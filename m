Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38929C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B4E27F31
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ffj05x53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B4E27F31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753773AbeF2NLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:11:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37715 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753483AbeF2NLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:11:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id c11-v6so7274857lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BRCR4JiNm1EULTPUvmgv6Vpb5Pg7mh5FheCQdlYebLI=;
        b=Ffj05x53bYI9FondK/jvuKHeQ6WkoZC/B1FpYnBm4EKPS3niV9dqfPlRKWsLTNgVpy
         +gj0kl0tGV4Icu1M27N3XfjCPT1DDdY2FSsEA5oPXJFyGinxfuPpAJXNWMD23PsVTmYm
         DPp3G9xIE4ywEdeVIgbOSB9lys/GSymkmc79I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BRCR4JiNm1EULTPUvmgv6Vpb5Pg7mh5FheCQdlYebLI=;
        b=gEWbTROJzeCayQ1AwuDYS00FWCFNyPcr7Tb6fkZPOWW6fDsDbXlIuN7F693nAHlKiE
         KwctjBgoCW63MibICrrlvH4aKjvmMawE7Tt/CG1XyedsNZbV+ZTWuzSiebtR08qdgbBx
         p6bHWRIDe2kXb2iER2HG0/iU6Mn7HQ6I+j9+b1X9+1YiIRQsBkz6w/o+pWhqwb5915b/
         ZHyiS5DXCFN/JKtacMFP5lRLIrguWiUDwLPF5QhggOeeTLO3EsTocOK+4uMQ+cgAvH71
         fBKlkA0Matam4JknaI+6CgA8NjIAWRE1Q5dMJjCJi8gSlhEy+xXrWx9t/R1zg+jBfj6z
         1Oew==
X-Gm-Message-State: APt69E0TcfHRLdf3bLIr3EbyqDZ6PIaqDKa4CqWeCihhddMqtJVPeErX
        3HssBi2oXqBay6hEX9pyopGfFQ==
X-Google-Smtp-Source: ADUXVKIbjdESXKsELYX2ggLbrvoPJuUrR0OBAHudSifJDYpXAKwzEI1dZ5Kt18gUahhSw8FjJzQMww==
X-Received: by 2002:a2e:3101:: with SMTP id x1-v6mr10749067ljx.8.1530277904329;
        Fri, 29 Jun 2018 06:11:44 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id r19-v6sm1546539ljg.43.2018.06.29.06.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 06:11:43 -0700 (PDT)
Date:   Fri, 29 Jun 2018 15:11:41 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     alagusankar@silex-india.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/3] ath10k: sdio: use same endpoint id for all packets
 in a bundle
Message-ID: <20180629131141.GA26446@centauri.lan>
References: <20180620084222.3521-1-niklas.cassel@linaro.org>
 <20180620084222.3521-2-niklas.cassel@linaro.org>
 <87zhzdersm.fsf@codeaurora.org>
 <87vaa1erlj.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vaa1erlj.fsf@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:53:44PM +0300, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
> 
> > Niklas Cassel <niklas.cassel@linaro.org> writes:
> >
> >> All packets in a bundle should use the same endpoint id as the
> >> first lookahead.
> >>
> >> This matches how things are done is ath6kl, however,
> >> this patch can theoretically handle several bundles
> >> in ath10k_sdio_mbox_rx_process_packets().
> >>
> >> Without this patch we get lots of errors about invalid endpoint id:
> >>
> >> ath10k_sdio mmc2:0001:1: invalid endpoint in look-ahead: 224
> >> ath10k_sdio mmc2:0001:1: failed to get pending recv messages: -12
> >> ath10k_sdio mmc2:0001:1: failed to process pending SDIO interrupts: -12
> >>
> >> Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
> >> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> >
> > You have Alagu's s-o-b first so that implies Alagu is the author. So
> > should I add From header for Alagu and add you (Niklas) as
> > Co-Developed-by? Or vice versa?

Hello Kalle,

It is not always obvious how the combination of git-author
and Co-Developed-by should be:
http://lkml.iu.edu/hypermail/linux/kernel/1801.2/00988.html

Alagu deserves most credit, since I have simply taken parts
of a very big patch and split it into smaller pieces.
I tried to do the right thing by having his Signed-off-by first.

Let's go with your suggestion and add a From: header with
Alagu's email, and a Co-Developed-by tag with my email.
(Note that both Signed-off-bys are still needed according to
submitting-patches.rst)

Do you want me to resend the patches with these two lines
added, or can you fix them up manually?

Regards,
Niklas

> 
> Ah, the same issue is with all three patches. So whatever we decide,
> I'll do the same changes on all three.
> 
> -- 
> Kalle Valo
