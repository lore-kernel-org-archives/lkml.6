Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A89DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2B4218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="gLhhAgOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbfAaPjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:39:41 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:52364 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731033AbfAaPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1548949138; x=1580485138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h3i9TM3SU56aKVfA+MZDvvbDmPzVkpYDC7tUFCDqctw=;
  b=gLhhAgOQFOXJiBhRAAqI1iV3Mxye6+ekyyVU0xMjSHRBs+quynWP3zMK
   eJxRqHGRKZabWj12wrc49YII4tkFUAEae9b5cf6bIJsj39OWMRZ/sSXso
   pm/n753JSwxuDw6+cjINi5kNNjnS61nT5VYMXWv8PPjackqsBzdSqVS3F
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EDAAANFlNchyWd50NjGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUQUBAQEBCwGCWYEUJwqME1+LFIINiSaJWYUPFIFnCwEBhGw?=
 =?us-ascii?q?Cgw8iNAkNAQMBAQIBAQIBAQIQAQEBCgsJCCkvgjoigm8BAQEEElwLDAQCAQg?=
 =?us-ascii?q?RBAEBAS4hLggCBAENBQgagwCBagMVoDM9AoFuiQcBAQGCHogFDYIejECCFoQ?=
 =?us-ascii?q?jgleBdwESAQOFfAKLdIR7kT8zBwKOe4MyIYFrhT6LFC2Jc4ZTilsCBAIEBQI?=
 =?us-ascii?q?UgUaBHnFwUIJsgicOCROOC0ABMY1OgR+BHwEB?=
X-IPAS-Result: =?us-ascii?q?A2EDAAANFlNchyWd50NjGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?QUBAQEBCwGCWYEUJwqME1+LFIINiSaJWYUPFIFnCwEBhGwCgw8iNAkNAQMBA?=
 =?us-ascii?q?QIBAQIBAQIQAQEBCgsJCCkvgjoigm8BAQEEElwLDAQCAQgRBAEBAS4hLggCB?=
 =?us-ascii?q?AENBQgagwCBagMVoDM9AoFuiQcBAQGCHogFDYIejECCFoQjgleBdwESAQOFf?=
 =?us-ascii?q?AKLdIR7kT8zBwKOe4MyIYFrhT6LFC2Jc4ZTilsCBAIEBQIUgUaBHnFwUIJsg?=
 =?us-ascii?q?icOCROOC0ABMY1OgR+BHwEB?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jan 2019 09:38:54 -0600
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VFbovd009461;
        Thu, 31 Jan 2019 10:38:53 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2qc2a9gkqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 10:38:53 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxipps310.us.dell.com ([143.166.148.211])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 Jan 2019 21:38:05 +0600
X-LoopCount0: from 10.166.132.169
X-IronPort-AV: E=Sophos;i="5.56,545,1539666000"; 
   d="scan'208";a="313068159"
To:     <2pi@mok.nu>, <andy.shevchenko@gmail.com>
CC:     <dvhart@infradead.org>, <andy@infradead.org>,
        <mjg59@srcf.ucam.org>, <pali.rohar@gmail.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] platform/x86: wmi: use MODULE_DEVICE_TABLE()
 instead of MODULE_ALIAS()
Thread-Topic: [PATCH v3 3/3] platform/x86: wmi: use MODULE_DEVICE_TABLE()
 instead of MODULE_ALIAS()
Thread-Index: AQHUuK6uTgian2NWo0SKFPJZJW2EmqXIWdAAgAGLhYD//59jEA==
Date:   Thu, 31 Jan 2019 15:38:50 +0000
Message-ID: <65c868f6bfa1489b941047c6416a8002@ausx13mpc120.AMER.DELL.COM>
References: <cover.1548860212.git.2pi@mok.nu>
 <830f6043839606c6ed04dfeaceeb0ce4d9cd1b54.1548860212.git.2pi@mok.nu>
 <CAHp75VeRVThOnL8Lo2TENB0zdcW1Sd00CL88ha6h+QGceBr7sg@mail.gmail.com>
 <20190131152428.lnoy3ibxipnwlxxu@mok.nu>
