Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211C2C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19592089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHDPCSUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19592089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeJIQMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:12:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54893 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIQMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:12:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so994074wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 01:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=u4sHVfV/3+1Y4a13xsy8rs1uphbzPeaCo3PCqYJAia8=;
        b=WHDPCSUi8ZhtR0EOLCtQGwk3+3x2P1d44TstoeX0cBdVQbURp8V/Kqc2b9MwlNGkFu
         NgsM8Hzg563b6IDr7LTpktU+v9ycZGUNLjdFq3cFU7jgDMvOhQCx2Q8mbkUOXcwhXcmh
         ZjDC6rgiiQiyjmlCBaydw4Fgki+IWYK6P/yAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=u4sHVfV/3+1Y4a13xsy8rs1uphbzPeaCo3PCqYJAia8=;
        b=rzoI9h9+d3UBBAz7PqXLCJkTz/jm6kKQJzPV+apjgT7NPBI3uiFQPInQJwExpFwAQ6
         WO5auEYYuLmQc4jPtejf5JaAZlPk9buoyVVnE7dWCJ4kEO5C0eiuzDElNv8YF0OWASpL
         H0s7G5orHpFdxOKWTMV1HwwGa9LHusTQ7oFEYejzunJ49cnAGDjNnbEJ5JkLjVEhD3d0
         jpZ2jTOkRhp3E9xQ1EVDMTDyI4g+oZR6Cg0DdFMrssoFsaIw/NC19pxx84jp4Y1IcsXV
         t+vnrFS0nkehHyawSMbcJZmOQ8Sor28Y2l7C34w0gDOvG2/64+M/sUt+ifSGsWHpliSa
         W3sA==
X-Gm-Message-State: ABuFfojutKGMy82zX+P18PESnRB8lOx8CtMnKBp15mKWw/gzjasQwPfM
        4honBKDAk41oynqfc0AvCEvtYw==
X-Google-Smtp-Source: ACcGV62nTP7Av90jOpbvIGItJldvLW2iw01IvQFFjQ5dqklU9tVhmZOYcR+2T97QdMOCSjy5lUgeHQ==
X-Received: by 2002:a1c:d712:: with SMTP id o18-v6mr1205216wmg.54.1539075391314;
        Tue, 09 Oct 2018 01:56:31 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id b81-v6sm10769667wmh.47.2018.10.09.01.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 01:56:30 -0700 (PDT)
Date:   Tue, 9 Oct 2018 01:56:28 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        dmurphy@ti.com
Subject: Re: [PATCH 1/3] mfd: ti-lmu: switch to gpiod
Message-ID: <20181009085628.GA4939@dell>
References: <20180911210133.GA32497@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911210133.GA32497@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Pavel Machek wrote:

> Use new descriptor based API instead of the legacy one.
>     
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
