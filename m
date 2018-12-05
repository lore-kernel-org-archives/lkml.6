Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA33C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E3D20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="P/mCLywR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="O6D9+YG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E3D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeLEXLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:11:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33716 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727701AbeLEXLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:11:32 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB5N8JhA006753;
        Wed, 5 Dec 2018 15:11:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xW338xFIWv3rctLYMKsXLbOhM8rQIc4bS3a41yyw4Uc=;
 b=P/mCLywRS26ntsjjSWX0eLU1WMNAnbqIJ2wyg4iRR6GRsx9irQw835cGjpAJkhIObAHm
 oPpGv03iNbrfgeD9fgWxgh5BXCG2G98eTfk7F/+UaZtsnQ3z4kANKoBNJRLbtF436COZ
 RAWBWfiPo9NzH2wUud+Q0G0tKH3UeF60I2g= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p6pwcg81x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Dec 2018 15:11:20 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 5 Dec 2018 15:11:18 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 5 Dec 2018 15:11:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW338xFIWv3rctLYMKsXLbOhM8rQIc4bS3a41yyw4Uc=;
 b=O6D9+YG2cMQx1FA/mr8hfvbMFxzoRL82beunqYw82g1MEWZWL/91F9ASnu9HXU6ZfIbQqKvcGoTNY7ibDAoivj/QPuyinr4usZV+Sb+FAa/TweziSgQipVrtjxH7RHt8u21hcrrIlTci7cSY/3ijwAXp5PPYvAHTvOKqCjePJjk=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2424.namprd15.prod.outlook.com (52.135.198.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.18; Wed, 5 Dec 2018 23:11:16 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5%3]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 23:11:16 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] mm/memcg: Fix min/low usage in
 propagate_protected_usage()
Thread-Topic: [PATCH 1/3] mm/memcg: Fix min/low usage in
 propagate_protected_usage()
Thread-Index: AQHUit5xdIPpMr8W9kuwgrfCUim4T6VsyDQAgAMTc4CAAO48AA==
Date:   Wed, 5 Dec 2018 23:11:16 +0000
Message-ID: <20181205231110.GA11330@castle.DHCP.thefacebook.com>
References: <20181203080119.18989-1-xlpang@linux.alibaba.com>
 <20181203180008.GB31090@castle.DHCP.thefacebook.com>
 <03652447-d9ba-45ea-3365-46a4caf96748@linux.alibaba.com>
In-Reply-To: <03652447-d9ba-45ea-3365-46a4caf96748@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:907:1::20) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:75b9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2424;20:IMRg6T7A89lgFYsugtcDQRH6Idw6N4FH7RcgW2oHiowgDa0zDzLO5kjTfS1Hj9W9plNREhsKzq7JsZNy9d5kk6D4ccBmY6l3TBZk/j1SsxL1q2hlQtPTjSlpWorwgyqC35H9xALP6cmiJ4HSXSeY8/QrRpMN3aXSypXFMhMBzjQ=
x-ms-office365-filtering-correlation-id: 3c5f8883-cacf-4538-9a34-08d65b06f4f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2424;
x-ms-traffictypediagnostic: BYAPR15MB2424:
x-microsoft-antispam-prvs: <BYAPR15MB2424903EA4F17070EAF24877BEA80@BYAPR15MB2424.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231455)(999002)(11241501185)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2424;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2424;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(136003)(366004)(199004)(189003)(186003)(105586002)(6486002)(256004)(106356001)(81156014)(6916009)(1076002)(4326008)(81166006)(14454004)(86362001)(8676002)(229853002)(68736007)(6116002)(46003)(9686003)(99286004)(305945005)(7736002)(6512007)(71190400001)(316002)(25786009)(102836004)(97736004)(446003)(486006)(71200400001)(5660300001)(52116002)(2906002)(478600001)(476003)(6246003)(6506007)(53936002)(33896004)(33656002)(8936002)(76176011)(11346002)(6436002)(54906003)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2424;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jlLgQOg/UV3KrgXx4Cqsd5Op7Le6+5hvCah6WLZRv3WcpriuYUBJvPowAxryboD/UBMpqo+izl1ntvg3p8eD+9fdxIO6zgUPIBJWXM7p9t8tEPFxp1D8WX2ZZe5JJeLumVYBgov6IpeNSG1Vrcp97F2FcX7bwJ+LYuTaAEr4LCca3OkAvaSmY4J7EKUNUxyqtB5ym60uH+fKSm+RR7e12i9rCkFVhzim1mlA6aKDY3X4bPz3rT8g+FrwvP6IxqD722Mb/vltTeJcTzAxxYlHfnGSqnZ6bmsfawxahteeq3cp6XipBRmHKIqiZ8Gp+guNnULxzH7aSsq8QXR0ICsKrC614BKa6IpfHhEKVdn5AeE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E662CE51E0E9F542824D65D18AFDE335@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5f8883-cacf-4538-9a34-08d65b06f4f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 23:11:16.0325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2424
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:58:31PM +0800, Xunlei Pang wrote:
> Hi Roman,
>=20
> On 2018/12/4 AM 2:00, Roman Gushchin wrote:
> > On Mon, Dec 03, 2018 at 04:01:17PM +0800, Xunlei Pang wrote:
> >> When usage exceeds min, min usage should be min other than 0.
> >> Apply the same for low.
> >>
> >> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> >> ---
> >>  mm/page_counter.c | 12 ++----------
> >>  1 file changed, 2 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/mm/page_counter.c b/mm/page_counter.c
> >> index de31470655f6..75d53f15f040 100644
> >> --- a/mm/page_counter.c
> >> +++ b/mm/page_counter.c
> >> @@ -23,11 +23,7 @@ static void propagate_protected_usage(struct page_c=
ounter *c,
> >>  		return;
> >> =20
> >>  	if (c->min || atomic_long_read(&c->min_usage)) {
> >> -		if (usage <=3D c->min)
> >> -			protected =3D usage;
> >> -		else
> >> -			protected =3D 0;
> >> -
> >> +		protected =3D min(usage, c->min);
> >=20
> > This change makes sense in the combination with the patch 3, but not as=
 a
> > standlone "fix". It's not a bug, it's a required thing unless you start=
 scanning
> > proportionally to memory.low/min excess.
> >=20
> > Please, reflect this in the commit message. Or, even better, merge it i=
nto
> > the patch 3.
>=20
> The more I looked the more I think it's a bug, but anyway I'm fine with
> merging it into patch 3 :-)

It's not. I've explained it back to the time when we've been discussing tha=
t
patch. TL;DR because the decision to scan or to skip is binary now, to
prioritize one cgroup over other it's necessary to do this trick. Otherwise
both cgroups can have their usages above effective memory protections, and
will be scanned with the same pace.

If you have any doubts, you can try to run memcg kselftests with and withou=
t
this change, you'll see the difference.

Thanks!
