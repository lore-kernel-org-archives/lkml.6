Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A120C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989DB20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="N9XJdwHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989DB20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeGLKtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:49:50 -0400
Received: from mail-co1nam03on0049.outbound.protection.outlook.com ([104.47.40.49]:18500
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeGLKtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqSVqwXgrxOYtoOVXt8/aeQMLfHoOERlWhvlwYuc/Ns=;
 b=N9XJdwHv8eF0UVqG9eCT1pJ6iKkfRDWUF1zfettIYWkIdg1pZ0qGRyD5wlKHqJFg4i22pc/fJhgyQCI86gdWlk0tcZRTI33joneuCpp0gwv/JoJ4hCpRUX1UeUDU+Wpjur43xaSYQhD/BAPQGVWHPOzdMbKvvCjCe9Mj/zr8Owg=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4646.namprd07.prod.outlook.com (52.135.204.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 10:40:34 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::39ca:4bef:3be8:fdf5]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::39ca:4bef:3be8:fdf5%3]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 10:40:34 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: RE: [PATCH 04/31] usb: usbssp: Added USBSSP platform driver
Thread-Topic: [PATCH 04/31] usb: usbssp: Added USBSSP platform driver
Thread-Index: AQHUGaPq0/81BJEIZEqY8xB7fIhUAqSLHeeAgABCC2A=
Date:   Thu, 12 Jul 2018 10:40:34 +0000
Message-ID: <BYAPR07MB4709C51CA8652F520AAADC52DD590@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
 <1531374448-26532-5-git-send-email-pawell@cadence.com>
 <20180712062139.GH20905@kroah.com>
