Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3BEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484C320821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OSLzkvUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484C320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeLJNVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:21:51 -0500
Received: from mail-bgr052101131079.outbound.protection.outlook.com ([52.101.131.79]:10270
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbeLJNVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GZ3jtg3u9d61PdyaKY7s6sLBWVVkUVvxu2ft1XdTs8=;
 b=OSLzkvUkvcMaSaa/Z23zguADURbGEtpurG0raY2NNYyp1p6x41DKDnKVZ0HnKaerTpLjAlHdmqtQ/pNcASdmGanH4OaERqcgjbzDtWG25HQ8ui+q+Ay1JDhxsXZhEV5hXv3VEjrK9PWWDjCnAnBBsNnW6UVVlW1X+dRa/ngxnMA=
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com (20.179.10.210) by
 DB8PR08MB3948.eurprd08.prod.outlook.com (20.179.8.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Mon, 10 Dec 2018 13:21:39 +0000
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d41:d012:1944:5810]) by DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d41:d012:1944:5810%6]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 13:21:39 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: Re: [PATCH v2 3/4] x86/kvm/hyper-v: direct mode for synthetic timers
Thread-Topic: [PATCH v2 3/4] x86/kvm/hyper-v: direct mode for synthetic timers
Thread-Index: AQHUhZ9mV1oam64KnkyNE5PKjfame6V4KKWA///bCACAAAeggA==
Date:   Mon, 10 Dec 2018 13:21:39 +0000
Message-ID: <20181210132134.GA5888@rkaganb.sw.ru>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-4-vkuznets@redhat.com>
 <20181210120637.GA13294@rkaganb.sw.ru> <87va41czk5.fsf@vitty.brq.redhat.com>
In-Reply-To: <87va41czk5.fsf@vitty.brq.redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
mail-followup-to: =?iso-8859-2?Q?Roman_Kagan_<rkagan@virtuozzo.com>,=09Vitaly_Kuznetsov_<vk?=
 =?iso-8859-2?Q?uznets@redhat.com>,=09"kvm@vger.kernel.org"_<kvm@vger.kern?=
 =?iso-8859-2?Q?el.org>,=09Paolo_Bonzini_<pbonzini@redhat.com>,=09Radim_Kr?=
 =?iso-8859-2?Q?=E8m=E1=F8_<rkrcmar@redhat.com>,=09"linux-kernel@vger.kern?=
 =?iso-8859-2?Q?el.org"_<linux-kernel@vger.kernel.org>,=09"K._Y._Srinivasa?=
 =?iso-8859-2?Q?n"_<kys@microsoft.com>,=09Haiyang_Zhang_<haiyangz@microsof?=
 =?iso-8859-2?Q?t.com>,=09Stephen_Hemminger_<sthemmin@microsoft.com>,=09"x?=
 =?iso-8859-2?Q?86@kernel.org"_<x86@kernel.org>,=09"Michael_Kelley_(EOSG)"?=
 =?iso-8859-2?Q?_<Michael.H.Kelley@microsoft.com>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0901CA0058.eurprd09.prod.outlook.com
 (2603:10a6:3:45::26) To DB8PR08MB4092.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB8PR08MB3948;7:rmkX43Plxn/xLglUZlNW/ntxS6/918FLcCHZcLOhDbGVpSLY9W8u8vm45l730ss8VM7fFyHLnhI3brjozyF85Q/XEhRbvUZDhSil1zzoqyrwDhEn+o/O6AJENUNWYHPpk5Vi3dBj0a6xpDu3CaDO7g==;20:t93PL8nuJgg2Jr1ZRsiPjEGqPUolwNoYTQPrdcTv8vUTWz+zc9MTieHk6RZ6/7fOcRQv9Scl3KbvNpQPTnZmonMV4XTCtpVoGXQ0KnPgzrh/P6VOjbkQCqk9ybjbLFsp7d3tFJtnRDsZx6O35z/S1t7TkzFNAgJlO/gbXnVmTrE=
x-ms-office365-filtering-correlation-id: dd771855-c4e7-4882-7ef9-08d65ea26b17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB8PR08MB3948;
x-ms-traffictypediagnostic: DB8PR08MB3948:|DB8PR08MB3948:
x-microsoft-antispam-prvs: <DB8PR08MB3948A3DB164B8AB035673B34C9A50@DB8PR08MB3948.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB8PR08MB3948;BCL:0;PCL:0;RULEID:;SRVR:DB8PR08MB3948;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(136003)(396003)(366004)(39840400004)(346002)(376002)(189003)(199004)(6246003)(2906002)(7736002)(25786009)(99286004)(5660300001)(97736004)(305945005)(33656002)(14454004)(6916009)(36756003)(68736007)(6116002)(3846002)(52116002)(105586002)(476003)(446003)(486006)(11346002)(106356001)(4326008)(1076002)(478600001)(6506007)(6486002)(66066001)(53936002)(386003)(9686003)(256004)(186003)(6436002)(58126008)(6512007)(54906003)(76176011)(8936002)(33896004)(26005)(102836004)(71200400001)(86362001)(8676002)(81166006)(7416002)(316002)(93886005)(229853002)(71190400001)(81156014)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB8PR08MB3948;H:DB8PR08MB4092.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 99KuPJV3FS1ckFuvKqXX0tSJCdUUEuSRhGmsmhjLnh/F9Wo9NEOcCEaZlNKV2OaNMViUMUMHUH/lkU0QVj9/NzZ+YjK93HoYRjTi8YsNNPfgtqEYBKWVp6tkUOgBNay0PWONKdSfVYtzCBIsTav8a792KAwRbJfp0PO4QDybBt/NRadqeFaJHmzV+AA0XKDAA+9Yk/ZI0jXzoDd50fRCRRdVNbwkPrbJqcN5qlR6SswSbr3hmB5rIMDyuUgixt/M7a2u4EpPPuazw4nzXFFyJPI88ecosM7RJboGc+i/cJCqgjJGWpBrG3K8xF7+v5wZ33wylR6EAGbsG1bmFeL6w/ZyHlUo1Sqle/wbP5kZzt/JcTieNOeiPyXhylknbOh6CCjPaZlHiYEmCqQ1doQK/Dy+7XIIhp7f3zzDxacdbQqyI42+bZ3ddUN7Y9wauK0OOXcWwb4tWf6Pzrz4yN4BHt8OhIt4LgHgOhJhl9cWfPkX/cxV5TW43VNk1eVnbwan
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <91D0B01C8708804BAB304B253D278442@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd771855-c4e7-4882-7ef9-08d65ea26b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 13:21:39.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 01:54:18PM +0100, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> > Just noticed that the patch seems to assume that "direct" timers are
> > allowed to use any vectors including 0-15.  I guess this is incorrect,
> > and instead stimer_set_config should error out on direct mode with a
> > vector less than HV_SYNIC_FIRST_VALID_VECTOR.
>=20
> The spec is really vague about this and I'm not sure that this has
> anything to do with HV_SYNIC_FIRST_VALID_VECTOR (as these are actually
> not "synic" vectors, I *think* that SynIC doesn't even need to be
> enabled to make them work).
>=20
> I checked and Hyper-V 2016 uses vector '0xff', not sure if it proves
> your point :-)
>=20
> Do you envision any issues in KVM if we keep allowing vectors <
> HV_SYNIC_FIRST_VALID_VECTOR?

It's actually lapic that treats vectors 0..15 as illegal.  Nothing
Hyper-V specific here.

Roman.
