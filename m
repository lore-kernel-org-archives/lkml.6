Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807FFECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305662075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="O+n7Efj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305662075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbeGROMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:12:22 -0400
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:20544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbeGROMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAuDytuoazwACocCIppCtv7rQWYmZch29T/zIu47J0c=;
 b=O+n7Efj5VO2P7jMFn970nZcY0FWt6MwxfvFNSK7tZbcUf9FrGoE2+6DcJCMgIsCsw0wqKCYVD6Q+5A1GIgjf4RRMN3FPGI7/87Bd605eRlIM3bJD+h1ErylsDp+XKeJkWZl/To0+8B8FjkC1sU2ptehNtaqI9FQIM7FBEplt09E=
Received: from BL0PR02MB4849.namprd02.prod.outlook.com (52.132.14.30) by
 BL0PR02MB4643.namprd02.prod.outlook.com (10.167.181.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Wed, 18 Jul 2018 13:34:21 +0000
Received: from BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::78c2:3aaf:600a:cad8]) by BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::78c2:3aaf:600a:cad8%2]) with mapi id 15.20.0952.021; Wed, 18 Jul 2018
 13:34:20 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "poza@codeaurora.org" <poza@codeaurora.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>
Subject: RE: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
Thread-Topic: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
Thread-Index: AQHUGe+qorjjnGNCwk6pQY3qlu/zFKSMnOsAgACFQpCAAS7hAIAGpKOg
Date:   Wed, 18 Jul 2018 13:34:20 +0000
Message-ID: <BL0PR02MB4849C990B8C0822ECA45746AA5530@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <b5ba83a0fd8694905528f740a186b891@codeaurora.org>
 <BL0PR02MB4849D9F256912CC9B869A20EA5580@BL0PR02MB4849.namprd02.prod.outlook.com>
 <3bd31b729f9f335fcd906a8164c0a4cb@codeaurora.org>
