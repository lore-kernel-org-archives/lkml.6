Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A1BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD0E206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bTQZrlxd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="i5d+D+ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD0E206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbeKPKsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:48:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40846 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726271AbeKPKsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:48:25 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id wAG0bjhZ022246;
        Thu, 15 Nov 2018 16:37:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=1yZF5uo8o0daWoNlXSFBWmvmzWPEaU/eFhRMQY9m3BY=;
 b=bTQZrlxdWe+AiFrNmXR/Az/a5C3bSvLSCJ7QnBXIcCDQpE9OEwfod7Tq185FXPxSnCcC
 t5ujX+Ng2bHCyVWyKCgAsjxb2mLQhhV2L9mYg8HEDijdfoeWoye5EK5Xw44hQdc5MMJ2
 BvapbNQnFnlmjcaecRkdSpk+dPZ+AhsDLSU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2nshhc0bbg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 15 Nov 2018 16:37:47 -0800
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 15 Nov 2018 16:37:30 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 15 Nov 2018 16:37:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yZF5uo8o0daWoNlXSFBWmvmzWPEaU/eFhRMQY9m3BY=;
 b=i5d+D+ftbkTmYC5IWyayNVpxi73yhlEqroN5v76LVO+9X6M5KSdeHCuLHBvW1uKBzd1oYbPiV4rVVdiznO+40wIbfwV47VUU43kFMh8r6X/e13OoAzrOdDnZViFx94UleeEfNxzByucWfYri3tR9Gon0U6g9EFKW9bdVd3lwoQI=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1424.namprd15.prod.outlook.com (10.173.234.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Fri, 16 Nov 2018 00:37:28 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6%2]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 00:37:28 +0000
From:   Tao Ren <taoren@fb.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] watchdog: core: suppress "watchdog did not stop" message
Thread-Topic: [PATCH] watchdog: core: suppress "watchdog did not stop" message
Thread-Index: AQHUfT0kb1jOq4Gqx0OLsq0sLX4HDKVRiaQAgAAE+QA=
Date:   Fri, 16 Nov 2018 00:37:28 +0000
Message-ID: <9a43bb84-f476-d6c8-886a-2120312ee8e7@fb.com>
References: <20181115234413.27009-1-taoren@fb.com>
 <20181116001938.GA16009@roeck-us.net>
In-Reply-To: <20181116001938.GA16009@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0025.namprd14.prod.outlook.com
 (2603:10b6:300:12b::11) To MWHPR15MB1216.namprd15.prod.outlook.com
 (2603:10b6:320:23::18)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:cb25]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1424;20:3LeHyUjIRjPmfn5JBIfzX8tdftM8QUpwqfBVP1vVGK3NYF1VPPsYf8sUqx3XoGCC7SU8CMyZ4KOCCZpN/DJGWcsIKF3aGks4RTLEo++rPt2YwjDd3ePhJ66AsHGuMqZ75Ko8IxIeNGZnFeznNmYPAJRRCtgWIYYTPCnZ/aeoTj8=
x-ms-office365-filtering-correlation-id: 41cd2986-dabb-43be-f93a-08d64b5baf9d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1424;
x-ms-traffictypediagnostic: MWHPR15MB1424:
x-microsoft-antispam-prvs: <MWHPR15MB14240499897FA9A2B1625DC0B2DD0@MWHPR15MB1424.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231415)(11241501184)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1424;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1424;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(6246003)(6436002)(71190400001)(345774005)(31686004)(15650500001)(6486002)(68736007)(6512007)(81156014)(2616005)(81166006)(8936002)(186003)(11346002)(486006)(7736002)(31696002)(446003)(305945005)(86362001)(46003)(8676002)(53936002)(476003)(2900100001)(65956001)(64126003)(65806001)(71200400001)(97736004)(106356001)(2906002)(105586002)(36756003)(6116002)(25786009)(102836004)(54906003)(76176011)(58126008)(53546011)(256004)(5660300001)(386003)(229853002)(6916009)(316002)(6506007)(4326008)(14454004)(99286004)(52116002)(65826007)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1424;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EoMeeNxLs+52OflO0VAKVq4p8360jIENuH0RF8hahxuoYWI9COQDCtFicpl6ufUUkBJ3a2S0vHmG7SvDfiWngZ1frgFEOTB8UX9vdeuQIx1KctNTa0XnhuK+NEX0PGwpQYqHQGyvHHc/tc2mjTPOlV90wMUczYJcUnl0zlipxRBQ/erNl6zMEC4ZZ01LlwxTK8BF47H9oEUoA/0hwQ7unGEhcMrj241W/crd6laadWNH8HvFX9nsIkL98zXeJq/KHIXEcX8DoXONRbZlg0xYM6zvqXwRxgiOB7xbgpauQOGo1Y2eUX6eYMNLiaQ7FZiiJXY3dUdv22kpLxp7E2/MIo98bIjYaXTPX9UqFWJ2s0U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <08A31BE9AC472D4B80052C833341EE5F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cd2986-dabb-43be-f93a-08d64b5baf9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 00:37:28.5445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1424
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTUvMTggNDoxOSBQTSwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4gTkFDSy4gVGhpcyBt
ZXNzYWdlIGlzIGRpc3BsYXllZCBpZi93aGVuIHRoZSB3YXRjaGRvZyBhcHBsaWNhdGlvbg0KPiBl
eGl0cyB3aXRob3V0IHN0b3BwaW5nIHRoZSB3YXRjaGRvZyBhbmQvb3Igd2l0aG91dCBjbG9zaW5n
IHByb3Blcmx5Lg0KPiBUaGlzIF9pc18gY3JpdGljYWwgc2luY2UgaXQgd2lsbCByZWJvb3QgdGhl
IHN5c3RlbSBhZnRlciB0aGUgbmV4dA0KPiB0aW1lb3V0IHBlcmlvZC4NCj4gDQo+IElmIHVzZXJz
cGFjZSB0cmlnZ2VycyB0aGlzIG1lc3NhZ2Ugb24gcHVycG9zZSAoZWcgYnkgdGhlIG1lbnRpb25l
ZA0KPiBzY3JpcHQsIHdoaWNoIGRvZXMgbm90IGV4aXQgcHJvcGVybHkpLCB1c2Vyc3BhY2UgaXMg
YXQgZmF1bHQsDQo+IG5vdCB0aGUga2VybmVsLg0KPiANCj4gR3VlbnRlcg0KDQpUaGFuayB5b3Ug
Zm9yIHRoZSBxdWljayByZXNwb25zZSwgR3VlbnRlci4gSSBzZWUgdGhlIGxvZyBlYWNoIHRpbWUg
d2hlbiBJIHJlYm9vdCBteSBzeXN0ZW0sIGFuZCB3aGVuIEkgc2VhcmNoZWQgdGhlIG1lc3NhZ2Ug
aW4gZ29vZ2xlLCBJIGFsc28gZm91bmQgcG9zdHMgYXNraW5nIHdoeSB0aGUgbWVzc2FnZSBpcyBw
cmludGVkIGF0IHJlYm9vdCwgYW5kIHRoYXQncyB3aHkgSSBmZWVsIGl0J3MgY29uZnVzaW5nLg0K
DQpBbnl3YXlzLCBwbGVhc2UgaWdub3JlIHRoZSBwYXRjaCBzaW5jZSBpdCdzIG5lY2Vzc2FyeS4N
Cg0KVGhhbmtzLA0KVGFvIFJlbg0K
