Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8BEFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D4420853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SM55/onH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D4420853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeINONb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:13:31 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40814 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeINONb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:13:31 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so1603442ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OBnDtkT3S9amCExa05f6sbQjXAVgM392T9P6/DaOmA=;
        b=SM55/onHeIt6/s2r1yPv0HgA77vYWPerY7zDxcpg5i8WKPyfb7lk+FEa1I+Og9M6YQ
         tYHOxQZpAmSxEoykjUMdF4cmVHTF9AQQypKzCofbwX8MT4vUORJawlG0Oe8lARKn1Aa0
         9AlhZv5lHyaI/CbgcC183CJ/CpEUZBjTU27/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OBnDtkT3S9amCExa05f6sbQjXAVgM392T9P6/DaOmA=;
        b=hojzxC5PvwFKubw+JY6p/RJY0Ap/4lbxA4GWY4T6OuV3WdG4hbTBsDzF8S5yPUgrWE
         wa1uXaMM0XWAHVFMYNulop8hs3gJGB/tA6ie7VLqPCRsbEPCZE6iTFzocOUP9LgxREPK
         s5yHIJaU3g8wG8/MPOgEDvvnnOZ4SgGmyFQ9nh2wH3Gf9gICFBRRLgOO02S0yuL8rACn
         G0hypHB4kG8T63lV5ZSFeZD/GGtV2mjSP3QGoByQHj9JPH7ishrqgtXUsUL6R8jrYBxw
         8X5n8I01MRs6iJq/chiyj5+RfSzI/yT+U68akEUk9cYGfpopqnTm3EVkCsVjpnfeB6gR
         oKZA==
X-Gm-Message-State: APzg51Cooy37YJknaUcD3hmCbQ5dsedMn37nH/5IxUH7UvAMz+4HcMJY
        UdHTri2Bm21TW/1yEGiRV5RVyFRkHV7p039FTu8iwA==
X-Google-Smtp-Source: ANB0VdbUSozUI9RhMe2JgstYzFrqWZHC/J1U6692rv5V/l+vP0Obm6qbFyMuhXRBt1xM2Xhi19BEVp2qvMX39iBeDMY=
X-Received: by 2002:a24:7044:: with SMTP id f65-v6mr511010itc.62.1536915599733;
 Fri, 14 Sep 2018 01:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180913124213.32065-1-ludovic.desroches@microchip.com>
In-Reply-To: <20180913124213.32065-1-ludovic.desroches@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Sep 2018 10:59:47 +0200
Message-ID: <CACRpkdZWoZ1YCP9eJbB0BgfgON=Zf8q4w=OV4w2nRxvkcd6VaQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: at91: don't use the same irqchip with multiple gpiochips
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 2:46 PM Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> Sharing the same irqchip with multiple gpiochips is not a good
> practice. For instance, when installing hooks, we change the state
> of the irqchip. The initial state of the irqchip for the second
> gpiochip to register is then disrupted.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Patch applied.

Yours,
Linus Walleij
