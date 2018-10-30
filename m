Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA55C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5402080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5402080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeJaAoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:44:17 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbeJaAoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:44:16 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id A24C8950F1832;
        Tue, 30 Oct 2018 15:50:12 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.44) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 30 Oct 2018 15:50:05 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 0/5] tpm: retrieve digest size of unknown algorithms from TPM
Date:   Tue, 30 Oct 2018 16:47:06 +0100
Message-ID: <20181030154711.2782-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

v2:
- change the end marker of the active_banks array
- check digest size from output of PCR read command
- remove count parameter from tpm_pcr_read() and tpm2_pcr_read()

v1:
- modify definition of tpm_pcr_read()
- move hash algorithms and definition of tpm2_digest to include/linux/tpm.h

Roberto Sassu (5):
  tpm: change the end marker of the active_banks array to zero
  tpm: rename and export tpm2_digest and tpm2_algorithms
  tpm: modify tpm_pcr_read() definition to pass a TPM hash algorithm
  tpm: retrieve digest size of unknown algorithms with PCR read
  tpm: ensure that output of PCR read contains the correct digest size

 drivers/char/tpm/tpm-interface.c    | 19 ++++--
 drivers/char/tpm/tpm.h              | 18 ++----
 drivers/char/tpm/tpm2-cmd.c         | 99 +++++++++++++++++++++--------
 include/linux/tpm.h                 | 30 ++++++++-
 include/linux/tpm_eventlog.h        |  9 +--
 security/integrity/ima/ima_crypto.c | 10 +--
 6 files changed, 122 insertions(+), 63 deletions(-)

-- 
2.17.1

