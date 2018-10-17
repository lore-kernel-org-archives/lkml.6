Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EF6ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541BA2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541BA2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeJQXuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:50:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:25423 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeJQXuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:50:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 08:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="asc'?scan'208";a="100256625"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by orsmga001.jf.intel.com with ESMTP; 17 Oct 2018 08:53:08 -0700
Message-ID: <3f8e7a6e9532abcd772927432d5f00cebeba08b8.camel@intel.com>
Subject: Re: [PATCH net-next] ixgbe: fix XFRM_ALGO dependency
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Shannon Nelson <shannon.nelson@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 17 Oct 2018 08:56:35 -0700
In-Reply-To: <07e372cb-06da-bf95-bc53-64ee09fc8e76@oracle.com>
References: <20181016100848.1329843-1-arnd@arndb.de>
         <07e372cb-06da-bf95-bc53-64ee09fc8e76@oracle.com>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-eBL/cF5nu+mq+ndEqGVn"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eBL/cF5nu+mq+ndEqGVn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-10-16 at 09:35 -0700, Shannon Nelson wrote:
> On 10/16/2018 3:03 AM, Arnd Bergmann wrote:
> > When XFRM_ALGO is not enabled, the new igxge ipsec code produces a
> > link error:
>=20
> s/igxge/ixgbe/
>=20
> >=20
> > drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.o: In function
> > `ixgbe_ipsec_vf_add_sa':
> > ixgbe_ipsec.c:(.text+0x1266): undefined reference to
> > `xfrm_aead_get_byname'
> >=20
> > Simply selectin XFRM_ALGO from here causes circular dependencies,
> > so
>=20
> s/selectin/selecting/
>=20
> > to fix it, we probably want this slightly more complex solution
> > that is
> > similar to what other drivers with XFRM offload do:
> >=20
> > A separate Kconfig symbol now controls whether we include the ipsec
> > offload code. To keep the old behavior, this is left as 'default
> > y'. The
> > dependency in XFRM_OFFLOAD still causes a circular dependency but
> > is
> > not actually needed because this symbol is not user visible, so
> > removing
> > that dependency on top makes it all work.
> >=20
> > Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I agree with Shannon's suggested changes.  Arnd, are you working on v2?
Or would you like me to take care of it?

