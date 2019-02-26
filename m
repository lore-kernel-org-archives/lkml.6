Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C70C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EF52173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GHlAlENf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="flklspr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfBZJGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:06:02 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30201 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfBZJGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551171962; x=1582707962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JerKbHvabqi7hYX5MzZGK9pp92A3A1j4vAUqyAbV5ts=;
  b=GHlAlENfEsHKSvtEi1ShbVGV1OFtIZApMT4SX6vdIUHdzIq1sntQ5ey2
   LgzEriaFPcUhcEeZnb/VHAsUSaSi/9RRTIcUxRpJolqvaY1CsyEmOWxNj
   VYfTNkUDBA75cIGISC+P+ZAQ0rbZqnU5NXGRyS8dq3FmckpCDhRfo9s6x
   K4++sMrGT2CRE3BiJQlfqDaTD/bCdiKw3fEUi5LwKiFouIICv5WTmu9+j
   h8y1c4TMTgJ9o5hiyONQ6dMcRlPV6XYzqDp3Ob7/0h2haRCaFaIonc6ZU
   rUrqVeZBBNe6EPxiIW8dKCVfqxx1WuhQRWomTG2BLpJs7X/MZSaUFfGSN
   A==;
X-IronPort-AV: E=Sophos;i="5.58,415,1544457600"; 
   d="scan'208";a="103922598"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2019 17:06:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JerKbHvabqi7hYX5MzZGK9pp92A3A1j4vAUqyAbV5ts=;
 b=flklspr9ZYoa5q2fRk/BO9XXQ6WDCf4fwR6I+2R3iSzUFfygVadk+yaXtu9t83IHHpk5QSSo9EMaD9rtO0WleyDZI5RmVdmZsFyZ8+iO089KhL0YN9xTuBskU638PXZSjLjuVnEozkV08zitzzR0/obnqLEcWQpGX4rHnJ/vd3I=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5021.namprd04.prod.outlook.com (52.135.116.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 09:05:59 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 09:05:59 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Gilad Broner <gbroner@codeaurora.org>,
        Raviv Shvili <rshvili@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>,
        Martin Petersen <martin.petersen@oracle.com>
Subject: RE: [PATCH v5 2/2] scsi: ufs: Remove unused device quirks
Thread-Topic: [PATCH v5 2/2] scsi: ufs: Remove unused device quirks
Thread-Index: AQHUwg7REIeHlqH6g0SKWsnXg9ytL6Xx4Lfg
Date:   Tue, 26 Feb 2019 09:05:58 +0000
Message-ID: <SN6PR04MB4925B3D87401E8052621F4A8FC7B0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
 <43265449-30e1-d514-3ffd-fc38530dac67@free.fr>
In-Reply-To: <43265449-30e1-d514-3ffd-fc38530dac67@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70ded5c7-a10c-47ac-751a-08d69bc99fbe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB5021;
x-ms-traffictypediagnostic: SN6PR04MB5021:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtTTjZQUjA0TUI1MDIxOzIzOkZ1SUlSNTl0TG9HdXNaTzR1K3pkbnd6bFVq?=
 =?utf-8?B?Z0N4RDgrS1Y4UXdiZVVPYkVIVWM4bDh6ZlBCMk1pNDNFRE5YNE54OG1qRnVZ?=
 =?utf-8?B?NmFPcElhRXFEemxqYVFieGZ3KzNHWFdvMzdKYjdHMTRDMHhzdURtNjZwUUxO?=
 =?utf-8?B?YWNLWEZxY3JsNVBUTUN3R3RHcnNUTW9mQURSdksrUmFtZUZiMFU1M1F2Nkx1?=
 =?utf-8?B?SnphWXpLcmp6QmhOeE9LVzdlWGZjdncvb1lGRGJjKzJHVjNaaEhoajY0Zjd3?=
 =?utf-8?B?eng0T0ZsT1RGNVdnK0wrczRZQ05BNVJTUHVZV2pyYmdFV0R5RWVibU8zWVB0?=
 =?utf-8?B?VWJUSkh0T0lFamxXQzJpdDQ0N1VRZjVReUJQREFyRUpVRXl6ZEpUdXUydG5C?=
 =?utf-8?B?ekRNMTE2L3pPZ3B4aFZTZGkvMWFhdFd4VHRqSVZpYkZjTDU2ejJMYXpWZHox?=
 =?utf-8?B?dVlyUG5QbDFCakxrUWNvUVgydTI3bHhBQmtXQUt6ZEkvNGNONmpIZVVSWmEy?=
 =?utf-8?B?WkpyNGI4WG1WdGNvdGE3cFZ1TXFhNEhlc0h4N0VBSDN1ZFpxZkt3UnhEQ0hu?=
 =?utf-8?B?STgycUd2cytYT211THpYanR6ak1aMUtRcVdNSkdURDJ2OUNsdlEvdkgybmds?=
 =?utf-8?B?VUNJMW83emJBeU9JelUxRDlTdHdScGVOUW10ZXl5OFNteWU0SVlSSGtTczVN?=
 =?utf-8?B?cXVlTzQxYmVPZ2EyTUNyYVpubFg3M1hVQXZVRzV6d2FrdkI0Rkh1V2tqeURk?=
 =?utf-8?B?K1Z4S0VwSUJZcG1aNnhGUWl2TTltRE5iSlMvaFVsMUg0dEpybldQbVN5OER4?=
 =?utf-8?B?T0pGei9uVFRzR0VidlU5UVl1RTBKZHpYb3RWZkpsZFZCZzhYZHpuZ0p5QTJ2?=
 =?utf-8?B?SmIwTExZbXNUTDdIYy9pWFI0b0EycERpVm1RU1RkczdXL1J6bXpldWdVZDhB?=
 =?utf-8?B?MmM2WWpDbUNVZk14eU0wYTdBazN2a3JSRGttQlVNK2hubEw3KzhCUS9CUXBL?=
 =?utf-8?B?aFdHeENRWlRHOEgwTmxIamlDQ1hzeFlPczhkK0FiWERqYlZUVnBqUEE0Si9n?=
 =?utf-8?B?QXkrQ3VtSitBc0licDIrZDg3eWNDOXBZcTBiZDBnRkEvNXNjSlZhVFIxekJx?=
 =?utf-8?B?R2E5L2t5WG9kUTl3ZkpNVWY0SVIzeGZhWS9uVENXSVI2clpkNk1lY0pKOUg5?=
 =?utf-8?B?a0FYSmdOMVhIa0ZjMWtqMWdKaXo0T2hBMUswWndWVTFPR04vSnQ1aHhNZkdU?=
 =?utf-8?B?M3A4NGdnNEZDc2E0dW9pTk4xc0tCaVQ1dVh5dWQyYlBkSVg1eUZVY0lFd0F3?=
 =?utf-8?B?QUpmWnkrSUpUKzBSb1ZDUU43UjlXNGwrWUI3SVVDenpLaHdaMXdQT2hUcWgv?=
 =?utf-8?B?MTZBYzBTZmxrQ3ZvdzJEL0ZZdHJtcE1vcjdNL0kvSFJxb3pDMWVaODZkcHFD?=
 =?utf-8?B?UmxLREpiR3U4WE13Tzh5anQrSHdwcmFLdW9TQ0t2NzB5d3ludHVrUVZHbmJ1?=
 =?utf-8?B?UzA5emhpSDRneHJMNVJZTyt5cmNBR21wS3pUdysyRm9pVmV0M3Fhb2VHeUhz?=
 =?utf-8?B?QUZ4azQ4cldMY3A3aWx2QXZ0UjMyeEJKUXRyR3dEQ2lRV002K0xCUmZMZVR5?=
 =?utf-8?B?MUhrWmZpempNSHp6Vi9CaktTNTFsTmpuajNVY1RVc3dMeGh4QzZjb1lqWVpa?=
 =?utf-8?B?MEFvelBtNXB5V0VuWjVXRUMrdmxGcFloYVowUzFmTkpOcndzM0xmL2lNdFZW?=
 =?utf-8?Q?2ImbarjPcvabROaFZySVjL1+ECHfr6IEywb2Q=3D?=
x-microsoft-antispam-prvs: <SN6PR04MB50219038C4542A61A5B7C554FC7B0@SN6PR04MB5021.namprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(66066001)(6436002)(86362001)(256004)(55016002)(105586002)(11346002)(7736002)(305945005)(558084003)(68736007)(446003)(478600001)(54906003)(25786009)(14454004)(81156014)(52536013)(8936002)(2906002)(316002)(5660300002)(229853002)(81166006)(110136005)(9686003)(8676002)(7416002)(74316002)(186003)(33656002)(71190400001)(71200400001)(4326008)(3846002)(486006)(72206003)(106356001)(6116002)(99286004)(476003)(97736004)(7696005)(6246003)(53936002)(26005)(6506007)(76176011)(102836004)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5021;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tZmCZ+M6SNUph7DCUwbyk6wfzQlbLIK4yGQz7ZnXEMBPwHVwHdH2GOGNV+gzjbAo+bKlcy1wncijd0lYLbz0L8VtODAKMplCeTPB0MOKyEwnda6Sjmskqd7qk/cSaGCu3Inj3oj7OZKGbBMcMfAWXvtiKGMGRfVKfEQ7a42rh8cHg0pHH361QotdH4yBaujo7Iz0DJTKv+i662NNMt2BfOouCDZyAvgJpPM7HAPc6tNCYgkNT2BJOJdMRooUTOEFIR76+kw68YOAyJWyM6cvN3xa/kj31zs74oyeQAvLkL4KCg/Kv1sL9fi4pM8mWWPRRkUJrZaPEyH9ir5Ut2HurHAXmfwNa97zCLMOM3Xd9dUMJ03VU/vyMr1LogNSlOHSPMrJZR93zQcqIKlwS0xDTcRd7H/tf1dnrWYYGFkcxsw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ded5c7-a10c-47ac-751a-08d69bc99fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 09:05:58.8613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBUaGUgVUZTSEMgZHJpdmVyIGRlZmluZXMgYSBmZXcgcXVpcmtzIHRoYXQgYXJlIG5v
dCB1c2VkIGFueXdoZXJlOg0KPiANCj4gVUZTX0RFVklDRV9RVUlSS19CUk9LRU5fTENDDQo+IFVG
U19ERVZJQ0VfTk9fVkNDUQ0KPiBVRlNfREVWSUNFX1FVSVJLX05PX0xJTktfT0ZGDQo+IFVGU19E
RVZJQ0VfTk9fRkFTVEFVVE8NCj4gDQo+IExldCdzIHJlbW92ZSB0aGVtLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTWFyYyBHb256YWxleiA8bWFyYy53LmdvbnphbGV6QGZyZWUuZnI+DQpBY2tlZC1i
eTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+DQo=
