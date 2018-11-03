Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49425ECDE46
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1049620843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1049620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeKDCUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:20:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:25467 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeKDCUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:20:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2018 10:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,460,1534834800"; 
   d="scan'208";a="271118484"
Received: from rysgaard-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.46])
  by orsmga005.jf.intel.com with ESMTP; 03 Nov 2018 10:08:08 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/8] Detach TPM space code out of the tpm_transmit() flow
Date:   Sat,  3 Nov 2018 19:07:57 +0200
Message-Id: <20181103170806.12177-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the changes that are needed to detach TPM space code from
tpm_transmit() flow so that we do no longer need nested tpm_transmit()
calls.

v2:
* Print tpm2_commit_space() error inside tpm2_commit_space()
* Error code was not printed when recv() callback failed. It is
  fixed in this version.
* Added a patch that removes @space from tpm_transmit().
* Fixed a regression in earlier series. Forgot to amend the change
  from the staging area that renames NESTED to UNLOCKED in tpm2-space.c.

Jarkko Sakkinen (8):
  tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
  tpm: print tpm2_commit_space() error inside tpm2_commit_space()
  tpm: clean up tpm_try_transmit() error handling flow
  tpm: access command header through struct in  tpm_try_transmit()
  tpm: move tpm_validate_commmand() to tpm2-space.c
  tpm: encapsulate tpm_dev_transmit()
  tpm: move TPM space code out of tpm_transmit()
  tpm: remove @space from tpm_transmit()

 drivers/char/tpm/tpm-dev-common.c |  50 ++++++-
 drivers/char/tpm/tpm-interface.c  | 240 +++++++++++-------------------
 drivers/char/tpm/tpm-sysfs.c      |   5 +-
 drivers/char/tpm/tpm.h            |  16 +-
 drivers/char/tpm/tpm1-cmd.c       |  28 +---
 drivers/char/tpm/tpm2-cmd.c       |  39 ++---
 drivers/char/tpm/tpm2-space.c     |  77 +++++++---
 drivers/char/tpm/tpm_vtpm_proxy.c |   3 +-
 8 files changed, 220 insertions(+), 238 deletions(-)

-- 
2.19.1

