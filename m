Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7CA49C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239E0208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V+7IVayB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239E0208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754593AbeFMWuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:50:22 -0400
Received: from mail-pu1apc01on0137.outbound.protection.outlook.com ([104.47.126.137]:31584
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754498AbeFMWuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yCxsG+J9gMSPfVWUnDtqHNQzFo+WgtCpYqhUCnhgCg=;
 b=V+7IVayBiTjvjNdm1GABKMSmus7ZjCwaWm6GTYcUFQ0+96RKouhIx/ntBPnjmeBo0rbJ8JTsUN5XZmkBKSAnMAxMeRDRTtndmF6NeeF7RxdVfCo0/mxSGUN82wYGpFo4yqSWwmiE/qkKo9GZBT0lkCVCZHVFoCY1RrHoD9pS7cM=
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM (10.170.167.17) by
 KL1P15301MB0037.APCP153.PROD.OUTLOOK.COM (10.170.167.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.9; Wed, 13 Jun 2018 22:50:06 +0000
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
 ([fe80::91a9:30c3:c99f:a8bc]) by KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
 ([fe80::91a9:30c3:c99f:a8bc%6]) with mapi id 15.20.0884.010; Wed, 13 Jun 2018
 22:50:06 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     'Bjorn Helgaas' <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'" 
        <driverdev-devel@linuxdriverproject.org>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Thread-Topic: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Thread-Index: AdPyKucLHxE0xn3+RTSKXedSJeHHcgCNtVtQAmSYQFABWDo6wAADvceAAAAiUoA=
Date:   Wed, 13 Jun 2018 22:50:05 +0000
Message-ID: <KL1P15301MB0006CAB372940BA3C42F1C58BF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006EE546A7C2567B61EA783BF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <BN6PR21MB016112A4E32D76EC669818C3CA690@BN6PR21MB0161.namprd21.prod.outlook.com>
 <KL1P15301MB0006D8314C8B40A939598056BF640@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <KL1P15301MB00069C79B0C674695DDBC8AABF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180613221509.GB12463@bjorn-Precision-5520>
In-Reply-To: <20180613221509.GB12463@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-13T22:50:03.3464909Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:c9b:1056:d0e5:5bb1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0037;7:+6+CNQaKfH8gSwvgctHlHrl03zcRJULQSckuL+nDOfGDIhwhExVhmWW0t2HUo+vqQ3l+gWu6s7TebCV75OGu2H6k39U7IYY316RgjiCL/pOOUia44j9soDUd8w9unlSY0HRkdiCuqsGXYmp901RYRvaWm8Lht1rNtBfVbQdox+k6G/M9JnQrSAKlT9u+j++tHWftbNveGsVjIFwEpBlWrE/kpMlVhBctiEKobrLJ4LglFxP1opNkxnwhaJPriajR
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6dbe3ba9-bbfa-4f18-280e-08d5d18001eb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0037;
x-ms-traffictypediagnostic: KL1P15301MB0037:
x-microsoft-antispam-prvs: <KL1P15301MB003767B8B9E4991F30425B2FBF7E0@KL1P15301MB0037.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0037;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0037;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(39380400002)(396003)(189003)(199004)(68736007)(4326008)(5250100002)(54906003)(99286004)(6436002)(476003)(74316002)(478600001)(186003)(8990500004)(53936002)(486006)(9686003)(25786009)(446003)(22452003)(8676002)(11346002)(316002)(8936002)(81156014)(81166006)(6246003)(93886005)(7736002)(10290500003)(305945005)(6116002)(14454004)(2900100001)(55016002)(10090500001)(3660700001)(86362001)(76176011)(2906002)(229853002)(97736004)(59450400001)(6506007)(5660300001)(33656002)(3280700002)(7696005)(46003)(6916009)(7416002)(106356001)(102836004)(86612001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0037;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZUEgvla3YjkuTjdejoFNVi/sPGukdLwqAP1JcJU+3ngV/nuXnj2wpejekP90eotow8g4afz+kYvsCE0YUTUIlEI8235mBVlW+hpqA21zRP2jgEfWHlWOsm1i7enVJmbgmgyf+Y7AZLkvA5B95mS9toJLSaS6IhTqfp08n3RbI/qCLV47ywALmLrzEWSWHZDX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbe3ba9-bbfa-4f18-280e-08d5d18001eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 22:50:05.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, June 13, 2018 15:15
> > ...
> > It looks Lorenzo's pci.git tree has not been updated for 3+ weeks.
> > I guess Lorenzo may be on vacation.
> >
> > @Bjorn, can this patch go through your tree?
> > Should I resubmit it?
>=20
> No need to resubmit it, Lorenzo has been out for a bit, but I'm sure
> he'll pick this up as he catches up.
OK, I see. Thanks!
=20
> You might, however, fix the commit log:
>=20
>   This is not an issue because hv_pci_onchannelcallback() is not slow,
>   and it not a hot path.
>=20
> This has at least one typo (I think you mean "and *is* not a hot
> path").
Sorry -- yes, it's a typo. I hope Lorenzo can help to fix this, or I can
resubmit it if Lorenzo or you want me to do it.
=20
> I also don't understand the sentence as a whole because the
> hv_pci_onchannelcallback() comment says it's called whenever the host
> sends a packet to this channel, and that *does* sound like a hot path.
Sorry for not making it clear.
The host only sends a packet into the channel of the guest when there
is a change of device configuration (i.e. hot add or remove a device), or
the host is responding to the guest's request.

The change of device configuration is only triggered on-demand by the
administrator on the host, and the guest's requests are one-off when
the device is probed.

So IMO the callback is not a hot path.

> I also don't understand the "hv_pci_onchannelcallback() is not slow"
> part.  In other words, you're saying hv_pci_onchannelcallback() is
> fast and it's not a hot path.  And apparently this has something to do
> with the difference between local_bh_disable() and local_irq_save()?
>=20
> Bjorn
Actually in my original internal version of the patch, I did use=20
local_irq_save/restore().

hv_pci_onchannelcallback() itself runs fast, but here since it's in a
loop (i.e. the while (!try_wait_for_completion(&comp.comp_pkt.host_event)
loop), IIRC I was asked if I really need local_irq_save/restore(),
and I answered "not really", so later I switched to local_bh_disable()/enab=
le().

However, recently I found that if we enable CONFIG_PROVE_LOCKING=3Dy,
the local_bh_enable() can trigger a warning because the function=20
hv_compose_msi_msg() can be called with local IRQs disabled (BTW,
hv_compose_msi_msg() can also be called with local IRQS enabled in
another code path):

IRQs not enabled as expected
  WARNING: CPU: 0 PID: 408 at kernel/softirq.c:162 __local_bh_enable_ip

Despite the warning, the code itself can still work correctly, but IMO we'd
better switch back to local_irq_save/restore(), and hence I made the patch.

I hope the explanation sounds reasonable. :-)

Thanks,
-- Dexuan

