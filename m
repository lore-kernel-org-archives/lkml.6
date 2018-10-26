Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5A5ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1956E20848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UeIVvwSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1956E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeJ0CgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:36:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38563 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJ0CgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:36:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so884071pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FtU8CFVEtRo/CtwcF+APeDDh48Za5P6DP/Vph2P9Qx8=;
        b=UeIVvwShIXT8b9Qa73D7zr0YWREzDKnOXk3fpIdI5NAACPmObHtFXw2MrqRpQ1K4h6
         QivOcKVuWrBji3rQAA777evsWMd57QRlGvRKIwb6ZAlwL7IKCqTStafVpbf5CtmHhA1f
         VzugkpabxzxX2q53zDbbPhB6z0oNHEq0BhSpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FtU8CFVEtRo/CtwcF+APeDDh48Za5P6DP/Vph2P9Qx8=;
        b=Q5PhQyOR/gtYeCeQrkJuhVMd+/BAH2cfZ7OtIW4OZSs5Foej8QhOm7wURArLFHYQ5w
         fLzN9qK28yQXWpbejnEcF3wVxL4rg9J92yItkgzeMexS7YKQgVtPubJOgHKPtAt3iEeJ
         VSJvZ0KHSFQ91GeSyLntqAZfmw7I8jEj7Q4Ljj57uIv4dNS5iRJoNDu8KLZfxOCm2M1b
         DExm+PztyNzLB4V9BkTxdVNeQU6s6tluy5rUXoVLZv8qoVUTndnILvHeb9J9sQ+047iW
         TYsLjpd3PRUjHLjRjO0UKjgdaQk6f0xdkG4ZfPS/PpNd+K365A04l7tFog7zvObiwo6I
         cNTg==
X-Gm-Message-State: AGRZ1gIk53N0uYMyozvry2X30t675Jzw4re4eb/o7MD0KZVrbAYu8WZs
        D17Z2YmDkVK5CJc8jHrA5fAy4Q==
X-Google-Smtp-Source: AJdET5ela14lG8aFgS1ixTu0Fn3VCsUmbDywUYj66rhcuw4BcWuZdgQ/Zp1PhQE9bT8hHfSAMDc+LA==
X-Received: by 2002:a62:1fdb:: with SMTP id l88-v6mr4721107pfj.213.1540576697358;
        Fri, 26 Oct 2018 10:58:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id h6-v6sm12828933pgm.14.2018.10.26.10.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 10:58:16 -0700 (PDT)
Date:   Fri, 26 Oct 2018 10:58:16 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>, hemantg@codeaurora.org
Subject: Re: [PATCH 1/2] Bluetooth: Add quirk for reading BD_ADDR from fwnode
 property
Message-ID: <20181026175816.GC22824@google.com>
References: <20181025002134.256791-1-mka@chromium.org>
 <20181025002134.256791-2-mka@chromium.org>
 <4041ef05cdd70d28d665d3288c4d4c43@codeaurora.org>
 <7462a1b91c84454290eb09ff33bee8ee@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7462a1b91c84454290eb09ff33bee8ee@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 10:31:37AM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> I missed to add a point here.
