Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A840C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520C5218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfBFQ10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:27:26 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32877 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbfBFQ10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:27:26 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C2A121D2663FAD87ACF5;
        Wed,  6 Feb 2019 16:27:24 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.33) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 6 Feb 2019 16:27:16 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>,
        <matthewgarrett@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v10, RESEND 0/6] tpm: retrieve digest size of unknown algorithms from TPM
Date:   Wed, 6 Feb 2019 17:24:46 +0100
Message-ID: <20190206162452.7749-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending after applying the patch set on top of linux-tpmdd/nested
(b91bfb7cc947) and some minor fixes.

Update

This version of the patch set includes three additional patches (4-6/6)
that allow users of the TPM driver to provide a digest for each PCR bank to
tpm_pcr_extend(). The new patches have been included to facilitate the
review of all the changes to support TPM 2.0 crypto agility for reading and
extending PCRs.


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

v9:
- add comment for ima_load_kexec_buffer() in ima_init()
- move 'digests' and ima_init_digests() to ima_queue.c
- remove comment for TPM_RETRY

v8:
- set digest array length in tpm_digest to new constant TPM_MAX_DIGEST_SIZE
- replace enum tpm_const with #define
- rename labels in init_trusted()
- allocate tpm_digest array after retrieving random data in init_digests()

v7:
- use memchr_inv() in tpm2_get_pcr_allocation()
- add patch to move tpm_chip to include/linux/tpm.h
- add patch to set the tpm_chip argument in trusted.c to a pointer from
  tpm_default_chip()
- remove definition of tpm_extend_digest
- remove code in tpm2_pcr_extend() to extend unused PCR banks with the
  first digest passed by the caller of tpm_pcr_extend()
- remove count parameter from tpm_pcr_extend() and tpm2_pcr_extend()
- remove padding of SHA1 digest in tpm_pcr_extend()
- pre-allocate and initialize array of tpm_digest structures in
  security/keys/trusted.c and security/integrity/ima/ima_init.c 

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


Roberto Sassu (6):
  tpm: dynamically allocate the allocated_banks array
  tpm: rename and export tpm2_digest and tpm2_algorithms
  tpm: retrieve digest size of unknown algorithms with PCR read
  tpm: move tpm_chip definition to include/linux/tpm.h
  KEYS: trusted: explicitly use tpm_chip structure from
    tpm_default_chip()
  tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()

 drivers/char/tpm/tpm-chip.c         |   1 +
 drivers/char/tpm/tpm-interface.c    |  38 ++++----
 drivers/char/tpm/tpm.h              | 118 ++---------------------
 drivers/char/tpm/tpm1-cmd.c         |  12 +++
 drivers/char/tpm/tpm2-cmd.c         | 140 +++++++++++++++++++---------
 include/linux/tpm.h                 | 127 ++++++++++++++++++++++++-
 include/linux/tpm_eventlog.h        |   9 +-
 security/integrity/ima/ima.h        |   1 +
 security/integrity/ima/ima_crypto.c |  10 +-
 security/integrity/ima/ima_init.c   |   4 +
 security/integrity/ima/ima_queue.c  |  27 +++++-
 security/keys/trusted.c             |  73 +++++++++++----
 12 files changed, 350 insertions(+), 210 deletions(-)

-- 
2.17.1

