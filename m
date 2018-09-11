Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C59C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102CF2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7jWnn/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102CF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeIKXNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:13:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44736 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKXNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:13:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so26988236wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6pPwj8rPJ6t6AlwF/h8Fq3qHeE9Ol8btlbNbUcs1vWY=;
        b=Z7jWnn/nBe96C+8oLiCgxZuBvvclmOrr9mxupogI6p1udzJiBEdVcKPjhpn5UAPHun
         OqpuP09oDALFVvASp4PoT7Cj28/en5J6Dhju3snS9uWxqIvm9bLVnco+kHb/zRWClAN7
         FaQx+7HZ4bA4qvB/ToO3aDPD+ZA6XfuTDInKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6pPwj8rPJ6t6AlwF/h8Fq3qHeE9Ol8btlbNbUcs1vWY=;
        b=PXS59xhuHd7kyoL1kh3N6FUUbDa1Oc6O9AddwJjODpxgAcpDH/eAyVNKJ6EA9mXjMT
         RZu2+3rNVZWPjW1sJkfv+tTFf9q1js0YH2fGvVf03Fl3SY9NOKme/eIVVj06M6rVgYt3
         CUHGfO4E7JMZGe+RqDlVnqgy4obTeFiLB93z+lVKYGQR7pv62WXbO82qCJWwyYqO96zR
         T3gBhZTq5qW4RrGpMq7tgX93efD3ASSVTAIO/Xm/5xcwEvQ//vIBQj8qnB2h9EwnS//L
         LKQ1RMs3ktnm+6DJWEItTWN2h0Ki6E/ognZrLfhO0N00r9P2SRcrN9BFfM8X54fMcuN7
         7jAg==
X-Gm-Message-State: APzg51D+bhYQvvOyG/atcUIye8MACgxc5dCl6y3Rb18+rsCa9QBtLxVA
        fk4qcVI0moAKpDr0VyLiB3fOtg==
X-Google-Smtp-Source: ANB0VdalTDQ09vi87y2/0TpSRywieOS7ciZYSti4dlziWl6Ek6NaF0E1+3a/lW1zd3GPAkZH85ZM5w==
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr18055826wrp.184.1536689590884;
        Tue, 11 Sep 2018 11:13:10 -0700 (PDT)
Received: from dell ([89.238.177.251])
        by smtp.gmail.com with ESMTPSA id i125-v6sm2808678wmd.23.2018.09.11.11.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 11:13:09 -0700 (PDT)
Date:   Tue, 11 Sep 2018 19:13:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: [PATCH] mfd: ti-lmu: constify mfd_cell tables
Message-ID: <20180911181305.GF4185@dell>
References: <20180829093108.GB22065@amd>
 <20180907093954.GA26364@amd>
 <e10bdc74-8138-055e-c829-7befbc7161b4@ti.com>
 <20180911155355.GD4185@dell>
 <a74f7980-08bf-5ef0-106b-1e3f4e90b0e6@ti.com>
 <e8423cfb-2a23-1332-955f-6af5b0ddaecd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8423cfb-2a23-1332-955f-6af5b0ddaecd@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Dan Murphy wrote:

> Lee
> 
> On 09/11/2018 12:08 PM, Dan Murphy wrote:
> > Lee
> > 
> > On 09/11/2018 10:57 AM, Lee Jones wrote:
> >> On Fri, 07 Sep 2018, Dan Murphy wrote:
> >>
> >>> Pavel
> >>>
> >>> On 09/07/2018 04:39 AM, Pavel Machek wrote:
> >>>> On Wed 2018-08-29 11:31:08, Pavel Machek wrote:
> >>>>> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >>>>>
> >>>>> mfd: ti-lmu: constify mfd_cell tables
> >>>>>     
> >>>>> Add const attribute to all mfd_cell structures.
> >>>>>     
> >>>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> >>>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >>>>
> >>>> Lee, I guess this is for you to apply. Any news there?
> >>>>
> >>>> There are more patches ready,
> >>>
> >>> As I stated in another email thread.  I don't see the need for this level of LMU framework.
> >>>
> >>> Here is the reference thread
> >>>
> >>> https://lore.kernel.org/patchwork/patch/982550/
> >>
> >> This driver has been present for 1.5 years.
> >>
> >> Is that a NACK for *this* patch or are you hijacking? :)
> >>
> > 
> > Its a NACK for adding this.  I am pushing a new series for the LM3697 and will end up
> > sending LED drivers for the non-MFD devices contained within. I will try to match the
> > feature set the best I can.
> 
> Sorry it is a NACK for adding the backlight series.  This patch is fine.

Ack, thanks for confirming.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
