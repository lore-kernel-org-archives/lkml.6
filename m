Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57253C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA4E20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA4E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeKTXuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:50:07 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56151 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKTXuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:50:07 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 90A05206D8; Tue, 20 Nov 2018 14:20:59 +0100 (CET)
Received: from qschulz (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4BF4A20510;
        Tue, 20 Nov 2018 14:20:59 +0100 (CET)
Date:   Tue, 20 Nov 2018 14:20:58 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/6] net: phy: mscc: migrate to
 phy_select/restore_page functions
Message-ID: <20181120132058.l3g37jpmac7ltclt@qschulz>
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
 <20181008100728.24959-2-quentin.schulz@bootlin.com>
 <mvm8t1pazea.fsf@suse.de>
 <20181119151057.GC26852@lunn.ch>
 <mvm4lcdaynt.fsf@suse.de>
 <20181119152830.GE26852@lunn.ch>
 <20181119154005.GA8367@piout.net>
 <mvmzhu59idl.fsf@suse.de>
 <20181119161204.GC2393@lunn.ch>
 <mvmefbgm0zc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="czv2zz26jygm5w43"
Content-Disposition: inline
In-Reply-To: <mvmefbgm0zc.fsf@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--czv2zz26jygm5w43
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On Tue, Nov 20, 2018 at 12:39:51PM +0100, Andreas Schwab wrote:
> On Nov 19 2018, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> > I still don't see why that would cause a hang.
>=20
> [  996.370000] [<ffffffe0011d7324>] mutex_lock+0x22/0x2a
> [  996.380000] [<ffffffe001039ba0>] mdiobus_read+0x36/0x60
> [  996.380000] [<ffffffe00103b82c>] vsc85xx_config_init+0x4c/0x1e2
>=20
> vsc85xx_config_init is calling mdiobus_read while holding the mdio_lock.
>=20

Thanks for reporting the bug. However, it could be nice the next time
you report a bug to give as much info as you can, such as the device
you're using. Architecture of your platform (or the board itself if it's
a DT in the Linux kernel), the MAC and the PHY IPs (the Microsemi PHY
driver now supports 6 different PHYs that do not work the same way so I
can't guess the one you're using), they all matter and help to
understand your bug. Also, if you could give a full bootlog of the
kernel and how it's possible to reproduce your issue (.config of your
kernel, on which commit on which branch you built your kernel).
Otherwise, you might not have any answer or considerably slow down the
bug identifying and fixing processes, which is annoying to you,
the users, the developers and the maintainers: a lot of upset people :)

Could you try something please? I'm pretty sure I found an issue (I
don't know if it's fixing your issue or not, but it might be).

Please replace in vsc85xx_default_config() the phy_read and phy_write by
respectively __phy_read and __phy_write (note the __ in front).

Let me know if you need help with this.

Thanks,
Quentin

--czv2zz26jygm5w43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlv0CjoACgkQhLiadT7g
8aNnkhAAkWuXup/I0+f8mysVgLfrZQkkOUEtuPebOR9jTjeK7kdNORamUy4SZ4Pb
/YLRXOWuXuPW79o6E1onCkCwnqjWJVk8LphR73PW3mSSIZDDaFtuab3xsGTRNJQG
B8PGEhO+I9jaPW6k4MIIAk+9s6j75IUi9x3+/2SfjEVxTuKkCtPQ1Ep6S24cHCkW
txfnw9I474T8hl4TBCRNCLSO3It52onf/SaHMaxZft20uIBB+M1TLDo2BZ79rhI1
IkoMAJcDaSz+Iuvs9B5bc/O5h2J4xW0mD/m3qtTcn0Vln1tSs27pH/kuH7fISFzV
8+2Fb+1nVMzTU0lD6l2HJeLo9Hud4fSm4DFpCJrkxZ0DMnRmuLUW9vCfAkU1Loud
XJ+RfcJcTTJkxP9ZDHd0PN3TW42jUSWPYMJYNAEC1mh7N7bH8xlG6kiXkqjH/b5V
kVPMIUPRCkyqFkcAFsGZ5XqzAHSsFS/mEBN55SFzLwJ4bE/KVCZY1RRHWiNpVGWW
XN4aAPQIaFJLCYw/FHMN1bZxizqBfwKk1vwlJRlzIFvwt05fNvbakm9vPUIh2pV2
1r5m2sFwyB/F+dzutPDkSdIQZODRkvY3spnnm/xmHbx/PhT6K1aTf4xixrlLik5r
Nt2vPXEGBQ9/kb09Gxo8WDeuW6ubwRR+SRW99MAwLX6P8QozCnQ=
=cN5n
-----END PGP SIGNATURE-----

--czv2zz26jygm5w43--
