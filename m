Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2847DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB93208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Qc/ij4U1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB93208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbeK1GET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:04:19 -0500
Received: from mail-eopbgr80102.outbound.protection.outlook.com ([40.107.8.102]:29373
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729277AbeK1GES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNsXYTWThRAYB7IX2I4Dgnb1GP8uIzWV7RiLfGw832Q=;
 b=Qc/ij4U1ShmgHHuozFoqHxWqy1gYOILNxsxmxeX1AoDkXDv9yV66Rexm+j55inIyEjZHydElVrO/ji+EnVAFlXwMty1VRl/dzShkoSFviTGZ4XWzbMKQ17fusqv9Sp+WFhl+MCPjvJwwsOETeOHLu2Oqi8Jjx9bYN2sF1aODLSU=
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com (20.177.61.74) by
 VI1PR08MB3453.eurprd08.prod.outlook.com (20.177.59.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 19:05:11 +0000
Received: from VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2]) by VI1PR08MB3599.eurprd08.prod.outlook.com
 ([fe80::5d2c:980a:d77e:34e2%3]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 19:05:11 +0000
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
Thread-Index: AQHUhZ9mV1oam64KnkyNE5PKjfame6ViQ1QAgAE8eQCAACZZgIAAVtOA
Date:   Tue, 27 Nov 2018 19:05:11 +0000
Message-ID: <20181127190506.GB5147@rkaganip.lan>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-4-vkuznets@redhat.com>
 <e565638e-d6cc-bbd9-f99e-c835ef1be5b7@redhat.com>
 <20181127083706.GB16047@rkaganb.sw.ru>
 <9d0e9796-b71e-9437-8cd4-a898fd503871@redhat.com>
In-Reply-To: <9d0e9796-b71e-9437-8cd4-a898fd503871@redhat.com>
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
x-originating-ip: [2a02:2168:904c:fe00:cfed:f2f6:11c1:3d78]
x-clientproxiedby: HE1PR0902CA0022.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::32) To VI1PR08MB3599.eurprd08.prod.outlook.com
 (2603:10a6:803:85::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3453;20:0B9w28ynj9oBnh6XYCm6ztUKHxOFS7/YTDhfBrP7hC099UCZEaA43byY8sqGOqu61+vySYeLU8aJ1okiE4Mq969KmVdujoKwNKFYmA49jGXjLoX95RwwB19ZCiD0OiwzRW6TpxkSj4AUBPHvJUmU01n52YgqpdPQbbfoddwScm8=
x-ms-office365-filtering-correlation-id: 7bed181c-8fe6-4f03-defe-08d6549b4170
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3453;
x-ms-traffictypediagnostic: VI1PR08MB3453:
x-microsoft-antispam-prvs: <VI1PR08MB34535A3E9AD1EA72CE0679F4C9D00@VI1PR08MB3453.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB3453;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3453;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(136003)(346002)(376002)(366004)(189003)(199004)(51444003)(54094003)(7416002)(478600001)(97736004)(4326008)(486006)(106356001)(33656002)(105586002)(305945005)(6436002)(229853002)(7736002)(68736007)(6486002)(14454004)(6916009)(25786009)(186003)(86362001)(6116002)(1076002)(6512007)(9686003)(71190400001)(71200400001)(316002)(58126008)(93886005)(81156014)(76176011)(446003)(81166006)(8936002)(6506007)(8676002)(386003)(54906003)(2906002)(53546011)(11346002)(5660300001)(476003)(102836004)(256004)(99286004)(33896004)(52116002)(36756003)(53936002)(6246003)(46003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3453;H:VI1PR08MB3599.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nJarVN5m5QfRhhMoaHhx5FRhiJpEFs1G4Zm/Qk4E0IXvQmNux4a/mov/5HsoOan13ReWWkLP3nMir204DjRqCAFNBeXx7EGtj21hcx7Y9dEM8k+pQgtO8qp1UwgWLkHS7qZ0hmrRP/fG/PD9l1LOWFG188qQ6SViAq27DxepE4qg6bvJCSx0Mn5QxXqQ0daHkwbXQKWGKSJBy4Mr8+pOb2hfB/r7mVUVNA5SKfO74z7WsodyxTJn196ZQJ595EqLZt95YRvCV2MudB/ndukzGC1oRFVGjYEnc7vYBsoUjBQRMK1wsneoQLd0q1LQPOLITJNKdb98v5ZexXaR1r4tamfEZObut8UAxBqc3K/q8oQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <F038FB406149404DB80A232F56A68EDC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bed181c-8fe6-4f03-defe-08d6549b4170
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 19:05:11.7676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 02:54:21PM +0100, Paolo Bonzini wrote:
> On 27/11/18 09:37, Roman Kagan wrote:
> > On Mon, Nov 26, 2018 at 05:44:24PM +0100, Paolo Bonzini wrote:
> >> On 26/11/18 16:47, Vitaly Kuznetsov wrote:
> >>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> >>> index 5cd5647120f2..b21b5ceb8d26 100644
> >>> --- a/arch/x86/kvm/x86.c
> >>> +++ b/arch/x86/kvm/x86.c
> >>> @@ -2997,6 +2997,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kv=
m, long ext)
> >>>  	case KVM_CAP_HYPERV_TLBFLUSH:
> >>>  	case KVM_CAP_HYPERV_SEND_IPI:
> >>>  	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
> >>> +	case KVM_CAP_HYPERV_STIMER_DIRECT:
> >>>  	case KVM_CAP_PCI_SEGMENT:
> >>>  	case KVM_CAP_DEBUGREGS:
> >>>  	case KVM_CAP_X86_ROBUST_SINGLESTEP:
> >>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> >>> index 2b7a652c9fa4..b8da14cee8e5 100644
> >>> --- a/include/uapi/linux/kvm.h
> >>> +++ b/include/uapi/linux/kvm.h
> >>> @@ -975,6 +975,7 @@ struct kvm_ppc_resize_hpt {
> >>>  #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
> >>>  #define KVM_CAP_EXCEPTION_PAYLOAD 164
> >>>  #define KVM_CAP_ARM_VM_IPA_SIZE 165
> >>> +#define KVM_CAP_HYPERV_STIMER_DIRECT 166
> >>
> >> I wonder if all these capabilities shouldn't be replaced by a single
> >> KVM_GET_HYPERV_SUPPORTED_CPUID ioctl, or something like that.
> >=20
> > Hmm, why?  Are we running short of cap numbers?
> >=20
> > Capabilities are a well-established and unambiguous negotiation
> > mechanism, why invent another one?  Besides, not all features map
> > conveniently onto cpuid bits, e.g. currently we have two versions of
> > SynIC support, which differ in the way the userspace deals with it, but
> > not in the cpuid bits we expose in the guest.  IMO such an ioctl would
> > bring more complexity rather than less.
>=20
> Yes, in that case (for bugfixes basically) you'd have to use
> capabilities.  But if the feature is completely hidden to userspace
> except for the CPUID bit, it seems like a ioctl would be more consistent
> with the rest of the KVM API.

So there will be some features that are more equal than others?

I think that it's the current scheme which is more consistent: there are
features that are implemented in KVM, and there are caps for negotiating
them with userspace, and then -- separately -- there's a mix of bits to
show to the guest in response to CPUID, which only the userspace has to
bother with.

Thanks,
Roman.
