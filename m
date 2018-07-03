Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7981C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F662463B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dpE12RG8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QGZMo7kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F662463B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeGCXVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:21:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4659 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbeGCXVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530660082; x=1562196082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NBxdIztVrcyxDd6nT/2koHAmeDUXovI2MG/FFK4vxbA=;
  b=dpE12RG8RJgfjlGou/uGOBjFTtmKkkG2RMvFZstWt1uN0cNUz6YIVLHE
   5hhGXILgYHvNVrsOxdfeuGJxiSQK+c2CZV9ighQJqAUXB4793c04TZfgT
   x2mOZOlJ2+ggzrxUtT7JwMZrfS/1ISFTroQBsYmVPCNTRv1feVSKz2uV6
   1ttW36RbrxIpgN7FOX4h8c4OYn6thuQRLv/2jl5sH+ttvBq6tjEb0qCbZ
   OPcsN6wGqg17H0E2ohcKzafLx6XOW97bbUXvL1XXZnb12d/j+wD6tFNIO
   xaIw0fF6UFGsTvl5EVJRz0SlHMCU5GJI2FQ0iPo0+Hv85COrLoW6sZ6UM
   A==;
X-IronPort-AV: E=Sophos;i="5.51,306,1526313600"; 
   d="scan'208";a="83705655"
