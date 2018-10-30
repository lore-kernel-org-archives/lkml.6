Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46144C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED97F205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y8COcsCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED97F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeJ3Wew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:34:52 -0400
Received: from mail-eopbgr730119.outbound.protection.outlook.com ([40.107.73.119]:31488
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727450AbeJ3Wew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4VoEgresdi+zDJ/fC7qonHDriRtQ/SofLuvmeJaAKs=;
 b=Y8COcsCCHo7bF8scVpidtYMYr8Mtt2KOXlmdmzmpJNlLRUhmIXd2fnvawn48xKaAdsLdQR8C155ZXUZgJ63rNeJAu8Vmsl8ZbR/sjd71jqd6LVMT+I/hRi7/QHolDq+Q4NDS5fEWnImQmocRNvV9v8gh1H3nsIog1ywAcLQnpbU=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.4; Tue, 30 Oct 2018 13:41:17 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb%8]) with mapi id 15.20.1294.014; Tue, 30 Oct 2018
 13:41:17 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH v2 char-misc 1/1] x86/hyperv: Fix PIT shutdown quirk
Thread-Topic: [PATCH v2 char-misc 1/1] x86/hyperv: Fix PIT shutdown quirk
Thread-Index: AQHUaiUQ3a7qHQo2LESQRWPEN4INt6U3guCAgABTtSA=
Date:   Tue, 30 Oct 2018 13:41:17 +0000
Message-ID: <CY4PR21MB0773848862C8F0E91CD318F3D7CC0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <1540226025-45092-1-git-send-email-mikelley@microsoft.com>
 <alpine.DEB.2.21.1810300859420.5984@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1810300859420.5984@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-30T13:41:14.9129628Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:osD6c+PZ82r7wB5AZu7iKVQnAREf2YQIYO3bdOsbwkJc0g8eggszj4Q2n1drGN713PmIwRllrvb22wbDLEsTiaPHjDiDRfjnI7Df8OSZQSBJfZlT9JxU0Gg0xeYWmZGdlJki6NEdMvX/05AN8j1nNZDq2+4alM7V5ClkygXnEgg88+o6qK76Tt53WqfiXPQl6ZLaQ6J+yQ0lFB64yjcrasrf7llXUZd9Eu+zC6R3V70aYvRj+AymGQNXrpQODFihmt6paJ/8teD/nP0zpamJ26OOh4HllsYjmrHlffPSI/+A5z+X3khBNgSAdZ7QjtpVoikGUaCNNfbCEJxp+PxvhV1RqUOvQe2Po57dlAUS/uDXgFyJ+FsdLn+C6mde9okH8AQs2OECxxj/pOiwZE/QPoQ3H6DszlB+VS14eRws3REzXWw0H7PSwkrFMF+GsZa+92UXgyPzUCftdfv3yHOdKA==;5:0gPd2xTpki1HY0HtstabdzzRPIdWOlbF2asOmqakfQNKfoMd7qmd4rPtYYTKZSGXFLe6pFQLnCtBoP8dhoKHYNH4buftLbqsw3qBIE1KmFQwIvrspYONiawzwOJSNRHn3Wx7GCFCKfiRvjWIojBsMV7c5/j1orcuclaLZr/i5es=;7:1asZoZiHlKghbYz6/GWSN+KXIb9gzWoBZ1v6TQiIsL48L9XwxJJp3jfr5Pkz5X2WLu7vzyNtTLog9HdBhR3LUQj7tenPgnri6xjnjmTykcEvjY18JYn6zckieXGrwSVgEskvRK8xtUCIi0BQYB0UBg==
x-ms-office365-filtering-correlation-id: 0f5acbb9-6f2b-40be-989e-08d63e6d5e53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0472527F1C8F89E09BD2CFE6D7CC0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220027)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231382)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(199004)(305945005)(7736002)(106356001)(486006)(86612001)(86362001)(99286004)(97736004)(5250100002)(4326008)(476003)(25786009)(3846002)(22452003)(68736007)(186003)(316002)(11346002)(6506007)(6436002)(66066001)(76176011)(7696005)(53936002)(7416002)(26005)(8676002)(81156014)(81166006)(2900100001)(2906002)(10290500003)(10090500001)(5660300001)(102836004)(33656002)(8936002)(446003)(54906003)(6116002)(478600001)(107886003)(6246003)(14454004)(74316002)(8990500004)(105586002)(256004)(71190400001)(71200400001)(55016002)(9686003)(6916009)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Xak2Bv7ut+xb+bhWOu1qh1oi4uQK//HsGyvGMoInU3XghvDn7NRW4dcOTeICbY1aAdxTwWYLiTvF4eY9To7zje3A6/vJTFdzopliJfIt8WiIyP0wOHUSSnnZyCQeFeeY71UYKLc0b0PcumRExqpLoQz4psvq2F6YOnQjvpyPyRiXMMz1Xd5PThhbHaHbADSkzYYFy6GD/XI+IZNcOsbuYd0oBLgiYGC3pvAz55c5NbIASgWV945QG46AN9z4/5GaJpSCEk7BqwwYLjR0dYJCu+W3riNBWsvKLvy97VekHCs1mZ5K1yNSG80G6BAj8ragfM/iEnGHYSX9LGE+0KozLYvavo9QKQunoq2/Y0EmWGQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5acbb9-6f2b-40be-989e-08d63e6d5e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 13:41:17.3357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Tuesday, October 30, 2018 =
1:36 AM
>=20
> You can avoid the ideffery completely. Something like the uncompiled patc=
h
> (lacks comments) below keeps everything in i8253 and should just work.
>=20

Thanks.  I'll spin a new version with that approach.  Having to clutter the=
 i8253
code with a Hyper-V quirk is unfortunate, but it's a lot fewer lines of cod=
e overall.

Michael
