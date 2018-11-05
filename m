Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A32ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBD520827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBD520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeKELDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:03:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:6517 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeKELDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:03:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 17:46:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="88557462"
Received: from unknown (HELO localhost) ([10.249.254.144])
  by orsmga006.jf.intel.com with ESMTP; 04 Nov 2018 17:45:59 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 00/16] Remove nested TPM operations
Date:   Mon,  5 Nov 2018 03:45:33 +0200
Message-Id: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[was Detach TPM space code out of the tpm_transmit() flow but the scope
 expanded a bit.]

Make the changes necessary to detach TPM space code and TPM activation
code out of the tpm_transmit() flow because of both of these can cause
nested tpm_transmit() calls. The nesteds calls make the whole flow hard
to maintain, and thus, it is better to just fix things now before this
turns into a bigger mess.

The commits are available in a branch called 'nested' in

git://git.infradead.org/users/jjs/linux-tpmdd.git

v3:
* Encapsulate power gating code to tpm_chip_start() and tpm_chip_stop().
* Move TPM power gating code and locking to tpm_try_get_ops() and
  tpm_put_ops().
* Call power gating code directly in tpm_chip_register() and
  tpm2_del_space().

v2:
* Print tpm2_commit_space() error inside tpm2_commit_space()
* Error code was not printed when recv() callback failed. It is
  fixed in this version.
* Added a patch that removes @space from tpm_transmit().
* Fixed a regression in earlier series. Forgot to amend the change
  from the staging area that renames NESTED to UNLOCKED in tpm2-space.c.

Jarkko Sakkinen (16):
  tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
  tpm: fix invalid return value in pubek_show()
  tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
  tpm: call tpm2_flush_space() on error in tpm_try_transmit()
  tpm: print tpm2_commit_space() error inside tpm2_commit_space()
  tpm: clean up tpm_try_transmit() error handling flow
  tpm: access command header through struct in  tpm_try_transmit()
  tpm: move tpm_validate_commmand() to tpm2-space.c
  tpm: encapsulate tpm_dev_transmit()
  tpm: move TPM space code out of tpm_transmit()
  tpm: remove @space from tpm_transmit()
  tpm: use tpm_try_get_ops() in tpm-sysfs.c.
  tpm: remove TPM_TRANSMIT_UNLOCKED flag
  tpm: introduce tpm_chip_start() and tpm_chip_stop()
  tpm: take TPM chip power gating out of tpm_transmit()
  tpm: remove @flags from tpm_transmit()

 drivers/char/tpm/tpm-chip.c       | 105 +++++++++++-
 drivers/char/tpm/tpm-dev-common.c |  45 ++++-
 drivers/char/tpm/tpm-interface.c  | 262 ++++++------------------------
 drivers/char/tpm/tpm-sysfs.c      | 141 +++++++++-------
 drivers/char/tpm/tpm.h            |  37 ++---
 drivers/char/tpm/tpm1-cmd.c       |  28 +---
 drivers/char/tpm/tpm2-cmd.c       |  68 +++-----
 drivers/char/tpm/tpm2-space.c     |  87 +++++++---
 drivers/char/tpm/tpm_vtpm_proxy.c |   4 +-
 9 files changed, 382 insertions(+), 395 deletions(-)

-- 
2.19.1

