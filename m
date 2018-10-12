Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE0BC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C162064E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j+GRDZeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C162064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJMBMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:12:19 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:61856
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbeJMBMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwkJ+EhByoNSQcNva90BVWPZ2BPqXRI9A6x8xe4dSaw=;
 b=j+GRDZeDSiFr23UFrqJNMQExg0PoTARURcABe1peSEKOb29DXYM7MQUgPRlhzkpkkxdAfHe53AGt8dPYUGw8jzKcFMZPFh51PlNp+dKru1QPT8cF/c0ls7H2QbBxqvDDrrVTcbeRDaH+X0QDID4z4lLSiAPKhMv/GwJgDeCc/iM=
Received: from MWHPR21MB0176.namprd21.prod.outlook.com (10.173.52.22) by
 MWHPR21MB0702.namprd21.prod.outlook.com (10.175.142.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.1; Fri, 12 Oct 2018 17:38:42 +0000
Received: from MWHPR21MB0176.namprd21.prod.outlook.com
 ([fe80::8817:5ea6:f97f:aa10]) by MWHPR21MB0176.namprd21.prod.outlook.com
 ([fe80::8817:5ea6:f97f:aa10%2]) with mapi id 15.20.1250.004; Fri, 12 Oct 2018
 17:38:42 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH net-next] hv_netvsc: fix vf serial matching with pci slot
 info
Thread-Topic: [PATCH net-next] hv_netvsc: fix vf serial matching with pci slot
 info
Thread-Index: AQHUYZ8xRe87/5A0vEmtKRlG+pA7h6UbKIcAgAC3MzA=
Date:   Fri, 12 Oct 2018 17:38:42 +0000
Message-ID: <MWHPR21MB017692C5CFF92E2716E322A6CAE20@MWHPR21MB0176.namprd21.prod.outlook.com>
References: <20181011201434.30737-1-haiyangz@linuxonhyperv.com>
 <20181012063620.GA20393@kroah.com>
