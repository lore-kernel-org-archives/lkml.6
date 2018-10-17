Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF4ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9184121523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cppGoz8y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Sy5kd6n7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9184121523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeJQQ1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:27:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:55147 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539765187; x=1571301187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8abTBWSzmCh4dOpewUOgeLC1Few4J7EQwKqD9J23hfQ=;
  b=cppGoz8yztYyb1Niuw2TCJTX5OvckYECHKWQI3kIKka3cnNg0qr8Uvm1
   aCgJ9W9RCXSGRgjL+FhPXpHf02+4NrbmxW2tA3tLeTwkXTp3AOCzzo3j2
   A+Xac77iy8W1SUXVG2UTMODn+SkT4VwAk0JrqUGBpYWfVKTSRfVLOwDtX
   gNH3RO5qyhgOyp8NoH6IK8CwrZ6TOXoGr8tuWvxM1bzMcgZLXnTVL5qAB
   09VtvtbjsImaHwuNZg985mWIS/v/1zZuM0p8/L8PHRMniEqhwMIxj9rOU
   7OkJIy57t55DUJAB1DSgu/UVNCBeNSbWrfjsIY2QA0ACoJAxlbsho/ZTr
   g==;
X-IronPort-AV: E=Sophos;i="5.54,391,1534780800"; 
   d="scan'208";a="92140284"
Received: from mail-bl2nam02lp0079.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([207.46.163.79])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2018 16:33:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDJiH3j8Qav1MT946wiP2vrsytpwheFx8uK0b25pw0g=;
 b=Sy5kd6n7+oL+uCEKTszxty/V+vsps5iJOUnUJqoGjbjEjf3vcBp4c6X0bjXhDB5BDiK2byH/OjiqHIZafTyOX5jQijcsBlhjMPrPchXoMSV/zEKhajFeaMJ9TCJLc/AsJBvqtv4HXUPV7kKYXXoJf0LKdeRUWSRcjiq8J5beX18=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4045.namprd04.prod.outlook.com (52.135.82.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Wed, 17 Oct 2018 08:33:02 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b%2]) with mapi id 15.20.1207.029; Wed, 17 Oct 2018
 08:33:02 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>
