Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D3BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BB22080A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AieviuyE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="her4n8ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBDTvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:51:21 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32092 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfBDTvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549309881; x=1580845881;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DM/p+gpI3ssOuvjoOri2ulMCQSkfABk7VMRKlTrdy7A=;
  b=AieviuyEfHLVOtwjQOEPdWdjbF2WK5dhbMxnQasLQl7nX8T/a7ueBtQc
   jeZ/4qT6ID3srzSucwKW3hUlQNGkvfAdx/w3pDhUsA446I7mu2KNZO0bS
   eJyCfBq2ihfQTmvPGs2ThJtaXXfUEmfNt0V2yBwnQ+rOoxyynXYwV2TpF
   lYvtTXAB9O2R3AdO/uGV5xYIIH31ysxEY4cdSRYkhmp5zG4B6NUbFr0k5
   4H5gUdNiOyTuyYbe6MvKSBRhpORrRKBKS3PBxysuSYD8aHz0s2VbVsX6I
   ee6PBnwKnrqx07GAVdhwWfnrOzbNj58meWuUntvmCqEcGWLixprhsr4UD
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,560,1539619200"; 
   d="scan'208";a="100492595"
Received: from mail-dm3nam03lp2055.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.55])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2019 03:51:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM/p+gpI3ssOuvjoOri2ulMCQSkfABk7VMRKlTrdy7A=;
 b=her4n8oxQtwgmYRcLQc/1fUTye6kVwNyUqIYYATakCtimRvQdbfYiH/07mp0ihLoIrqJAnAez8eIs/RY4cZMDZGlQF04ukohTW0QqnuMZY1y2m+UyXFPk7zme1SEk3Rn+9GE+giSCszHLT9g3k8WXyuA1FfQjQ9+RoG+54AT76Y=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5344.namprd04.prod.outlook.com (20.177.255.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Mon, 4 Feb 2019 19:51:17 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 19:51:17 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        SCSI <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH v3 5/5] Revert "scsi: ufs: disable vccq if it's not needed
 by UFS device"
Thread-Topic: [PATCH v3 5/5] Revert "scsi: ufs: disable vccq if it's not
 needed by UFS device"
