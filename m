Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5CA21C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1798A2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1798A2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934333AbeFLAUQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:20:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:33758 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933891AbeFLAUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:20:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 17:20:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,212,1526367600"; 
   d="scan'208";a="63747700"
Received: from tstruk-mobl1.jf.intel.com ([10.7.196.162])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2018 17:20:14 -0700
Subject: [PATCH v2 0/2] tpm: add support for nonblocking operation
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        tadeusz.struk@intel.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Jun 2018 17:20:14 -0700
Message-ID: <152876281395.19591.3681365717212126222.stgit@tstruk-mobl1.jf.intel.com>
In-Reply-To: <20180601171731.GF1408@ziepe.ca>
References: <20180601171731.GF1408@ziepe.ca>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCG SAPI specification [1] defines a set of functions, which allows
applications to use the TPM device in either blocking or non-blocking fashion.
Each command defined by the specification has a corresponding
Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
mode of operation. Currently the TPM driver supports only blocking calls,
which doesn't allow asynchronous IO operations.
This patch changes it and adds support for nonblocking write and a new poll
function to enable applications, which want to take advantage of this feature.
The new functionality can be tested using standard TPM tools implemented
in [2], together with modified TCTI from [3].

[1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_SAPI_Version-1.1_Revision-22_review_030918.pdf
[2] https://github.com/tpm2-software/tpm2-tools
[3] https://github.com/tstruk/tpm2-tss/tree/async

---
Changes in v2:
- Split the change into two separate patches. First patch adds a pointer
  to the space to the struct file_priv to have access to it from the async job.
  This is to avoid memory allocations on every write call. Now everything
  what's needed is in the file_priv struct.
- Renamed the 'work' member of the timer to avoid confusion.
  Now there are 'timeout_work' and 'async_work'.
- Removed the global wait queue and moved it to file_priv.
- Only creating the work queue when the first file is opened.

Tadeusz Struk (2):
      tpm: add ptr to the tpm_space struct to file_priv
      tpm: add support for nonblocking operation

 drivers/char/tpm/tpm-dev-common.c |  152 ++++++++++++++++++++++++++++---------
 drivers/char/tpm/tpm-dev.c        |   22 +++--
 drivers/char/tpm/tpm-dev.h        |   19 +++--
 drivers/char/tpm/tpmrm-dev.c      |   31 ++++----
 4 files changed, 152 insertions(+), 72 deletions(-)

--
TS
