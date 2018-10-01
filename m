Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2634C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB16213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TFMRz0aL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB16213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeJAWdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:33:04 -0400
Received: from mail-ve1eur01hn0216.outbound.protection.outlook.com ([104.47.1.216]:15271
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbeJAWdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzF48v3FHjjv3SCiNxOzyX9s7e6F/3z/WXJ+dfDiAcM=;
 b=TFMRz0aLVGvn+42bjowa9MGf0cvyF/wU0+jeZ4duNoyHBZ+c7V1HUdviIs5LJoJu96qCJRlNUx3Na40cMQwr3+R7W6k7xXWsxLR3riGVSKPPT/aJDXv3M48MIffwVQsT+RCBOcd0qRbW67UyEgxS6LDxvRpMZYIWAxqSWnzO0v4=
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) by
 VI1PR08MB1135.eurprd08.prod.outlook.com (10.166.45.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Mon, 1 Oct 2018 15:54:26 +0000
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::d453:c2b:518c:b64]) by VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::d453:c2b:518c:b64%3]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 15:54:26 +0000
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
Thread-Index: AQHUVbrTeaVBNfWXhkKXGMfpSWKXvqUD9seA///juoCABraMAIAAAX0A
Date:   Mon, 1 Oct 2018 15:54:26 +0000
Message-ID: <20181001155413.GA2314@rkaganb.sw.ru>
References: <20180926170259.29796-1-vkuznets@redhat.com>
 <20180926170259.29796-5-vkuznets@redhat.com>
 <20180927075911.GB4186@rkaganb.sw.ru> <87sh1vfge0.fsf@vitty.brq.redhat.com>
 <d39dcde2-695e-019e-419f-60ce3712eff3@redhat.com>
In-Reply-To: <d39dcde2-695e-019e-419f-60ce3712eff3@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
mail-followup-to: =?iso-8859-2?Q?Roman_Kagan_<rkagan@virtuozzo.com>,=09Paolo_Bonzini_<pbonz?=
 =?iso-8859-2?Q?ini@redhat.com>,=09Vitaly_Kuznetsov_<vkuznets@redhat.com>,?=
 =?iso-8859-2?Q?_kvm@vger.kernel.org,=09Radim_Kr=E8m=E1=F8_<rkrcmar@redhat?=
 =?iso-8859-2?Q?.com>,=09"K._Y._Srinivasan"_<kys@microsoft.com>,=09Haiyang?=
 =?iso-8859-2?Q?_Zhang_<haiyangz@microsoft.com>,=09Stephen_Hemminger_<sthe?=
 =?iso-8859-2?Q?mmin@microsoft.com>,=09"Michael_Kelley_(EOSG)"_<Michael.H.?=
 =?iso-8859-2?Q?Kelley@microsoft.com>,=09Mohammed_Gamal_<mmorsy@redhat.com?=
 =?iso-8859-2?Q?>,_Cathy_Avery_<cavery@redhat.com>,=09Wanpeng_Li_<wanpeng.?=
 =?iso-8859-2?Q?li@hotmail.com>,_linux-kernel@vger.kernel.org?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: VI1PR04CA0097.eurprd04.prod.outlook.com
 (2603:10a6:803:64::32) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB1135;7:48SAfi9o7MYwZ07eyN7skgU27npzJHhW58AlqJ+RXaH46M4qa47r1q5aO8y2g2v1f23XbG6S7FaEkMom+XJYOiPKl8UyNwa3q5OiO5CP6BRZkAuBbKcQtBYetFq23m0gSpbgBRcOdb16bfWrHEOzHJ3Bf6ROTA/M4Irp0oM9dy1GfQOqls19gv9CdpIqI0YXkg0XCUfvSia6D1FH2dSoYenGQLhANYGHUo4Y81Cx0YIVh7iv4HyPWn8+ZDOyJgq2;20:ptAf0P22Z6TtxqqmkYgJZONzfiQKx0Gbf9V9OmHlB/YCkmYfINzfMWet9Hm2o8L8c4ivJgDu+qG1TEvNVHn3/u92JKM9ctWIQpwpL30wpkZSiMDRyG7ZYl9pqi357G3pc4T5E0TI6tDTESzpvv+nkc29BqscARXAi2MLf4erdhQ=