> 
> On 2018-10-25 20:06, Balakrishna Godavarthi wrote:
> > On 2018-10-25 05:51, Matthias Kaehlcke wrote:
> > > Add HCI_QUIRK_USE_BDADDR_PROPERTY to allow controllers to retrieve
> > > the public Bluetooth address from the firmware node property
> > > 'local-bd-address'. If quirk is set and the property does not exist
> > > or is invalid the controller is marked as unconfigured.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > hci_dev_get_bd_addr_from_property() currently assumes that the
> > > firmware node with 'local-bd-address' is from hdev->dev.parent, not
> > > sure if this universally true. However if it is true for existing
> > > device that might use this interface we can assume this for now
> > > (unless there is a clear solution now), and cross the bridge of
> > > finding an alternative when we actually encounter the situation.
> > > One option could be to look for the first parent that has a fwnode.
> > > ---
> > >  include/net/bluetooth/hci.h | 12 +++++++++++
> > >  net/bluetooth/hci_core.c    | 42
> > > +++++++++++++++++++++++++++++++++++++
> > >  net/bluetooth/mgmt.c        |  6 ++++--
> > >  3 files changed, 58 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > > index cdd9f1fe7cfa..a5d748099752 100644
> > > --- a/include/net/bluetooth/hci.h
> > > +++ b/include/net/bluetooth/hci.h
> > > @@ -158,6 +158,18 @@ enum {
> > >  	 */
> > >  	HCI_QUIRK_INVALID_BDADDR,
> > > 
> > > +	/* When this quirk is set, the public Bluetooth address
> > > +	 * initially reported by HCI Read BD Address command
> > > +	 * is considered invalid. The public BD Address can be
> > > +	 * specified in the fwnode property 'local-bd-address'.
> > > +	 * If this property does not exist or is invalid controller
> > > +	 * configuration is required before this device can be used.
> > > +	 *
> > > +	 * This quirk can be set before hci_register_dev is called or
> > > +	 * during the hdev->setup vendor callback.
> > > +	 */
> > > +	HCI_QUIRK_USE_BDADDR_PROPERTY,
> > > +
> > >  	/* When this quirk is set, the duplicate filtering during
> > >  	 * scanning is based on Bluetooth devices addresses. To allow
> > >  	 * RSSI based updates, restart scanning if needed.
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index 74b29c7d841c..97214262c4fb 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -30,6 +30,7 @@
> > >  #include <linux/rfkill.h>
> > >  #include <linux/debugfs.h>
> > >  #include <linux/crypto.h>
> > > +#include <linux/property.h>
> > >  #include <asm/unaligned.h>
> > > 
> > >  #include <net/bluetooth/bluetooth.h>
> > > @@ -1355,9 +1356,40 @@ int hci_inquiry(void __user *arg)
> > >  	return err;
> > >  }
> > > 
> > > +/**
> > > + * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device
> > > Address
> > > + *				       (BD_ADDR) for a HCI device from
> > > + *				       a firmware node property.
> > > + * @hdev:	The HCI device
> > > + *
> > > + * Search the firmware node for 'local-bd-address'.
> > > + *
> > > + * All-zero BD addresses are rejected, because those could be
> > > properties
> > > + * that exist in the firmware tables, but were not updated by the
> > > firmware. For
> > > + * example, the DTS could define 'local-bd-address', with zero BD
> > > addresses.
> > > + */
> > > +static int hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
> > > +{
> > > +	struct fwnode_handle *fwnode = dev_fwnode(hdev->dev.parent);
> > > +	bdaddr_t ba;
> > > +	int ret;
> > > +
> > > +	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> > > +					    (u8 *)&ba, sizeof(ba));
> > > +	if (ret < 0)
> > > +		return ret;
> > > +	if (!bacmp(&ba, BDADDR_ANY))
> > > +		return -ENODATA;
> > > +
> > > +	hdev->public_addr = ba;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int hci_dev_do_open(struct hci_dev *hdev)
> > >  {
> > >  	int ret = 0;
> > > +	bool bd_addr_set = false;
> > > 
> > >  	BT_DBG("%s %p", hdev->name, hdev);
> > > 
> > > @@ -1422,6 +1454,16 @@ static int hci_dev_do_open(struct hci_dev
> > > *hdev)
> > >  		if (hdev->setup)
> > >  			ret = hdev->setup(hdev);
> > > 
> > > +		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
> > > +			if (!hci_dev_get_bd_addr_from_property(hdev))
> > > +				if (hdev->set_bdaddr &&
> > > +				    !hdev->set_bdaddr(hdev, &hdev->public_addr))
> > > +					bd_addr_set = true;
> 
> Can we check the return status of hdev->setup() before calling
> hdev->set_bdaddr().
> some vendors assign hdev->set_baddr helper before calling hdev->setup().
> https://elixir.bootlin.com/linux/v4.19-rc8/source/drivers/bluetooth/btqcomsmd.c#L194
> There will no use in calling hdev->set_baddr() if hdev->setup() fails.

Thanks for pointing this out, I'll add the check.

This is more a question for Marcel: independently from this change I
wonder how robust the error flow in this function is. Is there are
reason to not bail out directly when a seemingly vital function like
->setup() fails, and instead continue and potentially overwrite the
error code? And there are other similar patterns in hci_dev_do_open().

Bailing out would certainly add a bit more code and probably gotos to
a cleanup section (currently in the else branch at the bottom of the
function), but might improve readability and robustness (I don't claim
there is an actual problem, but overwriting the error code seems
brittle).

Cheers

Matthias
