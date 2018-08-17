Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840E8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03C221914
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="oB+t2JlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03C221914
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeHQNkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:40:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41160 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeHQNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:40:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so656656pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 03:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8TKfAW2T/4PTYZ2VZ2BQ2RUhFB66lw9H+B02oa5Oxh4=;
        b=oB+t2JlSpGmN0/vUUL6pBZXTf+OgWb5iuBnp1TzUITcZcIJtaeKto+18YMie3i2TcQ
         BfT41EWjUnm0YQvfKKYXiaXBrZn6JoBwz8Dg2MWJYXxpHIrheCjb3N563j7yaqv01w4q
         onna90rv977DVY7IwviUjRo6TuKNcII/Vr4eMo1d0QnAGObDiJs/wANrPCJZKX//4DFH
         qB4jScjZRz3JPhirNgnglA4VFUJRAFxar9u2QZmE47k62efS3xM3y8D55w8O3MATbl8j
         mEw+XK4RCktx3e0bwPs3F/JY6L+3hgmGaaupjVjiyiXmlTDIQ6h+N8knlVR0o8J7Fodj
         /MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8TKfAW2T/4PTYZ2VZ2BQ2RUhFB66lw9H+B02oa5Oxh4=;
        b=lAO5TjWfTvWGBTAUG3OeOsjHMYEXOtmcPJU5q9cTa+DDD+gWiRcVzo2q/D2ldl7J2J
         PdaMPvynXhghHpSmnwAphCwQa5IqAuz5A6BDcvAU+ePTWqRVjY8C6UfFjQHYgWRUrRlF
         9juck7n0XgQnVUSeTUPw7dSv80La2DRafP9qNLbcZE8yMQ4KBHLhNnNVw7tBZeoiNO+i
         BtA5C8iFubEM2pYFPayAnQV4ZnmGEdw9sQziQAGFFc34zn7wwH+v4J5s28hMk0wYVG6a
         cKe6ThMeSefkBbr0dqe2Kt5fwwZpRH4c983pMm1GknvX3R5RUquTLXfPB8qx0PReZoLy
         KFsQ==
X-Gm-Message-State: AOUpUlFXzCHEQXDA4mCq+Kdwj4P9qqyxAqs7+L8XvvEnicm3Pd9A2uNB
        Sv7dSsqdHpwoPvjl7SmYsN/fEg==
X-Google-Smtp-Source: AA+uWPxk2+Yg5kKk4dqq8CTYlmEajq1H2ns1kdvsag5SDIzaYTW2SJFDpQDtulyOy9+Tk0aG7hBrFA==
X-Received: by 2002:a63:8e41:: with SMTP id k62-v6mr32008014pge.187.1534502226719;
        Fri, 17 Aug 2018 03:37:06 -0700 (PDT)
Received: from [10.86.58.199] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id a81-v6sm3965825pfa.152.2018.08.17.03.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 03:37:05 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: fix race condition on metadata I/O
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1534501324-13693-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <fbe93d3b-31d5-608c-e9fc-c77510763462@lightnvm.io>
Date:   Fri, 17 Aug 2018 12:37:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1534501324-13693-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 12:22 PM, Javier González wrote:
> In pblk, when a new line is allocated, metadata for the previously
> written line is scheduled. This is done through a fixed memory region
> that is shared through time and contexts across different lines and
> therefore protected by a lock. Unfortunately, this lock is not properly
> covering all the metadata used for sharing this memory regions,
> resulting on a race condition.
> 
> This patch fixes this race condition by protecting this metadata
> properly.
> 
> Fixes: dd2a43437337 ("lightnvm: pblk: sched. metadata on write thread")
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-write.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 508c63701eda..df99c45778d4 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -417,12 +417,11 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
>   			rqd->ppa_list[i] = addr_to_gen_ppa(pblk, paddr, id);
>   	}
>   
> +	spin_lock(&l_mg->close_lock);
>   	emeta->mem += rq_len;
> -	if (emeta->mem >= lm->emeta_len[0]) {
> -		spin_lock(&l_mg->close_lock);
> +	if (emeta->mem >= lm->emeta_len[0])
>   		list_del(&meta_line->list);
> -		spin_unlock(&l_mg->close_lock);
> -	}
> +	spin_unlock(&l_mg->close_lock);
>   
>   	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>   
> @@ -491,14 +490,15 @@ static struct pblk_line *pblk_should_submit_meta_io(struct pblk *pblk,
>   	struct pblk_line *meta_line;
>   
>   	spin_lock(&l_mg->close_lock);
> -retry:
>   	if (list_empty(&l_mg->emeta_list)) {
>   		spin_unlock(&l_mg->close_lock);
>   		return NULL;
>   	}
>   	meta_line = list_first_entry(&l_mg->emeta_list, struct pblk_line, list);
> -	if (meta_line->emeta->mem >= lm->emeta_len[0])
> -		goto retry;
> +	if (meta_line->emeta->mem >= lm->emeta_len[0]) {
> +		spin_unlock(&l_mg->close_lock);
> +		return NULL;
> +	} >   	spin_unlock(&l_mg->close_lock);
>   
>   	if (!pblk_valid_meta_ppa(pblk, meta_line, data_rqd))
> 

Thanks. Applied for 4.20.

