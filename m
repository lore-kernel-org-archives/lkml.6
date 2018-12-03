Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32292C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE42F20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eRlAxrdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE42F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeLCWhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:37:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37708 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeLCWhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:37:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so7207375plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=Fc4pfkJwGkf6v+3rT6sVPrWelXtUkgVwrkeAcACPmuI=;
        b=eRlAxrdkaJ6RTMVeXSyqnHlHavxOx74oerMPgLI1dghNUKrw46lrCM8TYIHSufI3ZY
         QxdxjcgE3n48n4V2WIhqvtPm7gKDdbVf2ao37UtF+OcdhRj4ZVatlXdXPnsXFNonpG7j
         /bkrdQX2zsGRJQIhSTcjtQojjZrO7xwGWSzvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=Fc4pfkJwGkf6v+3rT6sVPrWelXtUkgVwrkeAcACPmuI=;
        b=ct+xjiJD1JFtEWThH6V5T9cgG+D7+2gDLI8p6G1jTMg7q3NX6OWdhMd8SYP5WJomt9
         7HmOQU6dtucKWdVVBupOEKECDPGnYe5WoFbYr6HZuPEoEHFr+7/MTwJ3Hn3zoCcVxipX
         +loLsbgkFnsxmyqMe63ZEpjjMY5EloI8p/DNoMZybCLuysIOSDWeV9a7qR8/DWtBCNPC
         uZ35vGH3F/e5ZNo5Bk5OL/OejSwBdUP8SRqdokcBbyem70+4tcB5RpRA8KODQoV6AmbP
         KfiBv3ProXFFi0SLyqFKGO9K7TTbaQO7vt/Ud3SX2aMFkktXMW7OGic4+EmsH8tewH97
         rssw==
X-Gm-Message-State: AA+aEWbi1CmlDRZJvhUzVYiVA0Mih9wE04GgSaPLWuvj9WkcKwmsNm+X
        uT3wqHtoGbMY8zSGfM+fKZSlMQ==
X-Google-Smtp-Source: AFSGD/VJ5edJ61ruJi9UcPa3B4nFJW+Wob4rqJiT8qWQ79HKa+Hv0Otm64a3DZg91DaQnpTyCglGpQ==
X-Received: by 2002:a17:902:43e4:: with SMTP id j91mr17235780pld.147.1543876658771;
        Mon, 03 Dec 2018 14:37:38 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id c23sm20918265pfi.83.2018.12.03.14.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 14:37:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181129221357.67417-3-evgreen@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
References: <20181129221357.67417-1-evgreen@chromium.org>
 <20181129221357.67417-3-evgreen@chromium.org>
Message-ID: <154387665743.88331.11858773205628128165@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 2/4] arm64: dts: qcom: msm8996: Fix QMP PHY #clock-cells
Date:   Mon, 03 Dec 2018 14:37:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2018-11-29 14:13:55)
> Move #clock-cells into the child node and set it to 0 to conform to the
> proper binding specification.
> =

> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

