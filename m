Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbeEANsw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:48:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754340AbeEANsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:48:47 -0400
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones <pjones@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/6] firmware: differentiate between signed regulatory.db and other firmware
Date: Tue,  1 May 2018 09:48:20 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050113-0040-0000-0000-00000434CD9E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050113-0041-0000-0000-00002638E687
Message-Id: <1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805010138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow LSMs and IMA to differentiate between signed regulatory.db and
other firmware.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Johannes Berg <johannes.berg@intel.com>
---
 drivers/base/firmware_loader/main.c | 5 +++++
 include/linux/fs.h                  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index eb34089e4299..d7cdf04a8681 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -318,6 +318,11 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
 			break;
 		}
 
+#ifdef CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
+		if ((strcmp(fw_priv->fw_name, "regulatory.db") == 0) ||
+		    (strcmp(fw_priv->fw_name, "regulatory.db.p7s") == 0))
+			id = READING_FIRMWARE_REGULATORY_DB;
+#endif
 		fw_priv->size = 0;
 		rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
 						msize, id);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dc16a73c3d38..d1153c2884b9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2811,6 +2811,7 @@ extern int do_pipe_flags(int *, int);
 	id(FIRMWARE, firmware)		\
 	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
 	id(FIRMWARE_FALLBACK, firmware)	\
+	id(FIRMWARE_REGULATORY_DB, firmware)	\
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
-- 
2.7.5
