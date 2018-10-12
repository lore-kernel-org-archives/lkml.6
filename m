Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EE0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6202086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="NBcp3ZqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6202086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mork.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeJLSRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:17:08 -0400
Received: from canardo.mork.no ([148.122.252.1]:43819 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeJLSRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:17:07 -0400
Received: from miraculix.mork.no ([IPv6:2a02:2121:30d:eedc:c8fa:53ff:fe7c:53d8])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id w9CAj3SM007864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Oct 2018 12:45:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1539341105; bh=JBznSEKUii9lq/dT1QSymWGDarAORjbzd01/9hVJJho=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=NBcp3ZqQqkekB3vEguOvIIW8vm9Wvz5O65fSyFqppQow4evBQxRKozvXh26jeYk9V
         hZhM9hCjaN98VjkMCXX6ASlfRYbi733u/XiIijAvynfyEr+46AJkMwElHeTKVqOuCK
         uTLb5/D9ooLbd4b1phXIwrUaHDeyZhEBAYSLq7KQ=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1gAuwD-0007nm-PJ; Fri, 12 Oct 2018 12:44:57 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk, gregkh@linuxfoundation.org,
        steve.glendinning@shawell.net
Subject: Re: [PATCH 4/7] net: qmi_wwan: add usbnet -> priv function
Organization: m
References: <20181012091642.21294-1-ben.dooks@codethink.co.uk>
        <20181012091642.21294-5-ben.dooks@codethink.co.uk>
Date:   Fri, 12 Oct 2018 12:44:57 +0200
In-Reply-To: <20181012091642.21294-5-ben.dooks@codethink.co.uk> (Ben Dooks's
        message of "Fri, 12 Oct 2018 10:16:39 +0100")
Message-ID: <87woqn30ly.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.1 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks <ben.dooks@codethink.co.uk> writes:

> +static inline struct qmi_wwan_state *usbnet_to_qmi(struct usbnet *usb)
> +{
> +	return (void *) &usb->data;
> +}


checkpatch doesn't like this, and it is also inconsistent with the
coding style elsewhere in the driver.

CHECK: No space is necessary after a cast
#30: FILE: drivers/net/usb/qmi_wwan.c:81:
+       return (void *) &usb->data;

total: 0 errors, 0 warnings, 1 checks, 115 lines checked


And as for consistency:  I realize that "dev" is a very generic name,
but it's used consistendly for all struct usbnet pointers in the driver:


bjorn@miraculix:/usr/local/src/git/linux$ git grep 'struct usbnet' drivers/=
net/usb/qmi_wwan.c
drivers/net/usb/qmi_wwan.c:static struct net_device *qmimux_find_dev(struct=
 usbnet *dev, u8 mux_id)
drivers/net/usb/qmi_wwan.c:static bool qmimux_has_slaves(struct usbnet *dev)
drivers/net/usb/qmi_wwan.c:static int qmimux_rx_fixup(struct usbnet *dev, s=
truct sk_buff *skb)
drivers/net/usb/qmi_wwan.c:     struct usbnet *dev =3D netdev_priv(net);
drivers/net/usb/qmi_wwan.c:     struct usbnet *dev =3D netdev_priv(to_net_d=
ev(d));
drivers/net/usb/qmi_wwan.c:     struct usbnet *dev =3D netdev_priv(to_net_d=
ev(d));
drivers/net/usb/qmi_wwan.c:     struct usbnet *dev =3D netdev_priv(to_net_d=
ev(d));
drivers/net/usb/qmi_wwan.c:     struct usbnet *dev =3D netdev_priv(to_net_d=
ev(d));
drivers/net/usb/qmi_wwan.c:static int qmi_wwan_rx_fixup(struct usbnet *dev,=
 struct sk_buff *skb)
drivers/net/usb/qmi_wwan.c:static int qmi_wwan_manage_power(struct usbnet *=
dev, int on)
drivers/net/usb/qmi_wwan.c:     struct usbnet *dev =3D usb_get_intfdata(int=
f);
drivers/net/usb/qmi_wwan.c:static int qmi_wwan_register_subdriver(struct us=
bnet *dev)
drivers/net/usb/qmi_wwan.c:static int qmi_wwan_change_dtr(struct usbnet *de=
v, bool on)
drivers/net/usb/qmi_wwan.c:static int qmi_wwan_bind(struct usbnet *dev, str=
uct usb_interface *intf)
drivers/net/usb/qmi_wwan.c:     BUILD_BUG_ON((sizeof(((struct usbnet *)0)->=
data) <
drivers/net/usb/qmi_wwan.c:static void qmi_wwan_unbind(struct usbnet *dev, =
struct usb_interface *intf)
drivers/net/usb/qmi_wwan.c:     struct usbnet *dev =3D usb_get_intfdata(int=
f);
drivers/net/usb/qmi_wwan.c:     struct usbnet *dev =3D usb_get_intfdata(int=
f);
drivers/net/usb/qmi_wwan.c:     struct usbnet *dev =3D usb_get_intfdata(int=
f);

The name was chosen to be consistent with the cdc_ether usage. I'd
prefer it if this function could use the "dev" name, to avoid confusing
things unnecessarly with yet another generic name like "usb". Which
isn't used anywhere else in the driver, and could just as easily refer
to a struct usb_device or struct usb_interface.

(yes, I know there are a couple of "struct usb_device *dev" cases. But
I'd rather see those renamed TBH)

I also don't see why this function should be qmi_wwan specific. No need
to duplicate the same function in every minidriver, when you can do with
two generic helpers (maybe with more meaningful names):

static inline void *usbnet_priv(const struct usbnet *dev)
{
        return (void *)&dev->data;
}

static inline void *usbnet_priv0(const struct usbnet * *dev)
{
	return (void *)dev->data[0];
}


Please fix the checkpatch warning and consider the other comments.

Personally I don't really think it makes the code any easier to read.
But if you want it, then I'm fine this. I guess I've grown too used to
seeing those casts ;-)


Bj=C3=B8rn
