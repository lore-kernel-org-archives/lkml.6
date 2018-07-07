Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B26C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 22:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF5120862
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 22:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF5120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932754AbeGGWMH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 18:12:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:37468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753758AbeGGWMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 18:12:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6598AD72;
        Sat,  7 Jul 2018 22:12:04 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Paolo Abeni <pabeni@redhat.com>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Sun, 08 Jul 2018 08:11:54 +1000
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [4/4] rhashtable: improve rhashtable_walk stability when stop/start used.
In-Reply-To: <86f305ff238d7cdac7ab20b0d6395cc6571cf4e0.camel@redhat.com>
References: <152452255351.1456.12384285355497513812.stgit@noble> <86f305ff238d7cdac7ab20b0d6395cc6571cf4e0.camel@redhat.com>
Message-ID: <87tvpawv9x.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05 2018, Paolo Abeni wrote:

>
> While testing new code that uses the rhashtable walker, I'm obeserving
> an use after free, that is apparently caused by the above:
>
> [  146.834815] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  146.842933] BUG: KASAN: use-after-free in inet_frag_worker+0x9f/0x210
                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Hi,
 did you get a chance to run ./scripts/faddr2line on this address and
find out where it is crashing?  I had a look in the code you posted and
couldn't see anything obvious.


> [  146.850120] Read of size 4 at addr ffff881b6b9342d8 by task kworker/13=
:1/177
> [  146.857984]=20
> [  146.859645] CPU: 13 PID: 177 Comm: kworker/13:1 Not tainted 4.18.0-rc3=
.mirror_unclone_6_frag_dbg+ #1974
> [  146.870128] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.1.7=
 06/16/2016
> [  146.878478] Workqueue: events inet_frag_worker
> [  146.883433] Call Trace:
> [  146.886162]  dump_stack+0x90/0xe3
> [  146.889861]  print_address_description+0x6a/0x2a0
> [  146.895109]  kasan_report+0x176/0x2d0
> [  146.899193]  ? inet_frag_worker+0x9f/0x210
> [  146.903762]  inet_frag_worker+0x9f/0x210
> [  146.908142]  process_one_work+0x24f/0x6e0
> [  146.912614]  ? process_one_work+0x1a6/0x6e0
> [  146.917285]  worker_thread+0x4e/0x3d0
> [  146.921373]  kthread+0x106/0x140
> [  146.924970]  ? process_one_work+0x6e0/0x6e0
> [  146.929637]  ? kthread_bind+0x10/0x10
> [  146.933723]  ret_from_fork+0x3a/0x50
> [  146.937717]=20
> [  146.939377] Allocated by task 177:
> [  146.943170]  kasan_kmalloc+0x86/0xb0
> [  146.947158]  __kmalloc_node+0x181/0x430
> [  146.951438]  kvmalloc_node+0x4f/0x70
> [  146.955427]  alloc_bucket_spinlocks+0x34/0xa0

This seems to suggest that it is one of the bucket spinlocks that is
being incorrectly referenced, but they aren't referenced in the failing
code at all.  I cannot imagine how to interpret that.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltBOqoACgkQOeye3VZi
gbnezQ/9Elqp2PTjdsdE3icERUum7nxUYZV8cCuXoWdUgRA17oqfNmxiPsyxojIh
uVN7LKqkeFH8FJU2OpivQrtRyzQAU7p80CSqds5DPIn62r/b5k/QkMNf+WowluSY
MR9PAeqQZfXTd/TDNDkT7sBtNYC2qStj+VHEm2Suap5tcY878wtbKp+HB07HJr1q
xLOCudq/T0ZK9Vum/eZDccEpqxsxEzFOSY6o9SqIl7rC1qXzX9+02R1sZKwolp0Z
WLRM/tO+NCwh98jA75GjN0LXJg368KDgbNu3IP83/dxNOyuSxOputt+yNZbYV9X5
Noqy2Mgd4Xt4IsEBB3gGgXu8RhqiJ27vccgCKAD8negvEGbu502/r3vqCDaJjrMH
0N/eFvh5VvOPnvOhYbChHAs6tAPL0nqK6HkbOc1slOmuHQDQhfxEtS7SWK7Jfimr
rZKMwzk/WpPVITDgaOITcZ2mvqm+69bciRnJNQHR33HPREYwSQpY3TlaZz/vKfE3
FHeBb0DOPMkC2SiH0WAKjwOkbt2f1mlkm7dEby12HxyoM25RNNMPzcKC9h+3CUG7
8D/26SJZqoODAplthCsoHB4eL8ctg0XEGsdmkY5SqV5xm6ipf2oVa+WUT71VjSJM
GGQVdfj0Lb2pSKcBYOTJAM0Ucg4bbfDyuH5K/5oh3i3JOe+FNV8=
=o7LG
-----END PGP SIGNATURE-----
--=-=-=--
