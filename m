Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785A2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3427A20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QbP2x2qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3427A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeLMMRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:17:38 -0500
Received: from mail-bgr052101130037.outbound.protection.outlook.com ([52.101.130.37]:6308
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728860AbeLMMRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3vMSgYp2qfTuw9XDhtrN+dRcIW8HaruF1dKNNyWjz4=;
 b=QbP2x2qhr+NYDZNfQG/65JvGqaeF7tnh5Ya0YLcom6TRn6WrPTmeME4GVhH8OLxid0CzbJfT3zS49bxk1CV326qCLSBFGHRytVnnj6L2bFof9j+CLGGSIlaLoKnD1tCD/KqSCSz0B5w9ceNZxbDh4ntqus/gg0k6tvZCMajphXs=
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com (20.179.10.210) by
 DB8PR08MB4012.eurprd08.prod.outlook.com (20.179.9.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Thu, 13 Dec 2018 12:17:26 +0000
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d0e0:ff54:c6fe:1407]) by DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d0e0:ff54:c6fe:1407%3]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:17:26 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] x86/hyper-v: Stop caring about EOI for direct
 stimers
Thread-Topic: [PATCH v2 1/2] x86/hyper-v: Stop caring about EOI for direct
 stimers
Thread-Index: AQHUkjrHjHKyrPOUG0Sh6Y24a/reJKV8lyWA
Date:   Thu, 13 Dec 2018 12:17:26 +0000
Message-ID: <20181213121722.GA2474@rkaganb.sw.ru>
References: <20181212165017.13278-1-vkuznets@redhat.com>
 <20181212165017.13278-2-vkuznets@redhat.com>
In-Reply-To: <20181212165017.13278-2-vkuznets@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
mail-followup-to: =?iso-8859-2?Q?Roman_Kagan_<rkagan@virtuozzo.com>,=09Vitaly_Kuznetsov_<vk?=
 =?iso-8859-2?Q?uznets@redhat.com>,_kvm@vger.kernel.org,=09Paolo_Bonzini_<?=
 =?iso-8859-2?Q?pbonzini@redhat.com>,=09Radim_Kr=E8m=E1=F8_<rkrcmar@redhat?=
 =?iso-8859-2?Q?.com>,=09linux-kernel@vger.kernel.org?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1P18901CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::22) To DB8PR08MB4092.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB8PR08MB4012;7:MQwtfGhssLt1cg6hhqkILD8vVE9StbmhvQjLvUrKf/Fx3PRPXVm7fukXyfUj5oBCz4JdM70tHHA72RWZLEtbb8ZNuOW980OF+Dg7LjC9D92emNLGJAZ2dddgeiB7uiMOpgYYru4dtanECy37qwHJqw==;20:emgIz/VXbQENYuWiwwN2+PCrfoojNoHUa5R7P2fd7epD15gbzvu8lAWuGHXS7pFQ4c414UmBF5mMNNHA/zTV228KCHD9Gn5qeLFv5f/Fbo2So+/Sc2c+CrnfSFMWxCdb5obtnOIzOH/R12EeeursrQjJYadog9dYcB08LSalTWk=
x-ms-office365-filtering-correlation-id: 36ddad59-e7d2-4eb8-a34e-08d660f4f1a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB8PR08MB4012;
x-ms-traffictypediagnostic: DB8PR08MB4012:|DB8PR08MB4012:
x-microsoft-antispam-prvs: <DB8PR08MB40129E31063EC236C78D0DB6C9A00@DB8PR08MB4012.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB8PR08MB4012;BCL:0;PCL:0;RULEID:;SRVR:DB8PR08MB4012;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(136003)(396003)(39850400004)(366004)(376002)(346002)(189003)(199004)(71200400001)(68736007)(58126008)(186003)(386003)(86362001)(102836004)(4326008)(71190400001)(33896004)(6506007)(26005)(105586002)(2906002)(54906003)(316002)(53936002)(97736004)(6116002)(6512007)(9686003)(1076002)(14454004)(6246003)(106356001)(36756003)(8676002)(5660300001)(478600001)(8936002)(81156014)(14444005)(6436002)(3846002)(81166006)(229853002)(256004)(7736002)(25786009)(99286004)(33656002)(6486002)(52116002)(446003)(66066001)(11346002)(476003)(486006)(6916009)(76176011)(305945005)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB8PR08MB4012;H:DB8PR08MB4092.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yuTK6m6oAefHNDYqB6/SLjnCYZSEqtYi4dFgJz5Gk78MYRHWORNOUucn5jVtCXJCZhNws3SYCjMmV3rzA/FUnMgpQN6wps6hwIAXrhzNpLAaV9nbIJPCLYBHXtqyOgynd5TrOQRnaHS/JHXs7iBJZuHc7SPaQsQ6c7Uztwikq2wWw39D+i82TS/UNU/gGIgcjiCrHPGqS2FDiF/nwp2lclqrBuwkl9CurVRIbBBGQIC+loZydKjwUL3hdZHtxg/W3xhNr1rPEgKQSIefW2a6CNU3VmZ85GLE7wkT6mIHmtkicGzWK79F0EyNH0v0U2oNlcZgSEBa3EXNjBtInduyQQ8W7itpPBjuuwF/8WDURNGBjVxDBTjo4xrwTIFmJiDqbR08ZQ98EAxZqu5qYWKGDB1m7RYi9yVWJwMUbcdDivaz2Jex0C4bD3VPBLYf2EO4XLPODZgqNLw0FYPEtNnGdcVzz4F6tnQtqddBXW+ZAwq4KOfcvZX9exG1CmTmmCR/
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <FC58DB73E47BEF4D9E8B33E90E27BD71@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ddad59-e7d2-4eb8-a34e-08d660f4f1a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:17:26.3724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 05:50:16PM +0100, Vitaly Kuznetsov wrote:
> Turns out we over-engineered Direct Mode for stimers a bit: unlike
> traditional stimers where we may want to try to re-inject the message upo=
n
> EOI, Direct Mode stimers just set the irq in APIC and kvm_apic_set_irq()
> fails only when APIC is disabled (see APIC_DM_FIXED case in
> __apic_accept_irq()). Remove the redundant part.
>=20
> Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 36 +++---------------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
