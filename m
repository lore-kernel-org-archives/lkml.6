Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9330FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A9A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KtYrdccD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeLRJQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:16:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42684 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeLRJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:16:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so7526116pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 01:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mRBP5b6j9konoMQH1hOnXFVpnTs8fXI/VlIUhW+e60s=;
        b=KtYrdccDepih9iVW6S+0DWW9ODLDbZzZbbQW17xlOw4QI2pIvWnprH138lKWl9n14r
         lyFVgiblDSb0E1n1AIipTCZSCsGALQC2un/c5bDdcE5G14yQLfgPN5XQic2w1vl6hd5o
         9A9cB/viM7KCgsCJrrq+MJH7UHQ1xf64x7Q4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mRBP5b6j9konoMQH1hOnXFVpnTs8fXI/VlIUhW+e60s=;
        b=p31mz7RbfR0P6TkkC2kbvUDs1xR7KasBTX+XPkHrhm8PzaRLNQ7+okXzhLJuLJzKzs
         yn0OHAXZk/Ey3xk0RAznjzTKFjW0gjHMf/GA6Lr4nnUnQWiV7K5dGAtMStQCAyIOg/yn
         1T6x0Wd7Ip5jB96SKnnhuYW43XFKGFHd/BUw6IiGPazNhMigN69+93cYf/v5UbSa3EEG
         nUl32ejqsJpAWg0vE1qTiu3Q+VLw6cN/sN/CMZ7Wl4v8WRbDExxwVhhyhkMEHuiS6vXZ
         2j7Pybrui4dG5I5nBe+GsKCtVZIgKwKyYBwZhri/9ZhP1L7wEHzLzrp3q/anMkoCI3/y
         Lh4g==
X-Gm-Message-State: AA+aEWa21EGRvLwZ2h0+fqI+mpwniz48DnyXbbHzhedAKnJ2YUYI0JoR
        e44J88VVHnHwZVrzcidlhCX3kg==
X-Google-Smtp-Source: AFSGD/WV1Uo/XWaqvd6twRUtZt/B2ZiNsshRVnN4abPGExTXEp5E7vW+C/chFNroNX/v2p6pRDDXbQ==
X-Received: by 2002:a62:8a51:: with SMTP id y78mr15746431pfd.35.1545124572952;
        Tue, 18 Dec 2018 01:16:12 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li547-117.members.linode.com. [198.74.50.117])
        by smtp.gmail.com with ESMTPSA id u186sm24852313pfu.51.2018.12.18.01.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 01:16:12 -0800 (PST)
Date:   Tue, 18 Dec 2018 17:16:07 +0800
From:   leo.yan@linaro.org
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Kevin Wangtao <kevin.wangtao@hisilicon.com>,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Ruyi Wang <wangruyi@huawei.com>
Subject: Re: [PATCH v2 06/19] mailbox: hi3660: Use device-managed
 registration API
Message-ID: <20181218091607.GB1475@leoy-ThinkPad-X240s>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
 <20181217150217.32435-7-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217150217.32435-7-thierry.reding@gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 04:02:04PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Get rid of some boilerplate driver removal code by using the newly added
> device-managed registration API.

Tested-by: Leo Yan <leo.yan@linaro.org>

> Cc: Kevin Wangtao <kevin.wangtao@hisilicon.com>
> Cc: Kaihua Zhong <zhongkaihua@huawei.com>
> Cc: Ruyi Wang <wangruyi@huawei.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mailbox/hi3660-mailbox.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
> index f9aed5d8f9f1..53f4bc2488c5 100644
> --- a/drivers/mailbox/hi3660-mailbox.c
> +++ b/drivers/mailbox/hi3660-mailbox.c
> @@ -265,7 +265,7 @@ static int hi3660_mbox_probe(struct platform_device *pdev)
>  	for (ch = 0; ch < MBOX_CHAN_MAX; ch++)
>  		chan[ch].con_priv = (void *)ch;
>  
> -	err = mbox_controller_register(&mbox->controller);
> +	err = devm_mbox_controller_register(dev, &mbox->controller);
>  	if (err) {
>  		dev_err(dev, "Failed to register mailbox %d\n", err);
>  		return err;
> @@ -276,17 +276,8 @@ static int hi3660_mbox_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int hi3660_mbox_remove(struct platform_device *pdev)
> -{
> -	struct hi3660_mbox *mbox = platform_get_drvdata(pdev);
> -
> -	mbox_controller_unregister(&mbox->controller);
> -	return 0;
> -}
> -
>  static struct platform_driver hi3660_mbox_driver = {
>  	.probe  = hi3660_mbox_probe,
> -	.remove = hi3660_mbox_remove,
>  	.driver = {
>  		.name = "hi3660-mbox",
>  		.of_match_table = hi3660_mbox_of_match,
> -- 
> 2.19.1
> 
