Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686D5C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E40D2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cH7OhZp7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Us0Wqxg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E40D2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389465AbeKGCSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:18:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389214AbeKGCSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:18:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8516861307; Tue,  6 Nov 2018 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541523166;
        bh=6QjqHF1QGun3rcIwTlZi566jp5Evxw/xJ5x1ffPq3jY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cH7OhZp78GxnM+eqM+/b2vKxiP7MCgG2p6Lp1AcCnDT4GdqvCz3EWLbqd0N4LRlvW
         MxMyszrrHm3/bL72ZMFlOecinyHfyH1fRcQlYNbLezOTZIS4ogtKZhskCX+UhklI9W
         muCwvLXSiV3AXYv5JX7JkPh1xlAKJ66isx8+NhYw=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7B1B60B7D;
        Tue,  6 Nov 2018 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541523165;
        bh=6QjqHF1QGun3rcIwTlZi566jp5Evxw/xJ5x1ffPq3jY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Us0Wqxg14g4h9AmH9iaTHURJJkpEh5foYbp3eRtK3kA9+T4EQTs3QJKB18WWDsUL7
         yzjI2TddqXmjFM5kSP+daiQIJdh1NBJ6wgJQiYG9htmDTLIvax1C3bW1GZ9EB++3Xr
         g1mRqk2ac2aNq6k23/qeq6/ZQjtPRw54G3VRnx4A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7B1B60B7D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 6 Nov 2018 09:52:42 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, chris@chris-wilson.co.uk,
        robdclark@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/msm: use kvmalloc for ring data in gpu crashstate
Message-ID: <20181106165242.GA27851@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Sharat Masetty <smasetty@codeaurora.org>,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, chris@chris-wilson.co.uk,
        robdclark@gmail.com, linux-kernel@vger.kernel.org
References: <1541484606-20813-1-git-send-email-smasetty@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541484606-20813-1-git-send-email-smasetty@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 11:40:04AM +0530, Sharat Masetty wrote:
> The ringbuffer data to capture at crashtime can end up being large
> sometimes, and the size can vary from being less than a page to the
> full size of 32KB. So use the kvmalloc variant that perfectly fits the bill.
> 
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 141062f..c93702d 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -406,7 +406,7 @@ int adreno_gpu_state_get(struct msm_gpu *gpu, struct msm_gpu_state *state)
>  				size = j + 1;
>  
>  		if (size) {
> -			state->ring[i].data = kmalloc(size << 2, GFP_KERNEL);
> +			state->ring[i].data = kvmalloc(size << 2, GFP_KERNEL);
>  			if (state->ring[i].data) {
>  				memcpy(state->ring[i].data, gpu->rb[i]->start, size << 2);
>  				state->ring[i].data_size = size << 2;
> @@ -445,7 +445,7 @@ void adreno_gpu_state_destroy(struct msm_gpu_state *state)
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(state->ring); i++)
> -		kfree(state->ring[i].data);
> +		kvfree(state->ring[i].data);
>  
>  	for (i = 0; state->bos && i < state->nr_bos; i++)
>  		kvfree(state->bos[i].data);
> -- 
> 1.9.1
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
