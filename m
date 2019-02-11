Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF083C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51162214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qPWFm/Uo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="noZ1PA0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfBKXZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:25:26 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60990 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbfBKXZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549927525; x=1581463525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5QwLzSPC9KlC59Lgw1P+KOZfTT/ttsucsNAjSXbmKUU=;
  b=qPWFm/UoTPLIpzfidI81m+icOf4Z3F5KDpM1WXaiYBJ3twpJRq+A3N+p
   b3akvXDyhJKoZOG8XbFUW29FFpshsx2REKDxWRRmJdGDqi4FEHqwYVeUr
   PM8nkS9VRyn16urC8C7LE75FPiIecKTjRzicmt50d/nPRN17itjSkK7J2
   obEKsItwjLcUrryuKbN4ivOHaliujl0YMqOGtCYOy9fLislEfuPMKuc6L
   gwWT/zb24Uy1JpfVbmvUePK3LbrrkeGCvz9lWVk9MjHLefDzb/WyNid4a
   gBvyGYoxij6+PrL7d92Gv01GJdKk25tGy1u/4SC7Iru1C2P0D8qUFUdF1
   g==;
X-IronPort-AV: E=Sophos;i="5.58,360,1544457600"; 
   d="scan'208";a="102263086"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 07:25:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp+aQie5LyyM2n29ZXd2YkF0q4+M+kwUeStwrMlz8Q0=;
 b=noZ1PA0Kfwoi9iGJ6MemNT4A+d1WtdBj6nQWmBGL8fvoYQG2UlgN31gSk6V4J6nBFRZoykMSZixyH/cpSK+Rmc24sBLjKmgtjgWD7UzohaXeH7eZZqOcB5UfesFwP2fOXG6IdKeZQ9lFGpZJZHBFyvy0u/jUfpWhB0GqeQAEksk=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB4726.namprd04.prod.outlook.com (52.135.240.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Mon, 11 Feb 2019 23:25:09 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::19f6:af46:d6a7:59bb]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::19f6:af46:d6a7:59bb%2]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 23:25:09 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        "david.abdurachmanov@gmail.com" <david.abdurachmanov@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "me@packi.ch" <me@packi.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "schwab@suse.de" <schwab@suse.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "zongbox@gmail.com" <zongbox@gmail.com>
