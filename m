Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA09DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569A32082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KfS6EN5t";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JK0x93wM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569A32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeKCA5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:57:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53756 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbeKCA5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:57:06 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2Fiqpr011379;
        Fri, 2 Nov 2018 08:49:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Abqyz8TYBhSKWQPk+m9vAPiU0b3WyLjmVRr4RYPub9c=;
 b=KfS6EN5t83FEXg1nmT3s9QjvqolNAsQi+cin5MWZHoG3UnKvdd/FdO7PW+dqqB3eXqOF
 TO+4g5uenfV9nfmYxSAWpq/IbnZLXUwGN9WcVq7iW98lkCUG28dV1CLQHpWnmIx/RtKW
 AoMgFJziEjorhOfuZBZmvsPAjstQsIVtlGY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ngr34g8u4-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 02 Nov 2018 08:49:09 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 2 Nov 2018 08:49:05 -0700
Received: from PRN-CHUB09.TheFacebook.com (2620:10d:c081:35::18) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 2 Nov 2018 08:49:05 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 2 Nov 2018 08:49:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abqyz8TYBhSKWQPk+m9vAPiU0b3WyLjmVRr4RYPub9c=;
 b=JK0x93wMim2+ZqRNqdC2oTYJrdj6DDI9hdgavAzx7/x9kDYmKi9DiwHphDS1QlT2KrH1U+ax5LpsYynYMbc7W5StLSUY+xLZ+uK1RdOcrf05TNi/Q2MTZDleuLrSQqJulMxbePN5HqwrsiRu5VnEfU63G4yxrOz6QVoDLN0ob8A=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0869.namprd15.prod.outlook.com (10.164.171.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Fri, 2 Nov 2018 15:48:57 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1273.030; Fri, 2 Nov 2018
 15:48:57 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Dexuan Cui <decui@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Topic: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Index: AdRyQEG5VIfdELkdR3eQ5BGm0rZVc///mGwAgACTWwCAAFjogIAAgeKA
Date:   Fri, 2 Nov 2018 15:48:57 +0000
Message-ID: <20181102154844.GA17619@tower.DHCP.thefacebook.com>
References: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102005816.GA10297@tower.DHCP.thefacebook.com>
 <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102073009.GP23921@dhcp22.suse.cz>
In-Reply-To: <20181102073009.GP23921@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:301:5f::35) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:b8f1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0869;20:vdABMMlztapes6ik1KpLgJqR17yrl4CDcpG+hkR0ARuqtbNmfgGJMCuwDzr+1AkQOqG2GfrWd7eGZ5+sfAK9Osl8VPmEFhDK0Pp41NtBmL467z+7b7YCKe+pCZC1S4uOePJTQBmE/ayDQWBe6iXep1AFH+FMkojaNIineC41r4M=
x-ms-office365-filtering-correlation-id: 79fbc19f-9790-496c-fd02-08d640dab01b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0869;
x-ms-traffictypediagnostic: BY2PR15MB0869:
x-microsoft-antispam-prvs: <BY2PR15MB0869C475A68CB945F0FB7213BECF0@BY2PR15MB0869.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3002001)(93006095)(93001095)(3231382)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0869;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0869;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39860400002)(376002)(396003)(189003)(199004)(33896004)(11346002)(476003)(446003)(81166006)(81156014)(2906002)(53936002)(106356001)(7416002)(105586002)(5660300001)(54906003)(14444005)(4326008)(7736002)(478600001)(14454004)(39060400002)(6116002)(256004)(2900100001)(486006)(25786009)(46003)(93886005)(1076002)(305945005)(71200400001)(86362001)(71190400001)(102836004)(186003)(6486002)(68736007)(229853002)(99286004)(33656002)(6246003)(97736004)(6436002)(9686003)(6916009)(8676002)(6506007)(386003)(8936002)(316002)(6512007)(76176011)(52116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0869;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ANnlzhUA5Lp59DZuC7/1g5JdCQeytTpxS4Z0C6scBoshELwmzUFB43Zeomni2XgOP/AXdheU0ZztIrtbkhpa+pBvyxL0zJb5kv95dGurY7QiK1daC1B65jRaFkRQ4Frm/MepMe1Pvr2cLRSi1UBJzVkHXFV7P8jrqx8fqZJNV3WUqjOLuEJaEcimwgijXxMQQZqRuGpNqSUZ++PES8CDefFeYCceZiat1PpmRJBD44vhAUg9216/WcPSspiVeIDuT+Lu4ESrZPnk8duV4o/OkuhbOnK1T8v1vmNILu4PlIxXHbAqrqoSKpP8CoSJWxnBC4o1tuhJ5nAKl62mDoNfQaPbCuNai409tS7rbYSjI2Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11F686430097414AA30A58213C8EB530@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fbc19f-9790-496c-fd02-08d640dab01b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 15:48:57.6706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0869
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 09:03:55AM +0100, Michal Hocko wrote:
> On Fri 02-11-18 02:45:42, Dexuan Cui wrote:
> [...]
> > I totally agree. I'm now just wondering if there is any temporary worka=
round,
> > even if that means we have to run the kernel with some features disable=
d or
> > with a suboptimal performance?
>=20
> One way would be to disable kmem accounting (cgroup.memory=3Dnokmem kerne=
l
> option). That would reduce the memory isolation because quite a lot of
> memory will not be accounted for but the primary source of in-flight and
> hard to reclaim memory will be gone.

In my experience disabling the kmem accounting doesn't really solve the iss=
ue
(without patches), but can lower the rate of the leak.

>=20
> Another workaround could be to use force_empty knob we have in v1 and
> use it when removing a cgroup. We do not have it in cgroup v2 though.
> The file hasn't been added to v2 because we didn't really have any
> proper usecase. Working around a bug doesn't sound like a _proper_
> usecase but I can imagine workloads that bring a lot of metadata objects
> that are not really interesting for later use so something like a
> targeted drop_caches...

This can help a bit too, but even using the system-wide drop_caches knob
unfortunately doesn't return all the memory back.

Thanks!
