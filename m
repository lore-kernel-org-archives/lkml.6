Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9990C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718C8223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Clge9vzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718C8223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbeKODzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:55:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35503 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731710AbeKODzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:55:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id v1-v6so989299plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 09:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b3MjNoU0UPI6VWMJ89AAtqeA8doEnco2Qgey8bN9S/w=;
        b=Clge9vzO8HL2nVVtTsAXOgWyuJntfrg/GdbxJcTfbUcaWBNaA6cxgPqzx///SpzgCK
         LJlZOQsUh0esX0lOzhp8p+sOWUTzUZEyMJPSELDKAkU2LgZCTPbH/tkV+W39YdxkHaR3
         Sk6vN6j+L/eRl8JXo64plOT7gWiVXmM6R6pRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b3MjNoU0UPI6VWMJ89AAtqeA8doEnco2Qgey8bN9S/w=;
        b=sXcBucIv+07Ifdu5LPemgV3A5P5rwVWQ1bSsWXFziWxo4KPpc2e5AjDg9Ov++PO2jW
         WotYwDjWVF0SdJK4DplsRam0IiUHOUKaT9H5e6hyApsAwX1cAQ3+9KdQmJVe1K/FyhM0
         HvOxn/n4nzeomiPZJHOjKKbcmZMtxcbmMy52z/1wHTuIiYmzknmzgc8UeDaVayfoz4U8
         NUofNRjxXDd7X3kYmDKskoHZ+IZfzUut2j/0iGqq3rOoSXVRw38aJdSVklE5GAy2LrPZ
         SzDZlc/Yka87+TEP7bPDiNxg3FtwcTW9lr2gpWtgb5YeJldRmiFbuwXwb7b4kBi4AxzZ
         kctw==
X-Gm-Message-State: AGRZ1gJWCTJwp23IbqK2ILxP01bzh+pFXKibdwR5VGVa3Vwinzr9G5YY
        7ICg66wJbhcyKEOhMGPMlwKUHw==
X-Google-Smtp-Source: AJdET5csRLyMBxJH+m5A90enO5inoT+BRAnYjZf45BpyUinkM/AzeSs4CdB/Meilf9lzpuIaXfIiJQ==
X-Received: by 2002:a17:902:846:: with SMTP id 64-v6mr2733126plk.70.1542217862481;
        Wed, 14 Nov 2018 09:51:02 -0800 (PST)
Received: from localhost ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id s2-v6sm53791699pfk.133.2018.11.14.09.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:51:01 -0800 (PST)
Date:   Wed, 14 Nov 2018 09:51:00 -0800
From:   Andy Gross <andy.gross@linaro.org>
To:     Alok Chauhan <alokc@codeaurora.org>
Cc:     swboyd@chromium.org, dianders@chromium.org, dkota@codeaurora.org,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: Add irq clear handling during SE init
Message-ID: <20181114175100.GB14703@hector>
References: <1538569430-32374-1-git-send-email-alokc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538569430-32374-1-git-send-email-alokc@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 05:53:50PM +0530, Alok Chauhan wrote:
> when the kernel inits a SE, its quite possible we have pending interrupts
> from bootloaders which did not handle/clear them. So do this in kernel at
> the SE init, to avoid some of it causing bad behavior, while at it also
> club all the register writes needed to clear the se irqs into a function
> to avoid repeating it over.
> 
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---

Thanks for sending this in.  I'll apply to my queue.

Andy
