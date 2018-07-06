Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ECFC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B27216FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VqoEnNbC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TZi8CqN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B27216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933912AbeGFRBI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:01:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45952 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbeGFRBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530896466; x=1562432466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z2XDqnBbdLu8gr/atiA5RadTUA/5kdnARpFBxGEYfqM=;
  b=VqoEnNbCMuhrQgarKhvguC4DcIRly8JEtAAjtTi51rRis3cuNI7t7OQf
   wlsYjoyxca5pxYarApjSPChd3jCFuN/ZraDX40s9aI7dLdkNsik1qcxU8
   xGGEF4ccVYjCRfBATa7oHSVyxsF1nINx5IiRV261q2y6/QZT1NE61i60E
   mwv1JYWqOvnk+vWpboDU1BRnXSY5x5aNaEHkIzduYC3WXUe42NTFVMUyO
   0Y/gWerI41kzB/iOu5HiYpfK6nakk+rVs/qo2BLnzRs9AM4ltz4jwl16R
   pEXQcxGN/+P4qcJKzqT87UoSnLealJDeYLKQaAYc3ApQ9d+nWqtKZIpfH
   A==;
X-IronPort-AV: E=Sophos;i="5.51,317,1526313600"; 
   d="scan'208";a="84074842"
Received: from mail-co1nam03lp0024.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([216.32.181.24])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2018 01:01:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2XDqnBbdLu8gr/atiA5RadTUA/5kdnARpFBxGEYfqM=;
 b=TZi8CqN4equUeW7wGF/RSjROq6e/QQK1+lxjVBRhwyA/SZ7v4GF788wooKL+3JgH++T5VyIxvcIGJ1ozYUdRipW2+Opeso/HpAY3T/qWMtDJhzv+KEt4rvH3qFhu7bRXvbjwsG4ITxrG/0Rzy7a3nUKurGV7DKD/fFmX7aG/Lsk=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0288.namprd04.prod.outlook.com (10.169.202.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Fri, 6 Jul 2018 17:01:00 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0906.026; Fri, 6 Jul 2018
 17:01:00 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jthumshirn@suse.de" <jthumshirn@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "RaghavaAditya.Renukunta@microsemi.com" 
        <RaghavaAditya.Renukunta@microsemi.com>,
        "david.carroll@microsemi.com" <david.carroll@microsemi.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/4] scsi: aacraid: remove AAC_STAT_GOOD define
Thread-Topic: [PATCH 1/4] scsi: aacraid: remove AAC_STAT_GOOD define
Thread-Index: AQHUFE+5LXiqTazrikuo5Sq4JRlRiaSA4WcAgAD1/ICAAJXQgA==
Date:   Fri, 6 Jul 2018 17:01:00 +0000
Message-ID: <b4f3bbb10b9e21b439e52c0f941809ca6f567bca.camel@wdc.com>
References: <20180705110140.19545-1-jthumshirn@suse.de>
         <20180705110140.19545-2-jthumshirn@suse.de>
         <babfea1746aaca57109f84bff674dda635a76e29.camel@wdc.com>
         <20180706080447.2u3iptpnvmso6ncc@linux-x5ow.site>
