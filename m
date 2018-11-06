Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2BFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B9D2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZlAX2n09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B9D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbeKGI3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:29:24 -0500
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:51024
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbeKGI3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 03:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bimkG7jzonADMUN2c8Asm5ZjypJEtunNUMLANpDqgcE=;
 b=ZlAX2n09ur4ZWzMve5ttxVNYtotskf5Dc0HTadMUjzvn3LgnxjnVEs+kCOj7PzXdVggcjDsyHhllEUlEPDDB+XDdzi1lH9XaTu1In4s9D9CV1Kbpi28yondYuw1kIIiDx5WnyGlQMjE4l5bzwQ8nqr0NK4O+yT7zmRXp1FtVtI0=
Received: from DM5PR21MB0185.namprd21.prod.outlook.com (10.173.173.136) by
 DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.8; Tue, 6 Nov 2018 23:01:48 +0000
Received: from DM5PR21MB0185.namprd21.prod.outlook.com
 ([fe80::85ba:98bc:9456:eebf]) by DM5PR21MB0185.namprd21.prod.outlook.com
 ([fe80::85ba:98bc:9456:eebf%3]) with mapi id 15.20.1339.009; Tue, 6 Nov 2018
 23:01:48 +0000
From:   Long Li <longli@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v4] genirq/matrix: Choose CPU for managed IRQs based on
 how many of them are allocated
Thread-Topic: [Patch v4] genirq/matrix: Choose CPU for managed IRQs based on
 how many of them are allocated
Thread-Index: AQHUdYVaTkJajO3NtEyTnG6H/NkfZKVDXb4AgAAAYHA=
Date:   Tue, 6 Nov 2018 23:01:48 +0000
Message-ID: <DM5PR21MB018511C3ABE491AFC768D3E4CECB0@DM5PR21MB0185.namprd21.prod.outlook.com>
References: <20181106040000.27316-1-longli@linuxonhyperv.com>
 <alpine.DEB.2.21.1811062357200.1635@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811062357200.1635@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:7:ede6:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0780;6:e4TDM0XQCQEo/ax108AVnJSjQl4I/mB9CxAlM0kosToo1NqdtS8zt5BKyqTGIdeQ2RbQt0V5dABngELmuERFXucZWBMFB93L7/OMHjN5pb3NRg5765JznTR7r7n1zixHEZTWFStIBo4w4l7P49+2A58ZrFUzg0bR0jY86ovYOrlQe5aNhpMnIGqb5Eji5VGcSGeS2W/Mn/ZynnRk7ea7L3TbgkZbJRcRNRd1x4kS0kBVBvXBPZj3KLjXatzZHVoBTdsIljiYIlZlImvuMVniLqB2RwcbIIfjBMQBBVSJ0Lye1vP3Gah+I47eAOAG4Fp4uI2pWgQzF7cRC84rwt4VBv3LBJq1CCtq4MCil9Az2P+EuVIeEJMFVxIIKE6tXt4GPjr1Y36aY3OkfZFYOOdvRvrtUxbWLMz89bFhT0LL+7Zdi+rG8iRSDDNZf0H5WE+utOFzhAcC/2cIKAOCPmbohQ==;5:oTt54BuuP8cLott+KrIlebr4E0AgXZYL4QO1BBNaCU0bhY0p5D/3LQg7pynLyPyUxD9WeGASTCckHzIB/rEKEjtOHTT4HcHNi0Rcqvq6zWaaDIhFB0oXGrVRskmjydO7wigqK2+bx/yI582kZsXWI5+g8w6UqA9ZLDWS04NsUM0=;7:vVGB7YccrYB/OKeQyXYpD2z46Mgndq2ayYcOWlfdJVA5NENFPd6bL81BqincgW4QiB7aFtNpvaG0dYr3DacmFbngKj43m1jtSGu+tYqHbrEV3EeHEoioaXheNkuok9+XDlyx2kca0b4f1Uzc72NlXA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: df3b5dda-810e-4fde-f5f1-08d6443bd4e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0780;
x-ms-traffictypediagnostic: DM5PR21MB0780:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0780835669E620E8C5724637CECB0@DM5PR21MB0780.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231382)(944501410)(52105095)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR21MB0780;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0780;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(376002)(346002)(54534003)(199004)(189003)(46003)(4326008)(486006)(6246003)(53936002)(446003)(476003)(11346002)(186003)(6436002)(8990500004)(102836004)(6506007)(74316002)(256004)(229853002)(10090500001)(76176011)(7696005)(6116002)(99286004)(7736002)(14454004)(8936002)(25786009)(106356001)(8676002)(81166006)(97736004)(81156014)(105586002)(305945005)(478600001)(86362001)(2900100001)(71190400001)(6916009)(68736007)(10290500003)(22452003)(55016002)(71200400001)(9686003)(86612001)(316002)(33656002)(2906002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0780;H:DM5PR21MB0185.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6eVrtDiHDXKr+cqU33fEVuEVInyJ0jRttSilD8QzhT0uSOVXMAG+/iCUhwyRMhllM0aQzf2ZiRs7q0YZ7UVfbTsIE6+NQ8uDIx6kf3xD/TjNJu1A6ExY1FADM7MsGHZ857YUasldypHsNKXkL2GAdsWf3k3ZCdGzrmv8DrV2VVJ6RmkWwS9Dh79iPab6EvxevVE3egvolMR6kZfLwUK3Uv76Qpa7kuVKUi0nd54MYKoPVGOh5V74UDw6b7F1qL/BBMDK3tVWK23BogMY0Utzi7YkormrMVwHVCBEAbzvSx7n0N4KzjnMfCIvtOzSCAyDzEY/tFUSUeYcsTZuuYikUyDm432x291NU7Uo5X8SE+s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3b5dda-810e-4fde-f5f1-08d6443bd4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 23:01:48.2809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [Patch v4] genirq/matrix: Choose CPU for managed IRQs based
> on how many of them are allocated
>=20
> Long,
>=20
> On Tue, 6 Nov 2018, Long Li wrote:
>=20
> > From: Long Li <longli@microsoft.com>
> >
> > On a large system with multiple devices of the same class (e.g. NVMe
> > disks, using managed IRQs), the kernel tends to concentrate their IRQs
> > on several CPUs.
>=20
> Thanks for addressing the comments. Well done.
>=20
> I've merged it, but took the liberty to rework the changelog so all the
> background information which we exchanged over the various iterations is
> preserved there.

Thank you!

Long

>=20
> Thanks,
>=20
> 	tglx
