Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FC5C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5684E20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="p85zWE8O";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QAPi5B+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5684E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbeJWBzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:55:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45916 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728628AbeJWBzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:55:48 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9MHYsmc011500;
        Mon, 22 Oct 2018 10:36:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WUOIFklUIvTAL2Afk9cPJ8hrqdwrtaRsjN6acajM+P8=;
 b=p85zWE8Ouhj9NZxZj8O2VvjvaJabGnKg+w3V9tTC+pzB0LxHS+qCd13Gms3MOmnnKE7/
 ZWwZ/D8uIFCuX7sH33JMiv+FU6xr73NBky5Sdtm67docD/YZ0fBQ6pJePGQ5br9VTBpS
 Aa/kKARJxZHzxDFfv9xyq7EbYoAQb4m/IJo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2n9fshrwta-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Oct 2018 10:36:05 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 22 Oct 2018 10:36:00 -0700
Received: from PRN-CHUB06.TheFacebook.com (2620:10d:c081:35::15) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 22 Oct 2018 10:36:00 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.16) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 22 Oct 2018 10:36:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUOIFklUIvTAL2Afk9cPJ8hrqdwrtaRsjN6acajM+P8=;
 b=QAPi5B+qpjIAHY6gg7j7TMEIxDi2A9uLsdL0FN6D9ryvVt+WZKSgfewA61hRLbsLESiqtSxlJu7BASfqzfiYc2gj7bLm3QZrqUUTCxjbSwnqfxYm+uAVU4MbzD1wVvJ6JcNXbktjMlU0VWUp4RrXaZ+CX97K4Sf8YV51fp9YTqw=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0262.namprd15.prod.outlook.com (10.163.64.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Mon, 22 Oct 2018 17:35:57 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1250.028; Mon, 22 Oct 2018
 17:35:57 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Spock <dairinin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Memory management issue in 4.18.15
Thread-Topic: Memory management issue in 4.18.15
Thread-Index: AQHUaeHkHk+DbEcbikCQiNZLx8ZaF6Urh5iA
Date:   Mon, 22 Oct 2018 17:35:57 +0000
Message-ID: <20181022173550.GA9592@tower.DHCP.thefacebook.com>
References: <CADa=ObrwYaoNFn0x06mvv5W1F9oVccT5qjGM8qFBGNPoNuMUNw@mail.gmail.com>
 <20181022083322.GE32333@dhcp22.suse.cz>
In-Reply-To: <20181022083322.GE32333@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0057.namprd22.prod.outlook.com
 (2603:10b6:300:12a::19) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:c82f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0262;20:NQj/MbdRkxC2/5xYqka/cT1065Es+uTRllx0bSORvyVvCnK1TqWQsU3Ct/4gIIFIh1QDLx8B78pf+fIHsx8LJaDVIsIXPcVBtbwwoJraCbs0obI0f6CxwsmUiEfs8C8dsrhRfoGr2DQyato30mut68oxX149yv2MhEPj+OJ7bCo=
x-ms-office365-filtering-correlation-id: e0e8f5cb-70c8-46c3-7018-08d63844d309
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0262;
x-ms-traffictypediagnostic: BY2PR15MB0262:
x-microsoft-antispam-prvs: <BY2PR15MB02620EFBBEE568FD0ABCD1CFBEF40@BY2PR15MB0262.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0262;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0262;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(136003)(366004)(346002)(199004)(189003)(46003)(76176011)(5024004)(4326008)(11346002)(2900100001)(7736002)(386003)(256004)(486006)(25786009)(39060400002)(1076002)(446003)(33656002)(476003)(6116002)(71190400001)(81156014)(71200400001)(8676002)(9686003)(14454004)(2906002)(81166006)(6512007)(6436002)(97736004)(53936002)(478600001)(6486002)(186003)(5250100002)(6246003)(105586002)(86362001)(229853002)(106356001)(33896004)(68736007)(8936002)(305945005)(5660300001)(52116002)(6916009)(7416002)(99286004)(102836004)(6506007)(54906003)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0262;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1XEZFkTzSf5herXtsPYet3qievwCdapSds/xSF4EZf38/Pb03H0lQ6Dlrl9NfSVf0PuFvxZyiMrFrq9qAETF1HBrLNjYxe0hnqCdsKfo6ZW0bOKQldcxIuuSaceZd7DbIAHQuvcEwJPWAujtYUFRFwx4GE9ezEJDRTkJm2bPCcB0M229eVXUHrl1C/KCGy6boI7rQSQ6rmtdFYfQ6Ms+oZ1pP6GfmxS/ljZxbW05rTYcN9Gy05ClnLeH+ulKszvbx0CkmjDu1K95qQjIN3LUlrNapQDEoP1nxSSTm1QpnFfFS0Up/1q4639TzQbLEsJjX/Au1MTqGbn+w2U1XhBIWCmlNlcL9mi8Z7llScbWb38=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F1A88CC12485E84292DE324AD647ABEF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e8f5cb-70c8-46c3-7018-08d63844d309
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 17:35:57.4828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0262
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-22_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 10:33:22AM +0200, Michal Hocko wrote:
> Cc som more people.
>=20
> I am wondering why 172b06c32b94 ("mm: slowly shrink slabs with a
> relatively small number of objects") has been backported to the stable
> tree when not marked that way. Put that aside it seems likely that the
> upstream kernel will have the same issue I suspect. Roman, could you
> have a look please?

So, the problem is probably caused by the unused inode eviction code:
inode_lru_isolate() invalidates all pages belonging to an unreferenced
clean inode at once, even if the goal was to scan (and potentially free)
just one inode (or any other slab object).

Spock's workload, as described, has few large files in the pagecache,
so it becomes noticeable. A small pressure applied on inode cache
surprisingly results in cleaning up significant percentage of the memory.

It happened before my change too, but was probably less noticeable, because
usually required higher memory pressure to happen. So, too aggressive recla=
im
was less unexpected.

How to fix this?

It seems to me, that we shouldn't try invalidating pagecache pages from
the inode reclaim path at all (maybe except inodes with only few pages).
If an inode has a lot of attached pagecache, let it be evicted "naturally",
through file LRU lists.
But I need to perform some real-life testing on how this will work.

Thanks!
