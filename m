Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B889EC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C25420673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="e5hN3GPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C25420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbeGZOfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:35:06 -0400
Received: from mail-sn1nam01on0071.outbound.protection.outlook.com ([104.47.32.71]:10432
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729506AbeGZOfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgcaXOWcyuSjRT/ImGHt1E12u1B0Uj7MV6XVgE4vKoA=;
 b=e5hN3GPkhE6qwiNiWsnTcrn7CyU2HdJzofWZekkn7ke1HQ45OR9NPLyBA08GUhWGSt8PBO4jA+SdAyurJH4UWucMIRl1FJa0mkZt4k6IlKlLwTJ3lUi+4VweuRCUy7B+6JlbSHVHW4XBxzwIMK3Xc2wCXucE02KldBoqOg7fY3k=
Received: from BL0PR02MB4849.namprd02.prod.outlook.com (52.132.14.30) by
 BL0PR02MB3652.namprd02.prod.outlook.com (52.132.8.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 13:18:10 +0000
Received: from BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::78c2:3aaf:600a:cad8]) by BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::78c2:3aaf:600a:cad8%2]) with mapi id 15.20.0973.022; Thu, 26 Jul 2018
 13:18:10 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "poza@codeaurora.org" <poza@codeaurora.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>
Subject: RE: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
Thread-Topic: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
Thread-Index: AQHUGe+qorjjnGNCwk6pQY3qlu/zFKSMnOsAgACFQpCAAS7hAIAGpKOggAeP1gCABQwiAA==
Date:   Thu, 26 Jul 2018 13:18:10 +0000
Message-ID: <BL0PR02MB48497796A6041471AA692581A52B0@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <b5ba83a0fd8694905528f740a186b891@codeaurora.org>
 <BL0PR02MB4849D9F256912CC9B869A20EA5580@BL0PR02MB4849.namprd02.prod.outlook.com>
 <3bd31b729f9f335fcd906a8164c0a4cb@codeaurora.org>
 <BL0PR02MB4849C990B8C0822ECA45746AA5530@BL0PR02MB4849.namprd02.prod.outlook.com>
 <cba588cfb69aaa933adf2e8a31be6041@codeaurora.org>
