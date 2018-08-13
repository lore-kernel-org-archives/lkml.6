Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC00C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C96721834
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/acIf6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C96721834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeHMIqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 04:46:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34471 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeHMIqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 04:46:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so7217413pfi.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 23:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NgqI7NmL/YwS2MzymNgvmM/sZcx3w6s1jpN1cR7LOD8=;
        b=s/acIf6Xop4xlMCNXjNk/eoWk2FMyRTS7oTNMvcpdpJknjJew+sy3AfixYAhfs4MdN
         S5JpZbDE+7BMWECmVZhPMDpjfbkYhdNTVSMJ5Hqx2LghkYB9TE8w2L0v09fsrVwHOzgR
         JGEhHjkRD9EyE2D0MMt+k3QzmXBSNHhujlTGzAqKHFGRPuRQ6+cFej3fmzPRNIWTOmMf
         Ainoo25sxAfqkw3UogxKl0PFkGgI0htlTTUWMp42YtenErlv8hfw160sn2MjSs0hevO9
         XODmeP2p86W90Qd9XwH9k/KTXDzRZVanlCuotZxOrNoSbS3UYhXWYaprS/3xqVOiVGWA
         BPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NgqI7NmL/YwS2MzymNgvmM/sZcx3w6s1jpN1cR7LOD8=;
        b=jVGJ8dmrk+TpZ9aofyijPrYDxTGk52QTPLEh1YAbs3ziXOynadFSp1PsSNlC2dtOE/
         nem+QK0Ipp4+PI1VhLWvVoqw7sWSkZty9mk0UPj5fchcmaAONOo2k0R4g0iK5YJAdCnF
         /gGCbuUt4xrnmgQ+zZlERZUvxDL7EsLuyjsZMDyR9hlHA8nijeku4FPK9qRyOOIbp4A/
         kPiEEmJgYPIe35Dqs5TBjaO4UPL+qJzRm0+OMStgHObLu19ZrEa2o+viyx8ryt1iw0IP
         Am7o0g87/pQ/ZzkurU652wz0FrdKSPDTu1XzJq+S2+TDFKg1OR6t5zw4rl+KK82WiyM+
         l1aQ==
X-Gm-Message-State: AOUpUlEaw5Pp7K+AfUag6yWSJNMFXVuIMvFvJyEo5k/MjgiYaz+rVGKW
        uYr48hEzD6goyyxGDeGmLYA=
X-Google-Smtp-Source: AA+uWPx9JhEaRnmLmvV+xXSLP5VU1EuL7XuZB+p1Bup5SiF49DiGtIvsrGkUUY98twIzFtXxMdR76g==
X-Received: by 2002:a62:444d:: with SMTP id r74-v6mr17513908pfa.96.1534140355363;
        Sun, 12 Aug 2018 23:05:55 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id d19-v6sm45466340pfm.48.2018.08.12.23.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Aug 2018 23:05:53 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:05:49 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     zhouxianrong <zhouxianrong@tom.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        zhouxianrong <zhouxianrong@huawei.com>
Subject: Re: [PATCH] zsmalloc: fix linking bug in init_zspage
Message-ID: <20180813060549.GB64836@rodete-desktop-imager.corp.google.com>
References: <20180810002817.2667-1-zhouxianrong@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810002817.2667-1-zhouxianrong@tom.com>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 09, 2018 at 08:28:17PM -0400, zhouxianrong wrote:
> From: zhouxianrong <zhouxianrong@huawei.com>
> 
> The last partial object in last subpage of zspage should not be linked
> in allocation list. Otherwise it could trigger BUG_ON explicitly at
> function zs_map_object. But it happened rarely.

Could you be more specific? What case did you see the problem?
Is it a real problem or one founded by review?

Thanks.

> 
> Signed-off-by: zhouxianrong <zhouxianrong@huawei.com>
> ---
>  mm/zsmalloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 8d87e973a4f5..24dd8da0aa59 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1040,6 +1040,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
>  			 * Reset OBJ_TAG_BITS bit to last link to tell
>  			 * whether it's allocated object or not.
>  			 */
> +			if (off > PAGE_SIZE)
> +				link -= class->size / sizeof(*link);
>  			link->next = -1UL << OBJ_TAG_BITS;
>  		}
>  		kunmap_atomic(vaddr);
> -- 
> 2.13.6
> 