x-ms-office365-filtering-correlation-id: 090bac10-34de-488b-6c09-08d627b6252b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB1135;
x-ms-traffictypediagnostic: VI1PR08MB1135:|VI1PR08MB1135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-microsoft-antispam-prvs: <VI1PR08MB11355815C038AAF71958F549C9EF0@VI1PR08MB1135.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:VI1PR08MB1135;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB1135;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(396003)(366004)(39840400004)(136003)(376002)(346002)(199004)(189003)(14444005)(7416002)(9686003)(8936002)(1076002)(33896004)(86362001)(6506007)(386003)(76176011)(5660300001)(58126008)(53936002)(256004)(54906003)(105586002)(7736002)(6512007)(6116002)(93886005)(3846002)(52116002)(81166006)(99286004)(305945005)(316002)(81156014)(8676002)(6436002)(106356001)(25786009)(186003)(39060400002)(486006)(33656002)(26005)(229853002)(446003)(11346002)(5250100002)(71200400001)(71190400001)(6486002)(478600001)(4326008)(2900100001)(476003)(97736004)(66066001)(34290500001)(53546011)(6916009)(14454004)(68736007)(2906002)(36756003)(6246003)(102836004)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB1135;H:VI1PR08MB3599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rURrIybdf39gkl74dWWn7Ws9SlaiE3vaZAhZwmByu6EF2Fr9Vjr62KrR3NG3CLsLHaHU7KTqBj+T9W5u2lUFKH6BI0EnzlAP1jimk+ufgisi8/7sBRG1a5MBCXv+5yLjsIiUNXUjDV4I9U5EYL1CXnHaMUa4A6Q5U5RnR0YBy/vNl3z7cClJq3/zkG2T5e5T7q0znBaVSc1m7cob/WF/bWPCa4pYBULnomf6l5t5OzxwRzOO2aD5pjjhXjH7o7xZgIl5P41aE710I6cUn+hXUDxbMlRacqwO+zxU4iJ6LGeEMYEG5/GqhhGBvKvNu9YBQW1EyjZAZGcqhQ4vFA1myuM31aAqT1BsAKW6f2cNTl/OSXz6zj//CeeZRIhRqWIrpiwUO+pS5ukZ+7H1FHwFLc7bxlo4G2xvnomW31+7Auy9YdXgX480Z7zcb23D4Lojdidxj+SdxTX7G1XK/JBgrOL7Dw9R7ztQjXIznTpU7TtjU2NG6HxxdQn4h0ZnJ4XrC3r7WKl9hn5fquYYVpVjP37gGxtApnB497DcKw9maouQkz0pfA2moH4DH7Yr6Kp9qX5y9y4Cq4USyy+H0T4DgA==
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <66E7B0E8D764374C85FA9A4DDA2D9199@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090bac10-34de-488b-6c09-08d627b6252b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 15:54:26.4507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB1135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 05:48:54PM +0200, Paolo Bonzini wrote:
> On 27/09/2018 11:17, Vitaly Kuznetsov wrote:
> > Roman Kagan <rkagan@virtuozzo.com> writes:
> >=20
> >> On Wed, Sep 26, 2018 at 07:02:56PM +0200, Vitaly Kuznetsov wrote:
> >>> In most common cases VP index of a vcpu matches its vcpu index. Users=
pace
> >>> is, however, free to set any mapping it wishes and we need to account=
 for
> >>> that when we need to find a vCPU with a particular VP index. To keep =
search
> >>> algorithms optimal in both cases introduce 'num_mismatched_vp_indexes=
'
> >>> counter showing how many vCPUs with mismatching VP index we have. In =
case
> >>> the counter is zero we can assume vp_index =3D=3D vcpu_idx.
> >>>
> >>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >>> ---
> >>>  arch/x86/include/asm/kvm_host.h |  3 +++
> >>>  arch/x86/kvm/hyperv.c           | 26 +++++++++++++++++++++++---
> >>>  2 files changed, 26 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/k=
vm_host.h
> >>> index 09b2e3e2cf1b..711f79f1b5e6 100644
> >>> --- a/arch/x86/include/asm/kvm_host.h
> >>> +++ b/arch/x86/include/asm/kvm_host.h
> >>> @@ -781,6 +781,9 @@ struct kvm_hv {
> >>>  	u64 hv_reenlightenment_control;
> >>>  	u64 hv_tsc_emulation_control;
> >>>  	u64 hv_tsc_emulation_status;
> >>> +
> >>> +	/* How many vCPUs have VP index !=3D vCPU index */
> >>> +	atomic_t num_mismatched_vp_indexes;
> >>>  };
> >>> =20
> >>>  enum kvm_irqchip_mode {
> >>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> >>> index c8764faf783b..6a19c8e3c432 100644
> >>> --- a/arch/x86/kvm/hyperv.c
> >>> +++ b/arch/x86/kvm/hyperv.c
> >>> @@ -1045,11 +1045,31 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vc=
pu, u32 msr, u64 data, bool host)
> >>>  	struct kvm_vcpu_hv *hv_vcpu =3D &vcpu->arch.hyperv;
> >>> =20
> >>>  	switch (msr) {
> >>> -	case HV_X64_MSR_VP_INDEX:
> >>> -		if (!host || (u32)data >=3D KVM_MAX_VCPUS)
> >>> +	case HV_X64_MSR_VP_INDEX: {
> >>> +		struct kvm_hv *hv =3D &vcpu->kvm->arch.hyperv;
> >>> +		int vcpu_idx =3D kvm_vcpu_get_idx(vcpu);
> >>> +		u32 new_vp_index =3D (u32)data;
> >>> +
> >>> +		if (!host || new_vp_index >=3D KVM_MAX_VCPUS)
> >>>  			return 1;
> >>> -		hv_vcpu->vp_index =3D (u32)data;
> >>> +
> >>> +		if (new_vp_index =3D=3D hv_vcpu->vp_index)
> >>> +			return 0;
> >>> +
> >>> +		/*
> >>> +		 * VP index is changing, increment num_mismatched_vp_indexes in
> >>> +		 * case it was equal to vcpu_idx before; on the other hand, if
> >>> +		 * the new VP index matches vcpu_idx num_mismatched_vp_indexes
> >>> +		 * needs to be decremented.
> >>
> >> It may be worth mentioning that the initial balance is provided by
> >> kvm_hv_vcpu_postcreate setting vp_index =3D vcpu_idx.
> >>
> >=20
> > Of course, yes, will update the comment in case I'll be re-submitting.
>=20
> 	/*
> 	 * VP index is initialized to hv_vcpu->vp_index by
> 	 * kvm_hv_vcpu_postcreate so they initially match.  Now the
> 	 * VP index is changing, adjust num_mismatched_vp_indexes if
> 	 * it now matches or no longer matches vcpu_idx.
> 	 */
>=20
> ?

To my taste - perfect :)

Roman.
