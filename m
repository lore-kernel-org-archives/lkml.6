Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A23CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3162175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kF26Bgmc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gHJBA8WB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfA3MV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:21:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37580 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725768AbfA3MV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:21:26 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x0UCDTwP007281;
        Wed, 30 Jan 2019 04:21:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wIsFOT/ThnSgY1/P/9Bwo6Ae2LKsIzQUi/sJaebZOAE=;
 b=kF26BgmcI/zFgELmcI1Glve12MebwFUIEuQnVXJo6ZZDSLDVCZkIMvZleC29Tl/ntMwX
 Ju4BaazbfBmdg7Afk140Bjbaj6yw2T3BqevLotRpngpsJuwsumf+HRDUElUghqaVETUZ
 Psu59znyS7/bGU9VRuM4H6zgxSqVt60uj6U= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2qb4dps34w-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Jan 2019 04:21:19 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 30 Jan 2019 04:21:09 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 30 Jan 2019 04:21:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIsFOT/ThnSgY1/P/9Bwo6Ae2LKsIzQUi/sJaebZOAE=;
 b=gHJBA8WB5z48aIgXchriiOw8BjYlwgL82yTC5oYOpP/z6ybmPcw3rdTvbpx+KCw2xBm6eBEr2V1es3yQ8yiGLwbKyHFMjrCutdFiB0fV/4KqiAhEjaPkLyt3uQNwMjorjBasK/tNnebebguoe/0Pj5TQaMcQXpFg7bVMjTPLiMw=
Received: from DM5PR15MB1883.namprd15.prod.outlook.com (10.174.247.135) by
 DM5SPR00MB335.namprd15.prod.outlook.com (10.173.225.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Wed, 30 Jan 2019 12:21:07 +0000
Received: from DM5PR15MB1883.namprd15.prod.outlook.com
 ([fe80::9c23:2db3:1e2a:4796]) by DM5PR15MB1883.namprd15.prod.outlook.com
 ([fe80::9c23:2db3:1e2a:4796%9]) with mapi id 15.20.1558.025; Wed, 30 Jan 2019
 12:21:07 +0000
From:   Chris Mason <clm@fb.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 1/2] Revert "mm: don't reclaim inodes with many attached
 pages"
Thread-Topic: [PATCH 1/2] Revert "mm: don't reclaim inodes with many attached
 pages"
Thread-Index: AQHUuFK1zOCFq26G8UWPT6kjO3PxRaXHu+OA
Date:   Wed, 30 Jan 2019 12:21:07 +0000
Message-ID: <25EAF93D-BC63-4409-AF21-F45B2DDF5D66@fb.com>
References: <20190130041707.27750-1-david@fromorbit.com>
 <20190130041707.27750-2-david@fromorbit.com>
In-Reply-To: <20190130041707.27750-2-david@fromorbit.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.4r5594)
x-clientproxiedby: BN3PR05CA0034.namprd05.prod.outlook.com (2603:10b6:400::44)
 To DM5PR15MB1883.namprd15.prod.outlook.com (2603:10b6:4:4f::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.253.148.112]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5SPR00MB335;20:Mx8BM8q4Vx1SSrQBx/fEAnQEplfrYSryiPi0ONzHsAE5VPGcTaDVNQkjLpK+sU01MT//izWKFZd+Bi4Yddb3CyB6KJH31o1oOm58H0zkNDGTD3rMAj6zBhv/pJ7HxdzfdgrHACCb3NVQ/7EyL+1JGMeaM+aEoACPc/gL7ECDfEA=
x-ms-office365-filtering-correlation-id: cde1cef4-04bb-43d5-9709-08d686ad68f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:DM5SPR00MB335;
x-ms-traffictypediagnostic: DM5SPR00MB335:
x-microsoft-antispam-prvs: <DM5SPR00MB335CAEB1E407C91892C91ADD3900@DM5SPR00MB335.namprd15.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(99286004)(386003)(86362001)(6506007)(102836004)(53546011)(186003)(26005)(52116002)(76176011)(966005)(14454004)(2906002)(6116002)(3846002)(105586002)(106356001)(33656002)(316002)(54906003)(478600001)(6916009)(4326008)(82746002)(68736007)(66066001)(39060400002)(25786009)(53936002)(97736004)(305945005)(7736002)(81166006)(81156014)(8936002)(6246003)(50226002)(36756003)(229853002)(8676002)(6306002)(6486002)(6512007)(486006)(6436002)(446003)(71200400001)(256004)(4744005)(11346002)(2616005)(83716004)(71190400001)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5SPR00MB335;H:DM5PR15MB1883.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AF6+pNW7vwOG8SjERpElEJo4E9YouCqxaEOrq8p1UcTB2IENEn/CsrLqVLcbgZNVwXN6skitd0q0kqM7rcNsNky2kOR8OowcW1DwrcmdLOh5QHa6Ygw/7cErVHs3scVl7d6fZDz7DL4NUuK6l8Yxe4ytC58dViOpubdQd2bS5xLSxR6h0byWN41+espdidowXFuMBOVAdXCYyUcVn3O2EttPxFhlwrKNU38vX64RquOXauzA7ZwJfEVRb3Y2v09RGI38R6iHiOzQrdsLEDGn+w8tRx6J5xwC/eQ3nJ1BkXDwtJJPBJTSCT8Vymkn/J4uAEOjX+eEeiJteYIREDZUqaM2m0GuXOdziIS9UDRZ/kEzbi/zw+6/xCdP3lwnAMFymGV/YiJSGk100TO660N+kEmHz2xwGgmXq/Qj29v2S+0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cde1cef4-04bb-43d5-9709-08d686ad68f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 12:21:05.9398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR00MB335
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29 Jan 2019, at 23:17, Dave Chinner wrote:

> From: Dave Chinner <dchinner@redhat.com>
>
> This reverts commit a76cf1a474d7dbcd9336b5f5afb0162baa142cf0.
>
> This change causes serious changes to page cache and inode cache
> behaviour and balance, resulting in major performance regressions
> when combining worklaods such as large file copies and kernel
> compiles.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D202441

I'm a little confused by the latest comment in the bz:

https://bugzilla.kernel.org/show_bug.cgi?id=3D202441#c24

Are these reverts sufficient?

Roman beat me to suggesting Rik's followup.  We hit a different problem=20
in prod with small slabs, and have a lot of instrumentation on Rik's=20
code helping.

-chris
