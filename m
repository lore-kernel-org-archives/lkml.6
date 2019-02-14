Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BA1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F302083E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DkavMxf0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZdxpNN3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfBNAjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:39:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57236 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726337AbfBNAjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:39:11 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1E0cTQa023597;
        Wed, 13 Feb 2019 16:38:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qpP/KdIfG5pR/CDzkwzAnm+87KAsnZ9tqo05PWflvEg=;
 b=DkavMxf0kZppCaWxnTpN5zcFKOIfBZW1QPWsSYkMey7bWVEdjRpNmnZV9dVd1Txyvpmb
 bFj40okVGCBgAGILIt4E18JFc5c/R7HGrxrres05kDu/3vLN1l7FFO+DRL1hiejSMpKr
 e+XrC79aWESu5Ilj80nOz37oh1V1AhGPg1w= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qmu950hgp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 13 Feb 2019 16:38:58 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 13 Feb 2019 16:38:57 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 13 Feb 2019 16:38:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpP/KdIfG5pR/CDzkwzAnm+87KAsnZ9tqo05PWflvEg=;
 b=ZdxpNN3GsmKxLRw0sptndovhTm+BAS65W5HuMiLWFmFwVnx+Wmi/Kvtz1Sog2OzjlmyWvTwmPnmBtmRZVDMUQcJrrW7sUbbE6MnNBUgs/zEfIOJ8gxkiXravpANdtuZRcsOMGL2PfZohtbr+xyvuL3f82RqbKK9iyRLhwPs59as=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2999.namprd15.prod.outlook.com (20.178.238.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 00:38:55 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1601.016; Thu, 14 Feb 2019
 00:38:55 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guroan@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] vmalloc enhancements
Thread-Topic: [PATCH v2 0/3] vmalloc enhancements
Thread-Index: AQHUwvxltqRw0KKPyU2GUxvyv29fa6XcgNAAgAAd04CAAdazgA==
Date:   Thu, 14 Feb 2019 00:38:54 +0000
Message-ID: <20190214003848.GA4898@tower.DHCP.thefacebook.com>
References: <20190212175648.28738-1-guro@fb.com>
 <20190212184724.GA18339@cmpxchg.org>
 <20190212123409.7ed5c34d68466dbd8b7013a3@linux-foundation.org>
In-Reply-To: <20190212123409.7ed5c34d68466dbd8b7013a3@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::48) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:3cbc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cb6e3fb-4158-41dd-050c-08d69214cc5f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2999;
x-ms-traffictypediagnostic: BYAPR15MB2999:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2999;20:rO6Dxg0qdO8gQr2Gq3Ln8nIwUMI4+WQHDqw8knVYAguldUdlQtwoFa+Gu+aDe+w7EW8Q4UQUvJeFoP/M1hTzOXzFQ7vzc7pWIis/VnVSO7dVEyRMI1Go2uQAffMmZBFv3DeklPzhP6bvOYnjy0s4MuK1EgzoHYzlftuOfPYM8qs=
x-microsoft-antispam-prvs: <BYAPR15MB299958CD052FE2ECEE943D0ABE670@BYAPR15MB2999.namprd15.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(81156014)(33896004)(4326008)(8936002)(52116002)(97736004)(386003)(25786009)(6506007)(86362001)(99286004)(6346003)(478600001)(316002)(6246003)(105586002)(14454004)(8676002)(81166006)(54906003)(102836004)(106356001)(1076003)(186003)(6116002)(476003)(33656002)(6436002)(486006)(6486002)(71190400001)(229853002)(14444005)(256004)(9686003)(6512007)(6916009)(53936002)(2906002)(305945005)(46003)(76176011)(7736002)(68736007)(446003)(11346002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2999;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nd+XzQ8ZsmJLCTQc8haj9C9LMD1gxU8AS+ofvS7zxYQXz792E9Vs2I9cG+0ImxR45JT6A1itbCRM8qwNQxCsJrwTadWbX+y1TfIixeo2huleQAxRjGmnB441JF6lPPskK9V+Rf0fgUYFeKyiAwY88vUoDBT6l9ioKNb2WCbfakVGsr/eHtLPnRoR/8Vs/4+fJywdkZLX4VmL2CDQkLjYyHNrriCdc4o0mWSzjeEpcBovi45HEBPXDX+PSim7+8WFkZwcDsPnQHZEfxyOp/1uizMGxYxHgaZCKcGVl3X156iYtP48QpW3f2+as1YLu+X9dDlBB6SIau1QLg7JG3AW17ZzuFEjxwDN7R4UgsBLJ/YRwAFQoWaNNwBTzOGshp6kk+RXZs7MGEe193U8Y/y/7Ecw0eMABotEEsr8U7b76Rc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <66C5D4B9A861674B9DDDAE2FA011711A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb6e3fb-4158-41dd-050c-08d69214cc5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 00:38:54.1421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2999
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:34:09PM -0800, Andrew Morton wrote:
> On Tue, 12 Feb 2019 13:47:24 -0500 Johannes Weiner <hannes@cmpxchg.org> w=
rote:
>=20
> > On Tue, Feb 12, 2019 at 09:56:45AM -0800, Roman Gushchin wrote:
> > > The patchset contains few changes to the vmalloc code, which are
> > > leading to some performance gains and code simplification.
> > >=20
> > > Also, it exports a number of pages, used by vmalloc(),
> > > in /proc/meminfo.
> > >=20
> > > Patch (1) removes some redundancy on __vunmap().
> > > Patch (2) separates memory allocation and data initialization
> > >   in alloc_vmap_area()
> > > Patch (3) adds vmalloc counter to /proc/meminfo.
> > >=20
> > > v2->v1:
> > >   - rebased on top of current mm tree
> > >   - switch from atomic to percpu vmalloc page counter
> >=20
> > I don't understand what prompted this change to percpu counters.
> >=20
> > All writers already write vmap_area_lock and vmap_area_list, so it's
> > not really saving much. The for_each_possible_cpu() for /proc/meminfo
> > on the other hand is troublesome.
>=20
> percpu_counters would fit here.  They have probably-unneeded locking
> but I expect that will be acceptable.
>=20
> And they address the issues with for_each_possible_cpu() avoidance, CPU
> hotplug and transient negative values.

Using existing vmap_area_lock (as Johannes suggested) is also problematic,
due to different life-cycles of vma_areas and vmalloc pages. A special flag
will be required to decrease the counter during the lazy deletion of
vmap_areas. Allocation path will require passing a bool flag through too ma=
ny
nested functions. Also it will be semi-accurate, which is probably tolerabl=
e.
So, it's doable, but doesn't look nice to me.

So, using a simple per-cpu counter still seems to best option.
Transient negative value is a valid concern, but easily fixable.
Are there any other? What's the problem with for_each_possible_cpu()?
Reading /proc/meminfo is not that hot, no?

Thanks!