In-Reply-To: <20190131152428.lnoy3ibxipnwlxxu@mok.nu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mattias Jacobsson <2pi@mok.nu>
> Sent: Thursday, January 31, 2019 9:24 AM
> To: Andy Shevchenko
> Cc: Limonciello, Mario; Darren Hart; Andy Shevchenko; Matthew Garrett; Pa=
li
> Roh=E1r; Platform Driver; Linux Kernel Mailing List; 2pi@mok.nu
> Subject: Re: [PATCH v3 3/3] platform/x86: wmi: use MODULE_DEVICE_TABLE()
> instead of MODULE_ALIAS()
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On 2019-01-30, Andy Shevchenko wrote:
> > On Wed, Jan 30, 2019 at 5:15 PM Mattias Jacobsson <2pi@mok.nu> wrote:
> > >
> > > WMI drivers can if they have specified an array of struct wmi_device_=
id
> > > use the MODULE_DEVICE_TABLE() macro to automatically generate the
> > > appropriate MODULE_ALIAS() output. Thus avoiding to keep both the arr=
ay
> > > of struct wmi_device_id and the MODULE_ALIAS() declaration(s) in sync=
.
> > >
> > > Change all drivers that have specified an array of struct wmi_device_=
id
> > > to use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS().
> >
> > Please, split this per driver basis. It would help in maintenance phase=
...
>=20
> Sure.
>=20
> >
> > > Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
> >
> > > Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
> >
> > ...and AFAIU Mario gave his tag only for Dell related stuff.
>=20
> Yes, that is correct. I applied the same reasoning as for the Acked-by:
> tag in [1]: "Acked-by: does not necessarily indicate acknowledgement of
> the entire patch.". Was that incorrect?
>=20
> Anyway, now that we are splitting the patch up;
>=20
> Mario: which files did you give the tag for? all involved *dell* files?

Yes.

