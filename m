Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDC2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301B52080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="asSYRWwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbeLSTTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:19:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44166 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbeLSTTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:19:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so9850861pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=t7rCqin0A4JcGVKgWQDkIVq9x7vm8QhesykNL37gXsw=;
        b=asSYRWwRMJSHnXfKT72DSTqNaDIkEgbjz3da0Xg1tNVNc8ghEro6v6NHd8gbaT2Chg
         RM83lyaT3ccxI3J2nQr6M5hTQ4hOi2lkXeO/Hr0fHlpTjQ6YcGXDibYl28FGEcBeysG5
         zNvRCitSocFZA2q3UWjm0nIxpBHt8P+Ksa+WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t7rCqin0A4JcGVKgWQDkIVq9x7vm8QhesykNL37gXsw=;
        b=eKOxSvppoo13dCYUxx10TXVlY0BG/0vwP9bg8BOfwuHT+ef7EbgpGdLzBKaQJnzgud
         YoIe7gWsoki82p5poqmRtmOr64dQwER75QsNUcXLc0TJ0UhWbFAj7xcpaSvn7f/hJpDx
         keBFd6G6DZu9gNvjpthK0nBsCtligitkajiN15Ejj9XUsyeFx7TroY9bSpBjSk8Za7zq
         W0eVDru6mGZf8acJNTUl5dQyGsUyq1f/Oc+awfXmw9VlO4lNYdkbHuPEGvi8O9L93aOO
         RfZixgnMuPrcEC9qOAr07HRpfvGiNKiGAUjK/HMDVIX1ZFMO31KmNXAOIqngtDLXyJK+
         XhsA==
X-Gm-Message-State: AA+aEWZJHd5jYFUmn2ghx1Gye9sbnfXnIpY0A7bfURZtN/sFvieezVfl
        qmR/XWBrmLPu6/rvqJ0HfMmSfQ==
X-Google-Smtp-Source: AFSGD/USmI+1+Ht1i8i8cx4RDtjXCfMZrrcwmmIGmgy9vzf6JVMHAgmRDIfYeYuEHH9KkAiCJTXCWg==
X-Received: by 2002:a62:b9a:: with SMTP id 26mr21860699pfl.196.1545247191201;
        Wed, 19 Dec 2018 11:19:51 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 184sm25685654pfe.106.2018.12.19.11.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 11:19:50 -0800 (PST)
Date:   Wed, 19 Dec 2018 11:19:49 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>
Subject: Re: [PATCH RESEND v2 1/3] Bluetooth: Add quirk for reading BD_ADDR
 from fwnode property
Message-ID: <20181219191949.GD109358@google.com>
References: <20181204201615.245574-1-mka@chromium.org>
 <20181204201615.245574-2-mka@chromium.org>
 <5F86A55E-2893-4D16-BA5C-36A60CB46DBC@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5F86A55E-2893-4D16-BA5C-36A60CB46DBC@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

thanks for the review!

On Wed, Dec 19, 2018 at 03:22:12PM +0100, Marcel Holtmann wrote:

