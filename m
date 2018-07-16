Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921CDECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43190208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+NEjSGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43190208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeGPW7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:59:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42734 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbeGPW7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:59:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so8011601pgp.9;
        Mon, 16 Jul 2018 15:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3LCBQukFGsv7pauFjoa3wVWBHgP7axdu3xwNudgBOKw=;
        b=Z+NEjSGBXUghub3usZwsJskptsjZeNoepsfK7jCP6L9FKRlUwvY/MQuDl9sfoNCPO0
         K84KziD/VfJ3waoho0oymSp2WVDyU8eAkim5m++DqacqIr0qjPIgdpeZBcOoP3dGoBtA
         lyO/BresJWEtm+NKR6Xt3jeLeBmAbg+KWvYAcDJLkGum83BslkALJ3QmtDA3lf0kDc6X
         U54HPAtkXkOR/bZrMKEpOhgR7B1IBdXudVnClOBpkSBhauLoGjxgqUTVH8vb37j7skMD
         Ort9UALUkxDGGCal3YZkaODsBjvviUg3NU4fWl6F3KOEQxIUg8F1y0aogQCvB6UDkgfL
         YUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3LCBQukFGsv7pauFjoa3wVWBHgP7axdu3xwNudgBOKw=;
        b=o8r48yS9TRn4G/6Yk3ocGN2SOWJ9NvFz6gMISQd/5AO2iRf1sLKiF6Z86YDw/Fnjxq
         iaXTEUrPI3vkhqm69PCWotvIT50nXOJI8GFKYbSATG7Asnzp+a5YiH230HW13AW9I0QB
         dHwERuJDfiCX6cXKoDCb6dNrzsZ6BuGURuWYfNzMjl0sRs0iPUYe6cW1tHZiddUUDXIM
         prxj0tjrVlYXl+GaFawiPMx+kRMxR7WA9NCXhG7eA6VU+hT4/LwZ2wUSksUcHcp3wKc0
         oSOkNuIecGqdPUagjym08mwQ3hPTefL7clzV+4AFz4eirlI057ZDMn5slhS5q/XiIOoi
         i76g==
X-Gm-Message-State: AOUpUlEv642D4DuvyQ554ZLziDU7uIX4TK1PLMZNwXmu7/F4jvNXToPk
        HFlUGiX9tmLcizkkvggZmRiAl9Xa
X-Google-Smtp-Source: AAOMgpfLn3lmfSAGkQkHjVY08jpEnnxE6Qm/2d+H2QxK5hfPiRajo4V3IVenQv+/Dyg9kpJFVSi4kg==
X-Received: by 2002:a62:5dd7:: with SMTP id n84-v6mr19914575pfj.68.1531780207300;
        Mon, 16 Jul 2018 15:30:07 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::7:3f88])
        by smtp.gmail.com with ESMTPSA id a25-v6sm45161458pgv.51.2018.07.16.15.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 15:30:06 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:30:04 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eddie Hao <eddieh@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: allow BPF programs access skb_shared_info->gso_segs
 field
Message-ID: <20180716223003.fvh6edj3zlfegy52@ast-mbp.dhcp.thefacebook.com>
References: <20180715084524.181717-1-eddieh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715084524.181717-1-eddieh@google.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 01:45:24AM -0700, Eddie Hao wrote:
> This adds the ability to read gso_segs from a BPF program. This is useful
> for user space monitoring systems to get gso_segs statistics for each
> arbitrary group of flows defined by the BPF program.
> 
> Signed-off-by: Eddie Hao <eddieh@google.com>
> ---
>  include/uapi/linux/bpf.h | 1 +
>  net/core/filter.c        | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index b7db3261c62d..282085445616 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2266,6 +2266,7 @@ struct __sk_buff {
>  	/* ... here. */
>  
>  	__u32 data_meta;
> +	unsigned short gso_segs;

'short' will make it harder to extend due to struct hole.
please use __u32 instead.

>  };
>  
>  struct bpf_tunnel_key {
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b9ec916f4e3a..f17e249f3fbb 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5820,6 +5820,15 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
>  				      bpf_target_off(struct sock_common,
>  						     skc_num, 2, target_size));
>  		break;
> +
> +	case offsetof(struct __sk_buff, gso_segs):
> +		BUILD_BUG_ON(FIELD_SIZEOF(struct skb_shared_info, gso_segs) !=
> +					  sizeof(unsigned short));
> +		off = offsetof(struct sk_buff, end);
> +		off += offsetof(struct skb_shared_info, gso_segs);

did you test this patch?
Above math doesn't look correct.
NET_SKBUFF_DATA_USES_OFFSET is not handled. At least one more LDX is needed.

> +		*insn++ = BPF_LDX_MEM(BPF_SIZEOF(unsigned short), si->dst_reg,
> +						 si->src_reg, off);

I think BUILD_BUG_ON is a bit of overkill when BPF_LDX_MEM
can use BPF_FIELD_SIZEOF(struct skb_shared_info, gso_segs) instead.

