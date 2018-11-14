Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06396C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51F120896
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oA6gsNKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51F120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbeKNMPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:15:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41497 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeKNMPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:15:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id p16-v6so6962994plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 18:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lRWLFcidtSQVS0zg3RNQj2AoK+XfyU3o7oUoQYHTt6w=;
        b=oA6gsNKmxYedmmD7L9E0PEZBWLInXI/ZeZaGAMGzg6OKmMV2DwX+XxF18uxVaHCvnu
         +rnVuI7a9Wcdi+vfAH8MrdQWvleufPoqhS82BTcyL6/R63CKrqo3XDsY55NIPh2cRhuf
         9k1uAZx8Gej+qFHQTiHVNkc5WeCdABxRcgfqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lRWLFcidtSQVS0zg3RNQj2AoK+XfyU3o7oUoQYHTt6w=;
        b=SQ/Prmw3nQS17SywavOkpWp5bknO/0ZBN9eTmWKBbUrJNVJZP3/efeX/5iIjlQNsPD
         acbwDsW/5+S/Y4oG6BzHHYdBeXLCdBP4yXfVl0ENA7aBXh73oRNbklcSlSPCr58+oCLO
         ZIZGrI8t5+QNmEfSgGCueEqkdKDGvOmTbYKpNnOrOx/uAg2Z7go5Vz4xyMDLkkA7vBEO
         9gjKpOFYC7ayMypUSggdWf2rrPTSJj8b/6uUHcXE9zoDKoOt9HjJqvz4vnjeJW2sDeWE
         fd/m8xFxgf1Z+jTtr5EVRDEPOMGgC8TwvTy5uc4yHCQcstpoOIvPH6ZaBpoSiJUpDAXW
         OFXg==
X-Gm-Message-State: AGRZ1gKxzoClejUH7OengLEOc1L/3YMzqhHMV6lavt4peZwpM1en/8au
        WrWoKnNeyMzs7/QaB08tEFfHTA==
X-Google-Smtp-Source: AJdET5dTrDoxV57z1fK7SIx9nc3h0BuPTl5kaAQbpfL9uIAckp0FJRGCU4au0K9uy9OKdrGma4DoLg==
X-Received: by 2002:a17:902:ab81:: with SMTP id f1-v6mr17866plr.103.1542161646105;
        Tue, 13 Nov 2018 18:14:06 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 67-v6sm27881214pfk.134.2018.11.13.18.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 18:14:05 -0800 (PST)
Date:   Tue, 13 Nov 2018 18:14:04 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 3/4] Bluetooth: hci_qca: clear
 HCI_QUIRK_RESET_ON_CLOSE flag
Message-ID: <20181114021404.GI22824@google.com>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-4-bgodavar@codeaurora.org>
 <462C4F58-E6E2-4B20-B074-72DDFA6D7364@holtmann.org>
 <170e0419929840109d349b5df5e38364@codeaurora.org>
 <0CE81F0B-B122-4793-817F-F0F4738C44E0@holtmann.org>
 <c4ced688b33ad82b61a705908393a0a6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4ced688b33ad82b61a705908393a0a6@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 06:44:07PM +0530, Balakrishna Godavarthi wrote:
> Hi Marcel,
> 
> On 2018-11-06 18:32, Marcel Holtmann wrote:
> > Hi Balakrishna,
> > 
> > > > > During hci down we are sending reset command to chip, which
> > > > > is not required for wcn3990, as hdev->shutdown() will turn off the
> > > > > regulators.
> > > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > > > ---
> > > > > drivers/bluetooth/hci_qca.c | 1 +
> > > > > 1 file changed, 1 insertion(+)
> > > > > diff --git a/drivers/bluetooth/hci_qca.c
> > > > > b/drivers/bluetooth/hci_qca.c
> > > > > index 8301663f0004..97b57e0f4725 100644
> > > > > --- a/drivers/bluetooth/hci_qca.c
> > > > > +++ b/drivers/bluetooth/hci_qca.c
> > > > > @@ -1190,6 +1190,7 @@ static int qca_setup(struct hci_uart *hu)
> > > > > 		 */
> > > > > 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> > > > > 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> > > > > +		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);

This patch doesn't apply cleanly against bluetooth-next, looks like
you have the unrelated "Bluetooth: hci_qca: Set
HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990"
(https://lore.kernel.org/patchwork/patch/1004372/) in your tree.

> > > > > 		hu->hdev->shutdown = qca_power_off;
> > > > > 		ret = qca_wcn3990_init(hu);
> > > > > 		if (ret)
> > > > I am pretty certain that you didn’t want this quirk:
> > > >        /* When this quirk is set, the HCI Reset command is send when
> > > >         * closing the transport instead of when opening it.
> > > > This quirk is for Bluetooth 1.0b devices where the HCI_Reset behavior
> > > > was not clear or for devices that actually misbehave with the initial
> > > > HCI_Reset.
> > > > In addition, you commit message is totally misleading. That is not
> > > > what is happening with this quirk.
> > > > Regards
> > > > Marcel
> > > 
> > > My intention was reset command is not required when we do an hci down.
> > > this is because of hdev->shutdown will turn off the regulators.
> > > It is like turning off the chip. sending reset command after turning
> > > off the chip is not required.
> > > 
> > > I understand the usage of the quirk, will update the commit text.
> > 
> > you are papering over the issue. Actually
> > hci_serdev.c:hci_uart_register_device() is the culprit with the legacy
> > code copied over from hci_ldisc.c:hci_uart_register_dev(). I think
> > there is no point doing all this legacy line discipline quirk handling
> > until it is really needed. The serdev drivers are all for recent
> > hardware.
> > 
> > That said, having moved over to a btuart.c approach and killed the
> > whole hci_serdev.c thing would have been a lot better here. You will
> > keep running in weird situations where 18 year old code keeps
> > surprising you.
> 
> [Bala]: even i feel the same. they are lot such kind of HACK's we need to do
> with current arch.
>         when can we expect btuart.c merged to bt-next. i think having btuart
> will helps us to have the control of
>         vendor porto's call's like in btusb.c

btuart was initially part of the 'add support for Bluetooth on MT7622
SoC' series (https://lore.kernel.org/patchwork/patch/960806/), but was
dropped with v6
(https://lore.kernel.org/patchwork/project/lkml/list/?series=360046)
upon Marcel's request: 'Frankly I prefer to keep the btuart.c driver
for drivers that really just use H:4 as transport protocol. If the
protocol is only H:4 alike and has extra headers, then it should be a
separate driver.' (https://lore.kernel.org/patchwork/patch/960806/#1148426).

Cheers

Matthias
