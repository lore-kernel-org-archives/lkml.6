Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172B8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0791222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BvxnRAeu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FpFBMWbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405325AbfBNLM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:12:56 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42992 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfBNLMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550142844; x=1581678844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ygvUeTdnbyg5wzMozzto7RtX8IDX0rE7mqwJne5TVL4=;
  b=BvxnRAeuHyjOl+bKD+Z/eKYnDi/6WX2OqWZjupzDlxtoRecfMMn7v6r+
   dgUd+8cpzEsODWALKTWggXypXmLGDWRMOzJESu9LbMCLO9oSD1I7pLfY2
   FSIg5Qh187vxY4OSMUUKxke9reDhMdBIOPmai6/kuLjICiBuEzwFDpzWp
   Az4Z4BTxVvnukCdDdZ+ONEOMm6B50NoVl4TI7bLfcBM92sPrNPCw9EKqh
   FilMJshO6Ov5yzJVWBCF64unFdyPic9BGT/1WU7DiniiytHieiqurz6hX
   HbQ2SRwVaavHazS2BrbJqfYy6NhovLSFj1BpR9ylMrbqt8QzkoV9B2tAk
   g==;
X-IronPort-AV: E=Sophos;i="5.58,368,1544457600"; 
   d="scan'208";a="199475617"
