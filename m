Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E33C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6259A20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HgX/0/sZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DRNY/8QQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6259A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeK0RJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:09:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51108 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727222AbeK0RJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:09:06 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id wAR66dqY030186;
        Mon, 26 Nov 2018 22:11:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dBfbOiocsZk6hHBIjtwsQdniVOfCgvELIGzdZXVpg+I=;
 b=HgX/0/sZUh8R9gAWyQbV5MYVwxGQSvC7lpRecuGjzRUjO/bEdg0JZ2xliJlyu54HLnaf
 JF+IKRw531tKeCd5Snt4rLkUVQTRfVy9NT15zgb7UP6Qm5++eXY8qQwzXSDKs7Ezyds7
 fisX5t+FBo+wsGzxXheBHi73ulhijO16Imo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2p0uab8r8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Nov 2018 22:11:49 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 26 Nov 2018 22:11:47 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 26 Nov 2018 22:11:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBfbOiocsZk6hHBIjtwsQdniVOfCgvELIGzdZXVpg+I=;
 b=DRNY/8QQzS4TD5azy3CKlhhzOdP68MUVw7wXcvWBLQuxGfJr8Rl5lN447eq8BJeccW+PecdLEcr/90lzO1cNTgxhj+pR+39jSIwdAkldllDIL/Cw+zYiQOP5N/6mvqKceR6cPFv/oqH+XsJw/OweKPh4xBbR0OB/CHMTmf0HMgw=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1696.namprd15.prod.outlook.com (10.175.142.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 06:11:46 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6%2]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 06:11:46 +0000
From:   Tao Ren <taoren@fb.com>
To:     "Jerry.Hoemann@hpe.com" <jerry.hoemann@hpe.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] watchdog: core: suppress "watchdog did not stop" message
Thread-Topic: [PATCH] watchdog: core: suppress "watchdog did not stop" message
Thread-Index: AQHUfT0kb1jOq4Gqx0OLsq0sLX4HDKVRiaQAgAAE+QCAEVixgP//yECA
Date:   Tue, 27 Nov 2018 06:11:46 +0000
Message-ID: <12D0F3A5-602E-4C4B-908D-55C3C50823BB@fb.com>
References: <20181115234413.27009-1-taoren@fb.com>
 <20181116001938.GA16009@roeck-us.net>
 <9a43bb84-f476-d6c8-886a-2120312ee8e7@fb.com>
 <20181127013117.GB11080@anatevka>
