Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBEEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D272081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G30v5v5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D272081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeLJSjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:39:35 -0500
Received: from mail-bgr052101133108.outbound.protection.outlook.com ([52.101.133.108]:21680
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbeLJSje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piyGYwVxN1xYClmbrOGW9pGw0MchlvFmk/xXS+qfs2E=;
 b=G30v5v5b5QnQTW/9zssQbFc1HlT4Pz4SIuZZDzmLZEX9+C4qkZPmE/FYsV+zl/4kYDPAnFFQArBY8NObFAGSidBpVMWoDBbuiAfTm5UJs0bbJedvvfwE6xHJWFsU0nQoAQQN80ayODXccKPU7RJ0/MGLTAvAI/hFYj8G0D7O31o=
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com (20.179.10.210) by
 DB8PR08MB3947.eurprd08.prod.outlook.com (20.179.8.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Mon, 10 Dec 2018 18:39:22 +0000
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d41:d012:1944:5810]) by DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d41:d012:1944:5810%6]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 18:39:22 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/hyper-v: Stop caring about EOI for direct stimers
Thread-Topic: [PATCH] x86/hyper-v: Stop caring about EOI for direct stimers
Thread-Index: AQHUjLBT6Al8mtnq+kqCWVZjGeBbQaV4VfGA
Date:   Mon, 10 Dec 2018 18:39:22 +0000
Message-ID: <20181210183918.GB13294@rkaganb.sw.ru>
References: <20181205153621.14343-1-vkuznets@redhat.com>
In-Reply-To: <20181205153621.14343-1-vkuznets@redhat.com>
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
x-clientproxiedby: HE1PR0102CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::33) To DB8PR08MB4092.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB8PR08MB3947;7:MwidnD9qhvwbLyFgUOyNUoqlXwEKYa8T9UN2NNswkGD6mbNX38fJLELoM1b6MPSQIaVaEArFHElt3sKndp8twp5sQx19iHCb1vgrKLb2oA7P0zFG4hqVhXy3txyfYQYf6byceIUuHjwarXYQYqEBSA==;20:Se2+C7PeGofhfSeOjnOqvrtKALoGXsJYPVvT+05D3aOXN+LA1JCPaYZGhL6m1Gv3HEK/aRn34shW5FPeEKLFKQMkW1esTjMXqufU79YAiwCSu284JNpik7uAVrIKKdRl4ix4DskUjtWUlgtk/Qxdw09gMahkMFp7J7Y9naKZWyA=
x-ms-office365-filtering-correlation-id: 96deeef1-0372-453e-d9ee-08d65ececd87
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB8PR08MB3947;
x-ms-traffictypediagnostic: DB8PR08MB3947:|DB8PR08MB3947:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-microsoft-antispam-prvs: <DB8PR08MB3947E0C44D43B7778D9F2023C9A50@DB8PR08MB3947.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB8PR08MB3947;BCL:0;PCL:0;RULEID:;SRVR:DB8PR08MB3947;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(346002)(376002)(366004)(39850400004)(396003)(136003)(189003)(199004)(54906003)(6246003)(478600001)(6916009)(58126008)(99286004)(2906002)(486006)(102836004)(106356001)(71200400001)(71190400001)(305945005)(33656002)(14454004)(6436002)(7736002)(52116002)(6116002)(3846002)(25786009)(6506007)(229853002)(8936002)(316002)(33896004)(76176011)(186003)(36756003)(6512007)(9686003)(26005)(97736004)(68736007)(386003)(66066001)(53936002)(8676002)(476003)(4326008)(5660300001)(1076002)(105586002)(81166006)(256004)(11346002)(14444005)(86362001)(81156014)(6486002)(446003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB8PR08MB3947;H:DB8PR08MB4092.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q4sgC/7lSmoffEx5dvBEcnoTu+2jK6RQihq5tMhAaoF/GDd8F8nJ4XwwQxcIzIH4tvV47HCTpr3mWb2YOyGjT6C1l3QtVlqX/9RMHF/nSpF9aPL3cCX+0WoZ/Jgu+Lr5XpZRpesDSPq2q03sxB36ntUBOPXz/dTVV4Xa03OuyoLZ9jNBfsiYUiSYLkIx7JF/vqh+d9oWuymhrf5+e/72Sp7cppp6H+sfiJLUCxr9TAfRPbeeOSdMtwuL4nhkJvolzZ1nqVKk9gJhHV/KgOqhuXtd0lt/JpM66sOXvAdQ0pJyNoyyuo+reB+ozv307KW5uAp/WfGH5eQLJPUxUoA7epCF+463rL2CZumf1O+zSakAZoOBZHif8hxHOAwLF2DKqmkuUeqQcJ4Anx4kvb/HB1ruIHq0OI9VtfFmHGevI7q6xwBlZa3xgK44F3eIe3bs4r/LLU8+Ar8c3zhjiw7lqajvSvieVV7b2iEyJTANL7Vm2DnOHli55iU/v5Z2yJhF
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <0BC30FB1B722E941BF7157E78627575C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96deeef1-0372-453e-d9ee-08d65ececd87
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 18:39:22.7902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sorry, missed this one ]

