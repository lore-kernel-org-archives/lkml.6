Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeEGQHu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 12:07:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752751AbeEGQHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 12:07:48 -0400
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v3 0/2] tpm: improving granularity in poll sleep times 
Date: Mon,  7 May 2018 12:07:31 -0400
X-Mailer: git-send-email 2.13.3
X-TM-AS-GCONF: 00
x-cbid: 18050716-0040-0000-0000-000004560695
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050716-0041-0000-0000-000020FA4245
Message-Id: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing TPM polling code sleeps in each loop iteration for time in
msecs ranging from 1 msecs to 5 msecs. However, many of the TPM commands
complete much faster, resulting in unnecessary delays.

This set of patches identifies such iterations and optimizes the sleep
time. The first patch replaces TPM_POLL_SLEEP with TPM_TIMEOUT_POLL and
moves it from tpm_tis_core.c to tpm.h as an enum with value 1 msecs. The
second patch further reduces the TPM poll sleep time in get_burstcount()
and wait_for_tpm_stat() in tpm_tis_core.c by calling usleep_range()
directly.

The change is only in the polling time, and the maximum timeout is still
maintained the same. Thus, it should not affect the overall existing
behavior.

Changelog:

v3:
 
tpm: reduce poll sleep time in tpm_transmit()
* added testing platform information
* updated patch description for more clarity on reasoning

tpm: reduce polling time to usecs for even finer granularity
* added testing platform information
* added Jarkko's and Mimi's Reviewed-by
 
v2:

tpm: reduce poll sleep time in tpm_transmit()
* merged previously defined two patches into this. 
* updated patch description as per Jarkko's feedback

tpm: reduce polling time to usecs for even finer granularity
* directly use usleep_range with finer granularity less than 1msec

Nayna Jain (2):
  tpm: reduce poll sleep time in tpm_transmit()
  tpm: reduce polling time to usecs for even finer granularity

 drivers/char/tpm/tpm-interface.c |  2 +-
 drivers/char/tpm/tpm.h           |  5 ++++-
 drivers/char/tpm/tpm_tis_core.c  | 11 +++--------
 3 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.13.3
