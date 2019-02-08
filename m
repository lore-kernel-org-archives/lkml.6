Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E405C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EF920823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfBHQbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:31:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:18996 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfBHQbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:31:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 08:31:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="273543195"
Received: from shivamur-mobl1.gar.corp.intel.com (HELO localhost) ([10.249.254.162])
  by orsmga004.jf.intel.com with ESMTP; 08 Feb 2019 08:31:01 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v3 0/2] tpm: Unify send() callbacks
Date:   Fri,  8 Feb 2019 18:30:57 +0200
Message-Id: <20190208163059.640-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A portion of send() callbacks have returned length, in many cases just
returning back what was given as an argument, and tpm_crb has returned 0 on
success. This patch set fixes and unifies the behaviour.

v3:
tpm_tis_core fix was left out of the staging area :-(
v2:
The drivers tpm_nsc and tpm_infineon were forgotten. For this version I
checked both with find and command and from Kconfig that everything that is
supposed to be a driver directly interfacing with the TPM core, is included
(e.g. discluding tpm_tis_spi).


Jarkko Sakkinen (2):
  tpm: Unify the send callback behaviour
  tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete

 drivers/char/tpm/st33zp24/st33zp24.c |  2 +-
 drivers/char/tpm/tpm_atmel.c         |  2 +-
 drivers/char/tpm/tpm_i2c_atmel.c     | 10 +++++++++-
 drivers/char/tpm/tpm_i2c_infineon.c  |  2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  2 +-
 drivers/char/tpm/tpm_ibmvtpm.c       |  2 +-
 drivers/char/tpm/tpm_infineon.c      |  2 +-
 drivers/char/tpm/tpm_nsc.c           |  2 +-
 drivers/char/tpm/tpm_tis_core.c      |  6 +++++-
 drivers/char/tpm/tpm_vtpm_proxy.c    |  3 +--
 drivers/char/tpm/xen-tpmfront.c      |  2 +-
 11 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.19.1

