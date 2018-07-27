Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FB2C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634FB20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNabRNYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634FB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeG0Iea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:34:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35302 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbeG0Iea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:34:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so4390448wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 00:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G8rtzm0uxBiLjnv2qSJYkkOYhAYD+C0vakpuqE73G3A=;
        b=fNabRNYEMaCHQmc7D9OwUanNlTiQEZ84+1bdmyz1hKLexC64aGIx0P7Oy/c7JaMyiW
         Atvg1MfR5la4SVc5elufeWIQilM+CrbCYGTIOLtF+8YEGJzKINo5vbFZbqSC6pKYu140
         4f1ejBPOauUswPaeiORZEWAJn+GV32YtaQHdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G8rtzm0uxBiLjnv2qSJYkkOYhAYD+C0vakpuqE73G3A=;
        b=hKlwvMsUjWYXacb5POHjiGg+k1LzUg1Ts/bPixQe32pkBQYR2n21QTJGw7p7zvI7k2
         xgjmfaIG4+Sbx0Iio7BeJTgCSZJP5lIFfRlm+6k57bx4czqMvPW9LjMjH9AWRyrZEA4t
         RlqLpWct+wIy6djpuxcKsEIr3+fLoin4ZmxtzDH/FCWh7SIwlEM8BPvXJB5waRmcdqrk
         pgxFLYhaaKr3yCFuyJyxdZDbDapm/JSd010TYrcAYe/H2EJMmJ4VfrKBu33ZE+RlKBlj
         /4+KxHSMArr94TB9LpQVr1UQx95d+aaZh2JKCNAT1TfgZkBkqoCTQ/MdqabDXB7Nvh1t
         q9fw==
X-Gm-Message-State: AOUpUlGe6lgbDm3in1fKLruwXGour0+aiEOucpsdUqa8HV506Vho8EQ4
        II5aZ5i5modiHiaWtdx1/FS/2A==
X-Google-Smtp-Source: AAOMgpfcVhi5A7majwGUGdERSTRZC9Xx++32TfXnQKiqxgWPn3GEMSESLATAbC64tzhX9OzC6CohMA==
X-Received: by 2002:a1c:9290:: with SMTP id u138-v6mr3654328wmd.52.1532675637935;
        Fri, 27 Jul 2018 00:13:57 -0700 (PDT)
Received: from dell (host109-153-79-7.range109-153.btcentralplus.com. [109.153.79.7])
        by smtp.gmail.com with ESMTPSA id q8-v6sm1721692wrj.97.2018.07.27.00.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 00:13:57 -0700 (PDT)
Date:   Fri, 27 Jul 2018 08:13:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Benson Leung <bleung@google.com>
Cc:     dmitry.torokhov@gmail.com, linux@armlinux.org.uk,
        bleung@chromium.org, enric.balletbo@collabora.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch (mfd, chrome) due for the v4.19
 window
Message-ID: <20180727071354.GC4628@dell>
References: <20180709011324.GA86474@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180709011324.GA86474@decatoncale.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Jul 2018, Benson Leung wrote:

> Hi all,
> 
> Please see this Immutable Branch which moves the cros_ec_i2c and cros_ec_spi
> transport drivers from mfd to platform/chrome. Changes in arm are a simple
> rename in defconfigs. Change in input is a rename in help text.
> 
> The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:
> 
>   Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git tags/ib-platform-chrome-mfd-move-cros-ec-transport-for-4.19

Pulled, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