>=20
> >
> > > ---
> > >  drivers/platform/x86/dell-smbios-wmi.c       | 2 +-
> > >  drivers/platform/x86/dell-wmi-descriptor.c   | 2 +-
> > >  drivers/platform/x86/dell-wmi.c              | 4 ++--
> > >  drivers/platform/x86/huawei-wmi.c            | 3 +--
> > >  drivers/platform/x86/intel-wmi-thunderbolt.c | 2 +-
> > >  drivers/platform/x86/wmi-bmof.c              | 2 +-
> > >  6 files changed, 7 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/platform/x86/dell-smbios-wmi.c
> b/drivers/platform/x86/dell-smbios-wmi.c
> > > index cf2229ece9ff..c3ed3c8c17b9 100644
> > > --- a/drivers/platform/x86/dell-smbios-wmi.c
> > > +++ b/drivers/platform/x86/dell-smbios-wmi.c
> > > @@ -277,4 +277,4 @@ void exit_dell_smbios_wmi(void)
> > >         wmi_driver_unregister(&dell_smbios_wmi_driver);
> > >  }
> > >
> > > -MODULE_ALIAS("wmi:" DELL_WMI_SMBIOS_GUID);
> > > +MODULE_DEVICE_TABLE(wmi, dell_smbios_wmi_id_table);
> > > diff --git a/drivers/platform/x86/dell-wmi-descriptor.c
> b/drivers/platform/x86/dell-wmi-descriptor.c
> > > index 072821aa47fc..14ab250b7d5a 100644
> > > --- a/drivers/platform/x86/dell-wmi-descriptor.c
> > > +++ b/drivers/platform/x86/dell-wmi-descriptor.c
> > > @@ -207,7 +207,7 @@ static struct wmi_driver dell_wmi_descriptor_driv=
er =3D {
> > >
> > >  module_wmi_driver(dell_wmi_descriptor_driver);
> > >
> > > -MODULE_ALIAS("wmi:" DELL_WMI_DESCRIPTOR_GUID);
> > > +MODULE_DEVICE_TABLE(wmi, dell_wmi_descriptor_id_table);
> > >  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
> > >  MODULE_DESCRIPTION("Dell WMI descriptor driver");
> > >  MODULE_LICENSE("GPL");
> > > diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/d=
ell-wmi.c
> > > index 16c7f3d9a335..0602aba62b3f 100644
> > > --- a/drivers/platform/x86/dell-wmi.c
> > > +++ b/drivers/platform/x86/dell-wmi.c
> > > @@ -50,8 +50,6 @@ MODULE_LICENSE("GPL");
> > >
> > >  static bool wmi_requires_smbios_request;
> > >
> > > -MODULE_ALIAS("wmi:"DELL_EVENT_GUID);
> > > -
> > >  struct dell_wmi_priv {
> > >         struct input_dev *input_dev;
> > >         u32 interface_version;
> > > @@ -738,3 +736,5 @@ static void __exit dell_wmi_exit(void)
> > >         wmi_driver_unregister(&dell_wmi_driver);
> > >  }
> > >  module_exit(dell_wmi_exit);
> > > +
> > > +MODULE_DEVICE_TABLE(wmi, dell_wmi_id_table);
> > > diff --git a/drivers/platform/x86/huawei-wmi.c
> b/drivers/platform/x86/huawei-wmi.c
> > > index 59872f87b741..52fcac5b393a 100644
> > > --- a/drivers/platform/x86/huawei-wmi.c
> > > +++ b/drivers/platform/x86/huawei-wmi.c
> > > @@ -201,8 +201,7 @@ static struct wmi_driver huawei_wmi_driver =3D {
> > >
> > >  module_wmi_driver(huawei_wmi_driver);
> > >
> > > -MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
> > > -MODULE_ALIAS("wmi:"AMW0_EVENT_GUID);
> > > +MODULE_DEVICE_TABLE(wmi, huawei_wmi_id_table);
> > >  MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
> > >  MODULE_DESCRIPTION("Huawei WMI hotkeys");
> > >  MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c
> b/drivers/platform/x86/intel-wmi-thunderbolt.c
> > > index 9ded8e2af312..4dfa61434a76 100644
> > > --- a/drivers/platform/x86/intel-wmi-thunderbolt.c
> > > +++ b/drivers/platform/x86/intel-wmi-thunderbolt.c
> > > @@ -88,7 +88,7 @@ static struct wmi_driver intel_wmi_thunderbolt_driv=
er =3D {
> > >
> > >  module_wmi_driver(intel_wmi_thunderbolt_driver);
> > >
> > > -MODULE_ALIAS("wmi:" INTEL_WMI_THUNDERBOLT_GUID);
> > > +MODULE_DEVICE_TABLE(wmi, intel_wmi_thunderbolt_id_table);
> > >  MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
> > >  MODULE_DESCRIPTION("Intel WMI Thunderbolt force power driver");
> > >  MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/w=
mi-
> bmof.c
> > > index c4530ba715e8..8751a13134be 100644
> > > --- a/drivers/platform/x86/wmi-bmof.c
> > > +++ b/drivers/platform/x86/wmi-bmof.c
> > > @@ -119,7 +119,7 @@ static struct wmi_driver wmi_bmof_driver =3D {
> > >
> > >  module_wmi_driver(wmi_bmof_driver);
> > >
> > > -MODULE_ALIAS("wmi:" WMI_BMOF_GUID);
> > > +MODULE_DEVICE_TABLE(wmi, wmi_bmof_id_table);
> > >  MODULE_AUTHOR("Andrew Lutomirski <luto@kernel.org>");
> > >  MODULE_DESCRIPTION("WMI embedded Binary MOF driver");
> > >  MODULE_LICENSE("GPL");
> > > --
> > > 2.20.1
> > >
> >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
>=20
> Thanks,
> Mattias
