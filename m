Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8249DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FFD2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WyQ84527"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbfAaQpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:45:39 -0500
Received: from mail-eopbgr750125.outbound.protection.outlook.com ([40.107.75.125]:19919
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728813AbfAaQpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEPKGNjgbkThNkeaxXpr/K5NjYkxrOAkZOhOv0rzRwg=;
 b=WyQ84527mxfCfjWwhm7GlpuHnJ42URy8FvASOLXOGIB7uBDcDWruUopiDX6e/fJ9pFYEBasQW0cfRcskJzIGSCISZR3dDBH/FPIR4fSsDKr09kKvvZzBq/ycylGZgISa0NwfNUVnB8jiQ7BGsjYnmHphHsXBsfKcJLYASG0j80E=
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com (52.132.132.163) by
 DM5PR2101MB1063.namprd21.prod.outlook.com (52.132.128.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.4; Thu, 31 Jan 2019 16:45:35 +0000
Received: from DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::15b:c868:d1bd:c781]) by DM5PR2101MB0918.namprd21.prod.outlook.com
 ([fe80::15b:c868:d1bd:c781%9]) with mapi id 15.20.1601.007; Thu, 31 Jan 2019
 16:45:35 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        kimbrownkd <kimbrownkd@gmail.com>
CC:     Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Thread-Index: AQHUsfdQr9slvBztV0itgZ+Z8timDaW6pkUAgAAxKgCAAMiIAIAJg9qAgAGHowCAAuF3AIAAFypQ
Date:   Thu, 31 Jan 2019 16:45:35 +0000
Message-ID: <DM5PR2101MB091847B2B68D7F9F2050CE45D7910@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190122064246.GA28613@ubu-Virtual-Machine>
 <PU1P153MB01696D28CDDC098307EBD5AFBF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190128195845.GA3723@ubu-Virtual-Machine>
 <PU1P153MB01699B96311157EA9DF515E6BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190131151958.GT3973@sasha-vm>
In-Reply-To: <20190131151958.GT3973@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-31T16:45:32.5707193Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fb886720-697f-49cc-8821-d3a52c84d815;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;6:LTcvlMw67CntkSWVODpGYzZPeOy0wlip9IZcZmAVLmmMKmcb2IgV1Nqa5Rq9HOljHpayzpAmYe5Tn+AMylTI/deNXYFBP+KvZG79QYS7G4uG1SoUEOAIRAeyVYUVee613wIn98Otjyf3mWUVnRhyRvj3bFUE0nbDGvFNlfUSVFi/vcnXdXXa8UdaoHLHqsMAdQZ7o8N9hoDgs8ABX3HaVfWRnvxKF2g7HJkqEAo2tGxbTh0QRzLRH7tHLnyyEyLuGf5RLelqBg261aZVt6kQRm6UiIONO1MdTL//2DypiQ5CPxn8Kipm2IEgHaopUloZ0ngUWPSQ1JdBAtKm01mhM+e4HercyHQDhvoyzP/xnLfwrJWwB6DQfUerppoNQy/IHWoPFQG83PhyNqywVi0xrf/QoZIf2LdJZzdHOC7vj1LZp/cZylbjcu2u89t3jQLhZD1q537kGKF3+OR0ZJBM/A==;5:fXtLT9oNXeyI0niXRQq1tlxhLBwGoVIpqhkQGRNpKtY6PXxAkcS/OKzanF/75WxlAr03brPEUAccPV6YWLtt+HEvrR6zrfRA/jtzK4vdy208l0K73ET+o7MBjF4rCjMwvILhthtMG0OPlJfG62pe4hkeLV8WdplHFNgip+ZeE+y3DDPbLjIL89WbNfQbn4t/Tehsggq+ASDhYw0gcH0wSg==;7:dV6uV3X4S9JdRF7dENDEM+6Da6Ez1wlYcjmLy28FicEzDwdoQaix9tkb8t4MrjMHk4RaOlR8aOQudMXDpyxe1Zn2EgSyAfJtyQXK2EIW3gvQn0ybkaiJysh6X2kpk33qlWhc7F1R8vkFT/FznqQGdA==
x-ms-office365-filtering-correlation-id: 36e55795-705f-4565-2da8-08d6879b85c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB10635D229D8CE0DB6E14BF7DD7910@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(3846002)(10090500001)(68736007)(8990500004)(186003)(86612001)(71200400001)(4744005)(76176011)(97736004)(71190400001)(6346003)(6506007)(256004)(14444005)(99286004)(26005)(86362001)(7696005)(6116002)(102836004)(7736002)(81156014)(53936002)(478600001)(2906002)(81166006)(66066001)(22452003)(1511001)(105586002)(10290500003)(4326008)(229853002)(33656002)(39060400002)(6246003)(305945005)(106356001)(316002)(486006)(446003)(11346002)(476003)(9686003)(14454004)(6436002)(74316002)(93886005)(25786009)(54906003)(8676002)(55016002)(8936002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB0918.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RDosqDiKNX62bwefjqlaaYjvTZ53VTcprN3e843+YnH261YpwiPndqFSmLq62AFVIx7iD1PMlOM03L4qgW8umDXcfDmV2qNCSM6JCzP7jhjjs1toLcvh9w+YO0NPLdHHILObK7pDPlZVHLDKi9KZ0Nq/ES6DDsnJAmm4MyLP5BaVX6AuVmZGz2nAgSiLJ5VeZFwIYBn61R32fWKZ6T2z7NXuwUQxuQgZDDiz1oZiZkdgkSc+lzQc/w9o0tMS4pigXNlQ0SgNS3A3zAfsHuE5fsL6GhRdU+BryAUeIGRQoz8UlbvD+u1dVHxzFIywVUo6W4caGbDjdAp7K8LQt3QxbCrHrQ45y+azeo9GgUkpekJVDpww9WrJ4N9x0K7Gw5PTivNPD8iTRBWPxgYlhr9GRiIoSLQutx5kSgjNgCB+Y6s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e55795-705f-4565-2da8-08d6879b85c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:45:35.2228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasha Levin <sashal@kernel.org> Sent: Thursday, January 31, 2019 7:20=
 AM
>=20
> I've queued this one for hyper-fixes, thanks all!
>=20

Actually, please hold off on queuing this one.  In a conversation I had yes=
terday with Kim, they had identified a deadlock.  Kim was going to be looki=
ng at some revisions to avoid the deadlock.

Kim -- please confirm.

Michael
