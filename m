Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133E2C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67A420685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67A420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbeGXW5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:57:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:34622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388527AbeGXW5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:57:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5066AAEB8;
        Tue, 24 Jul 2018 21:48:32 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Brian Norris <computersforpeace@gmail.com>
Date:   Wed, 25 Jul 2018 07:48:21 +1000
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        linux-mtd@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCHv3 2/2] mtd: m25p80: restore the status of SPI flash when exiting
In-Reply-To: <20180724194110.GA190016@ban.mtv.corp.google.com>
References: <20171206025342.7266-1-Zhiqiang.Hou@nxp.com> <20171206025342.7266-3-Zhiqiang.Hou@nxp.com> <20180723181350.GA58212@ban.mtv.corp.google.com> <20180723221002.736e0830@bbrezillon> <CAN8TOE904WXMScHo1b2jhusz-L8eGBK=gzUUX079ZVfiFk+HoQ@mail.gmail.com> <87in55po3a.fsf@notabene.neil.brown.name> <20180724012226.307f578d@bbrezillon> <87fu09pfii.fsf@notabene.neil.brown.name> <20180724194110.GA190016@ban.mtv.corp.google.com>
Message-ID: <877elkpaoq.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24 2018, Brian Norris wrote:

> Hi,
>
> On Tue, Jul 24, 2018 at 11:51:49AM +1000, NeilBrown wrote:
>> On Tue, Jul 24 2018, Boris Brezillon wrote:
>> > On Tue, 24 Jul 2018 08:46:33 +1000
>> > NeilBrown <neilb@suse.com> wrote:
>> >> One possibility that occurred to me when I was exploring this issue is
>> >> to revert to 3-byte mode whenever 4-byte was not actively in use.
>> >> So any access beyond 16Meg is:
>> >>  switch-to-4-byte ; perform IO ; switch to 3-byte
>> >> or similar.  On my hardware it would be more efficient to
>> >> use the 4-byte opcode to perform the IO, then reset the cached
>> >> 4th address byte that the NOR chip transparently remembered.
>
> Do these chips cache the last 4th-byte used? I don't recall reading
> that, but that would be interesting. It also sounds like that would make
> things even more difficult to do robustly.

That is how the Winbond W25Q256FV appears to behave in my experiments.
Any time you use a 4-byte address, the high byte is saved.  Any time you
use a 3-byte address, the saved high-byte is used.
The data sheet seems to support this understanding, as detailed in

Commit: f134fbbb4ff8 ("mtd: spi-nor: clear Winbond Extended Address Reg on =
switch to 3-byte addressing.")


>
>> >> This adds a little overhead, but should be fairly robust.
>> >> It doesn't help if something goes terribly wrong while IO is happenin=
g,
>> >> but I don't think any other software solution does either.
>> >>=20
>> >> How would you see that approach?
>> >
>> > I think the problem stands: people that have proper HW mitigation for
>> > this problem (NOR chip is reset when the Processor is reset) don't want
>> > to pay the overhead. So, even if we go for this approach, we probably
>> > want to only do that for broken HW.
>
> If it actually saves bytes on the wire to stay in 3-byte mode more
> often, then that could be helpful to all systems. But otherwise, yes, it
> doesn't really belong on a properly-designed system.

I'm not sure exactly what you encompass by the term "properly-designed",
but with the SOC that I have (mt7621) and the flash chip (Winbond
W25Q256FV) it is not possible to wire them up in any way that will work
reliably without software support for leaving 3-byte mode.

The SOC does not have an out-going reset line that signals a general
system reset - it only has one that signals watchdog reset.
The flash chip has an incoming reset line, but it shares a pin with
"hold", and that is the default use.  So we would need to program the
flash to listen for reset, and it would only catch a watchdog reset.
For any other reset, the CPU is (should be) in complete control (even
after a panic!) and it needs to reprogram the flash chip before
resetting the system.
But maybe you think either the SOC and/or the flash chip is not
"properly-designed" - and you may be correct..

Thanks,
NeilBrown


>
>> I agree that a "my-hardware-is-suboptimal" flag is appropriate.
>> I was addressing the suggestion that the current approach doesn't handle
>> all corner cases and was suggesting a different approach that might
>> handle more corner-cases.  I should have been more explicit about that.
>
> If you want to talk about optimizing the broken-hardware hack, then
> fine. That's not my interest at all.
>
> Brian

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltXnqUACgkQOeye3VZi
gbmiuA/9H8mS8aFt06/b6+cmc0dWBRSie5z+JJoYPKRInHzyurNk4HwJ23L0kQyG
MmKQsshhjN1umgOVDz4vaCF88CF18fuVoKGAC2T9orpwYG5nBMHaZwk6MIGp3Tbw
s2LULda57ueWQUbpdEu0JqR/S4pzsIloL+s7w9EBUVqr7J6qrSlI9TWAtdq5ec7d
lKUkzI/l7AVellh/wTb2lIju0z8r30Wl17hNKd134+5auxqmlN2ZAlRfFRe+dTiS
mlBFDyFk0FzGFoK/2UvOaew8kG55LvkuctsJ2hLw0HQbiNqcwztL01RjNoCwg1O6
KDCiNbdqWoKZSUMQRhxW62lpO1Ok7LWam8JQS9aiHOzeyL9q9b7PJh/RhMj90ZKV
KvYxpjj3CIFd3yJHM80BtOuZiCUkgYjg1a3tr8sC2FJ+UxfboyZ3HsgRA4XGSyat
l79oChpL0VKMbj56UBYs7FEC+7hy3u+5omXQBdf7Op4iDJGV9GadLjcJKf7HwuC3
9ISflAwP6255fX2iT8G3o/5iKx+lm5ymXjJiDRnuFPD2O/AGMbzLDO8HYjCT+TC3
zdudZsGB/Ew5u9TDidL39N1TE6MI0m1uWG34/6tM2Eqq/j3fq868kMgVtjutfE4W
sK4hfQqoYFE7kfQzU7iWgdvX0Hoh/jwflmI4K7HqK/8k0u5eymI=
=p7vQ
-----END PGP SIGNATURE-----
--=-=-=--
