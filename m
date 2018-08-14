Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D04C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFA0216E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFA0216E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbeHNUy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:54:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728692AbeHNUy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:54:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7EI48cs089477
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:06:06 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kv298vexu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:06:06 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <davidj@linux.ibm.com>;
        Tue, 14 Aug 2018 12:06:05 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 12:06:02 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7EI61BD18940108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 11:06:01 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27530C6055;
        Tue, 14 Aug 2018 12:06:01 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABF32C6057;
        Tue, 14 Aug 2018 12:06:00 -0600 (MDT)
Received: from dev.watson.ibm.com (unknown [9.31.111.83])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 12:06:00 -0600 (MDT)
From:   David Jacobson <davidj@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     David Jacobson <david@davidej.com>, Petr Vorel <pvorel@suze.cz>,
        David Jacobson <davidj@linux.ibm.com>
Subject: [PATCH 5/7] evmtest: validate boot record
Date:   Tue, 14 Aug 2018 14:05:49 -0400
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180814180551.28311-1-davidj@linux.ibm.com>
References: <20180814180551.28311-1-davidj@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081418-0036-0000-0000-00000A22B2A1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009544; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073490; UDB=6.00553126; IPR=6.00853448;
 MB=3.00022715; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-14 18:06:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081418-0037-0000-0000-00004894FA8B
Message-Id: <20180814180551.28311-5-davidj@linux.ibm.com>
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

The first record in the IMA runtime measurement list is the boot
aggregate - a hash of PCRs 0-7. This test calculates the boot aggregate
based off the PCRs and compares it to IMA's boot aggregate.

Dependencies: a TPM, IBMTSS2.

Signed-off-by: David Jacobson <davidj@linux.ibm.com>
---
 evmtest/functions/r_validate_boot_record.sh | 140 ++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100755 evmtest/functions/r_validate_boot_record.sh