In-Reply-To: <cba588cfb69aaa933adf2e8a31be6041@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB3652;6:Hy25+KvWGizljtYPwp+0mcEFmntvZ53GA0+B6QnY+6xPKeJ1aqeBVMm/WxcIckJeECa+8PatNIqmswD/3eAA4xdv9bCGvyMv4AIyOli8GnTY7SsCqxBjUISuYe8Wl3QJb13tjNJj/t4f+FK2t3/L71wTADVYFAN2tkEULaPouTw0mxe2ymqPHWKkNRk9G5QyRlmROujtUvkfbPYzR8WtJi2H2gj9DH0SopPZcTwTEU5MUVB8J8LczQKtz4Bp5KucUWDlOdj5LqNoJ2fcYMO1mKbGzbo/eXLoiunwboc8NORWIpKdCcgVuAx+HE8WCNWZBo/uqypR8BrN7vT62xKvrTFXJ+VpOyCVECnEnbHWaoW33d7DkzsK6Dnfilhq/X5Kkp2atdidQZDxoIpfe/8H5PGn/NTx9POBy2Q9vaGs+dPo6J7Ip8e6osVr6lRIT7vxJFMxO3heS6U16VSfW7N1qg==;5:yGeCjc6ISTF3Aw4+As6+v5FApyWKK37q3qiSLX8YCufnovBJYoc0DEpkNrP5FSxxF84I+LPJ2xybq4nQr1B9Z++yJcuvd9tbkDtijF72/9kn4wOOtNjQ1mUbG2Pf+YFRu3KMPnQqFqsDNY+TRZ3w232g58ud8eUolKwYBJCfKnc=;7:PCGgC2sYeLz6VOH+Kwh0QJi4NaRxM05kHSonYLOThaH3B+n2mifDbX9Syhr0lUOD1S+WBMeXnYk6N+0G1Xy9+3DtGsNtafyOhGPryHGM8xwasKmgRVkm/3OaaymI7EGdSeoRqCp0ZClNmubmJNfPb2R92xf2rtCNdkX7NmOj3VLog31xRyrGdFyA9ePX+B/SgGGThlVW5/DtNbXSdX1aB/IXy2CvVx+up4MGBzDZj/R8HHXed+1+lW+gtvP+1SzZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d9a994c0-6b42-49e4-5a7a-08d5f2fa3c3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB3652;
x-ms-traffictypediagnostic: BL0PR02MB3652:
x-microsoft-antispam-prvs: <BL0PR02MB36525193D8ABF7953372667DA52B0@BL0PR02MB3652.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB3652;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB3652;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(53754006)(305945005)(5640700003)(97736004)(53936002)(74316002)(6246003)(478600001)(2351001)(11346002)(7736002)(25786009)(2900100001)(68736007)(9686003)(4326008)(446003)(6916009)(1730700003)(81166006)(81156014)(33656002)(102836004)(14454004)(26005)(7696005)(5660300001)(76176011)(53546011)(6506007)(486006)(8676002)(476003)(256004)(105586002)(186003)(8936002)(106356001)(99286004)(5250100002)(54906003)(86362001)(2501003)(2906002)(6436002)(93886005)(55016002)(3846002)(6116002)(316002)(66066001)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3652;H:BL0PR02MB4849.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NYE1ASJ/HeYpPocXbIjgXkXHkL72IcMxOHvz8nSViqcyUMDHL14rlz1EBJnEYUxZgDH2MP+tqmwRwGG9OWMFUk/tXsSrysK/aZd7qaTrUTDUnoaIzoZhicMcSH0uDfvQPjaZdDPl2Zh7oqzGgSVL1Oq6ZD59pHmnWB9MiNZF94sUC+uROcs4oFmXV6BNftFvPAakXUjL4EXRjb6NFHZHvIgblNtiopiW4qxiZVOh+ayLVJdzC7sFyGRIUUW0QWob2sGuI/ZpN7dDsMCYiXfDu1+I3ehQVOYBQMFxuf0Wvq56INqgUIj0PBIEwqKEcVWRvPxEXSqKLJtgYjX0ir0lxguJjHdTdgE3Y1cXz2X1Neo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a994c0-6b42-49e4-5a7a-08d5f2fa3c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 13:18:10.8212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3652
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
>=20
> On 2018-07-18 19:04, Bharat Kumar Gogada wrote:
> >> On 2018-07-13 19:25, Bharat Kumar Gogada wrote:
> >> >> > Currently PCI_BRIDGE_CTL_SERR is being enabled only in ACPI flow.
> >> >> > This bit is required for forwarding errors reported by EP
> >> >> > devices to upstream device.
> >> >> > This patch enables SERR# for Type-1 PCI device.
> >> >> >
> >> >> > Signed-off-by: Bharat Kumar Gogada
> >> <bharat.kumar.gogada@xilinx.com>
> >> >> > ---
> >> >> >  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
> >> >> >  1 files changed, 23 insertions(+), 0 deletions(-)
> >> >> >
> >> >> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> >> > index
> >> >> > a2e8838..943e084 100644
> >> >> > --- a/drivers/pci/pcie/aer.c
> >> >> > +++ b/drivers/pci/pcie/aer.c
> >> >> > @@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct
> >> >> > pci_dev
> >> >> > *dev)
> >> >> >  	if (!dev->aer_cap)
> >> >> >  		return -EIO;
> >> >> >
> >> >> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
> >> >> > +	    dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> >> >> > +		u16 control;
> >> >> > +
> >> >> > +		/*
> >> >> > +		 * A Type-1 PCI bridge will not forward ERR_
> messages
> >> >> coming
> >> >> > +		 * from an endpoint if SERR# forwarding is not
> enabled.
> >> >> > +		 */
> >> >> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> >> >> &control);
> >> >> > +		control |=3D PCI_BRIDGE_CTL_SERR;
> >> >> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
> control);
> >> >> > +	}
> >> >> > +
> >> >> >  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
> >> >> > PCI_EXP_AER_FLAGS);  }
> >> >> > EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
> >> >> > @@ -352,6 +365,16 @@ int pci_disable_pcie_error_reporting(struct
> >> >> > pci_dev *dev)
> >> >> >  	if (pcie_aer_get_firmware_first(dev))
> >> >> >  		return -EIO;
> >> >> >
> >> >> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
> >> >> > +	    dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> >> >> > +		u16 control;
> >> >> > +
> >> >> > +		/* Clear SERR Forwarding */
> >> >> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> >> >> &control);
> >> >> > +		control &=3D ~PCI_BRIDGE_CTL_SERR;
> >> >> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
> control);
> >> >> > +	}
> >> >> > +
> >> >> >  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> >> >> >  					  PCI_EXP_AER_FLAGS);
> >> >> >  }
> >> >>
> >> >>
> >> >> Should this configuration no be set by Firmware ? why should Linux
> >> >> dictate it ?
> >> > Hi Oza, Can you please let us know why this should be set by firmwar=
e ?
> >> > Spec clearly states ERR_CORR,ERR_FATAL/NON FATAL will be forwarded
> >> > only if this bit is set.
> >> > If linux AER service is being enabled without checking/setting this
> >> > bit, then AER service will not do anything even ERR_* is seen on lin=
k.
> >> >
> >> > Regards,
> >> > Bharat
> >>
> >>
> >> The ERR_* to be forwarded or not to be forwarded could be decision of
> >> the platform.
> >> hence I think it is best left to firmware to decide if it want to
> >> enable this for particular platform.
> >>
> > I'm not aware of other platforms, can you please give an example of a
> > platform how it decides to set this in firmware ?
> >
> >> although,
> >> There are 2 cases
> >> Hotplug capable bridge and otherwise.
> >
> > Yes, what about an RP which supports only AER but doesn't support
> > Hotplug ?
> > If we have this patch we can set this bit without firmware also.
> >>
> >> 1) If Firmware sets them, I do not think during enumeraion linux will
> >> loose those settings.
> >
> >> 2) I do not see any integration of hotplug with AER currently, so if
> >> the PCIe switch is plugged into Hotplug capable RP, I am not very
> >> sure if this functions get called.
> >>
> >> Keith, Lukas and Bjorn any comments ?
> > Hi all, do you have any inputs on this ?
> >
>=20
> I have thought more on this..but needs separate discussion hence will be
> forking the separate thread.
> If I choose to make some more patches based on this patch, this patch can
> remain as is and will be included with your authorship.
>=20
> Regards,
> Oza.
Thanks Oza.
