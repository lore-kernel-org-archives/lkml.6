Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeCVAyY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 20:54:24 -0400
Received: from ozlabs.org ([103.22.144.67]:46867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753931AbeCVAyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 20:54:22 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 22 Mar 2018 11:53:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Caradoc-Davies <ben@transient.nz>, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: linux-next: manual merge of the net-next tree with the mac80211
 tree
Message-ID: <20180322115338.54a9b68c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j3lktFuh+6eAxg6X8NDMw9y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j3lktFuh+6eAxg6X8NDMw9y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/mac80211/debugfs.c
  include/net/mac80211.h

between commit:

  7c181f4fcdc6 ("mac80211: add ieee80211_hw flag for QoS NDP support")

from the mac80211 tree and commit:

  94ba92713f83 ("mac80211: Call mgd_prep_tx before transmitting deauthentic=
ation")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/net/mac80211.h
index 2b581bd93812,2fd59ed3be00..000000000000
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@@ -2063,9 -2070,14 +2070,17 @@@ struct ieee80211_txq=20
   * @IEEE80211_HW_SUPPORTS_TDLS_BUFFER_STA: Hardware supports buffer STA on
   *	TDLS links.
   *
 + * @IEEE80211_HW_DOESNT_SUPPORT_QOS_NDP: The driver (or firmware) doesn't
 + *	support QoS NDP for AP probing - that's most likely a driver bug.
 + *
+  * @IEEE80211_HW_DEAUTH_NEED_MGD_TX_PREP: The driver requires the
+  *	mgd_prepare_tx() callback to be called before transmission of a
+  *	deauthentication frame in case the association was completed but no
+  *	beacon was heard. This is required in multi-channel scenarios, where t=
he
+  *	virtual interface might not be given air time for the transmission of
+  *	the frame, as it is not synced with the AP/P2P GO yet, and thus the
+  *	deauthentication frame might not be transmitted.
+  *
   * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arr=
ays
   */
  enum ieee80211_hw_flags {
@@@ -2109,7 -2121,7 +2124,8 @@@
  	IEEE80211_HW_REPORTS_LOW_ACK,
  	IEEE80211_HW_SUPPORTS_TX_FRAG,
  	IEEE80211_HW_SUPPORTS_TDLS_BUFFER_STA,
 +	IEEE80211_HW_DOESNT_SUPPORT_QOS_NDP,
+ 	IEEE80211_HW_DEAUTH_NEED_MGD_TX_PREP,
 =20
  	/* keep last, obviously */
  	NUM_IEEE80211_HW_FLAGS
diff --cc net/mac80211/debugfs.c
index 94c7ee9df33b,a75653affbf7..000000000000
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@@ -212,7 -212,7 +212,8 @@@ static const char *hw_flag_names[] =3D=20
  	FLAG(REPORTS_LOW_ACK),
  	FLAG(SUPPORTS_TX_FRAG),
  	FLAG(SUPPORTS_TDLS_BUFFER_STA),
 +	FLAG(DOESNT_SUPPORT_QOS_NDP),
+ 	FLAG(DEAUTH_NEED_MGD_TX_PREP),
  #undef FLAG
  };
 =20

--Sig_/j3lktFuh+6eAxg6X8NDMw9y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqy/pIACgkQAVBC80lX
0GxViggAknbeMBXj66qXWm9HjcpZLUOjOvcnRYwb51XhQLrIfwowqumAJwIaXkrl
l48b12t/O+BEzLum1emM8sTeu4RDRgRiPVY/YrMyUW3XADdKdIBd/YaHduq1nJfi
bN3NBCDgCmgdMtg27ieMNjcLv/V9mjzeniiOVlLbMBcoiX0A2nshjImy4vj0PiQw
u7yeZBCWAg6IjWEp3ObSUZOSgO2OIW1A9whQqPA5isJRSlf5DmF9S5gVh3bc+o6h
XKpMGzRE+ho//17uBT4Wm6VmwcB/EGHda9AbhXpk5XvRCR9qvMLZb2wCIFdmQVph
WbFt/zMdevNDqQME/CNxa3U0hmVOsw==
=HeoV
-----END PGP SIGNATURE-----

--Sig_/j3lktFuh+6eAxg6X8NDMw9y--
