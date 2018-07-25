Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F5FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDF120671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/UUW/6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDF120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbeGYWGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:06:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40036 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbeGYWGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:06:22 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so10550309ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvQUGknBnIJeKJ/cdIBUTayXSguVj8mpv/6nsDclKXQ=;
        b=c/UUW/6XSTfTcEhINR/LNodTa5e+mOEm5PZkF8r20QpqZxeMtd/DkEFUq8sHwAXZDQ
         6xLjzlDEmbwgGGMkt5L01Cql2cewoFPQL0jjqTTssoZKWc12unpyYC2m6xdQ/JvVFVbY
         pYcSvh6cbgDbwL2daFK1Pi5Z4S4hLR1DD96/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvQUGknBnIJeKJ/cdIBUTayXSguVj8mpv/6nsDclKXQ=;
        b=WxmjN/6BJ0cbEhS0dyO6YWJht0Qil1Pk/7htVeFgKEz8Vq+DFTeuoArm30z90TXQdk
         /dhSFOkFUliWNrRmTPmEHD1X5gRhU8fDRsFFXUxzngdqgpX0wk6v8Vmn5hw9ozPqgXZk
         bRBfXMpSIHuME3Z7bufRKcuvEZgJUdvxa+ADtLttm5OIqm4TgnRoBCE7RCzrFST8aJAI
         TCnPMKNWdhkMdUlp6het/XXWzBhxyAt3lEsl/4r/iwFBvSRzyeEgnlL4GQjKTBqTsJRC
         ZN+Ur4HFPLtbCGQChT+BuHrY5nMWE+NCnAzrlg/JW3mXGXeF8tgZjyHojNSdNU+ks5eZ
         eQOQ==
X-Gm-Message-State: AOUpUlEFegESR/PrsPIxIkwf3SpWxo+UBMuOwFexZSjFRXYPscrFzX0g
        RltLVQx265YdHUcg7CLsK1tmc/81gQxiOL55knRaBg==
X-Google-Smtp-Source: AAOMgpcBLLyJeNb3UBcK2awHutazwgLxzl6pwZBNNR4jVJR730bry7Z/Npej+SzGGaDlV4hhZIfT/u4mnO1FpEtOLPg=
X-Received: by 2002:a24:7503:: with SMTP id y3-v6mr7574246itc.70.1532551977935;
 Wed, 25 Jul 2018 13:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com> <20180723202617.15230-8-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180723202617.15230-8-wsa+renesas@sang-engineering.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Jul 2018 22:52:46 +0200
Message-ID: <CACRpkda26LhGi3_LBqMjA+oHNNdNa5NHkpvE4Sk6OdP_uH9-gQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] i2c: stu300: use core to detect 'no zero length' quirk
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:26 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> And don't reimplement in the driver.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
