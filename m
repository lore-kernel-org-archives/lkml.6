Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF56AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6301221A5D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6301221A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbeHFXU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:20:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:21969 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbeHFXU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:20:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 14:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="222428188"
Received: from tstruk-mobl1.jf.intel.com ([10.7.196.170])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2018 14:09:18 -0700
Subject: [PATCH v3 RESEND 0/2] tpm: add support for nonblocking operation
From:   Tadeusz Struk <tadeusz.struk@intel.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tadeusz.struk@intel.com
Date:   Mon, 06 Aug 2018 14:09:18 -0700
Message-ID: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCG SAPI specification [1] defines a set of functions, which allow
applications to use the TPM device in either blocking or non-blocking fashion.
Each command defined by the specification has a corresponding
Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
mode of operation. Currently the TPM driver supports only blocking calls,
which doesn't allow asynchronous IO operations.
This patch changes it and adds support for nonblocking write and a new poll
function to enable applications, which want to take advantage of this feature.
The new functionality can be tested using standard TPM tools implemented
in [2], together with modified TCTI from [3], and an example application
by Philip Tricca [4]. Here is a short description from Philip:

"The example application `glib-tss2-event` uses a glib main event loop
to create an RSA 2048 primary key in the TPM2 NULL hierarchy while
using a glib timer event to time the operation. A GSource object is
used to generate an event when the FD underlying the tss2 function
call has data ready. While the application waits for an event indicating
that the CreatePrimary operation is complete, it counts timer events
that occur every 100ms. Once the CreatePrimary operation completes the
number of timer events that occurred is used to make a rough calculation
of the elapsed time. This value is then printed to the console.
This takes ~300 lines of C code and requires no management or
synchronization of threads. The glib GMainContext is "just a poll()
loop" according to the glib documentation here:

https://developer.gnome.org/programming-guidelines/stable/main-contexts.html.en

and so supporting 'poll' is the easiest way to integrate with glib /
gtk+. This is true of any other event system that relies on 'poll'
instead of worker threads."

[1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_SAPI_Version-1.1_Revision-22_review_030918.pdf
[2] https://github.com/tpm2-software/tpm2-tools
[3] https://github.com/tstruk/tpm2-tss/tree/async
[4] https://github.com/flihp/glib-tss2-async-example

---
Changes in v3:
- Fixed problem reported by 0-dey kbuild test robot around __exitcall.
  It complained because there is a module_exit() in another file already.
- Added info on example application from Philip

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

 drivers/char/tpm/tpm-dev-common.c |  150 +++++++++++++++++++++++++++----------
 drivers/char/tpm/tpm-dev.c        |   22 +++--
 drivers/char/tpm/tpm-dev.h        |   19 +++--
 drivers/char/tpm/tpm-interface.c  |    1 
 drivers/char/tpm/tpm.h            |    1 
 drivers/char/tpm/tpmrm-dev.c      |   31 ++++----
 6 files changed, 152 insertions(+), 72 deletions(-)

--
TS
