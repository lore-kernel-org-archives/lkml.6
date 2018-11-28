Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F72C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14383208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="HyMO4rB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14383208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeK2BtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:49:18 -0500
Received: from mail-eopbgr740043.outbound.protection.outlook.com ([40.107.74.43]:18657
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728000AbeK2BtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3amlWb5TZ5OdVufEoNwWSmZFnDgAO15hLkvDEz5SO8=;
 b=HyMO4rB9KgOoGuq88awL7MQw3beiZYwJzfKhpx8dhF1LxK4r+j8V7VvlHIpdb3EfH70+kls63PArZAVr1u3VvyptzMi3H+eIqKkoBz3oB4smWaqmSLdV9k4aUfeZzIGXzkHEiKyMDs8BfMI5mNRawr+j+OgCpUvLxTv/el8Xkbs=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB4496.namprd07.prod.outlook.com (52.135.93.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 14:47:19 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::ccc7:d111:7f3d:667d%4]) with mapi id 15.20.1361.018; Wed, 28 Nov 2018
 14:47:19 +0000
From:   "Richter, Robert" <Robert.Richter@cavium.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        John Garry <john.garry@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] irqchip/gic-v3-its: Use CMA for its table allocation
Thread-Topic: [PATCH 0/2] irqchip/gic-v3-its: Use CMA for its table allocation
Thread-Index: AQHUfS1KKJ7l48455Ey90kOzGtmdX6VlWCMA
Date:   Wed, 28 Nov 2018 14:47:19 +0000
Message-ID: <20181128144712.GI4262@rric.localdomain>
References: <20181115215012.23922-1-rrichter@cavium.com>
In-Reply-To: <20181115215012.23922-1-rrichter@cavium.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::42) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.14.124.106]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4496;6:VgisIXpGm6nhbTC2JmxOe6gx33JUKyXxy+9jnRFIeEq+FWKYLW/Z3g0zY5b8KbYcd/ZX9pnVRPY+lAmsAqD+rDdYruFP79+eOjNLgY8SuaQ1S7GLdx1l4prJXTZKBY78NImMmlkptzw2xXFC4cRz8e7/0YTf/WxvPOYFWYl3baBn773QqDFlrul/GKq2mMerHq03ZeadVRiLf2eT1TQnUOJEqabhZzzueXxeRUry8VoKaU7hFI6wVDgmy23rieSIHVi0gTb72P/YgmXf9X5HtqDNV9vHp6leehrHWy59Xw21BwiwCS5RHY+iV+iLmddwhY3uCyxKLxnCSQBhNw34AiiViQyIe573BL9+YJWle5+Wqr3ky3GJTBUP7EWIKnYzdDhc28PtFMtpCaBgrlKEgRbjfzxHWMl6CCTQJuzhIB/IZg2kOlTCxUtx9KisPA+ZTTcLi2gTVbYRrIfaM3pf5w==;5:2jpZ5Xje0ZPNfz5OoMz2xeIsCJGm9dGbtXsqES7VIBno68Xc+1YsOb7lqh743O4q+9+guazGoMdfiaoVhd4vyRG0aIZZhJ4GrZZcLpuiFStKVNQtB4ewvK90A3KmKAuDDhzTN7XgdPdrXCUVJLsc0RB83CnJbT9UMysZGQO0Ymw=;7:PlcveF/J+5IpACjjW2dftAYSnrDU8Cqze4jgd9UqfaLbCrIKM4YYm9vP4FAnVjfnM1olryAWD8U7lphThfp8RMJnA478ZE7xvg6GeIvkOqb0w19OOmDSkDvv4yz36ZyQIh3dTlv0DwK8qgcqKo6fJg==
x-ms-office365-filtering-correlation-id: 41a45f2b-e212-438d-e5bd-08d6554065b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4496;
x-ms-traffictypediagnostic: SN6PR07MB4496:
x-microsoft-antispam-prvs: <SN6PR07MB4496BBE6AB327553AB8E663DF1D10@SN6PR07MB4496.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB4496;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4496;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(366004)(136003)(189003)(199004)(53936002)(229853002)(305945005)(6246003)(11346002)(4326008)(14454004)(39060400002)(6506007)(6512007)(9686003)(6306002)(7736002)(3846002)(71190400001)(476003)(966005)(25786009)(1076002)(386003)(71200400001)(54906003)(110136005)(316002)(486006)(97736004)(446003)(33656002)(72206003)(6116002)(26005)(6436002)(66066001)(5660300001)(106356001)(105586002)(186003)(256004)(2906002)(76176011)(99286004)(8676002)(33896004)(81156014)(102836004)(81166006)(53546011)(86362001)(52116002)(68736007)(478600001)(7416002)(6486002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4496;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1G0hyrsd3jU4Szd9M1gyG1+tD2aRunZqSU9ZNOe8a9FUVdF1UYUedwK4Qj46ejhh+lTBTWHCkrH4O6qMFReK1QwEyIf0cyL7hySr467Qz+YRMn8CVlbViZuXrFdmVpzneRpGmd8liZcf5tIa9UrH7knUWDmTtVZy/vlHhw1dBEc3sFtRmMqlh+P7Atf48P56LyJ8D6hBd7f+mPbXnic2oU+iB8Je0+/N6lDPx7Cgf07mA6rXHarL3CgtVQogkdwqT2f2G1f847UN0lDs1YxUOlwUaR/8G3FTWTB4wbk0AW5PJ4UnNlGCg5X5Y2GkWnDss0zgM36kERBsQ0xqF+uQXSynQwf1VbPmtewnbPD5Kb8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17BBB4C26FD3224B92A4F57AFD1B1EC5@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a45f2b-e212-438d-e5bd-08d6554065b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 14:47:19.6475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.18 22:50:57, Richter, Robert wrote:
> The gicv3-its device table may have a size of up to 16MB (Cavium
> ThunderX). With 4k pagesize the maximum size of memory allocation is
> 4MB. This series implements the use of CMA for allocation of large its
> tables. To achieve this we need to make an its node a kernel device
> (patch #1) and rework the its table allocation code (patch #2). Both
> can only be done after the arch_initcall and thus this patch series
> bases on my previous series that implements late its initialization:
>=20
>       https://patchwork.kernel.org/cover/10673117/

I just sent out v2 of that series:

 https://patchwork.kernel.org/cover/10702781/

This series should be still compatible.

Any comments to this series?

Thanks,

-Robert

>=20
> Using its nodes as kernel devices has the side effect to ease the
> release of resources (devres used) and device based messages (dev_*
> printk variants used).
>=20
> The new its table allocator still uses the old scheme for small tables
> to allow a further rework that supports NUMA-aware its tables.
>=20
> Robert Richter (2):
>   irqchip/gic-v3-its: Handle its nodes as kernel devices
>   irqchip/gic-v3-its: Use CMA for allocation of large device tables
>=20
>  drivers/irqchip/irq-gic-v3-its.c | 224 +++++++++++++++++++++++----------=
------
>  1 file changed, 135 insertions(+), 89 deletions(-)
>=20
> --=20
> 2.11.0
>=20