In-Reply-To: <20181127013117.GB11080@anatevka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.0.180812
x-originating-ip: [2620:10d:c090:180::1:9054]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1696;20:q0sL04AtcmbQB0kmvx9NhbEKu2BWgj/FKdC6eYNTFAy/2Z9xqZZyhPVl40+58Ns0L6x9+FtCHzl4QEoNINqexg3DjGYINyUMxc3pTk+L1b7zk3dw/wzosWnVgm9PF87yJ95OcfvRHOIteAyHaORldoYO1voNA37lru5RPiz1+SU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3b615750-f7e2-4b6f-caa3-08d6542f35eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1696;
x-ms-traffictypediagnostic: MWHPR15MB1696:
x-microsoft-antispam-prvs: <MWHPR15MB1696DD08C2F0B1B5DB6F7CEFB2D00@MWHPR15MB1696.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231443)(11241501185)(944501410)(52105112)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201703031522075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1696;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1696;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(39860400002)(366004)(199004)(189003)(6512007)(6486002)(46003)(53546011)(229853002)(71190400001)(71200400001)(76176011)(186003)(6246003)(6506007)(83716004)(6916009)(102836004)(4326008)(99286004)(53936002)(6436002)(105586002)(2351001)(106356001)(256004)(2616005)(446003)(11346002)(486006)(82746002)(476003)(68736007)(93886005)(15650500001)(7736002)(14454004)(58126008)(296002)(54906003)(478600001)(2906002)(316002)(25786009)(86362001)(33656002)(8676002)(6116002)(81166006)(8936002)(81156014)(97736004)(2501003)(36756003)(5660300001)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1696;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2d/hmFZgeDoFae6RAlzLoU02NkTYRgjgYwUGqM1GO8Pl+yhnjGZldtvVfpBxjYOazrctsU0GVMZbaXr8+Z5d0SAfp4sBl6cqjcc0HrltKrcTpL2VA44nSO9hNk+hbsrk8TXXkstdur1vj2ItddwfhCUh8xPoqT3HW8MC/aCp1Br+5NMApUJYe2WqUx++FmKOD61TGO0xo3GcbE1r11fXvzXBCyojNKAI9vVdw0GMpywoqUX7Lm+lN7hPVzc7zg8P2rpb//pJfcZvlKYfmpsMfh/Dh5eC2DraB4mXltoHSSU5z1Q5z382wRAubixEaJbPSVBdZNNQtQbsIMk+L5l/IK6qq4FC3wZY/7zYlPSu1bI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <99C19D0526E0BD44B3DB6E607CF70289@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b615750-f7e2-4b6f-caa3-08d6542f35eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 06:11:46.2783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1696
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjYvMTgsIDU6MzEgUE0sICJKZXJyeSBIb2VtYW5uIiA8amVycnkuaG9lbWFubkBocGUu
Y29tPiB3cm90ZToNCj4gVGFvLA0KPiANCj4gSWYgeW91J3JlIG9uIGEgc3lzdGVtIHJ1bm5pbmcg
c3lzdGVtZCwgdGhlIGRlZmF1bHQgYmVoYXZpb3IgaXMgdG8NCj4gZW5hYmxlIHRoZSB3YXRjaGRv
ZyBkdXJpbmcgc2h1dGRvd24uICBUaGlzIGd1YXJkcyBhZ2FpbnN0IHNodXRkb3duIGhhbmdpbmcu
DQo+IFNvIHRoaXMgbWVzc2FnZSB3aWxsIGJlIHJvdXRpbmVseSBwcmludGVkIG91dCBkdXJpbmcg
b3JkZXJseSBzaHV0ZG93bi4NCg0KVGhhbmsgeW91IEplcnJ5IGZvciB0aGUgY29tbWVudHMuDQoN
CkkgYWN0dWFsbHkgdXNlIGEgc2VwYXJhdGUgZGFlbW9uIHByb2Nlc3MgdG8ga2ljayB0aGUgd2F0
Y2hkb2cgb24gbXkgQk1DIHN5c3RlbS4gVGhlIGRhZW1vbiBtb25pdG9ycyB0ZW1wZXJhdHVyZSBz
ZW5zb3JzIGFuZCBvdGhlciBzeXN0ZW0gc3RhdGVzIGFuZCBraWNrcyB3YXRjaGRvZyBwZXJpb2Rp
Y2FsbHk6IGlmIHRoZSBkYWVtb24gZ2V0cyBzdHVjayBvciBleGl0cywgdGhlbiB0aGUgbWFjaGlu
ZSBuZWVkcyB0byByZWJvb3QgZXZlbiBpZiBrZXJuZWwvc3lzdGVtZCBpcyBmaW5lLiBQZXJoYXBz
IEkgbmVlZCB0byBsb29rIGZvciBhIGJldHRlci9vZmZpY2lhbCB3YXkgdG8gbWFuYWdlIHRoZSB3
YXRjaGRvZyBkZXZpY2UuLg0KDQpCVFcsIEkgd2lsbCBiZSB0cmF2ZWxsaW5nIGFicm9hZCBpbiB0
aGUgbmV3IGZldyBkYXlzIGFuZCBtYXkgbm90IGJlIGFibGUgdG8gcmVwbHkgZW1haWxzIHRpbWVs
eS4gVGhhbmsgeW91IGFnYWluIGZvciBqdW1waW5nIGluLg0KDQpCZXN0IHJlZ2FyZHMsDQpUYW8g
UmVuDQogICAgDQoNCg==
