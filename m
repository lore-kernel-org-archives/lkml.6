Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB2FC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63E92086B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="A0+j/6f4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63E92086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeK3OIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:08:10 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11745 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3OIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:08:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c00a7cd0002>; Thu, 29 Nov 2018 19:00:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 29 Nov 2018 19:00:24 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 29 Nov 2018 19:00:24 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Nov
 2018 03:00:24 +0000
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
 <313bf82d-cdeb-8c75-3772-7a124ecdfbd5@nvidia.com>
 <2aa422df-d5df-5ddb-a2e4-c5e5283653b5@talpey.com>
 <7a68b7fc-ff9d-381e-2444-909c9c2f6679@nvidia.com>
 <1939f47a-eaec-3f2c-4ae7-f92d9fba7693@talpey.com>
 <0f093af1-dee9-51b6-0795-2c073a951fed@nvidia.com>
 <c64387d6-c51d-185a-d2a4-1fedcdac0abe@talpey.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <04c18816-e15d-bffd-e8be-eceefae77197@nvidia.com>
Date:   Thu, 29 Nov 2018 19:00:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <c64387d6-c51d-185a-d2a4-1fedcdac0abe@talpey.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543546830; bh=1A37q553sh7B6EidyLPFEGBjBHcMj7KWdnd11luENxM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=A0+j/6f4bovnRne9vtm4l9LNYnhVhLa9cTK6ZkWFOg+4Ed2/D+HGsKmO9+O+RT0wX
         DdFxs9CrWKnIxCH7IFLzETtTNajAUQ44oiz77IgqrzFbXsHPhtG2KNgZpSFnywpu79
         006qcX4kRr+c9C/wQ3LOgMq9fBsxoRHk30eOSAaXNfkbjpg7rL0DF/uX4kjCZodYOS
         EsBkVDxT1j7RnImf7SI4RvZYMsWVHV09WcTS7b0W38W5qz5Ov3/xkYGDYmrvLlD6pN
         CblkaCEEpZx7Lb8yc57/sBogeNPg189loPwi6zlAU+6XiWHcb5myMS0J3vVEHDbpdN
         E+OR91B6dvQmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 6:30 PM, Tom Talpey wrote:
> On 11/29/2018 9:21 PM, John Hubbard wrote:
>> On 11/29/18 6:18 PM, Tom Talpey wrote:
>>> On 11/29/2018 8:39 PM, John Hubbard wrote:
>>>> On 11/28/18 5:59 AM, Tom Talpey wrote:
>>>>> On 11/27/2018 9:52 PM, John Hubbard wrote:
>>>>>> On 11/27/18 5:21 PM, Tom Talpey wrote:
>>>>>>> On 11/21/2018 5:06 PM, John Hubbard wrote:
>>>>>>>> On 11/21/18 8:49 AM, Tom Talpey wrote:
>>>>>>>>> On 11/21/2018 1:09 AM, John Hubbard wrote:
>>>>>>>>>> On 11/19/18 10:57 AM, Tom Talpey wrote:
>>>>>> [...]
>>> Excerpting from below:
>>>
>>>> Baseline 4.20.0-rc3 (commit f2ce1065e767), as before:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read: IOPS=3D193k, BW=3D753MiB/s (790MB=
/s)(1024MiB/1360msec)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 : usr=3D16.26%, sys=3D48.05%, ctx=3D251258, majf=3D0, minf=3D7=
3
>>>
>>> vs
>>>
>>>> With patches applied:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read: IOPS=3D193k, BW=3D753MiB/s (790MB=
/s)(1024MiB/1360msec)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 : usr=3D16.26%, sys=3D48.05%, ctx=3D251258, majf=3D0, minf=3D7=
3
>>>
>>> Perfect results, not CPU limited, and full IOPS.
>>>
>>> Curiously identical, so I trust you've checked that you measured
>>> both targets, but if so, I say it's good.
>>>
>>
>> Argh, copy-paste error in the email. The real "before" is ever so slight=
ly
>> better, at 194K IOPS and 759 MB/s:
>=20
> Definitely better - note the system CPU is lower, which is probably the
> reason for the increased IOPS.
>=20
>>=C2=A0=C2=A0=C2=A0 cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 : usr=3D18.24%, sys=3D44.77%, ctx=3D251527, majf=3D0, minf=3D73
>=20
> Good result - a correct implementation, and faster.
>=20

Thanks, Tom, I really appreciate your experience and help on what performan=
ce=20
should look like here. (I'm sure you can guess that this is the first time=
=20
I've worked with fio, heh.)

I'll send out a new, non-RFC patchset soon, then.

thanks,
--=20
John Hubbard
NVIDIA
