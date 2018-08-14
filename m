Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C1DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F674216E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F674216E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbeHNUyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:54:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728692AbeHNUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:54:22 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7EI48kZ013765
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:06:04 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kv3cshq86-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:06:03 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <davidj@linux.ibm.com>;
        Tue, 14 Aug 2018 12:06:03 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 12:06:00 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7EI5xuh4784484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 11:05:59 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22E9FC6055;
        Tue, 14 Aug 2018 12:05:59 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A442DC6057;
        Tue, 14 Aug 2018 12:05:58 -0600 (MDT)
Received: from dev.watson.ibm.com (unknown [9.31.111.83])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 12:05:58 -0600 (MDT)
From:   David Jacobson <davidj@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     David Jacobson <david@davidej.com>, Petr Vorel <pvorel@suze.cz>,
        David Jacobson <davidj@linux.ibm.com>
Subject: [PATCH 4/7] evmtest: test kexec signature policy
Date:   Tue, 14 Aug 2018 14:05:48 -0400
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180814180551.28311-1-davidj@linux.ibm.com>
References: <20180814180551.28311-1-davidj@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081418-0004-0000-0000-000014765432
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009544; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073490; UDB=6.00553126; IPR=6.00853448;
 MB=3.00022715; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-14 18:06:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081418-0005-0000-0000-000088752E76
Message-Id: <20180814180551.28311-4-davidj@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808140185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With secure boot enabled, the bootloader verifies the kernel image's
signature before transferring control to it. With Linux as the
bootloader running with secure boot enabled, kexec needs to verify the
kernel image's signature.

This patch defined a new test named "kexec_sig", which first attempts to
kexec an unsigned kernel image with an IMA policy that requires
signatures on any kernel image. Then, the test attempts to kexec the
signed kernel image, which should succeed.

Signed-off-by: David Jacobson <davidj@linux.ibm.com>
---
 evmtest/files/policies/kexec_policy |   3 +
 evmtest/functions/r_kexec_sig.sh    | 156 ++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)
 create mode 100644 evmtest/files/policies/kexec_policy
 create mode 100755 evmtest/functions/r_kexec_sig.sh

