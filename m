Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C558BC46463
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A42620844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGiSuFjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A42620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbeGaRYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:24:51 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43831 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbeGaRYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:24:50 -0400
Received: by mail-pl0-f65.google.com with SMTP id x6-v6so7325774plv.10;
        Tue, 31 Jul 2018 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iYjfnlYysK2/KdaOiGfOeHZFgAShmkW/QQRzpK56fvw=;
        b=FGiSuFjD0XpMvmXOxKK9htNT9fbLjlx2gwaqulm5u6xyqXkKt+K8PaSQqUj/chdyet
         7uN5fhlBBNV+EYPqKCj/Z1Fh+tetJSTiM1hvTSkbnlOYcqGxzrGfpzO9yCoD87JpSh5F
         wg01oh860GtVx1XftBWn5sLMXoZ067RoC2vS2KPp4NsEuWlwZA+9sOHKQHZqOAqOro1R
         B9s0uQQTSHNVEIXL8tXUbMVWUAaSoK5PZVMbgEjye5mRFcVCtb0w/bEx8PLUHBvOb16G
         0PheRPpIya53H63cmCaT7qvGDeGffLo4Fz28/BylP1r5ueFwocxwLJ3vwo3Br7NigvgA
         1Ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iYjfnlYysK2/KdaOiGfOeHZFgAShmkW/QQRzpK56fvw=;
        b=K0SV3XKLEADJNQGdroy9B2/zZzD+6i5Q2LRTEwnHFCpzWTm0dYmgqY+bsM85sUhixE
         gmkUWhP3qOVEKXqEhpAkQfVTtk8XbDiIoOxbP16fsFi43nZc9t1NVIKnntT+Mdj0ULsI
         dBeNolWTMYD0vSx8jASY/cY1j9B6uLkOSiwDSmqM1oCpmsNtICFMXadF5nzmTOR4hA5c
         GioSiKT5VVV7CSo9SvT9A1NmOB/RuaEWBheZWFPT1a94Io5PoqJ7fBEwWd934AWZOocQ
         8NYdtoCiCEdPT2SfFM1aGf0l9UiY0Uj2MSM7XtWJe5IYz03UBIKRi/7IgQXKkpIfPS0E
         11qg==
X-Gm-Message-State: AOUpUlHKhLvP78f9U+sIblZPzpw4OKvBylwZLGKzdSn4djT3kGhalFcS
        hnU4aURd7uqpq8zhS053qko=
X-Google-Smtp-Source: AAOMgpco6tGsbGRTTtzfdAVPoJu0nCmv66PUneExMDR4jlZhEPOmJ6hsMv6t9ANLbKh6rYT3IWsayw==
X-Received: by 2002:a17:902:ba88:: with SMTP id k8-v6mr21096820pls.259.1533051836413;
        Tue, 31 Jul 2018 08:43:56 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 21-v6sm21829014pgx.20.2018.07.31.08.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 08:43:55 -0700 (PDT)
Date:   Tue, 31 Jul 2018 08:43:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Stefan Agner <stefan@agner.ch>, Christoph Hellwig <hch@lst.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fugang Duan <fugang.duan@nxp.com>
Subject: Re: [BUG BISECT] Ethernet fail on VF50 (OF: Don't set default
 coherent DMA mask)
Message-ID: <20180731154353.GA29601@roeck-us.net>
References: <CAJKOXPeaguNxRr7pCArJ5Db4tS6Kr5BDheCxskY+vd0dUN+0GQ@mail.gmail.com>
 <CAJKOXPfageiBVXddtdJRBS+092O3QfD0yoS_Mk+PoX7+qNYNUA@mail.gmail.com>
 <20180727140448.GA29001@lst.de>
 <20180728165820.GA5731@roeck-us.net>
 <45f7fc82-fb9c-e666-4ada-c5338d2c1c96@arm.com>
 <39fa11ce4b7dd151d98868f375baf818@agner.ch>
 <0e893142-a5db-d119-6eb3-f849db6b5d04@arm.com>
 <f67628ad-4cae-96cd-d0c4-3b2f7d12a822@roeck-us.net>
 <4ce17098-850f-3bb0-b977-8d7932e74e06@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ce17098-850f-3bb0-b977-8d7932e74e06@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 03:09:34PM +0100, Robin Murphy wrote:
> >Please note that sparc images still generate the warning (next-20180731).
> 
> Ugh, OK, any ideas what sparc does to create these platform devices that
> isn't of_platform_device_create_pdata() and has somehow grown an implicit
> dependency on of_dma_configure() since 4.12? I'm looking, but nothing jumps
> out...
> 

I suspect it might be of_device_register(), called from
	arch/sparc/kernel/of_device_64.c:scan_one_device()
	arch/sparc/kernel/of_device_32.c:scan_one_device()

Guenter
