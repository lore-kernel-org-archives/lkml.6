Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC8DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E9820863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="E0ZqP+c2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E9820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeK2V0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:26:51 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:51658 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbeK2V0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:26:51 -0500
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="24649434"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Nov 2018 03:21:59 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 29 Nov 2018 03:21:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzl+Tvl3tM2chP+446BwWcVWl0/bvxxouwGR1mj1k6k=;
 b=E0ZqP+c2wvvp3k5xJw/GPtFoTzwh9snlHtIP252YER3iMZ8sT+SuC34CLvd4TVYPDh2yR0LHCf5V+agyo0KjGj3Td0lSu05+8xfnQrF+fln3WE0qICGq3EBEyBLJPHWeKCUvWCgo8iobNuR3/A4RwQTVkqOIztX9WmIQRrlm1iM=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0568.namprd11.prod.outlook.com (10.163.159.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Thu, 29 Nov 2018 10:21:57 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 10:21:57 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <andrew@lunn.ch>
CC:     <harinik@xilinx.com>, <harini.katakam@xilinx.com>,
        <Nicolas.Ferre@microchip.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <shubhrajyoti.datta@xilinx.com>,
        <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
Thread-Topic: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
Thread-Index: AQHUhZa7v3Zh+jBG9kSdXfX2qosMHA==
Date:   Thu, 29 Nov 2018 10:21:56 +0000
Message-ID: <21fb7dab-04a3-d144-4a05-1f5146787f03@microchip.com>
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
 <1543216072-9623-2-git-send-email-harini.katakam@xilinx.com>
 <5de882e3-65ac-7ff1-bb55-7537666dfc77@microchip.com>
 <20181126145210.GD12116@lunn.ch>
 <CAFcVECK=4e-+1u3X+OuLoAEicUtrkTX3C0wzAugMRcJSP0N-Vg@mail.gmail.com>
 <74937246-dc7d-db1c-df00-5db856192eac@microchip.com>
 <20181128003500.GD26096@lunn.ch>
In-Reply-To: <20181128003500.GD26096@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0094.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::47) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0568;6:TkNPMqWf2bPhq+YkZK7Ssmr8Uvaq2KoN4VA41B0or9PjJk8cX37DEgI1GXUzmdipNCzcwY+9xD3Y3SeknOt40QeNFIx+0WmqMHLcCtwpsx6wajy46FPl6S0SnLbca+KOmhFv0KxFcq6zj/KFlzvUWARdi3aB5VeOx9zneFcoG/LP1nZPr5di1ZAV+dOrkDlwKJXgdQU3tC0RqizfPrHh2uXL+S4lnf9jXtUTDZRcAUYueeB4Py2UmdTHNFHY2M3t0F7M4F56QQxpVSt0XDb5WIZQJBnRr9xQSoxvIxiwlY0jhxZMlXv5wSUlW+seOsJA9VIsC53l1L1+k/OJGmIeLCNIGHylaD9husa9AiyPRtEXVzjlGxidMcjGvhFoYalQ5QIzfPbmYH3PPn8FbBHbzgdEWzvz2B5hxwW/UM63OZhzBpbW4/wtb/ILenpRHEMhVFn/r/61YZ1b23R6v+L3Nw==;5:HmeBe8v+jgS1ogkSnw2a6zfs0++7CdvUXu75i19FESXtPmvhSTlizHlca+phZBcUFgXGX08MfSvb2zKRPnUFPfjWbR5OxNeVSLLW+dRSKH5lDl3VCWmiLwwHJ1okZOSKitTxjd5qsqg5gt/ayfk6NktUhLo0vVVFgTE0IHz+ljw=;7:hUQ7NNnzrqxV0afMDPrXct0ensD9kev3hME+mQu7HxdN+0NUdThWQEu8/9emXN9l1ioa1CorxzHuwxVYCBvArFUZjOKDJpPn76/xtU9MPWz6QaI+2rrstj5oFWXg+Ya4nCLmcyWVKSuIba9v1YZEfw==
x-ms-office365-filtering-correlation-id: 15043bd4-65ef-499d-8d56-08d655e47d75
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0568;
x-ms-traffictypediagnostic: BY2PR11MB0568:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-microsoft-antispam-prvs: <BY2PR11MB056864A212EC1584E1B7D8EE87D20@BY2PR11MB0568.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231453)(999002)(944501447)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0568;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0568;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(11346002)(2616005)(25786009)(476003)(446003)(478600001)(316002)(54906003)(8676002)(229853002)(106356001)(256004)(14444005)(81156014)(8936002)(81166006)(186003)(486006)(4326008)(105586002)(6486002)(6246003)(5660300001)(68736007)(53936002)(99286004)(97736004)(72206003)(93886005)(6436002)(6512007)(31686004)(102836004)(6116002)(3846002)(26005)(71190400001)(71200400001)(7736002)(2906002)(31696002)(6916009)(53546011)(52116002)(6506007)(14454004)(66066001)(386003)(305945005)(345774005)(76176011)(36756003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0568;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2F/qgh/t0iOGTGPZ7rVcGTlf/mUOUrwAEw2yfoD6nvf7JffrBsmETY/5a0OaGS5RfDsRD58koVKlxsKJYVIs6DsvqdciqVtJL7m5l90vczx03iVFOHH68gzza7WeKw6DBQBHdxbaS6UnH8RO8ILW10jXf1aTeNPUcfXIU63q0C8b0Q4tlSc4TXmqefGbVOtzaCKIJ1PwM/RcRvb9ebXN5os03+nX+YkBurlwtRU31+j+I1FByolQYJIXxPAgqj3qqHRCAw6YDRSBPe9Wuuo6Wq1AZj9nOV6UGuf0UHzY1XazUg1+uOpjQTF2OqVTficK4DHloenjkiQ8zNBwsHzQZiRAwgW4UL/WroM6B50iW/U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1F65E90748E9241A16959E4420D460D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 15043bd4-65ef-499d-8d56-08d655e47d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 10:21:56.9638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0568
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI4LjExLjIwMTggMDI6MzUsIEFuZHJldyBMdW5uIHdyb3RlOg0KPj4gVGhlbiwgZG8g
eW91IHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byBoYXZlIGEgbmV3IEFQSSBwYXJ0IG9mIHN0
cnVjdA0KPj4gbWlpX2J1cyB0aGF0IGRyaXZlcnMgc2hvdWxkIHJlZ2lzdGVyIHNvIHRoYXQsIHRo
ZSBtaWkgY29yZSB0byBjaGVjayBpZiB0aGUNCj4+IGJ1cyBpcyBpZGxlIGJlZm9yZSBsdW5jaGlu
ZyBhIG5ldyByZXF1ZXN0Pw0KPiANCj4gSSdtIG5vdCBzdXJlIHRoYXQgYWN0dWFsbHkgYnJpbmdz
IGFueXRoaW5nIHVzZWZ1bC4gIFRoZSBjb3JlIGRvZXMgbm90DQo+IGJlbmVmaXQgZnJvbSBpdCwg
YW5kIGl0IGRvZXMgbm90IG1ha2UgdGhlIGRyaXZlciBzaW1wbGVyLg0KDQpPaywgdGhhbmsgeW91
IGZvciB5b3VyIGlucHV0Lg0KDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPiAJQW5kcmV3DQo+IA0K
PiANCg==
