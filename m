Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8045C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B87221524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODgSq4Vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B87221524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbeITNMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:12:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32781 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730654AbeITNMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:12:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so3961993pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 00:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6cTNXXPDv4rHHwctxkzW6fLP652duz1gP3Ecpw3II/4=;
        b=ODgSq4Vu3QuLs/hzTm47l0teHj6vOft1sTIeBc5pmm4UUO/lzCeg7koxAU/ia4rsHJ
         RdjqayrormvMMbQTe5d2Ie0yD1vcpbOgLm/gbXy7fQIz4cNmC4ZjrBWApIM/JxQQnRbN
         Yb1mvovCY6Dz+67hqBIppw+kDaPQEZeFm6ifI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6cTNXXPDv4rHHwctxkzW6fLP652duz1gP3Ecpw3II/4=;
        b=SQQ3HiaIVDNvt82e7wFck3cDdaCi1Rt3rwYYVOh682ai2zDRqdAxXlDzngNmixvGxG
         iCCRzmDeSRzrs9YHAOrxHlYIyIjJlh9ht+k1OhVfIxoGtuKfThZF9fmXxr/V4xgggTLx
         NGhAOLysPhH/e+vYWzg+5+27t5loV+BbX/oLYVtEYkeX9vm06/74x+0jvRSwQcKKFKbl
         yTTV5f70dYl2wJ+4FM7LRIGK/iN+ZH/DXNtAZAWE2Z8OcSwuMnDz0HKr1+XAuzX/KHgE
         YXm4Hu/QjGWZutRimfXhFm+zYvITaqT1CWutC80ZmZbWXQIqyWTbaszYi4yKyFX9uF9a
         mVGQ==
X-Gm-Message-State: APzg51DvyEQEQYM3ZY7xzw/gEMctPBACAO7jrRqCWpJgN/18uMXRLf0B
        Q2GiV77NkeCW5afFNR0dMAwRnA==
X-Google-Smtp-Source: ANB0VdZ1dEWdXJXjGx/N8oCja9wMiinWFW4LfuBvQRVz+xrxeI/0iK6Vm4iI/OLq8v9QFXBCsJfhlw==
X-Received: by 2002:a63:e001:: with SMTP id e1-v6mr36069062pgh.380.1537428605283;
        Thu, 20 Sep 2018 00:30:05 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n79-v6sm47474765pfh.2.2018.09.20.00.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 00:30:04 -0700 (PDT)
Date:   Thu, 20 Sep 2018 00:34:15 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH] firmware: Always initialize the fw_priv list object
Message-ID: <20180920073415.GC1367@tuxbook-pro>
References: <20180920010938.10315-1-bjorn.andersson@linaro.org>
 <20180920052204.GA15695@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920052204.GA15695@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19 Sep 22:22 PDT 2018, Greg Kroah-Hartman wrote:

> On Wed, Sep 19, 2018 at 06:09:38PM -0700, Bjorn Andersson wrote:
> > When freeing the fw_priv the item is taken off the list. This causes an
> > oops in the FW_OPT_NOCACHE case as the list object is not initialized.
> > 
> > Make sure to initialize the list object regardless of this flag.
> > 
> > Fixes: 422b3db2a503 ("firmware: Fix security issue with request_firmware_into_buf()")
> > Cc: stable@vger.kernel.org
> > Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/base/firmware_loader/main.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Is this being triggered by some hardware somewhere today?  Or is this
> just a fix found by code inspection?
> 

Hi Greg,

Yes, I found this issue while attempting to load the firmware and boot
one of the DSPs on one of my Qualcomm dev boards after v4.19-rc4 and it
can be reproduced on the upstream Dragonboard 820c.

Regards,
Bjorn
