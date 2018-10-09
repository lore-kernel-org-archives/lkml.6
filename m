Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA85FC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D26214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjhTot1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D26214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJIR3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:29:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52340 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeJIR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:29:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so1250492wmw.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2xsRKZa1uKBHfwg4CzfLh8Ae3Yvsc3dg8c0uYfkL1M0=;
        b=HjhTot1Q0SWekRGU6jmnrr23jiE92siqk3YupJ9EFsya57Gdl4/FJyeLOG6IJ8V+vL
         UIRKi6EvdeSpikC28kMKfftCBQ0Ad23rT9N2AeSbuWNwwAg9e34+0ePvm33fHkVszjRJ
         Na74OuwgXENPZRFQ0esILAqPTaQmo6t1wJf9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2xsRKZa1uKBHfwg4CzfLh8Ae3Yvsc3dg8c0uYfkL1M0=;
        b=odjmX/+XlPiiILFiaAJ0Ia++u5mRe695/KI7TdSESOjPZJVKzi5HO2C53liwToIO1V
         jWM+3NUiUENE7z7q6YVF7IaeTsI/ThVcD5m5acDcqDQu6yy59eKtVWfO4XYMqhZ3/417
         i2sm+HogvQFSC7cLMwLJEP6gKIiOEWzv810y3hkZd64kAweD7SvnnHQMYHssbXOYoUB2
         I12xA9CiFgweyqDPUC8xHehXn9J0Za2pJB2Zg9CI0eNLh894P0lxsApoiWGhrJLv52Lm
         QO2+obTNKo6l729NJWkPy3LdsrINUQde8rxkufLPdQLPAenErHkrMkDqAKco/+eAeKEE
         NayA==
X-Gm-Message-State: ABuFfoi6tBm9gxoqlaJwp+g60IEbN8n+EXA9wuF6233gKr7q3EAPw7st
        uWMNpRduwoaP+5uB06MODzds5g==
X-Google-Smtp-Source: ACcGV62g0TXqozQx1bfPff7fD/TcYC+Btuy8p11+uQHDFuzbZrCBTUKU/pAq5rZvWcQ+7MwqnLDYdA==
X-Received: by 2002:a1c:d750:: with SMTP id o77-v6mr1348470wmg.110.1539080007207;
        Tue, 09 Oct 2018 03:13:27 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id 78-v6sm920779wma.38.2018.10.09.03.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 03:13:26 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:13:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Emil Karlson <jekarlson@gmail.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: cros-ec: copy the whole event when msg->version is 0
Message-ID: <20181009101324.GL4939@dell>
References: <20180927092427.507-1-jekarlson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927092427.507-1-jekarlson@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018, Emil Karlson wrote:

> Commit 57e94c8b974db2d83c60e1139c89a70806abbea0 caused cros-ec keyboard events
> be truncated on many chromebooks so that Left and Right keys on Column 12 were
> always 0. This commit fixes the issue by restoring the old semantics when the
> protocol version is 0.
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Once you guys have all reviewed, agreed and tested the patches, can
you please send a final version with all of the Acks pre-collected
as a separate (not threaded/attached to this thread) submission
please?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