diff --git a/evmtest/functions/r_validate_boot_record.sh b/evmtest/functions/r_validate_boot_record.sh
new file mode 100755
index 0000000..421cbf1
--- /dev/null
+++ b/evmtest/functions/r_validate_boot_record.sh
@@ -0,0 +1,140 @@
+#!/bin/bash
+# Author: David Jacobson <davidj@linux.ibm.com>
+TEST="r_validate_boot_record"
+
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source $ROOT/files/common.sh
+
+TPM_VERSION="2.0" # DEFAULT
+VERBOSE=0
+TSS_DIR=`locate ibmtpm20tss | head -1`
+EVENT_EXTEND=$TSS_DIR/utils12/eventextend
+LD_LIBRARY_PATH=$TSS_DIR/utils:$TSS_DIR/utils12
+MEASUREMENT_FILE=$EVMTEST_SECFS/tpm0/binary_bios_measurements
+# This test validates the eventlog against the hardware PCRs in the TPM, and
+# the boot aggregate against IMA.
+
+usage (){
+	echo "r_validate_boot_record [-hv]"
+	echo ""
+	echo "	This test must be run as root"
+	echo ""
+	echo "	This test will attempt to validate PCRs 0-7 in the TPM"
+	echo "	It will also validate the boot_aggregate based those PCRs"
+	echo "	against what IMA has recorded"
+	echo ""
+	echo "	-h,--help	Display this help message"
+	echo "	-v,--verbose	Verbose logging"
+}
+
+
+TEMP=`getopt -o 'hv' -l 'help,verbose' -n 'r_validate_boot_record' -- "$@"`
+eval set -- "$TEMP"
+
+while true ; do
+	case "$1" in
+	-h|--help) usage; exit; shift;;
+	-v|--verbose) VERBOSE=1; shift;;
+	--) shift; break;;
+	*) echo "[*] Unrecognized option $1"; exit 1 ;;
+	esac
+done
+
+EVMTEST_require_root
+
+echo "[*] Starting test: $TEST"
+
+v_out "Checking if securityfs is mounted..."
+if [[ -z $EVMTEST_SECFS_EXISTS ]]; then
+	fail "securityfs not found..."
+fi
+
+v_out "Verifying TPM is present..."
+if [[ ! -d $EVMTEST_SECFS/tpm0 ]]; then
+	fail "Could not locate TPM in $EVMTEST_SECFS"
+fi
+
+v_out "TPM found..."
+
+v_out "Checking if system supports reading event log..."
+
+if [[ ! -f $EVMTEST_SECFS/tpm0/binary_bios_measurements ]]; then
+		fail "Kernel does not support reading BIOS measurements,
+		please update to at least 4.16.0"
+fi
+
+
+
+v_out "Verifying TPM Version"
+if [[ -e /sys/class/tpm/tpm0/device/caps ]]; then
+	contains_12=`grep 'TCG version: 1.2' /sys/class/tpm/tpm0/device/caps`
+	if [[ -z $contains12 ]]; then
+		v_out "TPM 1.2"
+		TPM_VERSION="1.2"
+	fi
+else
+	v_out "TPM 2.0"
+fi
+
+v_out "Checking if system supports reading PCRs..."
+
+if [[ ! -d $TSS_DIR ]]; then
+	fail "Could not find TSS2, please install using the package and
+	 try again"
+fi
+
+v_out "Grabbing PCR values..."
+pcrs=() # array to store the Hardware PCR values
+sim_pcrs=() # What PCRs should be according to the event log
+halg=$(grep boot_aggregate $EVMTEST_SECFS/ima/ascii_runtime_measurements|\
+		sed -n 's/.*\(sha[^:]*\):.*/\1/p')
+
+for ((i=0; i<=7; i++)); do
+	if [[ $TPM_VERSION == "1.2" ]]; then
+		pcrs[i]=`TPM_INTERFACE_TYPE=dev $TSS_DIR/utils12/pcrread \
+			-ha $i -ns`
+	else
+		pcrs[i]=`TPM_INTERFACE_TYPE=dev $TSS_DIR/utils/pcrread \
+			-ha $i -halg $halg -ns`
+	fi
+done
+
+tss_out=`LD_LIBRARY_PATH=$LD_LIBRARY_PATH $EVENT_EXTEND -if \
+				$MEASUREMENT_FILE -sim -ns`
+for ((y=2; y<=9; y++)); do
+	# Parse TSS output - first strip away PCR, then split on :, then
+	# remove leading whitespace
+	x=`echo $tss_out | awk -v y=$y -F 'PCR' '{print $y}'`
+	x=`echo "$x" | awk -F ":" '{print $2}' | sed -e 's/^[ \t]*//'`
+	index=$((y-2))
+	sim_pcrs[$index]=$x
+done
+
+v_out "Validating PCRs.."
+for ((i=0; i<=7; i++)); do
+	v_out "SIM PCR [$i]: ${sim_pcrs[$i]}"
+	v_out "TPM PCR [$i]: ${pcrs[$i]}"
+	if [[  "${pcrs[$i]}" = "${sim_pcrs[$i]}" ]]; then
+		v_out "PCRs are incorrect..."
+		fail "Mismatch at PCR "$i" "
+	else
+		v_out "PCR $i validated..."
+	fi
+done
+
+
+v_out "Validating Boot Aggregate..."
+tss_boot_agg=`echo $tss_out | awk -F "boot aggregate:" '{print $2}'| tr -d " "`
+ima_boot_agg=`grep boot_aggregate \
+$EVMTEST_SECFS/ima/ascii_runtime_measurements|cut -d ":" -f2|cut -d " " -f1`
+v_out "TSS BOOT AGG: $tss_boot_agg"
+v_out "IMA BOOT AGG: $ima_boot_agg"
+
+if [ "$tss_boot_agg" != "$ima_boot_agg" ]; then
+	fail "Boot Aggregate is inconsistent"
+else
+	v_out "Boot Aggregate validated"
+fi
+
+echo "[*] TEST: PASSED"
+exit 0
-- 
2.17.1

