Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125A4C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A646A20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlDIQe57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A646A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeJZADp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:03:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33366 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeJZADo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:03:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id o89so5982974qko.0;
        Thu, 25 Oct 2018 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OIf2DakP0oD5Tq7VvybGtzKfYwkFrt1ppRVPuLM3Xag=;
        b=WlDIQe57gP9tk72uPFahoq9XcJwdY6/4AdHtFgoBHrwgY1mdNX188rF5c3MrZbB0mo
         Sdd+ZVVsJjb57v5P6xhu2pxNZKIIxMdN3JqgdyVWs7Znr/s9j6cFnyhVky/XNHA1wiyv
         Ruhj0AQP7HeaGxM5t7/KWU1c8bEU+RfPNR9t0domp24grMSGUWxtM4Idr/WX7iGSFRbR
         UkCITaDWtP2qoT4hDnJjLu5ZzgczarNkzrAHBpsvW+biDxsWZLpLWcfcmsScqGcXY1bJ
         +hlvKpuZTIeiH4i7DsJGK3qLPtBnuDDp9saioLasDy7DYrAUWKRwzVC9mRHcO88yBww7
         45Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OIf2DakP0oD5Tq7VvybGtzKfYwkFrt1ppRVPuLM3Xag=;
        b=kTVREk1pNHKItf/lxpQJLDwRrhwpOk60aDqmB4YVDX7P95DTmOwWF+IhV6QdK47yfG
         7W+03TSmmyPn98JRK0pekXWZSVpfpWqgyJ6MzekVroDLMlRwtyj2qQjlUS2e2Dws0jgN
         ZO1SKk94pIfHyoZ0Bm2h8ROUBLwrTRwR1qo0a/0K86gimEfZe7SXrYqsuNtgsd22z6l5
         t0K/vaiZ95+4SbRt7FirHdY4tUnAm2typyBCDPiTLBtQqwm6gZQ3hhuaslm5xuiKa/y2
         RSzOrZQI/YxIF1KctWIx2POjU5E7MptyyfTTw+6Ti3FQwxtV2V8IGnS1TxUxrXOWjVot
         JYyA==
X-Gm-Message-State: AGRZ1gIFVmhErY1GPh2sJbPw9WZtcFgNNpbJrtW8vIijWl9NIXRZ8shS
        1lZwIGEPk8RmHkkwbRvSTMSJfF7F7kTLXwFhFFw=
X-Google-Smtp-Source: AJdET5dKIDJw3eee/VNm0+YOy+7JdTKxePwAYJsBQg96kwyLVfFbPTHnqnpdZaKnAx7LflDRWhK9606VmX9joDDRsW0=
X-Received: by 2002:a37:e21a:: with SMTP id g26-v6mr1886738qki.330.1540481427236;
 Thu, 25 Oct 2018 08:30:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:fd83:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 08:30:26
 -0700 (PDT)
In-Reply-To: <20181024202048.7e3534f7@bbrezillon>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
 <20181022133404.2061-7-boris.brezillon@bootlin.com> <20181024202048.7e3534f7@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Oct 2018 17:30:26 +0200
X-Google-Sender-Auth: ToJ4qwdkh9WaZwbtqufApwNto38
Message-ID: <CAK8P3a2DBgfvXs-9KzoDvbQpV+VN96xb7xHG-5=NDDgnt7ViVQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/9] i3c: master: Add driver for Cadence IP
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> Hi Arnd,
>
> On Mon, 22 Oct 2018 15:34:01 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>
>
>> +
>> +static void cdns_i3c_master_rd_from_rx_fifo(struct cdns_i3c_master
>> *master,
>> +					    u8 *bytes, int nbytes)
>> +{
>> +	readsl(master->regs + RX_FIFO, bytes, nbytes / 4);
>
> Vitor reported a problem with readsl(): this function expects the 2nd
> argument to be aligned on 32-bit, which is not guaranteed here. Unless
> you see a better solution, I'll switch back to a loop doing:
>
> 	for (i = 0; i < nbytes; i += 4) {
> 		u32 tmp = __raw_readl(...);
> 		memcpy(bytes + i, &tmp,
> 		       nbytes - i  > 4 ? 4 : nbytes - i);
> 	}

Could we maybe mandate that the buffer itself must be aligned here?
What would be a reason why we see an unaligned target buffer?

The open-coded loop should generally work (maybe a little slower),
but it does seem error-prone to use __raw_readl() in general.

      Arnd
