Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA1BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540AE218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfBGEXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:23:15 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:49128 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbfBGEXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:23:15 -0500
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x174L80M024031;
        Thu, 7 Feb 2019 04:22:57 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qg8h81q0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Feb 2019 04:22:57 +0000
Received: from sarge.linuxathome.me (unknown [16.99.168.108])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 1653B83;
        Thu,  7 Feb 2019 04:22:53 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        x86@kernel.org, Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, stable@vger.kernel.org
Subject: [Patch v2 0/4] Protect against concurrent calls into UV BIOS
Date:   Thu,  7 Feb 2019 04:22:30 +0000
Message-Id: <20190207042234.25109-1-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=989 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:

Addressed comments from Bhupesh Sharma, Thomas Gleixner, and Ard Biesheuvel:

 * made __uv_bios_call() static
 * moved the efi_enabled() cleanup to its own patchlet
 * explained the reason for renaming the efi_runtime_lock semaphore
 * dropped the reviewed-bys as they should be given on the mailing list
 * Cc'ng stable@vger.kernel.org given the nature of the problem addressed by the patches


---

Calls into UV BIOS were not being serialised which is wrong as it violates EFI
runtime rules, and bad as it does result in all sorts of potentially hard to
track down hangs and panics when efi_scratch.prev_mm gets clobbered whenever
efi_switch_mm() gets called concurrently from two different CPUs.

Patch #1 makes the efi_runtime_lock semaphore visible to EFI runtime callers
defined outside drivers/firmware/efi/runtime-wrappers.c in preparation for
using it to serialise calls into UV BIOS; the lock is also renamed to
efi_runtime_sem so that it can coexist with the efi_runtime_lock spinlock
defined in arch/x86/platform/efi/efi_64.c when CONFIG_EFI_MIXED is enabled.

Patch #2 removes uv_bios_call_reentrant() because it's dead code.

Patch #3 is a cleanup that drops test_bit() in favour of the ad hoc efi_enabled().

Patch #4 makes uv_bios_call() variants use efi_runtime_sem to protect against
concurrency.

Cc: Russ Anderson <rja@hpe.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: stable@vger.kernel.org

Hedi Berriche (4):
  efi/x86: turn EFI runtime semaphore into a global lock
  x86/platform/UV: kill uv_bios_call_reentrant() as it has no callers
  x86/platform/UV: use efi_enabled() instead of test_bit()
  x86/platform/UV: use efi_runtime_sem to serialise BIOS calls

 arch/x86/include/asm/uv/bios.h          |  4 +-
 arch/x86/platform/uv/bios_uv.c          | 33 ++++++++------
 drivers/firmware/efi/runtime-wrappers.c | 60 ++++++++++++-------------
 include/linux/efi.h                     |  3 ++
 4 files changed, 55 insertions(+), 45 deletions(-)

-- 
2.20.1

