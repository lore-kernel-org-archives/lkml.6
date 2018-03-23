Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeCWCVO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 22:21:14 -0400
Received: from ozlabs.org ([103.22.144.67]:46341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeCWCVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 22:21:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 23 Mar 2018 13:20:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudio Scordino <claudio@evidence.eu.com>
Subject: linux-next: manual merge of the tip tree with the pm tree
Message-ID: <20180323132001.7da7f3c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qWvjTvuySbM=9Uxz_p9U+ti"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qWvjTvuySbM=9Uxz_p9U+ti
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  kernel/sched/cpufreq_schedutil.c

between commit:

  0953feed3400 ("cpufreq: schedutil: rate limits for SCHED_DEADLINE")

from the pm tree and commit:

  8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/sched/cpufreq_schedutil.c
index 04d3fe9ba7d2,89fe78ecb88c..000000000000
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@@ -280,11 -276,9 +286,11 @@@ static void sugov_update_single(struct=20
  	unsigned int next_f;
  	bool busy;
 =20
- 	sugov_set_iowait_boost(sg_cpu, time);
+ 	sugov_set_iowait_boost(sg_cpu, time, flags);
  	sg_cpu->last_update =3D time;
 =20
 +	ignore_dl_rate_limit(sg_cpu, sg_policy);
 +
  	if (!sugov_should_update_freq(sg_policy, time))
  		return;
 =20
@@@ -366,12 -353,7 +365,9 @@@ sugov_update_shared(struct update_util_
 =20
  	raw_spin_lock(&sg_policy->update_lock);
 =20
 +	ignore_dl_rate_limit(sg_cpu, sg_policy);
 +
- 	sugov_get_util(sg_cpu);
- 	sg_cpu->flags =3D flags;
-=20
- 	sugov_set_iowait_boost(sg_cpu, time);
+ 	sugov_set_iowait_boost(sg_cpu, time, flags);
  	sg_cpu->last_update =3D time;
 =20
  	if (sugov_should_update_freq(sg_policy, time)) {

--Sig_/qWvjTvuySbM=9Uxz_p9U+ti
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq0ZFEACgkQAVBC80lX
0GwtjQf9H0HOALtMFdAwpRtMhNetBnrumX7u25Vij+HuYZWWZXtUll7p37AB/12b
RB0lkzRvBPbs4pxd+ReePMc2m4OaBFKn4eNE4mZUPcOuJdCZXy2jBI/S8TsPGewL
DSOziAIFa6fcYf4n93T3gRWGnAQ1i+/nr2lIrC2WoavKNfigeJ/bvf2pZS530EGE
mRcdcQROoFC6SSBOTCT6+PZBWNFSRAY6jt+uI+4omnu4kxfu7ZI3nQOjO7KC36N+
20Y5NekmMOkjqUA2VJSnEhef8TFJKXy10GmhVdywQshEK+C/ax1zQ+XHECH1P4Uy
BmUWpx4CXuAJ+5EcFliIVPsr/yO2qg==
=T7L6
-----END PGP SIGNATURE-----

--Sig_/qWvjTvuySbM=9Uxz_p9U+ti--
