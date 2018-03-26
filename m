Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeCZBYC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 21:24:02 -0400
Received: from ozlabs.org ([103.22.144.67]:44511 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbeCZBYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 21:24:01 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Mar 2018 12:23:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: linux-next: manual merge of the pci tree with Linus' tree
Message-ID: <20180326122306.546ecb6d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/n2nO6uHiaJ=UxlaZ1_bGgTs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n2nO6uHiaJ=UxlaZ1_bGgTs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Today's linux-next merge of the pci tree got a conflict in:

  include/linux/of_pci.h

between commit:

  a6f1086e29e9 ("PCI: Move of_irq_parse_and_map_pci() declaration under OF_=
IRQ")

from Linus' tree and commit:

  effab67ffe90 ("PCI: Move private DT related functions into private header=
")

from the pci tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/of_pci.h
index 091033a6b836,41155181ecbd..000000000000
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@@ -13,9 -13,7 +13,6 @@@ struct device_node
  struct device_node *of_pci_find_child_device(struct device_node *parent,
  					     unsigned int devfn);
  int of_pci_get_devfn(struct device_node *np);
- int of_pci_parse_bus_range(struct device_node *node, struct resource *res=
);
- int of_get_pci_domain_nr(struct device_node *node);
- int of_pci_get_max_link_speed(struct device_node *node);
 -int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
  void of_pci_check_probe_only(void);
  int of_pci_map_rid(struct device_node *np, u32 rid,
  		   const char *map_name, const char *map_mask_name,
@@@ -32,18 -30,12 +29,6 @@@ static inline int of_pci_get_devfn(stru
  	return -EINVAL;
  }
 =20
- static inline int
- of_pci_parse_bus_range(struct device_node *node, struct resource *res)
- {
- 	return -EINVAL;
- }
-=20
--static inline int
- of_get_pci_domain_nr(struct device_node *node)
 -of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
--{
- 	return -1;
 -	return 0;
--}
--
  static inline int of_pci_map_rid(struct device_node *np, u32 rid,
  			const char *map_name, const char *map_mask_name,
  			struct device_node **target, u32 *id_out)
@@@ -54,33 -46,4 +39,13 @@@
  static inline void of_pci_check_probe_only(void) { }
  #endif
 =20
 +#if IS_ENABLED(CONFIG_OF_IRQ)
 +int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 +#else
 +static inline int
 +of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 +{
 +	return 0;
 +}
 +#endif
-=20
- #if defined(CONFIG_OF_ADDRESS)
- int of_pci_get_host_bridge_resources(struct device_node *dev,
- 			unsigned char busno, unsigned char bus_max,
- 			struct list_head *resources, resource_size_t *io_base);
- #else
- static inline int of_pci_get_host_bridge_resources(struct device_node *de=
v,
- 			unsigned char busno, unsigned char bus_max,
- 			struct list_head *resources, resource_size_t *io_base)
- {
- 	return -EINVAL;
- }
- #endif
-=20
  #endif

--Sig_/n2nO6uHiaJ=UxlaZ1_bGgTs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq4S3oACgkQAVBC80lX
0GzZGQf7BAv+lQvZSgcULWthai9xXOFMKxscoNYHOvPm+gFcx6x9jnhnbs+8VwGS
fVn1fSnjupPZW+fEAXBqgoTU5+HsKe0g3ago/jrhKjh4SbjmRHYlv9IauTbjRMYf
CaYxlln2ZZ64qdgyy/1urZnbx/LuFJp/U0Obapf8Bpc8vT72OK6BvShQueA3cNqc
o8QlFmtzSXZQZY28XEKy/yHrmyTicOhr0HbxjskoR2lBPliKMAlYkQbVdN0Motl8
zwDPPYZFrewktBl66IPQBk2NdhcCvvxwe2+wBll79mFnmlQNm8Io9H/bze0AL9tN
q74SBkKKY1ZP/sXhup9+hQwfDrrgWQ==
=a9O8
-----END PGP SIGNATURE-----

--Sig_/n2nO6uHiaJ=UxlaZ1_bGgTs--