In-Reply-To: <3bd31b729f9f335fcd906a8164c0a4cb@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4643;7:J/+asfwbwUyTBUWhEd8o5+nvEvi79NMveaBwE3dxY0ziz7XYSrr5pDtgrdC9WSZpsNOK16iRVc71KwAS7clIGX0zu+vLBB0h2XAI8dr6dpahwANE4L9IoC1EkwBUC49V4m351TvEnpJvURO5Koi8fZ8sAgpo+fiBQ84WUpWA+j8pV7KfM9KSa/eBxibZdbpGo0qT1snViQxm3xHJjJZv0pStgCf9hP3sBDpLooTyvl8pj3Qh7D8bLKQhQ/hatO/I
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e12b39f7-d967-4cfd-cc23-08d5ecb32b21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4643;
x-ms-traffictypediagnostic: BL0PR02MB4643:
x-microsoft-antispam-prvs: <BL0PR02MB464380ABA8C96F6D4C91C651A5530@BL0PR02MB4643.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4643;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4643;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(53754006)(189003)(199004)(5660300001)(8936002)(106356001)(105586002)(186003)(66066001)(9686003)(55016002)(86362001)(93886005)(25786009)(8676002)(99286004)(102836004)(476003)(7696005)(54906003)(26005)(1730700003)(6506007)(4326008)(2501003)(5250100002)(81156014)(76176011)(486006)(2906002)(229853002)(6246003)(81166006)(2351001)(68736007)(6916009)(256004)(478600001)(14454004)(74316002)(6116002)(6436002)(3846002)(446003)(55236004)(53546011)(53936002)(11346002)(7736002)(316002)(97736004)(5640700003)(33656002)(305945005)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4643;H:BL0PR02MB4849.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iAj9QhBgrfvFA7rgDMWh7zDPWbRzsNJekubGKXMKW5XqoUnBRdzhP+j4OU2gcQcTVYNRU5vAd6w3kEt9j/aEB+4Sa9bMOWx5/sz977ohrfoAIKOyEMoX80H6mj4/BGToVmemyA38HIEjCnE8XoaYnUVgm2i9Pwz8h9PpMgGN5DIAbceLGsSrFn/sy1RB7RraqbfwOI5F2b04lHuPvHrucCpHODS02OYhaepGFx1Dkm+aiNSyHMFLZOotfJ0tctEx6IG68OvBlK/2yJfo+5XTZ/a0DhnSc6mtc2R5g+0MjoPdd0nJzuRuDxahscXgGNEdSLQYc/eJG3QJyTla51mJKkK9PVRHX5LJxP6ZFLvDJ8A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12b39f7-d967-4cfd-cc23-08d5ecb32b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 13:34:20.8088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4643
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2018-07-13 19:25, Bharat Kumar Gogada wrote:
> >> > Currently PCI_BRIDGE_CTL_SERR is being enabled only in ACPI flow.
> >> > This bit is required for forwarding errors reported by EP devices
> >> > to upstream device.
> >> > This patch enables SERR# for Type-1 PCI device.
> >> >
> >> > Signed-off-by: Bharat Kumar Gogada
> <bharat.kumar.gogada@xilinx.com>
> >> > ---
> >> >  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
> >> >  1 files changed, 23 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c index
> >> > a2e8838..943e084 100644
> >> > --- a/drivers/pci/pcie/aer.c
> >> > +++ b/drivers/pci/pcie/aer.c
> >> > @@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct
> >> > pci_dev
> >> > *dev)
> >> >  	if (!dev->aer_cap)
> >> >  		return -EIO;
> >> >
> >> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
> >> > +	    dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> >> > +		u16 control;
> >> > +
> >> > +		/*
> >> > +		 * A Type-1 PCI bridge will not forward ERR_ messages
> >> coming
> >> > +		 * from an endpoint if SERR# forwarding is not enabled.
> >> > +		 */
> >> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> >> &control);
> >> > +		control |=3D PCI_BRIDGE_CTL_SERR;
> >> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> >> > +	}
> >> > +
> >> >  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
> >> > PCI_EXP_AER_FLAGS);  }
> >> > EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
> >> > @@ -352,6 +365,16 @@ int pci_disable_pcie_error_reporting(struct
> >> > pci_dev *dev)
> >> >  	if (pcie_aer_get_firmware_first(dev))
> >> >  		return -EIO;
> >> >
> >> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
> >> > +	    dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> >> > +		u16 control;
> >> > +
> >> > +		/* Clear SERR Forwarding */
> >> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> >> &control);
> >> > +		control &=3D ~PCI_BRIDGE_CTL_SERR;
> >> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> >> > +	}
> >> > +
> >> >  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> >> >  					  PCI_EXP_AER_FLAGS);
> >> >  }
> >>
> >>
> >> Should this configuration no be set by Firmware ? why should Linux
> >> dictate it ?
> > Hi Oza, Can you please let us know why this should be set by firmware ?
> > Spec clearly states ERR_CORR,ERR_FATAL/NON FATAL will be forwarded
> > only if this bit is set.
> > If linux AER service is being enabled without checking/setting this
> > bit, then AER service will not do anything even ERR_* is seen on link.
> >
> > Regards,
> > Bharat
>=20
>=20
> The ERR_* to be forwarded or not to be forwarded could be decision of the
> platform.
> hence I think it is best left to firmware to decide if it want to enable =
this for
> particular platform.
>=20
I'm not aware of other platforms, can you please give an example of a platf=
orm=20
how it decides to set this in firmware ?

> although,
> There are 2 cases
> Hotplug capable bridge and otherwise.

Yes, what about an RP which supports only AER but doesn't support Hotplug ?
If we have this patch we can set this bit without firmware also.
>=20
> 1) If Firmware sets them, I do not think during enumeraion linux will loo=
se
> those settings.=20

> 2) I do not see any integration of hotplug with AER currently, so if the =
PCIe
> switch is plugged into Hotplug capable RP, I am not very sure if this fun=
ctions
> get called.
>=20
> Keith, Lukas and Bjorn any comments ?
Hi all, do you have any inputs on this ?

Regards,
Bharat

