Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F48ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C79206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eDW/Va2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C79206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeGQJ2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:28:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35103 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbeGQJ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:28:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id y22-v6so681755wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 01:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3S4Jpqnwrg7ztPtUc8IxJPH6yUd7miqu4ph6sl1FhPA=;
        b=eDW/Va2KKkGf+a1hpCEMjP4SOxFsAOOl/YWV3/29Uv8qr5rpp9nvH17VPFgADFnLEb
         zrB3aQEGrF+V0h5y6fRv/ofHz+pWC64TvvGUxa4hgpwQ71EXSZXztsrPpI8wvDmbJ7Qt
         G4Sn53EzGwciwnoPCw2+5ewO6oZ3hk5RvaVX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3S4Jpqnwrg7ztPtUc8IxJPH6yUd7miqu4ph6sl1FhPA=;
        b=mhoW1RM877AuVBCrgZE0avmGgZV4/8Eq1lSM0SO40tqMVjqXb72eN5zazAFu+vz0bi
         QmM2yzNF5Q5kM34stw8Xt8q6Mq6vulCaS58uNRRmzVXm6gkLX0hrohuMhS1iqSQJU0cc
         q9fNUSbsBbi05q2qBiwVFQuvnv2yy/dT2KqcDxjn/gB17a/xrYvnRdTW9D5lOcWF4kOh
         mbuZuCi5y79JkXcuDJfU3nffYorb+fZhCaqwudUJw1muVOaZ9WqSbUlPBvgHlQQ01ha0
         /1b3INKsZD8KhyvyK6/KmM1rgJas+9FS12lVy/A4TPsdeTCZYYNd17tl6RkX7z9bGdFk
         4TFQ==
X-Gm-Message-State: AOUpUlHoGgk2grOYYE69qjklsEMV8xXyoyWofP0W4jkWTbS0u4wqIcpc
        QJUzwK/k96/aKeFTYh7NxDAqbTzVmi0=
X-Google-Smtp-Source: AAOMgpfnHgqO1wYR/MQ8x1//ZgWFnDHeUO5QWQ+Y5c1vRSQbtdfdlbBh65TjHXUu4DKUIaqQvQmVOA==
X-Received: by 2002:a1c:415:: with SMTP id 21-v6mr791416wme.128.1531817832843;
        Tue, 17 Jul 2018 01:57:12 -0700 (PDT)
Received: from [192.168.8.101] ([37.168.37.237])
        by smtp.googlemail.com with ESMTPSA id f190-v6sm1444621wmd.0.2018.07.17.01.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 01:57:12 -0700 (PDT)
Subject: Re: [PATCH 2/2] clocksource: sprd: Register one always-on timer to
 compensate suspend time
To:     Baolin Wang <baolin.wang@linaro.org>, tglx@linutronix.de,
        john.stultz@linaro.org, sboyd@kernel.org, arnd@arndb.de,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <c233469f487d9e187de3fdaf79db4e1a7ca7486d.1531812082.git.baolin.wang@linaro.org>
 <3d6de641eabb8f36ad2b6d4e948bfdeb2282c96a.1531812082.git.baolin.wang@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <aec77e9f-7b2e-b092-6489-f15655ed04a9@linaro.org>
Date:   Tue, 17 Jul 2018 10:57:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3d6de641eabb8f36ad2b6d4e948bfdeb2282c96a.1531812082.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2018 09:55, Baolin Wang wrote:
> Since the clocksource framework has introduced one suspend clocksource to
> compensate the suspend time, this patch registers one always-on timer as
> the suspend clocksource.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from RFC v1:
>  - None.
> ---

I'll take this patch in my tree for v4.19.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

