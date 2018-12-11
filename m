Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF457C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FBD2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FBD2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeLKOqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:46:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:48212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbeLKOqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:46:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E39DB041;
        Tue, 11 Dec 2018 14:46:05 +0000 (UTC)
Date:   Tue, 11 Dec 2018 15:46:03 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Liu, Chuansheng" <chuansheng.liu@intel.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
Message-ID: <20181211144603.xrxip27hfd5uljok@pathway.suse.cz>
References: <27240C0AC20F114CBF8149A2696CBE4A6015A889@SHSMSX101.ccr.corp.intel.com>
 <20181210054622.GA6291@jagdpanzerIV>
 <27240C0AC20F114CBF8149A2696CBE4A6015A8D9@SHSMSX101.ccr.corp.intel.com>
 <20181210061151.GA28533@jagdpanzerIV>
 <f6e39c8f-2ca2-4a01-cf42-9ed3bc2462a8@i-love.sakura.ne.jp>
 <27240C0AC20F114CBF8149A2696CBE4A6015ABB6@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A6015ABB6@SHSMSX101.ccr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-12-11 01:16:10, Liu, Chuansheng wrote:
> > From: Tetsuo Handa [mailto:penguin-kernel@i-love.sakura.ne.jp]
> > On 2018/12/10 15:11, Sergey Senozhatsky wrote:
> > > On (12/10/18 05:58), Liu, Chuansheng wrote:
> > >>> On (12/10/18 05:40), Liu, Chuansheng wrote:
> > >>>> @@ -130,6 +130,13 @@ static void check_hung_task(struct task_struct

> > -    if (!sysctl_hung_task_warnings && !sysctl_hung_task_panic)
> > -        return;
> > +    if (sysctl_hung_task_panic) {
> > +        console_verbose();
> > +        hung_task_show_lock = true;
> > +        hung_task_call_panic = true;
> > +    }
> > (...snipped...)
> > -    if (sysctl_hung_task_panic) {
> > -        hung_task_show_lock = true;
> > -        hung_task_call_panic = true;
> > -    }
> Thanks Tetsuo, I prefer this option, which makes code more readable.

I like this variant as well. Also using console_verbose() looks
like a better choice.


> More thoughts in this condition of sysctl_hung_task_warnings == 0 && sysctl_hung_task_panic == 1,
> in this case, debug_show_all_locks() may not output useful information if LOCK DEBUG config is not enabled.
> trigger_all_cpu_backtrace() will not show the hung task for debugging either.
> 
> We may enhance it by:
> -       if (sysctl_hung_task_warnings) {
> +       if (sysctl_hung_task_panic || sysctl_hung_task_warnings) {
>                 if (sysctl_hung_task_warnings > 0)
>                         sysctl_hung_task_warnings--;

I agree with Tetsuo that we should not touch this.

The warnings will get typically printed because panic() will get
triggered on the first occasion. And we should respect when the admin
disables the warnings completely.

Best Regards,
Petr
