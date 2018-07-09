Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD527C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCA32086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="KfGA1XaJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpL78kvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCA32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754518AbeGILav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:30:51 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36275 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754432AbeGILas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:30:48 -0400
Received: by mail-oi0-f68.google.com with SMTP id r16-v6so35228525oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8Fqlh5U2UbyR8yMxJz/USvPwlv5k1YPtuR7L/66qCls=;
        b=KfGA1XaJScFTZ69iLKGjLe8Uw3pj3OGQHHIR4YjPspASgF9XlnACUv86zk/QJR65q5
         Oz1+0KLNpQkEnXyWaZ6COVxA8gt2Q0OR+XR9aK9p8J5d833Sg5BN+hJxfE06EMQTV3u3
         WzvsocEuagyLLKlWGJJhExnOuabKWhj/Y49DO3gxqcZ2+pgplptlyJ7ey8dYdOYF4ptz
         pR0r2ubKHLPcKaCa169CJmThUgJYlzUVrKkiwMZ+x1n8L5zCnbJA4lOKGLIZ1167KaFy
         z7CmjbhgOqdKWP0KxD0GQUargiDAdWY3v87Y3QdrhBcgiGNQddv97Lx7DhaeYQTltikq
         UEuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8Fqlh5U2UbyR8yMxJz/USvPwlv5k1YPtuR7L/66qCls=;
        b=hpL78kvvDsJjLXjh7IutcV1bmqC0fVj05xTc6A2V2rqI/g+5x7hWjsLzrF98Bvashh
         C8aPBFLsvFEgBMw2xvhQ2693bwH2OGjhqzBkIlmx8lhz/9nGZuzRSaMLI8HDjkQkRscy
         +QwgKOjtuvg8LKXciBkTlCKlWWWMpM4wjr5ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8Fqlh5U2UbyR8yMxJz/USvPwlv5k1YPtuR7L/66qCls=;
        b=onXAymo6Iq+lnYmrqRRtuj3vokCOY83HOUfFO3FM3Y+HBe1QDOgcrt9U4eNovfTaQN
         gBuHqyIXXLvpNwQMUmp/Ty0/3Araqw3H4trqLoW2r+EiBAgE/SYRW40cYDnCajG735gg
         NIFjzIGQPMirhOnfiUtUZBwphdLO9KnA1ucMP4F1DehYD3Y69YsQBgE9IZuWc3wmMBJi
         wNtMiLDdsvzSYodNYHgqC5jiCdCuJh/AokU72ya4h7sJivL9iAfYnkeKFXgCdRTpKcCu
         CtPqF3o8gZ661err9hOaKdQR/cw4338f6bImHDDmN5oRqVpwZk8HNmhZ7/NZoV9XAQcA
         7qSA==
X-Gm-Message-State: APt69E0acc9aGSBZQLkHdpTjpbSa0Fc0Gyoh3fsBhFiWQxcWKHoeCb8u
        n+aqjIQYA6m8Z5l0chuu869QMcW6/uhmFNc+XT963w==
X-Google-Smtp-Source: AAOMgpd2ViXMuY618HSvXD667p/ZwOoLiDZtxK/N4tqannE5Kbaa45glx4KFDNptJ9cRnRXQ82TPMOUPkMrx8oSVn0Q=
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr21076659oie.68.1531135847567;
 Mon, 09 Jul 2018 04:30:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 04:30:46 -0700 (PDT)
In-Reply-To: <20180702175357.GA28713@localhost.localdomain>
References: <cover.1530533998.git.amit.kucheria@linaro.org> <20180702175357.GA28713@localhost.localdomain>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 9 Jul 2018 17:00:46 +0530
X-Google-Sender-Auth: BZsmKsDndBf6rXgqZ4nvmXmw-Gs
Message-ID: <CAHLCerM1t-xO-zpYn3twb14VMGoC3+Pyv8LHuzYt7NVJWF0n4w@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] thermal: tsens: Refactoring for TSENSv2 IP
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 11:23 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> On Mon, Jul 02, 2018 at 06:14:03PM +0530, Amit Kucheria wrote:
>> This series is a mixed bag:
>> - Some code moves to allow code sharing between various v2.x.y versions of
>>   the TSENS IP,
>> - new qcom,tsens-v2.4.0 DT property for SDM845 and a generic qcom,tsens-v2
>>   property as a fallback compatible for all v2.x.y platforms,
>> - new platform support (sdm845)
>> - a cleanup patch and
>> - a DT change to have a common way to deal with the SROT and TM registers
>>   despite slightly different features across the IP family and different
>>   register offsets.
>>
>> Rob mentioned offline that we should expose the full version string of the
>> TSENS IP (x.y.z) and have a fallback compatible. I hope patch 4 does what
>> you were looking for.
>
> Applied patches 1, 3, and 4. Patch 5 needs a description. Patches 2 and
> 6 go via your arch tree.

Hi Eduardo,

I've sent v5 for this series. It fixes a breakage for old DTs with new
code. Also, Rob decided he was happier with the earlier single
fallback binding. Please consider applying the new series.

Regards,
Amit
