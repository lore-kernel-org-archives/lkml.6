Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22518C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC23C20666
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AyADrIuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC23C20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeI0NH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:07:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44866 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbeI0NH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:07:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so1169738pgu.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 23:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=JLSYVhJlDA0FsUQmCUBZqdFzMAGSOmjM6ShNUmwWVwU=;
        b=AyADrIuVK2yoN3v6nPngeWweFqt7dOe8jPTHd6ETEsp9EN4YjvMBxT3ztuk2ZZ8eFt
         yw89DHtlSPoIXlTYy+IHEtp++up3pfMK190LUk/1SLEz5hAz8M6CmTnF0Ue6Wdlf6g+R
         NfPeTJxARVsu9Wj9vapgRKBmQErzPbyWUakdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=JLSYVhJlDA0FsUQmCUBZqdFzMAGSOmjM6ShNUmwWVwU=;
        b=jX/kU2/+FxMcWO9bTshErKL4qS+y29Bmq17bnkrTEXOlfSKrJ17th1k8wbFrmqZM5s
         iKkiPzTEWMCYvimE8apBhiYbaQSISpHJgDcGVAqbs/udaV9t4/pBgNV7mZMd2GNa3vTa
         83UznBjvrnclAnskN6vMEWsU5U14FtARkGHCuP/woO6FpyxcKmShuvaxD3P5cW6BXS26
         y9xDjifFNXhZzZLVuxozKvPZmcXs+2ZiO3weZ3MguyWuLXq+nTInrCOXUAH85eRLQ7+j
         0PNKL2mvHOo8vO4ydkCUdiA7jxtVjjZClM5MTomXkEs8An4pkCEGBhO54eXaIrIj5fmK
         YIqg==
X-Gm-Message-State: ABuFfojzgVaiZjY/BFYT+ZHosddrqrvz9wclgTgZX/kZBEhm9NIWmwsT
        ptTd34W3/amfaA3fHTXfsmQZKemDT34=
X-Google-Smtp-Source: ACcGV62z6zOwN+C+abjGO9QAXBPDm3o+76xFacVSP5VoQOr5a3e2khFkL+dquJ4x3X2RD/cpC1JiNg==
X-Received: by 2002:a62:f58a:: with SMTP id b10-v6mr9854308pfm.253.1538031074595;
        Wed, 26 Sep 2018 23:51:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id k26-v6sm2169935pfb.167.2018.09.26.23.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 23:51:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Timur Tabi <timur@codeaurora.org>, linux-gpio@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180921103604.13361-2-ricardo.ribalda@gmail.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com>
Message-ID: <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
Date:   Wed, 26 Sep 2018 23:51:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ricardo Ribalda Delgado (2018-09-21 03:36:04)
> Current code assumes that the direction is input if direction_input
> function is set.
> This might not be the case on GPIOs with programmable direction.
> =

> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---

Looks OK to me visually. I haven't tested it because I don't have access
to the locked down hardware anymore.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

