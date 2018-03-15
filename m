Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeCODO6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 23:14:58 -0400
Received: from ozlabs.org ([103.22.144.67]:44957 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbeCODO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 23:14:56 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 14:14:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20180315141425.49479b8b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/s0Of4vZo6n6iD+GjmQff4YC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s0Of4vZo6n6iD+GjmQff4YC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  sound/pci/hda/hda_intel.c

between commits:

  1ba8f9d30817 ("ALSA: hda: Add a power_save blacklist")
  40088dc4e1ea ("ALSA: hda - Revert power_save option default value")

from Linus' tree and commit:

  07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")

from the drm-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc sound/pci/hda/hda_intel.c
index d5017adf9feb,ec4e6b829ee2..000000000000
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@@ -2219,8 -2201,8 +2223,9 @@@ static int azx_probe_continue(struct az
  	struct hda_intel *hda =3D container_of(chip, struct hda_intel, chip);
  	struct hdac_bus *bus =3D azx_bus(chip);
  	struct pci_dev *pci =3D chip->pci;
+ 	struct hda_codec *codec;
  	int dev =3D chip->dev_index;
 +	int val;
  	int err;
 =20
  	hda->probe_continued =3D 1;
@@@ -2302,21 -2284,16 +2307,30 @@@
  	chip->running =3D 1;
  	azx_add_card_list(chip);
 =20
 +	val =3D power_save;
 +#ifdef CONFIG_PM
 +	if (pm_blacklist) {
 +		const struct snd_pci_quirk *q;
 +
 +		q =3D snd_pci_quirk_lookup(chip->pci, power_save_blacklist);
 +		if (q && val) {
 +			dev_info(chip->card->dev, "device %04x:%04x is on the power_save black=
list, forcing power_save to 0\n",
 +				 q->subvendor, q->subdevice);
 +			val =3D 0;
 +		}
 +	}
 +#endif /* CONFIG_PM */
++
+ 	/*
+ 	 * The discrete GPU cannot power down unless the HDA controller runtime
+ 	 * suspends, so activate runtime PM on codecs even if power_save =3D=3D =
0.
+ 	 */
+ 	if (use_vga_switcheroo(hda))
+ 		list_for_each_codec(codec, &chip->bus)
+ 			codec->auto_runtime_pm =3D 1;
+=20
 -	snd_hda_set_power_save(&chip->bus, power_save * 1000);
 +	snd_hda_set_power_save(&chip->bus, val * 1000);
- 	if (azx_has_pm_runtime(chip) || hda->use_vga_switcheroo)
+ 	if (azx_has_pm_runtime(chip))
  		pm_runtime_put_autosuspend(&pci->dev);
 =20
  out_free:

--Sig_/s0Of4vZo6n6iD+GjmQff4YC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqp5REACgkQAVBC80lX
0GxoIwf/Ynl6aTsk6eMadOxM6MmWPcaZODrISV04xbpLC9jrizJgX/r+vBht+e92
8rrtwqo4cctahri2YR26GQvwvNKJ28N8mmidk8TL3LWKpqXedvYtfl+ol72e40hx
TfIiyihHLnmiDy+df0XhqwvYk5DI81RGufXoOGaXC/fXOZ5FniOyBt0/lhs0Bi3R
q/viy1bh0w7ZQJGEaunKrgRlcaKtVTg49RjSXiCjgg593M5FFPi2b4UQt+sOjEAh
xE719bDJ/K6N5m+UWbWZ+CMU25Z9mP490W/OAoVDwgeGavWKL3oYwWXDThYIR9am
+3A26bfbGDvV9fshzUcafBpsktCC8A==
=0AgE
-----END PGP SIGNATURE-----

--Sig_/s0Of4vZo6n6iD+GjmQff4YC--
