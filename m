Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D13C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7386F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7386F21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeK3K7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:59:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36166 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeK3K7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:59:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gSW6Y-0005Je-KL; Thu, 29 Nov 2018 23:52:22 +0000
Date:   Thu, 29 Nov 2018 23:52:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paulmck@linux.vnet.ibm.com, Florian Weimer <fweimer@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH - resend*2] VFS: use synchronize_rcu_expedited() in
 namespace_unlock()
Message-ID: <20181129235222.GJ2217@ZenIV.linux.org.uk>
References: <87y3nyd4pu.fsf@notabene.neil.brown.name>
 <20171026122743.GX3659@linux.vnet.ibm.com>
 <b8a1a898-850c-cc7a-2574-1bfd15cc9888@redhat.com>
 <20171127144125.GF3624@linux.vnet.ibm.com>
 <87induxd3u.fsf@notabene.neil.brown.name>
 <87tvm1rxme.fsf@notabene.neil.brown.name>
 <20181005014002.GS32577@ZenIV.linux.org.uk>
 <87mupro3wh.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mupro3wh.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 10:33:18AM +1100, NeilBrown wrote:
> 
> The synchronize_rcu() in namespace_unlock() is called every time
> a filesystem is unmounted.  If a great many filesystems are mounted,
> this can cause a noticable slow-down in, for example, system shutdown.
> 
> The sequence:
>   mkdir -p /tmp/Mtest/{0..5000}
>   time for i in /tmp/Mtest/*; do mount -t tmpfs tmpfs $i ; done
>   time umount /tmp/Mtest/*
> 
> on a 4-cpu VM can report 8 seconds to mount the tmpfs filesystems, and
> 100 seconds to unmount them.
> 
> Boot the same VM with 1 CPU and it takes 18 seconds to mount the
> tmpfs filesystems, but only 36 to unmount.
> 
> If we change the synchronize_rcu() to synchronize_rcu_expedited()
> the umount time on a 4-cpu VM drop to 0.6 seconds
> 
> I think this 200-fold speed up is worth the slightly high system
> impact of using synchronize_rcu_expedited().
> 
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com> (from general rcu perspective)
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
> 
> Al Viro says "I can live with this one" but this still hasn't landed.
> Maybe someone else could apply it?

Applied (in work.misc, once I push it out)
