Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35919C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5238216E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5238216E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbeHNUyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:54:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728811AbeHNUyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:54:19 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7EI48CI065998
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:05:59 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kv1depvrx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:05:59 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <davidj@linux.ibm.com>;
        Tue, 14 Aug 2018 12:05:58 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 12:05:55 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7EI5tEg5505420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 11:05:55 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF6B7C605F;
        Tue, 14 Aug 2018 12:05:54 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 700A0C6057;
        Tue, 14 Aug 2018 12:05:54 -0600 (MDT)
Received: from dev.watson.ibm.com (unknown [9.31.111.83])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 12:05:54 -0600 (MDT)
From:   David Jacobson <davidj@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     David Jacobson <david@davidej.com>, Petr Vorel <pvorel@suze.cz>,
        David Jacobson <davidj@linux.ibm.com>
Subject: [PATCH 2/7] evmtest: test appraisal on policy loading with signature
Date:   Tue, 14 Aug 2018 14:05:46 -0400
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180814180551.28311-1-davidj@linux.ibm.com>
References: <20180814180551.28311-1-davidj@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081418-8235-0000-0000-00000DE9E511
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009544; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073490; UDB=6.00553126; IPR=6.00853448;
 MB=3.00022715; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-14 18:05:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081418-8236-0000-0000-00004245CEF7
Message-Id: <20180814180551.28311-2-davidj@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808140185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMA can be configured to require signatures on policies before loading
them. This test verifies that IMA correctly validates signatures, and
rejects policies that lack signatures or have been signed by an
unauthorized party (i.e. certificate is not on the appropriate keyring).

This test requires root privileges in order to write to securityfs
files.

Signed-off-by: David Jacobson <davidj@linux.ibm.com>
---
 evmtest/Makefile.am                          |  4 +-
 evmtest/files/Notes                          | 25 ++++++
 evmtest/files/bad_privkey_ima.pem            | 16 ++++
 evmtest/files/policies/signed_policy         |  2 +
 evmtest/files/policies/unknown_signed_policy |  1 +
 evmtest/files/policies/unsigned_policy       |  1 +
 evmtest/functions/r_policy_sig.sh            | 93 ++++++++++++++++++++
 7 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 evmtest/files/Notes
 create mode 100644 evmtest/files/bad_privkey_ima.pem
 create mode 100644 evmtest/files/policies/signed_policy
 create mode 100644 evmtest/files/policies/unknown_signed_policy
 create mode 100644 evmtest/files/policies/unsigned_policy
 create mode 100755 evmtest/functions/r_policy_sig.sh

diff --git a/evmtest/Makefile.am b/evmtest/Makefile.am
index 388ead1..b537e78 100644
--- a/evmtest/Makefile.am
+++ b/evmtest/Makefile.am
@@ -14,9 +14,11 @@ evmtest.1:
 install:
 	install -m 755 evmtest $(bindir)
 	install -d $(datarootdir)/evmtest/files/
+	install -d $(datarootdir)/evmtest/files/policies
 	install -d $(datarootdir)/evmtest/functions/
