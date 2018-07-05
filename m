Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858DEC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B5624029
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kQf8H9t7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oa46mUIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B5624029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbeGERYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:24:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25253 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753213AbeGERY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530811468; x=1562347468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+D35j3Ka2vAsYOAn9P9nKeCdAckclzUgSqWirz5FypI=;
  b=kQf8H9t7C2TfvY20DvLtULpjTooJsPyQYhb5btVFye/LXPfrmDhOK5ET
   +ekvrih3uSWv17LTsNIpyScv6PS8zGq79QzdybQEQSzJXo3R0x71Mkeeg
   EezSbIx0jvGorbmeuywn/LY6uSteJNCh9jzh8ada441/FRXAF9LEqm3a6
   wQOabYKRqXwctr+B/ghVvjT+QfEBwGVmjyAFfG4p+/u7AXsVZU1FCU3cJ
   0qRlE8TgSa1la3+5pKW3UMSeyWm5uN2O5Aolik35oafojt/SzYr94p+VT
   b7+FNqxbecs0P2ZOuiRRm0ViGkzU6kfZRXAdTlPKFJvGC/OluTsxvmbqQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,313,1526313600"; 
   d="scan'208";a="83325580"
Received: from mail-dm3nam05lp0120.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([216.32.181.120])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2018 01:24:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D35j3Ka2vAsYOAn9P9nKeCdAckclzUgSqWirz5FypI=;
 b=oa46mUIg8S/dB6b3SwdZlgDdLbJIe9b7FptVlznpdjIMm6vgjXZ8elWKlDGrzNr3qR2hvIlO4wtv9aN9AlFEm6NJxSJXOxqsB8n+Kj468Iupw96sphJGZ2AHMjWAZppdsZrXIhaFN9xzaYcvVnTrEMc7y2vy9neV/AIlUdVKdgE=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0463.namprd04.prod.outlook.com (10.173.48.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Thu, 5 Jul 2018 17:24:24 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0906.026; Thu, 5 Jul 2018
 17:24:24 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "RaghavaAditya.Renukunta@microsemi.com" 
        <RaghavaAditya.Renukunta@microsemi.com>,
        "david.carroll@microsemi.com" <david.carroll@microsemi.com>
Subject: Re: [PATCH 1/4] scsi: aacraid: remove AAC_STAT_GOOD define
Thread-Topic: [PATCH 1/4] scsi: aacraid: remove AAC_STAT_GOOD define
Thread-Index: AQHUFE+5LXiqTazrikuo5Sq4JRlRiaSA4WcA
Date:   Thu, 5 Jul 2018 17:24:23 +0000
Message-ID: <babfea1746aaca57109f84bff674dda635a76e29.camel@wdc.com>
References: <20180705110140.19545-1-jthumshirn@suse.de>
         <20180705110140.19545-2-jthumshirn@suse.de>
In-Reply-To: <20180705110140.19545-2-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0463;7:p7ytk2MOtOkkvTac/79TxEkMSFQ9TWyNLoKe+gSR01BP56a8WafOcfg5JhjTSnpKD3rEqjXbv54bAI1/2qp/B2CvnnfE0PAWxjQSOk24NGDK3hVGgmnkN7eC75b4e+3HGpTNHqAppI571cfx13+JWl2sFZFwaddDg7DHqxJiu75imAcalJ5rsAf4LzKq9bA9TlaL8K5MldgcGSxhJ8Ya1sIHbZUYIVj/Zlfz+HGeK3LKX1VakezuogmO/WsZWm/T;20:utxQtwiwqJR0grJtLRnOq2Nn9Y1tbAH3g2Afw9S+ubfaW1gTsPQds7k69kWD4VosMPiZJ2dITdDadvkp+XkdF5NDXi1lstB2nhm+ZHEHRWP7fnoMpqrAY/kiidHi9jV3pLTjm7TQTGdmRNNuThbGk7az7z9HkdA+nXKjBxP4lDU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ded33f53-d8c5-42dc-e797-08d5e29c2713
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0463;
x-ms-traffictypediagnostic: MWHPR04MB0463:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0463FCB9862C52F4144FEBEE98400@MWHPR04MB0463.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0463;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0463;
x-forefront-prvs: 0724FCD4CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(6116002)(3846002)(86362001)(14454004)(2900100001)(25786009)(478600001)(97736004)(72206003)(118296001)(316002)(36756003)(305945005)(68736007)(5660300001)(7736002)(8936002)(2906002)(229853002)(106356001)(105586002)(486006)(186003)(53936002)(81156014)(81166006)(6512007)(66066001)(99286004)(6436002)(6506007)(102836004)(446003)(476003)(26005)(6486002)(76176011)(11346002)(2616005)(54906003)(5250100002)(2501003)(256004)(6246003)(110136005)(4326008)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0463;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: sxiuuTBcZHNIlSihyN3hyyTU2A5R5F4Y3njIYGqkg/6de6FslyOLc/3q95Lxl9QB+tStqkHdTD5MXoYFf3yn5rLoTftynAkkaNAYjxjhLKRhYYGG0pzIQLcTZa6N66XRXpXv7aHDSuFdKZnRcnSQeJNLN8RJ6fNw+0f0EIkcpJ9QBSiw7PKYEmwzZfdUSeLMVVK63GKP2qJ2tU0e8ha4M4/zZE+TrrgZNAZeVuStZR9WASC1f1W/PLi5ISF+JGM1lsZWi94egYNGBAU7hwQSTRcPSjNq9Ng69SmURW2hmhPvEVl4QZc+yWpJ8joy0rpRiIEPXimoE3Zu1T6cYkGN4EJCHWbiXTyKPHGgoa6A1TI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDF67FE8D276144489A6B17C365ED9BC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded33f53-d8c5-42dc-e797-08d5e29c2713
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 17:24:23.9012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA3LTA1IGF0IDEzOjAxICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+ICAJCWlmICgoKGFhY19jYWNoZSAmIDYpID09IDYpICYmIGRldi0+Y2FjaGVfcHJvdGVj
dGVkKSB7DQo+IC0JCQlzY3NpY21kLT5yZXN1bHQgPSBBQUNfU1RBVF9HT09EOw0KPiArCQkJc2Nz
aWNtZC0+cmVzdWx0ID0gRElEX09LIDw8IDE2IHwgQ09NTUFORF9DT01QTEVURSA8PCA4IHwNCj4g
KwkJCQkJICBTQU1fU1RBVF9HT09EOw0KDQpEb2VzIEFBQ19TVEFUX0dPT0QgcmVhbGx5IGhhdmUg
dG8gYmUgZXhwYW5kZWQgaW4gZnVsbCBtdWx0aXBsZSB0aW1lcz8NCkhhdmUgeW91IGNvbnNpZGVy
ZWQgdG8gcmVwbGFjZSBBQUNfU1RBVF9HT09EIGJ5IHRoZSBudW1lcmljYWwgY29uc3RhbnQNCjAg
aW5zdGVhZD8NCg0KVGhhbmtzLA0KDQpCYXJ0Lg0KDQoNCg0KDQo=
