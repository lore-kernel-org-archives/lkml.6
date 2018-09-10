Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8707CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF2420866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqjbBnrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF2420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeIJOFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:05:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55892 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeIJOFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:05:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so20713512wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=p7DX7vguRQm0CFMAfSRvZjCNkNU+/ez59LEQfbFt1VE=;
        b=bqjbBnrdY6Hwn2Ac+rM3dIBaQ5dCBtV50b10NYcZK3V/kUBUg1xOhRkwU17dQLNEOW
         Gz19YGrtGlMTyYpBgkTBDwJGmmrcV5Qj9GnCtfWAKOWeKRguTp5BvnHtMow92hyajdOK
         At952xa30d3Y0LTsRUQU2Wia99vcTeEO6B7sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p7DX7vguRQm0CFMAfSRvZjCNkNU+/ez59LEQfbFt1VE=;
        b=PtHqUUPGgMQX16Un+iJVOA9euRWbUMGZhd5ZCSoJEx7HBK5zdk90a0cEm9wkF/6xSq
         A5S2FzSp5cyEoBae6ONoqPykxk1bvn/FOmotIbuBi8/1CPTwz9QKtVUHIJ/pA5/gw1+y
         8/LTNq9cZ1GZDsL9T2qX9Dk3zgEYurWTkubadx3Rw5j5D9cHHcFFxv1Wywcj+xpHo4Ap
         2vqYYrt3XT/4HV/Wu8avuA4QV0eDpofkaKHW6kdBVV99wIvdSSYbeNQql6WMoOiYYU9F
         oFuiUELSf+mRYz7ZX7Pxl+mLPDCRlZZxWKk0coFDbCJoYM847sTvHx2qHS1DVc35B2At
         1hXQ==
X-Gm-Message-State: APzg51AC3CsJMne76gzPjnPZ2OsacQtgC3iRbleQ1Pa+dQ2G/OtpRVUn
        Z27lfcK9BIPEhgjWXD3zYJQ1Ug==
X-Google-Smtp-Source: ANB0VdZlLgzbuTyDxF0SfGaYev7lT5AMZI0qk5PTiUrfgXa3puNpRws+3L5htaLrNurYUiQlGhRybw==
X-Received: by 2002:a1c:a94d:: with SMTP id s74-v6mr18863wme.39.1536570729335;
        Mon, 10 Sep 2018 02:12:09 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id r140-v6sm24893029wmd.7.2018.09.10.02.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 02:12:08 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:12:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Benson Leung <bleung@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@chromium.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] mfd: cros_ec: Fix and improve kerneldoc comments.
Message-ID: <20180910091208.GH28860@dell>
References: <20180718160956.19864-1-enric.balletbo@collabora.com>
 <20180718160956.19864-3-enric.balletbo@collabora.com>
 <20180907075438.GB95655@rodete-laptop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907075438.GB95655@rodete-laptop-imager.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Sep 2018, Benson Leung wrote:

> Hi Enric,
> 
> On Wed, Jul 18, 2018 at 06:09:56PM +0200, Enric Balletbo i Serra wrote:
> > cros-ec includes inside the MFD subsystem, specially the file
> > cros_ec_commands.h, has been modified several times and it has grown a
> > lot, unfortunately, we didn't have care too much about the documentation.
> > This patch tries to improve the documentation and also fixes all the
> > issues reported by kerneldoc script.
> > 
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Applied, thanks.

If applying patches from other subsystems, you need to wait for an
appropriate Ack before applying.  Please send me a succinct
pull-request for this patch, so that we might avoid potential conflict
at merge time.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
