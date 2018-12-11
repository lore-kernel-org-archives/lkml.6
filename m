Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82D8C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF20920672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iiGAUeht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF20920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeLKVwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:52:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44137 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeLKVwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:52:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so7763459pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=qnv4JXXM9Bgs8qgt3xUvHXHU1Z590lI1IuapUxLLpGs=;
        b=iiGAUehtiKxO6jox72BEneW5sxb/jRVlQur6ac1tqwzCzUz72AdTcDSavhDinptOob
         SBVKJLnYcVPX7EmMppUF60WfS36LpjzdWxzExB7m+dJ0IaL3GlZLuahAllT89X3XayEy
         8aK8occJW4T/spqyKmZUfh4XTlmX1fnh5SQRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=qnv4JXXM9Bgs8qgt3xUvHXHU1Z590lI1IuapUxLLpGs=;
        b=VZAGbnoc/VztIt41ISkNIkaoFjDAXzJw8CRMUSBcwp7UZKme6mYbS4Qho2DsXTsq2h
         N09El3U3aAP9GeLm08f9YXTeg547vXZqhfBGrW7iE/t2H9f9GSVQ4PdqaiycWX1mcE1X
         oh7Grwl/YfIQ8zM/9EuT7t2p66aJXxN8JM53nDCtuMfcrYAJwT1z7r0YlIGVrDGW7Wu4
         oEA9XOPMU8Mo0sny57+e9Ly0HMquvUYIP3dD9OYMaaB9WpBxbFYyQHYDZIjM6OnbCggw
         XNb5uAVQZfI9h53JzER/69nYDOFcHBRjQ6JKuqipbcZ/JjMb4eP1YRb5BZfQZt3RMMbw
         ZIPQ==
X-Gm-Message-State: AA+aEWbtIgf69C9XrVLdJST+UY673u9IEH5l0Cw45ra1Kr7dWRMeURJT
        l52jMd+IFLLh6ry5/Y1Udl7NQw==
X-Google-Smtp-Source: AFSGD/VFKbdy/O8vVhgUK4IgyActrk+4tzvwqCAFQLwFQ/PgJEbt+OuNPS6tHWGktNGjAOrSTQpuyg==
X-Received: by 2002:a63:4f5e:: with SMTP id p30mr16184528pgl.71.1544565164358;
        Tue, 11 Dec 2018 13:52:44 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m85sm23193667pfj.171.2018.12.11.13.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:52:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181211094938.25086-4-rnayak@codeaurora.org>
Message-ID: <154456516307.17204.16085800753150792219@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v6 03/10] soc: qcom: rpmpd: Add a Power domain driver to model corners
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181211094938.25086-1-rnayak@codeaurora.org> <20181211094938.25086-4-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Date:   Tue, 11 Dec 2018 13:52:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-11 01:49:31)
> The Power domains for corners just pass the performance state set by the
> consumers to the RPM (Remote Power manager) which then takes care
> of setting the appropriate voltage on the corresponding rails to
> meet the performance needs.
>=20
> We add all power domain data needed on msm8996 here. This driver can easi=
ly
> be extended by adding data for other qualcomm SoCs as well.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

