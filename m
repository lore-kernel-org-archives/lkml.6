Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D5FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4932077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="gkQUddj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4932077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeIDPVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:21:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35269 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbeIDPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:21:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id q13-v6so2589743lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3iA8kd0k/kr1AgS5dW+X8+LIGFy1fTeIHLBrzV8TdfU=;
        b=gkQUddj957WZ648RiMzY6OH+K8yf0Y0q27gcKKPzd+Lvv9T73nkdj5bPyuMr+aAekz
         2IRxnEcLqul5aVR+iDNq3WBDFucGJAUCpEMB5GBY6FGvrVTgGX9YYM1iQOvWUIdqfg5I
         ErY8YOCRMGwZs7sbzo7rQ7trBQip9wAkKNkrlen8UUNZ+xl+mfhMix3OLzhiBeXkLEoc
         qF553Tyc3OXnd79G7uRvxCdxQSe73w9WaYvi9WMUIA8IK+1oMzJewEPTz6Xe7At1xI6Q
         rRNyTxLZ2Ie57F47/EjZYne0zPafKTCWELcnQhFGRYWtZMa/ZrpiRZfGebNa59bNcRWH
         qiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3iA8kd0k/kr1AgS5dW+X8+LIGFy1fTeIHLBrzV8TdfU=;
        b=lKz1SjNz/1WX2G5hJJUHBWpXcPWuFQxi6LbBrTo0wq2YUplOp9kv9MDnXntEX9HYF6
         vjYyAt5DKuEWyotI8RnFGwcZDrt/JU3PaBr6hXbJjSEHql8DEGZ45U3Xir8KteOtZhAh
         L/3k0ytUwstp61Oa8pzQDNFTewlBWvndHPB3bK0OuVWkyitt7RzRqmmDBDtvJblioMOv
         H2w3Du0jAUS0B9WhwQyisE5uuCFR175OMZsLaoxC/0hEMH4waZyOG6s9l7m6QQBJAIE6
         Fsu5sfaCMXD9IA8icQYvOS2ALZUhbZKXyRnLhaMtuyDQCGBLwANnlVV9gOwgsIion+jQ
         KjsQ==
X-Gm-Message-State: APzg51DXwGRd/LLWkN/1sd+M/ObVeTNzvEXMxANQrMagQFGDOj2Uc4QL
        mMrnStBYVefYVOu6s5iXSkWOPw==
X-Google-Smtp-Source: ANB0VdbuK3dBjulJxs+94TwM4Rs0jIa12KJRU4AEn7Hh8CFUp5BdL4rd8ovLG/ajZtn69LYpwMAgtw==
X-Received: by 2002:a19:129e:: with SMTP id 30-v6mr19770281lfs.29.1536058620648;
        Tue, 04 Sep 2018 03:57:00 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id r63-v6sm3963967lja.18.2018.09.04.03.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 03:56:59 -0700 (PDT)
Subject: Re: [PATCH V3] lightnvm: pblk: fix mapping issue on failed writes
To:     hans.ml.holmberg@owltronix.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1536057487-17267-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1536057487-17267-2-git-send-email-hans.ml.holmberg@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f3178168-f516-5ac5-efa8-915bdf25b36e@lightnvm.io>
Date:   Tue, 4 Sep 2018 12:56:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1536057487-17267-2-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 12:38 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> On 1.2-devices, the mapping-out of remaning sectors in the
> failed-write's block can result in an infinite loop,
> stalling the write pipeline, fix this.
> 
> Fixes: 6a3abf5beef6 ("lightnvm: pblk: rework write error recovery path")
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> 
> Changes in V2:
> 	Moved the helper function pblk_next_ppa_in_blk to lightnvm core
> 	Renamed variable done->last in the helper function.
> 
> Changes in V3:
> 	Renamed the helper function to nvm_next_ppa_in_chk and changed
> 	the first parameter to type nvm_tgt_dev
> 
>   drivers/lightnvm/pblk-write.c | 12 +-----------
>   include/linux/lightnvm.h      | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 5e6df65d392c..9e8bf2076beb 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -106,8 +106,6 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
>   /* Map remaining sectors in chunk, starting from ppa */
>   static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
>   {
> -	struct nvm_tgt_dev *dev = pblk->dev;
> -	struct nvm_geo *geo = &dev->geo;
>   	struct pblk_line *line;
>   	struct ppa_addr map_ppa = *ppa;
>   	u64 paddr;
> @@ -125,15 +123,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
>   		if (!test_and_set_bit(paddr, line->invalid_bitmap))
>   			le32_add_cpu(line->vsc, -1);
>   
> -		if (geo->version == NVM_OCSSD_SPEC_12) {
> -			map_ppa.ppa++;
> -			if (map_ppa.g.pg == geo->num_pg)
> -				done = 1;
> -		} else {
> -			map_ppa.m.sec++;
> -			if (map_ppa.m.sec == geo->clba)
> -				done = 1;
> -		}
> +		done = nvm_next_ppa_in_chk(pblk->dev, &map_ppa);
>   	}
>   
>   	line->w_err_gc->has_write_err = 1;
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 09f65c6c6676..36a84180c1e8 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -593,6 +593,42 @@ static inline u32 nvm_ppa64_to_ppa32(struct nvm_dev *dev,
>   	return ppa32;
>   }
>   
> +static inline int nvm_next_ppa_in_chk(struct nvm_tgt_dev *dev,
> +				      struct ppa_addr *ppa)
> +{
> +	struct nvm_geo *geo = &dev->geo;
> +	int last = 0;
> +
> +	if (geo->version == NVM_OCSSD_SPEC_12) {
> +		int sec = ppa->g.sec;
> +
> +		sec++;
> +		if (sec == geo->ws_min) {
> +			int pg = ppa->g.pg;
> +
> +			sec = 0;
> +			pg++;
> +			if (pg == geo->num_pg) {
> +				int pl = ppa->g.pl;
> +
> +				pg = 0;
> +				pl++;
> +				if (pl == geo->num_pln)
> +					last = 1;
> +
> +				ppa->g.pl = pl;
> +			}
> +			ppa->g.pg = pg;
> +		}
> +		ppa->g.sec = sec;
> +	} else {
> +		ppa->m.sec++;
> +		if (ppa->m.sec == geo->clba)
> +			last = 1;
> +	}
> +
> +	return last;
> +}
>   
>   typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
>   typedef sector_t (nvm_tgt_capacity_fn)(void *);
> 

Thanks. Applied for 4.20.
