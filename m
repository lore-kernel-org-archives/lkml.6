Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B46C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E94214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FZs4N1h+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E94214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeIZCD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:03:58 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36376 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeIZCD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:03:58 -0400
Received: by mail-ua1-f66.google.com with SMTP id m26-v6so3734625uaq.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YqKfgJAn5FGmzkfHA2ZyzFQHNMuiEgCIrlm8xRJB/Y=;
        b=FZs4N1h+5EUdsOFBeL0hSW3OyLH1tHiJN4QXSlXytx0Cx17mIH9LRrHGuVnSs6D51g
         4GtlD940ieFfAHNnqHIPC8szcPq5hiBKGg/Wpdluj17udxMgGAx7WYnx7nst6I/weLNC
         kosYRCm8eH8rjE1p8KUfd5fufRoQvq6wsFRjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YqKfgJAn5FGmzkfHA2ZyzFQHNMuiEgCIrlm8xRJB/Y=;
        b=FpGn0JgY1ZYgFr/9+8kjJg7WDYrxXio3SmNvguKhxAuVlFNdjiTUhv7Bg9xqfqFblI
         bttQRT7JfUJkT5IBQIL5xAr/Eipx5AudrOwzFh9v6uK9+nAB8obqFn3XDCKj+tlXFcW+
         Vl2eJNuww1qWturu7kZrkpDLp1MIgySkWg6qwKtbMlDxptLpo0xX5fwwd5luQlsn4erX
         8Zc9ymD2RbgtZ9t3X73BzYoL9HGxhBsM90GMifaWh2ONEmDUB4o5ZWoyFzj1MokJ/hcZ
         agpYY7zoLhdDh0i4cbR+Xe8o5KxLe+JW9RFi2eYFq6OO5mEJ3dyrf6wVP0RUbxHUL1BB
         CpjA==
X-Gm-Message-State: ABuFfoiHzmCcW2LZ3cgWGeeAyDh7Lvk+EkLDOJVMBTtaIPz2atPQoJGu
        mLC9f1RRm5GkasVIEU0w9YjvGp8tRc0=
X-Google-Smtp-Source: ACcGV63HxfQx0PkmaS1+LUnMT+lk2RKCfSovWaK7iH56S/12oMFw6PEjF1EJ8u8/5tz8FS9Tl//6lA==
X-Received: by 2002:ab0:51e5:: with SMTP id h34-v6mr873124uaa.97.1537905288073;
        Tue, 25 Sep 2018 12:54:48 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id k1-v6sm148256vka.19.2018.09.25.12.54.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 12:54:47 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id t21-v6so3787446vso.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:54:46 -0700 (PDT)
X-Received: by 2002:a67:3511:: with SMTP id c17-v6mr818259vsa.42.1537905286647;
 Tue, 25 Sep 2018 12:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-4-git-send-email-dkota@codeaurora.org> <153780767551.119890.9339380838620508307@swboyd.mtv.corp.google.com>
 <8866de0e7a687cea1d800d6b3dcfb60b@codeaurora.org>
In-Reply-To: <8866de0e7a687cea1d800d6b3dcfb60b@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Sep 2018 12:54:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VJA_qUDp3mxej4gANpzY6TFy7bpK_VzFy=W1X31vmifQ@mail.gmail.com>
Message-ID: <CAD=FV=VJA_qUDp3mxej4gANpzY6TFy7bpK_VzFy=W1X31vmifQ@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 25, 2018 at 12:36 PM <dkota@codeaurora.org> wrote:
> >> +       unsigned int cur_speed_hz;
> >
> > unsigned long for Hz? The clk framework uses that type.
>
> cur_speed_hz stores the speed value requested as part of transfer (not
> the resultant or rounded off frequency got from clk framework. It is u32
> type, i will change cur_speed_hz to u32 type instead of unsigned long.
> Code snippet:
>          mas->cur_speed_hz = xfer->speed_hz;

Change it to "unsigned long" anyway to match the clock framework.  In
theory maybe the "xfer" structure will be updated eventually.


-Doug
