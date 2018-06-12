Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4082CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BB820891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J2J6BiUF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="F/kksI/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BB820891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933900AbeFLULY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:11:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2031 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932768AbeFLULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528834282; x=1560370282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hS7IicaZLt7znfTxv7yiuXYdMrFgw+pdTKeRT26vnMA=;
  b=J2J6BiUF6f7dJSJiyb4OUSzq1oWnhr86eWU++fiNym8umzttib59UvEk
   KRl1Eoj5xxd3kl5Zspjb9RQ1P+iyRxtxEizvtWwYu7qo+6yZAkWeyiKdb
   w/b7sR9veJw/1GaCT7FY7bBDa3IW/7LdSKw0PWcR2pMNx+HaP4XrnW+GX
   BIFPEc9mvU00VHVE2PFgH/6MBUJTTVVJpfhgpbTu14jKW7n2Judv1YyzL
   vMgMcHsOD1DY3+8fbn1pkaFD9KZmCczPtXeydgTFHrI41Gy3K8qW/meUV
   sH3CcPPOFZYEi7+0/+E2rWrJQK9XpZ3OKnWlAenty1cNzHwYDJK2DQQqh
   w==;
X-IronPort-AV: E=Sophos;i="5.51,216,1526313600"; 
   d="scan'208";a="80688994"
