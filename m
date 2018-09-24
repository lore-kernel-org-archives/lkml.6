Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0903EC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64AF208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64AF208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeIYER3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:17:29 -0400
Received: from sauhun.de ([88.99.104.3]:38908 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeIYER2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:17:28 -0400
Received: from localhost (i577B9B6D.versanet.de [87.123.155.109])
        by pokefinder.org (Postfix) with ESMTPSA id 584742C0599;
        Tue, 25 Sep 2018 00:13:05 +0200 (CEST)
Date:   Tue, 25 Sep 2018 00:13:04 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Subject: Re: [PATCH v2 1/2] i2c: i2c-qcom-geni: Properly handle DMA safe
 buffers
Message-ID: <20180924221304.GF18592@kunai>
References: <20180920180323.217377-1-swboyd@chromium.org>
 <20180920180323.217377-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <20180920180323.217377-2-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2018 at 11:03:22AM -0700, Stephen Boyd wrote:
> We shouldn't attempt to DMA map the message buffers passed into this
> driver from the i2c core unless the message we're mapping have been
> properly setup for DMA. The i2c core indicates such a situation by
> setting the I2C_M_DMA_SAFE flag, so check for that flag before using DMA
> mode. We can also bounce the buffer if it isn't already mapped properly
> by using the i2c_get_dma_safe_msg_buf() APIs, so do that when we
> want to use DMA for a message.
>=20
> This fixes a problem where the kernel oopses cleaning pages for a buffer
> that's mapped into the vmalloc space. The pages are returned from
> request_firmware() and passed down directly to the i2c master to write
> to the i2c touchscreen device. Mapping vmalloc buffers with
> dma_map_single() won't work reliably, causing an oops like below:
>=20
>  Unable to handle kernel paging request at virtual address ffffffc01391d0=
00
>  Mem abort info:
>    Exception class =3D DABT (current EL), IL =3D 32 bits
>    SET =3D 0, FnV =3D 0
>    EA =3D 0, S1PTW =3D 0
>  Data abort info:
>    ISV =3D 0, ISS =3D 0x00000146
>    CM =3D 1, WnR =3D 1
>  swapper pgtable: 4k pages, 39-bit VAs, pgd =3D ffffff8009ecf000
>  [ffffffc01391d000] *pgd=3D000000017fffa803, *pud=3D000000017fffa803, *pm=
d=3D0000000000000000
>  Internal error: Oops: 96000146 [#1] PREEMPT SMP
>  Modules linked in: i2c_dev rfcomm uinput lzo lzo_compress hci_uart zram =
btqca qcom_q6v5_pil bluetooth ecdh_generic qcom_common bridge qcom_q6v5 stp=
 llc ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_mark fuse snd_seq_dummy snd_s=
eq snd_seq_device cfg80211 rmtfs_mem smsc95xx usbnet mii joydev
>  CPU: 0 PID: 1269 Comm: bash Not tainted 4.14.68 #1
>  task: ffffffc0dc2a0080 task.stack: ffffff800f978000
>  PC is at __clean_dcache_area_poc+0x20/0x38
>  LR is at __swiotlb_map_page+0x80/0x98
>  pc : [<ffffff800809bfb4>] lr : [<ffffff800809a150>] pstate: 80400149
>  sp : ffffff800f97ba20
>  x29: ffffff800f97ba50 x28: 0000000000000001
>  x27: ffffff8008a04000 x26: ffffffc0f79a7a28
>  x25: 0000000000000000 x24: ffffffbf004e4740
>  x23: 0000000000000000 x22: ffffffc0f94eb290
>  x21: 000000009391d000 x20: 0000000000000084
>  x19: 0000000000000001 x18: 0000000000000000
>  x17: 0000000000000000 x16: ffffffc0dc2a0080
>  x15: 0000000000000000 x14: 0000000000000001
>  x13: 00000000000c00b1 x12: 0000000000000000
>  x11: 0000000002000000 x10: 0000000000000000
>  x9 : 0000000080000000 x8 : 000000001391d000
>  x7 : ffffff80085649dc x6 : 0000000000000000
>  x5 : 0000000000000000 x4 : 0000000000000001
>  x3 : 000000000000003f x2 : 0000000000000040
>  x1 : ffffffc01391d084 x0 : ffffffc01391d000
>  Process bash (pid: 1269, stack limit =3D 0xffffff800f978000)
>  Call trace:
>  Exception stack(0xffffff800f97b8e0 to 0xffffff800f97ba20)
>  b8e0: ffffffc01391d000 ffffffc01391d084 0000000000000040 000000000000003f
>  b900: 0000000000000001 0000000000000000 0000000000000000 ffffff80085649dc
>  b920: 000000001391d000 0000000080000000 0000000000000000 0000000002000000
>  b940: 0000000000000000 00000000000c00b1 0000000000000001 0000000000000000
>  cros-ec-spi spi10.0: SPI transfer timed out
>  b960: ffffffc0dc2a0080 0000000000000000 0000000000000000 0000000000000001
>  b980: 0000000000000084 000000009391d000 ffffffc0f94eb290 0000000000000000
>  b9a0: ffffffbf004e4740 0000000000000000 ffffffc0f79a7a28 ffffff8008a04000
>  b9c0: 0000000000000001 ffffff800f97ba50 ffffff800809a150 ffffff800f97ba20
>  b9e0: ffffff800809bfb4 0000000080400149 ffffffc0f94eb290 0000000000000000
>  ba00: 0000007fffffffff 0000000000000001 ffffff800f97ba50 ffffff800809bfb4
>  [<ffffff800809bfb4>] __clean_dcache_area_poc+0x20/0x38
>  [<ffffff8008448154>] geni_se_tx_dma_prep+0x80/0x154
>  [<ffffff800867eb2c>] geni_i2c_xfer+0x14c/0x3dc
>  [<ffffff80086793bc>] __i2c_transfer+0x428/0x83c
>  [<ffffff8008679850>] i2c_transfer+0x80/0xbc
>  [<ffffff80086798e8>] i2c_master_send+0x5c/0x90
>  [<ffffff8008671cc0>] elants_i2c_send+0x30/0x84
>  [<ffffff8008672460>] write_update_fw+0x324/0x484
>  [<ffffff80085559e4>] dev_attr_store+0x40/0x58
>  [<ffffff80082c4ca4>] sysfs_kf_write+0x4c/0x64
>  [<ffffff80082c36fc>] kernfs_fop_write+0x124/0x1bc
>  [<ffffff8008234f04>] __vfs_write+0x54/0x14c
>  [<ffffff80082352b0>] vfs_write+0xcc/0x188
>  [<ffffff800823548c>] SyS_write+0x60/0xc0
>  Exception stack(0xffffff800f97bec0 to 0xffffff800f97c000)
>  bec0: 0000000000000001 000000000e7ede70 0000000000000002 0000000000000000
>  bee0: 0000000000000002 000000000e7ede70 00000000ec049bc8 0000000000000004
>  bf00: 0000000000000002 0000000000000000 000000000e7f0f10 000000000ca2bcd8
>  bf20: 0000000000000000 00000000ff9df69c 00000000ebfaf229 0000000000000000
>  bf40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>  bf60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>  bf80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>  bfa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>  bfc0: 00000000ebfec978 00000000400e0030 0000000000000001 0000000000000004
>  bfe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>  [<ffffff80080832c4>] el0_svc_naked+0x34/0x38
>  Code: 9ac32042 8b010001 d1000443 8a230000 (d50b7a20)
>=20
> Reported-by: Philip Chen <philipchen@chromium.org>
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to for-current (with shortend BUG printout), thanks!


--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlupYXAACgkQFA3kzBSg
KbYLshAAryUdGUyDVUTdIYObIfoHEWdGYbqOgOTtbyzjTNDtheauXQbMWetDVQy8
RMyCqWe/l/vdzVex55B9b/CU0A3fLHiPYjvbu31+ujZ2tQq3ZDa33JL7NOIHvSmq
VNYwdpIuyc3tImirkkzgaHMK5vggMePj9pD0ag+Bsj/hL5j1W2Cce/jk5YPfR4cx
5izTOn1+V+4z+/UGGvna/6k2cv0CpiuFXXoDk39Y2GDVMcrKsUGAk70gp8KDiFiP
uGN7I901d7GkIQARGQ5WmieKUEY04KLqwgkNP/gB66swn2LyVfGVY7yVKHABcNGP
w1CeZ6f6yCQbTKXwztqooB2GG7WvyWEVWqJpGH9bg6kS0ZOhcCtBovoXj9+ziRVj
ENTSqtxEMLDAfDU8d2L+RHpU3NVnLvz6VS44I8v77qwGwECaMT/djEqudkFHfUI5
MGY/jIOQ7lwvhZxz2ksGHso4L5H4TDuVde7JtZYYDiMvFW5rpDYo/YGt3XqQD4ZT
Fq4I25/e3DTJM+w7Umg3l9K5JEg053h8FS1mjE7jPcueI3lii28i+z+OcH/muM5k
+InLqdIxy4oLafnGRxYfK0c61NVmPeTdvg/DrKcFm1cEQ15GMn+2EXEhcZkcIDWR
JLpDcWt07S6dCvMckmsZ81pPrEdF4ky1yQWKcZRyeyI19IOG7gU=
=a8rS
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
