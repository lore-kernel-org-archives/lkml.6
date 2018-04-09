Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeDIL0H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:26:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54974 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751671AbeDIL0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:26:05 -0400
Date: Mon, 9 Apr 2018 12:26:00 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Ji.Zhang" <ji.zhang@mediatek.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Weiser <michael.weiser@gmx.de>,
        Julien Thierry <julien.thierry@arm.com>,
        Xie XiuQi <xiexiuqi@huawei.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, shadanji@163.com
Subject: Re: [PATCH] arm64: avoid race condition issue in dump_backtrace
Message-ID: <20180409112559.uh76jpiytznymw6w@lakrids.cambridge.arm.com>
References: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
 <20180322055929.z25brvwlmdighz66@salmiak>
 <1521711329.26617.31.camel@mtksdccf07>
 <20180326113932.2i6qp3776jtmcqk4@lakrids.cambridge.arm.com>
 <1522229612.26617.47.camel@mtksdccf07>
 <20180328101240.moo44g5qd3qjuxgn@lakrids.cambridge.arm.com>
 <1522397292.26617.63.camel@mtksdccf07>
 <20180404090431.rqwtaqovipxa5gta@lakrids.cambridge.arm.com>
 <1523174328.26617.91.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523174328.26617.91.camel@mtksdccf07>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 03:58:48PM +0800, Ji.Zhang wrote:
> Yes, I see where the loop is, I have missed that the loop may cross
> different stacks.
> Define a nesting order and check against is a good idea, and it can
> resolve the issue exactly, but as you mentioned before, we have no idea
> how to handle with overflow and sdei stack, and the nesting order is
> strongly related with the scenario of the stack, which means if someday
> we add another stack, we should consider the relationship of the new
> stack with other stacks. From the perspective of your experts, is that
> suitable for doing this in unwind?
> 
> Or could we just find some way easier but not so accurate, eg.
> Proposal 1: 
> When we do unwind and detect that the stack spans, record the last fp of
> previous stack and next time if we get into the same stack, compare it
> with that last fp, the new fp should still smaller than last fp, or
> there should be potential loop.
> For example, when we unwind from irq to task, we record the last fp in
> irq stack such as last_irq_fp, and if it unwind task stack back to irq
> stack, no matter if it is the same irq stack with previous, just let it
> go and compare the new irq fp with last_irq_fp, although the process may
> be wrong since from task stack it could not unwind to irq stack, but the
> whole process will eventually stop.

I agree that saving the last fp per-stack could work.

> Proposal 2:
> So far we have four types of stack: task, irq, overflow and sdei, could
> we just assume that the MAX number of stack spanning is just 3
> times?(task->irq->overflow->sdei or task->irq->sdei->overflow), if yes,
> we can just check the number of stack spanning when we detect the stack
> spans.

I also agree that counting the number of stack transitions will prevent
an inifinite loop, even if less accurately than proposal 1.

I don't have a strong preference either way.

Thanks,
Mark.
