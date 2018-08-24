Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B98AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9466A2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QgCtAx1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9466A2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeHXKSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:18:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33518 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeHXKS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:18:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so4084277pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=2vqpk+JqxItkCV2F7FCziQOSKJfkulTl+Fco7HH8gho=;
        b=QgCtAx1khYzIZSk9kvXmpUg/XolG7l6pVnGH2eQzMqfD6+WyK2h4Zd/351ktnwrKxX
         7vr8gYaiwnodJWxXcgB6BvJgO4Jsm092r5RVHN5z84/Z9zxHyXWKM26sUlteXWVCQoVg
         0lWdNc2fMyR1jmtV5lhL5RUC7weHUWZ9fgl+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=2vqpk+JqxItkCV2F7FCziQOSKJfkulTl+Fco7HH8gho=;
        b=P96S9gXNNGWMFvDIQcIhdhBoCw6w92gqWyseJV1R+CgztCupB4FIISgRWsNWKhhbqJ
         8NaJ6+3E84bD0vaO6LGydd1vJMJWGGuDcwNS0H/72KHGfu4PVfQImztKDxFoh3qCNEXH
         Aqso5BFLXNxVZvYkziZRlNGNONfVtp8+gCGZ5se3yNoS2oRBw3MeLEyqjX+WqRatVsX9
         xUqeZzPyOALrfBbbkBTLPwRpoe805ojW0D+Ot+gWtFgpFbMcJrvUqAI4yAWrvNaN+B/a
         xlJAbt368LdhiDjosP/cNQF75aK5jh15H3HL0Ra+04xzw6s4ni73X/ZLgpdLDNF4flUX
         SEeQ==
X-Gm-Message-State: APzg51DwDCqFku7TI8ITJ4EXGCa8rOFduUyBohh/l4j86S/QS2cfBDW6
        4DUucrlgkFHnTIxkrqXVAO5Azw==
X-Google-Smtp-Source: ANB0VdbsFKj5dVs+U5dK6C9ySbHQ32AJAIMGeKJ4KNPSaS2v76ej7Sw0RX6HO/Zw1KqxxABsG5Uw3A==
X-Received: by 2002:a63:485a:: with SMTP id x26-v6mr352755pgk.375.1535093115206;
        Thu, 23 Aug 2018 23:45:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 22-v6sm12893370pfl.126.2018.08.23.23.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 23:45:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vikash Garodia <vgarodia@codeaurora.org>, andy.gross@linaro.org,
        arnd@arndb.de, bjorn.andersson@linaro.org, hverkuil@xs4all.nl,
        mark.rutland@arm.com, mchehab@kernel.org, robh@kernel.org,
        stanimir.varbanov@linaro.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1535034528-11590-5-git-send-email-vgarodia@codeaurora.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
 <1535034528-11590-5-git-send-email-vgarodia@codeaurora.org>
Message-ID: <153509311396.28926.9155836717358532427@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 4/4] venus: firmware: register separate platform_device for
 firmware loader
Date:   Thu, 23 Aug 2018 23:45:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vikash Garodia (2018-08-23 07:28:48)
> From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> =

> This registers a firmware platform_device and associate it with
> video-firmware DT subnode. Then calls dma configure to initialize
> dma and iommu.

Yes, but why? Commit text isn't supposed to say what is obvious from the
code.

