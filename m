Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB89C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F287246D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zomj1Qbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F287246D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933829AbeFVRjZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:39:25 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44386 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933468AbeFVRjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:39:23 -0400
Received: by mail-pf0-f196.google.com with SMTP id h12-v6so3533877pfk.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=i3y4z4mJChoSOZTuU4I6y7V3f6cbpCIPsF1nt0GBgqQ=;
        b=Zomj1QbeNEooaoBRAKKZTrERhS22UxArALtZzhRHLl1udP4AcxvgWR6aI/6SXMVb26
         bWRaf3bQAgM3K7RodBRIej78Aw+NLoACO+kf8K0tJzUZ9prK11OGfwDI+0ZYFBTOef89
         ujYz/HuxQ6ovNC8jYIGblXHEi5JySQxRwuHVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=i3y4z4mJChoSOZTuU4I6y7V3f6cbpCIPsF1nt0GBgqQ=;
        b=JXJ5OkHFsEJ89eJBRurB4Sxaa9xZVQOkXTD3z4HfPHSnxYY8nDrrb3ky/QZsVFW7Hl
         kiC+qvcWQQyu0PB2fzHAgO0q38+hgs1hZ61G5auvCt6zqcrt8kBVHTD1fn7z4MdQH21r
         TdQ7jEaVUrknqxlYMSsuJIa1Nk3ffKSXrfDBLyOCPzpz6u25kcbqXHXOFfMtXeW+5cDH
         ttj7Axkdy6N0cI5wLF4kI/bhzTWEaAlXV3COrBFTXzFFbWceKvxbwopYpbXPlz+vSgWN
         dF0fG9LUXKAInEp4CJumwgf59Soeuho+MOYirpsAnKPH07j6WCNCI430PMdanY7u/EWn
         bsFg==
X-Gm-Message-State: APt69E1VkYO5P3otODYrH/rX7W+jR3VA/sCQ6dnwsob6sCl8CGiXHQuN
        ivB53OmUOAjxHaAgJRblP8fXLQ==
X-Google-Smtp-Source: ADUXVKJ2L4lkisgntdqZG7enYssLtt0XhqHjObB+kX41aoAtxVh6UrO0rU4ffpslXPtIWKu9dDlQ0g==
X-Received: by 2002:a65:5b0a:: with SMTP id y10-v6mr2308179pgq.112.1529689163306;
        Fri, 22 Jun 2018 10:39:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id j15-v6sm18280496pfk.40.2018.06.22.10.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 10:39:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180622165454.GA10336@builder>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
References: <20180518224750.232742-1-swboyd@chromium.org>
 <20180622165454.GA10336@builder>
Message-ID: <152968916153.16708.10037419184008772073@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] soc: qcom: geni: Make version macros simpler
Date:   Fri, 22 Jun 2018 10:39:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-06-22 09:54:54)
> On Fri 18 May 15:47 PDT 2018, Stephen Boyd wrote:
> =

> > This macro doesn't work, because it hides a local variable inside of the
> > macro to hold the version and that variable name is called 'ver' and
> > 'version' sometimes.
> > =

> > Let's change this to be more explicit. Introduce three macros for the
> > major, minor, and step of the version, and require callers to pass the
> > version in to get the part of the version out. This way we don't hide
> > local variables inside macros and things are less evil overall.
> > =

> > Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> > Cc: Sagar Dharia <sdharia@codeaurora.org>
> > Cc: Girish Mahadevan <girishm@codeaurora.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> =

> I was expecting that someone referenced this macro, but I guess that's
> coming?

The SPI driver does.

