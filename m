Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1E1C6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF7D206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 02:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Vby67Sqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF7D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeJHJ0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 05:26:31 -0400
Received: from mail-dm3nam03on0054.outbound.protection.outlook.com ([104.47.41.54]:56544
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725760AbeJHJ0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 05:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxJOQ/rjjsm41Romf+FA9wOhYA2y7UCqm2T4EwPye/Y=;
 b=Vby67SqfHXcApw2O+InIp+f+sFhcjHjQ63dnyraF1C+IcWgQ9ijUZuLYZVuFj4rnz/joxvCpInqPDJv7B3aeYTqdcySkeCfu3gkzgB13LMli8ooevRLFNpT72MBjQMoesUoj9+MUGZ+MSZARcLjnOcstQXBOdZUIm5lyNzFChYo=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5095.namprd05.prod.outlook.com (20.177.231.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.13; Mon, 8 Oct 2018 02:17:09 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Mon, 8 Oct 2018
 02:17:09 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Thread-Topic: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Thread-Index: AQHUW2CZEG0GJCpfDkK4fEgcOSwgMqUOuSmAgAAJ9ICAAAHlAIAABIuAgAAEaQCAAAT8gIAABDiAgAAKqICAAYO3AIAEPbuA
Date:   Mon, 8 Oct 2018 02:17:09 +0000
Message-ID: <8762567F-AF91-4D51-AEAD-4F4A18E59F8E@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com> <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <20181004091222.GB21864@gmail.com>
 <D42AB116-BFA4-4CF0-BF45-41C579A9B4C7@vmware.com>
 <20181004094519.GA97692@gmail.com>
 <29591D3B-D49B-4D7A-B280-85A2C3F63F9C@vmware.com>
 <20181005093108.GA24723@gmail.com>
In-Reply-To: <20181005093108.GA24723@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [70.164.121.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5095;20:prsTeRnMpjQZxZunTIpDwvPyBE/Jivl4HaHoHefmuhmulKUlgFu4GUXqFpg+euAoTSICdsECKWoLmNxK477KF//VcNug1Q3sa2NjwOA82Hyu6YQX3Uo8xiSZi6WwRwnHB1toNQqvU0sxVa/GfJoyUPIAonOS0TkFuynRFO7fa7Y=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 46b75829-4d46-4874-3335-08d62cc426de
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5095;
x-ms-traffictypediagnostic: BYAPR05MB5095:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB5095DA28776A9CC7E9867F69D0E60@BYAPR05MB5095.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR05MB5095;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5095;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(54534003)(2616005)(476003)(76176011)(6246003)(6436002)(7736002)(8936002)(81166006)(81156014)(256004)(6306002)(2906002)(6512007)(5250100002)(8676002)(68736007)(486006)(33656002)(102836004)(478600001)(53936002)(54906003)(305945005)(25786009)(99286004)(106356001)(966005)(82746002)(93886005)(14454004)(71200400001)(6506007)(83716004)(71190400001)(105586002)(66066001)(229853002)(7416002)(86362001)(446003)(4326008)(26005)(2900100001)(3846002)(11346002)(6116002)(6486002)(5660300001)(186003)(316002)(6916009)(36756003)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5095;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UmS/uOGznYxtW2CZXSWYAIzKevGzQJYsoC1M9y2B+i6AT7r3rD3Z23STTgRVV2ZAuYxYH/dQarljp8t0P10gX8Ab4G/HmEH8JIUwXevzGn3VslhlJwvnTPajvwLhNRcBWJTiNekqKqGtcdTsqVhfvoz6yUtDOXlBn/hKbxR0uwenLZb9b1foySCDlTDv8xbEgby2IwLbSIFxV1K26e3ic6wVeFQaaJf507goRJQUApzx5YC7OqWCFG/AHDH41DO7jRsTKm2wzV0SWjTdAB9almIKV7R/YDfL+6ZqhWC2Yd8+CXwd2OSHe+PFD/k3f1dTWNI1of0eDwe0ASZfRqmRwIqw/lzua0bR65VWTTOo5JA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A5ACA91DE766A34DA15F9FABB0F8F37C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b75829-4d46-4874-3335-08d62cc426de
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 02:17:09.4624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 2:31 AM, Ingo Molnar <mingo@kernel.org> wrote:

>=20
> * Nadav Amit <namit@vmware.com> wrote:
>=20
>>> Are you using defconfig or a reasonable distro-config for your tests?
>>=20
>> I think it is best to take the kernel and run localyesconfig for testing=
.
>=20
> Ok, agreed - and this makes the numbers you provided pretty representativ=
e.
>=20
> Good - now that all of my concerns were addressed I'd like to merge the r=
emaining 3 patches as=20
> well - but they are conflicting with ongoing x86 work in tip:x86/core. Th=
e extable conflict is=20
> trivial, the jump-label conflict a bit more involved.
>=20
> Could you please pick up the updated changelogs below and resolve the con=
flicts against=20
> tip:master or tip:x86/build and submit the remaining patches as well?

For the record, I summarized my analysis of the poor function inlining
decisions in Linux in the following blog-post:

https://nadav.amit.zone/blog/linux-inline

Regards,
Nadav


