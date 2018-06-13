Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 66652C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1184020020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n0o/KVyJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Rd4d3dno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1184020020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935593AbeFMNFM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:05:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48556 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754478AbeFMNFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528895110; x=1560431110;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=CDWb79yzSxEk0p0QbiDcJYOpkvsP/rFbu18VBSyKzXk=;
  b=n0o/KVyJ/11BQC7z2JQGW9i86zRYxD1CM833B+ng98wmdsrH5Xps2goE
   JoRhIATwPc3jd7R945+BXvDH7dRxQ5ceo2Mao3mnAUQXwAU7U2F3uv6o3
   vkN26ErR2IiypGcnTYGBZnsH6fatSBrXvxRnK6f7Slw8Z0D2QRBGKFXPj
   WUmzCLLAdw05p5EGSiV/qBMqLsckJHHLgzCPqgoTVA70bWL4fvXIjKnRu
   zEn8WI6BgX+pyoIa20pbDJ7aGHSrhQbVwXJDU7jW7j1o4B1w+xeWlMR5M
   PBNpkEKsz8Bq7mtX0qN0tRbieyZS2ckoSu7rnB90L8m9ym5MJ6dN7Tpso
   A==;
X-IronPort-AV: E=Sophos;i="5.51,218,1526313600"; 
   d="scan'208";a="82408177"
Received: from mail-co1nam03lp0019.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([216.32.181.19])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2018 21:05:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDWb79yzSxEk0p0QbiDcJYOpkvsP/rFbu18VBSyKzXk=;
 b=Rd4d3dnoatkTl69PyO+eTfRkbXpsrp5qIPunvrD1DG84LrHk2DJv/lest+IdZFftYB2gITTokUk44R/ujKEL2P+epkV96DuAolhbZbpNS/TEk+qcLQuxZaFGSnrSVHD4109EPpfJQUhfNro+8Gy7Oygj87aqOXwB87jN0pasGQE=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0880.namprd04.prod.outlook.com (10.174.174.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Wed, 13 Jun 2018 13:05:08 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Wed, 13 Jun 2018
 13:05:07 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "randrianasulu@gmail.com" <randrianasulu@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: Fwd: Re: kernel BUG at drivers/scsi/scsi_error.c:197! - git
 4.17.0-x64-08428-g7d3bf613e99a
Thread-Topic: Fwd: Re: kernel BUG at drivers/scsi/scsi_error.c:197! - git
 4.17.0-x64-08428-g7d3bf613e99a
Thread-Index: AQHUAsVwkM7cfrEV4EWfUb5bnyHWyKReKMEA
Date:   Wed, 13 Jun 2018 13:05:07 +0000
Message-ID: <3ab38d8d65c34d4109195f29bae61429f30b13aa.camel@wdc.com>
References: <201806130602.59441.randrianasulu@gmail.com>
In-Reply-To: <201806130602.59441.randrianasulu@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [76.103.130.147]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0880;7:DR3gVBPxnbuYd+152FmtobZF72+OTRumdlOQpPTg9u4G0Hv0pPz3jBdCweucdo6uWzckQvUaVcZyrrLPFokSHMeMONSyd9InBwETOpGAVuLt+9P1nUPcmew5yaYKroeFrcVaENbX0snqyLPtl4at79BQQU3TCDf4FqWL6bJ2w1asn/DAtE+okvaBJvlBmRfnPwOnO8Oo4ojz4WhFFW6fy4SJwfnCURqnx37BF/Iezmn3qC3owmhEyGAtZgNgNLlg;20:fYcJx4n99u28x1bpnixHbfH9DXBpelS+iqE+nkASpvA0+ugIBciqMHsdsPMXrKd+3rLEIYCcBCuOxQ+AbWNWysWDxrlLh8Ya2WnW2KJA1M8duWCeKGdc9cNnhdt5rsNB8eDL5rw8DrE1e9Qjp1aaIxYV7mdjB4KH/ZiQlcv+RcA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3626edb-3774-418b-6fd8-08d5d12e49d0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0880;
x-ms-traffictypediagnostic: MWHPR04MB0880:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB088088D4CA462E01D31C500D987E0@MWHPR04MB0880.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0880;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0880;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39850400004)(366004)(396003)(199004)(189003)(66066001)(2501003)(72206003)(76176011)(99286004)(186003)(486006)(5660300001)(5250100002)(26005)(6436002)(446003)(11346002)(14454004)(2616005)(476003)(68736007)(86362001)(2201001)(478600001)(6506007)(316002)(110136005)(102836004)(7736002)(305945005)(6246003)(3660700001)(3280700002)(97736004)(2900100001)(6116002)(106356001)(8936002)(81166006)(2906002)(36756003)(39060400002)(81156014)(229853002)(6512007)(3846002)(105586002)(118296001)(6486002)(53936002)(25786009)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0880;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9OlSpXR/ZTJN9DeVqWdNeZj0QeYTO67YlMwsF+Ol/3BvUpPteNiurTSp1Gu0kDGkOvvlP0hzUhBJmMlMH5KDI6XwuuRPPBE46rIGfoEnBekz0BWMXCUgf/80hN7tmjoHXPG9nuOexPQu/SexMff3VnK/AECpapTa8K44iAa6ie3yxCqmefvsbwF7bte8NlQM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFD1BF45589A9E408800B34A1B81917A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3626edb-3774-418b-6fd8-08d5d12e49d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 13:05:07.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0880
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA2LTEzIGF0IDA2OjAyICswMzAwLCBBbmRyZXcgUmFuZHJpYW5hc3VsdSB3
cm90ZToNCj4gYWZ0ZXIgcmV0ZXN0aW5nIHdpdGggZ2l0IHVwIHRvIA0KPiA0LjE3LjAteDY0LTEx
NzAxLWc0NTk3ZmNmZjA3MDQtZGlydHkNCj4gDQo+IEJVRyBsaW5lIGlzIGdvbmUgLCB5ZXQgczJy
YW0gc3RpbGwgbm90IHdvcmtpbmc6DQoNCkhlbGxvIEFuZHJldywNCg0KSGF2ZSB5b3UgYWxyZWFk
eSB2ZXJpZmllZCB3aGV0aGVyIHMycmFtIHdvcmtzIGFnYWluIGFmdGVyIGhhdmluZyBhcHBsaWVk
DQpKaWFuY2hhbydzIHBhdGNoPw0KDQpUaGFua3MsDQoNCkJhcnQuDQoNCg0KDQo=
