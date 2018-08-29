Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C592C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5029220652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5029220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeH3AZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:25:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:34215 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeH3AZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:25:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 13:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,304,1531810800"; 
   d="scan'208";a="84464412"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2018 13:13:10 -0700
Date:   Wed, 29 Aug 2018 13:13:10 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Message-ID: <20180829201309.GA7142@linux.intel.com>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-2-namit@vmware.com>
 <20180829175936.fb27b3bf13da819a9a971f07@kernel.org>
 <1F547CEE-B5D9-42A0-8093-2C5555BACE26@vmware.com>
 <2694AE6F-2212-46C6-A570-6BAF265364FB@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2694AE6F-2212-46C6-A570-6BAF265364FB@vmware.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 07:36:22PM +0000, Nadav Amit wrote:
> at 10:11 AM, Nadav Amit <namit@vmware.com> wrote:
> 
> > at 1:59 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> >> On Wed, 29 Aug 2018 01:11:42 -0700
> >> Nadav Amit <namit@vmware.com> wrote:
> >> 
> >>> Use lockdep to ensure that text_mutex is taken when text_poke() is
> >>> called.
> >>> 
> >>> Actually it is not always taken, specifically when it is called by kgdb,
> >>> so take the lock in these cases.
> >> 
> >> Can we really take a mutex in kgdb context?
> >> 
> >> kgdb_arch_remove_breakpoint
> >> <- dbg_deactivate_sw_breakpoints
> >>   <- kgdb_reenter_check
> >>      <- kgdb_handle_exception
> >>         <- __kgdb_notify
> >>           <- kgdb_ll_trap
> >>             <- do_int3
> >>           <- kgdb_notify
> >>             <- die notifier
> >> 
> >> kgdb_arch_set_breakpoint
> >> <- dbg_activate_sw_breakpoints
> >>   <- kgdb_reenter_check
> >>      <- kgdb_handle_exception
> >>          ...
> >> 
> >> Both seems called in exception context, so we can not take a mutex lock.
> >> I think kgdb needs a special path.
> > 
> > You are correct, but I don’t want a special path. Presumably text_mutex is
> > guaranteed not to be taken according to the code.
> > 
> > So I guess the only concern is lockdep. Do you see any problem if I change
> > mutex_lock() into mutex_trylock()? It should always succeed, and I can add a
> > warning and a failure path if it fails for some reason.
> 
> Err.. This will not work. I think I will drop this patch, since I cannot
> find a proper yet simple assertion. Creating special path just for the
> assertion seems wrong.

It's probably worth expanding the comment for text_poke() to call out
the kgdb case and reference kgdb_arch_{set,remove}_breakpoint(), whose
code and comments make it explicitly clear why its safe for them to
call text_poke() without acquiring the lock.  Might prevent someone
from going down this path again in the future.
