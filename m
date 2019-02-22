Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E82C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434032075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfBVS4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:56:19 -0500
Received: from shelob.surriel.com ([96.67.55.147]:56494 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVS4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:56:19 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gxFzZ-0005ky-Qo; Fri, 22 Feb 2019 13:56:13 -0500
Message-ID: <f39cf989bc4c39c6065cd0896c99e20c63316b3b.camel@surriel.com>
Subject: Re: [PATCH RFC] mm/vmscan: try to protect active working set of
 cgroup from reclaim.
From:   Rik van Riel <riel@surriel.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Date:   Fri, 22 Feb 2019 13:56:13 -0500
In-Reply-To: <20190222175825.18657-1-aryabinin@virtuozzo.com>
References: <20190222175825.18657-1-aryabinin@virtuozzo.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zrqnWZMPMJ+zyetOZuRD"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zrqnWZMPMJ+zyetOZuRD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-02-22 at 20:58 +0300, Andrey Ryabinin wrote:
> In a presence of more than 1 memory cgroup in the system our reclaim
> logic is just suck. When we hit memory limit (global or a limit on
> cgroup with subgroups) we reclaim some memory from all cgroups.
> This is sucks because, the cgroup that allocates more often always
> wins.
> E.g. job that allocates a lot of clean rarely used page cache will
> push
> out of memory other jobs with active relatively small all in memory
> working set.
>=20
> To prevent such situations we have memcg controls like low/max, etc
> which
> are supposed to protect jobs or limit them so they to not hurt
> others.
> But memory cgroups are very hard to configure right because it
> requires
> precise knowledge of the workload which may vary during the
> execution.
> E.g. setting memory limit means that job won't be able to use all
> memory
> in the system for page cache even if the rest the system is idle.
> Basically our current scheme requires to configure every single
> cgroup
> in the system.
>=20
> I think we can do better. The idea proposed by this patch is to
> reclaim
> only inactive pages and only from cgroups that have big
> (!inactive_is_low()) inactive list. And go back to shrinking active
> lists
> only if all inactive lists are low.

Your general idea seems like a good one, but
the logic in the code seems a little convoluted
to me.

I wonder if we can simplify things a little, by
checking (when we enter page reclaim) whether
the pgdat has enough inactive pages based on
the node_page_state statistics, and basing our
decision whether or not to scan the active lists
off that.

As it stands, your patch seems like the kind of
code that makes perfect sense today, but which
will confuse people who look at the code two
years from now.

If the code could be made a little more explicit,
great. If there are good reasons to do things in
the fallback way your current patch does it, the
code could use some good comments explaining why :)

--=20
All Rights Reversed.

--=-zrqnWZMPMJ+zyetOZuRD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlxwRc0ACgkQznnekoTE
3oOzJgf+IxsPL5yIB5u027UvllE62JRrGLEE5jT6pUWMuilQAYqXRs4OJ+dUXeJG
ZFT/XqnrA8OQ+HtA9yZ7qvu8O4QxQvrHA2DD3Xvc62SyuMQn+07JT6oreNsXSAJR
j4M3bvj8SGycS81sImxx7q5TYB+QSpBsYOzHYultqY4gO6xiAiCU4+FNuO9V1OoI
jVLuIp0aMmbMhE9lEWzMLPfPBMH3uZFELmPXTJDlE6G8Cd1CTAzFj41Po99yYN0w
BtdHFWSU2cmSg/aKVJCGgVoC93EiL6m7DcuYJWQtgWVJ+tVxVwPIZ/ICHRbC0deo
19rUK2TX7FzIBhReWch3aVNGDnokBg==
=VKDb
-----END PGP SIGNATURE-----

--=-zrqnWZMPMJ+zyetOZuRD--

