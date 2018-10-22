Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CAEC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 23:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B09D20651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 23:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qRFhj1fa";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GfsybtWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B09D20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeJWIFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 04:05:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52262 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725752AbeJWIFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 04:05:31 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9MNZWeO025807;
        Mon, 22 Oct 2018 16:44:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=6A3eeWqTbkb4uHb+rGFeUy1xYiinB6LS2hceXT9miEU=;
 b=qRFhj1faw9As1ZDgks1BvJ8Mk3CGu1G6jpbX7+EgqbjrRF1StVsNFh62kbdm+CW81ZRR
 5mCsZ8aczpIEzTspSGUn47tHBXb/u45IFSLCuWbtplJ2ewG/qE37JAwgqB7uuUNlRJ5v
 uJGBP5jTANC8aJYbLgMnWsbzBFboGO/op+0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n9myagpew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Oct 2018 16:44:38 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 22 Oct 2018 16:44:36 -0700
Received: from FRC-CHUB14.TheFacebook.com (2620:10d:c021:18::33) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 22 Oct 2018 16:44:36 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 22 Oct 2018 19:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A3eeWqTbkb4uHb+rGFeUy1xYiinB6LS2hceXT9miEU=;
 b=GfsybtWveydHNsF7dybhJpjQ6H8LFKciKhNL8XG5zsla1TjPeRwea8kz1aEyvDxDiquSmGG74l8AiqFoS/myDKCZ8ygBtpGdWUizuihr8XVzmPzJnRPlzhOIH4x/JZDHAmyoMLTq7jhQBD0VsRTN3lJn0o993CS5pH33cFVPfBI=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0517.namprd15.prod.outlook.com (10.163.110.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Mon, 22 Oct 2018 23:44:33 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1250.028; Mon, 22 Oct 2018
 23:44:33 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Spock <dairinin@gmail.com>
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
Thread-Index: AQHUaeHkHk+DbEcbikCQiNZLx8ZaF6Ur7pMA
Date:   Mon, 22 Oct 2018 23:44:33 +0000
Message-ID: <20181022234425.GA18716@tower.DHCP.thefacebook.com>
References: <CADa=ObrwYaoNFn0x06mvv5W1F9oVccT5qjGM8qFBGNPoNuMUNw@mail.gmail.com>
 <20181022083322.GE32333@dhcp22.suse.cz>
In-Reply-To: <20181022083322.GE32333@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:300:d4::16) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:b4d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0517;20:cPPSSpTyHJw9+v/cXTxgabmAdv5/wcJW2a9O+5ILPuYhA0mUMxeIvcWkIQaHo9sOtuIEeOgLh4Mao6W65u9e7b88Ufk84IxSi6bi215Gug6f40AhS+XEKk/6INtBCi38xM+kvq1fo0dGO2j10jNn0DDbNez9J5+UdGL8Oi6PlFc=
x-ms-office365-filtering-correlation-id: 3a4a2af8-5cb2-4dea-e77d-08d6387850fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0517;
x-ms-traffictypediagnostic: BY2PR15MB0517:
x-microsoft-antispam-prvs: <BY2PR15MB05177FE5669181F0EC36D4F2BEF40@BY2PR15MB0517.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0517;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0517;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(2900100001)(5660300001)(1076002)(71200400001)(316002)(7416002)(71190400001)(6916009)(33896004)(305945005)(7736002)(105586002)(76176011)(386003)(6506007)(486006)(106356001)(81156014)(11346002)(9686003)(4326008)(99286004)(39060400002)(476003)(1411001)(33656002)(229853002)(446003)(25786009)(52116002)(8676002)(6512007)(478600001)(14444005)(256004)(97736004)(46003)(6246003)(2906002)(6116002)(54906003)(5250100002)(81166006)(102836004)(14454004)(6486002)(68736007)(53936002)(6436002)(86362001)(8936002)(186003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0517;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t6U1hQw61ubzWXCEbxTNAg9fS0H9pJ+eHzWAXihN2WczAoWbC+bnOK8zuQi5GLKVTNPCcbAjB/bloeCJCm41GbFz+elE4uK8m5Q0tLSqCD1aLag1TTlcJiNiGzuy7YVNggDV+oBpX2pcXgeyDuSvBt3c3EeoJssDXEU0qqxDhuQMcnxEmPHieSlAwgYAPbyaojfWzZZ/StrNvenWY6Zi/3gPisATvgYsrBJS6wvlYTSVrGL+XwgeUQd9EFNTSPQS6LuxTSkZVgVRSM+osx9VTRcDbm9l4Y8bpbO1yiCW9BQW1qpivjCCkaiEqia8LOClJw38BnhiTtWbhCpOkPEWNOmz8AOL7MxJ3WXqn+NwUYM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84C62170042B2E42977CC9963F954C9C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4a2af8-5cb2-4dea-e77d-08d6387850fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 23:44:33.2230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0517
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-22_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat 20-10-18 14:41:40, Spock wrote:
> > Hello,
> >=20
> > I have a workload, which creates lots of cache pages. Before 4.18.15,
> > the behavior was very stable: pagecache is constantly growing until it
> > consumes all the free memory, and then kswapd is balancing it around
> > low watermark. After 4.18.15, once in a while khugepaged is waking up
> > and reclaims almost all the pages from pagecache, so there is always
> > around 2G of 8G unused. THP is enabled only for madvise case and are
> > not used.

Spock, can you, please, check if the following patch solves the problem
for you?

Thank you!

--

diff --git a/fs/inode.c b/fs/inode.c
index 73432e64f874..63aca301a8bc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -731,7 +731,7 @@ static enum lru_status inode_lru_isolate(struct list_he=
ad *item,
        }
=20
        /* recently referenced inodes get one more pass */
-       if (inode->i_state & I_REFERENCED) {
+       if (inode->i_state & I_REFERENCED || inode->i_data.nrpages > 1) {
                inode->i_state &=3D ~I_REFERENCED;
                spin_unlock(&inode->i_lock);
                return LRU_ROTATE;