In-Reply-To: <20180712062139.GH20905@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMDhlOTk5YTMtODVjMC0xMWU4LTg3MTAtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDA4ZTk5OWE0LTg1YzAtMTFlOC04NzEwLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjU2MCIgdD0iMTMxNzU4NjU2NDc0ODU1Njg2IiBoPSJpalZkY0cwMVJ0TUJMNURDcTNQS1pIaDhFZ289IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pawell@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4646;7:SiTsKGfHwpkhr57PEUH2UjdEBlI0tnx+5OQncooWhUW/p0eJjqzWeR8ohnN2wjhgjaJrplBTUaMxPI0syGH077BmiUJl7ol6eaHnI8bsFZL2o3bIapEpQf8lD0PnnS66tupeFc3Qbg6OROR6R0GMIcoysvL0Hnc1ykFgGXbMLJeYia6mNRHnwui7k+oWekPRb5vjdesEh1K/Zhhjsn7pwiK3ZiFajjKhqAm3SbkWwUYte83QF8re3AJwJIvQp90i;20:1kYjRHsBl5R84PJlayHOCqidmLP82iO7hNNN1JCqgTu9CuGbOdiwyLbCMjBsypS9k5tgJrXBCYpbBcllsetCVFp3lZwCbT8lPCUkU9fIW0TX3bm/2tLo9fPVQ7F/6p5LKUMLDjxhZ2hCmiclYc1vAg3totgVg3WTYhioER13/bgVWAOerRrQtfQUav5M0Ypa7AlHv44ZTPvA8HEuTviv7JGEOJSraeL9i0WLY1yYECh6JiaoODcXmTVvmYJLI8TJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39860400002)(346002)(396003)(199004)(189003)(36092001)(5250100002)(102836004)(66066001)(3846002)(6116002)(229853002)(97736004)(8936002)(25786009)(76176011)(81166006)(68736007)(9686003)(55016002)(6506007)(305945005)(54906003)(8676002)(86362001)(316002)(6436002)(74316002)(81156014)(7696005)(4326008)(14454004)(446003)(33656002)(5660300001)(99286004)(7736002)(106356001)(256004)(6916009)(478600001)(476003)(186003)(2906002)(107886003)(26005)(486006)(11346002)(105586002)(2900100001)(14444005)(53936002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4646;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 98de6d31-295f-45c6-75c6-08d5e7e3e5d9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4646;
x-ms-traffictypediagnostic: BYAPR07MB4646:
x-microsoft-antispam-prvs: <BYAPR07MB4646E0F4208BB2A0277B7E01DD590@BYAPR07MB4646.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4646;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4646;
x-forefront-prvs: 0731AA2DE6
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0zaO7lCX/koXst/uBklQydsO0Vu4uz/QOwycJxUoZlS0kCEjLHBUzwLjhA1Xg40/leA1ojUw4n9Kk8K1G5vVQztAhyaeXrnXDfR5lBqgHTW2u8GeqB3KGID0HcDgyuVPBeihoH1/sSelFmS6RO1AVksgJmKSfmX5V9szjYuPal0pXwG4fqBucqrsV5W7WZsFzTUMT9rZsytCcr5LP5iXNXgGruWv19Qsh6VuPOCRlyw3kU8aOzz60FXKefzpjsBBEiykvTqFBo3/8dzWp/4sVGyOAASZCXJRsxcCaSqmIIi96oQRSHMgDhZgFbLJlZb9/d20pWBshBewhRMRRJOLxP71nV8h9xBCB1Wp1yRPrOk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98de6d31-295f-45c6-75c6-08d5e7e3e5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 10:40:34.0928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4646
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch adds platform driver that is entry point for loading and
> > unloading usbssp.ko modules.
> > It also adds information about this driver to drivers/usb/Kconfig and
> > drivers/usb/Makefile files and create Kconfig and Makefile files in
> > drivers/usb/usbssp directory.
> >
> > Patch also adds template for some function ivokked from usbssp_plat.c
> > file. These function will be implemented in next patches.
> >
> > This patch also introduce usbssp_trb_virt_to_dma that converts virtual
> > address of TRB's to DMA address. In this moment this function is used
> > only in gadget-trace.h.
> >
> > >From this moment the driver can be compiled.
> >
> > Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>=20
> This is a much nicer breakup of the patches than the last series, thanks =
for
> doing it this way.
>=20
> > --- a/drivers/usb/usbssp/gadget.h
> > +++ b/drivers/usb/usbssp/gadget.h
> > @@ -9,7 +9,6 @@
> >   * A lot of code based on Linux XHCI driver.
> >   * Origin: Copyright (C) 2008 Intel Corp.
> >   */
> > -
> >  #ifndef __LINUX_USBSSP_GADGET_H
> >  #define __LINUX_USBSSP_GADGET_H
> >
>=20
> You should have done that in an earlier patch :)
>=20
> > @@ -1671,6 +1670,21 @@ static inline void usbssp_write_64(struct
> > usbssp_udc *usbssp_data,  {
> >  	lo_hi_writeq(val, regs);
> >  }
> > +
> > +/* USBSSP Device controller glue */
> > +int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup);
> > +int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated);
> > +
> > +irqreturn_t usbssp_irq(int irq, void *priv);
> > +
> > +/* USBSSP ring, segment, TRB, and TD functions */ dma_addr_t
> > +usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
> > +		union usbssp_trb *trb);
> > +
> > +/* USBSSP gadget interface*/
> > +int usbssp_gadget_init(struct usbssp_udc *usbssp_data); int
> > +usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
>=20
> Very odd indentation, don't you think?
>=20
> > +MODULE_ALIAS("platform:usbss-gadget");
> > +MODULE_DESCRIPTION("USBSSP' Device Controller (USBSSP) Driver");
> > +MODULE_LICENSE("GPL");
>=20
> Wrong MODULE_LICENSE() string.  Please read module.h for what these all
> should be.

From module.h only these two are correct for this driver:
*	"GPL"				[GNU Public License v2 or later]
 *	"GPL v2"			[GNU Public License v2]

So I'm guessing that "GPL v2" will be better.=20

I will prepare new patch set.

thanks,
Pawel Laszczak
