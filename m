Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA8EC476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB7E20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="FXr7e0if"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB7E20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbeGLQxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:53:50 -0400
Received: from mail-eopbgr680080.outbound.protection.outlook.com ([40.107.68.80]:52501
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbeGLQxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5H5uhCM3045nMCZnTDOAeBJk45dBmz7hMRcDTsDRpQ=;
 b=FXr7e0ifGv7YOfiqvHc/uuaV0E4llXqOb4oWGuDMIi/26/ZTCDNVIhQHlTTzEiHR4XLd4j7wLBHuOkpgMS7q1EMOEqlNFPsDTNr39tq+3RW1bZuPW5KSwjOeuqezkmEhLFn4p6d7nTtOB+CUuoSq96pO9mwH8zj6fN8MdZ7h9E8=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5112.namprd07.prod.outlook.com (20.176.254.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Thu, 12 Jul 2018 16:43:28 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::39ca:4bef:3be8:fdf5]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::39ca:4bef:3be8:fdf5%3]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 16:43:27 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: RE: [PATCH 02/31] usb: usbssp: Added some decoding functions.
Thread-Topic: [PATCH 02/31] usb: usbssp: Added some decoding functions.
Thread-Index: AQHUGaPhZIddO8iCH0aR0BV4Q6TTjKSLGsoAgAAA+mCAAAXlAIAAqcVQ
Date:   Thu, 12 Jul 2018 16:43:27 +0000
Message-ID: <BYAPR07MB47093E425A14049C036D97CFDD590@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
 <1531374448-26532-3-git-send-email-pawell@cadence.com>
 <20180712061030.GB20905@kroah.com>
 <BYAPR07MB4709D8EB760716D0F9B0F4FBDD590@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20180712063506.GA25007@kroah.com>
In-Reply-To: <20180712063506.GA25007@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYjlmNzcwMzMtODVmMi0xMWU4LTg3MTAtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGI5Zjc3MDM1LTg1ZjItMTFlOC04NzEwLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTMyNyIgdD0iMTMxNzU4ODc0MTkzNDQxMjI0IiBoPSJsTnZQTmlsUGdBc2JtbUlrWElvN1UwWXZiSlE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pawell@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5112;7:AdHUV0rWRbWlDJmF0+DwStw/nr4LzBOR5ij9qyKjUHnDk7tRvmIcxfMA9E2DBc3daPclcqj2ErVnG8Px05gi4u71ftn2zvdV//gcGpZgEth2Fgw8SsTVZuB5nMkuppMNuqRDlMXQnejG8jnpv6NbA8YYDEaugPDjIryC9sj3rVjnfjyLc6udR7XpujHMV3y6Vz15Wuz0oPgSY60HF8TE4FVzZNLxBjrAidPpRtKcfaYTkrR59v4WnL/8DD3agObN;20:sbn7A+tkFY07F7STTayo0HQ8ZcMX/zRdPLvsqCkaT1BaEhNZC2mWFTcC1JkGUGl9CUDBNKLmXFIUjl+3rKrN5YB7fGIklsS2hbSqmKmkiuaRBlAoz7MlC7qlLy0TEkUdPIGE+/3kkxrITg/wLvnuB27NbpD7OQxTUajMbqExeMIevGnLWarBgQhdk52J7aUMOD/BEiVs7wlEjvOn723i1l3M5tLAQH+ETDg/5SiSCxEGtjIvgR7LoPyYN64mFnLW
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(36092001)(189003)(199004)(186003)(2900100001)(97736004)(6916009)(105586002)(4326008)(2906002)(5660300001)(256004)(55016002)(54906003)(316002)(66066001)(14454004)(8676002)(9686003)(478600001)(6436002)(76176011)(68736007)(26005)(229853002)(7696005)(6506007)(33656002)(106356001)(107886003)(93886005)(99286004)(81166006)(3846002)(81156014)(11346002)(6116002)(476003)(102836004)(74316002)(53936002)(5250100002)(6246003)(86362001)(486006)(25786009)(446003)(8936002)(305945005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5112;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: a45a960c-81eb-4cf5-ae0d-08d5e81697be
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5112;
x-ms-traffictypediagnostic: BYAPR07MB5112:
x-microsoft-antispam-prvs: <BYAPR07MB51124E9CF9F6C948FBBBB15BDD590@BYAPR07MB5112.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB5112;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5112;
x-forefront-prvs: 0731AA2DE6
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VPtA5VwrqPsB8Z/p+v8gZa+BZP/1AtGz9uXF9BhenaAr8qaUiX/nyRF4LDjHs6nTiq2MiLdZ7vppVFaXd1fXUQAAfBIvJGDmloxYCP1HYzeYi5xQcpbntGfsKDHSiy4kDzhw77s7innbXuOJMzf4kf9uK9aEZ9T5mBEmvAwGyscQRKz4rfXnwrs6OelrDwMyZErLL4Ptink3nGNjb2K60oA5rVAsXIYy/baB5H0/kvoje9cqbuTfyc8WtBlfHRTAtdt43fvfWZmJ04D5ewMoHjqZPOWsqSP/KXwWrFv5txDZ+wvyFbdoVXXyosTWTdDCR949I6tMEDht5yaThT9I+N5dM7CsBN8espXXnD+mxjU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45a960c-81eb-4cf5-ae0d-08d5e81697be
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 16:43:27.4092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > This patch add additional functions that converts some fields to st=
ring.
> > > >
> > > > For example function usbssp_trb_comp_code_string take completion c
> > > > ode value and return string describing completion code.
> > >
> > > Odd line-wrapping :(
> > Do you mean additional space character between "c" and "ode"
>=20
> It wrapped lines at that point for me, yes.
>=20
> > > And why do you want a string for these things?  Who cares about them?
> > It will be used in next version of driver. I have plan to add gadget-de=
bugfs.c
> file.
> > At this moment this functions can be useful during debugging driver if
> > someone want to display some debug information.
> >
> > Should I remove this function ?
>=20
> If no one is using it now, yes, it does not need to be there, right?  We =
don't
> have dead code around for no reason, otherwise someone will come along
> and remove it :)

I checked again, and these functions are used in gadget-trace.h file added =
in [PATCH 03/31].
I didn't want to create too big patch, so I split it into two separate part=
. [PATCH 02/31] add debugging=20
function used in trace* functions, and [PATCH 03/31/] add all trace* functi=
on used in driver.

thanks,

Pawel Laszczak
