Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68B4ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB9C2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DqkDcjco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB9C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732907AbeITUOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:14:05 -0400
Received: from mail-eopbgr1300094.outbound.protection.outlook.com ([40.107.130.94]:55552
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387437AbeITUOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxjatOhAYfLbdp1WrsIrm/27kWsLUGuG6ZgYi0COPLE=;
 b=DqkDcjcoYhKZ3loQ03MXSL9WMQJGHERrnGkmCGEGK2JjdKjFOK2k4nbHJXJOwEAN8H+MsJjYQDhvvFFSPhwVPvL3v0z8xLtIcrFYE9iMJVdg2fpLtsvgrUcsiwDFLyZSUv1QJni6XwzW3K6dL7wyNvE6L2I8dQlPtXTV8s4/qUI=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0161.APCP153.PROD.OUTLOOK.COM (52.133.156.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Thu, 20 Sep 2018 14:30:15 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 14:30:15 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: Re: [PATCH V2 4/13] KVM/MMU: Flush tlb directly in the
 kvm_handle_hva_range()
Thread-Topic: [PATCH V2 4/13] KVM/MMU: Flush tlb directly in the
 kvm_handle_hva_range()
Thread-Index: AQHUTv5JxXHYarz6dEerAeTlEED0BKT3yCcAgAF2swA=
Date:   Thu, 20 Sep 2018 14:30:14 +0000
Message-ID: <53f4c88b-14b7-c5b1-9690-1aad98cf56d4@microsoft.com>
References: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
 <20180918031754.113013-5-Tianyu.Lan@microsoft.com>
 <CY4PR21MB077308B3F20B235B994FF6A5DC1C0@CY4PR21MB0773.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB077308B3F20B235B994FF6A5DC1C0@CY4PR21MB0773.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0161;6:m7qd6sN0ep1HsYz5lvHr390WO92IzSXn1rkhLTgPDzjPDYs73VZ2sBB7WsB528PC3MISTFIqSUQ2ZSfXcOrAVQZU8tNsPvI4frzcwbFNf5EAySDs1cD6C9/JqmZAhDX8oxBRgKJLl25or9qalB0F8lDKmmSUEFdmHV1/8a8X44s1JFWyaaREJ9AVZPwFFJyTo39R7oFdAGP43q5fXYYUY6YZ9cK8oEX/eolqNXRzQ2s7ulUcOtJDQ3x4xLOr9XyDf+oMAws516VA/cJ2L+B61bCLZi/hxTVKmgbUo/osv6OVrC6ac4FOTR5s3xkUEaV7p973vZkc2JoLA6u0XkEdHw8WwMV1FxBg5+Mtv/mnJOEfKD2VjASQlpOxIbPyNUeNM/BS4H08wLWOxFaQzR703RwnFA5GoNiKaPXn08EqshBdt5hvgZMheuwiWlLSTi6WAHcAD1sc+sGQnpqFZ5DDIw==;5:7jngPUlR+QwKCbfffmNX3giLl6H+j8MTJrtlvpmq1Vy/ZxEwlHBkUKhLlSXz1FwTqDNDCORoXL1eZS4be0g2Uy+rza/Mf56gnLu5wy3UflAZYa2O2shO+/S9pglUmx1PugCMXIsWdaIVUtylyO974quCJp/aeG7j3kbc+MUL7e0=;7:VE+AaUMtGQDpX0m+RIxM+m6bmD8QdfNbAFJr8NVF/buWpsSrHxB/JAq964l2tNBMBTlkdc6TIJeAd97Cuv5Q1bNuFBLPFRGZcUldOq4pXdvN3hBnnFFBPbkU87qHdZtDsaH+vS6Ucn7MGOWaCnT5OaxQ38uSlyfFDQHGJaK9ijm+d2ZJr04H2BQcZxyUieeNY3D85Y/VXkq/um/cnq5ugha/7GzdyPoTWQ9SmH66tCUvBmszWuT6YzPUEphHQQKn
x-ms-office365-filtering-correlation-id: 5ec9abcf-e61c-4855-eba0-08d61f0594d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0161;
x-ms-traffictypediagnostic: HK0P153MB0161:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0161A3524DCB5B7B103035EC92130@HK0P153MB0161.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:HK0P153MB0161;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0161;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(10090500001)(107886003)(11346002)(31686004)(4326008)(97736004)(25786009)(36756003)(486006)(446003)(68736007)(476003)(2616005)(22452003)(110136005)(85306007)(81156014)(105586002)(81166006)(256004)(106356001)(5660300001)(76176011)(6246003)(71190400001)(8676002)(53936002)(6436002)(31696002)(1511001)(71200400001)(6486002)(86612001)(2900100001)(478600001)(316002)(102836004)(6512007)(2906002)(66066001)(99286004)(8936002)(54906003)(6116002)(3846002)(14454004)(229853002)(6506007)(53546011)(305945005)(5250100002)(7736002)(86362001)(26005)(7416002)(72206003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0161;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZGM7X7fMIQ1/73xAq4erMsJIPQhyWEBrZl4NWB0aWHWrmuQoDyagC3Nvf6ZdKap5oiXEUkSffEgkG1aENlwDGnt+JAqAIN8UcNgWkoVTKJLqK/agu0a8ratjNmKvcRlbbtu0O3YZ8Ss/R4aBX0CdwfBMHtvc1u8icTicjW3aWF64chZZKO3hIq7I6XT1PWXL/UEpOSybeO3a1E+WHXF2rq4QKW9fDDinlKrp8AiSPFMzQDgrd+lHoFlpkHnZH5BUd4Fcx2uFaF+0SHX+kX+tc7a4K4xB066uyAahAXIgeLDAcV7037Na5hkbMB+KTy6P3fffIFie++h8mAqf7Qywxujuf/vzZwIzwoa17R8a2OE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4A2CE448EA82B4798C50D848FF4BBB5@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec9abcf-e61c-4855-eba0-08d61f0594d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 14:30:14.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yMC8yMDE4IDEyOjA4IEFNLCBNaWNoYWVsIEtlbGxleSAoRU9TRykgd3JvdGU6DQo+IEZy
b206IFRpYW55dSBMYW4gIFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE3LCAyMDE4IDg6MTkgUE0N
Cj4+ICsNCj4+ICsJCQlpZiAocmV0ICYmIGt2bV9hdmFpbGFibGVfZmx1c2hfdGxiX3dpdGhfcmFu
Z2UoKSkgew0KPj4gKwkJCQlrdm1fZmx1c2hfcmVtb3RlX3RsYnNfd2l0aF9hZGRyZXNzKGt2bSwN
Cj4+ICsJCQkJCQlnZm5fc3RhcnQsDQo+PiArCQkJCQkJZ2ZuX2VuZCAtIGdmbl9zdGFydCk7DQo+
IA0KPiBEb2VzIHRoZSBhYm92ZSBuZWVkIHRvIGJlIGdmbl9lbmQgLSBnZm5fc3RhcnQgKyAxPw0K
DQpUaGUgZmx1c2ggcmFuZ2UgZGVwZW5kcyBvbiB0aGUgaW5wdXQgcGFyYW1ldGVyIGZyYW1lIHN0
YXJ0IGFuZCBmcmFtZSBlbmQgDQpvZiBmb3JfZWFjaF9zbG90X3JtYXBfcmFuZ2UoKS4NCg0KICAg
ICAgICAgZm9yX2VhY2hfc2xvdF9ybWFwX3JhbmdlKG1lbXNsb3QsIFBUX1BBR0VfVEFCTEVfTEVW
RUwsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUFRfTUFYX0hVR0VQQUdFX0xF
VkVMLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdmbl9zdGFydCwgZ2ZuX2Vu
ZCAtIDEsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJml0ZXJhdG9yKQ0KICAg
ICAgICAgICAgICAgICByZXQgfD0gaGFuZGxlcihrdm0sIGl0ZXJhdG9yLnJtYXAsIG1lbXNsb3Qs
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGl0ZXJhdG9yLmdmbiwgaXRlcmF0b3Iu
bGV2ZWwsIGRhdGEpOw0KDQoNClRoZSBzdGFydCBpcyAiZ2ZuX3N0YXJ0IiBhbmQgdGhlIGVuZCBp
cyAiZ2ZuX2VuZCAtIDEiLiBUaGUgZmx1c2ggc2l6ZSBpcyANCihnZm5fZW5kIC0gMSkgLSBnZm5f
c3RhcnQgKyAxID0gZ2ZuX2VuZCAtIGdmbl9zdGFydC4NCg0KPiANCj4+ICsJCQkJcmV0ID0gMDsN
Cj4+ICsJCQl9DQo+IA0KPiBNaWNoYWVsDQo+IA==
