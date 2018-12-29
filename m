Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E80C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 17:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646192145D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 17:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeL2Ro0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 12:44:26 -0500
Received: from yaina.de ([78.46.107.162]:47250 "EHLO mail.yaina.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727596AbeL2Ro0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 12:44:26 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Dec 2018 12:44:24 EST
Received: by mail.yaina.de (Postfix, from userid 500)
        id 7219F12B89D; Sat, 29 Dec 2018 18:36:59 +0100 (CET)
Date:   Sat, 29 Dec 2018 18:36:59 +0100
From:   Joerg Reuter <jreuter@yaina.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in ax25_fillin_cb
Message-ID: <20181229173658.GA13856@yaina.de>
References: <000000000000da8f65057e1ce530@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000da8f65057e1ce530@google.com>
X-Face: -|Tm)MD9B08?aHe]*_v09ON~6*LV"A:<1AMnvz)sW#R9rWf?vf_5n=%"yPK]&ybq.K}xR5_
 +8Pb4r3C#wP%iWD$,_k;oH\}]cG54jLEtf)%Wcu6naYc#poD0=r(b^df%6G-vC6L0I/..iYP=HYJTN
 <VS3K"q`KX>6vC#EF;\uBwX[6[6d
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 02:51:04PM -0800, syzbot wrote:

> BUG: KASAN: use-after-free in ax25_fillin_cb_from_dev net/ax25/af_ax25.c:450
> [inline]
> BUG: KASAN: use-after-free in ax25_fillin_cb+0x6d5/0x810
> net/ax25/af_ax25.c:477
> Read of size 4 at addr ffff8881ccecc438 by task syz-executor5/11370

Not good... Why do things like this always pop up when I'm traveling?

>  ax25_fillin_cb_from_dev net/ax25/af_ax25.c:450 [inline]
>  ax25_fillin_cb+0x6d5/0x810 net/ax25/af_ax25.c:477
>  ax25_setsockopt+0x92a/0xa20 net/ax25/af_ax25.c:663

That's here:
	// ...
	case SO_BINDTODEVICE:
		// ...
		dev = dev_get_by_name(&init_net, devname);
		if (!dev) {
			res = -ENODEV;
			break;
		}

		ax25->ax25_dev = ax25_dev_ax25dev(dev);
		ax25_fillin_cb(ax25, ax25->ax25_dev);
		dev_put(dev);
		break;

Thus, dev is not NULL, and neither is dev->ax25_ptr.

> Freed by task 11339:
>  [..]
>  ax25_dev_device_down+0x164/0x2f0 net/ax25/ax25_dev.c:129
>  ax25_device_event+0x1f6/0x2e0 net/ax25/af_ax25.c:131
>  notifier_call_chain+0x17e/0x380 kernel/notifier.c:93

ax25_dev_device_down() has this:

       if ((s = ax25_dev_list) == ax25_dev) {
		ax25_dev_list = s->next;
		spin_unlock_bh(&ax25_dev_lock);
		dev_put(dev);
		kfree(ax25_dev);
		return;
	}

	while (s != NULL && s->next != NULL) {
		if (s->next == ax25_dev) {
			s->next = ax25_dev->next;
			spin_unlock_bh(&ax25_dev_lock);
			dev_put(dev);
			kfree(ax25_dev); // <==== here
			return;
		}

		s = s->next;
	}
	spin_unlock_bh(&ax25_dev_lock);
	dev->ax25_ptr = NULL;

I hope I didn't write this... *shudders*

Anyway, we are indeed missing to set dev->ax25_ptr to NULL if we're at
the head or somewhere on the ax25_dev_list, probably because it will be
cleaned up on removal of dev anyway. Unfortunately, in the meantime
either someone could call setsockopt() on an existing socket, or the
setsockopt() call got interrupted. From my POV the SO_BINDTODEVICE needs
to get protected by this:

		spin_lock_bh(&ax25_dev_lock);
		ax25->ax25_dev = ax25_dev_ax25dev(dev);
		if (ax25->ax25_dev != NULL) {
			ax25_fillin_cb(ax25, ax25->ax25_dev);
			dev_put(dev);
		}
		spin_unlock_bh(&ax25_dev_lock);

and ax25_dev_device_down() needs to be rewritten and ensure
that dev->ax25_ptr gets set to NULL after each kfree(ax25_dev)

Unfortunately, I'm on a low bandwidth connection right now. I'd be
grateful if someone could create a patch. This is likely not a high
impact issue (unpriviliged users can't set up or tear down interfaces),
still it may cause hard to find memory corruptions.

	- Joerg (yes, I'm still alive)

-- 
Joerg Reuter                                    http://yaina.de/jreuter
And I make my way to where the warm scent of soil fills the evening air. 
Everything is waiting quietly out there....                 (Anne Clark)