Received: from mail-sn1nam01lp0117.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([207.46.163.117])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2018 07:21:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBxdIztVrcyxDd6nT/2koHAmeDUXovI2MG/FFK4vxbA=;
 b=QGZMo7kgMDoSiU8kvY/VSC3aI2wwj/4PcYWHW/yX2gogYIzujP5xrA9bAS/5V9/4TQ4EjcZdx06A+jiBNKzKd2ygy1oefWlv8bsDlmFKhz09LW3G4kJn7Aun9ZgLqjWVCKhNOohftPxHIzwH7f+FJSm/eH5sSJuNJFmvuerLYDM=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0592.namprd04.prod.outlook.com (10.173.49.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Tue, 3 Jul 2018 23:21:19 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0906.025; Tue, 3 Jul 2018
 23:21:18 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "hch@lst.de" <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [RFC] scsi: switch to scsi-mq by default
Thread-Topic: [RFC] scsi: switch to scsi-mq by default
Thread-Index: AQHUEpq3M7qagL4jW0q5EukcipvbmaR+I98A
Date:   Tue, 3 Jul 2018 23:21:18 +0000
Message-ID: <7ab21471b799d2a60ccfd8579b2548f58915568a.camel@wdc.com>
References: <20180703065413.6098-1-jthumshirn@suse.de>
In-Reply-To: <20180703065413.6098-1-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0592;7:AquJnJSzfzp3xHxgHNrVQq9JfAgPmTbU3NNtqDQ1/ENSbr3tWbg2/BssRqX4wI87W7VqPv50dltQ2C6pNdgdsz8kE7K+J5oWIUwVLND9WXIEY/3oOYlTOzcA8YKivoIpxxjOltNvnjQvBBLz91/LKpQKsHKc2vYBPyf/ZFd+ljVMU+cwxsPZ6ZX44XeRjL6hkqSagoeO37X7gH0czk3QX1sxy5WdYG61ZCouQvdCAM15Kn06/k9cxE6XC3BhIXEu;20:D4ZM1jWmM7dFM4n7bm7wHy4C6YVY6qg1qw2x9EHwLtv6FJ9Tmppzqba1X1B2b9vwYN0VbH/3G/fOUDnPKQfki+mX9lSTD9pb89XdSIHsw8HwryYn9cN29W6dVJqXyMvsL8iwxCTc8zpZ1Tk0f7DTQP2QTyZHykGU5dalK/lWVTw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e40b0e6b-d34e-471f-d1a3-08d5e13bae33
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0592;
x-ms-traffictypediagnostic: MWHPR04MB0592:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0592DA5C7AF197FB9A85A67798420@MWHPR04MB0592.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0592;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0592;
x-forefront-prvs: 0722981D2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(55674003)(189003)(97736004)(316002)(68736007)(66066001)(76176011)(3846002)(446003)(54906003)(6116002)(2900100001)(53936002)(72206003)(4326008)(106356001)(6246003)(5660300001)(99286004)(486006)(14454004)(118296001)(7736002)(478600001)(6436002)(8936002)(81156014)(81166006)(2501003)(11346002)(476003)(26005)(102836004)(8676002)(5250100002)(36756003)(6512007)(14444005)(256004)(86362001)(186003)(305945005)(229853002)(6506007)(39060400002)(2616005)(110136005)(6486002)(2906002)(105586002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0592;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: TAGIlHJIRZcLRATXDVy92KPtg+wrnsoNFcAkveEilA599iJs308GoAsBgp2k2rGpioZflQlimH2qp5XtimHmQ9ul8ZkX60QGOM01Qzjy7HLYsd+wKbHIN40U+Ta0QGIHxOt0nA1cgwKfq7jpLfeCaXMlC+1E3jz4pK0VxMRWfV/jmXV968SMF4vpbJIoVFf1N/kjO3TOfcumch3rZhFXgtqERRDzS7AVcMYrevtjhUgHnhbJzX7n1lofdyO2HHWn72RXUQydvS4ki3H06IWehgfN1FvEdP+wv4nybgzE5Tvu4XbV6vBjOCjnxMM8P0zcJAn5rkiDQC9fnOO+OkSYe3UJmRzf1a1je7bTy6EUaj4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D3301BF8E0FBE41B8E13CD04298DF33@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e40b0e6b-d34e-471f-d1a3-08d5e13bae33
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2018 23:21:18.2693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTAzIGF0IDA4OjU0ICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IEl0IGhhcyBiZWVuIG1vcmUgdGhhbiBvbmUgeWVhciBzaW5jZSB3ZSB0cmllZCB0byBj
aGFuZ2UgdGhlIGRlZmF1bHQNCj4gZnJvbSBsZWdhY3kgdG8gbXVsdGkgcXVldWUgaW4gU0NTSS4g
QmFjayB0aGVuIHdlIGhhZCB0byByZXRyYWN0IHRoZQ0KPiBjaGFuZ2UgYmVjYXVzZSBvZiBwZXJm
b3JtYW5jZSBpc3N1ZXMgd2l0aCByb3RhdGluZyBkaXNrcy4NCj4gDQo+IEluIHRoZSBtZWFudGlt
ZSB0aGVyZSBoYXZlIGJlZW4gYSBzdWJzdGFudGlhbCBhbW91bnQgb2YgcGVyZm9ybWFuY2UNCj4g
aW1wcm92ZW1lbnRzLCB0aHVzIHdlIGNhbiByZS1lbmFibGUgc2NzaS1tcSB3aXRob3V0IGEgc2ln
bmlmaWNhbnQNCj4gcGVyZm9ybWFuY2UgcGVuYWx0eS4NCg0KSGVsbG8gSm9oYW5uZXMsDQoNClBs
ZWFzZSBpbmNsdWRlIHJlZmVyZW5jZXMgdG8gY29tbWl0cyBjYmU3ZGZhMjZlZWUgKCJSZXZlcnQg
InNjc2k6DQpkZWZhdWx0IHRvIHNjc2ktbXEiIikgYW5kIDVjMjc5YmQ5ZTQwNiAoInNjc2k6IGRl
ZmF1bHQgdG8gc2NzaS1tcSIpLg0KSSB0aGluayBpdCdzIGEgZ29vZCBpZGVhIHRvIG1lbnRpb24g
dGhhdCBzdXNwZW5kL3Jlc3VtZSBub3cgd29ya3MNCndpdGggc2NzaS1tcS4NCg0KQmFydC4NCg0K
DQoNCg0KDQoNCg0KDQo=
