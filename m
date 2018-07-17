Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE8BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7527420684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="YpsuTcRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7527420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeGQSbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:31:37 -0400
Received: from mail-eopbgr660118.outbound.protection.outlook.com ([40.107.66.118]:56448
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729688AbeGQSbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector1-raithlin-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFhPg4kGfuP4WiRbHzCW2hei+Xqp3iafW9qhiUobnVo=;
 b=YpsuTcRGnXCGp5+m8fnV+XdkDaIZvfFdgPhONPPzK+tfLGgDEt3bJLDyuNPeNBPmG6E/JMRTgQN0XQBy1nAHkwbt3HXVSjo7ItSciUVvfG3sWJcqIyFFPezJAvM9hqRPAOo63noH7AjnvXQnMGtz8FdOUPgLJopQJ6Vl9zY26Fk=
Received: from YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM (52.132.39.161) by
 YTXPR0101MB1263.CANPRD01.PROD.OUTLOOK.COM (52.132.33.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Tue, 17 Jul 2018 17:57:48 +0000
Received: from YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9855:3d86:374c:95b7]) by YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9855:3d86:374c:95b7%3]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 17:57:48 +0000
From:   "Stephen  Bates" <sbates@raithlin.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 4/4] PCI: Introduce the disable_acs_redir parameter
Thread-Topic: [PATCH v7 4/4] PCI: Introduce the disable_acs_redir parameter
Thread-Index: AQHUHe/v75a2v6FwDUisHhlkvKPSdKSTsPQAgAAAKAD//53FgA==
Date:   Tue, 17 Jul 2018 17:57:47 +0000
Message-ID: <ADC606E4-5A29-41AB-BE4D-51B89318B333@raithlin.com>
References: <20180717170204.30470-1-logang@deltatee.com>
 <20180717170204.30470-5-logang@deltatee.com>
 <20180717114848.2914d547@t450s.home>
 <a3197c27-1b41-7784-374b-948e43471789@deltatee.com>
In-Reply-To: <a3197c27-1b41-7784-374b-948e43471789@deltatee.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.f.0.180709
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com; 
x-originating-ip: [70.73.168.51]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1263;7:e4P9WvsEqWabiJSltuUiVnP6ZIULGdL3eAjzOsN/qh+DvjpISRWHlJ+pfqOW0T6zaliZqiPrx03vQ2wnUqRRtyVP6h0sgzphVFl7LcO3N3gT0YCbYqpC8/ZsPxVXgHJTdlaLle1Nmek5RJFsI/2U52U+0y14423VByqJmEsVKvFQrvopgTQ4Q9OrNsk0WOv5RjMMOaluvZ0+/tGgeiwAH8nlV8ee2Qh+RiaPM8Dn+avlFV/oWVJ0aME39Ml+jSoV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: de3e747e-e012-4a6f-3812-08d5ec0ecea4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:YTXPR0101MB1263;
x-ms-traffictypediagnostic: YTXPR0101MB1263:
x-microsoft-antispam-prvs: <YTXPR0101MB1263B94D531B7CFB7D243D4DAA5C0@YTXPR0101MB1263.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(6043046)(6072148)(201708071742011)(7699016);SRVR:YTXPR0101MB1263;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1263;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39830400003)(346002)(136003)(376002)(189003)(199004)(69224002)(229853002)(81166006)(305945005)(26005)(54906003)(6116002)(478600001)(7736002)(105586002)(186003)(558084003)(110136005)(25786009)(8936002)(6246003)(6512007)(97736004)(36756003)(3846002)(2906002)(6506007)(14454004)(81156014)(76176011)(33656002)(8676002)(6486002)(82746002)(93886005)(476003)(53936002)(68736007)(106356001)(102836004)(2616005)(11346002)(6436002)(4326008)(83716003)(5660300001)(99286004)(5250100002)(256004)(446003)(7416002)(58126008)(66066001)(486006)(316002)(2900100001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1263;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: raithlin.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZYxqI04DYc8R8oIsAKpKvxLF1iJwgicIRLIVzwTLUM0DPGlC7+cCTsvZKKkZu4TSQTtd/u3vCWKiUY7c9ItXV1mJjfbJvbqy3gayfI/vMi9R9EmxsFBw5MLI88e6mvnXnG7wAqzomikEstu+jJXirbyA02Tmu1lzlD/acjGpfs3wKjywaAcEKjs5IXcE5yesydGrSk/q+nqE1iFvJicdkPO9Ta7Q9GLuciivUtS5BfkUYOJx2SsqEk4hX7UNeBKUk6ghCttdghwuA21XyhmStXcuy61NcRTxGnHRr/KTd1vwtv1B2WLx4NIFMlI4jIp2SMwabrN9ICAvUpmh/UIRpr2ZjlAT0UM7C70RZ+zjVqo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <24B73FC6A8D2694AA351ED33AECBC101@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3e747e-e012-4a6f-3812-08d5ec0ecea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 17:57:48.2988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gUmV2aWV3ZWQtYnk6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5j
b20+DQo+ICAgIA0KPiAgICANCj4gICAgVGhhbmtzIGZvciBhbGwgdGhlIHRob3JvdWdoIHJldmll
dyENCg0KKzEhIFllcywgdGhhbmtzIEFsZXggZm9yIGFsbCB0aGUgZmVlZGJhY2sgb24gdGhpcyBz
ZXJpZXMuDQoNCkJqb3JuZSwgaXMgQWxleCdzIHJldmlldyBlbm91Z2ggZm9yIHlvdSB0byB0YWtl
IHRoaXMgc2VyaWVzPw0KDQpTdGVwaGVuDQogDQoNCg==