diff --git a/evmtest/files/policies/kexec_policy b/evmtest/files/policies/kexec_policy
new file mode 100644
index 0000000..dc00fa7
--- /dev/null
+++ b/evmtest/files/policies/kexec_policy
@@ -0,0 +1,3 @@
+appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig
+measure func=KEXEC_KERNEL_CHECK
+audit func=KEXEC_KERNEL_CHECK
diff --git a/evmtest/functions/r_kexec_sig.sh b/evmtest/functions/r_kexec_sig.sh
new file mode 100755
index 0000000..e1295b9
--- /dev/null
+++ b/evmtest/functions/r_kexec_sig.sh
@@ -0,0 +1,156 @@
+#!/bin/bash
+# Author: David Jacobson <davidj@linux.ibm.com>
+TEST="r_kexec_sig"
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source $ROOT/files/common.sh
+VERBOSE=0
+POLICY_LOAD=$ROOT/files/load_policy.sh
+
+# This test validates that IMA measures and appraises signatures on kernel
+# images when trying to kexec, if the current policy requires that.
+usage() {
+	echo ""
+	echo "kexec_sig -k <key> [-i <kernel_image]"
+	echo "	[-vh]"
+	echo ""
+	echo "	This test must be run as root"
+	echo "	Note: kexec may require PECOFF signature"
+	echo ""
+	echo "	This test will check that IMA prevents kexec-ing to "
+	echo "	unsigned kernel image."
+	echo ""
+	echo "	-k,--key	The key for the certificate on the IMA keyring"
+	echo "	-i,--image	An unsigned kernel image"
+	echo "	-h,--help	Display this help message"
+	echo "	-v,--verbose	Verbose logging"
+}
+
+TEMP=`getopt -o 'k:i:hv' -l 'key:,image:,help,verbose' -n 'r_kexec_sig' -- "$@"`
+eval set -- "$TEMP"
+
+while true ; do
+	case "$1" in
+	-h|--help) usage; exit 0 ; shift;;
+	-i|--image) KERNEL_IMAGE=$2; shift 2;;
+	-k|--key) IMA_KEY=$2; shift 2;;
+	-v|--verbose) VERBOSE=1; shift;;
+	--) shift; break;;
+	*) echo "[*] Unrecognized option $1"; exit 1;;
+	esac
+done
+
+if [[ -z $IMA_KEY ]]; then
+	usage
+	exit 1
+else
+	if [[ ! -e $IMA_KEY ]]; then
+		fail "Please provide valid keys"
+	fi
+fi
+
+# If the user doesn't provide a kernel image for kexec, get the current
+if [[ -z $KERNEL_IMAGE ]]; then
+	v_out "No kernel provided, looking for running kernel"
+	RUNNING_KERNEL=`uname -r`
+	if [[ -e /boot/vmlinuz-$RUNNING_KERNEL ]]; then
+		KERNEL_IMAGE=/boot/vmlinuz-$RUNNING_KERNEL
+		TEMP_LOCATION=`mktemp`
+		v_out "Found kernel in: $KERNEL_IMAGE"
+		v_out "Copying kernel to $TEMP_LOCATION"
+		cp $KERNEL_IMAGE $TEMP_LOCATION
+		KERNEL_IMAGE=$TEMP_LOCATION
+	fi
+else
+	# If a kernel has been provided, ensure it exists
+	if [[ ! -e $KERNEL_IMAGE ]]; then
+		fail "Kernel image not found..."
+	else
+		v_out "Valid Kernel provided, continuing"
+	fi
+fi
+
+EVMTEST_require_root
+
+begin
+
+v_out "Writing file hash on kernel image"
+evmctl ima_hash -a sha256 -f $KERNEL_IMAGE
+
+
+v_out "Attempting to sign policy..."
+evmctl ima_sign -f $ROOT/files/policies/kexec_policy -k $IMA_KEY
+
+v_out "Loading kexec policy..."
+$POLICY_LOAD kexec_policy &>> /dev/null
+
+if [[ $? != 0 ]]; then
+	fail "Could not update policy - verify keys"
+fi
+
+v_out "Testing kexec (using kexec_file_load) on unsigned image..."
+# -s uses the kexec_file_load syscall
+kexec -s -l $KERNEL_IMAGE &>> /dev/null
+loaded_unsigned=$?
+if [[ $loaded_unsigned != 0 ]]; then # Permission denied (IMA)
+	v_out "Correctly prevented kexec of an unsigned image"
+else
+	kexec -s -u
+	fail "kexec loaded instead of rejecting. Unloading and exiting."
+fi
+
+v_out "Testing kexec (using kexec_load) on unsigned image..."
+kexec -l $KERNEL_IMAGE &>> /dev/null
+if [[ $? == 0 ]]; then
+	kexec -u
+	fail "Kexec loaded unsigned image - unloading"
+else
+	v_out "Correctly prevented kexec of an unsigned image"
+fi
+
+# On some systems this prevents resigning the kernel image
+
+#v_out "Signing image with invalid key..."
+#evmctl ima_sign -f $KERNEL_IMAGE -k $ROOT/files/bad_privkey_ima.pem
+#kexec -s -l $KERNEL_IMAGE &>> /dev/null
+#loaded_bad_signature=$?
+
+#if [[ $loaded_bad_signature == 0 ]]; then
+#	kexec -u
+#	fail "Kernel image signed by invalid party was allowed to load.\
+#		Unloaded"
+#fi
+
+#v_out "Correctly prevented loading of kernel signed by unknown key"
+
+v_out "Signing kernel image with provided key..."
+evmctl ima_sign -f $KERNEL_IMAGE -k $IMA_KEY
+
+v_out "Attempting to kexec signed image using kexec_file_load..."
+kexec -s -l $KERNEL_IMAGE &>> /dev/null
+
+loaded_signed=$?
+if [[ $loaded_signed != 0 ]]; then
+	fail "kexec rejected a signed image - possibly due to PECOFF signature"
+else
+	v_out "kexec correctly loaded signed image...unloading"
+fi
+
+kexec -s -u
+
+v_out "Attempting kexec_load on signed kernel... [should fail]"
+kexec -l $KERNEL_IMAGE &>> /dev/null
+
+if [[ $? == 0 ]]; then
+	kexec -u
+	fail "Signed image was allowed to load without file descriptor for\
+		appraisal. Unloading."
+fi
+
+v_out "Correctly prevented loading"
+
+v_out "Cleaning up..."
+if [[ ! -z $TEMP_LOCATION ]]; then
+	rm $TEMP_LOCATION
+fi
+
+passed
-- 
2.17.1

