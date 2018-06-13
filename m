Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B22C5C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E169208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f92qb37g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E169208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935655AbeFMUc3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:32:29 -0400
Received: from mail-hk2apc01on0132.outbound.protection.outlook.com ([104.47.124.132]:11929
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754504AbeFMUc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WSIPZHgIbaPbrIZqcZVds5l7Jax7Xa/tvCd0dHMH58=;
 b=f92qb37gtwkS7+TQPD0MVFTEnjdvny4R2ZHgOLZYRFY+Pj9Kslas7HX8zw/1jDhRBCzelVBndxaFVRHqvaEY151dXMLwbQLMD2g4kdXx6fVP41PPmH0Kd/cZV7/0CteMOADNZC18fxo+U7Zm//+wKuZuhQa+rkznxLAc4kZGZOQ=
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM (10.170.167.17) by
 KL1P15301MB0086.APCP153.PROD.OUTLOOK.COM (10.170.164.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.12; Wed, 13 Jun 2018 20:32:13 +0000
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
 ([fe80::91a9:30c3:c99f:a8bc]) by KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
 ([fe80::91a9:30c3:c99f:a8bc%6]) with mapi id 15.20.0884.010; Wed, 13 Jun 2018
 20:32:13 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     'Bjorn Helgaas' <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'" 
        <driverdev-devel@linuxdriverproject.org>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Thread-Topic: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Thread-Index: AdPyKucLHxE0xn3+RTSKXedSJeHHcgCNtVtQAmSYQFABWDo6wA==
Date:   Wed, 13 Jun 2018 20:32:13 +0000
Message-ID: <KL1P15301MB00069C79B0C674695DDBC8AABF7E0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006EE546A7C2567B61EA783BF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <BN6PR21MB016112A4E32D76EC669818C3CA690@BN6PR21MB0161.namprd21.prod.outlook.com>
 <KL1P15301MB0006D8314C8B40A939598056BF640@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB0006D8314C8B40A939598056BF640@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-23T00:18:18.8931354Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:c9b:1056:d0e5:5bb1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0086;7:9u7oyX30zPApoK7ci1Ris93VkWkCNfOQ+TkbIHqtH+M4lmwSeyzGrwm68pFZhct0nmY+jIUhsTlyqGpiKQUANygpCSlzmZzgIpMJEjJu9NBjPcJrKklFEK7fOiFpoR6P0oOLoAza+9HrK+F6cGVapC8Dy9GFdZKM394n12mHUJ7NHkzQj7eFqlq679drXcUlCMaJVH1zEpSvbY69W0/y8n0TgD9K8Eu1GKZ7wGwm0/lCkAQAk+kxKnC8hCB+11Pk
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91012310-5a5e-4c75-5885-08d5d16cbf35
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0086;
x-ms-traffictypediagnostic: KL1P15301MB0086:
x-microsoft-antispam-prvs: <KL1P15301MB0086604C3D51A7545DA633C7BF7E0@KL1P15301MB0086.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(211936372134217)(153496737603132)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0086;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0086;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(376002)(346002)(366004)(39380400002)(189003)(199004)(9686003)(53936002)(105586002)(8936002)(81156014)(81166006)(86612001)(7416002)(6246003)(5250100002)(8676002)(1511001)(4326008)(229853002)(55016002)(14454004)(68736007)(5660300001)(10090500001)(8990500004)(305945005)(6116002)(7736002)(6436002)(46003)(74316002)(106356001)(102836004)(316002)(54906003)(76176011)(99286004)(2906002)(7696005)(110136005)(25786009)(53546011)(3280700002)(86362001)(446003)(6506007)(22452003)(97736004)(476003)(575784001)(486006)(478600001)(59450400001)(33656002)(11346002)(2900100001)(186003)(10290500003)(3660700001)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0086;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f3lBez3FWwMArhsjeCAAiG7DK4JMXRiluXUQF8mLlx8ZF9jeYVXdme6LXy0EMLDQ6oClEDgYQ3QCvFmiLotQP9vN58qb2gnIjpnE1aSBX4olrcZZOXLyDYzwbzkUgBr80vQvR6q5wCKAKuIWjj2vM3NyHlLXRbrT7kqu5Cajob/vjKiyka/S3vI5+wmj9fKJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91012310-5a5e-4c75-5885-08d5d16cbf35
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 20:32:13.2526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dexuan Cui
> Sent: Wednesday, June 6, 2018 17:15
> To: Haiyang Zhang <haiyangz@microsoft.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>;
> linux-pci@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com
> Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
> vkuznets@redhat.com; marcelo.cerri@canonical.com
> Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
> hv_compose_msi_msg()
>=20
> > From: Haiyang Zhang
> > Sent: Friday, May 25, 2018 12:52
> > To: Dexuan Cui <decui@microsoft.com>; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > linux-pci@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Stephen
> > Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de;
> > apw@canonical.com; jasowang@redhat.com
> > Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.or=
g;
> > vkuznets@redhat.com; marcelo.cerri@canonical.com
> > Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
> > hv_compose_msi_msg()
> >
> > > From: Dexuan Cui
> > > Sent: Tuesday, May 22, 2018 8:18 PM
> > > To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> > > <bhelgaas@google.com>; linux-pci@vger.kernel.org; KY Srinivasan
> > > <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> > > olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com
> > > Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.=
org;
> > > Haiyang Zhang <haiyangz@microsoft.com>; vkuznets@redhat.com;
> > > marcelo.cerri@canonical.com
> > > Subject: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
> > > hv_compose_msi_msg()
> > >
> > >
> > > Commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in
> > hv_compose_msi_msg()")
> > > uses local_bh_disable()/enable(), because hv_pci_onchannelcallback() =
can
> > also
> > > run in tasklet context as the channel event callback.
> > >
> > > With CONFIG_PROVE_LOCKING=3Dy in the latest mainline, or old kernels =
that
> > > don't have commit f71b74bca637 ("irq/softirqs: Use lockdep to assert =
IRQs
> > are
> > > disabled/enabled"), it turns out can we trigger a warning at the begi=
nning
> of
> > > __local_bh_enable_ip(), because the upper layer irq code can call
> > > hv_compose_msi_msg() with local irqs disabled.
> > >
> > > Let's fix the warning by switching to local_irq_save()/restore(). Thi=
s is not an
> > > issue because hv_pci_onchannelcallback() is not slow, and it not a ho=
t path.
> > >
> > > Fixes: de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in
> hv_compose_msi_msg()")
> > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > Cc: <stable@vger.kernel.org>
> > > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > > ---
> >
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > Thanks you.
>=20
> Hi Lorenzo,
>=20
> Can I have your reply to this patch?
>=20
> -- Dexuan

It looks Lorenzo's pci.git tree has not been updated for 3+ weeks.
I guess Lorenzo may be on vacation.=20

@Bjorn, can this patch go through your tree?
Should I resubmit it?

Thanks,
-- Dexuan
