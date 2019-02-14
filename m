Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D51C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1EA222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550153992;
	bh=bQeUdn+pOnsvAJ1YSUsb7VdLHukLiuB9N2BohOeBwXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YyvbhJr7wg5SeClZ7FQYx2oAK1AaHN1Q31IzOHPSppdNFpmudgzjlrG2r3675BtJB
	 L/kJa+vgEa+hI0gBvMgW3dxDfpDVikmBd/pisGR/g375WpdqjjdNoG1VpLFd6tPCMz
	 IQBTEiQVOsWkMZ/4cmdN4Ta3KdtP/LniI+G7ZR00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407125AbfBNOTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfBNOTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:19:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B32222D4;
        Thu, 14 Feb 2019 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550153990;
        bh=bQeUdn+pOnsvAJ1YSUsb7VdLHukLiuB9N2BohOeBwXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vmZEE1LU9gvByCquAQQkt+2YCvdL3ZLEe/2+0w/pM3ftcAmH0pGK0DBRNiABxnHiZ
         5+OPhPCpwBNBeD+b4fS2AAzBXp93t8GrugNRpeBGhSVL1q7qDxAAsyB5M5/g9LNUgG
         m3oQ6ESoXpVEumek1+54ln+1b655Ez4891miwZgU=
Date:   Thu, 14 Feb 2019 15:19:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Emil Velikov <emil.velikov@collabora.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 004/352] drm/vgem: Fix vgem_init to get drm device
 available.
Message-ID: <20190214141947.GA31965@kroah.com>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141846.783223749@linuxfoundation.org>
 <20190214135802.GB20918@arch-x1c3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214135802.GB20918@arch-x1c3>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 01:58:02PM +0000, Emil Velikov wrote:
> Hi Greg,
> 
> On 2019/02/11, Greg Kroah-Hartman wrote:
> > 4.20-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > [ Upstream commit d5c04dff24870ef07ce6453a3f4e1ffd9cf88d27 ]
> > 
> > Modify vgem_init to take platform dev as parent in drm_dev_init.
> > This will make drm device available at "/sys/devices/platform/vgem"
> > in x86 chromebook.
> > 
> > v2: rebase, address checkpatch typo and line over 80 characters
> > 
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
> > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Link: https://patchwork.freedesktop.org/patch/msgid/20181023163550.15211-1-emil.l.velikov@gmail.com
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Zero objections to picking this for stable, although I'm curious what
> flagged this commit as stable material.
> 
> Especially since it's closer to a feature than a bug-fix.
> 
> Can you share some light? Perhaps a link to a thread/document since I
> would imagine you've been asked before.

Sasha has a presentation all about how this gets picked up, but I can't
find the link right now.  Sasha?

