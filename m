Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EBFC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87EA2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87EA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeLLKRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:17:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:38638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbeLLKRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:17:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E570AE5F;
        Wed, 12 Dec 2018 10:17:34 +0000 (UTC)
Date:   Wed, 12 Dec 2018 11:17:33 +0100
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
Message-ID: <20181212101732.5kayilcr7ww5cyu5@pathway.suse.cz>
References: <27240C0AC20F114CBF8149A2696CBE4A6015A889@SHSMSX101.ccr.corp.intel.com>
 <20181210054622.GA6291@jagdpanzerIV>
 <27240C0AC20F114CBF8149A2696CBE4A6015A8D9@SHSMSX101.ccr.corp.intel.com>
 <20181210061151.GA28533@jagdpanzerIV>
 <f6e39c8f-2ca2-4a01-cf42-9ed3bc2462a8@i-love.sakura.ne.jp>
 <27240C0AC20F114CBF8149A2696CBE4A6015ABB6@SHSMSX101.ccr.corp.intel.com>
 <77864d48-ce55-a699-ee6e-60d9ec36e305@i-love.sakura.ne.jp>
 <27240C0AC20F114CBF8149A2696CBE4A6015B06E@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A6015B06E@SHSMSX101.ccr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-12-12 01:16:11, Liu, Chuansheng wrote:
> 
> 
> > -----Original Message-----
> > From: Tetsuo Handa [mailto:penguin-kernel@i-love.sakura.ne.jp]
> > Sent: Tuesday, December 11, 2018 6:02 PM
> > To: Liu, Chuansheng <chuansheng.liu@intel.com>; Sergey Senozhatsky
> > <sergey.senozhatsky.work@gmail.com>
> > Cc: akpm@linux-foundation.org; pmladek@suse.com;
> > sergey.senozhatsky@gmail.com; rostedt@goodmis.org; dvyukov@google.com;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] kernel/hung_task.c: force ignore_loglevel before panic
> > 
> > On 2018/12/11 10:16, Liu, Chuansheng wrote:
> > > We may enhance it by:
> > > -       if (sysctl_hung_task_warnings) {
> > > +       if (sysctl_hung_task_panic || sysctl_hung_task_warnings) {
> > >                 if (sysctl_hung_task_warnings > 0)
> > >                         sysctl_hung_task_warnings--;
> > 
> > Why ignore sysctl_hung_task_warnings? The administrator can already
> > configure as sysctl_hung_task_warnings == -1 && sysctl_hung_task_panic == 1
> > if he/she does not want to suppress neither sched_show_task() nor
> > debug_show_all_locks()/trigger_all_cpu_backtrace(). Someone might want that
> > sysctl_hung_task_warnings == 0 (which is a request to suppress only
> > sched_show_task()) should not be ignored by sysctl_hung_task_panic == 1
> > (which is a request to trigger panic).
> 
> 
> My complete idea is in patch V1 which has been sent. Paste here:
> If sysctl_hung_task_panic == 1, I will force sched_show_task(t) and set
> hung_task_call_panic = true
> hung_task_show_lock = true

Please, do not mix two changes into one patch.

Add console_verbose() in one patch. It is simple and
everyone has agreed with it so far.

Force sched_show_task() when hung_task_call_panic == 1 in
another patch. It seems to be controversial and should be
discussed/changed separately.

Best Regards,
Petr
