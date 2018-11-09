Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096F5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B833520883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="f+zNVpB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B833520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbeKIRs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:48:56 -0500
Received: from mail-eopbgr700049.outbound.protection.outlook.com ([40.107.70.49]:30205
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727962AbeKIRs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN+AJ7TqTz9OEy1AjWPxrQI3rdCpN3SkUuGEP0hmQBg=;
 b=f+zNVpB0fMxXQXy3FzEwNTq2KRviaymbDvB1FVYW7DIZs25xuxSAuV9QI/6E3No+WWbhJV/pojGIcCn29cE/Q0L6AatV18CKVIDhdBX6+dbB1foP+cblLDPP+7V2l8azzob7zREghLjHdJtyLVbtFCHPSHl8ZOpDzAefERxLY6k=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5024.namprd07.prod.outlook.com (52.135.121.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Fri, 9 Nov 2018 08:09:28 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 08:09:28 +0000
From:   "Richter, Robert" <Robert.Richter@cavium.com>
To:     Julien Thierry <julien.thierry@arm.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH 08/10] irqchip/gic-v3-its: Decouple its initialization
 from gic
Thread-Topic: [PATCH 08/10] irqchip/gic-v3-its: Decouple its initialization
 from gic
Thread-Index: AQHUduW606qvYKxACUS/t7Q6A777CKVFvd0AgAFbYAA=
Date:   Fri, 9 Nov 2018 08:09:28 +0000
Message-ID: <20181109080920.GE4064@rric.localdomain>
References: <20181107220254.6116-1-rrichter@cavium.com>
 <20181107220254.6116-9-rrichter@cavium.com>
 <21a0183b-bf4b-1895-d10b-8287dbff930a@arm.com>
In-Reply-To: <21a0183b-bf4b-1895-d10b-8287dbff930a@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0022.eurprd04.prod.outlook.com
 (2603:10a6:206:1::35) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2.245.13.105]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5024;6:nBdLSw1YaNtKm8DpwRzcmHKZ/uqwvy7Ng2ERlitySU5qlEh5EOo/9wxyy1BTilWANLWBp7thKYIpyQo/qVG/8y6kHYPO5WmpCUq1dxRSqT5POUcCcynTUd99SfVdB4d2b6uVrXXZD5yaU3l6Bf+iaPaZK4lGcOSsvjcWLQ7MOKhdyHxothwFZzMnCaWxm4LLnugGDo1L0ZWPFf+j6swXcIKBifaAbUAJkfv1ir+kXL25zxrJnDeen64DYVAYH4XG9SEC1Ng5yw6rVlgLMRLqdFvho+yvq0s9/AVUW+LMSfq+gV+X5sctMNT1QCuEOwV8rs6AmoTiomqqwuu3RvRHhA3f53lWBjA9jox9gcoob4EHS4ZeEMjHXsvdUHGnj9W9lWUkTIFZbm+79sbl0r+7o8w4BvKj/gmKzPwml6waaI6pb/ejb+HMN3EmL9fk51AX4LhXR49PTKF1ReVoTvoGxw==;5:0jO/GYk/F3dWVsgVGxxdY29DWYzurYmsXIdbiV0M972W0KPTLa0TT1WJ7Acnhne0PA62hW9m1oUYfaGIFqMRhokcp2Fd/6hCVy23fGSVAh0pDPV1vIVDWyvW5pk0LTyQcR7EZmxWFwjgyXZ3R19wHDI7MFj2XLBnlls7zHQAwe8=;7:8gJlIVJJ4pRCGvFKMjhZPshi6S/yogryjIw3Etg051ppRMqY50C9iFplKrA4HXxTl9NskEtTGXxHZR5ZiaWCfLyHd2s27I50S0MtlALstSOwNH3pfHRVA0nEih2lm9c6DI9wksLrJ35DdqYupDNrcA==