-	install -D $$(find ./files/ -not -type d)  $(datarootdir)/evmtest/files/
+	install -D $$(find ./files/ -not -type d -not -path "./files/policies/*")  $(datarootdir)/evmtest/files/
 	install -D ./functions/* $(datarootdir)/evmtest/functions/
+	install -D ./files/policies/* $(datarootdir)/evmtest/files/policies/
 	cp evmtest.1 $(datarootdir)/man/man1
 	mandb -q
 
diff --git a/evmtest/files/Notes b/evmtest/files/Notes
new file mode 100644
index 0000000..6b75263
--- /dev/null
+++ b/evmtest/files/Notes
@@ -0,0 +1,25 @@
+This file contains a description of the contents of this directory.
+
+1. bad_privkey_ima.pem
+
+This file was generated such that its corresponding public key could be placed
+on the IMA Trusted Keyring, however, it has not. Therefore, any policy (or file)
+signed by this key cannot be verified, and is untrusted.
+
+2. basic_mod.ko
+
+This is a kernel module that logs (to dmesg) the syscall that was used to load
+it.
+
+3. common.sh
+
+This file contains useful functions and variables for evmtest scripts.
+
+4. load_policy.sh
+
+This is a script to load policies. The first time this is called, it will
+replace the existing policy. Subsequent calls will append the running policy.
+
+5. policies/
+
+This is a directory that contains IMA policies with self explanatory names.
diff --git a/evmtest/files/bad_privkey_ima.pem b/evmtest/files/bad_privkey_ima.pem
new file mode 100644
index 0000000..dcc0e24
--- /dev/null
+++ b/evmtest/files/bad_privkey_ima.pem
@@ -0,0 +1,16 @@
+-----BEGIN PRIVATE KEY-----
+MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMOnki6OKMHExpH1
+IWgUlPWWSbsDpW1lpqXMj0/ZWo9xU5W2xZC53TVArUGOImQ5PcMNkw1VcHhKbFKO
+jYT0gEE0Sv+VbePiEnhUheFOWUxNNFE3DVQaOpBN0OzsUCSGX9RKIIwkIAwJkvWA
+MHzR4ZPQGGM9hMJKhEvlTG4PP96LAgMBAAECgYBKVKVCrptpUhqmZNx2MCuPSbNl
+KzNz5kRzhM2FZmvzRvicTj2siBA0JQgteZQzQ1PlgIi3bhg2ev/ANYwqUMFQWZv9
+zm5d4P7Zsdyle15MDTSrQIaroeb1nbfNvaB0L4D4Inv0p6ksyIFp7TR5MLVenC5k
+bxfESVWVPDseiAFKUQJBAPQ/x3LmnT0RiMeX6quCGAON7DGpV5KFwL97luWO6vH+
+qZ2W1/J0UxTbruv7rA+tj3ZXpdNOxfmq+JStY0jrJV0CQQDNEUqomnA183rX0dv8
+MWyOPmX0Z9SMSTRvflNRW85Bzbosq68uLTq3qOBj+td9zUlopsLpJlfF0Vc+moff
+uq0HAkEAi/Sz47oTZXfTqZL6TBZ6jibXrck8PeBYhyBZYebX55ymMn/J88sGBFCx
+VdVbTYyFRSmKAqADv0FhuUf1OUZMnQJAOayjUsgcxw+zfP+I32UHIvppslOBc/Mi
+zDi7Niab2+YAdo/StSoDWaQld/kUok0aWFSOfQRLq1c1MmZD0KiwAQJANY0LopqG
+pxACc4/QawxtBoV1a8j5Zui8LZPRtKwjkA30Nq8fOufzMuBeJIlLap45uD1xC7St
+bsPWG5+uz18e5w==
+-----END PRIVATE KEY-----
diff --git a/evmtest/files/policies/signed_policy b/evmtest/files/policies/signed_policy
new file mode 100644
index 0000000..87828f0
--- /dev/null
+++ b/evmtest/files/policies/signed_policy
@@ -0,0 +1,2 @@
+measure func=POLICY_CHECK
+appraise func=POLICY_CHECK appraise_type=imasig
diff --git a/evmtest/files/policies/unknown_signed_policy b/evmtest/files/policies/unknown_signed_policy
new file mode 100644
index 0000000..1f8f8f4
--- /dev/null
+++ b/evmtest/files/policies/unknown_signed_policy
@@ -0,0 +1 @@
+audit func=POLICY_CHECK
diff --git a/evmtest/files/policies/unsigned_policy b/evmtest/files/policies/unsigned_policy
new file mode 100644
index 0000000..1f8f8f4
--- /dev/null
+++ b/evmtest/files/policies/unsigned_policy
@@ -0,0 +1 @@
+audit func=POLICY_CHECK
diff --git a/evmtest/functions/r_policy_sig.sh b/evmtest/functions/r_policy_sig.sh
new file mode 100755
index 0000000..7462c0a
--- /dev/null
+++ b/evmtest/functions/r_policy_sig.sh
@@ -0,0 +1,93 @@
+#!/bin/bash
+TEST="r_policy_sig"
+# Author: David Jacobson <davidj@linux.ibm.com>
+
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source $ROOT/files/common.sh
+
+VERBOSE=0
+POLICY_LOAD=$ROOT/files/load_policy.sh
+# This test validates that IMA measures and appraises policies.
+usage() {
+	echo ""
+	echo "policy_sig -k <key> [-vh]"
+	echo ""
+	echo "  This test must be run as root"
+	echo ""
+	echo "  This test verifies that IMA prevents the loading of unsigned"
+	echo "	policies"
+	echo ""
+	echo "  -k,--key    	The key for the certificate on the IMA keyring"
+	echo "  -h,--help       Display this help message"
+	echo "  -v,--verbose    Verbose logging"
+}
+
+TEMP=`getopt -o 'k:hv' -l 'key:,help,verbose' -n 'r_policy_sig' -- "$@"`
+eval set -- "$TEMP"
+
+while true ; do
+	case "$1" in
+	-h|--help) usage; exit 0; shift;;
+	-k|--key) IMA_KEY=$2; shift 2;;
+	-v|--verbose) VERBOSE=1; shift;;
+	--) shift; break;;
+	*) echo "[*] Unrecognized option $1"; exit 1 ;;
+	esac
+done
+
+if [[ -z $IMA_KEY ]]; then
+	usage
+	exit 1
+fi
+
+EVMTEST_require_root
+
+begin
+v_out "Attempting to read current policy..."
+cat $EVMTEST_SECFS/ima/policy &>> /dev/null # Don't need to output it
+
+if [[ $? != 0 ]]; then
+	fail "Could not read running policy - did you run env_validate?"
+fi
+v_out "Policy is readable"
+
+v_out "Signing policy with provided key..."
+evmctl ima_sign -f $ROOT/files/policies/signed_policy -k $IMA_KEY
+if [[ $? != 0 ]]; then
+	fail "Failed to sign policy - check key file"
+fi
+
+v_out "Loading policy..."
+$POLICY_LOAD signed_policy &>> /dev/null
+if [[ $? != 0 ]]; then
+	fail "Failed to write policy - did you run env_validate?"
+fi
+v_out "Loaded"
+
+v_out "Attempting to load unsigned policy..."
+$POLICY_LOAD unsigned_policy &>> /dev/null
+if [[ $? != 1 ]]; then
+	fail "Failed to reject unsigned policy"
+fi
+
+v_out "IMA Blocked unsigned policy"
+
+v_out "Signing policy with invalid key..."
+evmctl ima_sign -f $ROOT/files/policies/unknown_signed_policy \
+	-k $ROOT/files/bad_privkey_ima.pem &>> /dev/null
+v_out "Attempting to load policy signed by invalid key..."
+$POLICY_LOAD unknown_signed_policy &>> /dev/null
+
+if [[ $? != 1 ]]; then
+	fail "Failed to reject policy signed by unknown key"
+fi
+
+v_out "IMA blocked policy signed by unknown key"
+
+v_out "Removing security.ima attribute from policies..."
+setfattr -x security.ima $ROOT/files/policies/unsigned_policy &>> /dev/null
+setfattr -x security.ima $ROOT/files/policies/unknown_signed_policy \
+	&>> /dev/null
+v_out "Done"
+
+passed
-- 
2.17.1

