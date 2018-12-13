Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E91C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618BC20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618BC20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeLMKcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:32:43 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728499AbeLMKcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:32:43 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id AFF53D9B1D27C;
        Thu, 13 Dec 2018 10:32:35 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.48) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 13 Dec 2018 10:32:28 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v7 0/5] tpm: retrieve digest size of unknown algorithms from TPM
Date:   Thu, 13 Dec 2018 11:29:40 +0100
Message-ID: <20181213102945.30946-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update

This version of the patch set includes an additional patch (7/7) which
modifies the definition of tpm_pcr_extend() and tpm2_pcr_extend(). The new
patch has been included to facilitate the review of the changes to support
TPM 2.0 crypto agility for reading/extending PCRs.


Original patch set description

The TPM driver currently relies on the crypto subsystem to determine the
digest size of supported TPM algorithms. In the future, TPM vendors might
implement new algorithms in their chips, and those algorithms might not
be supported by the crypto subsystem.

Usually, vendors provide patches for the new hardware, and likely
the crypto subsystem will be updated before the new algorithm is
introduced. However, old kernels might be updated later, after patches
are included in the mainline kernel. This would leave the opportunity
for attackers to misuse PCRs, as PCR banks with an unknown algorithm
are not extended.

This patch set provides a long term solution for this issue. If a TPM
algorithm is not known by the crypto subsystem, the TPM driver retrieves
the digest size from the TPM with a PCR read. All the PCR banks are
extended, even if the algorithm is not yet supported by the crypto
subsystem.

PCR bank information (TPM algorithm ID, digest size, crypto subsystem ID)
is stored in the tpm_chip structure and available for users of the TPM
driver.

Changelog

v6:
- squash patches 4-6
- rename tpm_bank_list to tpm_extend_digest, extend_size and extend_data
  members to size and data
- add comment in tpm2_init_bank_info()

v5:
- rename digest_struct variable to digest
- add _head suffix to tcg_efi_specid_event and tcg_pcr_event2
- rename digest_size member of tpm_bank_list to extend_size
- change type of alg_id member of tpm_bank_list from u8 to u16
- add missing semi-colon in pcrlock()

v4:
- rename active_banks to allocated_banks
- replace kmalloc_array() with kcalloc()
- increment nr_allocated_banks if at least one PCR in the bank is selected
- pass multiple digests to tpm_pcr_extend()

v3:
- remove end marker change
- replace active_banks static array with pointer to dynamic array
- remove TPM2_ACTIVE_PCR_BANKS

v2:
- change the end marker of the active_banks array
- check digest size from output of PCR read command
- remove count parameter from tpm_pcr_read() and tpm2_pcr_read()

v1:
- modify definition of tpm_pcr_read()
- move hash algorithms and definition of tpm2_digest to include/linux/tpm.h

Roberto Sassu (5):
  tpm: dynamically allocate the allocated_banks array
  tpm: add _head suffix to tcg_efi_specid_event and tcg_pcr_event2
  tpm: rename and export tpm2_digest and tpm2_algorithms
  tpm: retrieve digest size of unknown algorithms with PCR read
  tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()

 drivers/char/tpm/eventlog/tpm2.c    |  12 +--
 drivers/char/tpm/tpm-chip.c         |   1 +
 drivers/char/tpm/tpm-interface.c    |  36 +++----
 drivers/char/tpm/tpm.h              |  22 ++--
 drivers/char/tpm/tpm1-cmd.c         |  25 ++++-
 drivers/char/tpm/tpm2-cmd.c         | 157 +++++++++++++++++++++-------
 include/linux/tpm.h                 |  43 +++++++-
 include/linux/tpm_eventlog.h        |  19 +---
 security/integrity/ima/ima_crypto.c |  10 +-
 security/integrity/ima/ima_queue.c  |   5 +-
 security/keys/trusted.c             |   5 +-
 11 files changed, 223 insertions(+), 112 deletions(-)

-- 
2.17.1

