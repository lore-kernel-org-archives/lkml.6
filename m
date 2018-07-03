Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AF5C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD4520836
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JvSWOM7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD4520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933071AbeGCGUV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:20:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38961 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932613AbeGCGUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:20:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so910209wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 23:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x2I6FA0yCAl6CUa83T99mOjqsaw2z7Gnsi5/gPLhdds=;
        b=JvSWOM7hiC8mDD6QC6YNs1UJbtiBRwDSTiYhOdLLkRwrRsoWQ5Odx1wi1kGj6SX3z+
         8BFD+LPEF6dsUoho44xrHW3sLLqu2+ePPstf+vTcq/i46vFRaFA2bgLo+M8v9BfC3V3B
         a4edzLgFEI/O4z5yazN9yR+gR3FPjYWlYtlT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x2I6FA0yCAl6CUa83T99mOjqsaw2z7Gnsi5/gPLhdds=;
        b=AtWH6HKBz0ZGZKscON7yuLg1aF+7r+vnUmfngiAfIw5jBc6/ol2y04XlmFc0EnsT2T
         hmBxWnvI/CuPBXVfvSit/Fx26eWpaJwbNjT3qRNOz/5B4iZRhxtTO0bXb7JX9HhDXnsB
         Lgh30L9oKui2IraLJsneSNLBy1gvQ0WiJ1WCF/6E0zhAOvyZSjidgbe9qQ5HQHAcbly8
         0tjWlQ45kC5jRq52H91rtiP6eDLsIxBXnuyAIXI4vBsaGYCkYFlpHE16sWmQIlJtIpFJ
         8rJ2cy+oDCL5gxnwE5qddcOyeTYJCnelFZiFPkR8DW9QcqmTptwV0f22jK1BvMjtoFJj
         Kw1g==
X-Gm-Message-State: APt69E2tqpONsBtlItJJT4j+1sjkjmiaMI7S+JlsT2Sdo6fRxV9GIeRv
        00V4pqWPW6RIK9yJB7jLUkbJ0A==
X-Google-Smtp-Source: AAOMgpe1cbHK25dW6TEEwIVGTEiHFtZr6jzeVOBjywbh50w//jCunBEa/XZo1G9018p6WcshU/gWYg==
X-Received: by 2002:a1c:8e4e:: with SMTP id q75-v6mr10840831wmd.137.1530598817114;
        Mon, 02 Jul 2018 23:20:17 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id 130-v6sm2101598wmr.1.2018.07.02.23.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 23:20:16 -0700 (PDT)
Date:   Tue, 3 Jul 2018 07:20:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, tj@kernel.org, hongxing.zhu@nxp.com,
        Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: enable bus auto clock gating function for
 i.mx6sll
Message-ID: <20180703062014.GB4242@dell>
References: <1529645568-3786-1-git-send-email-Anson.Huang@nxp.com>
 <20180701085111.GK4348@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180701085111.GK4348@dragon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Jul 2018, Shawn Guo wrote:

> On Fri, Jun 22, 2018 at 01:32:48PM +0800, Anson Huang wrote:
> > i.MX6SLL has HW bus auto clock gating function, enable
> > it by default to save VDD_SOC_IN power, about 5% ~ 20%
> > saved depends on different use cases.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> Applied, thanks.

Since this touches MFD, please apply my Ack to the patch.

  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
