Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7778C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21842086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="m7SPCK2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21842086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbeKHE2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:28:41 -0500
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:28160
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbeKHE2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSnmHtyO5KgtWnjIQ1/EhzKAQUHuTG86Mwjmym832Qc=;
 b=m7SPCK2o6pW8bPHq9VIdry2duzU/ecvE+GKN7HHU9QYKx7ipAHTEvnG3FcEI7w4yP76ifHtqNjc3WG31Y/tDkLarQmfSnIWSRbCpRzZp6UTx7eVig1KSs6B1KWS/+ciOTJMyl1PBxI1bQU1IrEYiKHmTaB/fHC0ekZduQLuK/YA=
Received: from SN6PR05MB4783.namprd05.prod.outlook.com (52.135.115.17) by
 SN6PR05MB4671.namprd05.prod.outlook.com (52.135.114.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.15; Wed, 7 Nov 2018 18:56:53 +0000
Received: from SN6PR05MB4783.namprd05.prod.outlook.com
 ([fe80::c964:38d3:a19b:6091]) by SN6PR05MB4783.namprd05.prod.outlook.com
 ([fe80::c964:38d3:a19b:6091%3]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 18:56:53 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Ingo Molnar <mingo@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Topic: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Index: AQHUW2CZ0dZfAolPxUG9hT8O5ZUp5qVDToGAgAAFpACAAAwfgIABcMKAgAAOcACAAAERgA==
Date:   Wed, 7 Nov 2018 18:56:52 +0000
Message-ID: <192946CF-8543-4CF5-B2A3-93674FCD07E2@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-3-namit@vmware.com>
 <89262174-6f15-6116-e67f-436f7c1bfe99@deltatee.com>
 <6651971B-E3AB-4CDD-868C-2338593F7D83@vmware.com>
 <d0812681-4a8f-8cc4-24ce-d02002ee34d2@deltatee.com>
 <DC1EA50F-FAC3-4750-BCF7-0622D1FB4756@vmware.com>
 <a3902c4c-64b1-9c49-02fb-d5e4c9b04314@deltatee.com>
In-Reply-To: <a3902c4c-64b1-9c49-02fb-d5e4c9b04314@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR05MB4671;20:d6GVqQZPbWLRP26EFc0LZOG8R3PtM5AcHZg+7tqId474Odwwb5wv29IuPd/XptmAVbEI2UVlRIxS2C7WcFCyNug0MPLxXM/FTAEgg4ysQfPzMvEUYbfzsG9mkKB9gIc04zWrAy0zN+9kzZOnq/SrKwnrik8t/K6NBdAPqobpCXY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ae3c029b-f0b1-477f-c76f-08d644e2c826
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4671;
x-ms-traffictypediagnostic: SN6PR05MB4671:
x-microsoft-antispam-prvs: <SN6PR05MB4671BC2CA9E03602DE83B45DD0C40@SN6PR05MB4671.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN6PR05MB4671;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4671;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(6506007)(71200400001)(53546011)(305945005)(86362001)(6436002)(316002)(229853002)(97736004)(14454004)(102836004)(33656002)(53936002)(7736002)(6486002)(36756003)(6246003)(7416002)(110136005)(478600001)(93886005)(6512007)(2900100001)(446003)(11346002)(25786009)(106356001)(68736007)(5660300001)(105586002)(76176011)(256004)(99286004)(186003)(26005)(476003)(2616005)(4326008)(6116002)(3846002)(8676002)(8936002)(486006)(66066001)(82746002)(81166006)(81156014)(71190400001)(54906003)(83716004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4671;H:SN6PR05MB4783.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cJFjaYqXLQw9XPZJko3OghIuUYcQtr7oMThcWEZqlEhuDcqoZUkQ/zzYd1oXA2CiUbytUjgYstO2MyO1p4stswLWLcYkwnYzhgW7WicwPtIo/tW1OEr7V59/PgiCcmVrAlcuJ9EDfkzW+apIWzedY2TQ9mkhDSwARj26Xq+J55NkMatPO4C4IVy5NQLcThkRsBtrJapZpYTRz+lMlvzVb/hLs8EyUIfFYByybJ1VTcNDdPFvITNn3PxJlykxRE0oq+AychRDYc6UOoZwDPSzyaNmDzZt+D6Ugdlq+yITQm56mRCcot3SdbkNgfttggiKRwRY0QAxJKKdlneKJq03bR0MNm0WTahVdfxhrn9zovA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7211FD300DB08248A699CA13BAEFB2B2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3c029b-f0b1-477f-c76f-08d644e2c826
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 18:56:52.9848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logan Gunthorpe
Sent: November 7, 2018 at 6:53:02 PM GMT
> Subject: Re: [PATCH v9 02/10] Makefile: Prepare for using macros for inli=
ne asm
>=20
>=20
>=20
>=20
> On 2018-11-07 11:01 a.m., Nadav Amit wrote:
>> Ideas? Do people care about it?
>=20
> Just spit balling, but is there a reason we didn't just put the macros
> for inline assembly directly in the header? Something like this:
>=20
> asm(".macro ANNOTATE_UNREACHABLE counter:req\n\t"
>    "\\counter:\n\t"
>        ".pushsection .discard.unreachable\n\t"
>        ".long \\counter\\()b -.\n\t"
>        ".popsection\n\t"
>    ".endm\n");
>=20
> #define annotate_unreachable() ({                   \
>    asm volatile("ANNOTATE_UNREACHABLE counter=3D%c0" \
>                 : : "i" (__COUNTER__));            \
> })
>=20
> It does mean the macros won't be usable in non-inline assembly, without
> duplicating them, but do we care about that?

HPA indicated more than once that this is wrong (and that was indeed my
initial solution), since it is not guaranteed that the compiler would put
the macro assembly before its use.

