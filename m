Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA586C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9410C208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9410C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeHQUFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:05:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeHQUFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:05:41 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BD17ACBF;
        Fri, 17 Aug 2018 17:01:32 +0000 (UTC)
Date:   Fri, 17 Aug 2018 19:01:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jinpu Wang <jinpu.wang@profitbricks.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, konrad.wilk@oracle.com
Subject: Re: [BUG]smt sysfs dir missing on 4.4.148 and 4.14.63
Message-ID: <20180817170129.GE24945@kroah.com>
References: <CAMGffEnzVo5VVSVBjCOBMhcoV1qXf0XXqJqr3C01xQn-aUiZFQ@mail.gmail.com>
 <20180816155126.GA18296@kroah.com>
 <CAMGffEmJR310NKHO1JpwE8yTg1Oeu_oaTaJ1D2_T_UHKCnHwKA@mail.gmail.com>
 <20180816163937.GA5105@kroah.com>
 <CAMGffEk2FqRn0av7T-aF-TKvRAKeinm96NYjJju_T4CmUrYPkQ@mail.gmail.com>
 <CAMGffEnKt0xcc6LhNdZQGRmckJ3qCFxCOnQ3owZmWWiaKYdYuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEnKt0xcc6LhNdZQGRmckJ3qCFxCOnQ3owZmWWiaKYdYuw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 02:39:00PM +0200, Jinpu Wang wrote:
> On Thu, Aug 16, 2018 at 6:48 PM Jinpu Wang <jinpu.wang@profitbricks.com> wrote:
> >
> > On Thu, Aug 16, 2018 at 6:39 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Aug 16, 2018 at 06:28:59PM +0200, Jinpu Wang wrote:
> > > > On Thu, Aug 16, 2018 at 5:51 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Aug 16, 2018 at 05:43:23PM +0200, Jinpu Wang wrote:
> > > > > > Hi Greg, hi Thomas,
> > > > > >
> > > > > > I noticed /sys/devices/system/cpu/smt dir is missing on 4.4.148 and
> > > > > > 4.14.63, default setting.
> > > > >
> > > > > For 4.4, I would be amazed if anything was there, the backport was done
> > > > > only to handle the local user issue, not the "full" protection.  So
> > > > > please try 4.9 or 4.14.
> > > > Thanks for quick reply. Right, just checked. the patch for create the
> > > > sysfs entry is missing.
> > >
> > > What patch is that?  What is the git commit id that we missed?
> > >
> > > > > How about 4.17 and 4.18, do those trees work properly for you?
> > > > I guess it's the same.
> > > > >
> > > > > > Tried stable/master branch 31130a16d459 ("Merge tag
> > > > > > 'for-linus-4.19-rc1-tag' of
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip")
> > > > > > It's the same there.
> > > > >
> > > > > Ah, so we are bug compatible, good :)
> > > > I will try test stable master a bit more to gather the full log.
> > > > >
> > > > > > When boot with 'nosmt' kernel paramter kernel 4.14.63 panic during
> > > > > > boot, 4.4.148 boot fine.
> > > > > > The call trace seem irq related, is it known bug?
> > > > >
> > > > > You are not giving us much to go on here sorry.  We need full details,
> > > > > and also please cc: lkml and the other developers who worked on this.
> > > > > THomas is on vacation this week.
> > > > Now, add more developers to cc, also lkml.
> > > >
> > > > I have the config and boot dmesg attached for default setting.
> > >
> > > I see no error in your boot log, what exactly are you worried about?
> > 2 problems here:
> > 1 According to https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html
> >   I expect /sys/devices/system/cpu/smt/, but it's not.
> > 2 kernel 4.14.63 panic when I boot with 'nosmt' or 'l1tf=full', I
> > attached the picture here again,
> >   I will try to get the full log tomorrow, also test with linus tree.
> > >
> > > confused,
> > >
> > > greg k-h
> >
> > Thanks
> I found the problem, CONFIG_HOTPLUG_SMT is enable due to CONFIG_SMP,
> but I did explicitly enable CONFIG_HOTPLUG_CPU.
> 
> That's why the smt dir is missing, and kernel panic when I boot with
> 'nosmt' or 'l1tf=full' probably also other combination.
> 
> With CONFIG_HOTPLUG_CPU=y, it works fine so far.

So do we need a new configuration dependancy here to resolve this
problem?  Why is this not an issue in Linus's tree?

confused,

greg k-h
