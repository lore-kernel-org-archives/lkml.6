Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312C4C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF16F27D8E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mvv2O5y6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dkd5af9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF16F27D8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966276AbeF2NwG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:52:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38028 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966099AbeF2NwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:52:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A442360AFF; Fri, 29 Jun 2018 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530280323;
        bh=wB+ps2iQHjTOVqBt7sbo2j0LMLRQd4LJWYRG0GtbDGc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Mvv2O5y6Q8KwRytLD67my2p00X/GreXqnh6DxYVS0oftJS5dlweXSHWQFPcPWq53A
         c8NSUAhPZnmGEcElfAkhy4ngWoDM6OXxMQMTDwJgD78QG1zr3xEut/3KlfPkb6Qnbt
         VFSZugzXj5XQNbFmW+p09sDGSXBQsmQWGcpNRnr8=
Received: from x230.qca.qualcomm.com (85-76-151-243-nat.elisa-mobile.fi [85.76.151.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23DE8601EA;
        Fri, 29 Jun 2018 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530280319;
        bh=wB+ps2iQHjTOVqBt7sbo2j0LMLRQd4LJWYRG0GtbDGc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dkd5af9m74omiKl87lLBmr9629RcGi82Awjv9u2W7ExII094MDoMCR+/0lSa0XADz
         Kkw7XZbuzFVyg1U1pil0/svfg9golC6b015kwowxm4123DIZ0MDDL9ytCptkRRLU4k
         VjgicEXvtHOl4N56pe9ROkBsOHbrHtlKtPB5BZYg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23DE8601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     alagusankar@silex-india.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/3] ath10k: sdio: use same endpoint id for all packets in a bundle
References: <20180620084222.3521-1-niklas.cassel@linaro.org>
        <20180620084222.3521-2-niklas.cassel@linaro.org>
        <87zhzdersm.fsf@codeaurora.org> <87vaa1erlj.fsf@codeaurora.org>
        <20180629131141.GA26446@centauri.lan>
Date:   Fri, 29 Jun 2018 16:51:51 +0300
In-Reply-To: <20180629131141.GA26446@centauri.lan> (Niklas Cassel's message of
        "Fri, 29 Jun 2018 15:11:41 +0200")
Message-ID: <87r2kpem4o.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niklas Cassel <niklas.cassel@linaro.org> writes:

> On Fri, Jun 29, 2018 at 02:53:44PM +0300, Kalle Valo wrote:
>> Kalle Valo <kvalo@codeaurora.org> writes:
>> 
>> > Niklas Cassel <niklas.cassel@linaro.org> writes:
>> >
>> >> All packets in a bundle should use the same endpoint id as the
>> >> first lookahead.
>> >>
>> >> This matches how things are done is ath6kl, however,
>> >> this patch can theoretically handle several bundles
>> >> in ath10k_sdio_mbox_rx_process_packets().
>> >>
>> >> Without this patch we get lots of errors about invalid endpoint id:
>> >>
>> >> ath10k_sdio mmc2:0001:1: invalid endpoint in look-ahead: 224
>> >> ath10k_sdio mmc2:0001:1: failed to get pending recv messages: -12
>> >> ath10k_sdio mmc2:0001:1: failed to process pending SDIO interrupts: -12
>> >>
>> >> Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
>> >> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>> >
>> > You have Alagu's s-o-b first so that implies Alagu is the author. So
>> > should I add From header for Alagu and add you (Niklas) as
>> > Co-Developed-by? Or vice versa?
>
> Hello Kalle,
>
> It is not always obvious how the combination of git-author
> and Co-Developed-by should be:
> http://lkml.iu.edu/hypermail/linux/kernel/1801.2/00988.html

Yeah, that's true.

> Alagu deserves most credit, since I have simply taken parts
> of a very big patch and split it into smaller pieces.
> I tried to do the right thing by having his Signed-off-by first.
>
> Let's go with your suggestion and add a From: header with
> Alagu's email, and a Co-Developed-by tag with my email.
> (Note that both Signed-off-bys are still needed according to
> submitting-patches.rst)

Ok.

> Do you want me to resend the patches with these two lines
> added, or can you fix them up manually?

No need, I did that already in the pending branch. Please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6b23bd067990df1cc1e9a4c28327393a7a3ba718

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=bf83a5c572e0737e59e026c989b190b4e52d2ef4

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=218f924d80b76520a4e60eead5e89f3ebd2e86c1

-- 
Kalle Valo