Thread-Index: AQHUvLFjM7n2cnjjv0mu0zRdA0tiuaXQCqXg
Date:   Mon, 4 Feb 2019 19:51:16 +0000
Message-ID: <SN6PR04MB49255ADE41BBD35F894FD4CBFC6D0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
In-Reply-To: <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [129.253.244.4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB5344;6:Z8Z+UD29zQsEPP42cZLv0Ddke3AOFFx6SBYr4x1qjjA+yNiBzOLIo8PYI1h3nbKew33DZwQ5NOP2EZtriFdLCU2o8MISIvblsLdSdZr7f+ESbDb0nshf8GapR4nFm5kDVpr1YIyjnNhND4mUde8GXE2afwI/kLmiJdOloFayV9Dqwa8xaBoI2tePlB4VmPjzX4JRbhB68FUAsDBJwW0j3VSLfXU269Wy25l2DHAJTBm7T3FaiY2LsYbNuZsx4H4duNnJUVop8uIJPJd4QuFPlie1NDkS4oSCbRmOV3wrJRyB8KUWw+Iiad6K7sBT/6r2gj2wHA9prYxMiG5LYmlt7UtWHmw4fXG1EcUSFKfZNEqY0F2MjLXwayzlBBGXjebgt+YVV8gqVa9OTMhHK7nFEC2ArPOpVaj+sYc9Df47BrKyTOqwst7mfw3SfAydpNEUnu1onbmQOutq2+vZGL2Erg==;5:CUyZNhTQTMBuKC+F2N/BsHu+yt7t8/xfbixO3dMcGNPz2wgnoyXVgVBD84LF2cHS4KI6W70/ZfKkp2oQyuSFpmyugrF5029DUA/hL1tQNTD/xy9710FsGTYy3weZNCMtegs8xVI6Bf8qvQK3RoVE1zAdPQxYrQlDdmJcsLJMeY8N34CX7+Wi5C/AK+86U9zQhZjsNatW1TehxIhCQwZAug==;7:Q+DcjJwb+bp20fKBP8JpZZY3Ie7N8mao+fnrdX+EL8lD4m/v309sDbGDHXkzRQOwBUzmXPq7IpxACCOPWP0mqm6M5w01u4yFzsj1gmOwTG4HdEXxEk3su/cnnnRJik3q0Kk6bO0KH5H6c478UNDUPw==
x-ms-office365-filtering-correlation-id: 315110f1-4df2-426b-2c49-08d68ada207d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB5344;
x-ms-traffictypediagnostic: SN6PR04MB5344:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB53443B20EB71AC8864828B9BFC6D0@SN6PR04MB5344.namprd04.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(6506007)(81166006)(8676002)(81156014)(68736007)(74316002)(305945005)(7416002)(72206003)(7736002)(478600001)(4744005)(14454004)(105586002)(106356001)(8936002)(66066001)(2906002)(6116002)(6436002)(3846002)(53936002)(229853002)(55016002)(97736004)(9686003)(7696005)(86362001)(186003)(54906003)(71200400001)(316002)(71190400001)(110136005)(76176011)(4326008)(33656002)(99286004)(446003)(486006)(11346002)(476003)(256004)(25786009)(6246003)(102836004)(26005)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5344;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r2c1MJpNT7FAcH2AGTLKE/WaufbXpZZ3wed4Rx+V9buvUdfHqzHPnE9jrjQW2wtNBg2QMWdGxRwaGqoUSK+e5X5+P0D32W5rkdL9unWOdSs61MqctxFYSuL2irDe1R5R9JGV9Os3is82+mDalrC7bTIsMY9j0m3SfuYUITs0X43xjbXnyeFrjnNk3yxjZT004YHm9m+FVGTsJuYinoP5G1D5Lps8CfXdJqbwTLiy3Xb3f6bV68UZ7YVloQ4E5m1YyvBtBDEYjiweMT4W9JeNupZvs9zLhpXyUMxkPbeZtqkNYsp/x5sL5NMnsHc6vqPD97vqm5OktMIHZ3cA6FFEl+7NG1JursH8VcK/l/WlU65Rpvbn6xFvDaMiP72iiKDfN1960NtpNzvYVteyOmOsNeoa4TFZO7eka+KqTN9WETk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315110f1-4df2-426b-2c49-08d68ada207d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 19:51:17.0280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFRoaXMgcmV2ZXJ0cyBjb21taXQgNjBmMDE4NzAzMWMwNWUwNGNiYWRmZmI2MmY1NTdkMGZm
MzU2NDQ5MC4NCj4gDQo+IENhbGxpbmcgdWZzaGNkX3NldF92Y2NxX3JhaWxfdW51c2VkIGhhbmdz
IG15IHN5c3RlbS4NCj4gSXQgc2VlbXMgdmNjcSBpcyBub3QgKm5vdCogbmVlZGVkLg0KVGhpcyBw
YXRjaCBlc3NlbnRpYWxseSBpbXBsZW1lbnRzIHRoZSBVRlNfREVWSUNFX05PX1ZDQ1EgcXVpcmss
DQpXaGljaCBpcyBuZWVkZWQgZm9yIGJvdGggU2Ftc3VuZyBhbmQgSHluaXggZGV2aWNlcy4NCk9u
Y2UgYWNrZWQgYnkgdGhvc2UgdmVuZG9ycywgY2FuIGJlIHJlbW92ZWQgZnJvbSB0aGUgcXVpcmsg
bGlzdCBhcyB3ZWxsLg0KDQpUaGFua3MsDQpBdnJpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJj
IEdvbnphbGV6IDxtYXJjLncuZ29uemFsZXpAZnJlZS5mcj4NCg==
