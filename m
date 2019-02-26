Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7AEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEE0213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E9Im2VY5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jw+zO5op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfBZJF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:05:29 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26478 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551171927; x=1582707927;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q7i0B9v2LjcamMyK2ZUE/IZ59g8H0f3mJ3fHCUa3cu4=;
  b=E9Im2VY5eAQh0y/0vHHgkgPDoSbmW8G5nhE0nx3hgpFnj/ya4u8BbfKE
   oQCLyyrGVKXLl/61lEB3cqqtyOpmURvvR3RpyfD/5/fVFiF3NCiufJqlB
   LAG///rQ65IGeq00E5wsPKT9CkOnyurYitKASoEVCRgkkt5cuFm7h1+qc
   /sFuewA0jdJuE6PJiSTqAcCYQxWTzJ00LiOwod7jPmpA1+mAcfxfix4bE
   v25zrFZjaUiRIGNKFVZ19GDZBTUzVGsKumJT0r0AUm9m+ogszj3h4RKuJ
   d9xeVc4L9FvayOChYb2A4N/iqqwCcRNOgUHcDWSna9SxhB4H5R5Kg9iyY
   A==;
X-IronPort-AV: E=Sophos;i="5.58,415,1544457600"; 
   d="scan'208";a="102165641"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2019 17:05:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7i0B9v2LjcamMyK2ZUE/IZ59g8H0f3mJ3fHCUa3cu4=;
 b=jw+zO5oppF8jCSIkYUeA4JwTwl/F/jn6tviM8lfBNtxH4mDPf5BtRzJ3UsBgH3k6k1yk3UEMXjJUa5br4RKFa6CS6pA5/rZBoDdfvJCNHraIBFE1NpfNRiNB2po3Z+fUveqoU1Ok3Pve6NbmPDHDyuNYzr+DJf36awGHg/2a1pw=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5021.namprd04.prod.outlook.com (52.135.116.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 09:05:23 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 09:05:23 +0000
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
Subject: RE: [PATCH v5 1/2] scsi: ufs: Do not disable vccq in UFSHC driver
Thread-Topic: [PATCH v5 1/2] scsi: ufs: Do not disable vccq in UFSHC driver
Thread-Index: AQHUwg6tKGMkUWpd+UCXGq4pzDHQF6Xx4FGA
Date:   Tue, 26 Feb 2019 09:05:22 +0000
Message-ID: <SN6PR04MB4925E5C25FA0E4BDC05D3660FC7B0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
 <be3ef9bf-438b-4e8a-62c4-f75458e8ecc0@free.fr>
In-Reply-To: <be3ef9bf-438b-4e8a-62c4-f75458e8ecc0@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77213753-73e0-49f0-f60f-08d69bc98a67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB5021;
x-ms-traffictypediagnostic: SN6PR04MB5021:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtTTjZQUjA0TUI1MDIxOzIzOnR5T3dxWUtGL3MwbjJBODhaZG03UzJvMTBk?=
 =?utf-8?B?MmFTNTdPU2RDMS82bEI1VnlaM0FpVTBYRXZ5Qk02MVVPUWtMdnNzdDcvWC9l?=
 =?utf-8?B?MkdXMWJKNU1uU2M1YkVPS3hVeTJaNmRvUzVOWWZ3dzhkUWlmY3REbTRxUmZC?=
 =?utf-8?B?SWtKVnlyQWovRFhsam5TaWF1RXk1NERPU1dIM2tPZ3ZzTjhJUFM5RDhJNGZE?=
 =?utf-8?B?djJlb1F2bmdQUkR3eFo0aFk2dk5zMTMxdHlwYjlqQm9ZZ2hrYU90NjZlQlgz?=
 =?utf-8?B?b0Mrd3Q3RW50MmVKWFFCeGNyd3B1VmJhb1NoRkNSb2NtVDIwWnRTUXVscmxu?=
 =?utf-8?B?L0REOEVKd0laQjdKM2pnQXhpcndhQkpDUis0aS8zRGJ3VGFyQXhBSkhzKzl0?=
 =?utf-8?B?T3pFSExqcXpPazl0b25nUjN2aDU4N09KcW9nY1NTRDdoWG9xNGRQZVZubmZ3?=
 =?utf-8?B?RjcveWdUQWN0Qlk3clR0dEVKTW5LYm1IY1RtZ2hyRk8xcjMzKzd3YzFYMWgv?=
 =?utf-8?B?WHBBVmNaeWcxYi9oRklMZ29YbjdJVXhQUWFSWU5TK0Z3WE5DUVFNemRnQmVF?=
 =?utf-8?B?UG9VbkVUN1U0eEJmZG00OGlKTnc5UjJYVVhCUExER0pnRFRzMUxiMzhsL3RS?=
 =?utf-8?B?bG5rclVkWHhKTlVoTzBwQXV3cGxJUWh6a29NWk9aT09lbE1ZR0JER25vTU5C?=
 =?utf-8?B?c2tMd1FwWjRrcXZ6M2kvYjlDV3FRdkNwNWRlUXBYV3JFNHNJODN1dFJNdDRr?=
 =?utf-8?B?MHMrL0U2ajl0YVlyUWovSlgvRzNhY251d1gvRGdSVVhWeWpZS3FWOUFLWDRu?=
 =?utf-8?B?VWw2Z3FBQVM5czB2TDV5NlB5YU11by90amxHa1cvRjFmVFZDd0NxYzVJNmRi?=
 =?utf-8?B?RDhFMmxuVkowRkx3OEpxaGRiNHBmT1JnbzUvUERmc1k2YXhuMVcxRTlDNDh0?=
 =?utf-8?B?RllBa3BJTUhDaVUzYkdlVGNnbFBhb2YwVk03TlM4azVIS2YycjhWeUFtcW0x?=
 =?utf-8?B?TitCejd6ZEU2WlU4MWtQcWJ6NytraVU4OXhQc09YUW51YjVGaG1HRURUbFN3?=
 =?utf-8?B?SEVYUXdpQlZ6UHFNRWVmR0RFRExkTzZRYXFWUnlLYUFsajlBTDh5R2tzZWpU?=
 =?utf-8?B?Q2hhdGJnaUwzRlh0cm9nVzkvbGFFeUNhdmdhOWRVLytySmJ0a3FpdzlMTXF1?=
 =?utf-8?B?RTV4OUxFVEpYRjliQnphdWh5dEFpUjFvS1NSTzRndmlUQ3VoUzlyY3dGOTVH?=
 =?utf-8?B?N2tVUFFNWUZGa0hRbFUrWnpMY1VjMWdkNzBqa3o5UjBRdjlNb3NTVlUyZ3My?=
 =?utf-8?B?VE1pY1BzL0l4VG1ycDJKUEl0ZVVGWlo5c25vaW9wUmpKMzBUeENEUGNCKzRS?=
 =?utf-8?B?Y2ZXcE9PUjMya21TRkVPOTFHc0RpNUdHRERuVVpJam5HZEhreXN4MGpFV3JC?=
 =?utf-8?B?QmRpMEcvNnAvZ1Q1V0dXTDZQUEd3NnplK0FFVnRRclpHWU1GdUhyREc3QnI2?=
 =?utf-8?B?b2NNMjFhcE0vR2FDRVlWTHZxVEdnMFJ3NTZVTmtoZlZiKzdZdUVXeXdQQVpC?=
 =?utf-8?B?ZzRuSmtYMnkyTkhlWFBmbWpGZFRsTE9VVEJEbW1GTG5xK1ZmQ2d0KzFIMGsr?=
 =?utf-8?B?bFZKakdZUnFYWXVNQXFCbithOUVTTmJuRmwxNTZvMDQ0ekpnazNXZlM0WWhq?=
 =?utf-8?B?WFZEakJ4WjdYeVZOaUx4U0J1akpkaGRkMmpnb1hEVUtPYXQ5clhiemZpLzU5?=
 =?utf-8?B?azYzLzNncEdjcXdvaU1DQT09?=
x-microsoft-antispam-prvs: <SN6PR04MB502100D136924D44FDBA20BAFC7B0@SN6PR04MB5021.namprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(66066001)(6436002)(86362001)(256004)(55016002)(105586002)(11346002)(7736002)(305945005)(68736007)(446003)(478600001)(54906003)(25786009)(14454004)(81156014)(52536013)(8936002)(2906002)(316002)(14444005)(5660300002)(229853002)(81166006)(110136005)(9686003)(8676002)(7416002)(74316002)(186003)(33656002)(71190400001)(71200400001)(4326008)(3846002)(486006)(72206003)(106356001)(6116002)(99286004)(476003)(97736004)(7696005)(6246003)(53936002)(26005)(6506007)(76176011)(102836004)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5021;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nPV8nFpebNKMp7vKs3dxfVcYdhw0nYrmaXgnoS5wAFXaexSJOOYR1o5nNPSYK74rX2iYPfLuaa0+mu6ZHxapYtSSYXzlgHo059cVDQEWMHV2kUabp+bhRx+INm6jrRKONOHWEIDH+BElq1TX/sf5LAE6jj5k/cSipzP2qr1s1yzGDRWjomMa9xJ/1ebvLbliHsBY55PPmsgDPFelovfmqq3ljcFokhUaH/gNYXlR8C+CPWjIIC2zBxX5BItJceXVcUxMGMba2iC4Z51d0NlWoCjxub758BMQ9Xs7kcacxrKyimpZJaxD5u1dKAmnW1T8pqSmN5uUQl+jDPje+3RYOYhzpkX/mh9OJv04/UoZQ9dmcCWkkVpke3dNncDNZId/SV+usNxZidRDKlNDCwum+0gxLxv5Nyszkj61kbyCn4A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77213753-73e0-49f0-f60f-08d69bc98a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 09:05:23.0043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gQ29tbWl0IDYwZjAxODcwMzFjMCAoImRpc2FibGUgdmNjcSBpZiBpdCdzIG5vdCBuZWVk
ZWQgYnkgVUZTIGRldmljZSIpDQo+IGludHJvZHVjZWQgYSBzbWFsbCBwb3dlciBvcHRpbWl6YXRp
b24gYXMgYSBkcml2ZXIgcXVpcms6IGlnbm9yZSB0aGUNCj4gdmNjcSBsb2FkIHNwZWNpZmllZCBp
biB0aGUgVUZTSEMgRFQgbm9kZSB3aGVuIHNhaWQgaG9zdCBjb250cm9sbGVyDQo+IGlzIGNvbm5l
Y3RlZCB0byBzcGVjaWZpYyBGbGFzaCBjaGlwcyAoU2Ftc3VuZyBhbmQgSHluaXggY3VycmVudGx5
KS4NCj4gDQo+IFVuZm9ydHVuYXRlbHksIHRoaXMgb3B0aW1pemF0aW9uIGJyZWFrcyBVRlMgb24g
c3lzdGVtcyB3aGVyZSB2Y2NxDQo+IHBvd2VycyBub3Qgb25seSB0aGUgRmxhc2ggY2hpcCwgYnV0
IHRoZSBob3N0IGNvbnRyb2xsZXIgYXMgd2VsbCwNCj4gc3VjaCBhcyBBUFE4MDk4IE1FRElBQk9Y
IG9yIE1UUDg5OTg6DQo+IA0KPiBbICAgIDMuOTI5ODc3XSB1ZnNoY2QtcWNvbSAxZGE0MDAwLnVm
c2hjOiB1ZnNoY2RfcXVlcnlfYXR0cjogb3Bjb2RlIDB4MDQNCj4gZm9yIGlkbiAxMyBmYWlsZWQs
IGluZGV4IDAsIGVyciA9IC0xMQ0KPiBbICAgIDUuNDMzODE1XSB1ZnNoY2QtcWNvbSAxZGE0MDAw
LnVmc2hjOiB1ZnNoY2RfcXVlcnlfYXR0cjogb3Bjb2RlIDB4MDQNCj4gZm9yIGlkbiAxMyBmYWls
ZWQsIGluZGV4IDAsIGVyciA9IC0xMQ0KPiBbICAgIDYuOTM3NzcxXSB1ZnNoY2QtcWNvbSAxZGE0
MDAwLnVmc2hjOiB1ZnNoY2RfcXVlcnlfYXR0cjogb3Bjb2RlIDB4MDQNCj4gZm9yIGlkbiAxMyBm
YWlsZWQsIGluZGV4IDAsIGVyciA9IC0xMQ0KPiBbICAgIDYuOTM3ODY2XSB1ZnNoY2QtcWNvbSAx
ZGE0MDAwLnVmc2hjOiB1ZnNoY2RfcXVlcnlfYXR0cl9yZXRyeTogcXVlcnkNCj4gYXR0cmlidXRl
LCBpZG4gMTMsIGZhaWxlZCB3aXRoIGVycm9yIC0xMSBhZnRlciAzIHJldGlyZXMNCj4gWyAgICA2
Ljk0NjQxMl0gdWZzaGNkLXFjb20gMWRhNDAwMC51ZnNoYzogdWZzaGNkX2Rpc2FibGVfYXV0b19i
a29wczoNCj4gZmFpbGVkIHRvIGVuYWJsZSBleGNlcHRpb24gZXZlbnQgLTExDQo+IFsgICAgNi45
NTc5NzJdIHVmc2hjZC1xY29tIDFkYTQwMDAudWZzaGM6IGRtZS1wZWVyLWdldDogYXR0ci1pZCAw
eDE1ODcNCj4gZmFpbGVkIDMgcmV0cmllcw0KPiBbICAgIDYuOTY3MTgxXSB1ZnNoY2QtcWNvbSAx
ZGE0MDAwLnVmc2hjOiBkbWUtcGVlci1nZXQ6IGF0dHItaWQgMHgxNTg2DQo+IGZhaWxlZCAzIHJl
dHJpZXMNCj4gWyAgICA2Ljk3NTAyNV0gdWZzaGNkLXFjb20gMWRhNDAwMC51ZnNoYzogdWZzaGNk
X2dldF9tYXhfcHdyX21vZGU6DQo+IGludmFsaWQgbWF4IHB3bSB0eCBnZWFyIHJlYWQgPSAwDQo+
IFsgICAgNi45ODI3NTVdIHVmc2hjZC1xY29tIDFkYTQwMDAudWZzaGM6IHVmc2hjZF9wcm9iZV9o
YmE6IEZhaWxlZCBnZXR0aW5nDQo+IG1heCBzdXBwb3J0ZWQgcG93ZXIgbW9kZQ0KPiBbICAgIDgu
NTA1NzcwXSB1ZnNoY2QtcWNvbSAxZGE0MDAwLnVmc2hjOiB1ZnNoY2RfcXVlcnlfZmxhZzogU2Vu
ZGluZyBmbGFnDQo+IHF1ZXJ5IGZvciBpZG4gMyBmYWlsZWQsIGVyciA9IC0xMQ0KPiBbICAgMTAu
MDA5ODA3XSB1ZnNoY2QtcWNvbSAxZGE0MDAwLnVmc2hjOiB1ZnNoY2RfcXVlcnlfZmxhZzogU2Vu
ZGluZyBmbGFnDQo+IHF1ZXJ5IGZvciBpZG4gMyBmYWlsZWQsIGVyciA9IC0xMQ0KPiBbICAgMTEu
NTEzNzY2XSB1ZnNoY2QtcWNvbSAxZGE0MDAwLnVmc2hjOiB1ZnNoY2RfcXVlcnlfZmxhZzogU2Vu
ZGluZyBmbGFnDQo+IHF1ZXJ5IGZvciBpZG4gMyBmYWlsZWQsIGVyciA9IC0xMQ0KPiBbICAgMTEu
NTEzODYxXSB1ZnNoY2QtcWNvbSAxZGE0MDAwLnVmc2hjOiB1ZnNoY2RfcXVlcnlfZmxhZ19yZXRy
eTogcXVlcnkNCj4gYXR0cmlidXRlLCBvcGNvZGUgNSwgaWRuIDMsIGZhaWxlZCB3aXRoIGVycm9y
IC0xMSBhZnRlciAzIHJldGlyZXMNCj4gWyAgIDEzLjA0OTgwN10gdWZzaGNkLXFjb20gMWRhNDAw
MC51ZnNoYzogX191ZnNoY2RfcXVlcnlfZGVzY3JpcHRvcjoNCj4gb3Bjb2RlIDB4MDEgZm9yIGlk
biA4IGZhaWxlZCwgaW5kZXggMCwgZXJyID0gLTExDQo+IFsgICAxNC41NTM3NjhdIHVmc2hjZC1x
Y29tIDFkYTQwMDAudWZzaGM6IF9fdWZzaGNkX3F1ZXJ5X2Rlc2NyaXB0b3I6DQo+IG9wY29kZSAw
eDAxIGZvciBpZG4gOCBmYWlsZWQsIGluZGV4IDAsIGVyciA9IC0xMQ0KPiBbICAgMTYuMDU3NzY3
XSB1ZnNoY2QtcWNvbSAxZGE0MDAwLnVmc2hjOiBfX3Vmc2hjZF9xdWVyeV9kZXNjcmlwdG9yOg0K
PiBvcGNvZGUgMHgwMSBmb3IgaWRuIDggZmFpbGVkLCBpbmRleCAwLCBlcnIgPSAtMTENCj4gWyAg
IDE2LjA1Nzg3Ml0gdWZzaGNkLXFjb20gMWRhNDAwMC51ZnNoYzogdWZzaGNkX3JlYWRfZGVzY19w
YXJhbTogRmFpbGVkDQo+IHJlYWRpbmcgZGVzY3JpcHRvci4gZGVzY19pZCA4LCBkZXNjX2luZGV4
IDAsIHBhcmFtX29mZnNldCAwLCByZXQgLTExDQo+IFsgICAxNi4wNjcxMDldIHVmc2hjZC1xY29t
IDFkYTQwMDAudWZzaGM6IHVmc2hjZF9pbml0X2ljY19sZXZlbHM6IEZhaWxlZA0KPiByZWFkaW5n
IHBvd2VyIGRlc2NyaXB0b3IubGVuID0gOTggcmV0ID0gLTExDQo+IFsgICAzNy4wNzM3ODddIHVm
c2hjZC1xY29tIDFkYTQwMDAudWZzaGM6IGxpbmsgc3RhcnR1cCBmYWlsZWQgMQ0KPiANCj4gSW4g
bXkgb3BpbmlvbiwgdGhlIHJhdGlvbmFsZSBmb3IgdGhlIG9yaWdpbmFsIHBhdGNoIGlzIHF1ZXN0
aW9uYWJsZS4NCj4gSWYgbmVpdGhlciB0aGUgVUZTSEMsIG5vciB0aGUgRmxhc2ggY2hpcCwgcmVx
dWlyZSBhbnkgbG9hZCBmcm9tIHZjY3EsDQo+IHRoZW4gdGhhdCBwb3dlciByYWlsIHNob3VsZCBz
aW1wbHkgbm90IGJlIHNwZWNpZmllZCBhdCBhbGwgaW4gdGhlIERULg0KPiANCj4gV29ya2luZyBh
cm91bmQgdGhhdCBmYWN0IGluIHRoZSBkcml2ZXIgaXMgZGV0cmltZW50YWwsIGFzIGV2aWRlbmNl
ZA0KPiBieSB0aGUgZmFpbHVyZSB0byBpbml0aWFsaXplIHRoZSBob3N0IGNvbnRyb2xsZXIgb24g
TVNNODk5OC4NCj4gDQo+IFJldmVydCB0aGUgb3JpZ2luYWwgcGF0Y2gsIGFuZCBjbGVhbiB1cCBs
b29zZSBlbmRzIGluIHRoZSBuZXh0IHBhdGNoLg0KPiANCj4gUmVsZXZhbnQgcGF0Y2hlczoNCj4g
DQo+IDYwZjAxODcwMzFjMDVlMDRjYmFkZmZiNjJmNTU3ZDBmZjM1NjQ0OTANCj4gYzU4YWI3YWFi
NzFlMmM3ODMwODcxMTVmMGNlMTYyM2MyZmRjZjBiMg0KPiA0NmMxY2Y3MDYwNzY1MDBjZGNkZTM0
NDViZTk3MjMzNzkzZWVjN2YxDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjIEdvbnphbGV6IDxt
YXJjLncuZ29uemFsZXpAZnJlZS5mcj4NCkFja2VkLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRt
YW5Ad2RjLmNvbT4gDQo=
