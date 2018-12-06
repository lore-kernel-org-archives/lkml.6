Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9FBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEF5208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GKn16Qt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEF5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLFUmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:42:08 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17170 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFUmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:42:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c09899c0001>; Thu, 06 Dec 2018 12:42:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Dec 2018 12:42:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Dec 2018 12:42:05 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 6 Dec
 2018 20:42:05 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.56) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 6 Dec 2018 20:42:05 +0000
Received: from BYAPR12MB2712.namprd12.prod.outlook.com (20.177.124.13) by
 BYAPR12MB3543.namprd12.prod.outlook.com (20.179.94.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 20:42:04 +0000
Received: from BYAPR12MB2712.namprd12.prod.outlook.com
 ([fe80::2c34:273b:59ad:23d6]) by BYAPR12MB2712.namprd12.prod.outlook.com
 ([fe80::2c34:273b:59ad:23d6%2]) with mapi id 15.20.1404.019; Thu, 6 Dec 2018
 20:42:03 +0000
From:   Alexander Van Brunt <avanbrunt@nvidia.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Ashish Mhetre <amhetre@nvidia.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sachin Nikam <Snikam@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
Thread-Topic: [PATCH V3] arm64: Don't flush tlb while clearing the accessed
 bit
Thread-Index: AQHUb2mK2jioXCSBXUOglXMUWPpsLKU2DOwAgABGE2iAN2VlVIAEmdOAgAAC4fGAABP4tw==
Date:   Thu, 6 Dec 2018 20:42:03 +0000
Message-ID: <BYAPR12MB27120C304F7B085A0CA36124CFA90@BYAPR12MB2712.namprd12.prod.outlook.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
 <20181029105515.GD14127@arm.com>
 <BN7PR12MB2708B742FD3448589AD0F259CFF30@BN7PR12MB2708.namprd12.prod.outlook.com>
 <BYAPR12MB27129A4EE7BBF57B1CAB5094CFAE0@BYAPR12MB2712.namprd12.prod.outlook.com>,<20181206191850.GC20796@arm.com>,<BYAPR12MB271239AAF4A0B79D756850C6CFA90@BYAPR12MB2712.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB271239AAF4A0B79D756850C6CFA90@BYAPR12MB2712.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=avanbrunt@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3543;6:3PVKS+sj5skgIwxTcp71epOabV76F5izuZczXoEjdqWymoW719nfHnUcBFueVtbGKs8f7Sc1ZR2o6ehd9JOOL9Dtd0GmIvqT/0DnZoq7ee2ed6SarxHUJlMvuWVV9YIhEW5zyanOfNvt0cDc/aJlrChwJszfvazhqM00KJAw/bu0AXbWSCuxSBInw5Vntm6kaeldxgTOU5BENf15t5wM0I6R8WMd0lLup0q7Rl8oFXVcVztnAEu4baNSb0bBI24DfSq4T7kie07uueMQbpGZxr7k/vkGjXr18YrkjGdrUmDVF5uXrV+8eirv+vH5zkxg85dohmphk2V7SWs8EPi/UWTYJ7UcLpqvCj83Y2wuMBjJdaaryQ4p1dKEqT+utaAuva2/1Qziw/Pvg0yWqqb5YdCgNqTSuBiSEOAl3CNijqyI+oNXfZ3xKyzBwnG5HeHzMNG7g/P/eEeiu12DPoYy0w==;5:jOn5KvnXq7y8msSUPDajB1YT2yENR1n4M5+SuoxrvCzxBeRvSDVTG7YBmmxnXGnC5ukIfDboGDNNGaZ8kBA3hqj2HJqHvwyqh2zv1zpOxPijM//MttIWuuRoJ7jSSrBvkJTsesIQ4Ovn5at/tuImYZEKO+x1X020h1dPCjjpVvw=;7:mqJ/JBMUBR1V2etR234FqHztuGP8ZBHryrDqPcmKgu37qdjV/Jaa/5zd20ctjHMQwoIdjDoPsJbKtERQH7J7whO57fEOe68OreWneSbLkLOv+Wxjz/rER/c/mgQg3tSJGy1L7lzQp5J4tJWJMgNVfQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(366004)(199004)(189003)(14454004)(93886005)(81166006)(478600001)(93156006)(68736007)(106356001)(55016002)(71190400001)(71200400001)(81156014)(316002)(8676002)(2906002)(54906003)(2940100002)(486006)(446003)(5660300001)(86362001)(476003)(76176011)(6436002)(8936002)(11346002)(102836004)(6916009)(229853002)(7696005)(105586002)(99286004)(256004)(9686003)(6116002)(25786009)(66066001)(3846002)(6506007)(74316002)(26005)(97736004)(7736002)(53936002)(14444005)(4326008)(6246003)(33656002)(305945005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3543;H:BYAPR12MB2712.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: c612f387-613d-44a6-d365-08d65bbb4791
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3543;
x-ms-traffictypediagnostic: BYAPR12MB3543:
x-microsoft-antispam-prvs: <BYAPR12MB35439726AD66429D4A80B036CFA90@BYAPR12MB3543.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR12MB3543;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB3543;
x-forefront-prvs: 087894CD3C
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8sFIffQtGXh+9EnhkuMjqr29gGtyA6oe/yI2opgEvgdR/hjuG2B72Yotvha4EoXuMO/eFh4PunwDjZXWGINQD5/mA+oofahLVKABRFLNxOuE+J/3QuN7hquIdbTOO/R9qxFhrCLyWweKICGT/XbT7x0UWrBviyO296AI9iDLHYBDVwKQpii9eZdWZ61+FDwoe7a7DldlzgEASOYaJwN1IkMDF2VF/nO5/yrBYrnrEXKyNCvQuEOMCo8i28UI8iEiiAew4KpZ8HkAbBgwyyRB1kIesamOdU3Q31p6FLIBliScnDN2rXiH1g1uckxPCuNiJDv4pvWIEF+S134EW4gjCrbZ4PreU5INrPgj8w1Oj80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c612f387-613d-44a6-d365-08d65bbb4791
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 20:42:03.5293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3543
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544128924; bh=1uMhDSNOvnaphndMUqo9jMVAJCi++zN1c8Ilihedq+k=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-exchange-senderadcheck:x-exchange-antispam-report-cfa-test:
         x-forefront-prvs:received-spf:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=GKn16Qt/WohOQAqnsjKgCHgGf2CcHE3+KjWrhkLKPt+g0L+ukcgPt5AygoRCxz1rb
         xI5sYy/bYpV4LU2hBoYTVPFXWVysivLebKHUKzwiAED5w8hGxm+eU+HNp8Tyc8HaP6
         r4jYxKyl9l7HIaP6y4mFarh3jgqq4bof1zav9LosXLQgFBXTVQlzm90V09X5fLMNSd
         WrmxM/cExbrDdouTBuxr5wy6Q+yczWaL24XgJpMTGMRkUWd8NLBWfTqXc75qt9nmu8
         7WZ7dvITf0FF+8jpA1KiuOi7Iou8EcaftAIRXds9HOhA8fbA1Oyq0Vz24Tu8S70sHr
         Sj7TCC/X6faQg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >=A0If we roll a TLB invalidation routine without the trailing DSB, wha=
t sort of
> > >=A0performance does that get you?
> >=20
> > It is not as good. In some cases, it is really bad. Skipping the invali=
date was
> > the most consistent and fast implementation.

> My problem with that is it's not really much different to just skipping t=
he
> page table update entirely. Skipping the DSB is closer to what is done on
> x86, where we bound the stale entry time to the next context-switch.

Which of the three implementations is the "that" and "it" in the first sent=
ence?

> Given that I already queued the version without the DSB, we have the choi=
ce
> to either continue with that or to revert it and go back to the previous
>=A0behaviour. Which would you prefer?

To me, skipping the DSB is a win over doing the invalidate and the DSB beca=
use
it is faster on average.

DSBs have a big impact on the performance of other CPUs in the inner sharea=
ble
domain because of the ordering requirements. For example, we have observed
Cortex A57s stalling all CPUs in the cluster until Device accesses complete=
.

Would you be open to a patch on top of the DSB skipping patch that skips th=
e
whole invalidate?=
