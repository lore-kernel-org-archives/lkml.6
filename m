Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E239C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577CF2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HNkM3sNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfAGQKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:10:17 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42884 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfAGQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:10:17 -0500
Received: by mail-ed1-f68.google.com with SMTP id y20so1384846edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=46m2z5xwOnYu24alrwjoBcVkrYWuSoPISoWtTMFVA2k=;
        b=HNkM3sNcvQy8ji2an0WbeBS4N7c2KP88Ds4LOSNJiEcCWTfDdOnrsbgFFvXrz0VvDh
         Lbe3uW0Mvt2YdHJl34IMpT+GKSDiDseWTKbn29Cp4ejKvOw4INpsXYTb9Ayr8FZOC4Yq
         ccdytIq0lGdgRbTJTplfq/dQM9nnFBp6CwVXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=46m2z5xwOnYu24alrwjoBcVkrYWuSoPISoWtTMFVA2k=;
        b=tyaBbv/V2MS6FKvA0XAFDF1olxNybWgYS3fAIQbgkluM7AN2IX0Z3WRw5q70xn6KC2
         hnKFjq+NtICdgU7Hk5IgXnL66P9PdtzBZjBa6ATAEhLlnPFDvt1xlTKKp3OrYa1bs6or
         9o7h94l/JJDqVt42rmWnP9sO16RMwK5poZmlzhDuTUpBrC2nlMX+IJL9KtkUvXyxeLA1
         mSojQ1aiX4zYnhotIKTBOP5I0eGjQWNxqvRUWKS3jj7lRBoojOEanf/rq7bXy7yU8viR
         8ef2P33A4xpHQ6Lt5m8XonDQAOo2urZfwyNABw9JHulIdK288maaaxz4FN1WdG6C/U4m
         1m8w==
X-Gm-Message-State: AJcUukcrGyc9oUPIcnwe0R5pop8WsZ7yH47Lcj+aQ0xIv9aL9kpBB6tt
        r79VA1LnlGsQ/dzllAQ8wyMUEg==
X-Google-Smtp-Source: ALg8bN4cRCdwAdReH+6BemauL4Al0Ves1+SMiOfHGoKzLIYAsU8tIBVLwm512y3ZJcdcYeWXZeCsNQ==
X-Received: by 2002:a50:d84d:: with SMTP id v13mr1369274edj.103.1546877414914;
        Mon, 07 Jan 2019 08:10:14 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t10-v6sm18044694ejg.41.2019.01.07.08.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 08:10:14 -0800 (PST)
Date:   Mon, 7 Jan 2019 17:10:12 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        daniel@ffwll.ch, robdclark@gmail.com, jcrouse@codeaurora.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] drm/prime: Use sg_dma_len() macro to get sg's
 length
Message-ID: <20190107161012.GM21184@phenom.ffwll.local>
Mail-Followup-To: Vivek Gautam <vivek.gautam@codeaurora.org>,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        robdclark@gmail.com, jcrouse@codeaurora.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <CAFp+6iGV6m_Bj=QBvt_wS2v-Bv=3vp15kUCuMZw3uyJGQD2ytg@mail.gmail.com>
 <20190107120708.18497-1-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107120708.18497-1-vivek.gautam@codeaurora.org>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 05:37:08PM +0530, Vivek Gautam wrote:
