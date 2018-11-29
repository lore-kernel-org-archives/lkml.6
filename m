Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B954FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8443F2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nm/47DeL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i6zAw6qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8443F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeK3GrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:47:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49196 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeK3GrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:47:06 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 770C160246; Thu, 29 Nov 2018 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543520433;
        bh=+HAz2pko/0I8mNF6pt/9+VgxmQOdf41JxCU6R1o2pMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nm/47DeLaL3Onwl9hk2PbvTBRQ1v19CMc7rYBw20uDWS03YWm9JYav7IajYgQblZc
         9ngEDaWS15eguNS0ibL+qitW2qLgM1omYOk5uLjdZoTCQqX1LFBESzmfyU2BNlh4l4
         RH+dwFr4DvuYpwEk4Y21Aw20k/43rj7q4p2dp/kM=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7638E60246;
        Thu, 29 Nov 2018 19:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543520432;
        bh=+HAz2pko/0I8mNF6pt/9+VgxmQOdf41JxCU6R1o2pMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6zAw6qz2/G0yn66VlSKXA5V8Hdj8pt7E/8Kmzl4XHEWnjdCSDgVYuD1Iz66PPtj5
         2gEnWmJy4pb5gJGrB64hBjIaWykLgPrrU2v3XfQnTT5TzIVh2T6nnjsNM9F+BMbKs8
         Nly6BF2h0M10J00eOuC/VglXX+iUamE3vvoBAV3k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7638E60246
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Thu, 29 Nov 2018 12:40:29 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     hch@lst.de, Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181129194029.GE17663@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>, hch@lst.de,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sean Paul <seanpaul@chromium.org>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de>
 <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAF6AEGu65Vvzpy6K7eF+Kk4YdYBPEKFX5ct8GxG0pw-KNwM5eA@mail.gmail.com>
 <20181129155418.GB26537@lst.de>
 <CAF6AEGufdp5jRtUZ_+VRQg3ZXH36hNHvbWZQeJDArp8N5SZ3Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGufdp5jRtUZ_+VRQg3ZXH36hNHvbWZQeJDArp8N5SZ3Lg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 01:48:15PM -0500, Rob Clark wrote:
> On Thu, Nov 29, 2018 at 10:54 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Nov 29, 2018 at 09:42:50AM -0500, Rob Clark wrote:
> > > Maybe the thing we need to do is just implement a blacklist of
> > > compatible strings for devices which should skip the automatic
> > > iommu/dma hookup.  Maybe a bit ugly, but it would also solve a problem
> > > preventing us from enabling per-process pagetables for a5xx (where we
> > > need to control the domain/context-bank that is allocated by the dma
> > > api).
> >
> > You can detach from the dma map attachment using arm_iommu_detach_device,
> > which a few drm drivers do, but I don't think this is the problem.
> 
> I think even with detach, we wouldn't end up with the context-bank
> that the gpu firmware was hard-coded to expect, and so it would
> overwrite the incorrect page table address register.  (I could be
> mis-remembering that, Jordan spent more time looking at that.  But it
> was something along those lines.)

Right - basically the DMA domain steals context bank 0 and the GPU is hard coded
to use that context bank for pagetable switching.

I believe the Tegra guys also had a similar problem with a hard coded context
bank.

This is a discussion we do need to have but not at the risk of derailing the
caching discussion which is arguably more important and has much wider ranging
implications for multimedia and Ion and such.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
