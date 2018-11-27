Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0D7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3492C2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WXLbXYrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3492C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbeK0Teb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:34:31 -0500
Received: from mail-bgr052101131037.outbound.protection.outlook.com ([52.101.131.37]:31446
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728823AbeK0Teb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+mFatYnjOKTud7Pj5xTaJ28Jr8k/la/e50nwKcd+k4=;
 b=WXLbXYrFzyaW7JoZ3LH7BmQD/6znWHi0bzxnOqjtNBJV1PLt+Hj/dX7zBWMjxKRj2JcxZCTpwQ98vrQho7KK7hJwtLx90N3V06veN+ZvexR++wsfp7boJXYHRmgKH+0YwyKMdnAN5FnRNl5/GCJFleM+vYpGXneTw983unY+1Lg=
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) by
 VI1PR08MB0733.eurprd08.prod.outlook.com (10.163.165.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Tue, 27 Nov 2018 08:37:11 +0000
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2]) by VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2%3]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 08:37:11 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: Re: [PATCH v2 3/4] x86/kvm/hyper-v: direct mode for synthetic timers
Thread-Topic: [PATCH v2 3/4] x86/kvm/hyper-v: direct mode for synthetic timers
Thread-Index: AQHUhZ9mV1oam64KnkyNE5PKjfame6ViQ1QAgAEKL4A=
Date:   Tue, 27 Nov 2018 08:37:11 +0000
Message-ID: <20181127083706.GB16047@rkaganb.sw.ru>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-4-vkuznets@redhat.com>
 <e565638e-d6cc-bbd9-f99e-c835ef1be5b7@redhat.com>
In-Reply-To: <e565638e-d6cc-bbd9-f99e-c835ef1be5b7@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
mail-followup-to: =?iso-8859-2?Q?Roman_Kagan_<rkagan@virtuozzo.com>,=09Paolo_Bonzini_<pbonz?=
 =?iso-8859-2?Q?ini@redhat.com>,=09Vitaly_Kuznetsov_<vkuznets@redhat.com>,?=
 =?iso-8859-2?Q?_kvm@vger.kernel.org,=09Radim_Kr=E8m=E1=F8_<rkrcmar@redhat?=
 =?iso-8859-2?Q?.com>,=09linux-kernel@vger.kernel.org,=09"K._Y._Srinivasan?=
 =?iso-8859-2?Q?"_<kys@microsoft.com>,=09Haiyang_Zhang_<haiyangz@microsoft?=
 =?iso-8859-2?Q?.com>,=09Stephen_Hemminger_<sthemmin@microsoft.com>,_x86@k?=
 =?iso-8859-2?Q?ernel.org,=09"Michael_Kelley_(EOSG)"_<Michael.H.Kelley@mic?=
 =?iso-8859-2?Q?rosoft.com>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR09CA0065.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::33) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB0733;7:OD0zcxhWi5jpmCuUUZKkK/uGD0XDPsfCkISA15xmhZbQvDfOqXQvSYxKvp8f/xzpZ/RtBevmhfcO1tjA5Y5ZthopFvpbXGt6PBix3FMhGpfM/ckHVwpFw/EcrcNGDc+caVsFjln6wsBaIOpBY3dGTg==;20:UpLPrUf1nut35LQu7xBQ1Yxnmh3qMJCPng5U3prFPA8e/HqBZMmUfv17qlg44XybrXNNMmEmlBcUkHIhwlIcaPfCaciK8atAnLvUiEFiHWH2DBpZRF4DfIGLB6jeJsREfs1PJyYRPLU/dxUcjXI+jLJTrJqvFPt157xxJqsGGrg=
