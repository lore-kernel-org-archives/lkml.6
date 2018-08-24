Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF6BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9791F205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5ayq2AC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9791F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeHXPrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:47:52 -0400
Received: from mail-co1nam03on0073.outbound.protection.outlook.com ([104.47.40.73]:18240
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726803AbeHXPrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpNedyufXrZ2UQMfN7imCIy87eCBrOWS6/GAbjPeWRg=;
 b=5ayq2AC1a8V/4I+u2PYPhLcU3I21NmFtqLBdO4CeTmj/oXDt4bA5mNyh0koL0ZCSWokhQVCe6XMhdcm/gbxkjhD03T5vEJzoiyJ8YSqJvTGflCJeHQccq0swHiuAUEOxz4wVKEoDLpZ+4P/WmB7peaYAQg3oaiVV//O9VGy+Z8Y=
Received: from BL0PR02MB4849.namprd02.prod.outlook.com (52.132.14.30) by
 BL0PR02MB4820.namprd02.prod.outlook.com (52.132.14.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Fri, 24 Aug 2018 12:13:25 +0000
Received: from BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::e42c:5d04:1f44:ad9d]) by BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::e42c:5d04:1f44:ad9d%5]) with mapi id 15.20.1080.015; Fri, 24 Aug 2018
 12:13:25 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "poza@codeaurora.org" <poza@codeaurora.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>
