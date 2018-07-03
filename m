Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226DEC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45D6247F2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a6JO1s89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45D6247F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbeGCWol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:44:41 -0400
Received: from mail-eopbgr730114.outbound.protection.outlook.com ([40.107.73.114]:51027
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753076AbeGCWoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW9RKpocS/QbzvFht7Io/jz5nQu90alMlqL4TrJk+ao=;
 b=a6JO1s89lyAKf6sjMIaOQEVouwsAYuGHxFi9M/LHHA3TgSeu9qxl2TqKC3Yhc3dozDinAmgduVY9LKXcl9VnMLqYAVXoZB8IMka8wBwfX1jqosY/k5Gi1eNqaW1D7P/iVyV5IjUBf1VbAVWDhD6RkdGYx2wcszXBzdyogQjsNTw=
Received: from BL0PR2101MB1107.namprd21.prod.outlook.com (52.132.24.30) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Tue, 3 Jul 2018 22:44:37 +0000
Received: from BL0PR2101MB1107.namprd21.prod.outlook.com
 ([fe80::bdce:1ed4:1030:fa7f]) by BL0PR2101MB1107.namprd21.prod.outlook.com
 ([fe80::bdce:1ed4:1030:fa7f%3]) with mapi id 15.20.0952.005; Tue, 3 Jul 2018
 22:44:37 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/1] X86: Fix the circular dependency in IPI
 enlightenment.
Thread-Topic: [PATCH 1/1] X86: Fix the circular dependency in IPI
 enlightenment.
