Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F98C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 07:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583132063F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 07:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bZz2ZF6o";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c8mXkLEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfBXHIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 02:08:04 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:12055 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfBXHIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 02:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550992116; x=1582528116;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/zXgMZSIimf63/wcaeD5b25PuVJg6R3fcsfFgwL/44o=;
  b=bZz2ZF6oTYMEpa7q9KlAnyk0AB2ZUTkyKyJEkQywBnen80j0DiUPQ3/l
   bO0Uo/k9mcS412pCgWvv2zfxrwSMrHhcwh++ZxvMZzSYOeTjjWTETl7xh
   qRhNNseMDz7d0ke4GzHZj5M8Gy3vCBSk5WK3I+KyvkmRfx2V7f/lF4DJg
   +JMdpotGXYOOiRVumDKtEZJ4/7WsagfPpcu3/nfxlhWoNRs5ngE1GDRro
   zOuYyetl1QhgFCISYeSlv5L7ArCANJcTuXev0pI4DRmeI1l2G7Gk4PEAF
   U/fWuk94wNgHEbkt33wbfsXP9IiPJleZIfgAVnsQT+GZ6revxKfvQTARc
   w==;
X-IronPort-AV: E=Sophos;i="5.58,406,1544457600"; 
   d="scan'208";a="200411250"
Received: from mail-co1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.52])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2019 15:08:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zXgMZSIimf63/wcaeD5b25PuVJg6R3fcsfFgwL/44o=;
 b=c8mXkLExDvPWLpvdPAWNmqasUF9F9hTBO8Do/fObRv1I5D/93iWW/PH6RIL/uorti2sOkrsr4vskDHTPIoNLAB1iYBXjMIHTYHBXjja6+OJl9sxH61UwhIIxTAablaw0EzWDffR8LqWVIFwf60Sgn3PPTJa/mfAp1shuu50UJK8=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4126.namprd04.prod.outlook.com (52.135.71.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Sun, 24 Feb 2019 07:08:01 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 07:08:01 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] mmc: core: Add discard support to sd
Thread-Topic: [PATCH v2 3/3] mmc: core: Add discard support to sd
Thread-Index: AQHUvg8xJYZJmAkJmUuaUqRdwcSwoqXS4UAAgAxOnrCAD3MKUA==
Date:   Sun, 24 Feb 2019 07:08:00 +0000
Message-ID: <SN6PR04MB4925F4144BA19933F80B7D08FC790@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
 <1549452487-17193-4-git-send-email-avri.altman@wdc.com>
 <CAPDyKFqrS+f4K-t6i0ZxAivtATddYepXLguX5svrQub-zH2JEw@mail.gmail.com>
 <SN6PR04MB492532246A5968F6C60F84F3FC670@SN6PR04MB4925.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB492532246A5968F6C60F84F3FC670@SN6PR04MB4925.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cedbad64-1547-407d-660e-08d69a26d01b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4126;
