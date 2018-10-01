Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13E1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAA820C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="asqNesoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAA820C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeJAWgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:36:03 -0400
Received: from mail-ve1eur02hn0209.outbound.protection.outlook.com ([104.47.6.209]:35909
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725266AbeJAWgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeO9BaRd4eA3Oh3FQJfuasYBPFiyJQoYPRQoS6NGcBs=;
 b=asqNesoNRG+vPNUz5NsgNe0qm7nOzS+hklO8i7+S8Pp/L/XRR+ibv3mTRcI2qRWH0oBDL85Kzp+xw7RtHdZMj58Lk8b26g06VGB2gYJNJHIQNVgEmMlXGxSxXs4mNAs9lWhSC8AoiwwkZw+wQkbWHuh2i1zdF0ZvubyE9c5KVkw=
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) by
 VI1PR08MB0976.eurprd08.prod.outlook.com (10.166.143.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Mon, 1 Oct 2018 15:57:19 +0000
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::d453:c2b:518c:b64]) by VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::d453:c2b:518c:b64%3]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 15:57:19 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/7] KVM: x86: hyperv: keep track of mismatched VP
 indexes
Thread-Topic: [PATCH v6 4/7] KVM: x86: hyperv: keep track of mismatched VP
 indexes
Thread-Index: AQHUVbrTeaVBNfWXhkKXGMfpSWKXvqUD9seA///juoCABraMAIAAM8eA///OjwA=
Date:   Mon, 1 Oct 2018 15:57:19 +0000
Message-ID: <20181001155715.GA9741@rkaganb.sw.ru>
References: <20180926170259.29796-1-vkuznets@redhat.com>
 <20180926170259.29796-5-vkuznets@redhat.com>
 <20180927075911.GB4186@rkaganb.sw.ru> <87sh1vfge0.fsf@vitty.brq.redhat.com>
 <d39dcde2-695e-019e-419f-60ce3712eff3@redhat.com>
 <20181001155413.GA2314@rkaganb.sw.ru>
In-Reply-To: <20181001155413.GA2314@rkaganb.sw.ru>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
mail-followup-to: =?iso-8859-2?Q?Roman_Kagan_<rkagan@virtuozzo.com>,=09Paolo_Bonzini_<pbonz?=
 =?iso-8859-2?Q?ini@redhat.com>,=09Vitaly_Kuznetsov_<vkuznets@redhat.com>,?=
 =?iso-8859-2?Q?=09"kvm@vger.kernel.org"_<kvm@vger.kernel.org>,=09Radim_Kr?=
 =?iso-8859-2?Q?=E8m=E1=F8_<rkrcmar@redhat.com>,=09"K._Y._Srinivasan"_<kys?=
 =?iso-8859-2?Q?@microsoft.com>,=09Haiyang_Zhang_<haiyangz@microsoft.com>,?=
 =?iso-8859-2?Q?=09Stephen_Hemminger_<sthemmin@microsoft.com>,=09"Michael_?=
 =?iso-8859-2?Q?Kelley_(EOSG)"_<Michael.H.Kelley@microsoft.com>,=09Mohamme?=
 =?iso-8859-2?Q?d_Gamal_<mmorsy@redhat.com>,_Cathy_Avery_<cavery@redhat.co?=
 =?iso-8859-2?Q?m>,=09Wanpeng_Li_<wanpeng.li@hotmail.com>,=09"linux-kernel?=
 =?iso-8859-2?Q?@vger.kernel.org"_<linux-kernel@vger.kernel.org>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: VI1PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:803:64::39) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB0976;7:wWdb4hxSO771c3UZPU6wuEffqKXMRL3HBZtqCVdtRZVktaOzatZl4xQTH4HPLYCuqkUgnGCDjJASEnxzoFRL70/apzhGP1PpdfAtB1WgU5reL87UKHKmrINzzEudT31QjO5AMkUtyLrySf7pSvy3YWN+z1vi1UpflVnb5YqQKpYimzkbmwPQ1eq5ppndw6qEbi7A8e9qfA+bv/Z6d/x8NPhgTeB2++Oqn7jyCubUHalXJ7IjobAtkB3Bkn+/p6mv;20:19Lx/27ULIAHCmgvxASRvY3mlgWV1gOmWH5u/k6VCf6jRGQdD8uX1lsNlIhYLpFd6hn2V5rm0r3Lol2orpNeDROhcQRR1S5vOz+BwzuZw+dyITjJiiVD4jTurNZSu/MBFza41bhJbX5RobjJvzL2b1/9KhXRvJrGQvA2p6sVwo0=
