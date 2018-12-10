Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64200C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8D62084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XTuI76cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8D62084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeLJMG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:06:57 -0500
Received: from mail-bgr052101130054.outbound.protection.outlook.com ([52.101.130.54]:44878
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727146AbeLJMG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giSFzG2jXr8TVyLTb92WzxXUstalmwRZOgLDU9PAcac=;
 b=XTuI76cq/7gOsX8IB7eiAvJid9DCh/bMpZ3oq/tMybjv0cIx+5lgWZcwN/iJrYrSddYDZ5u2YkTaZ9ap1x0l+UmMEMDgCe0D6DH1TqRMkQJ25pxcqlacDqhg7Ot5zPd0BMrIgONK8cWUUx05h/QZ91i6XUkIUTieprKk4/zAJYM=
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com (20.179.10.210) by
 DB8PR08MB4106.eurprd08.prod.outlook.com (20.179.11.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 12:06:41 +0000
Received: from DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d41:d012:1944:5810]) by DB8PR08MB4092.eurprd08.prod.outlook.com
 ([fe80::d41:d012:1944:5810%6]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 12:06:41 +0000
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
Thread-Index: AQHUhZ9mV1oam64KnkyNE5PKjfame6V39lwA
Date:   Mon, 10 Dec 2018 12:06:41 +0000
Message-ID: <20181210120637.GA13294@rkaganb.sw.ru>
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
x-clientproxiedby: HE1P18901CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::16) To DB8PR08MB4092.eurprd08.prod.outlook.com
 (2603:10a6:10:ab::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB8PR08MB4106;7:gEjOy9nJqQN+1ZccgqoixSJV+BSTjiXpS1jlAaWnkxjnTbtExfSMUGAD7kEbZgE0Sy3KkGywuiJF5WksAEpbpK/4lSNTvCjdKXahJcK0edwPb1szWH737LRrDKI8UGxkGd/xets9GgyR/vNNjYNyIg==;20:C1TgznpEHj8ntIgrPmVFeuPp1EluEle4lehgv21GyEC9YviYb2OICo6taeQhRyZc9WXaOVE8aUS0gufx90zYfyklyfSk7Nbae7DtiuRarqJ27VNj8y65rF29xkVkswwS0xECDklJmJJyTp9JX7tiT4+QuCK030+muhzY2pqWWsQ=
x-ms-office365-filtering-correlation-id: 6f9d706c-bd34-461d-e635-08d65e97f206
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB8PR08MB4106;
x-ms-traffictypediagnostic: DB8PR08MB4106:|DB8PR08MB4106:
x-microsoft-antispam-prvs: <DB8PR08MB4106CD1B43FF992E6F7D4C4DC9A50@DB8PR08MB4106.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB8PR08MB4106;BCL:0;PCL:0;RULEID:;SRVR:DB8PR08MB4106;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(346002)(136003)(366004)(376002)(39840400004)(396003)(189003)(199004)(11346002)(1076002)(53936002)(446003)(6116002)(476003)(14454004)(2906002)(3846002)(316002)(478600001)(486006)(25786009)(58126008)(229853002)(54906003)(6916009)(7736002)(66066001)(305945005)(14444005)(5660300001)(6436002)(6486002)(102836004)(7416002)(26005)(36756003)(71190400001)(71200400001)(52116002)(186003)(86362001)(386003)(6506007)(9686003)(106356001)(76176011)(6246003)(81166006)(105586002)(81156014)(99286004)(8936002)(8676002)(256004)(68736007)(4326008)(33656002)(97736004)(6512007)(33896004)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB8PR08MB4106;H:DB8PR08MB4092.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xK6XlAwAjzBZCVT1nbTfjgOa2fraCSlUIfGXll2IBOI1oapjQGX2ndx1hvcoDiON42Hr3xygsy8MGIFk0nXfq4dCb1bEIDwPRE2wvK2W9hPhRhdOYfEeo0xnlL0pxigD53ZjOLtMPK+6idF2MVFjYGCXGKw0etg8payLuu67i22cD0XECUfEBxGid4JJ3CzF9PwnoSEvvFaf3IxDA9ezciquUgI2Q29mOOOGqRG8MF6h5ZxXQ+0rN/LDi9lN4744s+UGF1wNomijyy2bvRgLa0Lv9cOqkmqR/1fw5dhXY2swmEBKxZAI5MvtRC6T+j2JW82Xrpu1HOzAC9y16xLidWXN3aNaMyzon4g+4IroUxcazVhVKz3m45JVR/GIf7aYN00EC+r45xzVUbJLSHN6ZivMvN9g+M25b3UjPVnjBsXtXEfOnV9haU0bLXE4SD9f5wdthgsgoykKpeZwzFJ9wcaiBw70tN0rgRkld/vB6xrO+La7Wcgm7etZ/MK6Cd9e
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <969B5E1A2AE93D469E1AE256DAD37BFA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9d706c-bd34-461d-e635-08d65e97f206
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 12:06:41.8698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:47:31PM +0100, Vitaly Kuznetsov wrote:
> Turns out Hyper-V on KVM (as of 2016) will only use synthetic timers
> if direct mode is available. With direct mode we notify the guest by
> asserting APIC irq instead of sending a SynIC message.
>=20
> The implementation uses existing vec_bitmap for letting lapic code
> know that we're interested in the particular IRQ's EOI request. We assume
> that the same APIC irq won't be used by the guest for both direct mode
> stimer and as sint source (especially with AutoEOI semantics). It is
> unclear how things should be handled if that's not true.
>=20
> Direct mode is also somewhat less expensive; in my testing
> stimer_send_msg() takes not less than 1500 cpu cycles and
> stimer_notify_direct() can usually be done in 300-400. WS2016 without
> Hyper-V, however, always sticks to non-direct version.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - Changes since v1: avoid open-coding stimer_mark_pending() in
>   kvm_hv_synic_send_eoi() [Paolo Bonzini]
> ---
>  arch/x86/kvm/hyperv.c    | 67 +++++++++++++++++++++++++++++++++++-----
>  arch/x86/kvm/trace.h     | 10 +++---
>  arch/x86/kvm/x86.c       |  1 +
>  include/uapi/linux/kvm.h |  1 +
>  4 files changed, 67 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index eaec15c738df..9533133be566 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -38,6 +38,9 @@
> =20
>  #define KVM_HV_MAX_SPARSE_VCPU_SET_BITS DIV_ROUND_UP(KVM_MAX_VCPUS, 64)
> =20
> +static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
> +				bool vcpu_kick);
> +
>  static inline u64 synic_read_sint(struct kvm_vcpu_hv_synic *synic, int s=
int)
>  {
>  	return atomic64_read(&synic->sint[sint]);
> @@ -53,8 +56,21 @@ static inline int synic_get_sint_vector(u64 sint_value=
)
>  static bool synic_has_vector_connected(struct kvm_vcpu_hv_synic *synic,
>  				      int vector)
>  {
> +	struct kvm_vcpu *vcpu =3D synic_to_vcpu(synic);
> +	struct kvm_vcpu_hv *hv_vcpu =3D vcpu_to_hv_vcpu(vcpu);
> +	struct kvm_vcpu_hv_stimer *stimer;
>  	int i;
> =20
> +	for (i =3D 0; i < ARRAY_SIZE(hv_vcpu->stimer); i++) {
> +		stimer =3D &hv_vcpu->stimer[i];
> +		if (stimer->config.enable && stimer->config.direct_mode &&
> +		    stimer->config.apic_vector =3D=3D vector)
> +			return true;
> +	}
> +
> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> +		return false;
> +
>  	for (i =3D 0; i < ARRAY_SIZE(synic->sint); i++) {
>  		if (synic_get_sint_vector(synic_read_sint(synic, i)) =3D=3D vector)
>  			return true;
> @@ -80,14 +96,14 @@ static bool synic_has_vector_auto_eoi(struct kvm_vcpu=
_hv_synic *synic,
>  static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
>  				int vector)
>  {
> -	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> -		return;
> -
>  	if (synic_has_vector_connected(synic, vector))
>  		__set_bit(vector, synic->vec_bitmap);
>  	else
>  		__clear_bit(vector, synic->vec_bitmap);
> =20
> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
> +		return;
> +

Just noticed that the patch seems to assume that "direct" timers are
allowed to use any vectors including 0-15.  I guess this is incorrect,
and instead stimer_set_config should error out on direct mode with a
vector less than HV_SYNIC_FIRST_VALID_VECTOR.

Roman.
