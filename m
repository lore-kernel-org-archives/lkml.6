Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15E0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5EF20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctn2kbmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5EF20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbeKFWu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:50:27 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43891 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbeKFWu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:50:27 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so18335228qkr.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 05:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0hXt7ga73hk8MlSJ3izQIQjRkug/IA08+cKJTPvYEto=;
        b=ctn2kbmSQpqeXdiQPTJlM+xC7dO/edythNm64DQqqYOlyDJXa9HjmO2ZlInxz5W+/7
         HN1nfqF6Ep/dvjBHV//2r0Lhgy/7/nf0oS3ZCpzEdeV3NFBREfIsrOtdE9PCmwc77h1F
         aPHNgNyexflzFWZvoSjg+teY/rVr3AB6VXhVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0hXt7ga73hk8MlSJ3izQIQjRkug/IA08+cKJTPvYEto=;
        b=rFTvio0ONzbPLOvoCPdu3xUVQ2ifNxdLIohAplhMn8c35+l0dGiqLSEiWp0aoY8Jkt
         Xx3rR83eNDUcbRqOMgTAxeGaKDQMLa54QQub9pJc9wngd9bIypJ9xVWqQDzh/08ar7XC
         A8P+PlhGu5NbrQqy/nikqRoKEiiMpPEdXIyu4uwViu3951YiQqI3phdxps9ZGK6BtxWa
         l3nTfc0F5D0bKeT3yCurbh+1Nx7W0o+xWDN95QBtQkG1Wx3ArdCtSmqpxv0qI1vR9qQc
         SR17JuEoMCPvM17R7giOSFK95o8PZtEQ7E9pH+X8x08T1EC9uBj4fQw4j+ghfFD6Mm9t
         oTqw==
X-Gm-Message-State: AGRZ1gJNX5t/DGJuXqSQPsMIoUs5khfmciQKWOrdktj+hzNPYwGRcFz4
        x9r7DSxQfuXBGr8qVRkkShLYCWzchOg=
X-Google-Smtp-Source: AJdET5cp2519CMoHHuOUKoEjoU9b0VUts+UDzdLJT7+mSCw9l0Pc1lBb1KmyB3fY/PiWUgycd00NPQ==
X-Received: by 2002:a37:2a81:: with SMTP id q1mr24986166qkq.252.1541510714098;
        Tue, 06 Nov 2018 05:25:14 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id n101sm13757121qkh.61.2018.11.06.05.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 05:25:13 -0800 (PST)
Date:   Tue, 6 Nov 2018 08:25:12 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>,
        Roman Yeryomin <roman@advem.lv>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands
 list
In-Reply-To: <6a59717f-8ae8-54f7-b948-b145171c82c3@arm.com>
Message-ID: <nycvar.YSQ.7.76.1811060823150.1498@knanqh.ubzr>
References: <20181015221629.13924-1-stefan@agner.ch> <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com> <20181016084416.GF30658@n2100.armlinux.org.uk> <nycvar.YSQ.7.76.1810161357580.1498@knanqh.ubzr> <fe7595f5d02424c9d92e437cd20361f9@agner.ch>
 <nycvar.YSQ.7.76.1811052231220.1498@knanqh.ubzr> <6a59717f-8ae8-54f7-b948-b145171c82c3@arm.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018, Robin Murphy wrote:

> On 06/11/2018 04:49, Nicolas Pitre wrote:
> [...]
> >> r3 and r5 are not used above, so no need to have them in the clobber
> >> list.
> > 
> > They are used. ldrd and strd instructions always use a pair of
> > consecutive registers. So "ldrd r2, ..." loads into r2-r3 and "ldrd r4, ..."
> > loads into r4-r5.
> 
> FWIW, since we should now be enabling unified syntax everywhere, I guess we
> could probably rewrite all those ldrd/strd to the UAL 3-operand form - i.e.
> "ldrd r2, r3, [...]" - if we really cared for the extra clarity.

Good idea. Worthy of a separate patch though.


Nicolas
