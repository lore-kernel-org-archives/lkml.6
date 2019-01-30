Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2C4C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF29020870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rli5gtMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbfA3SOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:14:30 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19209 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfA3SO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:14:29 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c51e9690000>; Wed, 30 Jan 2019 10:14:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 30 Jan 2019 10:14:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 30 Jan 2019 10:14:29 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 18:14:28 +0000
Subject: Re: [v3 PATCH] mm: ksm: do not block on page lock when searching
 stable tree
To:     Yang Shi <yang.shi@linux.alibaba.com>, <ktkhai@virtuozzo.com>,
        <hughd@google.com>, <aarcange@redhat.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1548793753-62377-1-git-send-email-yang.shi@linux.alibaba.com>
 <82ba1395-baab-3b95-a3f7-47e219551881@nvidia.com>
 <7cf16cfb-3190-dfbd-ce72-92a94d9277f5@linux.alibaba.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <9bf60825-286f-d46c-b6d5-ee8bfffaaa48@nvidia.com>
Date:   Wed, 30 Jan 2019 10:14:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7cf16cfb-3190-dfbd-ce72-92a94d9277f5@linux.alibaba.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548872041; bh=vRFnZGny9hUnD9eny/611Mn7d12FxGlSSC/uexCXw2o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rli5gtMIAFpKXWV/KbzHzT5AIrb3FbVc7sMVRw+V8zZHiJE4y6MvNz1NiK9Hnx7Sl
         Zplal1p/QflKbl/jb6FEsKs0W2mVCTgC5XOWGn1cyT8phMAQHCe1ayZzol5rieXEzE
         ZKkGLyBNdeIccVbLZuT9iWpZKbJ0sLCH7SctfnEOil4gGOd6l1oJnEHiuel2EkjHlT
         eVlthmdkOgV2SM7Ho/uuOKn7iTbZnrOxTZphLT5lFm/CXapXf9RORKmH0ci3oHZAfY
         QXv/a+8oXTi255Avi9r7XdMI4bwhG3neFpS3GtoMes/ugRQUmYKQ9iCt+aCNA1vqxJ
         l8cRsAGO8TXVg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 9:47 AM, Yang Shi wrote:
[...]
>>> @@ -1673,7 +1688,12 @@ static struct page *stable_tree_search(struct pa=
ge *page)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 * It would be more elegant to return stable_node
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 * than kpage, but that involves more changes.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tre=
e_page =3D get_ksm_page(stable_node_dup, true);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tre=
e_page =3D get_ksm_page(stable_node_dup,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 GET_KSM_PAGE_TRYLOCK);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(PTR_ERR(tree_page) =3D=3D -EBUSY)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-EBUSY);
>>
>> or just:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0if (PTR_ERR(tree_page) =3D=3D -EBUSY)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return tree_page;
>>
>> right?
>=20
> Either looks fine to me. Returning errno may look more explicit? Anyway I=
 really don't have preference.

Yes, either one is fine. I like to see less code on the screen, all else be=
ing equal,
but it's an extremely minor point, and sometimes being explicit instead is =
better anyway.



thanks,
--=20
John Hubbard
NVIDIA
