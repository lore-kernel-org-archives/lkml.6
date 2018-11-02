Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB11DC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470DF2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EWhPeaa3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eTMEV4kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470DF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeKBKEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 06:04:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47368 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbeKBKEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 06:04:20 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA20vV4o027607;
        Thu, 1 Nov 2018 17:58:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xNpyJOwnWFitAiUnMelmtZvgWXIgqza71kQPJEGnONE=;
 b=EWhPeaa3leRbU4WTA05XIyO61CJq6+3eAa7Wt+Zh5SD8pYGHbhUBuiWx1Snu+R2EdxKB
 8fa/EFZt98oUDUO2/2qrB1aeBOCP/A73Ceym8nIah7dJ+AErCnrbo3Q5xtdu5XHl4K5y
 V6FLvGnn2BMzEQ71OEl4VNvOTjqs2rAiAS4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ngb5ggbdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 01 Nov 2018 17:58:31 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 1 Nov 2018 17:58:30 -0700
Received: from PRN-CHUB01.TheFacebook.com (2620:10d:c081:35::10) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Thu, 1 Nov 2018 17:58:30 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.11) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 1 Nov 2018 17:58:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNpyJOwnWFitAiUnMelmtZvgWXIgqza71kQPJEGnONE=;
 b=eTMEV4kvxo8rHF3VeId0qfrI9Hpvu4IFl9vYXHPX1EWZuxHwxJD6GQFdmh7fTKg8QH49CvpWFDGVNEY3rcbGYcnY/hbv+Z5avlhE0RPbBdlI7tM0sNnWJhjURY6vNdi8snlF/THbxwZZ0BogZl5yRacWTLKGjDyvkEOuNq5p8ME=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0520.namprd15.prod.outlook.com (10.163.110.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Fri, 2 Nov 2018 00:58:24 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1273.027; Fri, 2 Nov 2018
 00:58:23 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Dexuan Cui <decui@microsoft.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Topic: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Index: AdRyQEG5VIfdELkdR3eQ5BGm0rZVcwABuNOA
Date:   Fri, 2 Nov 2018 00:58:23 +0000
Message-ID: <20181102005816.GA10297@tower.DHCP.thefacebook.com>
References: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0071.namprd22.prod.outlook.com
 (2603:10b6:300:12a::33) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:b8f1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0520;20:SBzVwlPCMCxU5RoYKaLqI+SSM0WiFZFWtKZMvoM7qvDFSUiZsJDI4ni4WbOfdVL3FntS9JMIlPqRoygRy5qmkvG83qmlwn1C9EQ1jaMWVah0UrxqQO0LkeGLzrBT4tbtycnoqs3cjxUvqKkUzhf9Kqtu3vxutKOsD0Sd2H5Io1U=
x-ms-office365-filtering-correlation-id: 20525b32-ddca-42be-1fdd-08d6405e49f8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0520;
x-ms-traffictypediagnostic: BY2PR15MB0520:
x-microsoft-antispam-prvs: <BY2PR15MB0520CDC59C5BCF3BB48CEDC0BECF0@BY2PR15MB0520.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(10436049006162)(24339691489775)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3231382)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0520;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0520;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(53754006)(199004)(86362001)(5660300001)(6306002)(575784001)(8936002)(81166006)(7416002)(99286004)(1511001)(76176011)(52116002)(102836004)(386003)(97736004)(6506007)(33896004)(4326008)(478600001)(6246003)(81156014)(6512007)(8676002)(6436002)(2906002)(7736002)(68736007)(229853002)(9686003)(305945005)(53936002)(6916009)(2900100001)(6486002)(6116002)(966005)(71190400001)(71200400001)(1076002)(14454004)(25786009)(486006)(446003)(11346002)(46003)(33656002)(105586002)(39060400002)(316002)(256004)(186003)(106356001)(5024004)(54906003)(476003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0520;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qGxgbGQJWzLHEKGFmExunO5qQMSKtfLkjyycAtttL0Sw9yztUbVMCJhMLbrjcSNAZmRsyoAV1ZxTaAXEwSk1XslUZkwEwiPyfdwD91SbAPsch70Q6N5RAYl8s8LucOQ0P8AZOBJmuMAEcEeXE/gwYfJgQTZC4f4lZ0LjkP/E7hzbZ9VOr+mg9T3aLF1mtSddk58FY4YXNQbDMTQsGIQ9DjXDcwXkhnzo/vGNXkdSDy2KrV8/XN7xXxseRhZ/pDNMkIqr5hdpP/kTrhLzLcVCLaCJ3rV06mCA+FwXRW2a8o8fod1WhyfTVs9lzySjVElUeRwT53VcQZ6nFaLXXqswtbw0upr+mzRxQZuFkgrBs58=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7847F6CBC0D60A4B9006A68198DF7FBF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 20525b32-ddca-42be-1fdd-08d6405e49f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 00:58:23.8401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0520
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-01_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 12:16:02AM +0000, Dexuan Cui wrote:
> Hi all,
> When debugging a memory leak issue (https://github.com/coreos/bugs/issues=
/2516)
> with v4.14.11-coreos, we noticed the same issue may have been fixed recen=
tly by
> Roman in the latest mainline (i.e. Linus's master branch) according to co=
mment #7 of=20
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugs.launchpad.net=
_ubuntu_-2Bsource_linux_-2Bbug_1792349&d=3DDwIFAg&c=3D5VD0RTtNlTh3ycd41b3MU=
w&r=3Di6WobKxbeG3slzHSIOxTVtYIJw7qjCE6S0spDTKL-J4&m=3DmrT9jcrhFvVxDpVBlxihJ=
g6S6U91rlevOJby7y1YynE&s=3D1eHLVA-oQGqMd2ujRPU8kZMbkShOuIDD5CUgpM1IzGI&e=3D=
, which lists these
> patches (I'm not sure if the 5-patch list is complete):
>=20
> 010cb21d4ede math64: prevent double calculation of DIV64_U64_ROUND_UP() a=
rguments
> f77d7a05670d mm: don't miss the last page because of round-off error
> d18bf0af683e mm: drain memcg stocks on css offlining
> 71cd51b2e1ca mm: rework memcg kernel stack accounting
> f3a2fccbce15 mm: slowly shrink slabs with a relatively small number of ob=
jects
>=20
> Obviously at least some of the fixes are also needed in the longterm kern=
els like v4.14.y,
> but none of the 5 patches has the "Cc: stable@vger.kernel.org" tag? I'm w=
ondering if
> these patches will be backported to the longterm kernels. BTW, the patche=
s are not
> in v4.19, but I suppose they will be in v4.19.1-rc1?

Hello, Dexuan!

A couple of issues has been revealed recently, here are fixes
(hashes are from the next tree):

5f4b04528b5f mm: don't reclaim inodes with many attached pages
5a03b371ad6a mm: handle no memcg case in memcg_kmem_charge() properly

These two patches should be added to the serie.

Re stable backporting, I'd really wait for some time. Memory reclaim is a
quite complex and fragile area, so even if patches are correct by themselve=
s,
they can easily cause a regression by revealing some other issues (as it wa=
s
with the inode reclaim case).

Thanks!