> > ---
> >   drivers/net/ethernet/intel/Kconfig            | 10 ++++++++++
> >   drivers/net/ethernet/intel/ixgbe/Makefile     |  2 +-
> >   drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  8 ++++----
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  6 +++---
> >   net/xfrm/Kconfig                              |  1 -
> >   5 files changed, 18 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/intel/Kconfig
> > b/drivers/net/ethernet/intel/Kconfig
> > index b542aba6f0e8..d1db382d8299 100644
> > --- a/drivers/net/ethernet/intel/Kconfig
> > +++ b/drivers/net/ethernet/intel/Kconfig
> > @@ -194,6 +194,16 @@ config IXGBE_DCB
> >  =20
> >   	  If unsure, say N.
> >  =20
> > +config IXGBE_IPSEC
> > +	bool "IPSec XFRM cryptography-offload accelaration"
> > +	default n
>=20
> remove this "default n" line?
>=20
> > +	depends on IXGBE
> > +	depends on XFRM_OFFLOAD
> > +	default y
> > +	select XFRM_ALGO
> > +	---help---
> > +	  Enable support for IPSec offload in ixgbe.ko
> > +
> >   config IXGBEVF
> >   	tristate "Intel(R) 10GbE PCI Express Virtual Function Ethernet
> > support"
> >   	depends on PCI_MSI
> > diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile
> > b/drivers/net/ethernet/intel/ixgbe/Makefile
> > index ca6b0c458e4a..4fb0d9e3f2da 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/Makefile
> > +++ b/drivers/net/ethernet/intel/ixgbe/Makefile
> > @@ -17,4 +17,4 @@ ixgbe-$(CONFIG_IXGBE_DCB) +=3D  ixgbe_dcb.o
> > ixgbe_dcb_82598.o \
> >   ixgbe-$(CONFIG_IXGBE_HWMON) +=3D ixgbe_sysfs.o
> >   ixgbe-$(CONFIG_DEBUG_FS) +=3D ixgbe_debugfs.o
> >   ixgbe-$(CONFIG_FCOE:m=3Dy) +=3D ixgbe_fcoe.o
> > -ixgbe-$(CONFIG_XFRM_OFFLOAD) +=3D ixgbe_ipsec.o
> > +ixgbe-$(CONFIG_IXGBE_IPSEC) +=3D ixgbe_ipsec.o
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> > index 7a7679e7be84..1d5d66436eac 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> > @@ -770,9 +770,9 @@ struct ixgbe_adapter {
> >   #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in
> > bytes */
> >   	u32 *rss_key;
> >  =20
> > -#ifdef CONFIG_XFRM_OFFLOAD
> > +#ifdef CONFIG_IXGBE_IPSEC
> >   	struct ixgbe_ipsec *ipsec;
> > -#endif /* CONFIG_XFRM_OFFLOAD */
> > +#endif /* CONFIG_IXGBE_IPSEC */
>=20
> You'll probably want to apply these changes to the ixgbevf code as
> well.
>=20
> Cheers,
> sln
>=20
> >  =20
> >   	/* AF_XDP zero-copy */
> >   	struct xdp_umem **xsk_umems;
> > @@ -1009,7 +1009,7 @@ void ixgbe_store_key(struct ixgbe_adapter
> > *adapter);
> >   void ixgbe_store_reta(struct ixgbe_adapter *adapter);
> >   s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32 adv_reg, u32
> > lp_reg,
> >   		       u32 adv_sym, u32 adv_asm, u32 lp_sym, u32
> > lp_asm);
> > -#ifdef CONFIG_XFRM_OFFLOAD
> > +#ifdef CONFIG_IXGBE_IPSEC
> >   void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter);
> >   void ixgbe_stop_ipsec_offload(struct ixgbe_adapter *adapter);
> >   void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter);
> > @@ -1037,5 +1037,5 @@ static inline int
> > ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter,
> >   					u32 *mbuf, u32 vf) { return
> > -EACCES; }
> >   static inline int ixgbe_ipsec_vf_del_sa(struct ixgbe_adapter
> > *adapter,
> >   					u32 *mbuf, u32 vf) { return
> > -EACCES; }
> > -#endif /* CONFIG_XFRM_OFFLOAD */
> > +#endif /* CONFIG_IXGBE_IPSEC */
> >   #endif /* _IXGBE_H_ */
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > index 0049a2becd7e..113b38e0defb 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > @@ -8694,7 +8694,7 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct
> > sk_buff *skb,
> >  =20
> >   #endif /* IXGBE_FCOE */
> >  =20
> > -#ifdef CONFIG_XFRM_OFFLOAD
> > +#ifdef CONFIG_IXGBE_IPSEC
> >   	if (skb->sp && !ixgbe_ipsec_tx(tx_ring, first, &ipsec_tx))
> >   		goto out_drop;
> >   #endif
> > @@ -10190,7 +10190,7 @@ ixgbe_features_check(struct sk_buff *skb,
> > struct net_device *dev,
> >   	 * the TSO, so it's the exception.
> >   	 */
> >   	if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID)) {
> > -#ifdef CONFIG_XFRM_OFFLOAD
> > +#ifdef CONFIG_IXGBE_IPSEC
> >   		if (!skb->sp)
> >   #endif
> >   			features &=3D ~NETIF_F_TSO;
> > @@ -10883,7 +10883,7 @@ static int ixgbe_probe(struct pci_dev
> > *pdev, const struct pci_device_id *ent)
> >   	if (hw->mac.type >=3D ixgbe_mac_82599EB)
> >   		netdev->features |=3D NETIF_F_SCTP_CRC;
> >  =20
> > -#ifdef CONFIG_XFRM_OFFLOAD
> > +#ifdef CONFIG_IXGBE_IPSEC
> >   #define IXGBE_ESP_FEATURES	(NETIF_F_HW_ESP | \
> >   				 NETIF_F_HW_ESP_TX_CSUM | \
> >   				 NETIF_F_GSO_ESP)
> > diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> > index 4a9ee2d83158..140270a13d54 100644
> > --- a/net/xfrm/Kconfig
> > +++ b/net/xfrm/Kconfig
> > @@ -8,7 +8,6 @@ config XFRM
> >  =20
> >   config XFRM_OFFLOAD
> >          bool
> > -       depends on XFRM
> >  =20
> >   config XFRM_ALGO
> >   	tristate
> >=20


--=-eBL/cF5nu+mq+ndEqGVn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlvHW7MACgkQ5W/vlVpL
7c5wHg/+NP9nq3je2KsSMXHWUnmlsJRPiaPEwUIGII77Be/q9QvpjLpc0IgYhlxu
vC26ZRd34GPQP97lcu1YPu4zhw95D5LlPN/Eq72t5pwcPhV3eRx5+dQXIE2GQ8+x
+nZSH2Hfik1yQRlFc6sdart5ZxWhff/uk8KJhN7AZ7DHUHgmeCwxfuPD7o0Oup5n
+EGZejZFeXcRezBTrC42C9q26AsQ9E+XJqRS8IdoltxoOI0fQd1vvG7taJZ/fUF9
6R7r025SregAyKDaQ9K3a1TQ6ioAIHEP+n5j/QuzSuhmZ1Bm/mTc0Kw+2cFUG8tp
IaDmeJlhc43KH6ljyJyDcuc/9/qqmpQccBbO4sIXJhUh7sTIB9m7a2CHRvPkIR11
BENC25fJySD0U1BIAerWSsrmVBzDR49NXOjqxwvO2V0QIz3RgROsn9zobxLwZejg
7ecmaqodJAmP3RBcUie4b44L3oo2lMjlMf60yDAYxv5Se1pECeMK6csXTtZsahJk
nI0E9COMpTlw4ziherW6icUCAuCbpMbPqs25vwMnZHBs+6R3hf7Qe/S/ljIVftDr
1iX0n2xOxjxJYgk4lFHr8e/KWdrNH33bp8UB+VSlNnVyzYjmibQkNb/PV95PP8KA
swUZXxCRNh+sTjpaTmv7aU76KvGSSSwG6Sk6jyyZm8ClsbIqN8o=
=rJ+0
-----END PGP SIGNATURE-----

--=-eBL/cF5nu+mq+ndEqGVn--

