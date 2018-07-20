Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E5AECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E33120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E33120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeGTKgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:36:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49520 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeGTKgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:36:41 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 46F2341C;
        Fri, 20 Jul 2018 09:49:13 +0000 (UTC)
Date:   Fri, 20 Jul 2018 11:49:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Vyukov <dvyukov@google.com>, stable@vger.kernel.org
Cc:     James Chapman <jchapman@katalix.com>,
        David Miller <davem@davemloft.net>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Greg Hackmann <ghackmann@google.com>,
        syzbot <syzbot+065d0fc357520c8f6039@syzkaller.appspotmail.com>,
        Guillaume Nault <g.nault@alphalink.fr>
Subject: Re: KASAN: use-after-free Read in l2tp_session_create
Message-ID: <20180720094911.GA24081@kroah.com>
References: <001a11405130a984300562e8e7b3@google.com>
 <CACT4Y+Y1ZskrqsmhWoHWXOigMHX5eyG5nGGyuU6cZ0uNnChSiQ@mail.gmail.com>
 <5308835b-b5ef-51e4-2e4f-05a9636dff55@katalix.com>
 <CACT4Y+YRmX2ROxWZcT4w-NHR76cVV4_U6-Y0T=x4on67r8dNzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YRmX2ROxWZcT4w-NHR76cVV4_U6-Y0T=x4on67r8dNzQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:00:34AM +0200, Dmitry Vyukov wrote:
> On Fri, Jul 20, 2018 at 9:53 AM, James Chapman <jchapman@katalix.com> wrote:
> > On 18/07/18 12:00, Dmitry Vyukov wrote:
> >> On Tue, Jan 16, 2018 at 7:29 PM, syzbot
> >> <syzbot+065d0fc357520c8f6039@syzkaller.appspotmail.com> wrote:
> >>> Hello,
> >>>
> >>> syzkaller hit the following crash on
> >>> a8750ddca918032d6349adbf9a4b6555e7db20da
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> >>> compiler: gcc (GCC) 7.1.1 20170620
> >>> .config is attached
> >>> Raw console output is attached.
> >>> Unfortunately, I don't have any reproducer for this bug yet.
> >>>
> >>>
> >>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >>> Reported-by: syzbot+065d0fc357520c8f6039@syzkaller.appspotmail.com
> >>> It will help syzbot understand when the bug is fixed. See footer for
> >>> details.
> >>> If you forward the report, please keep this part and the footer.
> >>
> >> James,
> >>
> >> Did you fix this? You asked syzbot to test a fix for this bug some time ago.
> >> If yes, did you include the Reported-by tag in the commit? This bug is
> >> still considered open by syzbot. But it stopped happening ~4 months
> >> ago:
> >
> > Yes, I think this has been fixed now. I think it was fixed by
> > Guillaume's 6b9f34239b00e6956a267abed2bc559ede556ad6 that was actually
> > to fix another syzbot bug fbeeb5c3b538e8545644 which looks similar to
> > this one.
> >
> >> https://syzkaller.appspot.com/bug?id=6fed0854381422329e78d7e16fb9cf4af8c9aef1
> >> We are also seeing these crashes in 4.4 and 4.9, it would be good to
> >> backport the fix.
> >
> > It looks like 6b9f34239b00e6956a267abed2bc559ede556ad6 hasn't made it to
> > 4.9 or 4.4.
> 
> Thanks for the update!
> 
> Let's tell syzbot that this is fixed:
> 
> #syz fix: l2tp: fix races in tunnel creation
> 
> Greg H: so this is probably the patch we need.
> 
> +Greg KH: I think we need this in stable, we hit this in both 4.4 and 4.9.

It's also needed in 4.14.y.  But it doesn't apply to any of those kernel
trees cleanly, can someone please provide a working backport?

thanks,

greg k-h
