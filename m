Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC6CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03612087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Hbv4c2kC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03612087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeLCRMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:12:38 -0500
Received: from mail-bgr052101135021.outbound.protection.outlook.com ([52.101.135.21]:63186
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbeLCRMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amQzcAGUEvaMFcb/T/WNidBDvwcknd55u7O0Y4jT+oM=;
 b=Hbv4c2kCFK3nRQeY/5vWLVVS8mcH2L5BltwPdCJd37RUYzcad7pdYk33f9PJ3dBWLDUVD7TYxtg1v646hxS7p4oHsDSfiLM7KiVpmI8bqx3bbVorM1AOojQpXDZ9vq/eyD98psTnoSURNbUW6C19NTmUG7PwZMcvPvM8Mltg8Hw=
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) by
 VI1PR08MB3552.eurprd08.prod.outlook.com (20.177.61.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 17:12:24 +0000
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2]) by VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2%3]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 17:12:24 +0000
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
Thread-Index: AQHUhZ9mV1oam64KnkyNE5PKjfame6VtS3MA
Date:   Mon, 3 Dec 2018 17:12:24 +0000
Message-ID: <20181203171220.GA2886@rkaganb.sw.ru>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-4-vkuznets@redhat.com>
In-Reply-To: <20181126154732.23025-4-vkuznets@redhat.com>
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
x-clientproxiedby: HE1PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::17) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3552;7:qjET4bwBBRPho0RPiWc3dp7Tquaq6LAh/XsJZby8wecnobKfbGCrICPwcGBHe6goiiDCdA4kCH6p5lEHdY431E1UT+IzKiACc0PZ2ZeaHQB3YyGkTf1x5rP+fSD9xbfk8lVWKYdIA7kEo7FScPJQSg==;20:0YHaLiyJ9WtDkkGWuA4KAaUEQLuiBFpRp4RgPuxPJ2v+/qLDy7sljA365axtcCGq46sNgBR2+uc5HXZfBuUc6z9su6S2d3b34W4wC1UpDuX2na7D0UD0Tol2/feXdg2O+g1SKta1a/izhy9F5E/F519PPMPk36fjybirfynEZLg=
x-ms-office365-filtering-correlation-id: 1d7ec5d4-e572-4c54-43d1-08d659427e38
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3552;
x-ms-traffictypediagnostic: VI1PR08MB3552:|VI1PR08MB3552:
x-microsoft-antispam-prvs: <VI1PR08MB3552883AEDF393E7544CFEC1C9AE0@VI1PR08MB3552.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB3552;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3552;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(376002)(366004)(346002)(39850400004)(396003)(136003)(189003)(199004)(386003)(68736007)(6506007)(7736002)(1076002)(52116002)(7416002)(6116002)(3846002)(99286004)(305945005)(5660300001)(106356001)(105586002)(6512007)(14454004)(316002)(86362001)(25786009)(58126008)(54906003)(8936002)(2906002)(6916009)(9686003)(36756003)(476003)(71190400001)(71200400001)(486006)(6486002)(102836004)(4326008)(33656002)(8676002)(81166006)(446003)(66066001)(26005)(229853002)(14444005)(256004)(6436002)(6246003)(33896004)(97736004)(76176011)(81156014)(53936002)(11346002)(186003)(478600001)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB3552;H:VI1PR08MB3599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BYPRyVQFfDnBoFn3J76duDPIs5PsS/WRdte/QH0kBITx+HV09idsNobIK6GSq0KxBVAlAxYnsLCz0AxygnFq/GLDkPZpJcOHYcp0RrHUAojNNHVtyqw7v4zQoTTS31NHwjiXJNzbFleRZ8DK0y/duZUzU3gCV65+nNoc9vR3U9tfWETkHq3M3QXmo02izjDzL4zwQ1MlmRqUyrr2KNxOyeD/HyHHrtMGirUBkf9FeRf4fFiDHr3hhoAXBUduFTDJtT/4bVXBmYcSSFpp+YewtLYTWu/QSRfSm8BjCdLAqGTCiCl/mA7Yn09X8upA89R6hVLMU3dtF3iSxqXlxReb+S1NkqIHEdlrnrxB1blzawuxBI+oxY1cF90436T3D5woz2yXBOAbvJi91e/ape8tqA93cY0qKiCnmzQrA0SztQ2G42B0duDQLyH4wYW7V4+BFzHMf4KLWIj+LXLVltmT/2muEzT7irI7QBjQn/4G7eEFd2wqsAT6Bx6U2YmKGP2ervdoeWSm+Yjh4CQrnyt8SboJo3mgWGsgHkybbvsBQo0=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <D3BD3015D0CEFD49BEEEC476EC243099@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7ec5d4-e572-4c54-43d1-08d659427e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 17:12:24.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:47:31PM +0100, Vitaly Kuznetsov wrote:
> @@ -379,6 +398,14 @@ void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, in=
t vector)
>  	for (i =3D 0; i < ARRAY_SIZE(synic->sint); i++)
>  		if (synic_get_sint_vector(synic_read_sint(synic, i)) =3D=3D vector)
>  			kvm_hv_notify_acked_sint(vcpu, i);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
> +		stimer =3D &hv_vcpu->stimer[i];
> +		if (stimer->msg_pending && stimer->config.enable &&
> +		    stimer->config.direct_mode &&
> +		    stimer->config.apic_vector =3D=3D vector)
> +			stimer_mark_pending(stimer, false);
> +	}
>  }

While debugging another issue with synic timers, it just occurred to me
that with direct timers no extra processing is necessary on EOI: unlike
traditional synic timers which may have failed to deliver a message and
want to be notified when they can retry, direct timers just set the irq
directly in the apic.

So this hunk shouldn't be needed, should it?

Roman.
