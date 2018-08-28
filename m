Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB8EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0652087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0652087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeH2Dvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:51:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39576 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727094AbeH2Dvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:51:51 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1funrn-0000l7-W2; Wed, 29 Aug 2018 00:57:48 +0100
Date:   Wed, 29 Aug 2018 00:57:47 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     linux-kernel@vger.kernel.org
Message-ID: <20180828235747.GJ18030@decadent.org.uk>
References: <20180828235656.GH18030@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
Content-Disposition: inline
In-Reply-To: <20180828235656.GH18030@decadent.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH 2/2] liblockdep: Stub task_struct::state
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

lockdep_print_held_locks() now checks task_struct::state.  Define it
so that all tasks are assumed to be running, since we have no
reasonble way to tell in user-space.

Fixes: 8cc05c71ba5f ("locking/lockdep: Move sanity check to inside ...")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/include/linux/lockdep.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/linux/lockdep.h b/tools/include/linux/lockdep.h
index 6b0c36a58fcb..8e84609afb04 100644
--- a/tools/include/linux/lockdep.h
+++ b/tools/include/linux/lockdep.h
@@ -31,12 +31,16 @@ struct task_struct {
 	gfp_t lockdep_reclaim_gfp;
 	int pid;
 	char comm[17];
+	long state;
 };
=20
 extern struct task_struct *__curr(void);
=20
 #define current (__curr())
=20
+/* lockdep checks task_struct::state =3D=3D TASK_RUNNING */
+#define TASK_RUNNING 0
+
 static inline int debug_locks_off(void)
 {
 	return 1;

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBW4Xhe+e/yOyVhhEJAQpFqw/+J3Fk+PQp2nAlO0SdQqvJnd52Bxv1q6l7
pvXcOEsIUcSQatLg0K1Pv0mpqmoeuwm6P2y5dBDzre/u/8eytut172ctJxF3YCpk
lxe+KEnsWhISv0R23yon2fs9nlGi/6g17aUOZoCfLFf1aFGiSnCu2DEMkDlvQqha
33tLoIdET9oApJykthxmKqy+EMbzoXKgW2FHh19s5HxNpE0ACBvxDSEu1moM6/Nh
KmgyjDO2RNp+nitwDcJxP3HXKx4uO3gOjZLhAMKuFPGGkSxVMiIePVerzRxuDx1l
Pz+/xfe2Meqa/RxaM3IjOrYN2VEVX52T+xOD5FeYETjfQXUHnuB/8v7S2xa9VxyP
MYe674dzrlUR++upZDpI0pOoeBYkgqD3w5jWdwBIFHcHOaoTH2ragSPi/EVVq0WH
ju6J2Lhtuct9vU2VtMFUhjaXYj9jeUroNQD2OPHQmV5KR63yzl9rYbQaGTbtx2ti
2ePRU7jWwmKajAxuruis/STEPov8yonDO3CzPXDRvybgOJet2820A7K/nusfk4PL
vngJN9y8Yo2R8FRhzjtweCAmZ5CkxsCcnS9/S0wTSYC4FyCASnyZUrISwWXgr+JO
odC3wE2AuKPAn3iWEmFRzWKAotMzbnvN5v33lMbWEDdUaz/jrcWnofhCx8w0Y+wp
I3Qj7gZnNl8=
=QEOQ
-----END PGP SIGNATURE-----

--Q59ABw34pTSIagmi--
