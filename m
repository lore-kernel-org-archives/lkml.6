Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3844FC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19E322429
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UT82sMVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19E322429
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeHJWqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:46:19 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46444 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeHJWqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:46:19 -0400
Received: by mail-ua1-f68.google.com with SMTP id u11-v6so3187459uan.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FGETNAEOCg+jXe2VQWgzaTh5vttGu3qPx0BGekE0jWY=;
        b=UT82sMVxP6RzQK5c530P4Fsx4d0xL3u/XnqAt5bYkom7Rt/0XZ4jJs3gVLLgipeP8w
         C88lTKu3/4B6rEqBQrByH8meBigHmEAdGc2NIlTjBPP642TJnA0v+XiwUGYeWMseYIpC
         H7FEkDXTBVu4pj1YyLxDwwM45VV6bucE4qHsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FGETNAEOCg+jXe2VQWgzaTh5vttGu3qPx0BGekE0jWY=;
        b=Cb1vHHmy02yQKo6feBQU5ikJWJaFkvjVUZK/Nd6vWo+bc3ANuzotck+m/zWyLhWgcs
         ZznFvQWhdPNB7FWP+bBztf8tuUfFhXjBzXofVG2HmykqBjY6RkDvZt3QhcSNMvpqC6qe
         /kNC0nbySLhINVjqlu60ivDENCpZzc52bhNgcPZgak+APe+Ysj+Z+G3KLT1zFpW//SXs
         Dvxf/biUTqSUfTnah8EiIRXZSB6GFP8/MV7N0eeii7xXqqiu52Oe/AQcvBYftx0tNVjA
         V3ylgeu2afPqeMeCnmBGwQfBr2B/hP5w1Gaj2nBQa4+rI6DhsTexsi/IaSGWTU08rUW1
         1Qgg==
X-Gm-Message-State: AOUpUlHIfz0+4Y0LIvAijrEfNzBbGIcoNyMFhf3AfxQMJ6d7LuCHFVSi
        T/x2BPc1B/I+g0NnNiRnaARl3InN7w4=
X-Google-Smtp-Source: AA+uWPxYPmlAXAdhBc9Q2KDkemisSHANc2Lc/ZaEz737QyR16U1SEW3RPq2gbPyRncx8ydjQPF86mQ==
X-Received: by 2002:ab0:1b6c:: with SMTP id n44-v6mr5355941uai.4.1533932097714;
        Fri, 10 Aug 2018 13:14:57 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id u25-v6sm1511034uan.26.2018.08.10.13.14.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 13:14:56 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id c12-v6so3185859uan.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:14:56 -0700 (PDT)
X-Received: by 2002:a1f:ebc7:: with SMTP id j190-v6mr5042671vkh.114.1533932096230;
 Fri, 10 Aug 2018 13:14:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 13:14:55 -0700 (PDT)
In-Reply-To: <20180514224222.54495-1-dianders@chromium.org>
References: <20180514224222.54495-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Aug 2018 13:14:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X60vTUmaMbwrg_DoUK6JKiN-kMGQ1KUmDJ7YbP+1bLfA@mail.gmail.com>
Message-ID: <CAD=FV=X60vTUmaMbwrg_DoUK6JKiN-kMGQ1KUmDJ7YbP+1bLfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] phy: qcom-qmp: Quiet -EPROBE_DEFER from qcom_qmp_phy_probe()
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

On Mon, May 14, 2018 at 3:42 PM, Douglas Anderson <dianders@chromium.org> wrote:
> The -EPROBE_DEFER virus demands special case code to avoid printing
> error messages when the error is only -EPROBE_DEFER.  Spread the virus
> to a new host: qcom_qmp_phy_probe().  Specifically handle when our
> regulators might not be ready yet.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I'm curious what you think of this patch and the next one.  Is it
something you'd apply or are you not interested?  Either way is fine
(it's just log spam) but I thought I'd check.  Thanks!  :)


-Doug
