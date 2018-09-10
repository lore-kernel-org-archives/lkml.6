Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23BFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC5D2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Huz+vNw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC5D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeIJOle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:41:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53420 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeIJOld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:41:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id b19-v6so20876377wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tvW7B19VUb04doqNJ038sjjvWyKM9RKSu6TrvuBh/g8=;
        b=Huz+vNw2Nw9fgU4ahg4RA+i8dB8vEy3BkjS6rbvOamxWxqrIFe+dK/I987qf8TqZun
         a127XChlmVrM1eKd6e2oPXpu+A9rBxbpO0R2ARDhAOey/EuNXvaOguQYK63eww5Ud5cH
         V636wh7U7LUB1hFmT8Rnjgg12W4GWXUSbIiBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tvW7B19VUb04doqNJ038sjjvWyKM9RKSu6TrvuBh/g8=;
        b=oB8VIO4heUnv60k+B8FRPuJUeu+UKWCe7nXnCuMaHseR5/sYXzTzKxqFZRT/81BTuZ
         Cudrmx+5vRRs/5H0jfnd7PtOmAL+1oT41gKwLjMsLBIWttFzdkk0K6YF6BVD8iu34/H4
         a1B7u+rSmtz3hiZ6Z3hz45Qn+VuvcYyWzBjGd4VQjKL126ij05wGMdxgWjLIQsW2Xu34
         Z7j+6/vylW+shQDyvTpMJqzzMkzEhIFFZWxGAq8VWAr7RHkDd72EyHyP5mHqrp3m8g4j
         7mGnnp7bGYKkiUskxQ7OGCBnMuWGVtVCwjVmEWe+3CrevIEJSI8bwUQ+d8I0IrIjzrfF
         zRkg==
X-Gm-Message-State: APzg51CKQcDhTCl6d39swhjEQoBGW8/n37BuyqApd5ApxZjqP8bx+nxm
        GbVVq1vSlCP1MKI9jgumLed/8A==
X-Google-Smtp-Source: ANB0Vdbyz2p3iDxLITJK0p64f/OjcuOje+G06P5Blwt+SZ97ljxoNgAdPiqTKfOsS95RnM7wurynKQ==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr132655wmt.94.1536572900412;
        Mon, 10 Sep 2018 02:48:20 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id m68-v6sm30511570wmb.10.2018.09.10.02.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 02:48:19 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:48:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, broonie@kernel.org, jslaby@suse.com,
        richard.genoud@gmail.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Message-ID: <20180910094817.GJ28860@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Sep 2018, Radu Pirea wrote:
> Well, this is the 12th version of this patch series.
> In this version I fixed a warning from kbuild-robot and I have no idea
> how I forgot to add static in declaration of that functions. Also I
> fixed the example for the SPI driver in bindings.

Okay great.  So which patches still require Acks?

[...]

> Radu Pirea (6):
>   MAINTAINERS: add at91 usart mfd driver
>   dt-bindings: add binding for atmel-usart in SPI mode
>   mfd: at91-usart: added mfd driver for usart
>   MAINTAINERS: add at91 usart spi driver
>   spi: at91-usart: add driver for at91-usart as spi
>   tty/serial: atmel: change the driver to work under at91-usart mfd

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
