Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1D6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133E62081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NXeryYgf";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="f0Op8P/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133E62081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeK2Ejd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:39:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36558 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727867AbeK2Ejd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:39:33 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASHaj2M007888;
        Wed, 28 Nov 2018 09:37:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OCGIgRcpxduPNPXad1ZkrGVGa7pcF5jdEdemT6YgYeM=;
 b=NXeryYgftpXETazZz3U4/MweNGRj1sf5NoMYkOuhQVAJvFD1PsLyxj5mdSojgkH/HJdl
 PWvgFOJyNDJkA7ot63U4EI2TcsrjkzcQqPKWcdXYYkrmnaxQfdE5bpQX+2pf8ls0LDes
 uYe9wYL83OYgpOaIfwr9+Zqh7aTqBryI4z8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p1x8srayd-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 28 Nov 2018 09:37:05 -0800
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 28 Nov 2018 09:36:33 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 28 Nov 2018 09:36:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCGIgRcpxduPNPXad1ZkrGVGa7pcF5jdEdemT6YgYeM=;
 b=f0Op8P/OhT03Dkhqm0ZOhUDnvOZdPJsV6aJK7Y2OBCRhrCLE+5Mkh7kLUHGf5L0z68piaCto3OAsWQA53ieptf93rrsmxaKv2rABpmXW4XJQggTx4RwLcd2v0PYPxItGAjnRPU87tkgaSo/EjmCGTmhkdUdAZgUAWsnzEqgp1nY=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0774.namprd15.prod.outlook.com (10.164.171.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 17:36:29 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::1d40:c1ed:72a7:38a6%4]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 17:36:29 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Thread-Index: AQHUetwXxFde3wHnZUKDpNhUsGNNTqVN2ueA///hhYCAAcPYAIAWC8cA
Date:   Wed, 28 Nov 2018 17:36:28 +0000
Message-ID: <20181128173622.GA22882@tower.DHCP.thefacebook.com>
References: <20181112230422.5911-1-guro@fb.com>
 <20181112230422.5911-5-guro@fb.com> <20181113154825.GC30990@redhat.com>
 <20181113215919.GC15590@tower.DHCP.thefacebook.com>
 <20181114165631.GE13885@redhat.com>
In-Reply-To: <20181114165631.GE13885@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:104:4::29) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:f365]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0774;20:faXQg+h8YzgjQZ6YoMPBfq78eb5WzwyVvt5uWcDbJEu7CT1I6N0HgIdg6srCdJRKJX0aPMEt82aa3a/uGK7nBbz1zNCWhQ5NVKB0S6jdOqozfacqWoC1pk+zL/6u+PiTXJCEGOPyGKIPoTxjUyqUF6E2ykn9m/OgIOXssRvhlsQ=
x-ms-office365-filtering-correlation-id: ad6db05c-fb6c-4151-f1a8-08d65558073a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0774;
x-ms-traffictypediagnostic: BY2PR15MB0774:
x-microsoft-antispam-prvs: <BY2PR15MB0774BA20E54BEADE319DD164BED10@BY2PR15MB0774.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3002001)(3231443)(999002)(11241501185)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0774;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0774;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(376002)(346002)(396003)(52314003)(199004)(189003)(6116002)(2906002)(68736007)(81166006)(81156014)(256004)(305945005)(229853002)(8936002)(8676002)(1076002)(25786009)(478600001)(86362001)(105586002)(71190400001)(71200400001)(106356001)(966005)(6436002)(14454004)(186003)(5660300001)(6486002)(486006)(446003)(54906003)(476003)(99286004)(11346002)(9686003)(6512007)(4326008)(39060400002)(33656002)(102836004)(6506007)(386003)(93886005)(76176011)(53936002)(6916009)(6306002)(7736002)(52116002)(33896004)(316002)(97736004)(46003)(6246003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0774;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0WLaArBbT2bxePyecwf2UfVypciRBxTutjiIRUh+ubxaPLs/r2osLovFUKUUjiZCj6eXtTttiJbtizuhOFMXS20smm9kPrtDOLZru7NqAwlPr70YSaFjnbilmc0QvN+1gkF1b9v/ea9G7ZblD08VEjAskD5SwSfAxZjgCqHHlvl63ou+lY6CnD1F8VCIrjpS84oJKgGNWXHrZ2fay4tCQrDSq/8YhJn37+vuk1GpyqVIU8QSSJEnxhPzKZOAi3KjzNzq5V74Pj+1PnSZw6gOOigI1wsERZ70SOjzTpXuij8kF4ZGavJXZ3QyEDa7Sgch07gurmua8O2skxBBjLnSwqMT8RH1Weq7vVQC+ZDZSpc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <622259CAEDB0B143B8C259C3B9CAC130@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6db05c-fb6c-4151-f1a8-08d65558073a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 17:36:28.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0774
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 05:56:32PM +0100, Oleg Nesterov wrote:
> Hi Roman,
>=20
> OK, it seems you are going to make the new version anyway, so I can wait =
for it
> and not read this series ;)

Hi Oleg!

Can you, please, take a look at v3, which I posted recently?
https://lkml.org/lkml/2018/11/17/193

Thank you!
