Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062D820837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062D820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeHaNFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:05:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:22153 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbeHaNFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:05:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 01:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,309,1531810800"; 
   d="scan'208";a="253425645"
Received: from ssirohi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.112])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2018 01:58:27 -0700
Date:   Fri, 31 Aug 2018 11:58:25 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] tpm: add support for nonblocking operation
Message-ID: <20180831085825.GD12908@linux.intel.com>
References: <153419236870.8189.15489652816512817246.stgit@tstruk-mobl1.jf.intel.com>
 <20180831085711.GC12908@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831085711.GC12908@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just the change to the commit message. Mislooked patchwork, the typo was
in my response :-) I'll do recheck for 2/2. Check those comments before
v6 if there is anything else.

/Jarkko

On Fri, Aug 31, 2018 at 11:57:11AM +0300, Jarkko Sakkinen wrote:
> Are you planning to send v6 soon fixing the minor things in 1/2 (typo
> + change for the commit message)?
> 
> /Jarkko
> 
> On Mon, Aug 13, 2018 at 01:32:48PM -0700, Tadeusz Struk wrote:
> > The TCG SAPI specification [1] defines a set of functions, which allow
> > applications to use the TPM device in either blocking or non-blocking fashion.
> > Each command defined by the specification has a corresponding
> > Tss2_Sys_<COMMAND>_Prepare() and Tss2_Sys_<COMMAND>_Complete() call, which
> > together with Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
> > mode of operation. Currently the TPM driver supports only blocking calls,
> > which doesn't allow asynchronous IO operations.
> > This patch changes it and adds support for nonblocking write and a new poll
> > function to enable applications, which want to take advantage of this feature.
> > The new functionality can be tested using standard TPM tools implemented
> > in [2], together with modified TCTI from [3], and an example application
> > by Philip Tricca [4]. Here is a short description from Philip:
> > 
> > "The example application `glib-tss2-event` uses a glib main event loop
> > to create an RSA 2048 primary key in the TPM2 NULL hierarchy while
> > using a glib timer event to time the operation. A GSource object is
> > used to generate an event when the FD underlying the tss2 function
> > call has data ready. While the application waits for an event indicating
> > that the CreatePrimary operation is complete, it counts timer events
> > that occur every 100ms. Once the CreatePrimary operation completes the
> > number of timer events that occurred is used to make a rough calculation
> > of the elapsed time. This value is then printed to the console.
> > This takes ~300 lines of C code and requires no management or
> > synchronization of threads. The glib GMainContext is "just a poll()
> > loop" according to the glib documentation here:
> > 
> > https://developer.gnome.org/programming-guidelines/stable/main-contexts.html.en
> > 
> > and so supporting 'poll' is the easiest way to integrate with glib /
> > gtk+. This is true of any other event system that relies on 'poll'
> > instead of worker threads."
> > 
> > [1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_SAPI_Version-1.1_Revision-22_review_030918.pdf
> > [2] https://github.com/tpm2-software/tpm2-tools
> > [3] https://github.com/tstruk/tpm2-tss/tree/async
> > [4] https://github.com/flihp/glib-tss2-async-example
> > 
> > ---
> > Changes in v5:
> > - Changed the workqueue allocation time back from the first user interface
> >   open to module init.
> > 
> > Changes in v4:
> > - Changed the way buffer_mutex is handled in nonblocking mode so that
> >   it is not held when write() returns to user space.
> > 
> > Changes in v3:
> > - Fixed problem reported by 0-dey kbuild test robot around __exitcall.
> >   It complained because there is a module_exit() in another file already.
> > - Added info on example application from Philip
> > 
> > Changes in v2:
> > - Split the change into two separate patches. First patch adds a pointer
> >   to the space to the struct file_priv to have access to it from the async job.
> >   This is to avoid memory allocations on every write call. Now everything
> >   what's needed is in the file_priv struct.
> > - Renamed the 'work' member of the timer to avoid confusion.
> >   Now there are 'timeout_work' and 'async_work'.
> > - Removed the global wait queue and moved it to file_priv.
> > - Only creating the work queue when the first file is opened.
> > 
> > Tadeusz Struk (2):
> >       tpm: add ptr to the tpm_space struct to file_priv
> >       tpm: add support for nonblocking operation
> > 
> >  drivers/char/tpm/tpm-dev-common.c |  150 +++++++++++++++++++++++++++----------
> >  drivers/char/tpm/tpm-dev.c        |   22 +++--
> >  drivers/char/tpm/tpm-dev.h        |   19 +++--
> >  drivers/char/tpm/tpm-interface.c  |    1 
> >  drivers/char/tpm/tpm.h            |    1 
> >  drivers/char/tpm/tpmrm-dev.c      |   31 ++++----
> >  6 files changed, 152 insertions(+), 72 deletions(-)
> > 
> > --
> > TS
