Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256DDECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E2A208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUWWWn8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E2A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbeGMHoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:44:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36932 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731351AbeGMHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:44:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so8414740wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BFLdm+38l1RXMRuTGYQpFp9tuTkTwcz507zcdb8t68U=;
        b=IUWWWn8TVPwM99cYKYXTY6Wr2P4oByvlI9QlqvLUXZgJr0e+qSIlFtkFFTSDUNK3zw
         bR86obG97f7Ltnn4Ddn6AgXKC7TrzpLKlATv69uBHhcQlFNURNkkWF0I073L55GdT2W7
         gRYrPiu1hSNXYYivutXKqVtXGvf6iu3rT5p/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BFLdm+38l1RXMRuTGYQpFp9tuTkTwcz507zcdb8t68U=;
        b=ILgyskGCnx5ID8ABwTj0IQvQC++oc/sLpLeOa+iDFCCWwETqLp2867zz3AvVu5vbZb
         eyYJyMl6KgnsuIB6BH0Wt49y3QZ0EsO+D/aGaef1Hk3hisYrtPYbm48iLJ4bPlBYXE4K
         y+iJWpvAbTpA1hqCPcs0QkOPFWcMWXW3skieT2e+VcQo/k8fP3f02/pyLuD0iQKJNhwd
         OsQlblObd/Ocx2BhlyDZmclkFyqQbzgVyi6zeTUnIYTWhYhIf6d6PTO52bQDHBu5fWfH
         +UjAb/ZZVmHufYANlktlGtST/BzU1gjCpa3s+vBZL++nF+SYZSEwCT5P/w3dTGbZEHFL
         HCag==
X-Gm-Message-State: AOUpUlH1VKTl/29SJkftKx7LvMzMbGR3vrmTwI+GVKGO3h6Ia8BUGHzi
        TwHSIrCQsmq5GSEvFA55KzhIKA==
X-Google-Smtp-Source: AAOMgpey/uHujFDbQOkXjhabFj+YOE6Jb8qfGw5ItADbPKMd7YQWOw7r5aPUyZIfh+7B571pyCll9g==
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr2974282wmf.1.1531467054496;
        Fri, 13 Jul 2018 00:30:54 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id o13-v6sm4745973wmc.8.2018.07.13.00.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 00:30:53 -0700 (PDT)
Date:   Fri, 13 Jul 2018 08:30:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH 2/6] mfd: rave-sp: Fix incorrectly specified checksum type
Message-ID: <20180713073052.GN4641@dell>
References: <20180707024108.32373-1-andrew.smirnov@gmail.com>
 <20180707024108.32373-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180707024108.32373-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2018, Andrey Smirnov wrote:

> RAVE SP firmware covered by "legacy" variant uses 16-bit CCITT
> checksum algorithm. Change the code to correctly reflect that.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/mfd/rave-sp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
