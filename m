Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F20C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665C02086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Nba5vuHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665C02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbeK0Tqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:46:54 -0500
Received: from mail-bgr052101134010.outbound.protection.outlook.com ([52.101.134.10]:59647
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729387AbeK0Tqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ri5Sgr+Ey2cSxQ+3WFURkXoqsubprMxIGim6vov370=;
 b=Nba5vuHAaY+XpBMsQ1DxPFPcT/inqq7gJBTV9Gplz7b6qW8d46kvqHD6ihvURTJfPN7LobrcWIuBIYzR2fxDUEoz4vudDn88TnOSgLfqrX0pFX1mndSsT/nAsGR4g2Kx9jp9LaMeiJiucZWsFi0wIjkyO8oOr9nivR5TK2MUojY=
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) by
 VI1PR08MB3760.eurprd08.prod.outlook.com (20.178.14.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Tue, 27 Nov 2018 08:49:33 +0000
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2]) by VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2%3]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 08:49:33 +0000
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
Subject: Re: [PATCH v2 4/4] x86/kvm/hyper-v: avoid open-coding
 stimer_mark_pending() in kvm_hv_notify_acked_sint()
Thread-Topic: [PATCH v2 4/4] x86/kvm/hyper-v: avoid open-coding
 stimer_mark_pending() in kvm_hv_notify_acked_sint()
Thread-Index: AQHUhZ9o3da6WPit0kW17k8z1cvR2KVjUPiA
Date:   Tue, 27 Nov 2018 08:49:33 +0000
Message-ID: <20181127084929.GC16047@rkaganb.sw.ru>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-5-vkuznets@redhat.com>
In-Reply-To: <20181126154732.23025-5-vkuznets@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
mail-followup-to: =?iso-8859-2?Q?Roman_Kagan_<rkagan@virtuozzo.com>,=09Vitaly_Kuznetsov_<vk?=
 =?iso-8859-2?Q?uznets@redhat.com>,_kvm@vger.kernel.org,=09Paolo_Bonzini_<?=
 =?iso-8859-2?Q?pbonzini@redhat.com>,=09Radim_Kr=E8m=E1=F8_<rkrcmar@redhat?=
 =?iso-8859-2?Q?.com>,=09linux-kernel@vger.kernel.org,=09"K._Y._Srinivasan?=
 =?iso-8859-2?Q?"_<kys@microsoft.com>,=09Haiyang_Zhang_<haiyangz@microsoft?=
 =?iso-8859-2?Q?.com>,=09Stephen_Hemminger_<sthemmin@microsoft.com>,_x86@k?=
 =?iso-8859-2?Q?ernel.org,=09"Michael_Kelley_(EOSG)"_<Michael.H.Kelley@mic?=
 =?iso-8859-2?Q?rosoft.com>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0101CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::11) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3760;7:gELVKQKaBiWkT8YcayoWsIiLD0e3H7GfMEmkkZAdAML0iGbzEDQPRx88sfzuNULusAeicgPIalOYQ3PSY+6LtkSficSYYcw7UlhXv1cKYu4QeLznBx6swmvr8mOCx1rIriF34Lb5CZ7W1ovM4RJ6jA==;20:p5mfOhKcUlXXmvdy6wf1awjL+ShSnSQYRIEh43/CVxbWqOBUHmNAqTMxO9Z/vBwKPKDvET805UQ1PQIBLwbmJA/sjViSevBbRgJNqSegK3xgJbbjLsIGeucx1Pu51vHrWnbE8RS4wWIT1iVWXYkuN5NCDSloa9Li6n+lUQOqICQ=
x-ms-office365-filtering-correlation-id: 2dc69142-4fe3-4af6-367f-08d654454068
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3760;
x-ms-traffictypediagnostic: VI1PR08MB3760:|VI1PR08MB3760:
x-microsoft-antispam-prvs: <VI1PR08MB37607052F27FD7C71B93FDC4C9D00@VI1PR08MB3760.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB3760;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3760;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39850400004)(136003)(189003)(199004)(97736004)(33656002)(8676002)(316002)(305945005)(7736002)(3846002)(6116002)(54906003)(8936002)(81166006)(81156014)(1076002)(7416002)(58126008)(229853002)(6916009)(6246003)(6486002)(478600001)(53936002)(9686003)(6512007)(6436002)(106356001)(25786009)(105586002)(36756003)(446003)(4326008)(11346002)(6506007)(33896004)(386003)(186003)(476003)(102836004)(26005)(14454004)(486006)(2906002)(68736007)(52116002)(76176011)(86362001)(99286004)(256004)(14444005)(5660300001)(66066001)(71200400001)(71190400001)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB3760;H:VI1PR08MB3599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9MfdbaLx9wxLHgH5V4NrwrfPZPkp1KSiO1WAOoS2DqXqTGZf6nuetmtmkL531Hs7Hss2VD6yPIGx+KZSpUwRMOX6q1+O5XzjsEpHiwRF9/x/MawZ/HXPZ68f7VO19he1CvN0BMTOo8wUgA4nzwPgzAw7B6kGjgElNUsBywxoWQJfx15BZxIx3GYWXWXf1y5P6Dt1Bk6wzo6MIXuLY1ZuNpQqMItRrGD2zwRejWNP4up+QR8Y2T9mF+E7wD3gc1MteSdRngE23ibqT2o4RppoRImFkqmqPcNDYgrC2RV9YA9Z+6Gg3Ah98Hq/OoKdHR/0YkqCgqTorNNvb06EeUfrIaHsv7vu9UZFtZfOXJ/iw0cROl6saA5Jrdk5XEBiGeyevVQ6ahE86ny9F0MYRuyTix4B/TBu/KxNu1DkbD4OIhPSd/qeYA7hcfph1nqO1UKO3aPItdOMVlZ5peX90zgCwuPR9//5USiTyfwUKMf4JaTuRCQ3rzHGgQYNYhLFlFRE2+a/Nrw8vTFhvz26hWpL538XQHzqjAe3Zxwmo0jBiJw=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <8C552FE84A789F4DA16FF4CA64DEB5E4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc69142-4fe3-4af6-367f-08d654454068
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 08:49:33.4595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:47:32PM +0100, Vitaly Kuznetsov wrote:
> stimers_pending optimization only helps us to avoid multiple
> kvm_make_request() calls. This doesn't happen very often and these
> calls are very cheap in the first place, remove open-coded version of
> stimer_mark_pending() from kvm_hv_notify_acked_sint().

Frankly speaking, I've yet to see a guest that configures more than one
SynIC timer.  So it was indeed a bit of overengineering in the first
place.

> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
