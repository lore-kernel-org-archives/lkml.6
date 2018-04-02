Return-Path: <neil@brown.name>
X-Google-Smtp-Source: AIpwx49SNHWnfyYLMiZmpk7xizcAtdJa+BTsiUvgh5Y2sGcEcW2HRyYRCeIf1HLYafWrKwiOjgVS
ARC-Seal: i=1; a=rsa-sha256; t=1522628423; cv=none;
        d=google.com; s=arc-20160816;
        b=rehAUWiWSTVhB/qJ9RwLAE7I0ndfAtBw3H1BM8dq7hzzaHuv/hLNxnckHR874pn0ju
         7u06jVDd4hdUFCVWYCRBG1pIuy7RubXMtNHwLdWiE2fO34JatAgaIcX3vc6UjaeblJFg
         mH2hPliUBplPnCuaJnR55QF9svpvFlkOC1zJzG5WoSNYP2XCTU3jJxDng8EfDP6ov5Gb
         pnBSZ60sxm9ulyywaAMRSNtszHvCGyBMKf7iaPmk9UGA3tG03Sk8e7Nl2nCdRqZvzt12
         ZVDDPFtxE94FnOqhY1F92Qd+Q09O85Go25tlUitJBXUgB2EyOcEqhjJKxDecy6+7sROZ
         qFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:subject:cc:date:to:from
         :arc-authentication-results;
        bh=dHKo/FUoE1pf+uUFzJIILTx57ub9huBEDBR/a+0lwB4=;
        b=yjfOtg6LIAIzfJ/KjfD/gtKrM6HXdb/0r2nxwCL8PWCEUDw/V2VBU2E5IrkSpOvLr/
         I80La2Cb9O/ZyGGXTtUkrbyaTDHWZa9cxQiuotoyzaHSRVkQKC/M8WDvAj3EYqHa0q3+
         88OnFvOvwT7YDuW5uaLk8FpTZO5sZ8q9tJ/hW7oYA7hLOqogE8JC6OniNMxSKeeZDr1o
         wjHYwvqyZHxrKsLI6rncVhMpjxb/tADGJ5xQLndBjU3GcLhG463v9HpZBwsHIAwDDGCg
         K99QoD1IRtfZLXXXmxD4m6PnnyUR7cgpbkX6bD4/HS8pXzdGhd4ZpRDjqSo41pUXIxNE
         wOWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 02 Apr 2018 10:20:15 +1000
Cc: devel@driverdev.osuosl.org , linux-kernel@vger.kernel.org 
Subject: [PATCH] staging: mt7621-pci: Hack 2 more PCI interrupts for gnubee1
Message-ID: <87sh8e1mtc.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596591621802615906?=
X-GMAIL-MSGID: =?utf-8?q?1596591621802615906?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


The mt7621-pci support 3 pci devices and has 3 interrupts.
Each of these need to be enabled by the same sort of hack to
map hwirq number to virq number.
This is a hack which will go as soon as I understand how this is
supposed to work.

Signed-off-by: NeilBrown <neil@brown.name>
=2D--
 drivers/staging/mt7621-pci/pci-mt7621.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt76=
21-pci/pci-mt7621.c
index 1fa41eb8a87f..602321522198 100644
=2D-- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -441,11 +441,16 @@ pcibios_map_irq(const struct pci_dev *dev, u8 slot, u=
8 pin)
 	/*
 	 * 'irq' here is a hwirq, but a virq is needed.  Until we know how and wh=
ere
 	 * to convert one to the other, we have this hack for the GNUBEE1
+	 * Similarly 31->23 and 32->24.
 	 */
=2D	return irq =3D=3D 11 ? 22 : irq;
=2D#else
=2D	return irq;
+	if (irq =3D=3D 11)
+		return 22;
+	if (irq =3D=3D 31)
+		return 23;
+	if (irq =3D=3D 32)
+		return 24;
 #endif
+	return irq;
 }
=20
 void
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrBdz8ACgkQOeye3VZi
gbnb3A/9EN6LAJa2RxS94acW9mpk9klSLEXlS4R+F5fUTRaw2M+JJytT0qWR24kN
2vjcHE3r54+GTqPhu6dwr+ozem2QndA5JS0dGMvSdQXB4pRBtQIDJ2fheyVmaGRd
a//YmjbG4wD/oTcepjM99dfNyw5uau10EQ6IBz981tAqXpDL7vXRHJi/gilLJ7SN
kgdBXHg7kjR2kRiJw57mUKRTDGNC+Ah0eYJg3ejaE3AAaWROZ4xnTAr5ozR9c4xk
LigeIsMGXZdWf6qHMQxzOPmgvtpZevzABk4O0vrJJcemxezpVnN3AkHPlKeBpgOw
IGYrdhwEPibGhnGcSHi46W+Mf53RZrqkcSbY7HWESajoyXIxsfONmRE106inE3Rq
cYLRInCZn6c+LSUJLB4hbELwCoGNnhqaDx3slvsWv6AgL+i6Ahg+xgALJeViyBCM
LuXE2dEnG8fk9oWwh8pncRjiTNGpuk4Fab4oOQnNCC8s5mYsAZp1nP8jQG5UvJsZ
ueTeBtcc0FlwOp7IzVIcXAYHEKljP3CLZYHq9WURehIiN93m9v5yWvbhHglYjaoa
/mK6DszBStAb5/ZiqWCIF6xKaKEjrCeYwzN8OuptCfpGeP16gknu30QcdLIINwYS
C8rbrDkm2COpkYY/R7mzH9gqTur6mGAtIaKJ6fs7s0mk60Q88AM=
=naNs
-----END PGP SIGNATURE-----
--=-=-=--
