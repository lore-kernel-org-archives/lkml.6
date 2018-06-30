Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E44C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA2125355
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="N4w4rEuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA2125355
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeF3SN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 14:13:57 -0400
Received: from mail-sg2apc01on0113.outbound.protection.outlook.com ([104.47.125.113]:47815
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751363AbeF3SNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 14:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHaKsKksbbSyVkJTf3jLYn03aNdf3cOsoid3wjGcftA=;
 b=N4w4rEuFjqzt0oIxZecEYd+lNq9XHWBPs0UrtQVbcVcs+BHCaHZcTJBrSBqudRjS22X5D/sF/w9r5TTV+7QeLZ4D/Df2xCuwbeZ5qFVgKEH8svksNnIufgw4e2bzlG60/HrJYRqnDmgAz1qRVADA3DJ7c4MQtvKcM6F/gRYCYtY=
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM (10.170.167.17) by
 KL1P15301MB0069.APCP153.PROD.OUTLOOK.COM (10.170.168.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.16; Sat, 30 Jun 2018 18:13:40 +0000
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
 ([fe80::91a9:30c3:c99f:a8bc]) by KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
 ([fe80::91a9:30c3:c99f:a8bc%7]) with mapi id 15.20.0930.016; Sat, 30 Jun 2018
 18:13:40 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
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
Thread-Index: AdPyKucLHxE0xn3+RTSKXedSJeHHcgCNtVtQAmSYQFABWDo6wAADvceAAAAiUoADCiLZgABB5qXg
Date:   Sat, 30 Jun 2018 18:13:39 +0000
Message-ID: <KL1P15301MB0006780D045979A760DA4E2BBF4D0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006EE546A7C2567B61EA783BF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <BN6PR21MB016112A4E32D76EC669818C3CA690@BN6PR21MB0161.namprd21.prod.outlook.com>
 <KL1P15301MB0006D8314C8B40A939598056BF640@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <KL1P15301MB00069C79B0C674695DDBC8AABF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180613221509.GB12463@bjorn-Precision-5520>
 <KL1P15301MB0006CAB372940BA3C42F1C58BF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180629093927.GA9576@red-moon>
In-Reply-To: <20180629093927.GA9576@red-moon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-30T18:13:37.0102703Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a27f:df20:b5c6:83a3:b380:1e4c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0069;7:58v4xvEIxquG0kBvkmAZLI4cA9ovz0o8K7wpTKkLFWWea8d1/c/NBgfLc/u1qYAo/49j4Q4GfXcvOknrG7JCQxcO8GWgKmUUGiJP+KuokSwzQ2yN3C/P+gzmPbr5liK+7G+UcAM9F0iPaIjnaN6hFrrhCvSascTCF/5EZx23VLq8VJBtOzFMsg7umk0uWYz/l/VwSsPKL1WxLbiXHZtdLkG++i59C+2M0LVxUFqNxJOr1G5KPCoSW9XPVtb2KxXK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5cdea782-7fa0-4e9f-e1ee-08d5deb534ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:KL1P15301MB0069;
x-ms-traffictypediagnostic: KL1P15301MB0069:
x-microsoft-antispam-prvs: <KL1P15301MB00691A70C4BC0A32BE9C532CBF4D0@KL1P15301MB0069.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0069;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0069;
x-forefront-prvs: 0719EC6A9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(136003)(376002)(366004)(54534003)(189003)(199004)(7696005)(68736007)(5660300001)(2906002)(99286004)(446003)(6116002)(54906003)(476003)(4326008)(86362001)(53546011)(14444005)(6506007)(9686003)(2900100001)(55016002)(86612001)(256004)(97736004)(5250100002)(11346002)(102836004)(316002)(53936002)(478600001)(46003)(81166006)(8676002)(8936002)(305945005)(81156014)(8990500004)(7736002)(7416002)(22452003)(10290500003)(6436002)(486006)(74316002)(33656002)(6916009)(6246003)(76176011)(14454004)(25786009)(105586002)(93886005)(186003)(10090500001)(229853002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0069;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cScOeO9A3YhlBE5OZnwYywLWz5ziuLZj8z7jh+6dcAoivAhhVm23RTrNuPIDQMiR7EFxMfpqGfiCRWS3TSwssIqwAcdcaLdwq9vpO1klLNHrpYlBeWF6ZQRmf8RMZK+56PGIeF1a+K7mIUEpQKJnTziZKFQz2izmgWw5FVHwi4O5Z4DR1Ii7fmhOwROb6pE13bVOTxIrpZ96xob6GdEh7FA2UZVUYZFX54UVCANeFvEOMuSjriVC8Q1H83wsyxDlF6T/QjOV8B3DzepqmGCw87a048uIWHPkAYlgPj+lurF7Cp2FyvyCNi+EuwLIHk2ne4uO2uW7QAvwV44+gGK9EVwKaE4wdjRnPDi3F+4yl2g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdea782-7fa0-4e9f-e1ee-08d5deb534ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2018 18:13:39.5591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Friday, June 29, 2018 02:39
> To: Dexuan Cui <decui@microsoft.com>
> On Wed, Jun 13, 2018 at 10:50:05PM +0000, Dexuan Cui wrote:
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Wednesday, June 13, 2018 15:15
> > > > ...
> > > > It looks Lorenzo's pci.git tree has not been updated for 3+ weeks.
> > > > I guess Lorenzo may be on vacation.
> > > >
> > > > @Bjorn, can this patch go through your tree?
> > > > Should I resubmit it?
> > >
> > > No need to resubmit it, Lorenzo has been out for a bit, but I'm sure
> > > he'll pick this up as he catches up.
> > OK, I see. Thanks!
> >
> > > You might, however, fix the commit log:
> > >
> > >   This is not an issue because hv_pci_onchannelcallback() is not slow=
,
> > >   and it not a hot path.
> > >
> > > This has at least one typo (I think you mean "and *is* not a hot
> > > path").
> > Sorry -- yes, it's a typo. I hope Lorenzo can help to fix this, or I ca=
n
> > resubmit it if Lorenzo or you want me to do it.
> >
> > > I also don't understand the sentence as a whole because the
> > > hv_pci_onchannelcallback() comment says it's called whenever the host
> > > sends a packet to this channel, and that *does* sound like a hot path=
.
> > Sorry for not making it clear.
> > The host only sends a packet into the channel of the guest when there
> > is a change of device configuration (i.e. hot add or remove a device), =
or
> > the host is responding to the guest's request.
> >
> > The change of device configuration is only triggered on-demand by the
> > administrator on the host, and the guest's requests are one-off when
> > the device is probed.
> >
> > So IMO the callback is not a hot path.
> >
> > > I also don't understand the "hv_pci_onchannelcallback() is not slow"
> > > part.  In other words, you're saying hv_pci_onchannelcallback() is
> > > fast and it's not a hot path.  And apparently this has something to d=
o
> > > with the difference between local_bh_disable() and local_irq_save()?
> > >
> > > Bjorn
> > Actually in my original internal version of the patch, I did use
> > local_irq_save/restore().
> >
> > hv_pci_onchannelcallback() itself runs fast, but here since it's in a
> > loop (i.e. the while (!try_wait_for_completion(&comp.comp_pkt.host_even=
t)
> > loop), IIRC I was asked if I really need local_irq_save/restore(),
> > and I answered "not really", so later I switched to
> local_bh_disable()/enable().
> >
> > However, recently I found that if we enable CONFIG_PROVE_LOCKING=3Dy,
> > the local_bh_enable() can trigger a warning because the function
> > hv_compose_msi_msg() can be called with local IRQs disabled (BTW,
> > hv_compose_msi_msg() can also be called with local IRQS enabled in
> > another code path):
> >
> > IRQs not enabled as expected
> >   WARNING: CPU: 0 PID: 408 at kernel/softirq.c:162 __local_bh_enable_ip
> >
> > Despite the warning, the code itself can still work correctly, but IMO =
we'd
> > better switch back to local_irq_save/restore(), and hence I made the pa=
tch.
> >
> > I hope the explanation sounds reasonable. :-)
>=20
> Sorry for the delay in replying. I need to understand if you are
> preventing a spurious lockdep warning or you are fixing a kernel
> bug. From your commit log, I assume the former option but I do
> not think that's what you are really doing.

Now my understanding is:
1) When hv_compose_msi_msg() is called with local irq ENABLED by the upper
level irq code, the current code is good and the lockdep warning is not tri=
ggered.

2) When hv_compose_msi_msg() is called with local irq DISABLED by the upper
level irq code, the current code *is* buggg: local_bh_enable() can potentia=
lly call
do_softirq(), which is not supposed to run when local irq is DISABLED.=20
I think the lockdep warning is triggered for this reason.

In summary, now I realized the warning is not spurious, and here at the fir=
st
place I should not use local_bh_disable()/enable(), which are not supposed =
to
be used when local irq can be DISABLED.

> Apart from the commit log typos fixes I would like a log that
> explains *why* this is not a kernel bug fix rather than a harmless
> lockdep warning prevention.
>=20
> Lorenzo

Now I realized there *is* a bug.
I'm going to send a v2 with a new changelog, though the changed code
will remain the same.=20

Thanks,
-- Dexuan
