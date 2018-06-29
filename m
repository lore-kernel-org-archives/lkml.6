Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5345FC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE2F27F77
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q1cBYb/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE2F27F77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755544AbeF2N4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:56:31 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38168 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeF2N43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:56:29 -0400
Received: by mail-lf0-f66.google.com with SMTP id a4-v6so6867656lff.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cNb1WNpvwbLGlcZs7E9t/AsuMN9NuK4tJ44ZdhpAazE=;
        b=Q1cBYb/Pe0PIye22ICQW1U9jyxEAaFOtiH7FuFOFJrpDr6dogc8F7brwIag9QHqXTg
         ihqTvhdqDxkfLkBB7oSBqE0wyp2N77gNyHllEUtLf4GGq1v0Yb7OFwnGpmEheWvBHi4U
         UwWk8OyHYvb2+6poRrnjnFU+fwXaZImvw1374=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cNb1WNpvwbLGlcZs7E9t/AsuMN9NuK4tJ44ZdhpAazE=;
        b=c/H68957Dr1I7GD5en1YeMkq2Fay7s3ylbR+W2Ss3crC1caTt5sRZ6aJ0kNWMglOj6
         FCRi7fSuXg50vsRHCnG05XLYeGwypaXtxztndnZZBpm78vO/Mq1aoKd2BkS9ycsYpTIc
         qal2/VzKkehGSyi3Tg63QLOkFnU3GQ8O3MllPPWDnuscGrDI8o9yufkw9emC6fYxp4kj
         c+gCkg9981EjlvpT3W1QYily6ojkBSq50AzuhadQxLh7+7d4c4e+HMPqeYZngytBjqC9
         /aJhbzrnikv2fG0i52W0LedFX/PiPWsc84FTMXYmC6RLCzcKWxzlbDItIo6Kilh+5JkC
         kOLA==
X-Gm-Message-State: APt69E32uddRhS9Ioykid1nXHZTqTL/fSJMhT4YPyjujpBCtbtdwvAKF
        55SAp8w9Q4fW8WSI9/aSWRWadg==
X-Google-Smtp-Source: AAOMgpex9aWSU9Ow62FqEbeo4jov8ZOk6ovhdFgWH2+JXBqN1Ri27tS6+picAPUXAXYt3agY43gGJw==
X-Received: by 2002:a19:8f10:: with SMTP id r16-v6mr4901488lfd.92.1530280587985;
        Fri, 29 Jun 2018 06:56:27 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id q66-v6sm1745604lfg.17.2018.06.29.06.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 06:56:27 -0700 (PDT)
Date:   Fri, 29 Jun 2018 15:56:25 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     alagusankar@silex-india.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/3] ath10k: sdio: use same endpoint id for all packets
 in a bundle
Message-ID: <20180629135625.GA19076@centauri.lan>
References: <20180620084222.3521-1-niklas.cassel@linaro.org>
 <20180620084222.3521-2-niklas.cassel@linaro.org>
 <87zhzdersm.fsf@codeaurora.org>
 <87vaa1erlj.fsf@codeaurora.org>
 <20180629131141.GA26446@centauri.lan>
 <87r2kpem4o.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2kpem4o.fsf@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 04:51:51PM +0300, Kalle Valo wrote:
> Niklas Cassel <niklas.cassel@linaro.org> writes:
> 
> > On Fri, Jun 29, 2018 at 02:53:44PM +0300, Kalle Valo wrote:
> >> Kalle Valo <kvalo@codeaurora.org> writes:
> >> 
> >> > Niklas Cassel <niklas.cassel@linaro.org> writes:
> >> >
> >> >> All packets in a bundle should use the same endpoint id as the
> >> >> first lookahead.
> >> >>
> >> >> This matches how things are done is ath6kl, however,
> >> >> this patch can theoretically handle several bundles
> >> >> in ath10k_sdio_mbox_rx_process_packets().
> >> >>
> >> >> Without this patch we get lots of errors about invalid endpoint id:
> >> >>
> >> >> ath10k_sdio mmc2:0001:1: invalid endpoint in look-ahead: 224
> >> >> ath10k_sdio mmc2:0001:1: failed to get pending recv messages: -12
> >> >> ath10k_sdio mmc2:0001:1: failed to process pending SDIO interrupts: -12
> >> >>
> >> >> Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
> >> >> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> >> >
> >> > You have Alagu's s-o-b first so that implies Alagu is the author. So
> >> > should I add From header for Alagu and add you (Niklas) as
> >> > Co-Developed-by? Or vice versa?
> >
> > Hello Kalle,
> >
> > It is not always obvious how the combination of git-author
> > and Co-Developed-by should be:
> > http://lkml.iu.edu/hypermail/linux/kernel/1801.2/00988.html
> 
> Yeah, that's true.
> 
> > Alagu deserves most credit, since I have simply taken parts
> > of a very big patch and split it into smaller pieces.
> > I tried to do the right thing by having his Signed-off-by first.
> >
> > Let's go with your suggestion and add a From: header with
> > Alagu's email, and a Co-Developed-by tag with my email.
> > (Note that both Signed-off-bys are still needed according to
> > submitting-patches.rst)
> 
> Ok.
> 
> > Do you want me to resend the patches with these two lines
> > added, or can you fix them up manually?
> 
> No need, I did that already in the pending branch. Please check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6b23bd067990df1cc1e9a4c28327393a7a3ba718
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=bf83a5c572e0737e59e026c989b190b4e52d2ef4
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=218f924d80b76520a4e60eead5e89f3ebd2e86c1

Hello Kalle

It looks good :)

Regards,
Niklas

> 
> -- 
> Kalle Valo
