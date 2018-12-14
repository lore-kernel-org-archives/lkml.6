Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55036C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAD4208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYvZWCkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAD4208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbeLNMWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:22:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36549 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbeLNMWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:22:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id a18so5635646wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yl6cND0R+UcEEiLBRHwktF96ShE8k/1tfoWu5tq0WD0=;
        b=YYvZWCkM3zTlxGrvUkR5LOqR5m76hnDBVQIiRSQ479uiOMgCraxz8TsbRTrWaJz5kW
         Xw5q0PuF8gYDq509mWjDXhIuZSeFyxizhMh4RvLAXD5B/BgiGbWVUjf0NIuH2xO123gK
         O3isET7c/OHm7yNaFA20KC4JPjTPjtfourDmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yl6cND0R+UcEEiLBRHwktF96ShE8k/1tfoWu5tq0WD0=;
        b=XBMOpLHQfswQPjZeDPu1vm3BxH9xd8/xY1PhXmRIlNtcYELc26dfpNrrtpvBQkpghF
         yoQgmuUo21roYa2PLEPArY8wreU8Y2fa3rt+eqieEO1NUBGVCZKKvnXutxtP4nHg3lrv
         2mO9vZ6ORkmAmKDooY7wfQTZNF/wY8g6V9V/H/ku6lo5D3VFDfOFUq7AsxVNWhlLRjv6
         g0SDVcGuEZqKWR6sSj6BTSAjcfNJcR9AHHZe4vZzyngTeevycwEL+F+XygtEnUmxdAk8
         RAusSA3HTRl8TCQ+zmi0DHXNBAzRaZ+jg6itZPlKEQSKzv7XpIfMtHXCHLE0mdk9CBd6
         R17Q==
X-Gm-Message-State: AA+aEWZYji/ddTxK0skvxF+LoPryZ7sm94RY325IqxszjFS8yYt/3EZo
        j3OkFbK729uq4aLOt8nT3XoSoQ==
X-Google-Smtp-Source: AFSGD/XLve2lf/uHJh93mhJCbM4iUYMmlIYnAe77FV7ajy783/KyPBXA8vK1FSX/l9rRc9sqFyPGyw==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr2967711wmd.63.1544790167153;
        Fri, 14 Dec 2018 04:22:47 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id o17sm6841521wmg.35.2018.12.14.04.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 04:22:46 -0800 (PST)
Date:   Fri, 14 Dec 2018 12:22:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v2] mfd: cros_ec: Add commands to control codec
Message-ID: <20181214122245.GU4497@dell>
References: <20181206040540.84632-1-cychiang@chromium.org>
 <20181214122156.GT4497@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214122156.GT4497@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018, Lee Jones wrote:

> On Thu, 06 Dec 2018, Cheng-Yi Chiang wrote:
> 
> > Add EC host commands to control codec on EC.
> > 
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  V2 fixed the wrong ancestor issue so the patch can be applied cleanly on mfd tree.
> >  Codec driver that uses these commands will be sent separately.
> >  Thanks!
> > 
> >  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
> >  1 file changed, 94 insertions(+)
> 
> Would be good to have this reviewed by some more Chrome people.

See this for reference:

  https://lore.kernel.org/patchwork/patch/1024985/

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