On Wed, Dec 05, 2018 at 04:36:21PM +0100, Vitaly Kuznetsov wrote:
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
>=20
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index e6a2a085644a..0a16a77e6ac3 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -56,21 +56,8 @@ static inline int synic_get_sint_vector(u64 sint_value=
)
>  static bool synic_has_vector_connected(struct kvm_vcpu_hv_synic *synic,
>  				      int vector)
>  {
> -	struct kvm_vcpu *vcpu =3D synic_to_vcpu(synic);
> -	struct kvm_vcpu_hv *hv_vcpu =3D vcpu_to_hv_vcpu(vcpu);
> -	struct kvm_vcpu_hv_stimer *stimer;
>  	int i;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
> -		stimer =3D &hv_vcpu->stimer[i];
> -		if (stimer->config.enable && stimer->config.direct_mode &&
> -		    stimer->config.apic_vector =3D=3D vector)
> -			return true;
> -	}
> -
> -	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> -		return false;
> -
>  	for (i =3D 0; i < ARRAY_SIZE(synic->sint); i++) {
>  		if (synic_get_sint_vector(synic_read_sint(synic, i)) =3D=3D vector)
>  			return true;
> @@ -96,14 +83,14 @@ static bool synic_has_vector_auto_eoi(struct kvm_vcpu=
_hv_synic *synic,
>  static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
>  				int vector)
>  {
> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> +		return;
> +
>  	if (synic_has_vector_connected(synic, vector))
>  		__set_bit(vector, synic->vec_bitmap);
>  	else
>  		__clear_bit(vector, synic->vec_bitmap);
> =20
> -	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> -		return;
> -
>  	if (synic_has_vector_auto_eoi(synic, vector))
>  		__set_bit(vector, synic->auto_eoi_bitmap);
>  	else
> @@ -382,9 +369,7 @@ int kvm_hv_synic_set_irq(struct kvm *kvm, u32 vpidx, =
u32 sint)
> =20
>  void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector)
>  {
> -	struct kvm_vcpu_hv *hv_vcpu =3D vcpu_to_hv_vcpu(vcpu);
>  	struct kvm_vcpu_hv_synic *synic =3D vcpu_to_synic(vcpu);
> -	struct kvm_vcpu_hv_stimer *stimer;
>  	int i;
> =20
>  	trace_kvm_hv_synic_send_eoi(vcpu->vcpu_id, vector);
> @@ -392,14 +377,6 @@ void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, in=
t vector)
>  	for (i =3D 0; i < ARRAY_SIZE(synic->sint); i++)
>  		if (synic_get_sint_vector(synic_read_sint(synic, i)) =3D=3D vector)
>  			kvm_hv_notify_acked_sint(vcpu, i);
> -
> -	for (i =3D 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
> -		stimer =3D &hv_vcpu->stimer[i];
> -		if (stimer->msg_pending && stimer->config.enable &&
> -		    stimer->config.direct_mode &&
> -		    stimer->config.apic_vector =3D=3D vector)
> -			stimer_mark_pending(stimer, false);
> -	}
>  }
> =20
>  static int kvm_hv_set_sint_gsi(struct kvm *kvm, u32 vpidx, u32 sint, int=
 gsi)
> @@ -566,8 +543,6 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *st=
imer)
>  static int stimer_set_config(struct kvm_vcpu_hv_stimer *stimer, u64 conf=
ig,
>  			     bool host)
>  {
> -	struct kvm_vcpu *vcpu =3D stimer_to_vcpu(stimer);
> -	struct kvm_vcpu_hv *hv_vcpu =3D vcpu_to_hv_vcpu(vcpu);
>  	union hv_stimer_config new_config =3D {.as_uint64 =3D config},
>  		old_config =3D {.as_uint64 =3D stimer->config.as_uint64};
> =20
> @@ -580,11 +555,6 @@ static int stimer_set_config(struct kvm_vcpu_hv_stim=
er *stimer, u64 config,
>  		new_config.enable =3D 0;
>  	stimer->config.as_uint64 =3D new_config.as_uint64;
> =20
> -	if (old_config.direct_mode)
> -		synic_update_vector(&hv_vcpu->synic, old_config.apic_vector);
> -	if (new_config.direct_mode)
> -		synic_update_vector(&hv_vcpu->synic, new_config.apic_vector);
> -
>  	stimer_mark_pending(stimer, false);
>  	return 0;
>  }

As discussed in another thread, it seems worth while to make
stimer_set_config reject vectors 0..15.

Besides I'd rather sqwash this patch into the one that introduced direct
timers, before it reached Linus' tree.

Roman.
