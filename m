Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F6FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406DC2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c8UTpa4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406DC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeJZDiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:38:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44755 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbeJZDiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:38:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so4433028pgs.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJ80GcJpbhbpwJ1p8EKpX85nROIRh3r+g1RclbzQpoU=;
        b=c8UTpa4+vNHN13Akc+Fx/ShPyyOFstahgbVFr/gDkGFQy2CClxGcuGfM/7AtPo+txg
         Z0u6432TVvyM7phc/fLuIe83a1riQjUGnnV0KmnuAX8qQorRc+09b8SWvB+/h3OPl3+k
         SgEFrGMkC6+xVrqJm4q72BeAsLwPNg8/ucTp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJ80GcJpbhbpwJ1p8EKpX85nROIRh3r+g1RclbzQpoU=;
        b=TMgeg19znve2eEWTpWIe5icnGX56CzKN+ZmtBNoD0RLpbLzdiTxgM3i2YOaRcFcFVA
         qcpjTm9kb8Q9fGPYP9MXXEvk53C/8E/1kC3gBr/ZP/cGdOxiHpRg9JdOxwvUN0RvYOpA
         Slp9vPXkeb0oO1Gmu59xNowneDBqCPpCBqpIYnWZuQm6cWBhhxjBf9K/v3aXMNVJ26Zg
         s9AaNLLHJzfeGN832721X3aTiYjREQZ/CKXVdNAlCraVYZfjYK++m67NDwbfbuNPPNhN
         NpSDbzVHpgTVn7T5V5Lf8IzSMmncT5QFZ5oZDeoKrBoAbIlPxaAvbXyPgmNc1QqT/523
         qOnQ==
X-Gm-Message-State: AGRZ1gIQeKnKm9mNiZXRQ8cHcMj87lp4mJdgP2DfZQf2buaruN1ah5c+
        hD1shjiO6vTfylIUpeq+jN7B1Q==
X-Google-Smtp-Source: AJdET5femkqdR0nseanhbHyZ9csPlwth2ysb0AREfm71wUTA4r3KY7iJ66aNpq/EhxLoZ4tb1M/zXg==
X-Received: by 2002:a63:2807:: with SMTP id o7-v6mr363188pgo.155.1540494239829;
        Thu, 25 Oct 2018 12:03:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 3-v6sm9670473pga.12.2018.10.25.12.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 12:03:59 -0700 (PDT)
Date:   Thu, 25 Oct 2018 12:03:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>
Subject: Re: [PATCH 2/2] Bluetooth: btqcomsmd: use
 HCI_QUIRK_USE_BDADDR_PROPERTY
Message-ID: <20181025190358.GY22824@google.com>
References: <20181025002134.256791-1-mka@chromium.org>
 <20181025002134.256791-3-mka@chromium.org>
 <bff4f1b7d82e217f45273872eeffa77f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bff4f1b7d82e217f45273872eeffa77f@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 08:10:30PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-10-25 05:51, Matthias Kaehlcke wrote:
> > Use the HCI_QUIRK_USE_BDADDR_PROPERTY quirk to let the HCI
> > core handle the reading of 'local-bd-address'. With this there
> > is no need to set HCI_QUIRK_INVALID_BDADDR, the case of a
> > non-existing or invalid fwnode property is handled by the core
> > code.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > I couldn't actually test the changes in this driver since I
> > don't have a device with this controller. Could someone
> > from Qualcomm help with this?
> > ---
> >  drivers/bluetooth/btqcomsmd.c | 28 +++-------------------------
> >  1 file changed, 3 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/btqcomsmd.c
> > b/drivers/bluetooth/btqcomsmd.c
> > index 7df3eed1ef5e..e5841602c4f1 100644
> > --- a/drivers/bluetooth/btqcomsmd.c
> > +++ b/drivers/bluetooth/btqcomsmd.c
> > @@ -125,23 +125,10 @@ static int btqcomsmd_setup(struct hci_dev *hdev)
> >  		return PTR_ERR(skb);
> >  	kfree_skb(skb);
> > 
> > -	/* Devices do not have persistent storage for BD address. If no
> > -	 * BD address has been retrieved during probe, mark the device
> > -	 * as having an invalid BD address.
> > +	/* Devices do not have persistent storage for BD address. Retrieve
> > +	 * it from the firmware node property.
> >  	 */
> > -	if (!bacmp(&btq->bdaddr, BDADDR_ANY)) {
> > -		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> > -		return 0;
> > -	}
> > -
> > -	/* When setting a configured BD address fails, mark the device
> > -	 * as having an invalid BD address.
> > -	 */
> > -	err = qca_set_bdaddr_rome(hdev, &btq->bdaddr);
> > -	if (err) {
> > -		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> > -		return 0;
> > -	}
> > +	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> > 
> >  	return 0;
> >  }
> > @@ -169,15 +156,6 @@ static int btqcomsmd_probe(struct platform_device
> > *pdev)
> >  	if (IS_ERR(btq->cmd_channel))
> >  		return PTR_ERR(btq->cmd_channel);
> > 
> > -	/* The local-bd-address property is usually injected by the
> > -	 * bootloader which has access to the allocated BD address.
> > -	 */
> > -	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
> > -				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
> > -		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
> > -			 &btq->bdaddr);
> > -	}
> > -
> >  	hdev = hci_alloc_dev();
> >  	if (!hdev)
> >  		return -ENOMEM;
> 
> nit: can be remove unused "bdaddr_t bdaddr" variable.
> https://elixir.bootlin.com/linux/v4.19-rc8/source/drivers/bluetooth/btqcomsmd.c#L31
> Apart from this, It looks ok to me.

Thanks for the reviews! I'll remove the field in the next revision.