Subject: RE: [PATCH v2] PCI/AER: Enable SERR# forwarding in non ACPI flow
Thread-Topic: [PATCH v2] PCI/AER: Enable SERR# forwarding in non ACPI flow
Thread-Index: AQHUL/IrqlktPMCkeEW4N71tYHp9XKS3hpiAgBdg+NA=
Date:   Fri, 24 Aug 2018 12:13:24 +0000
Message-ID: <BL0PR02MB4849845E4161CDC9BE391EB2A5360@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1533826657-24552-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <2f53b7dd9c1464f40b10217eb64d511e@codeaurora.org>
In-Reply-To: <2f53b7dd9c1464f40b10217eb64d511e@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB4820;6:4l4E/VFE0LLpXny3uSbrx/99s5GniP/axtxfNxbm0XtY0Xcxp9rgkhLeJLnqDcoH8Or2AlHCrE6od0YOcVV6i04+orfogCSa0VyAwVcCzMuGX4UHzu851VV9mJjz5a4F1FgzOu5i7Iawtgyd/vVSf6qd0r5sge56TDrn9nIF2cL/3OaqpCflB5FiT+AR9XXa2qwTEkJ71I4CyGygEeBaJvTj27rspDj0J96ZbjQsHhWpPh8XLKD4md5ZMHqCpqwP36iHUZyJzjh7nseFmV5SyMzykJUcv6iTcZsKejUtqikVeegEVQ2IcrMHvs+QhdHilw7RsfRVG6gCh468ANNlYG/xkmxVByKjEO1jwuDtFP8/sFX4wbUMZbMmQe2gAfnFKQOo7AK5sxZLXiPLZbXeGidI0FezT2Y/9uy+H0Wh/XXClY9Z9vpg1qw3U1eVKzuofDRxzyhMYTQclJHp5bXwPw==;5:O71xczOk2NbFztQxeLkGSJ0QAfSlXDW/NZw5XFNMvLx6Z1U61Wl1EKcv06bp/bF5wDItQRgjmRK8E/3VMsdcU2lM/7D4ORsbKXnozfDNxt2QpueVRaQyGE0jVywsf+F6csh1rcw5eXw5vhKsPdslo1qAOXF0SMuFnN2lggi0Yeg=;7:9fv1oHtzFmGGZAoVb65StMoQJVTFCBPs6YNdDHnzbj88irtrpAGMm05t7btnzUpQe5xuVF+LfJvhUOlHD9C8YR/YIqOEAAQQziCfXPI42nfcFUZTf/jbZNhIdcHCSSDhsY4FGO0ogZPXeEhgtVFATy9WfXLqjCPtAy239C3OUpK1ro8eujYCXsWKe/ujMxzABRHptfIj4s9liQDslH3BfUoQ6ROdfszU6PsUf9sc/VbLS89giAgaY7eyccxR3ODe
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(366004)(346002)(136003)(189003)(199004)(33656002)(54906003)(6346003)(478600001)(76176011)(53546011)(6506007)(2906002)(26005)(68736007)(229853002)(5660300001)(1730700003)(66066001)(7696005)(81156014)(316002)(6916009)(81166006)(86362001)(14454004)(8936002)(74316002)(11346002)(305945005)(9686003)(6436002)(575784001)(446003)(186003)(476003)(486006)(97736004)(102836004)(7736002)(8676002)(2900100001)(99286004)(256004)(55016002)(5640700003)(105586002)(2351001)(106356001)(53936002)(4326008)(3846002)(6116002)(25786009)(6246003)(5250100002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4820;H:BL0PR02MB4849.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 5293c5f0-d3ec-4803-c995-08d609bafe08
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB4820;
x-ms-traffictypediagnostic: BL0PR02MB4820:
x-microsoft-antispam-prvs: <BL0PR02MB482065C5E368AB179B6D0755A5360@BL0PR02MB4820.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR02MB4820;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4820;
x-forefront-prvs: 07749F8C42
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-microsoft-antispam-message-info: 2GYqpGeVgFAsiVgDcK/oGqy+nviHCzWcL6EkVmaiDs409bgIqPL9n3UIMAIo7D6GmLm2x9x/bsmsUSMTLVlkeay3nxrcXCzungZ0esy4jAn6WuJoSaPylu++SJNRKgDJCmYsffpgWiaOH5D6OYk6jrAGcG1Fus5ubUySFl2084SebY8xFNJIuPGnjbIcvKkB3e3tJcPALNlXTvkB72M5FQ8Bn6hQRxsIq49VXp8eqgE6cwSwR1qKN0J/98xB3L1o1nlTXfSN3JrzW523oWmqA1VFg9QGKEVBkURutRjXAGmw5tys/zJIDcK4Ma+Af/fY1UIq7z2gRaLflnLsyWYnWGZAOHZ2KXc4ufyiIv/SP1E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5293c5f0-d3ec-4803-c995-08d609bafe08
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 12:13:24.8268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4820
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v2] PCI/AER: Enable SERR# forwarding in non ACPI flow
>=20
> On 2018-08-09 20:27, Bharat Kumar Gogada wrote:
> > As per Figure 6-3 in PCIe r4.0, sec 6.2.6, ERR_ messages will be
> > forwarded from the secondary interface to the primary interface, if
> > the SERR# Enable bit in the Bridge Control register is set.
> > Currently PCI_BRIDGE_CTL_SERR is being enabled only in ACPI flow.
> > This patch enables PCI_BRIDGE_CTL_SERR for Type-1 PCI device.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
> >  1 files changed, 23 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c index
> > a2e8838..4fb0d24 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -343,6 +343,20 @@ int pci_enable_pcie_error_reporting(struct
> > pci_dev
> > *dev)
> >  	if (!dev->aer_cap)
> >  		return -EIO;
> >
> > +	if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> > +		u16 control;
> > +
> > +		/*
> > +		 * A Type-1 PCI bridge will not forward ERR_ messages
> coming
> > +		 * from an endpoint if SERR# forwarding is not enabled.
> > +		 */
> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> &control);
> > +		if (!(control & PCI_BRIDGE_CTL_SERR)) {
> > +			control |=3D PCI_BRIDGE_CTL_SERR;
> > +			pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
> control);
> > +		}
> > +	}
> > +
> >  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
> > PCI_EXP_AER_FLAGS);  }
> > EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
> > @@ -352,6 +366,15 @@ int pci_disable_pcie_error_reporting(struct
> > pci_dev *dev)
> >  	if (pcie_aer_get_firmware_first(dev))
> >  		return -EIO;
> >
> > +	if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> > +		u16 control;
> > +
> > +		/* Clear SERR Forwarding */
> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> &control);
> > +		control &=3D ~PCI_BRIDGE_CTL_SERR;
> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> > +	}
> > +
> >  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> >  					  PCI_EXP_AER_FLAGS);
> >  }
>=20
>=20
> Hi Bjorn,
>=20
> I made some comments on patchv1., same I am putting it across here.
>=20
> what about hot-plug case ?
> should not aer_init() call pci_enable_pcie_error_reporting() for all the
> downstream pci_dev ?
> and remove all the calls from drivers..
> aer_init will be called for each device (pci_dev) while pciehp does re-
> enumeration.
> so probable we might want to call pci_enable_pcie_error_reporting() but
> that dictates the design where AER framework is taking decision to enable
> error reporting on behalf of drivers as well.
> but thats fine I think, if drivers do not want to participate then they h=
ave to
> call  pci_disable_pcie_error_reporting explicitly.
> does this make sense ?
>=20
Hi Bjorn,
Can you please comment on this.

Bharat
