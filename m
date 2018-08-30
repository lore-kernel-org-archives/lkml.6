Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC78C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3112120835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nUOugr7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3112120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeH3Xmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:42:31 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:26880
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbeH3Xma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aXk1fTN1v0G0dCMjcJ/beHgJHnbbeBlz40gwes5dl8=;
 b=nUOugr7J3wuYkTrJ7dpRSRndhD0xNQTTSg03Ff7/rdn+DkUdyZ78N8DMYdvr1a/96vHhpkaBRQPXDh19nVDJAt+4GYtA0QRFpFQ0v9Z/BcmYiRpLKyizEJ7WDY1zJ4Vcd+mV22aq3Q3vAUUhIdWSOKPBjCA+HPFN/m3AkAcnrNc=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0121.namprd21.prod.outlook.com (10.173.173.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 19:38:43 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 19:38:43 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFCv2 6/6] memory-hotplug.txt: Add some details about
 locking internals
Thread-Topic: [PATCH RFCv2 6/6] memory-hotplug.txt: Add some details about
 locking internals
Thread-Index: AQHUQJkPzdDzVGjSIEmr3/vDaTxSRw==
Date:   Thu, 30 Aug 2018 19:38:43 +0000
Message-ID: <b46f358b-8fea-b380-1978-5f3e772130d4@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-7-david@redhat.com>
In-Reply-To: <20180821104418.12710-7-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0121;6:3FkTvVYHCoASj2NoAJhXPer96uyBd3iV/k9HNGToAXzsU6Vr4qA3U/9ssBjeGJiS8WjeUBAFLKVHpU7kA4Ub/s8gUjImiJnvlymnUl+H9mAjtSFG5RKwVR5aG08fo04dTzjvKnHa8TZrIkFhmkIuK+fBikhPSrMYknwbrVscY646Dfl5+kf6zlMBZIhvm1iuKLo4tKCeFRDQsYmvoEd8DbP3j+oY31dutBdjgtfkK6hSZUd7qvKAlJqwUl+zB3hFu7XAE5GrzZ6rrXghKxkEi7YwjtP8Fw+HFLDY6IXuV99RuywIlb8/vctif97eSIdFzMgMXXASKpZMdqu0oIBtHR8ChE33w1+Mj/tOju3TnQxICBrFnaJHASrSVlCdEXC7wsygQTeX/B5qh5RUJ4FWMslpHvCABiml3hk+sEQi/yjXw8hIfpDgsh0QDFmU8v3t4KURfc4W6+b0r+v3+9ysXw==;5:/2rNI3M5JMmQqs8LI18ZR9rSsFfgacv8qlZwn6RiqXeCC6Ajeul4td3UTIeHo1x2I2pEmEyuMSB0v9Vd9KXLYPIa3drRpPl7IVVW0Vzj9MQTgizrmOT9FlXcwdoZC5ggQnBoOM+17TMcDsbbE7kgGIXbO6gqtYUJORlXUbBXMj4=;7:hO3H6YwXeALiFTTeuH5uL9iG8pGe9QLbhVaYbp5QAEbnWEshtCY+cxOGMxHBIDKBt4tYt4AOXVczV+rY5bF4uggCduWNfigRVN/ZvTh93qOIZ1RWZ60T781XcUWvTxMrYagMNhTdVhxDavfI3MJeKVgVQGySX/nJjIzbnqymGLlWC8Qz/OOhXSo8UMrGlHBK0P8/YYqP1ColK/WeHyceQFDpmgdDXNkRlyMFjgi0tMM7xQceOkYb0zGV3DmTOwVF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a438b49c-658f-4fab-9ec6-08d60eb0322e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0121;
x-ms-traffictypediagnostic: DM5PR21MB0121:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB01219AD80AFDF3EB8837A1539D080@DM5PR21MB0121.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0121;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0121;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(81166006)(6246003)(81156014)(54906003)(72206003)(6486002)(2900100001)(14454004)(2906002)(110136005)(66066001)(31686004)(5660300001)(106356001)(478600001)(105586002)(8936002)(10290500003)(6436002)(76176011)(102836004)(4326008)(53936002)(6512007)(99286004)(36756003)(6506007)(256004)(53546011)(14444005)(8676002)(10090500001)(558084003)(7416002)(26005)(7736002)(305945005)(486006)(446003)(11346002)(2616005)(476003)(186003)(68736007)(97736004)(22452003)(316002)(229853002)(2501003)(25786009)(31696002)(3846002)(86612001)(5250100002)(6116002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0121;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HT4zcTN7Kj4+uPrbBxL8ciA0gLQ6HO5Qzb2eg37ej8fyDU+Mv7qeR43rYmWwujmDs7FQkMOm/zoAWR4GdRVHO6oMH9GXr2gCyMMbBEUWPWRvVgGKnerRBgk9wFkmYms20H7ADCm7ycZTAws7tLtOZx9rffMTVHzz3tJu/i17rGtJG0+EnmPaZJOiWWYnwghzsI1TNoGZhQTDfZmep4W5AcIfGNr+v6ljVq4ZJW+Twb2O6AK2nbhODSySeNnDP1QP3Z4QJ1YXN2RrXLfVizvY99cS5RRjP2m9pjfACaoWfXT8GfB35yIJQgn6Nw8gF3o8XybejVMdRO0obARvO6iqTI42DG+GEMoBZy0KWe3Cs9A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F9046A8AD873D478941CC2B49BDEB5E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a438b49c-658f-4fab-9ec6-08d60eb0322e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 19:38:43.6951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpSZXZpZXdlZC1ieTogUGF2ZWwgVGF0YXNoaW4gPHBhdmVsLnRhdGFzaGluQG1pY3Jvc29mdC5j
b20+DQoNCk9uIDgvMjEvMTggNjo0NCBBTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+IExl
dCdzIGRvY3VtZW50IHRoZSBtYWdpYyBhIGJpdCwgZXNwZWNpYWxseSB3aHkgZGV2aWNlX2hvdHBs
dWdfbG9jayBpcw0KPiByZXF1aXJlZCB3aGVuIGFkZGluZy9yZW1vdmluZyBtZW1vcnkgYW5kIGhv
dyBpdCBhbGwgcGxheSB0b2dldGhlciB3aXRoDQo+IHJlcXVlc3RzIHRvIG9ubGluZS9vZmZsaW5l
IG1lbW9yeSBmcm9tIHVzZXIgc3BhY2UuDQo+IA==