x-ms-traffictypediagnostic: SN6PR04MB4126:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtTTjZQUjA0TUI0MTI2OzIzOnpXbytvdVBGbElkK3RaMzlHZCtJM0JkM1Y3?=
 =?utf-8?B?K0oxanYzYWVDTTU2MUtoUVlpYkkyb0k1QzZESGtUZTN3cXJVck9pWFFMMW1R?=
 =?utf-8?B?YjlmWGVTbnk2SjBFVnh3cHRQVFdyWUZuOURNQWVIclFoUE9YMFVad0lwcEhm?=
 =?utf-8?B?bHNIeGJPNXpuUTBwUGJlMjZ2cFUrbDZQNXJoeTROeTlnYTlpWmJBREE1TG15?=
 =?utf-8?B?SlpHY3hEYVh2WFpvN3hmTXBRaTcvYjJiRlFaeUs3aEh5MFlRM0k0R3BNcnkw?=
 =?utf-8?B?UldiV1loOW5KRTM3dklxbXR1THlobHU3aEtUWGpxUDhJMTR6Y0NJVHFNM1RQ?=
 =?utf-8?B?dmloQ3pyZEVSdFdjOW1MYTRYdm1xRGU1UnRIa0tHQ004cjFiejdFR09Qc0Nj?=
 =?utf-8?B?cmJIR3FPTVdKc00xVCt3QkdnOXcxWitnU1JZUkR1ZzZqcGQwSStJNXVYWUo5?=
 =?utf-8?B?SmVXZ3gzVkdCWGE2dWNTeWJGSFJhWmhMN1NZMFNoaDRKL3N5TU5sSlF1bmVp?=
 =?utf-8?B?VjdGR21rV3RSTkJGNmdjeENSVmlYYmIzWDl3K2Z4VDdHU0FaTm9ZeHhvM090?=
 =?utf-8?B?K1VWdmVyOFdLYnFuanZYc1pBTm9WbEJ3RkcxZTUxbFJFRko4eU1SYU9JbnY0?=
 =?utf-8?B?Y3RlRFUzT0Q3Ujd2ZkdMem1RUnlobTNqeDl4dzEyelg1UWRUeW9LeFFRYUFw?=
 =?utf-8?B?L2tXc3g0M21UUUZkc05MTkxyajUwUFEySXZ1TGxiRzBqaWd4djEyNG5QRjRs?=
 =?utf-8?B?ZU8vY3B4WGl6Q1JJZExxcXpsWlpHNGhOZEtlaWMzajd4YU5EWENtblZ4VExl?=
 =?utf-8?B?ZzZOeHBndlpSUnpta2lqK1ZPSmowUXVuT2pDakx2NENwZjJpVHhVd1lFZDd0?=
 =?utf-8?B?R015RUt2aGpqV3NEUmIzNWtTUnRRWUJZekNiS2Q3NlhLeXUrb2daVzhLRGkx?=
 =?utf-8?B?WCtXRjRXd3pLd0FId3FKYXNnc29md1liYThITDBJdXA2S0RnLzZ5N1VVRkcw?=
 =?utf-8?B?NWdpZ3kwUExSWmNGcmVMRzM5UDFhYUJaNDlrbTBIYnlLbzBnN2srTXh2U0o3?=
 =?utf-8?B?K29pd1NZQmhnMXROeDJUYlBSSEUvSHVxWklBZzlMdFVKWGkwbHZ5ZFlGU0Vv?=
 =?utf-8?B?eHY2WkQ2d1AvWG1kK2RXa3R4WXBQVkgwOG8yQ2tkQmlrSGpBZngzbmJCQlRH?=
 =?utf-8?B?d05pendrTTFxWUNYcUVMRTQrSjRkVk5QSXVUSXRDcklXQ2pWV0pnUENTbGdr?=
 =?utf-8?B?R3dvOWZqVGkvVzBwTDB6TEFSb1J2eE53TWluMHQrQkphL2tSNTUwOVpRVGpn?=
 =?utf-8?B?OVBPQ3JqS1FvOWlNbk9HQ0JYMEpMWTc2THUvRWhTck9sbHYvd2xQM1hZWWdL?=
 =?utf-8?B?Q0FJZnlzSnlXNnZQdFpwVzB1T1NPVlZUODlDVVoxalhrM3ZOeTV3NEQxeDRD?=
 =?utf-8?B?Rk9UTFBqZXpQdjV4K1N1d0srZVMwZTl5NytLY3pqZjdzMkxZMjJTRm1kVTZS?=
 =?utf-8?B?aGxHMWdZczEveUx2dWhqR0VGeGk5MlgwVVdZOEl0d09DWFgwOUFxWko1bUtp?=
 =?utf-8?B?S1BnMkNqeC8vT0FFVXo0a0hEbU01Znk0c3cvbzUwczgrd3dYTG01amxJSDl3?=
 =?utf-8?B?Z212bGJIL0Nxa21DMThXdmJiazhtL3l1REVIYjFFV0RFaTNETFM5V0JQS0pN?=
 =?utf-8?B?MDhpZ2QyWFV3NGZvclBLZ0w5YmhnSHFlTWJzM2xuaWtBTm1qaitBR3UzM1d6?=
 =?utf-8?B?ODRvSkozNHN0YXNNakMwZz09?=
