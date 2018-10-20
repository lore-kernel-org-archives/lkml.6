Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB14C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E8421533
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KacXSMJJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iWqXlPH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E8421533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJUBxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 21:53:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50056 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726779AbeJUBxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 21:53:06 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9KHb812013794;
        Sat, 20 Oct 2018 10:41:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NC/Sle73F/uSpTU5RYs8zLXYKHlYoXj1XCge4eDFVAM=;
 b=KacXSMJJd9yhLn+5nLHkDxcBbs0WX2P3Ewd22zfhit5VISogC/yqtmKy9ZbgUh934jWT
 hTvo0KdoBY/QtmmUgZB7n3gde1MtrrCXR0KwIVq2BXCMfZRvkVO/19PKdRMZxI7WNWm/
 jkJ1mVQM57cwf9CUjyUtzekA5uzXc6k6EK8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2n80690wxw-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 20 Oct 2018 10:41:26 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Sat, 20 Oct 2018 10:41:04 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Sat, 20 Oct 2018 10:41:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Sat, 20 Oct 2018 10:41:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC/Sle73F/uSpTU5RYs8zLXYKHlYoXj1XCge4eDFVAM=;
 b=iWqXlPH5+gHPD00Rx4jySgENTTD8QaY4PxalP5+zsh+mrYOd76bFCw4wEF5qoVvtTc88fyGg8ph7WUh5e8oylaEUe59sK3aOO1jIy3RadCo2Z+xZaJev7/jD79yyCMopIckZS89HD32N/Ex8Al9LBbqYohY09VhnHrWswMQIae0=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0439.namprd15.prod.outlook.com (10.163.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Sat, 20 Oct 2018 17:41:01 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1250.028; Sat, 20 Oct 2018
 17:41:01 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Spock <dairinin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: Memory management issue in 4.18.15
Thread-Topic: Memory management issue in 4.18.15
Thread-Index: AQHUaIrbHk+DbEcbikCQiNZLx8ZaF6UoZwYA
Date:   Sat, 20 Oct 2018 17:41:00 +0000
Message-ID: <20181020174053.GA6149@castle.DHCP.thefacebook.com>
References: <CADa=ObrwYaoNFn0x06mvv5W1F9oVccT5qjGM8qFBGNPoNuMUNw@mail.gmail.com>
 <a655c898-0701-f10d-bbf3-8a0090544560@infradead.org>
In-Reply-To: <a655c898-0701-f10d-bbf3-8a0090544560@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:301:3b::31) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:9137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0439;20:AodMd79GolS4NRhABYhe6SHIglCWT7WkPMYYAA+0mfVSRGcslsWTFcyK04PYmH6tYTSi/+/ITRokZmJj/Thuz+5qP+SlvziL9sPGmamibSatSjMGbD4DQ/zyhV8Cy1dTzxq/K6Vum5tPadZ5kXWSPjMduj3BOqWKi3Bf13Yxj1A=
x-ms-office365-filtering-correlation-id: 3782331a-091b-4249-6c90-08d636b3330b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0439;
x-ms-traffictypediagnostic: BY2PR15MB0439:
x-microsoft-antispam-prvs: <BY2PR15MB0439F552D87FC9973F1AF696BEFA0@BY2PR15MB0439.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0439;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0439;
x-forefront-prvs: 0831C25939
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(97736004)(5250100002)(2906002)(6116002)(486006)(446003)(46003)(6486002)(6436002)(9686003)(6512007)(476003)(11346002)(6306002)(53936002)(6246003)(256004)(305945005)(102836004)(7736002)(86362001)(186003)(1076002)(54906003)(53546011)(6506007)(386003)(8936002)(33896004)(76176011)(14454004)(39060400002)(105586002)(966005)(316002)(229853002)(71200400001)(71190400001)(52116002)(106356001)(4326008)(81156014)(99286004)(81166006)(33656002)(68736007)(8676002)(478600001)(2900100001)(6916009)(5660300001)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0439;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PItT8F1ZM5ZG45OtANJn4YBMDwgWYQ5sR4qcJN5GTYYItkGC6j8Dx1roDXh9ZXygLg0HRBTGY1iUxgW2NdGcC4D2bu8kbCqqBqiAndDXjQ9fCJU4kf6iBZYLpoz7FSqpmhd1MQy8mwsjto0KO3TEHK48MgNktREKlKYtzc2+mVQT4P0yiqmUMVJsbMK2uiZwU3Pif/niANNxxBABi2vKeK42+1VZLvI8zdcrosP6LdjGBNFY3L8WvYZxk+IdnpJBtfGv2p6WZJINPxocAtmwf3277avJ/6Yx1cQSp3LjFUWLjxQj6M8aegRDvBjnBweN0cQwxh3UICzM1R/wiTBwjlZ/g2/+I72ZDnSPBSwgD14=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <124A14B832841745B95D28394CA443FC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3782331a-091b-4249-6c90-08d636b3330b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2018 17:41:00.9343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0439
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-20_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 08:37:28AM -0700, Randy Dunlap wrote:
> [add linux-mm mailing list + people]
>=20
>=20
> On 10/20/18 4:41 AM, Spock wrote:
> > Hello,
> >=20
> > I have a workload, which creates lots of cache pages. Before 4.18.15,
> > the behavior was very stable: pagecache is constantly growing until it
> > consumes all the free memory, and then kswapd is balancing it around
> > low watermark. After 4.18.15, once in a while khugepaged is waking up
> > and reclaims almost all the pages from pagecache, so there is always
> > around 2G of 8G unused. THP is enabled only for madvise case and are
> > not used.
> >=20
> > The exact change that leads to current behavior is
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3Dlinux-4.18.y&id=3D62aad93f09c1952ede86405894df1b22012fd5ab
> >=20

Hello!

Can you, please, describe your workload in more details?
Do you use memory cgroups? How many of them? What's the ratio between slabs
and pagecache in the affected cgroup? Is the pagecache mmapped by some proc=
ess?
Is the majority of the pagecache created by few cached files or the number
of files is big?

This is definitely a strange effect. The change shouldn't affect pagecache
reclaim directly, so the only possibility I see is that because we started
applying some minimal pressure on slabs, we also started reclaim some inter=
nal
fs structures under background memory pressure, which leads to a more aggre=
ssive
pagecache reclaim.

Thanks!
