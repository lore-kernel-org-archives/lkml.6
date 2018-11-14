Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB00C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7194622360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7194622360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbeKOBhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:37:14 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727731AbeKOBhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:37:14 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id B9EE8C5A1AE9F;
        Wed, 14 Nov 2018 15:33:25 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.37) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 14 Nov 2018 15:33:22 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v5 0/7] tpm: retrieve digest size of unknown algorithms from TPM
Date:   Wed, 14 Nov 2018 16:31:01 +0100
Message-ID: <20181114153108.12907-1-roberto.sassu@huawei.com>
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

Roberto Sassu (7):
  tpm: dynamically allocate the allocated_banks array
  tpm: remove definition of TPM2_ACTIVE_PCR_BANKS
  tpm: rename and export tpm2_digest and tpm2_algorithms
  tpm: modify tpm_pcr_read() definition to pass a TPM hash algorithm
  tpm: retrieve digest size of unknown algorithms with PCR read
  tpm: ensure that the output of PCR read contains the correct digest
    size
  tpm: pass an array of tpm_bank_list structures to tpm_pcr_extend()

 drivers/char/tpm/tpm-chip.c         |   1 +
 drivers/char/tpm/tpm-interface.c    |  36 +++----
 drivers/char/tpm/tpm.h              |  23 ++---
 drivers/char/tpm/tpm1-cmd.c         |  26 ++++-
 drivers/char/tpm/tpm2-cmd.c         | 155 +++++++++++++++++++++-------
 include/linux/tpm.h                 |  43 +++++++-
 include/linux/tpm_eventlog.h        |  12 +--
 security/integrity/ima/ima_crypto.c |  10 +-
 security/integrity/ima/ima_queue.c  |   5 +-
 security/keys/trusted.c             |   5 +-
 10 files changed, 213 insertions(+), 103 deletions(-)

-- 
2.17.1