> After mapping a sg list the we should use sg_dma_address() and
> sg_dma_len() macros to access sg->address and sg->length. Fix
> the same for sg->length in drm_prime_sg_to_page_addr_arrays().
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
> 
> Changes since v1:
>  - Fixed compilation error: replaced sg_dma_length() with sg_dma_len().
> 
> This came while debugging one dmabuf import issue that we are seeing
> on sdm845 target.
> The dmabuf which is prepared by video (venus in this case), is imported
> by drm device.
> The import call flow looks like follows:
> 
> drm_gem_prime_import()
>  - drm_gem_prime_import_dev()
>    - dma_buf_attach() & dma_buf_map_attachment()
>      - From dma_buf_map_attachment()
>        - vb2_dma_sg_dmabuf_ops_map()
>          - dma_map_sg(): this updates the sg->nents.
> 
> From debugging, the sg table mapping results in sg's 'nents' to be less that
> the original nents. Now drm device prepares the page information based on
> this sg table, and messes up with the mappings, and we start seeing random
> crashes as below from drm's memory space.
> 
> Although this change isn't helping to fix the issue currently, but
> this fix seems the right thing to do.
> 
> One thing to notice is that, if we restore the sg->nents to
> sg->orig_nents in vb2_dma_sg_dmabuf_ops_map(), we don't see the below
> corruptions.
> 
> Any pointers on this will be highly appreciated.
> Thanks.
> 
> ------
> [  338.070558] Unable to handle kernel paging request at virtual address 0000400000000038
> [  338.078751] Mem abort info:
> [  338.081671]   ESR = 0x96000004
> [  338.084860]   Exception class = DABT (current EL), IL = 32 bits
> [  338.090972]   SET = 0, FnV = 0
> [  338.094139]   EA = 0, S1PTW = 0
> [  338.097393] Data abort info:
> [  338.100375]   ISV = 0, ISS = 0x00000004
> [  338.104362]   CM = 0, WnR = 0
> [  338.107446] [0000400000000038] address between user and kernel address ranges
> [  338.114801] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [  338.120527] Modules linked in: rfcomm uinput cdc_ether venus_dec venus_enc usbnet videobuf2_dma_sg videobuf2_memops hci_uart btqca bluetooth r8152 mii ath10k_snoc venus_core ath10k_core v4l2_mem2mem videobuf2_v4l2 videobuf2_common ath mac80211 ecdh_generic qcom_q6v5_mss lzo lzo_compress qcom_q6v5_adsp qcom_common qcom_q6v5 zram bridge stp llc ipt_MASQUERADE fuse snd_seq_dummy snd_seq snd_seq_device cfg80211 joydev
> [  338.158192] CPU: 4 PID: 3235 Comm: chrome Tainted: G        W         4.19.0 #2
> [  338.165700] Hardware name: Google Cheza (rev1) (DT)
> [  338.170720] pstate: 80400009 (Nzcv daif +PAN -UAO)
> [  338.175660] pc : drm_mm_insert_node_in_range+0xfc/0x348
> [  338.181035] lr : drm_mm_insert_node_in_range+0x24/0x348
> [  338.186407] sp : ffffff8013033b30
> [  338.189816] x29: ffffff8013033bd0 x28: ffffff8008591894
> [  338.195275] x27: 0000000000000010 x26: 0000000000000000
> [  338.200734] x25: 0000000000000000 x24: ffffffffffffffff
> [  338.206194] x23: 0000000000000000 x22: ffffffc0f48b7e08
> [  338.211656] x21: 0000000000000000 x20: 000000000000005d
> [  338.217118] x19: 0000000000000000 x18: 0000000000000000
> [  338.222581] x17: 0000000000000000 x16: 0000000000000000
> [  338.228046] x15: 0000000000000000 x14: 0000000000000000
> [  338.233511] x13: 0000000000000001 x12: ffffffc0b1da7200
> [  338.238978] x11: 0000000000000010 x10: 0000000000000010
> [  338.244437] x9 : 0000000000000008 x8 : 0000400000000000
> [  338.249898] x7 : 0000000000000000 x6 : ffffffffffffffff
> [  338.255361] x5 : 0000000000000000 x4 : 0000000000000000
> [  338.260823] x3 : 0000000000000000 x2 : 000000000000005d
> [  338.266285] x1 : ffffffc0b1da7100 x0 : ffffffc0b0215800
> [  338.271748] Process chrome (pid: 3235, stack limit = 0x000000000900f416)
> [  338.278628] Call trace:
> [  338.281151]  drm_mm_insert_node_in_range+0xfc/0x348
> [  338.286168]  msm_gem_map_vma+0x60/0xdc
> [  338.290022]  msm_gem_get_iova+0xb4/0xf4
> [  338.293967]  msm_ioctl_gem_info+0x90/0xdc
> [  338.298089]  drm_ioctl_kernel+0xa8/0xe8
> [  338.302043]  drm_ioctl+0x218/0x384
> [  338.305547]  drm_compat_ioctl+0xd8/0xe8
> [  338.309503]  __arm64_compat_sys_ioctl+0x134/0x20c
> [  338.314339]  el0_svc_common+0xa0/0xf0
> [  338.318108]  el0_svc_compat_handler+0x2c/0x38
> [  338.322588]  el0_svc_compat+0x8/0x18
> [  338.326274] Code: f94066c8 aa1f03e0 321d03e9 321c03ea (f9401d0b)
> [  338.332538] ---[ end trace 5c09e60869887d87 ]---
> [  338.354633] Kernel panic - not syncing: Fatal exception
> [  338.360018] SMP: stopping secondary CPUs
> [  338.364179] Kernel Offset: disabled
> [  338.367779] CPU features: 0x0,22802a18
> [  338.371643] Memory Limit: none
> ------
> 
>  drivers/gpu/drm/drm_prime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 231e3f6d5f41..aa87ba9c0d7b 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -945,7 +945,7 @@ int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page **pages,
>  
>  	index = 0;
>  	for_each_sg(sgt->sgl, sg, sgt->nents, count) {

I thought Christoph is creating a new macro to iterator over the mapped
sg, which needs to be used here instead of for_each_sg (which is only
valid for iterating over the cpu side mapping/struct page).
-Daniel
> -		len = sg->length;
> +		len = sg_dma_len(sg);
>  		page = sg_page(sg);
>  		addr = sg_dma_address(sg);
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
