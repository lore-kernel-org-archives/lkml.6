Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEE0C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705522080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p/nnKH6e";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NCwR363g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfBEMH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:07:28 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24351 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBEMH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549368448; x=1580904448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pi/909+xRDAsMnjgVroFIl15Jrf05vF347cI8EZm4Qs=;
  b=p/nnKH6eQkdU9dbhYBxE478mPcMW8HEx3vHipb23bm+1ej4FtGuJVpm7
   BAuOC9xCIbgZ4X5iu1nj2Ac84/Im9q1bK8OlprMCdm7snRNzNv9oov8sH
   FJHsrR7BLUm6iDAlxXWjvHZFWvS8u7sAPRxFIvBnS66EID9pBYgSuWHq6
   O2895iFkLlH9D5TMyJ7iGLBdlu+eZJq2C3wvPBeV3TmDSjEcQo5pE8xtn
   kuFwVSMIfKQlvNCADUCi1Wi4gAbkBYYiyxUwbHeAnsy3L0VCfqGq2ykD4
   J6e6QTGauxfG3AxKcFvfLlu1xVObJ50EHAkpti++ww3zNlVzFu0/ApFjp
   w==;
X-IronPort-AV: E=Sophos;i="5.56,563,1539619200"; 
   d="scan'208";a="101824704"
