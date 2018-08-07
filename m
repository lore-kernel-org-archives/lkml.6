Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AA2C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD9321770
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cA1/duZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD9321770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389121AbeHGPeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:34:10 -0400
Received: from mail-bn3nam01on0063.outbound.protection.outlook.com ([104.47.33.63]:19646
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727605AbeHGPeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHcr5nDyR4XBjKjDFSf8noB8BkQy0j32Q0yCMykocdo=;
 b=cA1/duZ9zQU8/XJdYDKD9PVVR0tuYPkltlny1MMap9kA1ap9xs8Yqpv0brdlNSuHTuFObfahUHdjrYZPFwEy84yB6R1GKAtcWVtqhm0s41sHBgpGg56AuPTqN6Pp3nPPTYYOA/SqqPnqOfnwT66Nb7LvblJ8RWoWrEleOpARQlo=
Received: from SN6PR02MB4862.namprd02.prod.outlook.com (52.135.116.24) by
 SN6PR02MB4015.namprd02.prod.outlook.com (52.135.69.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.19; Tue, 7 Aug 2018 13:19:48 +0000
Received: from SN6PR02MB4862.namprd02.prod.outlook.com
 ([fe80::29ee:2dd6:e6e1:32b]) by SN6PR02MB4862.namprd02.prod.outlook.com
 ([fe80::29ee:2dd6:e6e1:32b%5]) with mapi id 15.20.1017.019; Tue, 7 Aug 2018
 13:19:46 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx
 controller irq with AER
Thread-Topic: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx
 controller irq with AER
Thread-Index: AQHUKbewi3/JYjdOjEeN1+ktKQ2ulKSrMO6AgAgLdQCAARHjoA==
Date:   Tue, 7 Aug 2018 13:19:44 +0000
Message-ID: <SN6PR02MB4862625E305AE74F3E4F11F3A5270@SN6PR02MB4862.namprd02.prod.outlook.com>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533141889-19962-4-git-send-email-bharat.kumar.gogada@xilinx.com>
 <7d5ae8ed-5623-3cd2-7769-77702448b2d6@kernel.org>
 <20180806205614.GC30691@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180806205614.GC30691@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB4015;6:LgWz33LrQXX7HH1rooF3jvm58h9kdPfAO8YVJ8EULcvU/DfzWz3SJ+zgdn3ILa+RPvocTlZ8HmZpNtme/SKzbMWuzbkjT/7bgnuv8ILlixCMtpD71DcYn8U8WhsiYnAKvKlfVZj6d2bYsXfJebfq8AU0Q7Nq1WpNw2YqPE40t/1wVaiYFCqSu60FP6JMIz7aPaAmIJ8VgLs9JMVN9AxPYQ9oCyHovMcJCtVGI/MFyL7a0dBLMLT1YJVPg6UJ1VQlvgiFge7e05EqeY72bRmPyVLym5V6TrBziwyyWgRe05BchH/8+ZnTR9rpI56Xsp5RJ8Z+VgvtNbWwTSguQfP4dsJXODrrlRscNSHotlF81Rhf5Jk1vVMpUjKZ+WwsgEXuW4n/TK3HhOylXZVyeUJPzO9ekii0EtFrSkarKCB+0+LFw56ccWrXzsyu4K0XDaAM9fi8ikvXPGR+nGEYH9V6dA==;5:VZO6QzFvT0+Oomxz83zqRCeCHd0oFZMpE/PbjrT7IIIlzk1Fl1nTSN5cJKGVJaCggcgBQ9kbR1YEIltoxVqYXJoiQI0VuCwnBJXNLAz9avr8ghE+26weoLjEYIJFTvjTaZiBcx9xTd/A6bib4RvGZGdMWDPDEmHkvQlKniGT5z4=;7:Lf+Aczy/YpC6H4itakOoXFvMSaQSwqPVDxKzXjcMKCVai1W4WMOeNF8B4xBEemFPowPCJZ0g/y9rxMnLIQeLt19Hx0BbRneq2qf5xQDX4Z4UIqvyAOImtOhZbElksabPArnkw4Q3DBxXDcWuWPcSAbadtyDr31dNqP/ah7E5n5Qhxq9TrGbe3f3oSR/IWk7BeSixtI0s+gl7Hy3cxnRWZreRykpIMJ3Nzv+vcA9nYmrVPddKmOgrx+nov1wD+M/B
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(107886003)(81156014)(66066001)(8676002)(7696005)(76176011)(68736007)(99286004)(5250100002)(3846002)(6116002)(6246003)(33656002)(97736004)(25786009)(316002)(81166006)(110136005)(54906003)(4326008)(93886005)(5660300001)(186003)(26005)(6436002)(6506007)(2906002)(102836004)(53546011)(2900100001)(9686003)(53936002)(105586002)(55016002)(14454004)(106356001)(8936002)(256004)(229853002)(11346002)(7736002)(446003)(305945005)(486006)(476003)(478600001)(74316002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4015;H:SN6PR02MB4862.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 8b42a884-0a14-46d0-1608-08d5fc687217
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB4015;
x-ms-traffictypediagnostic: SN6PR02MB4015:
x-microsoft-antispam-prvs: <SN6PR02MB4015DA92C560E47045951566A5270@SN6PR02MB4015.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4015;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4015;
x-forefront-prvs: 0757EEBDCA
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dazDI0JXXB1ncojWmt9vfnVeN+le5gPWaku0IhGXqcO2OguwhS9fRFj77llBz7B6MuwEdZYAMJBuDAvnKjZ4PYTX91nUSYakHN1toUOvGblXOgbGOAzzQzGltxo07XclOi9YzcJBKCXjAjSOu3Wht/zaJ9q8dTVHgWQ9AHPmf3rTLjQKuYkIawqNy4J3aBJeTGDM5GMjlU91sSalZBz70y57RDM2Sp7N+oUxbrPsG++A/zIVJl05YEdteTik97wo3wi0SzdDfIdvHkmjbiTvCW5o7bUJSON8X/EfF94g8KYY4FAf+MaFyeNoUtbjHIlC+WdcXvXDb2lQjLhD3GCUGvpINb5Sga4iFlwH3B8obUc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b42a884-0a14-46d0-1608-08d5fc687217
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2018 13:19:45.4730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx
> controller irq with AER
>=20
> On Wed, Aug 01, 2018 at 11:05:09AM -0700, Sinan Kaya wrote:
> > On 8/1/2018 9:44 AM, Bharat Kumar Gogada wrote:
> > > Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
> > > Error Interrupt Message Number. The controller has dedicated
> > > interrupt line for reporting PCIe errors along with AER.
> > >
> > > Using dedicated controller irq number for AER which is shared with
> > > misc interrupt handler in pcie-xilinx-nwl. This irq number is set
> > > using PCI quirk.
> > >
> > > Signed-off-by: Bharat Kumar Gogada<bharat.kumar.gogada@xilinx.com>
> > > ---
> > >   drivers/pci/pcie/portdrv_core.c |    4 ++++
> > >   1 files changed, 4 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/drivers/pci/pcie/portdrv_core.c
> > > b/drivers/pci/pcie/portdrv_core.c index e0261ad..fa9150e 100644
> > > --- a/drivers/pci/pcie/portdrv_core.c
> > > +++ b/drivers/pci/pcie/portdrv_core.c
> > > @@ -264,6 +264,10 @@ static int pcie_device_init(struct pci_dev *pdev=
,
> int service, int irq)
> > >   	int retval;
> > >   	struct pcie_device *pcie;
> > >   	struct device *device;
> > > +#if defined(CONFIG_ARCH_ZYNQMP) &&
> defined(CONFIG_PCIE_XILINX_NWL)
> > > +	if (service =3D=3D PCIE_PORT_SERVICE_AER && pdev->sysdata)
> > > +		irq =3D *(int *)pdev->sysdata;
> > > +#endif
> >
> > I remember seeing a similar patch before.
>=20
> Are you thinking of [1]?
Thanks for reviewing. Yes this case is also similar to [1].=20
I'm not aware of this [1]. I will withdraw this current patches.
Will work on a different model based on your suggestions.

Regards,
Bharat=20
