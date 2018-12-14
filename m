Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2049DC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C5B20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544771912;
	bh=4Qcazf4gN7Np/Y5uphg8NKZrrThoNVKCQy2pMcMKeAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FJVcacT/k2TJ2xN0w3p7Ih/JU/nR8oN6EgTr1sUZJqcWGu3y+M1geVGdHQR2dpA7D
	 LpOQLLPIeufwUVR4PZ8NRYG1qJcRIq2oHnYvaMtKpWoEirQLgRChXQRywZvBJ9XrKR
	 2jx6BVtvJwXofoVvC86S3XW/r/X6Lf7jmPCVVQB0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C5B20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeLNHSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:18:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbeLNHSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:18:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A072D2086D;
        Fri, 14 Dec 2018 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544771909;
        bh=4Qcazf4gN7Np/Y5uphg8NKZrrThoNVKCQy2pMcMKeAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6KMPorPjWPuGDsbHBbMz5r0ECyLAEdoALczkaoxrI4i9oKwXgt/WZ+piqg3JJ+nT
         A+F3X/VCTI1akp2VvO5WImRftOAxyiVoCRPyyA+01TBPnDqpdcPDraCDOnF7ErG6By
         o9KOirJq9L5eQZnXOW4M11EHTLC6aYR3Q3G9ruVs=
Date:   Fri, 14 Dec 2018 08:18:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Henrik Austad <henrik@austad.us>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/17] Backport rt/deadline crash and the ardous story of
 FUTEX_UNLOCK_PI to 4.4
Message-ID: <20181214071826.GE31355@kroah.com>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
 <20181109103531.GA9188@sisyphus.home.austad.us>
 <20181119112720.GA29334@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119112720.GA29334@sisyphus.home.austad.us>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 12:27:21PM +0100, Henrik Austad wrote:
> On Fri, Nov 09, 2018 at 11:35:31AM +0100, Henrik Austad wrote:
> > On Fri, Nov 09, 2018 at 11:07:28AM +0100, Henrik Austad wrote:
> > > From: Henrik Austad <haustad@cisco.com>
> > > 
> > > Short story:
> > 
> > Sorry for the spam, it looks like I was not very specific in /which/ 
> > version I targeted this to, as well as not providing a full Cc-list for the 
> > cover-letter.
> 
> Gentle prod. I realize this was sent out just before plumbers and that 
> people had pretty packed agendas, so a small nudge to gain a spot closer to 
> the top of the inbox :)
> 
> This series has now been running on an arm64 system for 9 days without any 
> issues and pi_stress showed a dramatic improvement from ~30 seconds and up 
> to several ours (it finally deadlocked at 3.9e9 inversions).
> 
> I'd greatly appreciate if someone could give the list of patches a quick 
> glance to verify that I got all the required patches and then if it could 
> be added to 4.4.y.

This is a really intrusive series of patches, and without some testing
and verification by others, I am really reluctant to take these patches.

Why not just move to the 4.9.y tree, or better yet, 4.19.y to resolve
this issue for your systems?

thanks,

greg k-h
