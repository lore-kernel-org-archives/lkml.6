Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC50C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656B7204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L9Xk7scl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656B7204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJMAsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:48:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41847 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbeJMAsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:48:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id m77-v6so6512824pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KB31MiBpcX0lVyQ6qRbXEipWBHsAms4SP9E7HKgrX7Y=;
        b=L9Xk7scl5IkvAPigV3lAO/a6dfirFagMz/dG0pEZi1Wzd9IMCjjK3SINKwqP8Z9HRw
         SDmWoVXiiyKFZdnTHKj1vdHAwK6q1YM++8/wqJGmeMAflMRzQCkHyXypZObGSZ3vQvQ0
         oI0Kv1MVmTjxW1wjldyJxumycrDkeoLNukbB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KB31MiBpcX0lVyQ6qRbXEipWBHsAms4SP9E7HKgrX7Y=;
        b=WcrH423ZdzMCNa5Q9ATqkEkDwuFBmFCnxvJRSiTG//2b6AqY4trPoSMv1ue3FeMX+x
         sV07DXVSOw+Lw7n3VeNa7u1h2SiAmToWggaGIeGsuIuEylFFnlkpIyDkZw/8aq+SNrga
         t5MiGbm1e7zbsB5eX8ug/ND+h+UihgM85HPPAHjoPWxXMc5EfUDv0SfTn+w0jCiWf+/U
         oJRxv9W8NoyjEPZ2r0pMaqa1TcN1YopP9xAj8ZB3ziDFEo+pZPv00LCYL+9jgl6NcNPY
         QXG5unMTbPfcH6+fzqseZxP+et8842AMOb6hz3xU/bjQAAMH42Vf6zbp4Kccem07nxgd
         Npbw==
X-Gm-Message-State: ABuFfohUySb+zE0Zurt/U8Kk8Dhji/m+3nSSNIuegvztOvYhEwzH1jR9
        gTr9z56UFY59mTWy9YWBZcaSGA==
X-Google-Smtp-Source: ACcGV60LhMpsPBavzyb/mmcKFopJLFakcl4Rt29pzjEv21fvFUYlW2PbXdC6CXU1IoiMrJE6ako9cA==
X-Received: by 2002:a63:e645:: with SMTP id p5-v6mr6074446pgj.218.1539364524737;
        Fri, 12 Oct 2018 10:15:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id n63-v6sm3869712pfn.9.2018.10.12.10.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 10:15:24 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:15:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include
 unit address for node 'usb-id-nopull'
Message-ID: <20181012171523.GQ22824@google.com>
References: <20181004001432.21218-1-mka@chromium.org>
 <20181004001432.21218-2-mka@chromium.org>
 <20181005204743.GA17135@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181005204743.GA17135@bogus>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 03:47:43PM -0500, Rob Herring wrote:
> On Wed, Oct 03, 2018 at 05:14:31PM -0700, Matthias Kaehlcke wrote:
> > The node has a reg property, therefore its name should include a unit
> > address.
> > 
> > Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
> > DT conventions.
> 
> This is ADC channels? If so, then DT convention would really be 
> "adc@...". 

Is it really? A grep for 'adc@' in arch/${ARCH}/boot/dts yields
mostly ADC controller not channel nodes.

I'm totally fine with changing the name to 'adc@...' if that's the
preference/convention, just want to reconfirm since the actual use is
a bit ambiguous.