x-ms-office365-filtering-correlation-id: 2d3a232a-50ad-4516-aa63-08d654438602
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB0733;
x-ms-traffictypediagnostic: VI1PR08MB0733:|VI1PR08MB0733:
x-microsoft-antispam-prvs: <VI1PR08MB0733014E42B8CB563A198C0DC9D00@VI1PR08MB0733.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231443)(944501410)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB0733;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB0733;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(346002)(376002)(136003)(396003)(366004)(39850400004)(54094003)(199004)(189003)(305945005)(99286004)(6246003)(53936002)(7736002)(6486002)(6436002)(5660300001)(186003)(33656002)(229853002)(81156014)(7416002)(8676002)(81166006)(25786009)(9686003)(6512007)(26005)(6916009)(8936002)(106356001)(14454004)(71190400001)(71200400001)(446003)(11346002)(105586002)(4326008)(53546011)(2906002)(386003)(6506007)(66066001)(476003)(1076002)(76176011)(486006)(6116002)(3846002)(36756003)(52116002)(478600001)(33896004)(68736007)(58126008)(54906003)(256004)(86362001)(97736004)(316002)(102836004)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB0733;H:VI1PR08MB3599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: drGIWAXbiNXv14LwasvOoIUJLg4lWJ2uPMwXJTjFJoF3uUROnDSBS1wxdLpWptWTI2N1QlO6ZeYnNCNhpCS0mxKZHeE5FYZmiVOyeNmDGwQ7Ttv7M39bTvTkwP1BKNTZ9joGs9T4FW04aeUq00V3UaCdGmugDgHhnXZgQoN0QRDmu/GIse+Ne2ajICfiTB6+ZcRsd74Z0Gt8dm5TgwAkgTjHiIq2OvO/Ew1y1tFUg/H5MJ8gQVHR7+5p7h4Z8UP8Ry6Mzd1kxlonVMPhRVruP6cbnLmlBAkhbvsOnIm8XNu5Buyt1cFww3SbY/DETB17/+NnQ8j+4IsdKBpKhC4JLxxqVl8Dyp2Q4Nj/nxrMl0v0lRPzypbO8dtU+29dSxXeeY2yeo5woZ7cvE2XUdtJWDQTABP85XOOmjy8ep82L/vM1boH/Q84S0dw/Qb26XzpBa8KhXIjyKCCSIXStdjSFt+oUgzq3LOMDDS9vwqPkbE6wa05q0bgfW4bcz0K7HNhyVYd15+jrLNL7af88hoKhvm3ILTNpvU29wE66lndXDM=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <1263438BAA8BB84AB1EBC1580E1DCB80@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3a232a-50ad-4516-aa63-08d654438602
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 08:37:11.1080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0733
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:44:24PM +0100, Paolo Bonzini wrote:
> On 26/11/18 16:47, Vitaly Kuznetsov wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 5cd5647120f2..b21b5ceb8d26 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -2997,6 +2997,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm,=
 long ext)
> >  	case KVM_CAP_HYPERV_TLBFLUSH:
> >  	case KVM_CAP_HYPERV_SEND_IPI:
> >  	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
> > +	case KVM_CAP_HYPERV_STIMER_DIRECT:
> >  	case KVM_CAP_PCI_SEGMENT:
> >  	case KVM_CAP_DEBUGREGS:
> >  	case KVM_CAP_X86_ROBUST_SINGLESTEP:
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 2b7a652c9fa4..b8da14cee8e5 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -975,6 +975,7 @@ struct kvm_ppc_resize_hpt {
> >  #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
> >  #define KVM_CAP_EXCEPTION_PAYLOAD 164
> >  #define KVM_CAP_ARM_VM_IPA_SIZE 165
> > +#define KVM_CAP_HYPERV_STIMER_DIRECT 166
>=20
> I wonder if all these capabilities shouldn't be replaced by a single
> KVM_GET_HYPERV_SUPPORTED_CPUID ioctl, or something like that.

Hmm, why?  Are we running short of cap numbers?

Capabilities are a well-established and unambiguous negotiation
mechanism, why invent another one?  Besides, not all features map
conveniently onto cpuid bits, e.g. currently we have two versions of
SynIC support, which differ in the way the userspace deals with it, but
not in the cpuid bits we expose in the guest.  IMO such an ioctl would
bring more complexity rather than less.

Roman.