Subject: Re: [v3 PATCH 8/8] RISC-V: Assign hwcap only according to boot cpu.
Thread-Topic: [v3 PATCH 8/8] RISC-V: Assign hwcap only according to boot cpu.
Thread-Index: AQHUv1DZTg7Di6/hKki5WijoQT5U96XVnfCAgADoRACAAFpRgIAEGYUAgAARCwCAACRNgIAAAsGAgAARSAA=
Date:   Mon, 11 Feb 2019 23:25:09 +0000
Message-ID: <5353E827-644D-4BA1-B8E4-6075793C6E8A@wdc.com>
References: <mhng-99c5091e-32b8-4609-a92d-d3ff2a239887@palmer-si-x1c4>
In-Reply-To: <mhng-99c5091e-32b8-4609-a92d-d3ff2a239887@palmer-si-x1c4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [172.58.95.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b64d534-e2c4-4c87-f77b-08d690782a0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB4726;
x-ms-traffictypediagnostic: BYAPR04MB4726:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR04MB4726;23:b3zgNexbe683dpiBO1kGO3oKRLFFoT4eTVBpH+225?=
 =?us-ascii?Q?BMUVf46XjTu9R2yr4h6WjV0JyHyzREVXLkEpQmlaChj55pMJKgxpgtWXwkge?=
 =?us-ascii?Q?VP/k41CvC4mUKFbvqPbFRCwIHbaJAseVelXLbsO887GeZdG+sEjktVKlUnbY?=
 =?us-ascii?Q?6q9uHlSIdo4UAIM0OktBgimTt2rP9UzNljPoIwh7SrwAVks58xd+6ZG9GVPK?=
 =?us-ascii?Q?wahSdJEIZB6ulDC04JC5i4xL+TE3518JvsOZlSXg5CcFOhSk2rktG+QOKo3J?=
 =?us-ascii?Q?/ZcW/C+ZooSqBjqDrK+h1hE8gklfau0BhBpiWF7vHXenf3TgZHfZ4svHYcSL?=
 =?us-ascii?Q?5J9i0Nq54P8vQsXeGqrzn8fckh4s2GBaWjSZ9RR5UJAZO41QzU/Ol+OLGi3O?=
 =?us-ascii?Q?iAajPdkid6tzANbEvNDqKyIN8WbTEDJfKS/N5rCFyC37wXpvP3C6T0LEp7bL?=
 =?us-ascii?Q?S0Fgupu2wSoRgqQF79eH2SAjDaXjKGkHpMD7ic0YD0iB4CgmmWhhSYrWL2wB?=
 =?us-ascii?Q?k5/hubTfojulL8NA8W7NzDDPVvUXj0KRjfWlDI3StBF+B6dF+U9grgOMad3T?=
 =?us-ascii?Q?uvbKVyrmBwDqMEycankFFM7kVfZqIjDdyNN0+Af4mGdOKXeWyrdU7LKtKvfJ?=
 =?us-ascii?Q?hU6lHGGjKBkieVbyHmbvuDR5/tbuwH1D2aSuFs7X6J2aUl2Z+kjqP/RwM34X?=
 =?us-ascii?Q?Kqv9FXuIbHuitdEMQEIz3uTD6KzsKfW+VA5Ppj9yTYZB+zskt+qeE1L0A02K?=
 =?us-ascii?Q?QHkcNlG5K699orClafb8fisowxF2LtMyTB7T+tm1hGAjegqwVFGn2hOSvRoZ?=
 =?us-ascii?Q?Ilx8cbslQelv8wsAEb4PeR1PIXTLhuMckFWD3ZgQEY88S6/rFJPJMbEj/xZl?=
 =?us-ascii?Q?FeVrOFW7q7DfE6AW2lhdkZ4QSk91uG+t7LAkFMNxopbvtd6nuY3ky3HGUtb9?=
 =?us-ascii?Q?pC4V/NeGuXCz+svDljN1OASv/42leQ2ImmYEiNWyA1SOfwjDeL3WAGue2QSf?=
 =?us-ascii?Q?n6A+D7nG9kaDYocb1OnOMHNRCMHwl1eD0a0sTDgzGTCBVMRprq/+ei1Lq2pa?=
 =?us-ascii?Q?O0zPhchajFMH4N9QOK5I5m3BG1xWzeBpTn6NYb9LaeZ4898f308wz0suU4/6?=
 =?us-ascii?Q?82GB3Dg6FM8oNBwBnOs+2N+n6qUcZTQ79E0Qw7Kfi5DQbQdQhkp7ZQ0zZXca?=
 =?us-ascii?Q?OUiRJCF5XPojQPYEZ86XsOJTrhjORkEqEEJpDsaL3RpHlpiXNcLWtO7DnKg+?=
 =?us-ascii?Q?/IAEGqtTvhcseFtvAEW/b8b07vgBF2nMk0BuuPrBlNcUkvvolkdSpTdAiZoZ?=
 =?us-ascii?Q?I3wUP09A1YF0fbItKcoG5E=3D?=
x-microsoft-antispam-prvs: <BYAPR04MB472634B3C2DC5A75D76867F5FA640@BYAPR04MB4726.namprd04.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(81156014)(81166006)(82746002)(66066001)(966005)(4326008)(25786009)(14444005)(97736004)(256004)(229853002)(478600001)(6436002)(99286004)(72206003)(6486002)(6246003)(53936002)(6916009)(476003)(36756003)(7416002)(446003)(486006)(3846002)(6116002)(11346002)(2616005)(8936002)(76176011)(8676002)(71200400001)(71190400001)(54906003)(14454004)(305945005)(102836004)(86362001)(6512007)(83716004)(33656002)(106356001)(105586002)(7736002)(2906002)(316002)(68736007)(6506007)(53546011)(26005)(6306002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4726;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0U1KSL9rhUvGBNve/J6hKELcwVYpXPQQ7By9PzjTck0kJuED7xqYBFv/nHarvxitQOzb3Rfti1/GQ1YX2Y1BlfmIopcsgXS+QKR8s2go3YoEuyKWpjky/7A5E7rfiZMTB5u40Tvx9ziq8WXttwkLx1t3aTnXV2r+wf4t5T/RnlA0slPMe84rOZei2rV4grL0N5n/V3OmzM808KqiWtAGnj8zNpaLxu3LBE3ooJJu2kloUbDlqtNDrHzHXCrTLyqOnjlQopJbWBvov5krnAOBJILPq5lY28Dd5pHUjJ1C1ls8Tov+gHcx/+KjDUvV3D8JEHo1ZxIBW1sGprRf2hOUE8CuwR8mQaj9Ac/LtMd07ZGjlLDqNdoznFabLKcj856bSsDqELGDxDK4FhZM94Q0SS6VhtJ7i0aanoIeJIQy6fY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E83E73C75EA444D8D3714704FC6B0BC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b64d534-e2c4-4c87-f77b-08d690782a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 23:25:09.4517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 11, 2019, at 2:23 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
>=20
> On Mon, 11 Feb 2019 14:13:25 PST (-0800), marc.zyngier@arm.com wrote:
>> On Mon, 11 Feb 2019 12:03:30 -0800
>> Atish Patra <atish.patra@wdc.com> wrote:
>>=20
>>> On 2/11/19 11:02 AM, Palmer Dabbelt wrote:
>>> > On Fri, 08 Feb 2019 20:26:07 PST (-0800), david.abdurachmanov@gmail.c=
om wrote:
>>> >> On Sat, Feb 9, 2019 at 12:03 AM Atish Patra <atish.patra@wdc.com> wr=
ote:
>>> >>>
>>> >>> On 2/8/19 1:11 AM, Christoph Hellwig wrote:
>>> >>>>> +     * We don't support running Linux on hertergenous ISA system=
s.
>>> >>>>> +     * But first "okay" processor might not be the boot cpu.
>>> >>>>> +     * Check the ISA of boot cpu.
>>> >>>>
>>> >>>> Please use up your available 80 characters per line in comments.
>>> >>>>
>>> >>> I will fix it.
>>> >>>
>>> >>>>> +            /*
>>> >>>>> +             * All "okay" hart should have same isa. We don't kn=
ow how to
>>> >>>>> +             * handle if they don't. Throw a warning for now.
>>> >>>>> +             */
>>> >>>>> +            if (elf_hwcap && temp_hwcap !=3D elf_hwcap)
>>> >>>>> +                    pr_warn("isa mismatch: 0x%lx !=3D 0x%lx\n",
>>> >>>>> +                            elf_hwcap, temp_hwcap);
>>> >>>>> +
>>> >>>>> +            if (hartid =3D=3D boot_cpu_hartid)
>>> >>>>> +                    boot_hwcap =3D temp_hwcap;
>>> >>>>> +            elf_hwcap =3D temp_hwcap;
>>> >>>>
>>> >>>> So we always set elf_hwcap to the capabilities of the previous cpu=
.
>>> >>>>
>>> >>>>> +            temp_hwcap =3D 0;
>>> >>>>
>>> >>>> I think tmp_hwcap should be declared and initialized inside the ou=
ter loop
>>> >>>> instead having to manually reset it like this.
>>> >>>>
>>> >>>>> +    }
>>> >>>>>
>>> >>>>> +    elf_hwcap =3D boot_hwcap;
>>> >>>>
>>> >>>> And then reset it here to the boot cpu.
>>> >>>>
>>> >>>> Shoudn't we only report the features supported by all cores?  Othe=
rwise
>>> >>>> we'll still have problems if the boot cpu supports a feature, but =
not
>>> >>>> others.
>>> >>>>
>>> >>>
>>> >>> Hmm. The other side of the argument is boot cpu does have a feature=
 that
>>> >>> is not supported by other hart that didn't even boot.
>>> >>> The user space may execute something based on boot cpu capability b=
ut
>>> >>> that won't be enabled.
>>> >>>
>>> >>> At least, in this way we know that we are compatible completely wit=
h
>>> >>> boot cpu capabilities. Thoughts ?
>>> >>
>>> >> There is one example on the market, e.g., Samsung Exynos 9810.
>>> >>
>>> >> Mongoose 3 (big cores) only support ARMv8.0, while Cortex-A55
>>> >> (little ones) support ARMv8.2 (and that brings atomics support).
>>> >> I think, it's the only ARM SOC that supports different ISA extension=
s
>>> >> between cores on the same package.
>>> >>
>>> >> Kernel scheduler doesn't know that big cores are missing atomics
>>> >> support or that applications needs it and moves the thread
>>> >> resulting in illegal instruction.
>>> >>
>>> >> E.g., see Golang issue: https://github.com/golang/go/issues/28431
>>> >>
>>> >> I also recall Jon Masters (Computer Architect at Red Hat) advocating
>>> >> against having cores with mismatched capabilities on the server mark=
et.
>>> >>
>>> >> It just causes more problems down the line.
>>> > > IMO the best bet is to only put extensions in HWCAP that are suppor=
ted by all
>>> > the harts that userspace will be scheduled on.
>>> > Fair enough. Instead of setting HWCAP in setup_arch() once, we can se=
t it only for boot cpu. It will be updated after every cpu comes up online.
>>>=20
>>> Thus, HWCAP will consists all extensions supported by all cpus that are=
 online currently.
>>=20
>> You must thus prevent CPUs that have a different set of capabilities
>> from coming up late (once userspace has started).
>=20
> and we have no way to do that.  I'd prefer if we just looked through the =
entire device tree and only showed userspace the features that are on every=
 possible CPU from the start.  Otherwise the HWCAP will shift around during=
 a userspace run, which seems odd.

ok. I will do this for now. Once we have cpu hotplug enabled, we can revisi=
t this.

Regards,
Atish=
