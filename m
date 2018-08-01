Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957D1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E14A20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tLwDmbRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E14A20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390027AbeHARyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:54:02 -0400
Received: from mail-bl2nam02on0048.outbound.protection.outlook.com ([104.47.38.48]:12211
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732937AbeHARyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kmmOEkqnw0osPMB65f6L+WqIJq3zDTHuFWJiDNLAJk=;
 b=tLwDmbRXK6RJ/NvMEnO7tTzOyZ+SHDDyuoiOqJxtRy9fg0z7rGFFmegGqGRLtE37gVtiRbQkTVTuHkWFJkfhOlBxF9kTeq/NBYgMLwNTV4loj0fjfJteX0gOMjBjFMR3FohK9kZhiM+cP8r3bJ65Ef4tBCokLIwgXHnJjH3r4+s=
Received: from BL0PR02MB4849.namprd02.prod.outlook.com (52.132.14.30) by
 BL0PR02MB4308.namprd02.prod.outlook.com (10.167.172.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 1 Aug 2018 16:07:35 +0000
Received: from BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::78c2:3aaf:600a:cad8]) by BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::78c2:3aaf:600a:cad8%2]) with mapi id 15.20.0995.020; Wed, 1 Aug 2018
 16:07:33 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
Thread-Topic: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
Thread-Index: AQHUGe+qorjjnGNCwk6pQY3qlu/zFKSqDPAAgAEYJUA=
Date:   Wed, 1 Aug 2018 16:07:32 +0000
Message-ID: <BL0PR02MB48498160C3F18B81DC1ED6C1A52D0@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20180731224706.GO45322@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180731224706.GO45322@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4308;6:GjVH/KhqKPi/7yL11fzkCSWGzVCbaw6O6g5rzeW8NC57Mpepxh73oqpzPkh+Wt1MNdwz8Im/ObL5NeMgxuNRUVOcvR7YqGlbM8gfnUaSGNCVNPcv2F99V737LuD+leeaqL1lNw7hwicNWqAepabz1pGQxx/itqmlTLd9Zmy28zyeUBz2C0rMc2488AaTBW5jU7LTQX9LAyCju1z+dUQrFsGxAnkLaviHwn2v/0vt5EcWwOJrLtg0LTObTHOsZ9+sEVJWZVnY8v6HXCBCgNisMt0aZFQ476Q0tvs7Laa1tTN/yMIrBzPdT9whOain8eNWv6WQ6nKqMXcdzF1rYLQK4cYVImSnda1jSn0W8oeTXQqwwReql/CoI6oyobqahvc4LLMRZ++KR4Lz19Z5MN0xFn7rmzk/eCnMoIaS1uh4pEtiIAui+q++TkPyLWvzJyCcIzVKDhN8esj7L14GIaWGsQ==;5:5e+tiAgMhAs1FE28539tYs1KddQZB0fbrNArRUoQMQiavls+ZsBUWkS+C9qvlwt82FhOR4XjhyeV+uY7nhYDaZ9/lqKO3+J//BkxTKYdZ3fsl/gOOVQrvXXjzZ81UwwkrDpMKUwWCaAkBgRnPfFuB41AEKka+Fbz0u7f9ZBo+as=;7:8gq7EKYUAKvwn/xYKmU3y8xD/IbnsTT3Md/QT3/WWecDDQZ5OcLd/qgBuK3mCd27ARPYAHAKtG79w31sYe3xOfqNV6fsFyRIVDTEgvNhjR8Ea48IE5SZViO2DvJYZvnjwun2bzGWoSwpbTMaKVfwiDF3Xt6tByyynvin9MEyd8oN7JuaKZ6EZS21gBvZWD9Lu4ZRwkkEN9ggvrNSy2mlWirGIgdV0VLYdqliREaBtYyLmlea7Dwyn1HZKEluBTVt
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(2900100001)(7696005)(26005)(102836004)(33656002)(186003)(6506007)(105586002)(106356001)(478600001)(74316002)(305945005)(97736004)(7736002)(6916009)(256004)(8676002)(486006)(476003)(81166006)(81156014)(8936002)(76176011)(6116002)(5660300001)(3846002)(14454004)(316002)(6436002)(5250100002)(9686003)(55016002)(107886003)(53936002)(4326008)(6246003)(11346002)(2906002)(229853002)(68736007)(54906003)(99286004)(25786009)(66066001)(446003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4308;H:BL0PR02MB4849.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 2ebfc3ff-05d0-4952-4abd-08d5f7c8e3d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4308;
x-ms-traffictypediagnostic: BL0PR02MB4308:
x-microsoft-antispam-prvs: <BL0PR02MB43082B2770A6ED8C580778C7A52D0@BL0PR02MB4308.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4308;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4308;
x-forefront-prvs: 0751474A44
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: piO+/QqAOcQgHZvblgYpfgkH+iWQRTD/bIY8tmqSSne2NcEzxXUrHqNvPezT9cW815OySmklDQugzyfFbVqTJabYNh1QLkiBsomvU3xbc3JmFxYpQv6ocOXt4olBbJz8SS4V257aNW9WptpU2k91kr3vZzNxVmf3pc7yFT+rgPY3B8MRqhFPmsevzWWqF1acccE/wiW5OolqIb4s/SsCrqQXkevE4/mMcIR9Czs6uywLo5KGKsG/DpN0QtnY9RzWeJRMWWBEEQX/ihP7Qs+5Oi0NGcs8WzYcrsh3Ss8G04BARS8wYHMBRtjEofSUg/06GaZBqf673byY1m1SpDypYO09ezxuR92mC0krKJd+15g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebfc3ff-05d0-4952-4abd-08d5f7c8e3d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2018 16:07:32.8848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

> Subject: Re: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
>=20
> On Thu, Jul 12, 2018 at 08:15:19PM +0530, Bharat Kumar Gogada wrote:
> > Currently PCI_BRIDGE_CTL_SERR is being enabled only in ACPI flow.
> > This bit is required for forwarding errors reported by EP devices to
> > upstream device.
> > This patch enables SERR# for Type-1 PCI device.
>=20
> This does seem broken.
>=20
> Figure 6-3 in PCIe r4.0, sec 6.2.6, would be a helpful reference to inclu=
de in
> the commit log.
Yes, will include it.
>=20
> Semi-related question: there are about 40 drivers that call
> pci_enable_pcie_error_reporting() and
> pci_disable_pcie_error_reporting().  I see that the PCI core calls
> pci_enable_pcie_error_reporting() for Root Ports and Switch Ports in this
> path:
>=20
>   aer_probe                     # for root ports only
>     aer_enable_rootport
>       set_downstream_devices_error_reporting
>         set_device_error_reporting
>           if (ROOT_PORT || UPSTREAM || DOWNSTREAM)
>             pci_enable_pcie_error_reporting
>         pci_walk_bus(..., set_device_error_reporting)
>=20
> But the core doesn't call pci_enable_pcie_error_reporting() for endpoints=
.  I
> wonder why not.  Could we?  And then remove the calls from those drivers?
Yes, enabling error reporting on endpoints by AER driver makes sense as thi=
s is=20
not an optional feature like AER capability.=20
> If PCI_EXP_AER_FLAGS should only be set if the driver is prepared, the
> pci_driver.err_handler would be a good hint.
> But I suspect we could do something sensible and at least report errors e=
ven
> if the driver doesn't have err_handler callbacks.
Yes, at least reporting errors irrespective of err_handler is acceptable.=20
As you mentioned not all drivers are calling pci_enable_pcie_error_reportin=
g ,
if AER service enable's this independent of err_handler,
this would be useful for old endpoint device drivers which are not calling =
this.
PCI_EXP_AER_FLAGS can be set if pci_dev.driver independent of err_handler.
>=20
> On MIPS Octeon, it looks like pcibios_plat_dev_init() does already set
> PCI_EXP_AER_FLAGS for every device.
>=20
> But this question is obviously far beyond the scope of this current patch=
.
>=20
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
> >  1 files changed, 23 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c index
> > a2e8838..943e084 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct
> pci_dev *dev)
> >  	if (!dev->aer_cap)
> >  		return -EIO;
> >
> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
> > +	    dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
>=20
> I think this test needs to be refined a little bit.  If the kernel happen=
s to be
> built with CONFIG_ACPI=3Dy but the current platform doesn't support ACPI,=
 we
> still want to set PCI_BRIDGE_CTL_SERR, don't we?
Agreed, will refine it and resend.

Thanks,
Bharat
