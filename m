Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BBBC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BDA205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eMDLxLEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BDA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeJWBeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:34:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbeJWBeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SwhhilehX59OtzNOyzMPQK2caX/odAvnEp9Szdmmcsw=; b=eMDLxLEMIeSeX/C1ji37nsDn4
        6OO10+kARN1VF1wwfpY5bm0M5gz5iWcNZ/aCXb6koe3ZcKG3GzW6koaYhPV4LgZ+uvvNzc5Z1BkwY
        Cewa5qlSIDlzSK5YeqvKDci5E2ES/ZsNyxzSpgd9MVYaYcn0ycuhx1VIKBTKRheywq85SKISNpCDG
        gI2nsOC79Wa/tO7gD7fGXRhEnK+1uYMzOwiS1yzZcSc0yE3ydIuPe5CsIyYlVBpgK/8hzhsk8irW+
        d5DKIq/N6OQUa3I+FmtuIjVgxeW0AViTxRCDwIoipVb+qkFbGtze3t1KejUHnbe3jljvxlMEl+vEU
        CfgsSsw1g==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEdnW-0004DZ-1G; Mon, 22 Oct 2018 17:15:22 +0000
Received: by worktop (Postfix, from userid 1000)
        id 8FC896E082E; Mon, 22 Oct 2018 19:15:16 +0200 (CEST)
Date:   Mon, 22 Oct 2018 19:15:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Juergen Gross <jgross@suse.com>, Yi Sun <yi.y.sun@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Message-ID: <20181022171516.GH3117@worktop.programming.kicks-ass.net>
References: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
 <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
 <bab010e9-a122-95f1-d8cc-790e56c72716@suse.com>
 <20181022015342.GK11769@yi.y.sun>
 <2e0d62cb-b706-a5b4-65f7-982a913fb32b@suse.com>
 <ba75b994-c1a6-6e91-6499-b9af90636fcf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba75b994-c1a6-6e91-6499-b9af90636fcf@redhat.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Firstly, who come a patch that is grubbing around in kernel/locking/ has
an x86/hyperv subject and isn't Cc'ed to the locking maintainers?

On Mon, Oct 22, 2018 at 12:31:45PM -0400, Waiman Long wrote:
> On 10/22/2018 03:32 AM, Juergen Gross wrote:
> > On 22/10/2018 03:53, Yi Sun wrote:
> >> On 18-10-19 16:20:52, Juergen Gross wrote:
> >>> On 19/10/2018 15:13, Yi Sun wrote:
> >> [...]
> >>
> >>>> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> >>>> index 0130e48..9e88c7e 100644
> >>>> --- a/kernel/locking/qspinlock_paravirt.h
> >>>> +++ b/kernel/locking/qspinlock_paravirt.h
> >>>> @@ -7,6 +7,8 @@
> >>>>  #include <linux/bootmem.h>
> >>>>  #include <linux/debug_locks.h>
> >>>>  
> >>>> +#include <asm/mshyperv.h>
> >>>> +
> >>>>  /*
> >>>>   * Implement paravirt qspinlocks; the general idea is to halt the vcpus instead
> >>>>   * of spinning them.
> >>>> @@ -305,6 +307,10 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
> >>>>  				wait_early = true;
> >>>>  				break;
> >>>>  			}
> >>>> +#if defined(CONFIG_X86_64) && defined(CONFIG_PARAVIRT_SPINLOCKS) && IS_ENABLED(CONFIG_HYPERV)
> >>>> +			if (!hv_notify_long_spin_wait(SPIN_THRESHOLD - loop))
> >>>> +				break;
> >>>> +#endif

Secondly; how come you thought that was acceptable in any way shape or
form?

> > vcpu_is_preempted() is already part of this loop. And this is a paravirt
> > hook. Can't you make use of that? This might require adding another
> > parameter to this hook, but I'd prefer that over another pv-spinlock
> > hook.

> I agree with Juergen on that. I would suggest rename the
> vcpu_is_preempted hook into a more generic vcpu_stop_spinning, perhaps,
> so different hypervisors can act on the information accordingly. Adding
> an extra parameter is fine.

No; no extra parameters. vcpu_is_preempted() is a simple and intuitive
interface. Why would we want to make it complicated?