Thread-Index: AQHUEx54dNXJT7NbtU+3bGq/CTzHOqR+GBog
Date:   Tue, 3 Jul 2018 22:44:36 +0000
Message-ID: <BL0PR2101MB1107AC5048311B0AC1C6A852A0420@BL0PR2101MB1107.namprd21.prod.outlook.com>
References: <20180703223641.4171-1-kys@linuxonhyperv.com>
In-Reply-To: <20180703223641.4171-1-kys@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.107.160.86]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:k7HoutI+BhA4F9AZ9K/tOJ1m49yTzSGvDygzibWzQpK9GW7OfHtrNMqXpLG+v07nXE1m+FYVJnk25+0ujfMCPx1q5lTfr8haQ0OLB5TLjQ8vGXJ04TrjanUwAJbPPJBq9SK7S2BOmr1ixWhzRf9HoZkNm4lhicwR+aJmCOBF+pA3XEQ0LUD3XEvUimRCeQsbq8WOWHOx1UCK2ApZ6EL6lelxnOoJyCXgAk8U2qCuef6WlgvdDoab4YOQ/UqFnzIb
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: df7599e7-7cb8-4219-50f1-08d5e1368e16
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-o365eop-header: O365_EOP: Allow for Unauthenticated Relay
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <BL0PR2101MB096277D8803EEDEB2B01FE5BA0420@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231280)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0722981D2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(13464003)(446003)(2501003)(8990500004)(66066001)(10290500003)(9686003)(1511001)(86362001)(86612001)(102836004)(8936002)(26005)(476003)(3846002)(5250100002)(14454004)(11346002)(6116002)(2201001)(6436002)(256004)(486006)(99286004)(478600001)(55016002)(68736007)(10090500001)(110136005)(5660300001)(33656002)(2906002)(229853002)(7416002)(316002)(2900100001)(7696005)(105586002)(6246003)(22452003)(106356001)(97736004)(25786009)(81166006)(81156014)(53936002)(6506007)(53546011)(8676002)(76176011)(74316002)(305945005)(7736002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1107.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RhOMhQDDjsQvjXUf0sgOgdkw3du52mTHllL1DCJnucRdMHuVH4L4y6wHSe/NSwZco27HQmkrucBtP2B/F1qjhgUlTrXy6xP8JWHtZKjzGo70dnTs7d8v1M6z39TZcZfDzWqn/NrB16xj7MJUuSm3dBf78H1w6JaoWtMesTLf8QzolXl6F7m827WOzaZdurZD4nVdjIzA5u93ecKxJGKGomrb0pkrKPjbu8ThCMhMlNLr7L478/ymbb8LBbcJpgb7nXkPzdUBQ6Ocz+Ud9QR5YikBSigdg4ZTNUIFR0V9sDOBFsF8+jcEVg49ylSr0pEiMoD8T8+GtqZZtgjzy7tgW6SxTQE1dA0gpo0sCEM3Cc0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7599e7-7cb8-4219-50f1-08d5e1368e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2018 22:44:36.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>
> Sent: Tuesday, July 3, 2018 3:37 PM
> To: x86@kernel.org; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com; tglx@linutronix.de;
> hpa@zytor.com; Stephen Hemminger <sthemmin@microsoft.com>; Michael
> Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> Cc: KY Srinivasan <kys@microsoft.com>
> Subject: [PATCH 1/1] X86: Fix the circular dependency in IPI enlightenmen=
t.
>=20
> From: "K. Y. Srinivasan" <kys@microsoft.com>
>=20
> The IPI hypercalls depend on being able to map the Linux notion of CPU ID
> to the hypervisor's notion of the CPU ID. The array hv_vp_index[] provide=
s
> this mapping. Code for populating this array depends on the IPI functiona=
lity.
> Break this circular dependency.
>=20
> Fixes: 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")

Please drop this patch; I have sent the wrong patch.

Regards,

K. Y
>=20
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Tested-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/hyperv/hv_apic.c       | 5 +++++
>  arch/x86/hyperv/hv_init.c       | 3 +++
>  arch/x86/include/asm/mshyperv.h | 2 ++
>  3 files changed, 10 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index f68855499391..63d7c196739f 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -114,6 +114,8 @@ static bool __send_ipi_mask_ex(const struct cpumask
> *mask, int vector)
>  		ipi_arg->vp_set.format =3D HV_GENERIC_SET_SPARSE_4K;
>  		nr_bank =3D cpumask_to_vpset(&(ipi_arg->vp_set), mask);
>  	}
> +	if (nr_bank =3D=3D -1)
> +		goto ipi_mask_ex_done;
>  	if (!nr_bank)
>  		ipi_arg->vp_set.format =3D HV_GENERIC_SET_ALL;
>=20
> @@ -158,6 +160,9 @@ static bool __send_ipi_mask(const struct cpumask
> *mask, int vector)
>=20
>  	for_each_cpu(cur_cpu, mask) {
>  		vcpu =3D hv_cpu_number_to_vp_number(cur_cpu);
> +		if (vcpu =3D=3D -1)
> +			goto ipi_mask_done;
> +
>  		/*
>  		 * This particular version of the IPI hypercall can
>  		 * only target upto 64 CPUs.
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 595e44e8abaa..762ce164d733 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -293,6 +293,9 @@ void __init hyperv_init(void)
>  	if (!hv_vp_index)
>  		return;
>=20
> +	for (i =3D 0; i < num_possible_cpus(); i++)
> +		hv_vp_index[i] =3D -1;
> +
>  	hv_vp_assist_page =3D kcalloc(num_possible_cpus(),
>  				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
>  	if (!hv_vp_assist_page) {
> diff --git a/arch/x86/include/asm/mshyperv.h
> b/arch/x86/include/asm/mshyperv.h
> index 81e768b8d9eb..299de3dcc319 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -285,6 +285,8 @@ static inline int cpumask_to_vpset(struct hv_vpset
> *vpset,
>  	 */
>  	for_each_cpu(cpu, cpus) {
>  		vcpu =3D hv_cpu_number_to_vp_number(cpu);
> +		if (vcpu =3D=3D -1)
> +			return -1;
>  		vcpu_bank =3D vcpu / 64;
>  		vcpu_offset =3D vcpu % 64;
>  		__set_bit(vcpu_offset, (unsigned long *)
> --
> 2.17.1

