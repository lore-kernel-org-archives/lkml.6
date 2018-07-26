Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B61DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D5D20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FlDFC8SL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D5D20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeGZGgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:36:04 -0400
Received: from mail-eopbgr720079.outbound.protection.outlook.com ([40.107.72.79]:19642
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728737AbeGZGgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pltfCWx1n8xJhlOpPCOgXZS2QDjt96weKQOEM+WrxjY=;
 b=FlDFC8SLKS3txZBpJMXNAB3bsBgexZwW7hseRO8mMW5swkfIJviTauHvkD70FVMJC/yeO2HPHkWb21Jcp7sA/dEXYbimG8aOZisrJPfg6CBLQLA3v+mOtwsjcPWoHnhC6h63C5wAftMSwM0WMOsTnSwm3Y6b+6xilHFBzP+JRrM=
Received: from CY1PR02MB1692.namprd02.prod.outlook.com (10.162.161.26) by
 CY1PR02MB1320.namprd02.prod.outlook.com (10.161.170.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Thu, 26 Jul 2018 05:20:50 +0000
Received: from CY1PR02MB1692.namprd02.prod.outlook.com
 ([fe80::9dbd:bd61:c2d3:4b95]) by CY1PR02MB1692.namprd02.prod.outlook.com
 ([fe80::9dbd:bd61:c2d3:4b95%3]) with mapi id 15.20.0973.022; Thu, 26 Jul 2018
 05:20:45 +0000
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
Thread-Index: AQHUI1kdQYf467r9ZE6tdqpx/KPVD6SekS4AgAAgjBCAAAWOAIAA19PQgACEU4CAAOSMUA==
Date:   Thu, 26 Jul 2018 05:20:45 +0000
Message-ID: <CY1PR02MB16924F2F3373AD7EB059A088DC2B0@CY1PR02MB1692.namprd02.prod.outlook.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
 <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
 <CAAtXAHeVXw4BT7XF+Mu=nR9U9nK=nR_+x+JKSQU1owwPbt_HPA@mail.gmail.com>
 <CY1PR02MB169273A09D4E675A7671375CDC550@CY1PR02MB1692.namprd02.prod.outlook.com>
 <CANk1AXRYX+7hkm93r0maHz1e1Uh-gTKzs==1xjd_CZPQqBLSyA@mail.gmail.com>
 <CY1PR02MB1692876485F0557FE798C2D9DC540@CY1PR02MB1692.namprd02.prod.outlook.com>
 <CANk1AXTvVQz5PpX_HqWQ2SKJePizbk6JmHyp3mOAZ0DZA=en5Q@mail.gmail.com>
In-Reply-To: <CANk1AXTvVQz5PpX_HqWQ2SKJePizbk6JmHyp3mOAZ0DZA=en5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1320;6:Cj2x6QmkwfhRd6jUoEmDed9OBV8YwCVSZTIzOmnYXDh4MCSiRJSrkKzUVuvmnq9bJx6hRYsZ/qFi2gF4Oesf2vnAtSzwG95DIJ99QrR09yD4xiLetHViDvcnhvXeONDKcVkydzh3Nm8sUCVLQrJoP3WWX6yGwxqDH0tf/pincJY7disj69UFUbxdKmuYANSS9IhSpK7Wtm9vUMgRYmuXLTYNWpPZ1mBp0h91myuWZgVaZIACabig0LxNNqV03Tnvl02K3NgiD//qTLLjs/vCCyigCRpGwRJNVhSKQ5/z1bTnVa0aqOVtzJAnof4QFvkVxuoC+rUD1avWrbVhEYvzwKuGPFXYqQng/wy3jfqp3FlrqevWTL4WHDXHVgvhxUDfVc2fyRA9yE6iGObNp6pEGyOdujW+Ms7VYS6UX6FBqHl6JM1KgLVKPSFi3tPs7IVxGUx2+zz+DXXsFe5AUUfhJA==;5:6lic2aJcjhinmJ4ENZWkIp6gBveyuKIpP6edwLXCFKKgKDcKO+eFiI5+NlshcL+OfKSifijDswEtiH2ohNY2SD9UzCWKCOgkkA0/lgb7jUZIoIVGMOZ+PZRg0DEp0MIHjBycuLhqMetcUFd5wWpihuFGl6lDnQtQ6aWe1UQDnT0=;7:fhClXA6h6gSNUEXS7fjIMCdyqXJ4V9YK2J4FCvgYhEx2RaZW6PKqxjbe15xWp8GIevMEvjsMUdQwpRyDhhSO2uVVfOxkcPmnQrD49PQa4URbgVPrmMDeU/CzixnYxmEJDpmx8wxgMLQYdXZ39IRkpekAWwTcnALyAojGPqgG9y6/qbAoapXGAWm34uGJwLRAV0sJoWTKicfHxEGCbyahnFYV4k+8mp5M+NUDMtoTGFH0tKfyuilQGK2IqVuyzzl+
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: c476115b-978e-460c-0036-08d5f2b78a3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1320;
x-ms-traffictypediagnostic: CY1PR02MB1320:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <CY1PR02MB132026EA82A362426EB86AC6DC2B0@CY1PR02MB1320.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1320;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1320;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(51914003)(54906003)(6506007)(6246003)(186003)(305945005)(9686003)(55016002)(486006)(476003)(7736002)(6916009)(446003)(93886005)(5660300001)(33656002)(66066001)(102836004)(11346002)(6436002)(229853002)(561944003)(53936002)(68736007)(256004)(76176011)(97736004)(14454004)(74316002)(86362001)(8936002)(4326008)(5250100002)(106356001)(2906002)(3846002)(8676002)(105586002)(6116002)(81156014)(316002)(478600001)(99286004)(26005)(25786009)(81166006)(7696005)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1320;H:CY1PR02MB1692.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Jdde0L/hd8YwTqB6JYly4eVcrIm2KU+9NdpPAKzgMBhUpMP7kFnzIq8du2rr71B5C0EeFF9slxxmOgBEd69tSMDOZoSZ9Hj6jJ56zbuLcwjeIlZDPthfh47pPFBxQYRWdG+kgm0X/PDXsP9wsSOvAk3jgCqqISFAZZxCKEDR3HYGd7NvfikO9/2XPzBrrSNbJBiGW6RkNQvt0BNwBXtVt/beQrpyHnPgdD2WxaluA77n+Y+0hTYZNZ9cY6lqjVMyZuQO+XhWgfnLeXLJvaN7iSyeSuveaUJ1TC7PZf9j6PueS1ZBgZfeG+Cveq/tGL95T0FCifREcoiCVlj5KVZGaMNdY8VtktD+rHrlJiEBjXQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c476115b-978e-460c-0036-08d5f2b78a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 05:20:45.3224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhbiwNCg0KCVRoYW5rcyBmb3IgdGhlIHJldmlldy4uLg0KDQo8U25pcD4NCj4gPiBJbiBa
eW5xIENhc2UgaXQgc3VwcG9ydHMgdHdvIHR5cGVzIG9mIHRoZSByZWFkYmFjayAoQ29uZmlndXJh
dGlvbiByZWdpc3RlcnMsDQo+IENvbmZpZ3VyYXRpb24gZGF0YShmcGdhIGltYWdlKSkgIHdoaWNo
IG1heSBub3QgYmUgdGhlIHNhbWUgY2FzZSBmb3Igb3RoZXINCj4gdmVuZG9ycy4NCj4gPiBTaW5j
ZSBJIG5lZWQgdG8gc3VwcG9ydCBib3RoIHRoZSB1c2UgY2FzZXMgSSBoYXZlIGRpZmZlcmVudGlh
dGVkIHRoZW0gdXNpbmcNCj4gbW9kdWxlIHBhcmFtIGluIHRoZSB6eW5xLWZwZ2EgZHJpdmVyLg0K
PiA+DQo+ID4gQXMgeW91IHNhaWQgd2Ugc2hvdWxkbid0IGNoYW5nZSB0aGUgYXR0cmlidXRlJ3Mg
ZnVuY3Rpb24sIFNvIGluIHRoZQ0KPiA+IHp5bnEtZnBnYSBkcml2ZXIsIEkgYW0gcGxhbm5pbmcg
dG8gYWRkIGFub3RoZXIgZGVidWdmcyBhdHRyaWJ1dGUgZm9yDQo+IHJlYWRpbmcgYmFjayBvZiBj
b25maWd1cmF0aW9uIHJlZ2lzdGVycyBhcyBpdCBpcyB2ZW5kb3Igc3BlY2lmaWMgcmVhZGJhY2sg
dHlwZS4NCj4gPiAgKENvbmZpZ3VyYXRpb24gcmVnaXN0ZXJzICAgICAgICAgICAgICAgICAgIC0t
LS0gIFVzYWdlOg0KPiAvc3lzL2tlcm5lbC9kZWJ1Zy9mcGdhL3p5bnEtZnBnYS9jZmdyZWdfc3Vt
bWFyeSkNCj4gDQo+IElzIGl0IGNhbGxlZCAnLi4uc3VtbWFyeScgYmVjYXVzZSBpdCBpcyBub3Qg
YWxsIHRoZSByZWdpc3RlcnM/ICBDb3VsZCBqdXN0IGJlDQo+ICJjZmdfcmVncyI/DQoNClN1cmUg
d2lsbCBtYWtlIGl0IGNmZ19yZWdzLi4uDQpBcmUgeW91IG9rIHdpdGggdGhlIGFib3ZlIHByb3Bv
c2FsPz8gDQppZiB5b3UgYXJlIG9rIHdpbGwgbWFrZSBjaGFuZ2VzIGFjY29yZGluZ2x5IGFuZCB3
aWxsIHBvc3QgdjQuLi4NCg0KPiANCj4gPiAoQ29uZmlndXJhdGlvbiBkYXRhKGZwZ2EgaW1hZ2Up
ICAgIC0tLS0gICBVc2FnZToNCj4gL3N5cy9rZXJuZWwvZGVidWcvZnBnYS9mcGdhMC9pbWFnZSkN
Cj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cyBmb3IgdGhlIHNhbWUuLi4NCj4g
Pg0KPiA+Pg0KPiA+PiA+IE9uZSBvdGhlciBvcHRpb24gaXMgc3lzZnMuIERvIHlvdSB3YW50IG1l
IHRvIGltcGxlbWVudCBzeXNmcyBwYXRoPz8/DQo+ID4+ID4gQW55IG90aGVyIHN1Z2dlc3Rpb25z
Pz8/DQo+ID4+DQo+ID4+IFlvdSBjb3VsZCBpbXBsZW1lbnQgYW5vdGhlciBzeXNmcyBhdHRyaWJ1
dGUgZm9yIHJlYWRpbmcgRlBHQSByZWdpc3RlcnMNCj4gPj4gd2l0aCBhIHNlcGFyYXRlIG9wcyBj
YWxsYmFjay4gICBQbGVhc2UgY2xhcmlmeSB3aGF0IGl0IGlzIGRvaW5nIChub3QNCj4gPj4gYWxs
IEZQR0FzIGhhdmUgdGhpcyBmdW5jdGlvbikgYW5kIHdoYXQgdGhhdCB3aWxsIGxvb2sgbGlrZSB3
aGVuIHRoZQ0KPiA+PiB1c2VyIHJlYWRzIHRoZSBmcm9tIHRoZSBzeXNmcw0KPiA+DQo+ID4gQUZB
SUsgd2Ugc2hvdWxkbid0IGFkZCBhbm90aGVyIHN5c2ZzL2RlYnVnZnMgYXR0cmlidXRlIGZvciB2
ZW5kb3Itc3BlY2lmaWMNCj4gcmVhZGJhY2sgdHlwZSBpbiB0aGUgRlBHQSBtYW5hZ2VyIG9wcy4N
Cj4gPiBQbGVhc2UgY29ycmVjdCBtZSBpZiBteSB1bmRlcnN0YW5kaW5nIGlzIHdyb25nLg0KPiAN
Cj4gWW91IGFyZSBub3Qgd3JvbmcgOikNCg0KVGhhbmtzIPCfmIogDQoNClJlZ2FyZHMsDQpLZWRh
ci4NCg0KPiANCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gS2VkYXIuDQo+ID4NCj4gPj4NCj4gPj4g
QWxhbg0K
