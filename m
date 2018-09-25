Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5EFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8789420842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8789420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbeIYSSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:18:30 -0400
Received: from foss.arm.com ([217.140.101.70]:49890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbeIYSS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:18:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18B8880D;
        Tue, 25 Sep 2018 05:11:14 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D768E3F5B7;
        Tue, 25 Sep 2018 05:11:11 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:11:04 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/9] timer: fix circular header dependency
Message-ID: <20180925121104.zrz4m45sbnt5h2ht@lakrids.cambridge.arm.com>
References: <cover.1537802981.git.christophe.leroy@c-s.fr>
 <72d3e8c38f729dc22cb3235319b72f96190e01ee.1537802981.git.christophe.leroy@c-s.fr>
 <5c9530da-f5c8-e0b2-61ab-294a0da7f3fc@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c9530da-f5c8-e0b2-61ab-294a0da7f3fc@c-s.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:34:15AM +0200, Christophe LEROY wrote:
> 
> 
> Le 24/09/2018 à 17:52, Christophe Leroy a écrit :
> > When switching powerpc to CONFIG_THREAD_INFO_IN_TASK, include/sched.h
> > has to be included in asm/smp.h for the following change, in order
> > to avoid uncomplete definition of task_struct:
> > 
> > -#define raw_smp_processor_id() (current_thread_info()->cpu)
> > +#define raw_smp_processor_id() (current->cpu)
> > 
> > But this generates the following compilation error, due to circular
> > header dependency.
> > 
> >    CC      kernel/time/alarmtimer.o
> > In file included from ./arch/powerpc/include/asm/smp.h:31,
> >                   from ./include/linux/smp.h:64,
> >                   from ./include/linux/percpu.h:7,
> >                   from ./include/linux/hrtimer.h:22,
> >                   from kernel/time/alarmtimer.c:19:
> > ./include/linux/sched.h:558:19: error: field 'dl_timer' has incomplete type
> >    struct hrtimer   dl_timer;
> >                     ^~~~~~~~
> > ./include/linux/sched.h:567:17: error: field 'inactive_timer' has incomplete type
> >    struct hrtimer inactive_timer;
> >                   ^~~~~~~~~~~~~~
> > make[1]: *** [kernel/time/alarmtimer.o] Error 1
> > make: *** [kernel/time/alarmtimer.o] Error 2
> > 
> >    CC      fs/timerfd.o
> > In file included from ./arch/powerpc/include/asm/smp.h:31,
> >                   from ./include/linux/smp.h:64,
> >                   from ./include/linux/percpu.h:7,
> >                   from ./include/linux/hrtimer.h:22,
> >                   from ./include/linux/alarmtimer.h:6,
> >                   from fs/timerfd.c:12:
> > ./include/linux/sched.h:558:19: error: field 'dl_timer' has incomplete type
> >    struct hrtimer   dl_timer;
> >                     ^~~~~~~~
> > ./include/linux/sched.h:567:17: error: field 'inactive_timer' has incomplete type
> >    struct hrtimer inactive_timer;
> >                   ^~~~~~~~~~~~~~
> > make[1]: *** [fs/timerfd.o] Error 1
> > make: *** [fs/timerfd.o] Error 2
> > 
> > This patch fixes it by including linux/hrtimer.h after linux/sched.h
> > 
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > ---
> >   Should it be fixed in powerpc instead ? In that case, how ? Any idea ?
> 
> 
> Looks like there are several other places where the problem occurs, so it
> has to be fixed in the powerpc headers instead.
> 
> Seems like RISC arch faced the same issue, and fixed it the following way:
> 
> /*
>  * This is particularly ugly: it appears we can't actually get the
> definition
>  * of task_struct here, but we need access to the CPU this task is running
> on.
>  * Instead of using C we're using asm-offsets.h to get the current processor
>  * ID.
>  */
> #define raw_smp_processor_id() (*((int*)((char*)get_current() +
> TASK_TI_CPU)))
> 
> 
> Unless someone has a better idea, I'll fixed it that way.

To solve this on arm64 we made the cpu number a percpu variable; see
commit:

  57c82954e77fa12c ("arm64: make cpu number a percpu variable")

IIUC, you could do that by placing it in paca_struct.

Thanks,
Mark.