> > Add HCI_QUIRK_USE_BDADDR_PROPERTY to allow controllers to retrieve
> > the public Bluetooth address from the firmware node property
> > 'local-bd-address'. If quirk is set and the property does not exist
> > or is invalid the controller is marked as unconfigured.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > Tested-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > ---
> > Changes in v2:
> > - added check for return value of ->setup()
> > - only read BD_ADDR from the property if it isn't assigned yet. This
> >  is needed to support configuration from user space
> > - refactored the branch of the new quirk to get rid of 'bd_addr_set'
> > - added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' tag
> > ---
> > include/net/bluetooth/hci.h | 12 ++++++++++
> > net/bluetooth/hci_core.c    | 45 +++++++++++++++++++++++++++++++++++++
> > net/bluetooth/mgmt.c        |  6 +++--
> > 3 files changed, 61 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index c36dc1e20556a..fbba43e9bef5b 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -158,6 +158,18 @@ enum {
> > 	 */
> > 	HCI_QUIRK_INVALID_BDADDR,
> > 
> > +	/* When this quirk is set, the public Bluetooth address
> > +	 * initially reported by HCI Read BD Address command
> > +	 * is considered invalid. The public BD Address can be
> > +	 * specified in the fwnode property 'local-bd-address'.
> > +	 * If this property does not exist or is invalid controller
> > +	 * configuration is required before this device can be used.
> > +	 *
> > +	 * This quirk can be set before hci_register_dev is called or
> > +	 * during the hdev->setup vendor callback.
> > +	 */
> > +	HCI_QUIRK_USE_BDADDR_PROPERTY,
> > +
> > 	/* When this quirk is set, the duplicate filtering during
> > 	 * scanning is based on Bluetooth devices addresses. To allow
> > 	 * RSSI based updates, restart scanning if needed.
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 7352fe85674be..d4149005a661e 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -30,6 +30,7 @@
> > #include <linux/rfkill.h>
> > #include <linux/debugfs.h>
> > #include <linux/crypto.h>
> > +#include <linux/property.h>
> > #include <asm/unaligned.h>
> > 
> > #include <net/bluetooth/bluetooth.h>
> > @@ -1355,6 +1356,36 @@ int hci_inquiry(void __user *arg)
> > 	return err;
> > }
> > 
> > +/**
> > + * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
> > + *				       (BD_ADDR) for a HCI device from
> > + *				       a firmware node property.
> > + * @hdev:	The HCI device
> > + *
> > + * Search the firmware node for 'local-bd-address'.
> > + *
> > + * All-zero BD addresses are rejected, because those could be properties
> > + * that exist in the firmware tables, but were not updated by the firmware. For
> > + * example, the DTS could define 'local-bd-address', with zero BD addresses.
> > + */
> > +static int hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
> > +{
> > +	struct fwnode_handle *fwnode = dev_fwnode(hdev->dev.parent);
> > +	bdaddr_t ba;
> > +	int ret;
> > +
> > +	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> > +					    (u8 *)&ba, sizeof(ba));
> > +	if (ret < 0)
> > +		return ret;
> > +	if (!bacmp(&ba, BDADDR_ANY))
> > +		return -ENODATA;
> > +
> > +	hdev->public_addr = ba;
> 
> this needs to use bacpy btw.

will change

> > +
> > +	return 0;
> > +}
> 
> Make this void since the return value is actually not used right now.

ok

> > +
> > static int hci_dev_do_open(struct hci_dev *hdev)
> > {
> > 	int ret = 0;
> > @@ -1422,6 +1453,20 @@ static int hci_dev_do_open(struct hci_dev *hdev)
> > 		if (hdev->setup)
> > 			ret = hdev->setup(hdev);
> > 
> > +		if (ret)
> > +			goto setup_failed;
> > +
> > +		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
> > +			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
> > +				hci_dev_get_bd_addr_from_property(hdev);
> 
> So I would move the bacmp() into
> hci_dev_get_bd_addr_from_property. Mainly since you also write the
> field there.

Personally I'm not a fan of functions that pretend to do something and
then do it conditionally, IMO it obscures the actual code flow.

I'm open to change it though if you have a strong preference for not
having the check in hci_dev_do_open().

> > +			if (!bacmp(&hdev->public_addr, BDADDR_ANY) ||
> > +			    !hdev->set_bdaddr ||
> > +			    hdev->set_bdaddr(hdev, &hdev->public_addr))
> > +				hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
> > +		}
> 
> So this one I don’t like since it makes my brain hurt when I have to read it and understand it.

I agree, it's an ugly construct.

> I think this needs to be like this:
> 
> 	if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
> 	    hdev->set_bdaddr)
> 		ret = hdev->set_bdaddr(hdev, &hdev->public_addr);
> 	else
> 		err = -EADDRNOTAVAIL;
> 
> That will fail the power on procedure which is the right thing to do if the local-bd-address is not present. The driver decided that it should be in DT and so enforce that.

Ok, will change as suggested.

Thanks

Matthias
