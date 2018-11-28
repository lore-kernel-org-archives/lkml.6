Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B00C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4280620817
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="flXYav4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4280620817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeK1Nw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 08:52:29 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1967 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeK1Nw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 08:52:29 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bfe02c70000>; Tue, 27 Nov 2018 18:51:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Nov 2018 18:52:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Nov 2018 18:52:29 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 28 Nov
 2018 02:52:29 +0000
Subject: Re: [PATCH v2 0/6] RFC: gup+dma: tracking dma-pinned pages
To:     Tom Talpey <tom@talpey.com>, <john.hubbard@gmail.com>,
        <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20181110085041.10071-1-jhubbard@nvidia.com>
 <942cb823-9b18-69e7-84aa-557a68f9d7e9@talpey.com>
 <97934904-2754-77e0-5fcb-83f2311362ee@nvidia.com>
 <5159e02f-17f8-df8b-600c-1b09356e46a9@talpey.com>
 <c1ba07d6-ebfa-ddb9-c25e-e5c1bfbecf74@nvidia.com>
 <15e4a0c0-cadd-e549-962f-8d9aa9fc033a@talpey.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <313bf82d-cdeb-8c75-3772-7a124ecdfbd5@nvidia.com>
Date:   Tue, 27 Nov 2018 18:52:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <15e4a0c0-cadd-e549-962f-8d9aa9fc033a@talpey.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543373511; bh=4/O4KxmkbpQxeGqxvaXxwO9Q+QK3ZAUF6CqEchybL2A=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=flXYav4fHaJScsfdn+h1Udy38gBvpTJ0HBOSJwCifD8XpD658NmN0z0AR+Wx4//5L
         4IdFQjt/zgW6EYndT5qpm00ufgMX1POkfTbwlPe/A+ux06/qBW44I15oQ+lnwsSlMC
         yVAEKKV4TN9aJ2RLS9vi3xExxWXQ8wZaKRAXVkFysp8nkhbcKyG0SG36oN7TcsmI9A
         FYL6ka5ZMwna75jK1vFU8oUIz/G5wHfpwiYuJ/C3T2V6k6ZECP8SvFZENX8vJUXxFh
         HV4X7VnWOoOD+x3weFHvhRydgCct/NkMwSZkIhpyy0ZqZvC2RQT+AirOeJi14GKtmk
         0t7zBPCMSGgIA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 5:21 PM, Tom Talpey wrote:
> On 11/21/2018 5:06 PM, John Hubbard wrote:
>> On 11/21/18 8:49 AM, Tom Talpey wrote:
>>> On 11/21/2018 1:09 AM, John Hubbard wrote:
>>>> On 11/19/18 10:57 AM, Tom Talpey wrote:
[...]
>>>
>>> What I'd really like to see is to go back to the original fio parameter=
s
>>> (1 thread, 64 iodepth) and try to get a result that gets at least close
>>> to the speced 200K IOPS of the NVMe device. There seems to be something
>>> wrong with yours, currently.
>>
>> I'll dig into what has gone wrong with the test. I see fio putting data =
files
>> in the right place, so the obvious "using the wrong drive" is (probably)
>> not it. Even though it really feels like that sort of thing. We'll see.
>>
>>>
>>> Then of course, the result with the patched get_user_pages, and
>>> compare whichever of IOPS or CPU% changes, and how much.
>>>
>>> If these are within a few percent, I agree it's good to go. If it's
>>> roughly 25% like the result just above, that's a rocky road.
>>>
>>> I can try this after the holiday on some basic hardware and might
>>> be able to scrounge up better. Can you post that github link?
>>>
>>
>> Here:
>>
>> =C2=A0=C2=A0=C2=A0 git@github.com:johnhubbard/linux (branch: gup_dma_tes=
ting)
>=20
> I'm super-limited here this week hardware-wise and have not been able
> to try testing with the patched kernel.
>=20
> I was able to compare my earlier quick test with a Bionic 4.15 kernel
> (400K IOPS) against a similar 4.20rc3 kernel, and the rate dropped to
> ~_375K_ IOPS. Which I found perhaps troubling. But it was only a quick
> test, and without your change.
>=20

So just to double check (again): you are running fio with these parameters,
right?

[reader]
direct=3D1
ioengine=3Dlibaio
blocksize=3D4096
size=3D1g
numjobs=3D1
rw=3Dread
iodepth=3D64



> Say, that branch reports it has not had a commit since June 30. Is that
> the right one? What about gup_dma_for_lpc_2018?
>=20

That's the right branch, but the AuthorDate for the head commit (only) some=
how
got stuck in the past. I just now amended that patch with a new date and pu=
shed=20
it, so the head commit now shows Nov 27:

   https://github.com/johnhubbard/linux/commits/gup_dma_testing


The actual code is the same, though. (It is still based on Nov 19th's f2ce1=
065e767
commit.)


thanks,
--=20
John Hubbard
NVIDIA
