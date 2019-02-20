Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5795C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679572147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kwt4AX6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfBTXSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:18:13 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10352 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTXSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:18:13 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6de03c0000>; Wed, 20 Feb 2019 15:18:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 15:18:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Feb 2019 15:18:12 -0800
Received: from [10.2.169.124] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 23:18:09 +0000
Subject: Re: [PATCH 00/10] HMM updates for 5.1
To:     <jglisse@redhat.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0dbf7e99-7db4-4d8b-ecca-60893c83a2a9@nvidia.com>
Date:   Wed, 20 Feb 2019 15:17:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190129165428.3931-1-jglisse@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550704701; bh=jHmuXcTo/w6zTazajwVjPqQZf/gX3YgCX//I42wV+b8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kwt4AX6q2Qh4NQ4bFbxpjB52vcSjridZ19MNug1EAyU126yrxegiwIExxhEADAnmi
         zaruvMUbAHztcDFdWH0IJmMDn0d2lEORUVh5n7xevio8AMg2hIwYqOEWjfjYiKrFZA
         OChl6P/AiXoHiTdm3fdr0J81cvBwmn5biRRLA85Qwlypdfb2nrSQOD79XP9E4Q706X
         9NwJrY6ldS1/iCSBWeaXE/BskNEvIb0v/vArmQXWj1+5NrCWxUuny0DgTEpjFqT/PY
         l5DrvnvckQulQNG/THILAEqQVR+5pcaBARc+SWnK5Na+dhxJOzYD1cHKEYj9H8z26B
         lc9Qr3g9Fqmxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 8:54 AM, jglisse@redhat.com wrote:
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20
> This patchset improves the HMM driver API and add support for hugetlbfs
> and DAX mirroring. The improvement motivation was to make the ODP to HMM
> conversion easier [1]. Because we have nouveau bits schedule for 5.1 and
> to avoid any multi-tree synchronization this patchset adds few lines of
> inline function that wrap the existing HMM driver API to the improved
> API. The nouveau driver was tested before and after this patchset and it
> builds and works on both case so there is no merging issue [2]. The
> nouveau bit are queue up for 5.1 so this is why i added those inline.
>=20
> If this get merge in 5.1 the plans is to merge the HMM to ODP in 5.2 or
> 5.3 if testing shows any issues (so far no issues has been found with
> limited testing but Mellanox will be running heavier testing for longer
> time).
>=20
> To avoid spamming mm i would like to not cc mm on ODP or nouveau patches,
> however if people prefer to see those on mm mailing list then i can keep
> it cced.
>=20
> This is also what i intend to use as a base for AMD and Intel patches
> (v2 with more thing of some rfc which were already posted in the past).
>=20

Hi Jerome,

Although Ralph has been testing and looking at this patchset, I just now
noticed that there hasn't been much public review of it, so I'm doing
a bit of that now. I don't think it's *quite* too late, because we're
still not at the 5.1 merge window...sorry for taking so long to get to
this.

Ralph, you might want to add ACKs or Tested-by's to some of these
patches (or even Reviewed-by, if you went that deep, which I suspect you
did in some cases), according to what you feel comfortable with?


thanks,
--=20
John Hubbard
NVIDIA
