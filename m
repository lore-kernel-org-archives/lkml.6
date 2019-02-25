Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C53C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BB62147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551107617;
	bh=X1o4Do49B4s7JQLjwNHy2WVN46vY77vwss98ExeK4tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RkdkAcdrnvpKiP25N0ba0XLlT9ibLqNFZO5dRzrNqxx2/UZMMBKdjGCoKgx2j0zCf
	 nvEZP+pILSMuck0N4abYSLQ5hq11j9qwMequufMim6XFW5zg3tz3fKlZ1mWav40Xpu
	 P9Yb68WK7ljqP+YWh1ETd4xhMkzI8mDlNfP86O5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfBYPNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:13:35 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44267 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfBYPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:13:34 -0500
Received: by mail-yb1-f193.google.com with SMTP id c3so1550171ybo.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 07:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mLOpBX/5F2G/oYRLBjL46VTONps8ne40eaQPtNsdmSA=;
        b=cR3IzGgOEBkAEcKo+/En8Pk9gWVlz9p3DNZDWTalgUqQBIXHudd8GE66XnI6/3jdE8
         Z+dcFCYhOLYiIYN17NSIP1osOnWM1pNZY8Ym1IPo1Rpjp+y2Uo4jAjRWchTgAU/htfKY
         CYlLGlFCtI1BOI3ObyYcOeVRZ7NPF2W6rlb5PwC/tRvKwHrr2OP1r9ITnFQK3AglYwz4
         M9U+L+vpZFb1SO2KL5fNH5VolKRGbzdYwvRZ/DPG+kisKghMg70rjlhp5A9QDrQOkqxJ
         CKsXLk56OKIIUIs5hyYiBEwEhmwcLHP07zPIwrxurxD00ms/FFiFrW5LCvtof+mQySJc
         rsxQ==
X-Gm-Message-State: AHQUAuZmo6N/keKCOke2gn1WeWD9l6fZ6Y6Tkj3iC/oTlnKZB2Bd66JJ
        709JEBKIAwPA3HFxPv8OjUc=
X-Google-Smtp-Source: AHgI3IbBIanNK2b3dpslqnh41Yv7lJlDw1srmmXUhrXwKis2NIknvuv1xT3UKPK34/bm430n1JCdCw==
X-Received: by 2002:a25:2044:: with SMTP id g65mr14459634ybg.406.1551107613278;
        Mon, 25 Feb 2019 07:13:33 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::1:8bb9])
        by smtp.gmail.com with ESMTPSA id g39sm3766859ywk.50.2019.02.25.07.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 07:13:32 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:13:30 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 1/2] percpu: km: remove SMP check
Message-ID: <20190225151330.GA49611@dennisz-mbp.dhcp.thefacebook.com>
References: <20190224132518.20586-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224132518.20586-1-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 01:13:43PM +0000, Peng Fan wrote:
> percpu-km could only be selected by NEED_PER_CPU_KM which
> depends on !SMP, so CONFIG_SMP will be false when choose percpu-km.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  mm/percpu-km.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/percpu-km.c b/mm/percpu-km.c
> index 0f643dc2dc65..66e5598be876 100644
> --- a/mm/percpu-km.c
> +++ b/mm/percpu-km.c
> @@ -27,7 +27,7 @@
>   *   chunk size is not aligned.  percpu-km code will whine about it.
>   */
>  
> -#if defined(CONFIG_SMP) && defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
> +#if defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
>  #error "contiguous percpu allocation is incompatible with paged first chunk"
>  #endif
>  
> -- 
> 2.16.4
> 

Hi,

I think keeping CONFIG_SMP makes this easier to remember dependencies
rather than having to dig into the config. So this is a NACK from me.

Thanks,
Dennis
