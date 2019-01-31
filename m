Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25446C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D504B20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3u6ldJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfAaBRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:17:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43739 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfAaBRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 20:17:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so666034plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 17:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+T0i8D/OYhIdAi97ABUp5amjBv88qnhqoOStggACu6E=;
        b=E3u6ldJ6aYs3NP7ahqKZ5eKmWKrmhrHhrdft98bI1oI3AXdc5OBhJdMNtcVKufzvOD
         xY4jINrlLg88HdAdvxjE+NXES0mJENixQceZxOgaCxMrMD6KbjL996nCe/Y/ixzpJQue
         1Zei8hMFc8FrHP3ZSsEsf9cuWFSi9t+t/+q/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+T0i8D/OYhIdAi97ABUp5amjBv88qnhqoOStggACu6E=;
        b=m9jUxZD/lF/qLjqJ+uoRDeqKzo3fnegRJfY/1feqDlYO8qBNvYFCg3mkBuOiK/Tmy+
         RvhfQ4U0Qzc97CFQMDTeKRAEpPqE0xC43OSiOObZdo1IoDK9cnBhqFBMdkSN816HckM3
         FK0vqqlD/J3G9VK69jQ5V0+w8t1mtc/qtu6NGi0BoPvarydGIagrVYMhNRD6oHkEF3lk
         3ShMJpeiI09lQ1zt0bb/wCpU7Tp2tntjSlATwc5ssl8zVccOADABJyy+wgw7OMRlNhTA
         mVefzYmNrYMJw4h1pOWWKf/1uAuJ4g2yLShy6aWppP/nxi3tuAfrGwkO4umWxIJN8+hY
         e6hg==
X-Gm-Message-State: AJcUukepgIYeRzsWPgp8dLmMxtv/5bHt44QI64eENCWV+6FhKl2/Zexf
        rkLdBrg3SaOdy/WMkw+HzLNgeOjPMVY=
X-Google-Smtp-Source: ALg8bN7g7HO/DmmbfdqOmx5bI6t5JTCno1LDxbWZpGASEKW+vBhFLl9A/nRald5SfYxQ7ccslItl9Q==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr32761014plk.203.1548897424949;
        Wed, 30 Jan 2019 17:17:04 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n78sm4873466pfk.19.2019.01.30.17.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 17:17:04 -0800 (PST)
Date:   Wed, 30 Jan 2019 17:16:49 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        rohitkr@codeaurora.org
Subject: Re: [PATCH] qcom: apr: Make apr callbacks in non-atomic context
Message-ID: <20190131011649.GA27190@builder>
References: <20181115184904.27223-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115184904.27223-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15 Nov 10:49 PST 2018, Srinivas Kandagatla wrote:

> APR communication with DSP is not atomic in nature.
> Its request-response type. Trying to pretend that these are atomic
> and invoking apr client callbacks directly under atomic/irq context has
> endless issues with soundcard. It makes more sense to convert these
> to nonatomic calls. This also coverts all the dais to be nonatomic.
> 

Hi Srinivas,

Sorry for not looking at this before.

Are you sure that you're meeting the latency requirements of low-latency
audio with this change?

[..]
> @@ -303,6 +363,10 @@ static int apr_remove_device(struct device *dev, void *null)
>  
>  static void apr_remove(struct rpmsg_device *rpdev)
>  {
> +	struct apr *apr = dev_get_drvdata(&rpdev->dev);
> +
> +	flush_workqueue(apr->rxwq);
> +	destroy_workqueue(apr->rxwq);

The devices may still be communicating until you remove them on the next
line, wouldn't it make more sense to destroy the work queue after
removing the APR devices?

>  	device_for_each_child(&rpdev->dev, NULL, apr_remove_device);
>  }

Regards,
Bjorn
