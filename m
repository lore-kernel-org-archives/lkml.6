Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B466C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0002064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="T/M2jrvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0002064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeGYKXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:23:16 -0400
Received: from mail-sn1nam01on0082.outbound.protection.outlook.com ([104.47.32.82]:28876
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728673AbeGYKXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djk4bB5TykTm0G98JBTS8Kpa9wFV01DBEk8wtsZkdIg=;
 b=T/M2jrvL+kIEFuYrtG7lJEI2dR9p6QfGiGZy5JUt3saX0ubYpTQjXHIeqXZQjFZuboTsDQY9hXDrnlEz7D+8mycWsmBZvQswkCzbbSOEUKBdx0pSLGKmGmu8+SispCGF8PtzuulDr+V0HVkmtfo+MAZ86d21hUbWhPX49EGC0kk=
Received: from CY1PR02MB1692.namprd02.prod.outlook.com (10.162.161.26) by
 CY1PR02MB1120.namprd02.prod.outlook.com (10.163.15.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 25 Jul 2018 09:12:21 +0000
Received: from CY1PR02MB1692.namprd02.prod.outlook.com
 ([fe80::9dbd:bd61:c2d3:4b95]) by CY1PR02MB1692.namprd02.prod.outlook.com
 ([fe80::9dbd:bd61:c2d3:4b95%3]) with mapi id 15.20.0973.022; Wed, 25 Jul 2018
 09:12:21 +0000
From:   Appana Durga Kedareswara Rao <appanad@xilinx.com>
To:     Alan Tull <atull@kernel.org>
CC:     Moritz Fischer <moritz.fischer@ettus.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
Thread-Topic: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
Thread-Index: AQHUI1kdQYf467r9ZE6tdqpx/KPVD6SekS4AgAAgjBCAAAWOAIAA19PQ
Date:   Wed, 25 Jul 2018 09:12:21 +0000
Message-ID: <CY1PR02MB1692876485F0557FE798C2D9DC540@CY1PR02MB1692.namprd02.prod.outlook.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
 <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
 <CAAtXAHeVXw4BT7XF+Mu=nR9U9nK=nR_+x+JKSQU1owwPbt_HPA@mail.gmail.com>
 <CY1PR02MB169273A09D4E675A7671375CDC550@CY1PR02MB1692.namprd02.prod.outlook.com>
 <CANk1AXRYX+7hkm93r0maHz1e1Uh-gTKzs==1xjd_CZPQqBLSyA@mail.gmail.com>
In-Reply-To: <CANk1AXRYX+7hkm93r0maHz1e1Uh-gTKzs==1xjd_CZPQqBLSyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1120;6:+MM/T2n07LUKStJ0VfCS1lJiXDeDZ88iGvZyWSQt7huEdQTt9T0Rlxu/YBAiPAayDbzBJKfKZDhEZu7Ol0LEcdqHx+uZkX+9kMAnjsx0Nr93oiNXLJ26iidAcC/NE4RxwNWVd7ORI5g7lTZz+r7gAcCPoPIhMMCn5GY/6K+iUe+tTFydGL0DeVGiPmoJhp1eQfLVUIu5EcWJlFVj9eacxkKdBZuERWR2yxyenKQhN56Ob7ek+5DShfL7rAk/M1HK/xx+94auuYbF1tth06z25f54cD9edvuCdDI46FwlR4VLNgTCgsXycXzbtaz1QzbA85lRh6saKajPNqRvChRVhfmtrxB/153pg7hYW23vixxtgJGkxdCaM8zfAz2W22rg0M0td68Vpb9zwQ9Ls/u3VbE+q6s8cSIRcGY46eMRiXk0agXqQRGtIuBQk68Pc5wSqCL4eqPYKjpIJokDBQXhlw==;5:kpsFDkRhPqJ3sykKA9O6vkq9IGGOeUK8yd+ORwe6JWDM7/bkxZXJhKDCczjZTtfjDsbhNxMcaiqpVC0nJKLn0mb6HgK+GXQJLpcHLKlh0somu087EhoJ3KwWES+4hZoaw4YqOAQete51Z1aqAT9//mrOI1OQHvKwIq4/pG5CNS8=;7:q1lDeuuqalPNRXEApHET+7R82dtDm/GGix8G36EP3qqLg0xH3DDNWp49CmMCkivAk6pQPi/CNtY1utwXjU1qwhKvZbmAMl7t64GoRqLoHmU2oSC+DzCS5mHY/xk1q9ADBIPqGLebA2UCRD4cJwjNaRB8cvkyX7mjs86R3Iy6WfkJ5wW3ZlqAZ+TmX7UpoKh0hczeXVOTtETDsSVRkS0wsu0eqwmiMA1b9KMmhYb3yTVkyBu9wY3CyBRQNeC3Eizo
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 352e96d3-a8ea-4492-02d7-08d5f20eba7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1120;
x-ms-traffictypediagnostic: CY1PR02MB1120:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <CY1PR02MB1120EBEB5F86E41523681D55DC540@CY1PR02MB1120.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1120;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1120;
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(51914003)(189003)(99286004)(4326008)(93886005)(11346002)(5660300001)(14454004)(53936002)(6246003)(97736004)(25786009)(55236004)(186003)(256004)(6506007)(106356001)(26005)(7696005)(446003)(68736007)(486006)(478600001)(76176011)(102836004)(33656002)(6436002)(55016002)(8936002)(9686003)(86362001)(81156014)(8676002)(66066001)(316002)(229853002)(6916009)(74316002)(2906002)(5250100002)(6116002)(2900100001)(81166006)(3846002)(7736002)(305945005)(476003)(54906003)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1120;H:CY1PR02MB1692.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IuC6suSKQupkqjkAn2GPAOGFzmnBhBoZGjBAIpfBtjE0tS5o+3BZ2L6+MjSAmK07X+iCOD5BaudE9IA9ACJRgmh/61EgBSRy53bQCRV8ZZUoMg2fRhUQNS0a0n8AKN53buxAxonEbJfvENDr1QXY+eidomYQdSQHAopc2qBUHJDPFxJflMXvuOOMOi3bUL7WMYFvVhAKgJ3LZoljHtZKWdTYu7GwZv44Kcth83Z/OrU42NWUbR+HP6Kk4OMptuOkD1bK1NIITrEG1wJLvskvhzeQp8A0Yyg3NzFfIeHuOP5OywflZlJQGeGKiiIBBsEIWFFUNpIgGhpS99/8ubhKgge4s6Swu4ZP/hQLP2A+7tg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352e96d3-a8ea-4492-02d7-08d5f20eba7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 09:12:21.4361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhbiwNCgkNCglUaGFua3MgZm9yIHRoZSByZXZpZXcuLi4NCg0KPFNuaXA+IA0KPiA+DQo+
ID4gPFNuaXA+DQo+ID4+ID4gK3N0YXRpYyBib29sIHJlYWRiYWNrX3R5cGU7DQo+ID4+ID4gK21v
ZHVsZV9wYXJhbShyZWFkYmFja190eXBlLCBib29sLCAwNjQ0KTsNCj4gPj4gPiArTU9EVUxFX1BB
Uk1fREVTQyhyZWFkYmFja190eXBlLA0KPiA+PiA+ICsgICAgICAgICAgICAgICAicmVhZGJhY2tf
dHlwZSAwLWNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgcmVhZCAiDQo+ID4+ID4gKyAgICAgICAgICAg
ICAgICIxLSBjb25maWd1cmF0aW9uIGRhdGEgcmVhZCAoZGVmYXVsdDogMCkiKTsNCj4gPj4NCj4g
Pj4gTm90IHN1cmUgYSBtb2R1bGUgcGFyYW0gaXMgdGhlIGJlc3Qgc29sdXRpb24gaGVyZS4NCj4g
Pg0KPiA+IE5lZWQgdG8gcHJvdmlkZSBmbGV4aWJpbGl0eSB0byB0aGUgdXNlciB0byBzd2l0Y2gg
YmV0d2VlbiByZWFkaW5nIG9mIEZQR0ENCj4gcmVnaXN0ZXJzIGFuZCBjb25maWd1cmF0aW9uIGRh
dGEuDQo+IA0KPiBJIHN1Z2dlc3RlZCBjYWxsaW5nIHRoZSBhdHRyaWJ1dGUgJ2ltYWdlJyBiZWNh
dXNlIEkgdGhvdWdodCBpdCB3b3VsZCBhbHdheXMgYmUNCj4gYSByZWFkIGJhY2sgb2YgdGhlIEZQ
R0EgaW1hZ2UgaW5mb3JtYXRpb24uICBJIGRvbid0IHRoaW5rIHRoYXQgYSBzeXNmcw0KPiBhdHRy
aWJ1dGUncyBmdW5jdGlvbiBzaG91bGQgY2hhbmdlLiA6KQ0KDQpJbiBaeW5xIENhc2UgaXQgc3Vw
cG9ydHMgdHdvIHR5cGVzIG9mIHRoZSByZWFkYmFjayAoQ29uZmlndXJhdGlvbiByZWdpc3RlcnMs
IENvbmZpZ3VyYXRpb24gZGF0YShmcGdhIGltYWdlKSkgIHdoaWNoIG1heSBub3QgYmUgdGhlIHNh
bWUgY2FzZSBmb3Igb3RoZXIgdmVuZG9ycy4gDQpTaW5jZSBJIG5lZWQgdG8gc3VwcG9ydCBib3Ro
IHRoZSB1c2UgY2FzZXMgSSBoYXZlIGRpZmZlcmVudGlhdGVkIHRoZW0gdXNpbmcgbW9kdWxlIHBh
cmFtIGluIHRoZSB6eW5xLWZwZ2EgZHJpdmVyLg0KDQpBcyB5b3Ugc2FpZCB3ZSBzaG91bGRuJ3Qg
Y2hhbmdlIHRoZSBhdHRyaWJ1dGUncyBmdW5jdGlvbiwgU28gaW4gdGhlIHp5bnEtZnBnYSBkcml2
ZXIsDQpJIGFtIHBsYW5uaW5nIHRvIGFkZCBhbm90aGVyIGRlYnVnZnMgYXR0cmlidXRlIGZvciBy
ZWFkaW5nIGJhY2sgb2YgY29uZmlndXJhdGlvbiByZWdpc3RlcnMgYXMgaXQgaXMgdmVuZG9yIHNw
ZWNpZmljIHJlYWRiYWNrIHR5cGUuDQogKENvbmZpZ3VyYXRpb24gcmVnaXN0ZXJzICAgICAgICAg
ICAgICAgICAgIC0tLS0gIFVzYWdlOiAgL3N5cy9rZXJuZWwvZGVidWcvZnBnYS96eW5xLWZwZ2Ev
Y2ZncmVnX3N1bW1hcnkpIA0KKENvbmZpZ3VyYXRpb24gZGF0YShmcGdhIGltYWdlKSAgICAtLS0t
ICAgVXNhZ2U6IC9zeXMva2VybmVsL2RlYnVnL2ZwZ2EvZnBnYTAvaW1hZ2UpDQpQbGVhc2UgbGV0
IG1lIGtub3cgeW91ciB0aG91Z2h0cyBmb3IgdGhlIHNhbWUuLi4gDQoJDQo+IA0KPiA+IE9uZSBv
dGhlciBvcHRpb24gaXMgc3lzZnMuIERvIHlvdSB3YW50IG1lIHRvIGltcGxlbWVudCBzeXNmcyBw
YXRoPz8/DQo+ID4gQW55IG90aGVyIHN1Z2dlc3Rpb25zPz8/DQo+IA0KPiBZb3UgY291bGQgaW1w
bGVtZW50IGFub3RoZXIgc3lzZnMgYXR0cmlidXRlIGZvciByZWFkaW5nIEZQR0EgcmVnaXN0ZXJz
DQo+IHdpdGggYSBzZXBhcmF0ZSBvcHMgY2FsbGJhY2suICAgUGxlYXNlIGNsYXJpZnkgd2hhdCBp
dCBpcyBkb2luZyAobm90DQo+IGFsbCBGUEdBcyBoYXZlIHRoaXMgZnVuY3Rpb24pIGFuZCB3aGF0
IHRoYXQgd2lsbCBsb29rIGxpa2Ugd2hlbiB0aGUgdXNlciByZWFkcw0KPiB0aGUgZnJvbSB0aGUg
c3lzZnMNCg0KQUZBSUsgd2Ugc2hvdWxkbid0IGFkZCBhbm90aGVyIHN5c2ZzL2RlYnVnZnMgYXR0
cmlidXRlIGZvciB2ZW5kb3Itc3BlY2lmaWMgcmVhZGJhY2sgdHlwZSBpbiB0aGUgRlBHQSBtYW5h
Z2VyIG9wcy4NClBsZWFzZSBjb3JyZWN0IG1lIGlmIG15IHVuZGVyc3RhbmRpbmcgaXMgd3Jvbmcu
IA0KDQpSZWdhcmRzLA0KS2VkYXIuDQoNCj4gDQo+IEFsYW4NCg==