x-ms-office365-filtering-correlation-id: f6c6d01c-7902-419e-ae1a-08d627b6912c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB0976;
x-ms-traffictypediagnostic: VI1PR08MB0976:|VI1PR08MB0976:
x-microsoft-antispam-prvs: <VI1PR08MB0976B8235F432AB9D1D4BCB0C9EF0@VI1PR08MB0976.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:VI1PR08MB0976;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB0976;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(136003)(39840400004)(366004)(346002)(376002)(396003)(189003)(199004)(106356001)(81166006)(7736002)(39060400002)(305945005)(6436002)(71200400001)(71190400001)(4326008)(8936002)(76176011)(7416002)(33656002)(11346002)(81156014)(34290500001)(33896004)(478600001)(25786009)(52116002)(6916009)(53546011)(8676002)(6506007)(386003)(58126008)(36756003)(54906003)(5660300001)(68736007)(446003)(6486002)(66066001)(102836004)(186003)(26005)(2906002)(316002)(476003)(3846002)(53936002)(14454004)(5250100002)(486006)(229853002)(99286004)(6116002)(256004)(2900100001)(6246003)(105586002)(86362001)(97736004)(6512007)(1076002)(9686003)(93886005)(14444005)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB0976;H:VI1PR08MB3599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +aA048iI44e8k0Bh4Pi/hDrtHTlViBYj8g9WASQos49ifCrm8IQQ3y3T5yhm9RhxzB6QTAixO3vLYVTEs1b+3pyT1PSMmLoQZ29k8Rtn7sJANQLwfrVUEqTJ0Knvwuy5ilXEHvaUhYrASdbbtMIwybVzPc4K2ne8LmdZR+7bLX4BXfwX89JxNt7JCnmyRSP/h5qRmg4JMqkNC2NBQoWd7VsKw3HU+05ma/zJouZst0OYg06rz+JnS+zWeglU4JKdu8SCvN6v+ZAP8gBtd0DPB9AWOb5y8LSbJWjgn7PfbmiO702ZeSj8oNc6UgCFQeP4zn6HrYXZu0cUcsJBThbOVlQvtrLrlzZqyy6EiGg+yAl0ZdVjVU+I/fbBiPPvWchO0X3uIAXy/sw3PvtaAhaPkVkRFlJnIiFJLWUFzTAJzb7tHlCHtoHLpOWgV0xyzALlEyUw/WKK+H8kYATjphTSktM0+8yv8Fpqpj12x36IZkDbRiy3MhqCv+Hn9HqO+9CQTHlZwU1NghnWufolf7fyKQVXC1uEpMJQgSrNjNyC2ji+Oojsm2qcb+Hd6NQ9LSDEaAZzaE6++UHxVmJZNVw2pA==
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <27DFC9A6DD8D9E47B8CD2D6995558702@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c6d01c-7902-419e-ae1a-08d627b6912c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 15:57:19.6161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0976
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 03:54:26PM +0000, Roman Kagan wrote:
> On Mon, Oct 01, 2018 at 05:48:54PM +0200, Paolo Bonzini wrote:
> > On 27/09/2018 11:17, Vitaly Kuznetsov wrote:
> > > Roman Kagan <rkagan@virtuozzo.com> writes:
> > >=20
> > >> On Wed, Sep 26, 2018 at 07:02:56PM +0200, Vitaly Kuznetsov wrote:
> > >>> In most common cases VP index of a vcpu matches its vcpu index. Use=
rspace
> > >>> is, however, free to set any mapping it wishes and we need to accou=
nt for
> > >>> that when we need to find a vCPU with a particular VP index. To kee=
p search
> > >>> algorithms optimal in both cases introduce 'num_mismatched_vp_index=
es'
> > >>> counter showing how many vCPUs with mismatching VP index we have. I=
n case
> > >>> the counter is zero we can assume vp_index =3D=3D vcpu_idx.
> > >>>
> > >>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > >>> ---
> > >>>  arch/x86/include/asm/kvm_host.h |  3 +++
> > >>>  arch/x86/kvm/hyperv.c           | 26 +++++++++++++++++++++++---
> > >>>  2 files changed, 26 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm=
/kvm_host.h
> > >>> index 09b2e3e2cf1b..711f79f1b5e6 100644
> > >>> --- a/arch/x86/include/asm/kvm_host.h
> > >>> +++ b/arch/x86/include/asm/kvm_host.h
> > >>> @@ -781,6 +781,9 @@ struct kvm_hv {
> > >>>  	u64 hv_reenlightenment_control;
> > >>>  	u64 hv_tsc_emulation_control;
> > >>>  	u64 hv_tsc_emulation_status;
> > >>> +
> > >>> +	/* How many vCPUs have VP index !=3D vCPU index */
> > >>> +	atomic_t num_mismatched_vp_indexes;
> > >>>  };
> > >>> =20
> > >>>  enum kvm_irqchip_mode {
> > >>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > >>> index c8764faf783b..6a19c8e3c432 100644
> > >>> --- a/arch/x86/kvm/hyperv.c
> > >>> +++ b/arch/x86/kvm/hyperv.c
> > >>> @@ -1045,11 +1045,31 @@ static int kvm_hv_set_msr(struct kvm_vcpu *=
vcpu, u32 msr, u64 data, bool host)
> > >>>  	struct kvm_vcpu_hv *hv_vcpu =3D &vcpu->arch.hyperv;
> > >>> =20
> > >>>  	switch (msr) {
> > >>> -	case HV_X64_MSR_VP_INDEX:
> > >>> -		if (!host || (u32)data >=3D KVM_MAX_VCPUS)
> > >>> +	case HV_X64_MSR_VP_INDEX: {
> > >>> +		struct kvm_hv *hv =3D &vcpu->kvm->arch.hyperv;
> > >>> +		int vcpu_idx =3D kvm_vcpu_get_idx(vcpu);
> > >>> +		u32 new_vp_index =3D (u32)data;
> > >>> +
> > >>> +		if (!host || new_vp_index >=3D KVM_MAX_VCPUS)
> > >>>  			return 1;
> > >>> -		hv_vcpu->vp_index =3D (u32)data;
> > >>> +
> > >>> +		if (new_vp_index =3D=3D hv_vcpu->vp_index)
> > >>> +			return 0;
> > >>> +
> > >>> +		/*
> > >>> +		 * VP index is changing, increment num_mismatched_vp_indexes in
> > >>> +		 * case it was equal to vcpu_idx before; on the other hand, if
> > >>> +		 * the new VP index matches vcpu_idx num_mismatched_vp_indexes
> > >>> +		 * needs to be decremented.
> > >>
> > >> It may be worth mentioning that the initial balance is provided by
> > >> kvm_hv_vcpu_postcreate setting vp_index =3D vcpu_idx.
> > >>
> > >=20
> > > Of course, yes, will update the comment in case I'll be re-submitting=
.
> >=20
> > 	/*
> > 	 * VP index is initialized to hv_vcpu->vp_index by
                                      ^^^^^^^^^^^^^^^^^
				      vcpu_idx

> > 	 * kvm_hv_vcpu_postcreate so they initially match.  Now the
> > 	 * VP index is changing, adjust num_mismatched_vp_indexes if
> > 	 * it now matches or no longer matches vcpu_idx.
> > 	 */
> >=20
> > ?
>=20
> To my taste - perfect :)

Well, almost :)

Roman.
