Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021DEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0D220862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycg/oHIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0D220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbeKFWQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:16:25 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36870 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeKFWQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:16:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id 131so18318424qkd.4;
        Tue, 06 Nov 2018 04:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Buf6Hucrj9YwiniqARNftu2Pu7TU9+iAoIz/xRrY3Cw=;
        b=Ycg/oHIBRKh/fsVQqQRXAL5gGsI7BLrLRrzFn5adDlmet65syvTTE8GfyLvRgjoX30
         XkT8KpPzHI2LJCUdk/gUj6zG2Kh0ZaWSlF4cjL2OO1VDfSsiRyuKsLEFtnGaOuNFhl+U
         bE3ZKTqKlGadTTNRz8dVfPm7D3TpOqXDxKeLluG5DR9mu9LFvsImRAg8ktP1UUcocHon
         YNbtxrlooBH3eNP2G2RqxgQ+4pAFO/4GEfCs3tDnKnORwwTv34H3I3bzSlCz5eNjjsa+
         /NNkvIUUT+Bw3vWOHFtZlIIiCWOiKpdAjsH5e0wNOdW7fvCMEh7UxbrxMCwDRSMBfohg
         olJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Buf6Hucrj9YwiniqARNftu2Pu7TU9+iAoIz/xRrY3Cw=;
        b=m0DZZwVONsgRKAYEEIk5zxC2UiNHu7HsiFQ9+/Q1rCXECCMn5BMTw5ai040NDIazEd
         eNCRtwxuIa5tr4bQmhVrhnpI/DZ1NYHtt5HrWugQM8jvCnyffSew+gohHdZLL/iX2fDd
         j76FEr7T0N7dHKSHzFcVexrvx7BiqxMAzkQkEym5BhYRhpdVPsIejXdg4UTTGUUEgKmd
         lRxt91scz7EkuyCt2sVlaD1pMefNqZhB8vCJ3vQpuLPAozrLNZWycV4dW85MOBpuKDfy
         YfkjGVB+9k3gDtn9TdrKYWu4WdGDzJPAEhVkajSUWakvsj6fpx1XHYdGDap/b8AugPEX
         axgg==
X-Gm-Message-State: AGRZ1gLu5DgI5Zt83xZbyzAKmU2aXds9Xka9MXkp9aezgR3NLyF47U0Y
        Vf6rPSG0RTBGvaIdkgepYRb07dQQr6pnSGh7sgk=
X-Google-Smtp-Source: AJdET5f1uTPECcPHHp1ROfYWfovKVI8HRP76uBWKu/r2HL1t7mw/IRP3swVobwwb9bmCJXlVD9Imk6X8jI1ARCJTRnI=
X-Received: by 2002:a37:4116:: with SMTP id o22-v6mr23327155qka.107.1541508678961;
 Tue, 06 Nov 2018 04:51:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 04:51:17 -0800 (PST)
In-Reply-To: <be0a18e8-8ee6-4d4e-6dcc-6ba6e39033c9@ti.com>
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
 <1541387810-24867-3-git-send-email-zhang.chunyan@linaro.org> <be0a18e8-8ee6-4d4e-6dcc-6ba6e39033c9@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Nov 2018 13:51:17 +0100
X-Google-Sender-Auth: T94ROnoRH2UfrymrCT8HtqLfMO4
Message-ID: <CAK8P3a2X4tbx_R-5VgfApF-UPmJ_XuzH3hO_uVAfffC6h8WrJw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] mmc: sdhci-omap: Add using external dma
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On 05/11/18 8:46 AM, Chunyan Zhang wrote:
>>
>> +	sdhci_switch_extdma(host, true);
>
> A number of devices using sdhci-omap supports ADMA. So switching to
> external
> DMA shouldn't be unconditional.
>
> IMHO sdhci.c should see if the device supports ADMA or SDMA. If not it
> should
> try switching to external DMA and if external DMA too is not supported, it
> should use PIO.

What's the reasoning for preferring ADMA/SDMA over external DMA if
both are supported?

I'd expect that if the external DMA for some reason is worse than
ADMA, we just wouldn't list it in the DT at all, but if it's listed and
ADMA also works, then the driver should try to use it before falling
back to ADMA.

       Arnd
