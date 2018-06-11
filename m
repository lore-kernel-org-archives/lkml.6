Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2EF0EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C6C2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C6C2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754038AbeFKWFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 18:05:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:59156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbeFKWF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 18:05:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 137D4AE7A;
        Mon, 11 Jun 2018 22:05:27 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Date:   Tue, 12 Jun 2018 08:05:13 +1000
Cc:     linux-mtd@lists.infradead.org, boris.brezillon@free-electrons.com,
        frieder.schrempf@exceet.de, computersforpeace@gmail.com,
        david.wolfe@nxp.com, han.xu@nxp.com, festevam@gmail.com,
        marek.vasut@gmail.com, prabhakar.kushwaha@nxp.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes
In-Reply-To: <20180611114916.351ed272@bbrezillon>
References: <1528708694-19407-1-git-send-email-yogeshnarayan.gaur@nxp.com> <20180611114916.351ed272@bbrezillon>
Message-ID: <87r2ldj7xi.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, Jun 11 2018, Boris Brezillon wrote:
>
> Also, I'd prefer to have this patch split in 2:
> 1/ one patch removing the check in spi_nor_write()
> 2/ and the second patch removing the while() loop in m25p80_write()
>
> How about the following commit messages for those 2 patches:
>
> 1:
> "
> mtd: spi-nor: Support controllers with limited TX FIFO size
>
> Some SPI controllers can't write nor->page_size bytes in a single step
> because their TX FIFO is too small.

I no longer think this is good justification for changes to m25p80 or to
anything outside the low-level SPI driver.  The size of the FIFO is not
related to the maximum message size.

An SPI transaction involves:
 - asserting chip-select
 - sending/receiving a bunch of bits
 - deasserting chip-select

That middle part of sending/receiving bits can be done:
 - one bit at a time by bit-banging GPIOs
 - 32 bytes at a time by filling a buffer, running the SPI engine, then
    reading results out of the buffer (assuming a 32-byte buffer)
 - with one single DMA operation if the SPI engine can DMA to/from
   main memory

and there are probably other options.

If your SPI engine only handles (say) 32 bytes at a time, then call it
repeatedly, while holding chip-select asserted the whole time.  The SPI
clock is controlled by the host and in this case it will not have a
stable frequency for the whole transaction (occasionally pauses), but
that doesn't matter.  The slave just watches for the clock transitions
and don't care when they come as long as they don't come too fast.

I recently modified the mt7621 spi driver (in drivers/staging) to work
like this and got much better throughput when reading from spi-nor flash
memory.  It handles writes of full pages (36 bytes at at time!) without
problems.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlse8hoACgkQOeye3VZi
gbnSAQ/8DZgVN/kCJ8c8UYke3tZriVzT6F0rL2RBPB3InM7UTKKXpnbDe0V++Xc6
BVc535dvOY4cxIUK0uTqdsJUzGEA7OIjZbG9G5grv0DSNKqF3S9RmzOFEcR6hUjE
7gdrb23ehNsgW3gaWO3dNLqGXl7D+ryvAubrFh+GzFcaIiYIKiUCQhNnBUaduGQE
daLVmOl8YxMFV85R2stN5+Z47wHYQOe/i+P7I4CQZnlDgzcMjsZk+WhBvc4CQ29k
PIpMVPFIS4RCJvVuSgOGWmAn27FwkgBZf3bhKVMSOGnAJRVYPnjKqpIagzOqgt06
RnijPVaBUtbcPaTY7HmUtBS8ioPaeT/obgJnU1KxWiGoTexA0NG6pcPL9+0XidlG
9w2JX9kF2RHzidqKZqrdUha+zZ0U2I/J71+OMY61dtCvUxQiMWgZABlf8GiOnCQK
hra46nTojuKK5LgI1iHDChzB8qU/ZM7PNv92FTDC0DIODTpe7M9oy++BUKlZOGIA
prITcYkofPK0rT4bPwWG+RQTH6GtAehnOMtK30vb73F0Zqhl3n6QcR2upArPPbIz
mMez52S6js95q9iwT7DzDuXfMOMZN6siy3ZgfUKtgr8Pd2NlOMe6CkbD1NGiKMzn
EQz4SVTTQ9K1iq4iuOtnBneBKJWK4bkhFXDuiMF7rMGuiIZXpnI=
=t90E
-----END PGP SIGNATURE-----
--=-=-=--