x-microsoft-antispam-prvs: <SN6PR04MB41264083EF97062E4B2622D2FC790@SN6PR04MB4126.namprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(376002)(396003)(346002)(189003)(199004)(7696005)(93886005)(305945005)(186003)(99286004)(33656002)(8676002)(105586002)(102836004)(6506007)(81166006)(25786009)(2906002)(6436002)(106356001)(74316002)(76176011)(26005)(7736002)(81156014)(54906003)(55016002)(52536013)(478600001)(5660300002)(97736004)(9686003)(71190400001)(71200400001)(4744005)(6246003)(229853002)(53936002)(256004)(4326008)(72206003)(446003)(86362001)(68736007)(6116002)(3846002)(6916009)(486006)(66066001)(11346002)(14454004)(8936002)(316002)(476003)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4126;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kZmjBUkFUZD2LQccnWnwKjcvFFL5EBMcHvrBlbPLbsJXjOuczwiwXRj/mAbSucn7tKUvYoFISaCKbIt3anPQYf+V2aWlnSZk1ORvDGhmBrjSvzq1gg4vgrTfPwzMppgZx1vF1MTkkLMp7w9gozTvQ06tq+0HTnwgNFM/qo95krY0rCUQU5b/hI4LwKG6tc9lNDLFvBvxp4jTZwM2IdCqvrCPwdZoCIcEM3YHk9smxpmp6fdhfJEKyZIac7GC8BEmyhi3P6szPZUDRsS5e7yRgtFjSyrAGt9kWGVxp2JF2sYvfYV8foZlBiNomXmXHz5l2zgroO9o24t/yLWRwnbmbwmhYvx8IoJqaJvdie5xKYkYdZjugPECXkUqcllf1rfBbc6X3/NO4jK1qL6QAcgJOFFfTbZ4cLHHxEr9dC4fGAc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedbad64-1547-407d-660e-08d69a26d01b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 07:08:00.7953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gT24gV2VkLCA2IEZlYiAyMDE5IGF0IDEyOjI5LCBBdnJpIEFsdG1hbiA8YXZyaS5h
bHRtYW5Ad2RjLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gU0Qgc3BlYyB2NS4xIGFkZHMgZGlz
Y2FyZCBzdXBwb3J0LiBUaGUgZmxvd3MgYW5kIGNvbW1hbmRzIGFyZSBzaW1pbGFyDQo+IHRvDQo+
ID4gPiBtbWMsIHNvIGp1c3Qgc2V0IHRoZSBkaXNjYXJkIGFyZyBpbiBDTUQzOC4NCj4gPiA+DQo+
ID4gPiBBY3R1YWxseSwgdGhlcmUgaXMgbm8gbmVlZCB0byBjaGVjayBmb3IgdGhlIHNwZWMgdmVy
c2lvbiBsaWtlIHdlIGFyZQ0KPiA+ID4gZG9pbmcsIGFzIGl0IGlzIGFzc3VyZWQgdGhhdCB0aGUg
cmVzZXJ2ZWQgYml0cyBpbiBlYXJsaWVyIHZlcnNpb25zIGFyZQ0KPiA+ID4gbnVsbC4gRG8gdGhh
dCBhbnl3YXkgdG8gZG9jdW1lbnQgdGhlIHNwZWMgdmVyc2lvbiB0aGF0IGludHJvZHVjZSBpdC4N
Cj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2Rj
LmNvbT4NCj4gPg0KPiA+IERlZmVycmluZyB0aGlzIGEgYml0LCBuZWVkIHNvbWUgbW9yZSB0aW1l
IHRvIHJldmlldy4NCj4gQSBraW5kIHJlbWluZGVyLg0KQSBnZW50bGUgcGluZy4NCg0KVGhhbmtz
LA0KQXZyaQ0KDQo+IFRoYW5rcywNCj4gQXZyaQ0K
