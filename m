Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645FFC282DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCD521924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfBHSJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:09:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:54965 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbfBHSJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:09:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 10:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="116299433"
Received: from shivamur-mobl1.gar.corp.intel.com (HELO localhost) ([10.249.254.162])
  by orsmga008.jf.intel.com with ESMTP; 08 Feb 2019 10:09:00 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v4 0/2] tpm: Unify send() callbacks
Date:   Fri,  8 Feb 2019 20:08:55 +0200
Message-Id: <20190208180857.12330-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.co m>

A portion of send() callbacks have returned length, in many cases just
returning back what was given as an argument, and tpm_crb has returned 0 on
success. This patch set fixes and unifies the behaviour.

v4:
* Return zero already in tpm_tis_send_main() so that it is applied to all
  call sites of tpm_tis_send().
* Fixup tpm_ibmvtpm_send() documentation.
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
 drivers/char/tpm/tpm_ibmvtpm.c       |  8 ++++----
 drivers/char/tpm/tpm_infineon.c      |  2 +-
 drivers/char/tpm/tpm_nsc.c           |  2 +-
 drivers/char/tpm/tpm_tis_core.c      |  2 +-
 drivers/char/tpm/tpm_vtpm_proxy.c    |  3 +--
 drivers/char/tpm/xen-tpmfront.c      |  2 +-
 11 files changed, 22 insertions(+), 15 deletions(-)

-- 
2.19.1

