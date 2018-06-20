Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278B2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4ABC20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQ0yzZRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4ABC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754238AbeFTObY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:31:24 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45198 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752951AbeFTObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:31:21 -0400
Received: by mail-lf0-f68.google.com with SMTP id a13-v6so5281897lfk.12;
        Wed, 20 Jun 2018 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yUfIboMcb/EOHM8RJL6UJ1RJCNBdzF9E5sAesf9di0c=;
        b=dQ0yzZRboO6/CZNtMGeCwFhr4LwkypbFUORh/0XBvc5c4izxStedsSvuA0h+LulO+b
         zoFS298JtUOKcJaj6BEe1qvw1VTq4rGj+zT2o/nCuoPBLkduu8AMu1MNQ3RRXWuyLuiO
         LFJOPIya/IjcoMl//YXwFkhb7dk1ncNLa9xQiYDye+CRcr5ezzoXRYDl45wK2XUGX53K
         mjO30NZlqBv49f7SMsDMTQvJd93qEa52XchGmJ4XS8CjF8ipqYEjzfZ4bzsDSkEG+waw
         N5yNY5lAxp9k4K1uLKMvxovRs3GVTgVAj8ixKMs0GawEybqV/I8IhY9CpONZsXBWbgeg
         OGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yUfIboMcb/EOHM8RJL6UJ1RJCNBdzF9E5sAesf9di0c=;
        b=T3/ROYbICxktCcLDBhA4wy/Bf2m0hg9hsss4Id7Ay9Jr4IEMeQaQWm4UnN88W0JDnM
         +sowrocaaTJpVdpEZW3ssreVbkV3YS2hn7zXq9XrGig35aiAbL7/fj1Gef4hWbIFNg0F
         MDlKwS2UT1X6nq/PEeqrrhGfaWPKx1FhS+L4K6DpymnwDJh2+dyVHGf0ptjL7gtv5fGo
         YzS2I3wLlZ1cs/CmqEBV4j9hZjue2rzDRgNxSXAanoAfz2xbHgHWS4YWwgOm/7QckujU
         boTdRQmdN9+1SCBiuzii3DaCekFSavjMzbHITOdvEY8cJlzDyAySQtSVrukPUcnXVuF7
         uaEA==
X-Gm-Message-State: APt69E1jxCDCDe9eotaOXhYfadk9+89PBCrrhK9FXbNZchMQV2eWvNiR
        BgSCpSnsEdVuKeHsgvbdjy422xw=
X-Google-Smtp-Source: ADUXVKJKsc9UCsnRAvzZXZGPxf1rVoH8lJdg6dQUeRSzE87bgCTnWp6fdf/Itg1ETQwtyT/CU3cj3g==
X-Received: by 2002:a19:1a52:: with SMTP id a79-v6mr13772657lfa.43.1529505080136;
        Wed, 20 Jun 2018 07:31:20 -0700 (PDT)
Received: from [192.168.0.4] (89-64-25-103.dynamic.chello.pl. [89.64.25.103])
        by smtp.gmail.com with ESMTPSA id x15-v6sm449069lfe.39.2018.06.20.07.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 07:31:19 -0700 (PDT)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
X-Google-Original-From: Piotr Bugalski <elvis@carbonite>
Date:   Wed, 20 Jun 2018 16:31:13 +0200 (CEST)
To:     Mark Brown <broonie@kernel.org>
cc:     Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: Re: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <20180619151506.GG11230@sirena.org.uk>
Message-ID: <alpine.DEB.2.20.1806201627330.26137@carbonite>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com> <20180618162124.21749-2-bugalski.piotr@gmail.com> <20180619151506.GG11230@sirena.org.uk>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you very much for quick answer.

On Tue, 19 Jun 2018, Mark Brown wrote:

> On Mon, Jun 18, 2018 at 06:21:23PM +0200, Piotr Bugalski wrote:
>
>> +static int atmel_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>> +{
>> +	return 0;
>> +}
>
> If this can be empty should we adjust the callers to allow it to just be
> omitted?
>

If I remember well some commits ago spi-mem required even empty 
adjust_op_size. Now it seems unnecessary, but I forgot to remove the 
code. I will fix it in next version.

>> +static int atmel_qspi_remove(struct platform_device *pdev)
>> +{
>> +	struct spi_controller *ctrl = platform_get_drvdata(pdev);
>> +	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
>> +
>> +	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
>> +	clk_disable_unprepare(aq->clk);
>> +
>> +	spi_unregister_controller(ctrl);
>> +
>> +	return 0;
>> +}
>
> You should unregister the controller before disabling the hardware,
> otherwise something could come in and try to start an operation on the
> controller (or already be running one) while the hardware is disabled
> which might blow up.
>

Sure, deinit should be done in reverse order of init, you are perfectly 
right, just my mistake. I'll fix it in next version.

Best Regards,
Piotr