Received: from mail-co1nam03lp2056.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.56])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2019 19:14:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygvUeTdnbyg5wzMozzto7RtX8IDX0rE7mqwJne5TVL4=;
 b=FpFBMWbHCLCPd4Ri6DEmRbU5RtwOpfAY5h0/gz7I5G/LPy/vkQZGzXplVabWkRd8d7l3m4z/G41CyYdDmmArLreVYWUF548KOXOv4zY/Wpumg/OPcxsKzMF/1pRfjgLeiAEpxFiPkd9G5KH07k5IjBx/C+18pYOVF5eQ2lyxJkU=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4510.namprd04.prod.outlook.com (52.135.120.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 11:12:53 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 11:12:53 +0000
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
Thread-Index: AQHUvg8xJYZJmAkJmUuaUqRdwcSwoqXS4UAAgAxOnrA=
Date:   Thu, 14 Feb 2019 11:12:52 +0000
Message-ID: <SN6PR04MB492532246A5968F6C60F84F3FC670@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
 <1549452487-17193-4-git-send-email-avri.altman@wdc.com>
 <CAPDyKFqrS+f4K-t6i0ZxAivtATddYepXLguX5svrQub-zH2JEw@mail.gmail.com>
In-Reply-To: <CAPDyKFqrS+f4K-t6i0ZxAivtATddYepXLguX5svrQub-zH2JEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c312797c-4d5a-4b99-f383-08d6926d5d1c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4510;
x-ms-traffictypediagnostic: SN6PR04MB4510:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtTTjZQUjA0TUI0NTEwOzIzOkpSVGhoSzRGVzAxRXpoMXJESU1VeTk1ejJJ?=
 =?utf-8?B?Z0dnRXBJY1IzaGFzR3F3VEJjMVpBN1VmcW1TVU1GZWlib0tvVktaMzViTGpC?=
 =?utf-8?B?Z1Jrbm5XSlk0eGdMVmRZUzZ3Z1J0Q3pIT3BabEdkdmFrdmMyc2xmeDRZdzd1?=
 =?utf-8?B?dm0zMU9rQlVuNzRVR1AvR3phOW4xTmtnbUszWms1SG42YUhXSDhUanhjTFRN?=
 =?utf-8?B?TjlMcm15WkZ3MFVMUm5DUDRuMXNXSDJEK0sxOTQybXgzSlhxMHJLdFkvWXg0?=
 =?utf-8?B?Z29HNzc3czExT1dNYW1aL1RMK0x6WmJyM292SHZKcTU1V3FsTFM4Sk91Zi8x?=
 =?utf-8?B?bVNmMURrQjNhaXJNcFJwNTZEUWhjcFB5Y1hvMmQyeWlEaHVNeG05cnUydkpt?=
 =?utf-8?B?cG5NMWIyMmkvSVJ4MEZEb1NRbEZINUVXQllZTkZjRVFGTWZRRmNQRkRhYnNN?=
 =?utf-8?B?VmZmYXkvM2NoUGtUd3NVVi8vU2R6L0thSkQvcmZjRVU4VmVKMld0aFdTTkg3?=
 =?utf-8?B?aEJCZWcxbmo3WHJFRU9tTElRWndLeWh5Wko3TFVWZC9BdGVkdi95WE0zeG56?=
 =?utf-8?B?MGlobmwwbEEvT1RsUkV5NmlQSFlpVE5ScVkxNUlERW1PQ1MvSFR4eE4zcVNC?=
 =?utf-8?B?NUxiOWZjNzQ3TUwwWEl1VStiUzNyUkpjZlZ6b0g4SFlaSDRYcllWeSs3akoz?=
 =?utf-8?B?V2xGSERaK0ZZSEpzcTkyNk55RTVBZ05NN3B3M0RHS2Z6S3NxTER0eTRQZUY5?=
 =?utf-8?B?WkNEK1AxR1g5RFM4TG9DbGRtUytLaVF5L1F5T3pVb1ZHa0NDMitQU0ExSDE1?=
 =?utf-8?B?anpKcmozWTdlVGljQ1Zza3FNbmZNaHVnYUlvNDQ1b0piOHRUcThneFd2dldl?=
 =?utf-8?B?Q2pxRUgzNFk3aXlwUDhrZWZNWUYvTDFHOUoreXRPaTA4bGVwNUJHTmVmKzdy?=
 =?utf-8?B?Y2FmUjFuQ0hBM2VWUWROd0p2Tmk3aG1WTzJrbmFBaFBpY2IwSUlnajRacE1S?=
 =?utf-8?B?dXo2ZlVXQndOTlV2amRIRDlud1dDa0dTaW1Oamg3RkNsdmNHR1NTTVRJSFJP?=
 =?utf-8?B?bkRobGVOSXJtck9VM2ovRzJpS1RyaE51dHB4cTFaazJ0YU5wU1MrVFB6c3ZV?=
 =?utf-8?B?QU5JVVErQkxrbnV5bGhtS2VWNWg1V3FNeTR0MWVpR3pTcUlRRVh2ZHdNUEUx?=
 =?utf-8?B?bFJtSlE2UURtRWpFWDFWMDYybUVjUWMzN1cwUERYRHFCL0NVUXkwY0tpRUV4?=
 =?utf-8?B?WURYQnpneVJxVEpKMjlyY0lLRnRYeEpRaFQxMlltajE1RDdUTm9QeVc1bmZz?=
 =?utf-8?B?bEN6cjh0eC82SitGZDdmOGp3RGFTbFVrclByZGZsWURrejJybjlzdkpQOXk5?=
 =?utf-8?B?bHVRdms2dGtMSytaZTRVM2RDVjhaUlNnaHR0Rk83YjdDTHZSSEpVNUdBN0tS?=
 =?utf-8?B?eEhrYm4wczBzQlRJQzM4RUNpODZQa1RTcTdvdXRLYzhoS1F2dlpuYUVTeGpr?=
 =?utf-8?B?NFQrL3pNMHVLT0xhNUxIQ1N2RUZsbmFxYzcxUjdaMVZseWRHeDhKc0J5aWNJ?=
 =?utf-8?B?R2w3TEtsbitlYUYzZldWL3ordTFOUEJGaXB0cWxLSmZKTVVBMTkrNkJNazRO?=
 =?utf-8?B?MnNEd0EvRnRyeUZlKzBSbm1VNXIzRmVoZVZGRzM2NXlZc09FVzJVdm9BPT0=?=
x-microsoft-antispam-prvs: <SN6PR04MB4510FFA7CF6EFB1091CEF043FC670@SN6PR04MB4510.namprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(14444005)(14454004)(81166006)(8936002)(8676002)(81156014)(54906003)(97736004)(86362001)(316002)(72206003)(3846002)(6116002)(478600001)(99286004)(7696005)(26005)(186003)(102836004)(6916009)(6506007)(76176011)(305945005)(7736002)(74316002)(2906002)(6436002)(66066001)(256004)(6246003)(55016002)(68736007)(53936002)(229853002)(71190400001)(33656002)(71200400001)(4744005)(106356001)(9686003)(4326008)(25786009)(486006)(11346002)(476003)(446003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4510;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8zdnaoXUOjTUXbDHm79Mj+aWfgI55RCdrqoBvskWHn6QzgKyrEStUXl6d1fILjzVm04LlVdqHMnV90KTlXKbKMfHmkf/cu0907i/Nht6XAOT81LhfzORO9ZY/0CyehOI77BZyjzHudvv0NV5vo6biU+GuOrJ2y4IXbPicuMstqQByjU1mTf/NlZUpD31W8iAy0f7nNfgHpOgbL2Z8U6Tzer8Nk3wdeEjOF9csxXNOdfZ8o0T+zF2gAmrHEzNvli11fJsMe8PQeIKw/jc/Gzgm+QS+Wsdb9F8mre3QJZRkJJqW4iEQSoLY6UQjNtVW5QKe41hw5ARgFADUIUtGMU9ryV1e9962rodbUMxpYl5rNNCCQTf3iNciozlXvDuTULaWDTHVpPEerJwNBJnaUHY5AZlaPCBvG1yU51lSIRRvwA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c312797c-4d5a-4b99-f383-08d6926d5d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:12:52.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gV2VkLCA2IEZlYiAyMDE5IGF0IDEyOjI5LCBBdnJpIEFsdG1hbiA8YXZyaS5hbHRt
YW5Ad2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBTRCBzcGVjIHY1LjEgYWRkcyBkaXNjYXJkIHN1
cHBvcnQuIFRoZSBmbG93cyBhbmQgY29tbWFuZHMgYXJlIHNpbWlsYXIgdG8NCj4gPiBtbWMsIHNv
IGp1c3Qgc2V0IHRoZSBkaXNjYXJkIGFyZyBpbiBDTUQzOC4NCj4gPg0KPiA+IEFjdHVhbGx5LCB0
aGVyZSBpcyBubyBuZWVkIHRvIGNoZWNrIGZvciB0aGUgc3BlYyB2ZXJzaW9uIGxpa2Ugd2UgYXJl
DQo+ID4gZG9pbmcsIGFzIGl0IGlzIGFzc3VyZWQgdGhhdCB0aGUgcmVzZXJ2ZWQgYml0cyBpbiBl
YXJsaWVyIHZlcnNpb25zIGFyZQ0KPiA+IG51bGwuIERvIHRoYXQgYW55d2F5IHRvIGRvY3VtZW50
IHRoZSBzcGVjIHZlcnNpb24gdGhhdCBpbnRyb2R1Y2UgaXQuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4NCj4gDQo+IERlZmVycmluZyB0
aGlzIGEgYml0LCBuZWVkIHNvbWUgbW9yZSB0aW1lIHRvIHJldmlldy4NCkEga2luZCByZW1pbmRl
ci4NClRoYW5rcywNCkF2cmkNCg==
