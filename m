Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102F4C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD52721907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PkS72uz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfBHAwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:52:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39508 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfBHAwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:52:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so788713pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pna5PQ6isrBAB3aTHUhUZYVF371WUTwDp+BF/t+C/MI=;
        b=PkS72uz0uAWG9bbtkFXEezORMZnaKrTA2Cl6YK5aUB9E554Lxbc+YnhC97U0SDvUka
         ++Q5jT6FDVn5hCzD57z8pL/J7VW2Dy9Nh9Gl2UJMtt6vTYRjl+70J3vcSlkZr/nTDrzF
         K1JCDaVv6WYcOGRSwGxYNl66v3uQAc9tU/2bZVMwmeJ9HDCWs2Ezle0xY5fb4iKubKgr
         lkoU3uAjmxUEwHwE3b1Wb+g/wVOi/Ww6tOtMdIVvDbRm8UrMqPxPjQV5vrJfVvnpwE0p
         CvF/6tY/nAEjRSy6ocgIGSWYV61KO+70OtEa183CfX9J7nsabyz8eHCP1ecyZmH9llBZ
         NipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pna5PQ6isrBAB3aTHUhUZYVF371WUTwDp+BF/t+C/MI=;
        b=aMgnvvr9nrNJSelfqYDQYObovJNqds5C/qj0PG0DpRCJCj1rw68/G12reI4w6+Wlly
         YrziBf27KoMkcjekr703RXFyiL8QUyO7tk+4tEVPlyGEyzRVoodK2iqkdv6D/8V9COXg
         vkkUADN/RY50GERfZDbi7cOxcT1+FoeX2BJ2kufriRMsdtZMXKO62zwAx/ObbrzEwAl1
         N1iECcFkn/Ouk2Ul9CIvDZO4KJr94WqV77D7N3qEZGHPB6xvzxl/GJ/j3LReV9RdKNr7
         hPeYCCVHFINUSpS8+9m6Bf5Z75AttV5tNtJh7+JM5wHQcc3vYIZg9SBRgcUmdWhsSNFR
         BU3w==
X-Gm-Message-State: AHQUAubj5/dVOo3vp1GiqyGYKHMJrbF7xHHcBGBsbxNuzyeA2Bb4BTT4
        A8IQkW/YNVFL9y/qQvX3/sc9KQ==
X-Google-Smtp-Source: AHgI3IZtHELm0XiYrNwP8mgmR0kL4wFcUAoa43JPc9pnhrJ/OZ/bdUc6BdhffybgoCtHBrBlR1rkfA==
X-Received: by 2002:aa7:84c7:: with SMTP id x7mr10756119pfn.180.1549587170484;
        Thu, 07 Feb 2019 16:52:50 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
        by smtp.googlemail.com with ESMTPSA id g11sm414133pfo.139.2019.02.07.16.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 16:52:49 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 2/2] soc: amlogic: clk-measure: fix-up some clock definitions
In-Reply-To: <20190207132603.694-3-jbrunet@baylibre.com>
References: <20190207132603.694-1-jbrunet@baylibre.com> <20190207132603.694-3-jbrunet@baylibre.com>
Date:   Thu, 07 Feb 2019 16:52:48 -0800
Message-ID: <7hr2cjf6e7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> As pointed out in review, a few clock are not properly defined.
>
> Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Fixes: 2a4c63e080cd ("soc: amlogic: clk-measure: add axg and g12a support")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

I squashed this with the original too.

In doing so, I noticed I (mis)applied this to my dt64 branch, so while
sqaushing, I also moved it to my drivers branch.

Thanks,

Kevin