CC:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V15 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
Thread-Topic: [PATCH V15 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
Thread-Index: AdRl7szyFZC8CAUDQa2Xipmr9m5YCQAAbf9g
Date:   Wed, 17 Oct 2018 08:33:02 +0000
Message-ID: <SN6PR04MB4925A7614D60E58B2E64CBCCFCFF0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <BYAPR08MB4533120DFDB3803DB8B2E8B8DBFF0@BYAPR08MB4533.namprd08.prod.outlook.com>
In-Reply-To: <BYAPR08MB4533120DFDB3803DB8B2E8B8DBFF0@BYAPR08MB4533.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4045;6:bgtwEispmM2xAhfTcg+wEh6JUTwCoFRKByVNOFuypft/MHgg8jNo28wMcOX71U3eixtKOw94bHb6Xa0ZQGTpi+bWxB3uDKpcF06ub1OpPt/51mmq25UVpah3m3fQjDdP9dfPMVEVupnd366+xTSGlKJyrMkVZshqOEs51155mbfNejnAXekb50peygn6GbO8+dXdCnuSlYbSNzlEXAfEhmOK1Cb17WOsPonn+AG2ZX2tZipn62drPXIQnJDLJSbjZcbhpckck5+NYoeDuPUNEPhwWEldLlu/N1sluVjwgNWWEuvQ5kHluUa2LMDd/aidKXliBkXo5WZXdmFEurw7katB46J3KjBRnMZCNxPzqQHjYCNlKXUU8P8nw0j8LduXLsYMr8+C41j9cX798qo/rbzgdUnt2gvVffTOv8IK2X/Hbjgot+sCQxfcgsUw6afWtAlHDV6B+9yMkYfO6BJLxQ==;5:skP4l/eGSgJhiTGlk4PcD+pSE5W0hWJFKknMKd+JkKV6TI1bFTfK3EelF+JEo/9LgpkPWjddDPS92RHWwhpmPAvh+k7lKayWgwN7JzHCfI4necZcDNwaU5PVP/aINQaT0YL0rFuSIUWvEr+fGjssPW7UuI2zgt3pUQnZgeoHx60=;7:c0vtvrfxcfv3a3OHeBo8/vqZFjzBb2BsNoWptSMyLDm0ze7dUZtJ9zJmSjjQpNovnZWfmn8Ogfnjhe/Alv1c86Qoy7fXBpnQTZ1WT3bvTH3v2JinNSW3J3m0995mdW79SjN82KVSYua9/gbFP1HMgDI3OfouLHziNHAS1YfxbljGCzZ9vXPjCl7cvY7R1UYuUhxZxzEAbopYqc0zmZVwvIuV3ArqCWoO+t8KmhoETlV+oUpndx9qRZyl5kI9OTGn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7d569996-4792-45bb-0113-08d6340b274d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4045;
x-ms-traffictypediagnostic: SN6PR04MB4045:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4045C54557F7B2A2B220BEB1FCFF0@SN6PR04MB4045.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR04MB4045;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4045;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(9686003)(6506007)(5660300001)(476003)(7736002)(55016002)(39060400002)(7416002)(316002)(26005)(72206003)(186003)(74316002)(305945005)(478600001)(256004)(14454004)(6116002)(68736007)(53936002)(3846002)(66066001)(486006)(4326008)(2906002)(11346002)(7696005)(33656002)(2900100001)(97736004)(6436002)(25786009)(5250100002)(99286004)(8676002)(81156014)(81166006)(2501003)(8936002)(102836004)(71190400001)(71200400001)(229853002)(54906003)(446003)(105586002)(106356001)(110136005)(2201001)(86362001)(76176011)(6246003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4045;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: fNXKdrZuPv5spErO4qsr1fsd/GG5W2eGsCpPF84Tt9NtNMzxWUqUalYErtdVCp+IgpRx3GrIbtDX+RoYHWN3o+cmLdHn90yTdSLbSiTMSgDsDVLOyfHToQelcVejNHn26c6W18G9vzI37BTRZNtgWy9bGKCq1y848gCrOCI1nkaM7z6BSwDOlrUhkO8SfOjUAfuFJbsTRl3BnVo6qV7ZG9Ze+2fx701GTi+HdBvNxfC/VA0FPo+YaQw7e8dyD7Dxywq9JYMyVcYDrI8iiD2AqbrLHg1L0gTy9NcXzg9Z+v0LaxsODM3u+OlbY7bBsk9mGVAA3htDIwUnk67xcfX3uj1pwx2pdYKKulO/GTZG4j0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d569996-4792-45bb-0113-08d6340b274d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 08:33:02.6815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bean,

> >Usage:
> >1) To read current configuration descriptor with index X
> >   (where index X can be 0/1/2/3) :
> >   cat /config/<device_name>/ufs_config_desc_X
> >
> >2) To write configuration descriptor with index X :
> >   echo <config_desc_buf> > /config/<device_name>/ufs_config_desc_X
> >
> >
> I tested on my platform and got these error:
>=20
> cat /sys/kernel/config/ff3b0000.ufs/ufs_config_desc_0
> 0x90 0x1 0x0 0x1 0x0 0x1 0x7f 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0=20
> 0x1 0x1 0x0 0x3 0x0 0x0 0x0 0x2 0x1 0xc 0x2 0x0 0x0 0x0 0x0 0x0
> 0x1 0x2 0x0 0x3 0x0 0x0 0x0 0x2 0x1 0xc 0x2 0x0 0x0 0x0 0x0 0x0
> 0x1 0x0 0x0 0x3 0x0 0x0 0x0 0x4 0x1 0xc 0x2 0x0 0x0 0x0 0x0 0x0
> 0x1 0x0 0x0  0x0 0x0 0x0 0x1d 0xc7 0x1 0xc 0x2 0x0 0x0 0x0 0x0 0x0
> 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0xc 0x0 0x0 0x0 0x0 0x0 0x0
> 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0xc 0x0 0x0 0x0 0x0 0x0 0x0
> 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0xc 0x0 0x0 0x0 0x0 0x0 0x0
> 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0xc 0x0 0x0 0x0 0x0 0x0 0x0
>=20
> cat /sys/kernel/config/ff3b0000.ufs/ufs_config_desc_1
> [   63.631734] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcod=
e
> 0x01 for idn 1 failed, index 1, err =3D 252
> [   63.643059] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcod=
e
> 0x01 for idn 1 failed, index 1, err =3D 252
> [   63.653602] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcod=
e
> 0x01 for idn 1 failed, index 1, err =3D 252
This actually does not imply an error, just that your device is currently c=
onfigured
With 4 luns (2 of them are bootluns), as config_desc_0 shows.
config_desc_0 also indicate that there are no other config descriptors -=20
the 3rd byte of its header is 0x0.

It would be interesting to test however, a write operation with index 0x1 t=
o this device.
The current code is trying to override the config descriptor with the new c=
onfiguration -=20
That is, it reads it first, and then re-writes it.
I would expect that this will fail if the you are trying to read descriptor=
 with an index that does not exist.

Thanks,
Avri



> cat /sys/kernel/config/ff3b0000.ufs/ufs_config_desc_2
> [   77.946097] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcod=
e
> 0x01 for idn 1 failed, index 2, err =3D 252
> [   77.957212] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcod=
e
> 0x01 for idn 1 failed, index 2, err =3D 252
> [   77.968534] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcod=
e
> 0x01 for idn 1 failed, index 2, err =3D 252
> cat /sys/kernel/config/ff3b0000.ufs/ufs_config_desc_3
> [   82.237656] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcod=
e
> 0x01 for idn 1 failed, index 3, err =3D 252
> [   82.248374] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcod=
e
> 0x01 for idn 1 failed, index 3, err =3D 252
> [   82.259117] ufshcd-hisi ff3b0000.ufs: __ufshcd_query_descriptor: opcod=
e
> 0x01 for idn 1 failed, index 3, err =3D 252
