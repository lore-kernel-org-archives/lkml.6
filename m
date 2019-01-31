Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B806DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8921D20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="iO63x+Ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbfAaKms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:42:48 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:65006 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaKms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:42:48 -0500
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="27102416"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 03:42:46 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 03:42:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYDv8bmVeIcOyx64riWKiG1necLkZPll10wPuBKIIXg=;
 b=iO63x+AhmaCA4k/jQkxJcTL6e2qLi9S7U7DCdei4oNgpzSZyiqmmLnKNOKkzieyRM7EyAjoECql9/QmYDkNKtFx5jpXrqK/tm6BbLX/AHBfqVW98L4GMTH9RWHsGLCogRo57NFMg6qfq1pUFjE1s19wTURQvPlr+T31wZvk9rTw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1556.namprd11.prod.outlook.com (10.172.22.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 10:42:45 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 10:42:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>
CC:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 1/9] spi: atmel-quadspi: optimize qspi init
Thread-Topic: [PATCH 1/9] spi: atmel-quadspi: optimize qspi init
Thread-Index: AQHUuK2oYIgYi2Phc0CCu9Nb5y7hkaXIDV+AgAEkngA=
Date:   Thu, 31 Jan 2019 10:42:45 +0000
Message-ID: <3ae8f1c2-b201-f7ee-5715-e49f39b9cdc1@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-2-tudor.ambarus@microchip.com>
 <20190130181505.4f495d3a@bbrezillon>
In-Reply-To: <20190130181505.4f495d3a@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:802:2::40) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1556;6:l4WUwBNkbLF3l5lrsr27sR2py3qlhKoIuTjHugy28rUlgZj41u7G27MIh7ySkfX+cWlNLyvokHnh5zowmeYm+bV1Bp7prMXoeE7AKazQO0A8IGvteMmqDE7NqQfJdHpzVhTlOAjpnpY9bcLhCcA0D02nxi3YzCYA+o57asQhOzgaBO9MtBogRwjXfjN69urDSrE1i4Mx//ehbQMam7n9tljFhUdgc0RVmtrHvNQztzYdA538nQ+DiWO+PXibrPwHVuYWrQkMpinW9/iGg0O3j+r9M/p7humBXZEgutdJ+EnQpq9CjjDPcJwwO1lEDIhmIl7WPjEzESA4tQ3+dvcov5jrCcQWlEv7a7fFlcrEJas7rIfBlnfo2Xl6hDHXxxY90JbtQvJhXwKTjWFJl2svye3SnNDibnsmvcmShyg1NkPBs9JhgZe11NEBu9uXtALTM7xHqO32H/2ecToi0zPkGA==;5:3xufTaZ7TE17rEAnBm4Ms14ZVkExu4F3q/XFwdMbeRDZgVLLX+o+BF8/lU9JKUoe60CYxcbEb6AaCAkl5vvN+7FE4Ppae51ypI21YGcpKEXyF/OvduJEUYiDNjoUxHKKclkVsXURg9V/3B8+bsR83ZanDkSBDVLZPoUYLIS583wiqTAR7RkRCgxU5P6NB6GoTLIJqbXY87GZjoMkdPsI6Q==;7:5uTs8KxsOYtGf8L+FNs41soYFOPgDGkIsjXYwBUzg+BiNwU1M7cyjj7Xz5SN4GrVPDRpELfdC3wfH+aQK2o24N5BVvpqvqWb7Gy2qH0P602bG5+B2PHmDUIETb1QeZNSb7kV375jPHPbU1sYtEf5Gg==
x-ms-office365-filtering-correlation-id: 6fc078e9-e918-4fee-dc69-08d68768d585
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1556;
x-ms-traffictypediagnostic: BN6PR11MB1556:
x-microsoft-antispam-prvs: <BN6PR11MB15564A9DAA23F7580A14BE8FF0910@BN6PR11MB1556.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(54906003)(86362001)(105586002)(31696002)(6486002)(102836004)(316002)(66066001)(52116002)(229853002)(99286004)(53546011)(72206003)(6436002)(2906002)(14454004)(6116002)(478600001)(3846002)(106356001)(4744005)(4326008)(76176011)(25786009)(53936002)(6246003)(36756003)(386003)(6512007)(6506007)(8936002)(81156014)(7736002)(8676002)(476003)(446003)(305945005)(11346002)(2616005)(14444005)(68736007)(71200400001)(26005)(256004)(31686004)(486006)(71190400001)(6916009)(186003)(97736004)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1556;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E4Yyj/t8qAQ8yX9P2hvGmjey8hHHQhdWSBZct+Hj2hPcTWUmcx/rTh+j9EYPjsC07Y/qxp8GFwDOFk8Dgiv5gB2+iN9w18TkOWjXgdH4QuvXAKuZ3eMSDDXnf7q7UxYkBLo3A3g0RSEohx8tiXDQf2PM7mILWj4MS0VVcrsbonLTjXjTHxjF1r4GTE6MEGL47lp9p9NKNm/VtcJgHNwv8Ph/N7trYUYwa2PW3mILMxOgc/pHS53djaZGH/DY/H5KStbW9cNHTcFUB+9nqB7dVoMj5tCtP5zwMUrx6dM0e2TYM9G+kUIaRBgku86Cb6PA3UI4siQZ8Q+n3iiRQB/IPSyYgcImpMMnryEkHCKCTDFOtEGuU8GAb9vmYPjGz61psB31ExPHfLgiB0DVFZX6IyH/m7SPoI/mbNYQ0PH6sec=
Content-Type: text/plain; charset="utf-8"
Content-ID: <762667507B21874EA0F1817206AD37BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc078e9-e918-4fee-dc69-08d68768d585
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 10:42:39.9761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1556
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAxLzMwLzIwMTkgMDc6MTUgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
V2VkLCAzMCBKYW4gMjAxOSAxNTowODoyOSArMDAwMA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2No
aXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVz
QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gU2V0IHRoZSBRU1BJIGNvbnRyb2xsZXIgaW4gU2VyaWFs
IE1lbW9yeSBNb2RlIGF0IGluaXQgYW5kIG5vdA0KPj4gYXQgZWFjaCBleGVjX29wKCkgY2FsbC4N
Cj4gDQo+IElmIHlvdSBldmVyIHdhbnQgdG8gc3VwcG9ydCByZWd1bGFyIFNQSSB5b3UnbGwgaGF2
ZSB0byBwdXQgaXQgYmFjayB0bw0KPiBhdG1lbF9xc3BpX2V4ZWNfb3AoKSwgc28gSSdtIG5vdCBz
dXJlIHRoaXMgaXMgYSBnb29kIG1vdmUuIEFub3RoZXINCj4gYXBwcm9hY2ggd291bGQgYmUgdG8g
Y2FjaGUgdGhlIE1SIHZhbHVlIHRvIGF2b2lkIGRvaW5nIGEgd3JpdGUgYWNjZXNzDQo+IG9uIHRo
ZSBidXMgd2hlbiB0aGUgdmFsdWUgaGFzbid0IGNoYW5nZWQuDQoNCkknbGwgY2FjaGUgTVIgdmFs
dWUsIHRoYW5rcyENCg0KdGENCg==
