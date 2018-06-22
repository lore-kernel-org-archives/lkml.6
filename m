Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208E6C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D24244EE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D24244EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934017AbeFVPom (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:44:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42065 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933738AbeFVPol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:44:41 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWOEO-0007wV-Or; Fri, 22 Jun 2018 17:44:12 +0200
Date:   Fri, 22 Jun 2018 17:44:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the vfs tree
In-Reply-To: <5462d90a-0cac-ca10-1633-275a9836ad41@intel.com>
Message-ID: <alpine.DEB.2.21.1806221742280.2402@nanos.tec.linutronix.de>
References: <e6a26908-67b2-e32e-06b5-d2e62acce305@intel.com> <20180622115346.1e9cc433@canb.auug.org.au> <29411.1529671523@warthog.procyon.org.uk> <20180622130600.GY30522@ZenIV.linux.org.uk> <alpine.DEB.2.21.1806221537570.2402@nanos.tec.linutronix.de>
 <5462d90a-0cac-ca10-1633-275a9836ad41@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Reinette Chatre wrote:
> On 6/22/2018 6:39 AM, Thomas Gleixner wrote:
> > On Fri, 22 Jun 2018, Al Viro wrote:
> >> On Fri, Jun 22, 2018 at 01:45:23PM +0100, David Howells wrote:
> >>> Reinette Chatre <reinette.chatre@intel.com> wrote:
> >>>
> >>>> Thomas and David, please let me know what I can do from my side to help
> >>>> with this.
> >>>
> >>> You could try basing on Al Viro's for-next tree which has the mount API
> >>> changes in it.
> >>
> >> Umm...  That would be a massive headache for everyone involved; the changes
> >> in there have very little in common with what you are doing in rdt_mount(),
> >> so it might make sense to start with a minimal never-rebased branch that
> >> would
> >> 	* define rdt_pseudo_lock_init as 0
> >> 	* define rdt_pseudo_lock_release as empty
> >> 	* do the rdt_mount() part of a3dbd01e6c9d
> >> 	* have commit message along the lines of
> >> "hooks in rdt_mount() for rdt_pseudo_lock to use
> >>
> >> Functionally a no-op right now; the only reason for having that
> >> as a never-rebased branch to get rdt_pseudo_lock and mount series
> >> out of each other's hair"
> >>
> >> Base that on -rc1, then pull it into your rdt branch and David could pull the
> >> same into his.
> > 
> > Yes, that works.
> > 
> > Reinette, can you please look into creating that ordering. Then we just zap
> > the existing branch and redo it with this scheme.
> 
> Will do. How would you prefer to consume this to make the branches
> simple to create? Is it ok if I create a new patch series with Al's
> suggestion above as the first commit?
> 
> The original pseudo-locking patch series consisted out of two sections
> with the pseudo-locking specific parts starting in the middle. If I
> create a new series with the above change then it will not be cleanly
> separate anymore. Is that ok?

That's fine. Just mention it clearly in the changelog of that first one or
two patches you need for that.

Thanks,

	tglx
