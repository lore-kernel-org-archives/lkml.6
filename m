Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6670EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312F720825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312F720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeKIB4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:56:02 -0500
Received: from anholt.net ([50.246.234.109]:33476 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeKIB4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:56:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CE63110A139B;
        Thu,  8 Nov 2018 08:19:48 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id tN-63Uy_hNgh; Thu,  8 Nov 2018 08:19:46 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id DCE3F10A1376;
        Thu,  8 Nov 2018 08:19:46 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 794D02FE1B8F; Thu,  8 Nov 2018 08:19:46 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     "Koenig\, Christian" <Christian.Koenig@amd.com>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nayan Deshmukh <nayan26deshmukh@gmail.com>,
        "Deucher\, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 1/2] Revert "drm/sched: fix timeout handling v2"
In-Reply-To: <2f577af9-9ff7-4e9d-b198-02727a995393@amd.com>
References: <20181108160422.17743-1-eric@anholt.net> <20181108160422.17743-2-eric@anholt.net> <2f577af9-9ff7-4e9d-b198-02727a995393@amd.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 08 Nov 2018 08:19:45 -0800
Message-ID: <875zx7o82m.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Koenig, Christian" <Christian.Koenig@amd.com> writes:

> Am 08.11.18 um 17:04 schrieb Eric Anholt:
>> This reverts commit 0efd2d2f68cd5dbddf4ecd974c33133257d16a8e.  Fixes
>> this failure in V3D GPU reset:
>>
>> [ 1418.227796] Unable to handle kernel NULL pointer dereference at virtu=
al address 00000018
>> [ 1418.235947] pgd =3D dc4c55ca
>> [ 1418.238695] [00000018] *pgd=3D80000040004003, *pmd=3D00000000
>> [ 1418.244132] Internal error: Oops: 206 [#1] SMP ARM
>> [ 1418.248934] Modules linked in:
>> [ 1418.252001] CPU: 0 PID: 10253 Comm: kworker/0:0 Not tainted 4.19.0-rc=
6+ #486
>> [ 1418.259058] Hardware name: Broadcom STB (Flattened Device Tree)
>> [ 1418.265002] Workqueue: events drm_sched_job_timedout
>> [ 1418.269986] PC is at dma_fence_remove_callback+0x8/0x50
>> [ 1418.275218] LR is at drm_sched_job_timedout+0x4c/0x118
>> ...
>> [ 1418.415891] [<c086b754>] (dma_fence_remove_callback) from [<c06e7e6c>=
] (drm_sched_job_timedout+0x4c/0x118)
>> [ 1418.425571] [<c06e7e6c>] (drm_sched_job_timedout) from [<c0242500>] (=
process_one_work+0x2c8/0x7bc)
>> [ 1418.434552] [<c0242500>] (process_one_work) from [<c0242a38>] (worker=
_thread+0x44/0x590)
>> [ 1418.442663] [<c0242a38>] (worker_thread) from [<c0249b10>] (kthread+0=
x160/0x168)
>> [ 1418.450076] [<c0249b10>] (kthread) from [<c02010ac>] (ret_from_fork+0=
x14/0x28)
>>
>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
>> Cc: Nayan Deshmukh <nayan26deshmukh@gmail.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>
> Well NAK. The problem here is that fence->parent is NULL which is most=20
> likely caused by an issue somewhere else.
>
> We could easily work around that with an extra NULL check, but reverting=
=20
> the patch would break GPU recovery again.

My GPU recovery works with the revert and reliably doesn't work without
it, so my idea of "break GPU recovery" is the opposite of yours.  Can
you help figure out what in this change broke my driver?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlvkYiIACgkQtdYpNtH8
nuit4w/9HElAtr6o2/s69glGfsu3HF6ylT87u996R1ombFABoVcNTQSMo9eIDOui
jM3/EQoLsZIFsuKu3VbYLI9J9Gmfx29l9UW4Bu0AIYg3EG3ndDNqjSEwXz7aFUIv
YGwwxtp0L3NG4EjqmhkALr+A9EyC2NzDvk5jadzUKu0XjOhy6z5Kdz6YsmjEMUVV
eHfkCnunlXHMsiQyotDNffK6tkNhlZ4RwKkjSXgaXNlyxZcVt9aYB5muN1pd353D
hlJXoe2DXA6pY/kGq50nt2HvgP5SsYJ/2VfvseVi5yRqrCRFZLcQM9G0vMJY2pMV
DvWh9Mqh9ew91QvZHAnFC2ZOJtyqhVKQwyKUz4EuLK3gLFDkJpnWp4GrX5TDot4C
c9zakZ5SBwJwSZPR35tMvO6Umvno5PWs/2tYYHRKfHeBKtKDDHpVcHu/2kIq+Gjv
3Pw35FA37cRPwk3RoMSHCXszJkAHdPwKyuPB+3JiT2BmaIlYHl3TtldbIlbl8bR2
B6blHtUEPNzBskm01uh5+dSfNHQYBoa8O+BkvKRd1FVKNWnsno+7Cp/Fbq23Xb1n
WMQpNxd+MroLdsAqPWdL6Ls8Brdff7UeF0P2ePXFlS/0paf/fId5/1vk+HcJ9XCc
IGL1Gif94BL/n2VTvGAilOMJ313DonOYVpVIYiY74wVS1cqevFY=
=pUVW
-----END PGP SIGNATURE-----
--=-=-=--
