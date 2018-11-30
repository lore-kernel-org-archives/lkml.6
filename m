Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA66C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BD42082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BD42082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeLAGZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:25:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38785 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeLAGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:25:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so3265599pfi.5;
        Fri, 30 Nov 2018 11:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vYb92S/GcmfL6XS+gSva3HzX8uaPNAM/HRbC270QUzw=;
        b=BkDOytqWiu/sNHpuUTtJfZXdrh5thCAFBCrf0fTy2s2rM6Xpuq4jCo6PSvpl5DuXER
         hnyjutHEBrW/L8Z85sy+Vkey8zjDuCaRYp2BrYC4c+EOHropHWFVoG+VxBM7nXwkUGgh
         iLF2cGL8FbstMGHWcWkCRODA82cNoi+cFEpZWlnuKFmX2rj4lL/UmwYe4u1yATCGYAEv
         OnIe1VujCTHSsRF8WBy4waWNg8jz282tWlnyGxk824BcatOc1mW2WdHhHHW4hI8dadof
         nO8cWb4Ou9TZ4DW0YrHbPM1loIBi64gjntJALijOKSbnah/E0BnEu2INnswkR7o5MX+9
         i4Aw==
X-Gm-Message-State: AA+aEWaJsGlKy+tx5ZCoR0XJq6NHc4hk6PG5YLwJUDqGy5vksRbub9G7
        mIO+P+vq3+KYkZ8JT21adGPyc79l
X-Google-Smtp-Source: AFSGD/UaHbJVDcySev32hSuFmuO8HQcHELeGIh7hi2rzEYCKWX6JIoLTSu0L1QJv4kihVJU0z5+EVg==
X-Received: by 2002:a62:5884:: with SMTP id m126mr6757099pfb.177.1543605300922;
        Fri, 30 Nov 2018 11:15:00 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id w80-v6sm8824597pfk.11.2018.11.30.11.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 11:14:59 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Fri, 30 Nov 2018 11:14:56 -0800
Date:   Fri, 30 Nov 2018 11:14:56 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Cheng Lin <cheng.lin130@zte.com.cn>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn
Subject: Re: [PATCH] proc/sysctl: fix return error for proc_doulongvec_minmax
Message-ID: <20181130191456.GX18410@garbanzo.do-not-panic.com>
References: <1543559717-27534-1-git-send-email-cheng.lin130@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543559717-27534-1-git-send-email-cheng.lin130@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cheng, thanks for the patch!

On Fri, Nov 30, 2018 at 02:35:17PM +0800, Cheng Lin wrote:
> If the number of input parameters is less than the total
> parameters, an INVAL error will be returned.

Do you mean EINVAL?

> This patch ensure no error returned in this condition, just
> like other interfaces do.

Have an actual example to reproduce?

  Luis

> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> ---
>  kernel/sysctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 5fc724e..9ee261f 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2779,6 +2779,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
>  			bool neg;
>  
>  			left -= proc_skip_spaces(&p);
> +			if (!left)
> +				break;
>  
>  			err = proc_get_long(&p, &left, &val, &neg,
>  					     proc_wspace_sep,
> -- 
> 1.8.3.1
> 
