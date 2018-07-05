Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379C2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E598722438
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E598722438
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbeGESFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:05:03 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46726 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeGESFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:05:00 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so18563835oie.13;
        Thu, 05 Jul 2018 11:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9zPTOV+cU2GxkN227DQvy1qorzYlyyIb3UZEVWW+bCo=;
        b=YlJuFKSEwlG6Lo16qz1hBpN/3funqqXhfVq3F97V7lmXIjdbqAV316JQZs868mkDE7
         Skj23n0HdHpT18vi3Al5D/H1QVcTvM6/bgOG/qSCABX1tjqHkCR4furfGQKjicHU+XLV
         Iv5VPFgHk2Mp3+toqHkPL6EtqZkJCh65v3g/FReHIUYRirWedtKe/eJ+jwR1dBRsIjh4
         KZiMmfPmU/i3ZgzQRGjAIP3uQ4p8h5eZ8OM1MWPDGc+bE8kih9nXfm9e8fsyMvUX/8qe
         ixtLJB9C5TW/UvhaUDqZUmesJJjiA9Vt9fu5gjtSKoBA6Xme7Mfr0oxjxIN6X3oSmQ6h
         saSA==
X-Gm-Message-State: APt69E3BiTtywIUEOybVwaNySETiC4D33dvQvtQIW5Lcu/89sdHpXbtM
        Z30cBM6QawY/eQptlRB7hBzhQfs=
X-Google-Smtp-Source: AAOMgpcxlIMkw7Z77wYIvRzYo5Pmc/aDnePyuZ+i4ZRZlKH1DzWQI3UQOHOFcvxGi0P5u0LwBq8fFg==
X-Received: by 2002:aca:3b89:: with SMTP id i131-v6mr7826261oia.109.1530813900080;
        Thu, 05 Jul 2018 11:05:00 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id l133-v6sm5812116oif.48.2018.07.05.11.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 11:04:59 -0700 (PDT)
Date:   Thu, 5 Jul 2018 12:04:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH v2] pinctrl: at91-pio4: add support for drive strength
Message-ID: <20180705180457.GA5809@rob-hp-laptop>
References: <20180629081533.31885-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629081533.31885-1-ludovic.desroches@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 10:15:33AM +0200, Ludovic Desroches wrote:
> Add support for the drive strength configuration. Usually, this value is
> expressed in mA. Since the numeric value depends on VDDIOP voltage, a
> value we can't retrieve at runtime, the controller uses low, medium and
> high to define the drive strength.
> 
> The PIO controller accepts two values for the low drive configuration: 0
> and 1. Most of the time, we don't care about the drive strength. So we
> keep the default value which is 0. The drive strength is advertised
> through the sysfs only when it has been explicitly set in the device
> tree i.e. if its value is different from 0.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
> 
> Changes:
> - v2: use atmel,drive-strength property instead of drive-strengh one
> since it is not expressend in mA and there is no way to retrieve this
> value at runtime.
> - v1: https://www.spinics.net/lists/linux-gpio/msg27789.html
> 
>  .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |  3 ++
>  drivers/pinctrl/pinctrl-at91-pio4.c                | 42 ++++++++++++++++++++++
>  include/dt-bindings/pinctrl/at91.h                 |  4 +++
>  3 files changed, 49 insertions(+)

For the DT parts,

Acked-by: Rob Herring <robh@kernel.org>
