Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2786C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 02:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C5520672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 02:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kIqP++H3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iRsEuIjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C5520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLICG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 21:06:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34836 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbeLICG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 21:06:56 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB924hKR027065;
        Sat, 8 Dec 2018 18:06:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Uyegx4Qgcz++BAGzwoC9UZcNmWhucVWXPeIBEE50sig=;
 b=kIqP++H3Stt20CRAIRICQxjCYhRyjlPiBta1RUgYWLtDawDnyYTuRXgSPq9xFPoBYUxK
 o548BzNsYfSaw4Al3kFg2Qtw4yS4mR4OqQWVX9oUkDyq0w4OWEeWc0tHzNESpsifDNyW
 Rqx1htR4RnwhTWkRZIxXl6MPJHUNZAcYrkU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p8nh20e92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 08 Dec 2018 18:06:33 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Sat, 8 Dec 2018 18:06:33 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Sat, 8 Dec 2018 18:06:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uyegx4Qgcz++BAGzwoC9UZcNmWhucVWXPeIBEE50sig=;
 b=iRsEuIjcwjZpGgGGyyrjs5XDyzxhuaRF8PaTeVHpOlNNxv9cxmYCEji8vp5s76ulH/35Z82O57yBPbwknFULvlDFDtb/RQJwFVFdlyrOWkfIGnYWcL6zXyg6UMg24c4aWXrlBqiUY1GwFlHShn1iJwNBBY3VfkhieW6xydgafTc=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1757.namprd15.prod.outlook.com (10.174.255.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Sun, 9 Dec 2018 02:06:14 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::9d20:17f:ac07:601]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::9d20:17f:ac07:601%5]) with mapi id 15.20.1404.025; Sun, 9 Dec 2018
 02:06:14 +0000
From:   Martin Lau <kafai@fb.com>
To:     Roman Gushchin <guroan@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/3] bpf: pass struct btf pointer to the
 map_check_btf() callback
Thread-Topic: [PATCH bpf-next 1/3] bpf: pass struct btf pointer to the
 map_check_btf() callback
Thread-Index: AQHUjpB+RGQGVYinmE6Av5uq2zwZ/qV1qmMA
Date:   Sun, 9 Dec 2018 02:06:14 +0000
Message-ID: <20181209020612.raa636zl3x4sola2@kafai-mbp.dhcp.thefacebook.com>
References: <20181208005315.3500-1-guro@fb.com>
In-Reply-To: <20181208005315.3500-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:907:1::34) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:352d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1757;20:xwwfJ2ay+a09Rlr0P+vcB/oqUYCTjcGrfD1hcBNB7Pq9/a5cWMyS0j2XGXacC2VtF+LYHFUTEqv9Ny+TY3bxDLUWx4M3ny0EvQFCUUye80oS6fuNOBYORAiXi+/awBO8Qya0OOYj/JGvTtsmDxkBplVi3Q+juO5882n4MJDt09M=
x-ms-office365-filtering-correlation-id: 84affc7c-9dff-480c-ee07-08d65d7ae59a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1757;
x-ms-traffictypediagnostic: MWHPR15MB1757:
x-microsoft-antispam-prvs: <MWHPR15MB1757E10C4CA26FCA0DC654F5D5A40@MWHPR15MB1757.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(93006095)(93001095)(3231455)(999002)(11241501185)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1757;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1757;
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(9686003)(1076002)(6512007)(256004)(6246003)(446003)(5660300001)(11346002)(486006)(99286004)(97736004)(6486002)(316002)(54906003)(6916009)(14454004)(71190400001)(229853002)(71200400001)(6436002)(86362001)(81156014)(8676002)(81166006)(478600001)(2906002)(1411001)(25786009)(39060400002)(4326008)(46003)(7736002)(186003)(68736007)(476003)(105586002)(102836004)(53936002)(305945005)(6506007)(386003)(6116002)(76176011)(8936002)(52116002)(33896004)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1757;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CYbhik1SP/YK7/4PC6Rj6IQaUFJCg+5DkuMJbSnro7e4esaT4kfURwQEOLZEQY47UAEWnWtIQdMcyNSjbsCm+HrlHta+tfDV3xJE8MJ2crWkXEQO+PiDLZmaEmewdcTN+UDIbXdfkq0Mk3x3f2w/0FnqO9szYWneLMDeYoK0VGjFaYDj6EWLgyJTUs4nruqJF7l1tFlLpYL7kOP+wPPMOnB6lyRa5FyrF4mJbf3uaglGQYbFlDvrKFMCMz60dTv6/p330bxoqW1JYiPPrP77yAYk+C7J5HRyFFqUBB8Hr10ww8VgyrT8HpY8AcCcOBGFr875H40zIvrq1JyUq7tvJf4mfZ4GyNLfO15HGsMngcA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <283973066151E34791BD15A1D155FC03@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 84affc7c-9dff-480c-ee07-08d65d7ae59a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 02:06:14.3706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1757
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-08_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 04:53:13PM -0800, Roman Gushchin wrote:
> If key_type or value_type are of non-trivial data types
> (e.g. structure or typedef), it's not possible to check them without
> the additional information, which can't be obtained without a pointer
> to the btf structure.
>=20
> So, let's pass btf pointer to the map_check_btf() callbacks.
Acked-by: Martin KaFai Lau <kafai@fb.com>
