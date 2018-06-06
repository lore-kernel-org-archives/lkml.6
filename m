Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B08F760555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933686AbeFFRGd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:06:33 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58188 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752873AbeFFRGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:06:31 -0400
Message-ID: <1528304781.7898.135.camel@surriel.com>
Subject: Re: [PATCH 16/19] sched/numa: Detect if node actively handling
 migration
From: Rik van Riel <riel@surriel.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 06 Jun 2018 13:06:21 -0400
In-Reply-To: <20180606153204.GA39860@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
         <1528106428-19992-17-git-send-email-srikar@linux.vnet.ibm.com>
         <1528142755.7898.122.camel@surriel.com>
         <20180605035616.GD30328@linux.vnet.ibm.com>
         <1528204074.7898.126.camel@surriel.com>
         <20180606125529.GF30328@linux.vnet.ibm.com>
         <1528293314.7898.132.camel@surriel.com>
         <20180606153204.GA39860@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-RietDPWlo5hqx4g6EzUy"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RietDPWlo5hqx4g6EzUy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-06-06 at 08:32 -0700, Srikar Dronamraju wrote:

> Yes its better to skip cpus if they are already in migration.
> And we are already doing it with the above patch. However as I said
> earlier=20
>=20
> - Task T1 sets Cpu 1 as best_cpu,=20
> - Task T2 finds cpu1 and skips Cpu1
> - Task T1 finds cpu2 slightly better than cpu1.
> - Task T1 resets cpu1 as best_cpu, sets best_cpu as cpu2.
> - Task T2 finds cpu2 and skips cpu2
> - Task T1 finds cpu3 as best_cpu slightly better than cpu2.
> - Task T1 resets cpu2 as best_cpu, sets best_cpu as cpu3.
> - Task T2 finds cpu3 and skips cpu3
>=20
> So after this T1 was able to find a cpu but T2 couldn't find a cpu
> even
> though there were 3 cpus that were available for 2 task to swap.
>
> Again, this is too corner case, that I am okay to drop.

Not only is that above race highly unlikely, it is also
still possible with your patch applied, if the scores
between cpu1, cpu2, and cpu3 differ by more than
SMALLIMP/2.

Not only is this patch some weird magic that makes the
code harder to maintain (since its purpose does not match
what the code actually does), but it also does not
reliably do what you intend it to do.

We may be better off not adding this bit of complexity.

--=20
All Rights Reversed.
--=-RietDPWlo5hqx4g6EzUy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsYFI0ACgkQznnekoTE
3oPYfwf+P0py+4EOp1vBeBLKA1h3UZZhJxgkVclhiXvAmHFH7n1NAao/Cs/meyrE
xtfqmYPdNFppw0SXsSG/EqaaFu6LMEyuLUE1OmEpRzRxtL8eqtl8QV2iykxkeD0/
4xjPV9WrPvWl8ZFf7OzHc3NlZLE1fyfp1LSkQN+XCCDdQqWA3pVnsfdxNqwgVmEn
3osbrb3523FB1uOFt07eqHa2Ay0OMdgtUqr7Y7TXxJ8VRSIVl/kamla79G4KKECL
hZI3CQQ5J5hKD7k3SsqtByUf7O65EtOyz/HrnJRjsPsDgPDBnu5HDWbhAVAFBksg
Ist1gMtUtpImnTbzPn0GmJ2Q1Ef/3g==
=JGFb
-----END PGP SIGNATURE-----

--=-RietDPWlo5hqx4g6EzUy--