x-ms-office365-filtering-correlation-id: eee04df2-b083-4d16-4101-08d6461aab6e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5024;
x-ms-traffictypediagnostic: SN6PR07MB5024:
x-microsoft-antispam-prvs: <SN6PR07MB5024AB2DA4525D2E73BA9682F1C60@SN6PR07MB5024.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5024;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5024;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(189003)(199004)(6246003)(14454004)(105586002)(478600001)(26005)(106356001)(72206003)(53546011)(33896004)(102836004)(99286004)(386003)(6506007)(52116002)(25786009)(76176011)(81156014)(6486002)(8936002)(14444005)(6512007)(68736007)(81166006)(9686003)(53936002)(229853002)(6916009)(7416002)(5660300001)(305945005)(8676002)(97736004)(7736002)(6436002)(2900100001)(66066001)(476003)(86362001)(446003)(11346002)(486006)(186003)(256004)(33656002)(4326008)(2906002)(71200400001)(3846002)(39060400002)(6116002)(71190400001)(1076002)(316002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5024;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jd0/K8QnwQJiPrSziYfjetjVc9awH5Y4lF+EXtKM7wpbIrD51oXYRd85oMn9FuHvNhvwZpi255g4Wc7Kn9eVc7OeQbepY61kJf8M2dmGRkgBgpsqHWj4LmTphvySXBmPoRGMavlEgAmuaN0akomt4CP5mri5fMfw5VgFcyggYOFeXs9uD1tdRdN4BVkUMJcFAh4Z30SIemxSYYW/5U+kcFk0aANcud5gEAF1KpqcploU/0dsxmgpjCunYBtQyu1Ahi+h+XYFR2hKjBzK1NbgS1T24r50FnlglEJ/zjPM3jygY6VaszRIbezV20tUiy11A0a0/YIbDsY7R/5w26AlUr9BOkQIHhsX3Te052rdY6g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA5A9D9D0DD1014E95F633AA96F738FC@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee04df2-b083-4d16-4101-08d6461aab6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 08:09:28.3210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.18 11:26:02, Julien Thierry wrote:
> On 07/11/18 22:03, Robert Richter wrote:

> >-static int __init its_init(void)
> >+int __init its_init(void)
> >  {
> >      struct its_node *its;
> >      bool has_v4 =3D false;
> >      int err;
> >
> >+     if (list_empty(&its_probed))
> >+             return 0;
> >+
> >+     raw_spin_lock(&its_lock);
> >+redo:
> >+     list_for_each_entry(its, &its_probed, entry) {
> >+             list_del_init(&its->entry);
> >+
> >+             raw_spin_unlock(&its_lock);
> >+
> >+             /* Needs to be called in non-atomic context */
> >+             err =3D its_init_one(its);
> >+             if (err)
> >+                     its_free(its);
> >+
> >+             raw_spin_lock(&its_lock);
> >+
> >+             if (!err)
> >+                     list_add_tail(&its->entry, &its_nodes);
> >+
> >+             goto redo;
>=20
> Again, you're starting a loop only to work on the first element and then
> restarting the loop.
>=20
> Just do a while (!list_empty()), and without gotos...

When writing the code I have looked into an alternative to
list_for_each_entry() and did not find a better way that works with
proper locking. list_first_entry() requires the list being non-empty.
If you set the lock after list_empty() it is not granted the list is
actual empty. See also my other comment in an earlier mail.

-Robert

>=20
> >+     }
> >+
> >+     raw_spin_unlock(&its_lock);
> >+
> >      if (list_empty(&its_nodes)) {
> >              pr_warn("ITS: No ITS available, not enabling LPIs\n");
> >              return -ENXIO;
> >      }
> >
> >      err =3D allocate_lpi_tables();
> >-     if (err)
> >+     if (err) {
> >+             pr_warn("ITS: Failed to initialize (%d), not enabling LPIs=
\n",
> >+                     err);
> >              return err;
> >+     }
