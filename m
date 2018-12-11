Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5928DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177502081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FLMasdyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177502081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeLKHSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:18:30 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:27378 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLKHSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:18:30 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181211071826epoutp026b44dca48d37d790eee25de655562685~vNh_Dn2YI2627626276epoutp02e
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 07:18:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181211071826epoutp026b44dca48d37d790eee25de655562685~vNh_Dn2YI2627626276epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544512706;
        bh=Y5Iuv5C8K4bQS68SZQ2y7nlp6TP1BkHsJUvM4ev0ihA=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=FLMasdyOYiAHaHgFp8sSCJMUh+t6ahrWHUsje+GxJ98QG7MbZK+A/6lS6bQvV8+4F
         ajTBskRa0nES0SJTTtJuB1wOC0KHtv4a1J/70uztQfpsHOvd2pVLMdpuytvfmFGFig
         +y3tC2hCVO2IX0CwG5QR/Qq29Ea3l7duSZhOzzaU=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181211071823epcas1p1156125b1fdffcc6853f75b00a74e082d~vNh7e5XrP1800318003epcas1p1z;
        Tue, 11 Dec 2018 07:18:23 +0000 (GMT)
X-AuditID: b6c32a37-411ff70000000fdc-74-5c0f64bbf7c9
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.F0.04060.BB46F0C5; Tue, 11 Dec 2018 16:18:19 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v3] PM / devfreq: Restart previous governor if new
 governor fails to start
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <skannan@codeaurora.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <5C0F4C9A.8030607@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181211071818epcms1p30d107ed61043d39b38960ef1616282a0@epcms1p3>
Date:   Tue, 11 Dec 2018 16:18:18 +0900
X-CMS-MailID: 20181211071818epcms1p30d107ed61043d39b38960ef1616282a0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmge7uFP4Yg8uXOSyuf3nOanG26Q27
        xeVdc9gsPvceYbQ4c/oSq8WBixPZHNg8Lvf1MnlsudrO4tG3ZRWjx+dNcgEsUdk2GamJKalF
        Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDLlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2SqkFKTkFlgV6xYm5xaV56XrJ+blWhgYGRqZAhQnZGd19E5kKznFV
        fPnbwNTA+JSzi5GTQ0LAROLq06fMXYxcHEICOxglnt47xtrFyMHBKyAo8XeHMEiNsECKxNMr
        r9lAbCEBJYmGm/uYIeL6Eh0PtjGC2GwCuhJbN9xlAbFFBEIk9nS9ZweZySxwiVFiwt7rrBDL
        eCVmtD9lgbClJbYv3wrWzCmgLfH5+zeouKjEzdVv2WHs98fmM0LYIhKt984yQ9iCEg9+7oaK
        S0k8ebsQqr5e4vrnRUwgiyUEJjBK/L7xHyqhL/HoymywD3gFfCXWrrkMNohFQFVi6+QDUENd
        JO4u6mMCsZmBDlq28DUzKCCYBTQl1u/ShwjzSbz72gP3y455T5ggbDWJQ7uXQK2SkTg9fSHU
        SA+JfXt+sEACbiGLxKI3vBMY5WchgncWkmWzEJYtYGRexSiWWlCcm55abFhgjByjmxjBiU/L
        fAfjhnM+hxgFOBiVeHgVWvhihFgTy4orcw8xSnAwK4nw6qbxxgjxpiRWVqUW5ccXleakFh9i
        NAX6eSKzlGhyPjAp55XEG5oaGRsbW5gYmpkaGiqJ8z6RmhstJJCeWJKanZpakFoE08fEwSnV
        wFi1kG3lBw8O8ZKLLMcE1keJdOiKOzYFcv1flOl5+/ZshWnv3iX22tSk37+8cm5betq1azsm
        KT1/2REixze9c4LZxY13RU6t4p2YrcI6Nez1qds6U3W1Pz0VP1xSviB/ks0xX0mle/Vm/35Y
        7lnBum7mGd3UrW+TjorWVaXlHpL8Zb/P4YyZSpMSS3FGoqEWc1FxIgAHmnVhkgMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20161026191715epcas1p311c2c626563a736e14c83fb0504c099e
References: <5C0F4C9A.8030607@samsung.com>
        <1477509425-16936-1-git-send-email-skannan@codeaurora.org>
        <de0f8010-31b2-8cec-f793-393c2199f44d@samsung.com>
        <5820CE7E.40802@codeaurora.org> <5821948B.2010907@samsung.com>
        <58223AF1.2030605@codeaurora.org> <58227CDB.6050907@samsung.com>
        <58228B9E.2090108@samsung.com> <58228C10.3070502@samsung.com>
        <58238840.90802@codeaurora.org> <5823BB01.3090502@samsung.com>
        <5164dea6-ad0c-d817-eb0d-36d9f4a718d4@codeaurora.org>
        <CGME20161026191715epcas1p311c2c626563a736e14c83fb0504c099e@epcms1p3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Saravana,
>=20
> The devfreq git repo is maintained by Myungjoo Ham.
> you can check it on MAINTAINERS file.
>=20
> I think that you better to resend mail to mainline
> with my reviewed tag because the devfreq core could be modified
> and then merge conflict might be happen when apply this patch.
>=20
> Regards,
> Chanwoo Choi
>=20
> On 2018=EB=85=84=2012=EC=9B=94=2008=EC=9D=BC=2005:29,=20Saravana=20Kannan=
=20wrote:=0D=0A>=20>=20=0D=0A>=20>=20On=2011/9/16=204:10=20PM,=20Chanwoo=20=
Choi=20wrote:=0D=0A>=20>>=20After=20fixing=20the=20bug=20of=20devfreq_add_d=
evice(),=0D=0A>=20>>=20I'll=20remove=20the=20unneeded=20'if=20statement'=20=
of=20prev_governor=20in=20governor_store.=0D=0A>=20>=20=0D=0A>=20>=20It's=
=20been=202=20years=20and=20this=20patch=20still=20hasn't=20been=20picked=
=20up.=20Can=20we=20please=20pick=20this=20up=20and=20get=20this=20into=20t=
he=20next=20kernel=20release?=0D=0A>=20>=20=0D=0A>=20>=20Thanks,=0D=0A>=20>=
=20=0D=0A>=20>=20Saravana=0D=0A>=20>=20=0D=0A=0D=0AIf=20that's=20already=20=
2=20years=20old,=20please=20rebase,=20test=20to=20see=20if=20that's=0D=0Ast=
ill=20valid=20with=20today's=20kernel,=20and=20resubmit.=0D=0A=0D=0ASorry=
=20for=20missing=20it,=20right=20now,=20after=202=20years,=0D=0AI=20just=20=
can't=20remember=20this=20one.=0D=0A=0D=0ACheers,=0D=0AMyungJoo=0D=0A=0D=0A
