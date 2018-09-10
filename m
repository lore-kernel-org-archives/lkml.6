Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F06AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF98E20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MM4ZK2pI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF98E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeIJUqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:46:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32800 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbeIJUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:46:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so22552163wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8EeKXBON8xQVA6CfI6kp2c6HMR7hgcWpIcCFwO21CyM=;
        b=MM4ZK2pIT3j2XD159QuD1DZ35uHCDLACGGeqPuVcEsfccIde+k5Ncy9ngFX6UwTN1F
         NQVf9fkzamYOP/6u19i/wUVXKCSbIrf6l6/p6oPA8+UHYXwyL9Vdzw2/jnfpclO9aBWG
         plqDE5fhDVRVVponFB5RN6wgwOr+Z6FxERo54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8EeKXBON8xQVA6CfI6kp2c6HMR7hgcWpIcCFwO21CyM=;
        b=QuJ/DkiB5piYr22tReYFwy1YUAb3fXcn71FbYMSLG1l5LnId6tRWtNnCxskSv9GJQP
         lc3/JosfrcXI7dLC1HoaboISm44oe6zV1wv4OVeGCh8FjsmJysLdRbXnLvTASIKIgmhs
         nfRjvx7Y3kgcjZ0rNjakX8vsaQnV3zeeeu6aGqZesDjA8hDbMFdrYGe/Xdgljf0AxPf4
         rD23Q8vc/izGPIHDugQhIYZxIoMVsZzQFmE9eDz/9r3ryziFyw4dRgMdlqT8jjha2AZB
         AbDXv+B8EppgyUFYXmBeEsoneVTWTGEOK6R61XfpF+C3v8zuamvTtOQtPrA7bfvHrXKT
         Zdpg==
X-Gm-Message-State: APzg51B/6TXH8Pghxh12ByBIDfOk4hWN5/CRTeu03JNRQ/lWekOzm7I6
        Z2UD/oMuTisaLOLZX1/BG/0MfbLiktmBsA==
X-Google-Smtp-Source: ANB0VdaXBLInVEZz1iJWz64EBet3UTa13Smg3TJPdrthaxoqNpM7kO8ePPyxamAyXkoSdAuw44pv2g==
X-Received: by 2002:a05:6000:1291:: with SMTP id f17mr10722717wrx.215.1536594728048;
        Mon, 10 Sep 2018 08:52:08 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id j133-v6sm23407338wmd.12.2018.09.10.08.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:52:07 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:52:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 7/7] MAINTAINERS: Add myself as designated reviewer of
 Intel MFD PMIC
Message-ID: <20180910155205.GM28860@dell>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
 <20180830165255.43114-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830165255.43114-7-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Andy Shevchenko wrote:

> There are few Intel MFD PMIC device drivers which I would like
> to review.
> 
> Note, Intel MSIC is old system controller that based mostly on PMIC
> integrated in it. Thus, I included it as well.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