Received: from mail-sn1nam01lp0111.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([207.46.163.111])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2018 04:11:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hS7IicaZLt7znfTxv7yiuXYdMrFgw+pdTKeRT26vnMA=;
 b=F/kksI/ON/KrGyjHOdFbMq/hoKlZ5Rztp2vfOy3NEXeeKschO4xbuFp0vjw2CIayLE7tsRedjI07wuFxtz7TSxSt3J4PUFJQiczT55Cn3/gm+lXNRsQqn05xx/uQyC7EuRdDa0lINX4V2BHn7m9fb6SVWr2yZZZ1nPmvk+RMTyU=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0414.namprd04.prod.outlook.com (10.173.48.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Tue, 12 Jun 2018 20:11:18 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 20:11:18 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "evgreen@chromium.org" <evgreen@chromium.org>,
        Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
CC:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "gwendal@chromium.org" <gwendal@chromium.org>
Subject: Re: [PATCH 0/7] Enable UFS provisioning via Linux
Thread-Topic: [PATCH 0/7] Enable UFS provisioning via Linux
Thread-Index: AQHT93l8ZC6m9mEpI0aqfyFsRNJm9KRJnoYAgAHghACAAts6gIAB3/0AgAYf3wCAAvKegIADz10AgAAH+wA=
Date:   Tue, 12 Jun 2018 20:11:18 +0000
Message-ID: <d8035c8092a9401a766977a423c3f02c9c460ec5.camel@wdc.com>
References: <20180529181740.195362-1-evgreen@chromium.org>
         <MWHPR04MB11372C75BFC9416BAF5E81A19A630@MWHPR04MB1137.namprd04.prod.outlook.com>
         <CAE=gft4LoNiRtxgTA_ZPghZGEVOzu_GAwMgqhs-8NCYVgj_AVw@mail.gmail.com>
         <MWHPR04MB11370AED823FB608218CB9AD9A600@MWHPR04MB1137.namprd04.prod.outlook.com>
         <CAE=gft5Vk3neDkyvmVf4CkBQQPVK=wXp=5jJ8n0uaosEwWUOAg@mail.gmail.com>
         <b844b80f-9f6f-10f7-6dfd-f92d905738e3@intel.com>
         <MWHPR04MB1137E9FA44BAC5EBE097589C9A790@MWHPR04MB1137.namprd04.prod.outlook.com>
         <CAE=gft4LRtYJH1DStr6F6iK7q+TMA3RDPhft=A_AFyKpFmyS5w@mail.gmail.com>
In-Reply-To: <CAE=gft4LRtYJH1DStr6F6iK7q+TMA3RDPhft=A_AFyKpFmyS5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0414;7:vb0FJPtnZKA42wWcNlvbCIPMJmuSEbsKI2RQ9Fy+8gfuXdcLC2w5M8NO0F1taFaDH3qDsW5qULx4yWfjrY3v0ZebhGgDFlND3+k92tOUPVw8WkkDJCZrLYJLQ36E0nx/pq8onysMY2MJGL7RzkSZhg9ZIk/W+lrHj7TtJod25GooLiQlCU+gucfg8pPfdI+KRcz4RLIZnSCd9u5HxZcUbGYo1Fjazi6Nnxh9Eq5fEw787N3S3UsVaFuXR9BJNddr;20:g+/hbnG1x9rEP3YdlYYbkPjDEB4c9rm0wsUb9LFeh58jKAQFoCkIVqwUIaGyq2iZa068JI1MFE/tKD0QqVL5QIWG3LlU+yy3oPCYfj3OerVl7x1j6x64BUYPmAeDvWfOBq0/NqfAczqF8JLDnKymEhKBv7LyJjbnCZRhIvEvwVs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0414;
x-ms-traffictypediagnostic: MWHPR04MB0414:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB041490A308C0641DF185C74A987F0@MWHPR04MB0414.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0414;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0414;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(39860400002)(39380400002)(189003)(199004)(97736004)(5250100002)(118296001)(229853002)(6636002)(105586002)(106356001)(6436002)(14454004)(72206003)(5660300001)(478600001)(36756003)(2501003)(68736007)(66066001)(93886005)(6486002)(110136005)(81156014)(81166006)(8676002)(4326008)(2906002)(54906003)(25786009)(11346002)(7736002)(76176011)(6512007)(305945005)(26005)(53936002)(99286004)(3660700001)(39060400002)(2900100001)(6506007)(186003)(8936002)(3280700002)(59450400001)(102836004)(446003)(6116002)(6246003)(2616005)(86362001)(316002)(3846002)(486006)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0414;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ymllWVV2bPqnANqMSBJVYFsV+U/6TDbpAyX4Ou0ctPz/ubf4MF8FTAKS7jxj5Y9vDhTQJ53lDVD88kvdyTmxhl7UXVHp4MZM/JM5TmwXh2e9QTDIcGqt0fSh3zDgJn6SHmwru7WD/hEH91ZlgjsxcahJMtE7Hos2X2cH5GpryQF6I/5JHiwxKVMIHLBCNvsb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <748D75FA1880F04999A2ED925DCBAD2C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4b516936-341f-4708-cefe-08d5d0a0a896
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b516936-341f-4708-cefe-08d5d0a0a896
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 20:11:18.2932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTEyIGF0IDEyOjQyIC0wNzAwLCBFdmFuIEdyZWVuIHdyb3RlOg0KPiBX
aGF0IEkgX3dhbnRfIHRvIGRvIGlzIGJhc2ljYWxseSBjcmVhdGUgTiBzeXNmcyBncm91cHMsIHdo
ZXJlIGVhY2gNCj4gZ3JvdXAgcG9pbnRzIHRvIHRoZSBzYW1lIGFycmF5IG9mIGF0dHJpYnV0ZXMu
IFRoZW4gaW4gdGhlIHNob3cvc3RvcmUNCj4gbWV0aG9kcywgbG9vayB1cCB3aGljaCBncm91cCBJ
J20gaW4gYW5kIHVzZSB0aGF0IGFzIGFuIGluZGV4LiBCdXQgdGhlDQo+IHNob3cvc3RvcmUgZnVu
Y3Rpb25zIG9ubHkgcGFzcyB0aGUgYXR0cmlidXRlcyB0aGVtc2VsdmVzLCBhbmQgdGhlcmUNCj4g
c2VlbXMgdG8gYmUgbm8gd2F5IGZvciBtZSB0byBnZXQgdGhlIHBhcmVudCBub2RlLg0KDQpUaGUg
Zmlyc3QgYXJndW1lbnQgdGhhdCBpcyBwYXNzZWQgdG8gc3lzZnMgc2hvdyBhbmQgc3RvcmUgbWV0
aG9kcyBpcw0KYSBrb2JqZWN0IHBvaW50ZXIuIEhhdmUgeW91IGNvbnNpZGVyZWQgdG8gYWNjZXNz
IGtvYmplY3QucGFyZW50IGZyb20NCmluc2lkZSB0aGUgc2hvdy9zdG9yZSBtZXRob2RzPyBGcm9t
IGZzL3N5c2ZzL2ZpbGUuYzoNCg0KCWlmIChvcHMtPnNob3cpIHsNCgkJY291bnQgPSBvcHMtPnNo
b3coa29iaiwgb2YtPmtuLT5wcml2LCBidWYpOw0KCQlpZiAoY291bnQgPCAwKQ0KCQkJcmV0dXJu
IGNvdW50Ow0KCX0NCg0KQmFydC4NCg0KDQoNCg==