Received: from mail-sn1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.51])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2019 20:07:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi/909+xRDAsMnjgVroFIl15Jrf05vF347cI8EZm4Qs=;
 b=NCwR363g4SPXwkxRy7Lrf9ci4rE/jOaX2ymVJa7DkHGDdxP5WF4DIgQYrsu39DWI1pLUZC+7XAnohJWXXfbT4JNNCqqvTOj5bIV+U3lLLGeK/saSqw3ciJtBwAR4PQ9DReo/FwLDuNmNv1iwtBcBv4euYTYlMfJrEnREyYaiEhs=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5136.namprd04.prod.outlook.com (52.135.116.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Tue, 5 Feb 2019 12:07:25 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 12:07:25 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Evan Green <evgreen@chromium.org>
Subject: RE: [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
Thread-Topic: [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
Thread-Index: AQHUtg8jpd6bmkKdmkCBoLq0HKAzQaXFBk8AgAwjyaA=
Date:   Tue, 5 Feb 2019 12:07:25 +0000
Message-ID: <SN6PR04MB4925C574E60B3BA44DD6E0A0FC6E0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1548572868-12589-1-git-send-email-avri.altman@wdc.com>
 <1548572868-12589-4-git-send-email-avri.altman@wdc.com>
 <CAE=gft6mLsW-iEBZ9pFRWWyDQz_gCs20_4JBoBzxL1tYv0rbYg@mail.gmail.com>
In-Reply-To: <CAE=gft6mLsW-iEBZ9pFRWWyDQz_gCs20_4JBoBzxL1tYv0rbYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB5136;6:tExV8IonwsBwaBq0DeShZTP/YQMxc9LKuRQuws165i6ScM8c4lvvFj43HM76BD1QnXYiCAke2T5c5o68YX3ajyOfge1gJPnA/KrgGNy8tgHSiphRbrxvbXjTAKzsNK9pn+CYaou0B6CpNfuvIl9RnUWQxIJC0hnQ2kbE4Hy/WRTp0Cldt5pgZM8hOQGpaAKTTsP9qAV0d9gy670A2yjws9Z6UgyVrWZJl9Hrnf8CYVKCdo1vSeRikOd9OYPtH04WD1uMCPf7Ka3UzJ4pOeQ6rFVt5VAk8HUTET0o5vq4UaoyUlG7zIMoSCdBGhnsiivQJVW2YP40+S8ph1unAK+HFvUy2TuiwwDmwlWexK7zcwhzpIf6j6AptNPdKkI3HIcltYiLS+AGW5M7IdOQL3Pyt2XRQVqMO169+roHkFA2txcI9YmLXc3QjNrOKMaE8T4Fl369fYfzEXZCrRlCMUOevw==;5:a88zuDg7OiyoYsT19BMV4EB8tfyfTi1ngtYHVhYaj41AH8U3usxGkrbfXnh4dFXJ2vxU7SGiS0DO7cauGoKKSOfUj/K4p5edKv7nHzl2s+o4Tja2P9OcSyv+1U/AquS62mmH9FenXeKjSB659SbVw3xofgSf/RhXyISWh30hsjxqvnHTniHxGRpB535N01b1DQPr8SnytZvTn6HmBAN44Q==;7:gjSJQ9NFIyqmOeE5BhayrO5459dmf8JqOV6pTPS4038L7vNV9jj8zh9xj7y6Rnhi12u4n2WamkRJkiLgEw9ZM6vaQT04pe7I1xvaEh/w50bdCoRw6jrX2RO20wH0cvbAh99luF22jiopUsJdBCaO1g==
x-ms-office365-filtering-correlation-id: 33d16bfe-95b2-40db-3582-08d68b627e2b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB5136;
x-ms-traffictypediagnostic: SN6PR04MB5136:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB513619DAC37C9058587C0F80FC6E0@SN6PR04MB5136.namprd04.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(376002)(136003)(396003)(189003)(13464003)(199004)(4744005)(2906002)(6436002)(6506007)(53546011)(6246003)(106356001)(486006)(4326008)(102836004)(33656002)(105586002)(256004)(186003)(53936002)(55016002)(3846002)(229853002)(14444005)(26005)(6116002)(97736004)(81156014)(9686003)(7696005)(7736002)(6916009)(76176011)(54906003)(68736007)(305945005)(71200400001)(81166006)(71190400001)(8936002)(14454004)(446003)(86362001)(316002)(11346002)(476003)(72206003)(25786009)(99286004)(8676002)(66066001)(478600001)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5136;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 58SxAS0cRFlrBwbAj9DXCPkCGHG4LGqFgQcYysPuFHtkzsE+ScGpwsK3ZvmtYegBqx3/Pnxaw+ZMntd5Emmn2jExPHbnh1hywgu/AL36zgRHH1AyQS2PopZjzAhdIZ5AHC48WhlVzIyIb6bpuZb9Acz1NcBI9Cihfbl8i60IBUMKjy37zdP5slH3C6SWv5wVU3e6UXDsyPUzhQAy7WYyYOcASh4SvsjeIs+BKQ10JFFGbLMjaICrVW/1cprD3aAekxElKlPQVeODPF+j8VvVh5c+OEIVat3D/dhASTjEyK0oqlmsdtX8VvOBGFoXeQndvLcF9W5QNxjw+zAY7x/oIVf9unxjPsy3vozmbrp8jXyOhHDphNEK/3XRll2VcOBNn0vtUXJKDq/Ug8/pEuRFPylsnzE2cIzw20QXwNMilY4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d16bfe-95b2-40db-3582-08d68b627e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 12:07:25.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFydGluLA0KQW55IGZ1cnRoZXIgY29tbWVudHM/DQoNClRoYW5rcywNCkF2cmkNCg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEV2YW4gR3JlZW4gPGV2Z3JlZW5AY2hy
b21pdW0ub3JnPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjgsIDIwMTkgODo0MiBQTQ0KPiBU
bzogQXZyaSBBbHRtYW4gPEF2cmkuQWx0bWFuQHdkYy5jb20+DQo+IENjOiBKYW1lcyBFLkouIEJv
dHRvbWxleSA8amVqYkBsaW51eC52bmV0LmlibS5jb20+OyBNYXJ0aW4gSy4gUGV0ZXJzZW4NCj4g
PG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPjsgU0NTSSA8bGludXgtc2NzaUB2Z2VyLmtlcm5l
bC5vcmc+OyBMS01MDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgQXZpIFNoY2hp
c2xvd3NraSA8QXZpLlNoY2hpc2xvd3NraUB3ZGMuY29tPjsNCj4gQWxleCBMZW1iZXJnIDxBbGV4
LkxlbWJlcmdAd2RjLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAzLzNdIHNjc2k6IHVm
cy1ic2c6IEFsbG93IHJlYWRpbmcgZGVzY3JpcHRvcnMNCj4gDQo+IE9uIFNhdCwgSmFuIDI2LCAy
MDE5IGF0IDExOjA4IFBNIEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IEFkZCB0aGlzIGZ1bmN0aW9uYWxpdHksIHBsYWNpbmcgdGhlIGRlc2NyaXB0b3Ig
YmVpbmcgcmVhZCBpbiB0aGUgYWN0dWFsDQo+ID4gZGF0YSBidWZmZXIgaW4gdGhlIGJpby4NCj4g
Pg0KPiA+IFRoYXQgaXMsIGZvciBib3RoIHJlYWQgYW5kIHdyaXRlIGRlc2NyaXB0b3JzIHF1ZXJ5
IHVwaXUsIHdlIGFyZSB1c2luZw0KPiA+IHRoZSBqb2IncyByZXF1ZXN0X3BheWxvYWQuICBUaGlz
IGluIHR1cm4sIGlzIG1hcHBlZCBiYWNrIGluIHVzZXIgbGFuZCB0bw0KPiA+IHRoZSBhcHBsaWNh
YmxlIHNnX2lvX3Y0IHhmZXJwOiBkb3V0X3hmZXJwIGZvciB3cml0ZSBkZXNjcmlwdG9yLA0KPiA+
IGFuZCBkaW5feGZlcnAgZm9yIHJlYWQgZGVzY3JpcHRvci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6
IEV2YW4gR3JlZW4gPGV2Z3JlZW5AY2hyb21pdW0ub3JnPg0K
