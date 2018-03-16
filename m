Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeCPRrU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:47:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752163AbeCPRrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:47:03 -0400
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH] tpm: TPM 2.0 selftest performance improvement
Date: Fri, 16 Mar 2018 23:15:28 +0530
X-Mailer: git-send-email 2.13.6
X-TM-AS-GCONF: 00
x-cbid: 18031617-0012-0000-0000-000005C00F93
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031617-0013-0000-0000-0000193C1F26
Message-Id: <20180316174528.21018-1-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160213
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For selftest being run in the background, the TCG 2.0 Specification
provides the command TPM2_GetTestResult to check the status of selftest
completion.

When the partial selftest command is sent just after TPM initialization,
it is observed that it returns RC_COMMAND_CODE error, which as per TPM 2.0
Specification, indicates "the response code that is returned if the TPM is
unmarshalling a value that it expects to be a TPM_CC and the input value is
not in the table." This doesn't indicate the exact status of selftest
command on TPM. But, it can be verified by sending the TPM2_GetTestResult.

This patch implements the TPM2_GetTestResult command and uses it to check
the selftest status, before sending the full selftest command after partial
selftest returns RC_COMMAND_CODE.

With this change, dmesg shows the TPM selftest completed at 1.243864
compared with the previous 1.939667 time.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Tested-by: Mimi Zohar <zohar@linux.vnet.ibm.com> (on Pi with TPM 2.0)
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/char/tpm/tpm.h      |  2 ++
 drivers/char/tpm/tpm2-cmd.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 82ae7b722161..d95eeb7c002a 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -107,6 +107,7 @@ enum tpm2_return_codes {
 	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
 	TPM2_RC_COMMAND_CODE    = 0x0143,
+	TPM2_RC_NEEDS_TEST      = 0x0153,
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
 };
@@ -135,6 +136,7 @@ enum tpm2_command_codes {
 	TPM2_CC_FLUSH_CONTEXT	= 0x0165,
 	TPM2_CC_GET_CAPABILITY	= 0x017A,
 	TPM2_CC_GET_RANDOM	= 0x017B,
+	TPM2_CC_GET_TEST_RESULT = 0x017C,
 	TPM2_CC_PCR_READ	= 0x017E,
 	TPM2_CC_PCR_EXTEND	= 0x0182,
 	TPM2_CC_LAST		= 0x018F,
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 89a5397b18d2..494f6dfbc65d 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -823,6 +823,50 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
 
 /**
+ * tpm2_get_selftest_result() - get the status of self tests
+ *
+ * @chip: TPM chip to use
+ *
+ * Return: If error return rc, else return the result of the self tests.
+ * TPM_RC_NEEDS_TESTING: No self tests are done. Needs testing.
+ * TPM_RC_TESTING: Self tests are in progress.
+ * TPM_RC_SUCCESS: Self tests completed successfully.
+ * TPM_RC_FAILURE: Self tests completed failure.
+ *
+ * This function can be used to check the status of self tests on the TPM.
+ */
+static int tpm2_get_selftest_result(struct tpm_chip *chip)
+{
+	struct tpm_buf buf;
+	int rc;
+	int test_result;
+	uint16_t data_size;
+	int len;
+	const struct tpm_output_header *header;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_TEST_RESULT);
+	if (rc)
+		return rc;
+
+	len = tpm_transmit(chip, NULL, buf.data, PAGE_SIZE, 0);
+	if (len <  0)
+		return len;
+
+	header = (struct tpm_output_header *)buf.data;
+
+	rc = be32_to_cpu(header->return_code);
+	if (rc)
+		return rc;
+
+	data_size = be16_to_cpup((__be16 *)&buf.data[TPM_HEADER_SIZE]);
+
+	test_result = be32_to_cpup((__be32 *)
+			(&buf.data[TPM_HEADER_SIZE + 2 + data_size]));
+
+	return test_result;
+}
+
+/**
  * tpm2_do_selftest() - ensure that all self tests have passed
  *
  * @chip: TPM chip to use
@@ -851,10 +895,25 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 				      "attempting the self test");
 		tpm_buf_destroy(&buf);
 
+		dev_dbg(&chip->dev, "tpm selftest command returned %04x\n", rc);
 		if (rc == TPM2_RC_TESTING)
 			rc = TPM2_RC_SUCCESS;
 		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
 			return rc;
+
+		if (rc == TPM2_RC_COMMAND_CODE) {
+
+			dev_info(&chip->dev, "Check TPM Test Results\n");
+			rc = tpm2_get_selftest_result(chip);
+
+			dev_info(&chip->dev, "tpm self test result is %04x\n",
+					rc);
+			if (rc == TPM2_RC_TESTING)
+				rc = TPM2_RC_SUCCESS;
+			if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS
+					|| TPM2_RC_FAILURE)
+				return rc;
+		}
 	}
 
 	return rc;
-- 
2.13.6
