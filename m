Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA469C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F79222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbfBMGuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:50:05 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:15466 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387415AbfBMGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:50:04 -0500
X-UUID: 621f949198ff4ac497ea4337c4f676c0-20190213
X-UUID: 621f949198ff4ac497ea4337c4f676c0-20190213
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1942036351; Wed, 13 Feb 2019 14:49:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Feb 2019 14:49:45 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Feb 2019 14:49:45 +0800
Message-ID: <1550040585.12645.9.camel@mtkswgap22>
Subject: Re: [PATCH 1/1] tracing: Fix event_trace_printk loss on
 printk_format.
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Andress Kuo <andress.kuo@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 13 Feb 2019 14:49:45 +0800
In-Reply-To: <1550033650.7648.2.camel@mtkswgap22>
References: <1549971717-4693-1-git-send-email-mars.cheng@mediatek.com>
         <20190212204113.5ecaa2a1@gandalf.local.home>
         <1550033650.7648.2.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve

On Wed, 2019-02-13 at 12:54 +0800, Mars Cheng wrote:
> Hi Steve
> 
> On Tue, 2019-02-12 at 20:41 -0500, Steven Rostedt wrote:
> > On Tue, 12 Feb 2019 19:41:57 +0800
> > Mars Cheng <mars.cheng@mediatek.com> wrote:
> > 
> > > From: Andress Kuo <andress.kuo@mediatek.com>
> > > 
> > > If fmt on event_trace_printk is not a constant, It means that something not
> > > guaranteed, so the compiler optimizes the fmt out, and then the
> > > __trace_printk_fmt section is not filled. if __trace_printk_fmt is not
> > > filled, the kernel will not allocate the special buffers needed for the
> > > event_trace_printk() and then not shown in the file output
> > > sys/kernel/debug/tracing/print_formats.
> > > 
> > > Adding a "__used" to the variable in the __trace_printk_fmt section on
> > > event_trace_printk() will keep it around, even though it is set to NULL.
> > > This will keep the string from being printed in the
> > > sys/kernel/debug/tracing/printk_formats section.
> > > 
> > > We can also refer to commit 3debb0a9ddb1 ("tracing: Fix trace_printk()
> > > to print when not using bprintk()")that it had similar issue on path of
> > > trace_printk().
> > 
> > Honestly, I don't even remember why that macro was created. I think
> > it's a remnant from the creation of the trace events. I think the best
> > solution is just to nuke it. It shouldn't be used anymore.
> > 
> > I'll dig a bit deeper into the history of that macro, but I'm thinking
> > it shouldn't exist anymore.
> > 
> > [ /me returns from walking down memory lane ]
> > 
> > Wow, that brings back some wild memories. Yes, that macro must die, and
> > I wish the history of it could die along with it ;-) The horror of the
> > old ways I tell you. The event_trace_printk() was the original way we
> > displayed events! No real formatting, no parsing my userspace tools. It
> > was just a glamorized printk. It was called TRACE_FORMAT() which was
> > deprecated by today's TRACE_EVENT().
> > 
> > That macro should have been removed by commit b8e65554d80b4.
> > 
> > Please just send a patch to delete that macro. Let's not be maintaining
> > it. It gives me nightmares.
> > 
> > -- Steve
> 
> Got it, I will send another patch to remove the nightmares. :-)
> 
> Thanks.

After some grep, I found event_trace_printk() not used in 5.0-rc*. But
trace_printk() is still used in several places.

kernel/trace/ring_buffer_benchmark.c:415: trace_printk("Sleeping for 10
secs\n");
...
drivers/gpu/drm/i915/i915_gem.h:66:#define GEM_TRACE(...)
trace_printk(__VA_ARGS__)
drivers/hwtracing/stm/dummy_stm.c:30:   trace_printk("[%u:%u] [pkt: %x/%
x] (%llx)\n", master, channel,
...

since they are similar functions, do you prefer remove both of them or
just remove event_trace_printk()? the former approach might affect some
modules, and the latter approach keeps nightmares, right?

Thanks.
> 