In-Reply-To: <20181012063620.GA20393@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-12T17:38:38.4276900Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0702;6:Ld9mK5HuRihS93r21/o8+eXbc0abmk7JycktR5y7tZOFKzQGg34sQG23aIzYk5kPhjtmHv7ypgQOQQ95zv7Fs46N5rIkBqpY+ehhVtsFOuSbUEBkAeo2te2vtVLvP987JmhJHV5pR3Y6ITOdFlvLbHFx+vhQ32LdTBBuIEgWFV4YEXr0NlajtHDvdRKMQoGy7F/V3FDHvd8VG2F88zJy+GU9P9WMuNL86qtqYSNZf4+5L7xveirEs/H7DWwrJuekQzzhKOwLHpXjzMXXGMx+kS4YMk+oVSrcQmLyYgverk4ErdRzGxa+yg0aU2dif6B4f+b3CVt7Ee0xV+hmZHTfB8HNcYKAyM6pXxU9L5poly+Y2F1FMvBWX9YC+JZ3nzjyOp3k2v6efD0/wUan8ofWb4kX+GpffMz0H/RP4+qwZ1ku2veE4zFGYbx/Van7VDsIxvBm/EFWqIEAlG2tANDnGw==;5:zZw1pKCWzbT1w8y2WRc1IHL9fC2DBXNzPKbpkuL6aGIc1oAuKnOVlMRSL9hNIiSufzA5iVIvidxAuVFS2OeBTuzOtz1FmoisjRfpxJSswAa/TU9TKx4ArK7FficT5RfcdJBu+F/64k5teYhkbV8VvvfrQDJp1D/iSVLOYouXE00=;7:m3H3e21b5r/SxHekFvrbOd590aM0QsHqKlh3DEdITBK5l/1n5qsn/qjYDHVsHFcZ0xXXikDeUGZLK0L2oBH/rLL+Ym3hmOoa3xcpN0eVz1Q5COcQwkA84sQwykDra8ugJx5ouZyHgbN0AynAKk73Cg==
x-ms-office365-filtering-correlation-id: 1fcc57d7-07ba-4e2c-366a-08d630698d7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0702;
x-ms-traffictypediagnostic: MWHPR21MB0702:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB070234D982920AFDF3409CB2CAE20@MWHPR21MB0702.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:MWHPR21MB0702;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0702;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(376002)(136003)(366004)(13464003)(40224003)(51914003)(189003)(199004)(33656002)(229853002)(8990500004)(68736007)(8936002)(81166006)(81156014)(8676002)(71200400001)(71190400001)(66066001)(2900100001)(6346003)(186003)(26005)(486006)(476003)(11346002)(446003)(97736004)(102836004)(316002)(22452003)(5660300001)(6916009)(86362001)(5250100002)(86612001)(10090500001)(3846002)(6116002)(305945005)(7736002)(53936002)(9686003)(74316002)(6436002)(55016002)(478600001)(10290500003)(14454004)(6246003)(25786009)(2906002)(54906003)(53546011)(6506007)(99286004)(7696005)(105586002)(4326008)(256004)(14444005)(76176011)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0702;H:MWHPR21MB0176.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-message-info: w1kqL7VCQqqcixVJQ6QBIun2Eyn6I4aFQ62p80vpM+blDlIfDKyDWl/6KCdnSmfyQYOYKkAy9rgArqLuwTH9fbIiB4IBGMLcHFtmCuidFcu+Ppn+Fcv3dXf4dzuIcfSvVbj6VAysvEgzH2F25fZQIn7GRAxUxgVSI3xq7MrRkNKqabQ/RZGf1SL+M93W9GenBosbiy56K7SgFeUdz3a2cd2hB+tkinvKAMK/HYnXoPtdKxrq9O4JZKz2LiBKIKnbrDnLR2nN7CWAoVrUaIixthhF6V0eHgvP8jE8/6uPMHhBQW5vzh09WsnYbRagGUNUj1XNl69CDnzrnqRiQoLV5uPB+23+n3ViFv8G6PVSVDM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcc57d7-07ba-4e2c-366a-08d630698d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 17:38:42.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0702
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, October 12, 2018 2:36 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: davem@davemloft.net; netdev@vger.kernel.org; olaf@aepfle.de; Stephen
> Hemminger <sthemmin@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; vkuznets <vkuznets@redhat.com>
> Subject: Re: [PATCH net-next] hv_netvsc: fix vf serial matching with pci =
slot info
>=20
> On Thu, Oct 11, 2018 at 08:14:34PM +0000, Haiyang Zhang wrote:
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > The VF device's serial number is saved as a string in PCI slot's kobj
> > name, not the slot->number. This patch corrects the netvsc driver, so
> > the VF device can be successfully paired with synthetic NIC.
> >
> > Fixes: 00d7ddba1143 ("hv_netvsc: pair VF based on serial number")
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/net/hyperv/netvsc_drv.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/hyperv/netvsc_drv.c
> > b/drivers/net/hyperv/netvsc_drv.c index 9bcaf204a7d4..8121ce34a39f
> > 100644
> > --- a/drivers/net/hyperv/netvsc_drv.c
> > +++ b/drivers/net/hyperv/netvsc_drv.c
> > @@ -2030,14 +2030,15 @@ static void netvsc_vf_setup(struct work_struct
> *w)
> >  	rtnl_unlock();
> >  }
> >
> > -/* Find netvsc by VMBus serial number.
> > - * The PCI hyperv controller records the serial number as the slot.
> > +/* Find netvsc by VF serial number.
> > + * The PCI hyperv controller records the serial number as the slot kob=
j name.
> >   */
> >  static struct net_device *get_netvsc_byslot(const struct net_device
> > *vf_netdev)  {
> >  	struct device *parent =3D vf_netdev->dev.parent;
> >  	struct net_device_context *ndev_ctx;
> >  	struct pci_dev *pdev;
> > +	u32 serial;
> >
> >  	if (!parent || !dev_is_pci(parent))
> >  		return NULL; /* not a PCI device */ @@ -2048,16 +2049,22
> @@ static
> > struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev=
)
> >  		return NULL;
> >  	}
> >
> > +	if (kstrtou32(pdev->slot->kobj.name, 10, &serial)) {
>=20
> kobject_name()?
>=20
> And that feels _very_ fragile to me.  This is now an api that you are
> guaranteeing will never change?

Thanks for the suggestion -- I will update it to use kobject_name() to=20
access the name.

For stability, the VF NIC's serial numbers are always unique according
to the Hyper-V documents. Other devices may have same numbers,
but they are not handled by netvsc driver.

Thanks,
- Haiyang

