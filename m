Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9375FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F13620862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eS1ijfwn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ik0p1xBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F13620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeK0Flg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:41:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeK0Flf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:41:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F2E2C60F39; Mon, 26 Nov 2018 18:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543257996;
        bh=8E/fy05vk++UaC89yKOOhHJrfKYYC28WZ/8UNNye7qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eS1ijfwnoQQKIOh5aPdW8d2ookg3NW984cM9+Sf2fid9PVkhFHtPuMvNA1NYk4ewS
         rZHmspGZTaSHo5dsBtye6XHFGW7yPaSXUlU53ZORAs8Ly4fLM2YBsq5yAyk6PEl26Y
         qsZvwlPeajxNT/90ndMYlvjKsKLpWT6YJb3MGLCg=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79262609A8;
        Mon, 26 Nov 2018 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543257995;
        bh=8E/fy05vk++UaC89yKOOhHJrfKYYC28WZ/8UNNye7qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ik0p1xBngmz0aNM810X9aYmeeOLlpft5GSAWJOs44iCw1JO2i45lp926lKhVyQokq
         YC6sVWMw14N8V7TvUDYNKQgbFGhlLxIdPyl0YLbAepc5+G97pOsqqTp2r2DPXFtGz8
         BYGdacLQfMNc6VDUqpOQvJ1Wk1cL6/XE/F2HbKs4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79262609A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 26 Nov 2018 11:46:32 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Tomasz Figa <tfiga@chromium.org>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181126184632.GK31792@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20181120095437.29820-1-vivek.gautam@codeaurora.org>
 <20181120154148.GC31792@jcrouse-lnx.qualcomm.com>
 <CAAFQd5DAa+TmvJCViRHq8YTJh2GRyqBteicOLgohv5v7cNCQPA@mail.gmail.com>
 <bb5d0665-ad58-95f2-3cc8-75209abe4c6b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb5d0665-ad58-95f2-3cc8-75209abe4c6b@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 03:37:54PM +0530, Vivek Gautam wrote:
> Hi Tomasz, Jordan,
> 
> 
> On 11/21/2018 9:18 AM, Tomasz Figa wrote:
 
> >
> >>>+                     for_each_sg(msm_obj->sgt->sgl, s,
> >>>+                                 msm_obj->sgt->nents, i)
> >>>+                             sg_dma_address(s) = sg_phys(s);
> >>>+
> >>I'm wondering - wouldn't we want to do this association for cached buffers to so
> >>we could sync them correctly in cpu_prep and cpu_fini?  Maybe it wouldn't hurt
> >>to put this association in the main path (obviously the sync should stay inside
> >>the conditional for uncached buffers).
> >>
> 
> Sure, I will move this out of the conditional check.
> 
> >I guess it wouldn't hurt indeed. Note that cpu_prep/fini seem to be
> >missing the sync call currently.
> 
> I can't say I understand the usage of cpu_prep and cpu_fini(). But I can add
> the necessary support if you can point me in the right direction.

Not needed for this iteration. We don't have support in those functions for
cached buffers right now so continuing to not support it wouldn't hurt.

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
