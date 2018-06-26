Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71943C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA7526431
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dee1Fd2A";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XKmeKkRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA7526431
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965264AbeFZCS4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:18:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60316 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965199AbeFZCSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1529979535; x=1561515535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d2nxK7DvLRs9nDI5WmX7Zj8BdyViWFPk49EGoV5h6d8=;
  b=dee1Fd2ADlfm97ix7yQyiRk7kNSaFv9SKuc96QtZSSiEU3j3er708vqF
   RJuNnEyrg3ZnMERlQjAaCQSnVPG2MmjJqjNYr9yd21+7Ly1mqA7XrLD1E
   Gr49tE9ApoTiPPnlAdtgBdktGGZ04c2XLJFRHJ6j2AYEaUMwVIWqOIlYZ
   EZyxA1er6kTl3LU5s1TQpxVpojqq/oWZ63QT/OgDLWSozdTWKuOcLMIzB
   innznYSPfUEj74qp2pBt49wpnrmzR4zzPqTXQHccUfPdNFXyZOaXKm8CX
   E8LQ4h11Tom0iHo4OVUiwnSne3rSv1uwCdhV6bOj3V6XajAj9yAHuHS/C
   g==;
X-IronPort-AV: E=Sophos;i="5.51,272,1526313600"; 
   d="scan'208";a="84374399"
Received: from mail-cys01nam02lp0047.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([207.46.163.47])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2018 10:18:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2nxK7DvLRs9nDI5WmX7Zj8BdyViWFPk49EGoV5h6d8=;
 b=XKmeKkRyTVOB/m9RC3QUAvQWFY/sIhByy58x091V+/1Kv+QoYSfzC6owg2UAd0WWAEJMM3H/IZCw17U844XyGW6+h4pGv51OHCYQEAfxG99E4SsX4M7h09Pk9Uj51cW9IuBBUYy+RPqrJ7O5UcQwK2hW3O0BSazgn22gLycjdTI=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0480.namprd04.prod.outlook.com (10.173.48.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Tue, 26 Jun 2018 02:18:52 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0884.024; Tue, 26 Jun 2018
 02:18:52 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] scsi: check for equality of result byte values
Thread-Topic: [PATCH v3 1/2] scsi: check for equality of result byte values
Thread-Index: AQHUDHa10RnD73ewLEKXcSAlhYVJOKRxzx6A
Date:   Tue, 26 Jun 2018 02:18:52 +0000
Message-ID: <a0a24d883733dbc2dba00bac88f97c674c7b4900.camel@wdc.com>
References: <20180625112059.12872-1-jthumshirn@suse.de>
         <20180625112059.12872-2-jthumshirn@suse.de>
In-Reply-To: <20180625112059.12872-2-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [76.103.130.147]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0480;7:+Xvr2S0KINuGiKcZSQ0Kbk/MwcTtDz6zkPLCW1FsrsiBsjnUQO5sXflxqb8/IoApOvWgEqovu5AFXIlGt6eiFoXW3zyZJu/SMsoOcdtoWEDVnIaujr0RP+Uv2+GLYbUfmVKgFeWW/XIO31HH+0g787RiTu7HTcMEDsDEdmiRiEjOrf8//wvxg7yfCPe0wAMMKgUfY3zrUSpl7v1GrOGYvgEUI0/Jhofs/swu5CPg4d7UWyNFaZoPYCQCNlbr6t5y;20:hZ6yMMFyE1Qpu0rEH83vUuBlduAvVFqcdSU2IXne4CSNKLVrXSjyhAX/JqvUveRQ15S4qAKT5dhfWlRVXZdRV8HCp3zx334uQG01IC/QvTnIw4YB72Zx6ch0YuhUI7Wy1uyiV7PRyQhLngOIMlVS5F8AJvmGAMTej9CphBi6m4g=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a58a4b2c-a7e5-4334-9209-08d5db0b2939
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0480;
x-ms-traffictypediagnostic: MWHPR04MB0480:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0480E24028A3328FF2790BF598490@MWHPR04MB0480.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0480;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0480;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(25786009)(186003)(446003)(4326008)(316002)(8936002)(14454004)(476003)(53936002)(97736004)(486006)(14444005)(66066001)(5660300001)(2906002)(2616005)(72206003)(6246003)(26005)(11346002)(102836004)(99286004)(8676002)(86362001)(118296001)(2900100001)(54906003)(76176011)(6512007)(478600001)(36756003)(3846002)(68736007)(305945005)(6436002)(6506007)(6116002)(81166006)(110136005)(6486002)(7736002)(256004)(2501003)(105586002)(229853002)(81156014)(106356001)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0480;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: l9A1m4lQgsanFkk0e0JWyFSbL/AOzhmTdQloSxZgzIY065iQtvh3dROygMRZHtw/4V06f/ldZTTP6+hohuHvRtA22yaxOpjjzz0w1mCw33URNV0MBh9WnSA4guMhtg0VdvJRUdmTGFdYncPctUt7yJ/vzb8qraAQVfz1vhutKsH09pGpE6wpUINZNZ9uUWVxxBy9zCpnmcZDiUUvGJ0kuWRdyG+z0V5nzP5WOlzPyGuMc44xntqerdNzkyWvrHSeel7Y5mE56pn30ShtckSHSkeTMHptuBrMUjS7e0q4EXZXm5V5bk0VR4SmBf9WY5mNVa5YXYKrW2Civ+/SmiLW/rm+E+GPL5x3oOYnscyvzME=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <07DF630B9255E74E86381C2808DCFC0E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58a4b2c-a7e5-4334-9209-08d5db0b2939
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 02:18:52.4461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0480
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA2LTI1IGF0IDEzOjIwICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IFdoZW4gZXZhbHVhdGluZyBhIFNDU0kgY29tbWFuZCdzIHJlc3VsdCB1c2luZyB0aGUg
ZmllbGQgYWNjZXNzIG1hY3JvcywNCj4gY2hlY2sgZm9yIGVxdWFsaXR5IG9mIHRoZSBmaWVsZHMg
YW5kIG5vdCBpZiBhIHNwZWNpZmljIGJpdCBpcyBzZXQuDQo+IA0KPiBUaGlzIGlzIGEgcHJlcGFy
YXRpb24gcGF0Y2gsIGZvciByZXdvcmtpbmcgdGhlIHJlc3VsdHMgZmllbGQgaW4gdGhlDQo+IFND
U0kgY29tbWFuZC4NCg0KUmV2aWV3ZWQtYnk6IEJhcnQgVmFuIEFzc2NoZSA8YmFydC52YW5hc3Nj
aGVAd2RjLmNvbT4NCg0KDQoNCg0KDQo=