In-Reply-To: <20180706080447.2u3iptpnvmso6ncc@linux-x5ow.site>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0288;7:iC6s66NiFJQzTQJjJ6gZ+Tg2MVXB3xbL3ueraHumZMdvq5KEGZVkv2+6R9zJFksQr9m9RYm99RPI8Rev3MtkZri9z+/0q56nQ9/5c9fIF1UH3jzUb+/s6yLRRezfh9pkAijUrOy2upKGLctJoY9la10ZWHHPsSWrH3HBu82WXaGtsjUtyLnDmmZHgycRi8ObWavygJRlOpy7mgafDHnQ5JuJJgKu601X887n4HSSd1v7TxHcsW006KKmx7ZkNt2h;20:O/HLnm3/TszajSgfYNC1mtIfZHuv5pYfW0NobfNniUNbmNAIXlThh2AIwjEAYJOLM3R5o9zBufq7XkZfLZ962sofszTf1gLNtddWKqdAzyv3C7Ft0iuChNBV6QBCKhAdQfRQjz0BBsdCxkYmhSow3y+XT1x4Ji8HEHP9trEMP0I=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 866d63f5-5a5e-466b-9137-08d5e3620d20
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0288;
x-ms-traffictypediagnostic: MWHPR04MB0288:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0288D813901F6CA09A601D7298470@MWHPR04MB0288.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0288;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0288;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39860400002)(366004)(396003)(189003)(199004)(118296001)(3846002)(478600001)(8936002)(6116002)(1730700003)(81156014)(8676002)(2351001)(53936002)(68736007)(81166006)(2616005)(305945005)(7736002)(97736004)(486006)(6246003)(476003)(11346002)(72206003)(14454004)(446003)(6486002)(6436002)(106356001)(86362001)(4326008)(76176011)(6506007)(25786009)(66066001)(93886005)(6916009)(105586002)(316002)(229853002)(2501003)(2906002)(6512007)(5640700003)(2900100001)(99286004)(5250100002)(54906003)(36756003)(186003)(102836004)(256004)(5660300001)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0288;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: fk5Z0T2GvmcrfQa9XJe8NX749XBPL7DWXAvGbjKjVhrJzGAogP8XPY+W6jCqWqFkuNnI7WX2DuEVUc+2ZBuR2iKeG/3VvDPo8fl48r8P4NzGe5nhK4VoYkobNzPV9LHRuzEcCJJIQPgtPsegdvBhrYEjvVNHJHHaQp3OtB623kgFbPxu3ywj7GmHp5IMK7zuzN9QvzY8Md3+F6hNWhKXgtp6qI0G7SO6a2y3tf9g029MTesIAOXRKqQazZqfRFBDnELwaXn9WKeNEzDhNrrSCik14uHJQFaReqJKLh4JLHuucaNvZZXySla/IDKG/zosmZXi4n3wV+Fdh3intBnjnZpLxebl2QORXmLXQXXtfqs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <05E4E04AC233AD46BECFAB652D81F229@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866d63f5-5a5e-466b-9137-08d5e3620d20
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 17:01:00.8420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0288
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA3LTA2IGF0IDEwOjA0ICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIFRodSwgSnVsIDA1LCAyMDE4IGF0IDA1OjI0OjIzUE0gKzAwMDAsIEJhcnQgVmFu
IEFzc2NoZSB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMTgtMDctMDUgYXQgMTM6MDEgKzAyMDAsIEpv
aGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gPiA+ICAJCWlmICgoKGFhY19jYWNoZSAmIDYpID09
IDYpICYmIGRldi0+Y2FjaGVfcHJvdGVjdGVkKSB7DQo+ID4gPiAtCQkJc2NzaWNtZC0+cmVzdWx0
ID0gQUFDX1NUQVRfR09PRDsNCj4gPiA+ICsJCQlzY3NpY21kLT5yZXN1bHQgPSBESURfT0sgPDwg
MTYgfCBDT01NQU5EX0NPTVBMRVRFIDw8IDggfA0KPiA+ID4gKwkJCQkJICBTQU1fU1RBVF9HT09E
Ow0KPiA+IA0KPiA+IERvZXMgQUFDX1NUQVRfR09PRCByZWFsbHkgaGF2ZSB0byBiZSBleHBhbmRl
ZCBpbiBmdWxsIG11bHRpcGxlIHRpbWVzPw0KPiA+IEhhdmUgeW91IGNvbnNpZGVyZWQgdG8gcmVw
bGFjZSBBQUNfU1RBVF9HT09EIGJ5IHRoZSBudW1lcmljYWwgY29uc3RhbnQNCj4gPiAwIGluc3Rl
YWQ/DQo+IA0KPiBUaGlzIHdvbid0IHdvcmsgYW55bW9yZSBvbmNlIHdlIHN0YXJ0IHNwbGl0dGlu
ZyAtPnJlc3VsdCBpbnRvIDQNCj4gdW5yZWxhdGVkIGVudW1zLiBUaGF0J3Mgd2h5IEkgcHJlZmVy
IHRoaXMgd2F5Lg0KDQpUaGF0IGV4cGxhbmF0aW9uIGRvZXMgbm90IG1ha2Ugc2Vuc2UgdG8gbWUu
IFRoZXJlIGlzIHBsZW50eSBvZiBjb2RlIGluDQp0aGUgdXBzdHJlYW0ga2VybmVsIHRoYXQgYXNz
aWducyB6ZXJvIHRvIC5yZXN1bHQsIHNvIHlvdSB3aWxsIGhhdmUgdG8NCmRlYWwgd2l0aCB0aGF0
IHBhdHRlcm4gYW55d2F5Lg0KDQpCYXJ0Lg==
