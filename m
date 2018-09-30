Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A077EC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17A9206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT7vOGdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17A9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbeJAEwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:52:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45572 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeJAEwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:52:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id h6-v6so11006552eds.12;
        Sun, 30 Sep 2018 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M84uQUmoquLZN4+1317sdKFeHw066QThjxoZ2MtmpwI=;
        b=XT7vOGdTzmt4xnbFaCMkPcETv+B87jpMH98ie+taCAXChaE/2S65ZKI0kjAY1MPs+J
         FH0sA+zofkVo0E8BttdxsIl7BD3Tuu0j+ZLezNqNsIeItDaGGVR3xw7k2dkOuBxfopYb
         L7AUa6enqoyA5Zs69vnLBjMQeFosu5n8Es5Wxjb8+DISfOEl2SGZAjqNPIQteBRHCF61
         kubb+QrlP68P4TpA5IghzROheESsqaMfjC/qWSGt7CpeodoCsHAq796P4t0I+EAEhvXk
         zTA/kFeBWdRMXoRZN1gUHGjjwEsMcbNZBI8Yt4xn9LQu3jxtcsTA6TWX1iLyzR07pUkR
         a1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M84uQUmoquLZN4+1317sdKFeHw066QThjxoZ2MtmpwI=;
        b=DfePgjxgKONY22Du4QIWyl0ECUScCDw3R6H1G/DZmBmZBKGWfHvXWNSFyagfg/V0Qz
         KFr1WRS3TzenzYVWrY2A7xv1tWpd76bLuyqq+sdboLbLipV+hx8xD+Qw5Rcg//OU1Yqr
         wElxGw8AWJAg+lXGd8ALxVo1I/v+WxxUioBXySnOV7f+DnfbsSYNUBA4qs2Fq60D8T/3
         s832lsVtqOwvLYUqAIGxuf0xk8Mqy3iFdlFf9kf1QW65BlxtqnCLgUtV8jSCALl4zPar
         OnPbSzFyOoXGe0x1m9Q89sW2ROgKzH82kMNXIYZP3AkdUhVmYo1Rg9+29kglca7lg8Sz
         msMA==
X-Gm-Message-State: ABuFfog/7Hjq9l9AKSDjyW+QczLvcRbgqIVtxCxemO6Bs+T0jXEHge8E
        ILLyh91THEJO1KwX05Lufos=
X-Google-Smtp-Source: ACcGV61wuPVyzUMRMSKYV/c8ktba0u+y7fnrLswlgrCfTlR+5yhQw90tfAB0fdF4Wc+39Zzdmcp0Tw==
X-Received: by 2002:a50:86f0:: with SMTP id 45-v6mr14538374edu.52.1538345874688;
        Sun, 30 Sep 2018 15:17:54 -0700 (PDT)
Received: from scappy (d54C34DC6.access.telenet.be. [84.195.77.198])
        by smtp.gmail.com with ESMTPSA id a9-v6sm4407140edi.26.2018.09.30.15.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 15:17:53 -0700 (PDT)
Date:   Mon, 1 Oct 2018 00:17:51 +0200
From:   Daan Wendelen <daanwendelen@gmail.com>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     netdev@vger.kernel.org, hkallweit1@gmail.com, nic_swsd@realtek.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] r8169: always autoneg on resume
Message-ID: <20180930221751.rd7wva3zolephj6q@scappy>
References: <1538319728.z22jaatdgh.astroid@alex-desktop.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538319728.z22jaatdgh.astroid@alex-desktop.none>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

I randomly opened your patch even though I have absolutely no idea what this patch is about, but I
found a mistake in one of the comments:

On Sun, Sep 30, 2018 at 11:06:39AM -0400, Alex Xu (Hello71) wrote:
> This affects at least versions 25 and 33, so assume all cards are broken
                     ...
>  	 * 1GBit link after resuming from S3. For whatever reason the PHY on
> -	 * this chip doesn't properly start a renegotiation when soft-reset.
> +	 * these chips doesn't properly start a renegotiation when soft-reset.
                       ~~~~~~~ 
I believe it should be "these chips don't"

With kind regards,
Daan
