Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333FAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D741420673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orhR8VVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D741420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbeK3B4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:56:52 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37082 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbeK3B4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:56:51 -0500
Received: by mail-io1-f66.google.com with SMTP id a3so1777634ioc.4;
        Thu, 29 Nov 2018 06:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTIQHLyIo/rgKRzm7DKe5FKqXnh78m003nNDLnb7Zas=;
        b=orhR8VVEl/6x6eLR+sYuXvgISQIeGVY8wUqbdZtHNt5ETp5P0RSyOYBDA6X2xecoqY
         5Grxae5sJGpbso888psfprt5SquelIAiOwo64JsHKO0VmzcpwtB3eFr//3syl4GXPeQr
         VHK8BRfr955GptjFXQSnpY8RwQ/zjt+a3zG+gblqFQtRiKKObDOnsAaDnVzhEZuVjY4Y
         9eMwkLcgHFlaDPjUuFpdbYZT3ZbIWFScb8y6rAXsRicbymX6v9qoer4HIVumC0HOnGpr
         YnrmODHHSDrbJ5YhKM7MNA930SrTbPjXjTw+GUd5wwYkJk9vWJdVofQZxSc73LR86ReH
         EngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTIQHLyIo/rgKRzm7DKe5FKqXnh78m003nNDLnb7Zas=;
        b=hy2ttnIMXHwGAGYXtMI3aG3apgt3MURegK3vLgtDau3C4BaPTr8nwKd2smeF/RIZ9q
         0ueS9FYSygClGdyjV/mDKdQ8H61WihvR4zttlpx27xragvjvNlLvIPeoQjb567HhSGIn
         TEoWGoUIMSTqIJrMS7OsxxrV2g+tUeColkepDVH6Rt6poBLlE4AGtEKeb65sUeDuwDuX
         9Zbo9b0dS4hG/uzFaPeCZ09l5X/EN0Tap7MWFWcv9Q8rYQ0P5F2Z5BmxqaJBLGtrPkUT
         oykCJ4eam3FwKwVDZFaWBQEuY8E+ssnE5LyWGvwCFJKKSpuzWZXuIo9ayCrECTgFYXv4
         JFtw==
X-Gm-Message-State: AA+aEWava0dXnxnH5MsuHRHIVYll4TeNhbsaHT2IVxm6EpXcq44eO8F5
        ek6Bg/MBxBSaxK2ylwVae0HiZ4et6MVcubWViP79eg==
X-Google-Smtp-Source: AFSGD/UD30Mv5D4eT8PaV8Ww2ar6w22m74AtZwX3dG8IxF74R5Nslq5B4r0tRvD6vKI0gojN/QuvLfuPTK5QEVdwmFc=
X-Received: by 2002:a6b:bb44:: with SMTP id l65-v6mr1495608iof.185.1543503074576;
 Thu, 29 Nov 2018 06:51:14 -0800 (PST)
MIME-Version: 1.0
References: <20181129055559.159228-1-sashal@kernel.org> <20181129055559.159228-40-sashal@kernel.org>
In-Reply-To: <20181129055559.159228-40-sashal@kernel.org>
From:   Connor McAdams <conmanx360@gmail.com>
Date:   Thu, 29 Nov 2018 09:51:55 -0500
Message-ID: <CAM8Agx1xcN1P9y7r+Y7xgbt5Dqyk3ESU0QU7Ogc+c3iBsiHetA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 40/68] ALSA: hda/ca0132 - Add new ZxR quirk
To:     sashal@kernel.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch won't break anything, but it also won't fix anything
either. Not sure if that matters or not.
On Thu, Nov 29, 2018 at 12:59 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Connor McAdams <conmanx360@gmail.com>
>
> [ Upstream commit cce997292a5264c5342c968bbd226d7c365f03d6 ]
>
> This patch adds a new PCI subsys ID for the ZxR, as found and tested by
> other users. Without a way to know if any Z's use it as well, it keeps
> the quirk of QUIRK_SBZ and goes through the HDA subsys test function.
>
> Signed-off-by: Connor McAdams <conmanx360@gmail.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/pci/hda/patch_ca0132.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index dffd60cebc31..cc2bb0057810 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -1065,6 +1065,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
>         SND_PCI_QUIRK(0x1028, 0x0708, "Alienware 15 R2 2016", QUIRK_ALIENWARE),
>         SND_PCI_QUIRK(0x1102, 0x0010, "Sound Blaster Z", QUIRK_SBZ),
>         SND_PCI_QUIRK(0x1102, 0x0023, "Sound Blaster Z", QUIRK_SBZ),
> +       SND_PCI_QUIRK(0x1102, 0x0033, "Sound Blaster ZxR", QUIRK_SBZ),
>         SND_PCI_QUIRK(0x1458, 0xA016, "Recon3Di", QUIRK_R3DI),
>         SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
>         SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
> --
> 2.17.1
>
