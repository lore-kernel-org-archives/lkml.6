Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99294C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554702064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="BFVkdtAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554702064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeLJBGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 20:06:43 -0500
Received: from mail-eopbgr760088.outbound.protection.outlook.com ([40.107.76.88]:15320
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbeLJBGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 20:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNrA4eGlGX3LHmPNZedTTjxSt42II+phEoXoROiLYjg=;
 b=BFVkdtAcdzoJrSDr1JzZz1i3wYNa2X5hue0XvHHyow92PU/X0zlo55xYjxjL6tLMZlarfSPYkx2pUazi25hR9cYdtyZw9TWXJ9y95exsGbg/H5B6Lsp+7vqs/WQtcYewkwyASm7YpLc7cVJS3qGxpO/3H0m4MoKdjlMwupnyoP8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4741.namprd05.prod.outlook.com (52.135.233.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.12; Mon, 10 Dec 2018 01:06:37 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%3]) with mapi id 15.20.1425.016; Mon, 10 Dec 2018
 01:06:36 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v7 00/14] x86/alternative: text_poke() enhancements
Thread-Topic: [PATCH v7 00/14] x86/alternative: text_poke() enhancements
Thread-Index: AQHUjHfNFAwJWv67fk2Sd9DXTZtwfqVxfPmAgAWzSIA=
Date:   Mon, 10 Dec 2018 01:06:36 +0000
Message-ID: <5CE7C382-F25F-49B3-A2A5-4E3EA0A221DF@vmware.com>
References: <20181205013408.47725-1-namit@vmware.com>
 <20181206100337.GF13538@hirez.programming.kicks-ass.net>
In-Reply-To: <20181206100337.GF13538@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4741;20:f98VYs23fOhKn1Stn8KKEWZ7K31Lbs0lismEW3AQ5+oRJKgaC6XfkzRwzfyj8VeoUd2bEUg+03t9zAdejlHFiIwYsS/0rKMud5UmZSFwsuR8dLDVEDeo+uWnqx813GRkTbXY3BrPzwwE2nru2jZQ4Y/EfQ/nngciHWUuQ5BAPBc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9c26e210-7d74-4978-ab87-08d65e3bbbfc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4741;
x-ms-traffictypediagnostic: BYAPR05MB4741:
x-microsoft-antispam-prvs: <BYAPR05MB4741E97FF65DC9EC942B6A97D0A50@BYAPR05MB4741.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4741;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4741;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(396003)(346002)(199004)(189003)(102836004)(5660300001)(305945005)(81166006)(8676002)(7416002)(7736002)(8936002)(53546011)(68736007)(33656002)(81156014)(6506007)(99286004)(316002)(106356001)(110136005)(105586002)(54906003)(36756003)(76176011)(66066001)(186003)(6486002)(26005)(229853002)(6512007)(6436002)(6116002)(3846002)(71200400001)(71190400001)(97736004)(83716004)(82746002)(446003)(25786009)(11346002)(2616005)(86362001)(486006)(478600001)(476003)(256004)(14444005)(6246003)(4326008)(53936002)(2906002)(14454004)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4741;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uqx+Zvm4mFnVRxc/gVnazo0yhQS86srR+XtPgO0dyB1EWYrdQjYBY8pjFHfAqKNHCMemxTKIoFt9FOy7sy7jdXa3Nx+iIwrqCzT82NQwemEIgDrB1BVGLINCHZ0n+B9DFjhORLp03rax2PId3B9H90BSuAp/nTc5++Vg6lPFFdWU8M19V1yTw4mOGZNEHWF+/Q8ZXv39snNeM3C6Q/O2MBo6xO6S8QOCyX/oKFIhP5r6X82o2Q7uejMTc/CPXp81SAX0AOB/oPMDiB0hDvbppnz5kmGMUqGI+icUlkYRvMQFJ4hjjyVyBlDpOtrpEifG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <924F07255CE10D4F9CDD7FF3667E505E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c26e210-7d74-4978-ab87-08d65e3bbbfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 01:06:36.3702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 6, 2018, at 2:03 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Dec 04, 2018 at 05:33:54PM -0800, Nadav Amit wrote:
>> Which leads me to (b) - the patch-set is big "enough" IMHO. Indeed,
>> there are open security issues in the kernel when it comes to W^X.  But
>> some people would want to use Andy's temporary mm-struct for other uses.
>> So additional security hardening may be left for future patches.
>=20
> Yes, at the very least we should get the first 7 patches merged, since
> they work and clean up the text poking irrespective of all that W^X
> munging.
>=20
> (also, I think you lost my ACK)

Sorry for that. I will add.

But first, Thomas, Andy, are you ok with going with the first 7 patches?

IIRC, you are the one who asked to add the handling of modules, since it wa=
s
not clear whether some synchronization is needed after the poking (that is
done w/memcpy in this early stage).

I can add synchronization if needed until the rest of the series gets in.

