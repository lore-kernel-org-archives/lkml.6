Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A235EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B8E2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B8E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeK1Ods (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:33:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:40182 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeK1Ods (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:33:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 19:33:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,289,1539673200"; 
   d="scan'208";a="116244365"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2018 19:33:42 -0800
Date:   Wed, 28 Nov 2018 11:41:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] panic: Add options to print system info when panic
 happens
Message-ID: <20181128034100.tuiw6dm2gdb6wxim@shbuild888>
References: <1543302920-13044-1-git-send-email-feng.tang@intel.com>
 <20181127132318.203460a2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127132318.203460a2@gandalf.local.home>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Tue, Nov 27, 2018 at 01:23:18PM -0500, Steven Rostedt wrote:
> On Tue, 27 Nov 2018 15:15:20 +0800
> Feng Tang <feng.tang@intel.com> wrote:
> 
> > Kernel panic issues are always painful to debug, partially
> > because it's not easy to get enough information of the
> > context when panic happens.
> > 
> > And we have ramoops and kdump for that, while this commit
> > tries to provide a easier way to show the system info by adding
> > a cmdline parameter, referring some idea from sysrq handler.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > ---
> > Changelog:
> >  v2:
> >     - change text "dump/DUMP" to "print/PRINT" which
> >       is more accurate, suggested by Andrew Morton 
> >     - add code to print ftrace buffer 
> > 
> >  Documentation/admin-guide/kernel-parameters.txt |  8 +++++++
> >  kernel/panic.c                                  | 28 +++++++++++++++++++++++++
> >  2 files changed, 36 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 19f4423..80c819a 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3081,6 +3081,14 @@
> >  			timeout < 0: reboot immediately
> >  			Format: <timeout>
> >  
> > +	panic_print=	Bitmask for printing system info when panic happens.
> > +			User can chose combination of the following bits:
> > +			bit 0: print all tasks info
> > +			bit 1: print system memory info
> > +			bit 2: print timer info
> > +			bit 3: print locks info if CONFIG_LOCKDEP is on
> 
> > +			bit 4: print ftrace buffer
> 
> Note, "ftrace_dump_on_oops" accomplishes the same thing.
> 
> Should this be a sysctl setting as well?

Thanks for the suggestion and note. I will add sysctl part in next version.

- Feng
