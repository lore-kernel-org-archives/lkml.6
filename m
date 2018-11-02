Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363D9C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12B42082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3U5l5GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12B42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeKCDaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:30:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43686 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeKCDaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:30:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id u18so1942524lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EA2qLqIsmx6YLRKG8F4YGbxODLHhQ5/M4zED+i0s4Dg=;
        b=e3U5l5GSKQyr1C6IBRF52JYfplMMHwvWXRPzw/zFbnuMeh9OH6eLhKuGD0QKOj8P84
         IW11l84m3n+dKdsFwC31PHrykaH5gHHA5BX16d/tUuWEN2p5sHXj8ZVg9JQn8ngo17V7
         d8xXrSW4e/xJmI+aYEXuiRTrnKYz+U7Feaauw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EA2qLqIsmx6YLRKG8F4YGbxODLHhQ5/M4zED+i0s4Dg=;
        b=uj2JWeiGMhDu3lXkRSa/PTQYdEhFqQFuL5cZ0nVZuAtfUVAlccrQMvTkKLkTjosQMw
         Q0gisx0Bc0VhaRhdbWdr+zSe04glw4nBc5ahWiT7/H+FhgtnYkakQh9JJnUzzBPb9eEe
         gQ2tbkUsDTMV+Fh81a5Mz/ZNbnKO3nEJHe08t/nN7FLGQ5fMZRflzjKsYEQIBOkMpSSE
         uxmCUqGOM2XG+hSa6+CoERNLI4+MW96HK63ZDwg3MyjtFg+tcmN03mC+bjkl2oiPbnT6
         rzt5X2aP06Zjw7anyad+vTNPIXRSDRd/T2+sm+Pwr9BhK2jsosoC04AZ0IKNHlcH/8sa
         wVbw==
X-Gm-Message-State: AGRZ1gK/ICTxwMiKU+AUIweltKop77FYLrx9q5GhCj+6pYZZ2lD33Qpp
        tNoN3v0g/vKZNrbGFrx2xcCuIQ==
X-Google-Smtp-Source: AJdET5d80QLN/xB4dVCk/Vz/2n4pUCI5f8fVE0TvdnkGZUDQPJHFKhUmadp4GUmotnmN09TRuSiv0w==
X-Received: by 2002:a19:5a84:: with SMTP id y4mr7739269lfk.156.1541182926657;
        Fri, 02 Nov 2018 11:22:06 -0700 (PDT)
Received: from [10.0.0.171] ([94.72.11.11])
        by smtp.gmail.com with ESMTPSA id z8-v6sm3586380lfh.52.2018.11.02.11.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 11:22:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH RFC] block, bfq: set default slice_idle to zero for
 non-rotational devices
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <317076f7-f84f-c08f-5fb5-b227094cabfd@applied-asynchrony.com>
Date:   Fri, 2 Nov 2018 21:18:26 +0300
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E50DB19F-D744-4E6B-ADDC-A2546484ADF0@linaro.org>
References: <154109421062.925711.4117729151502021084.stgit@buzz>
 <317076f7-f84f-c08f-5fb5-b227094cabfd@applied-asynchrony.com>
To:     =?utf-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 1 nov 2018, alle ore 22:06, Holger Hoffst=C3=A4tte =
<holger@applied-asynchrony.com> ha scritto:
>=20
> On 11/01/18 18:43, Konstantin Khlebnikov wrote:
>> With default 8ms idle slice BFQ is up to 10 times slower than CFQ
>> for massive random read workloads for common SATA SSD.
>> For now zero idle slice gives better out of box experience.
>> CFQ employs this since commit 41c0126b3f22 ("block: Make CFQ default
>> to IOPS mode on SSDs")
>=20
> Well, that's interesting because 3 years ago I made the same =
suggestion
> and was told that BFQ's heuristics automagically make it not idle when
> rotational=3D0.

Yep, that automagic is probably 50% of the good of BFQ.

If one just sets slice_idle=3D0, then throughput is always maximum with
random I/O; but there is no control on I/O any longer.

At any rate, Konstantin, if you have some use case where BFQ fails,
I'll be very glad to analyze it, and hopefully improve BFQ.  Just one
request: use at least a 4.19.

Thanks,
Paolo

> Did you actually benchmark this? I just tried and don't
> get a noticeable performance difference with slice_idle=3D0 compared =
to
> deadline.
>=20
> Discussion link:
> =
https://groups.google.com/forum/#!msg/bfq-iosched/iRMw2n3kYLY/6l9cIm3TBgAJ=

>=20
> curious..
>=20
> Holger

