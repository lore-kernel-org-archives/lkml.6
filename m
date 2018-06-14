Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 34A96C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43C320864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TSklatS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43C320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936346AbeFNOwr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:52:47 -0400
Received: from mail-pu1apc01on0102.outbound.protection.outlook.com ([104.47.126.102]:8836
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936289AbeFNOwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfGIJju+4VjVETkTrG0U1lKZPJ6dabTHQ+Oi7hu2Naw=;
 b=TSklatS9KsX+hg28RQmmw535Auu3pd4KG61i/FGjyHwM+AAKIo/XNYLMVLS8Dxi5gQdqi2yhKTtUENUJqlQfRl9mn800ntRVcm3zdhSYetQ/Wk9aO0qvRg857eeDJMCDU/UwssiV/tzPpuMB31RvULle9agb1DaqTMy521yqqDY=
Received: from SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM (10.170.136.18) by
 SG2P15301MB0045.APCP153.PROD.OUTLOOK.COM (10.170.136.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.14; Thu, 14 Jun 2018 14:52:20 +0000
Received: from SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cae:4bd:cf5d:6e8d]) by SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cae:4bd:cf5d:6e8d%5]) with mapi id 15.20.0884.010; Thu, 14 Jun 2018
 14:52:20 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [RFC Patch 3/3] KVM/x86: Add tlb_remote_flush callback support
 for vmcs
Thread-Topic: [RFC Patch 3/3] KVM/x86: Add tlb_remote_flush callback support
 for vmcs
Thread-Index: AQHT++OdAN2+GrZK4EuBP0Cwrph5uaRcx7edgALROgCAAAW24IAASB6A
Date:   Thu, 14 Jun 2018 14:52:19 +0000
Message-ID: <d2c97f09-692a-25db-dd7c-1536325be1e5@microsoft.com>
References: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
 <20180604090749.489-4-Tianyu.Lan@microsoft.com>
 <87h8m8qbso.fsf@vitty.brq.redhat.com>
 <f868a339-03fc-4ba6-4882-4bb6232f599d@microsoft.com>
 <87d0wtpsha.fsf@vitty.brq.redhat.com>
In-Reply-To: <87d0wtpsha.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0045;7:3/V9NdsMqBzjBRHPTkouG3ArMbcF0UkKBBToUY4eQSCDV0xjxsuSAf58NXrLVi6QjV9FdY9PIPo/3NmHBVAcQK48THjTgxQi5CTZJTATqTXqxIDAdMxRANsuzqk6J5CtYWsKtO/sRayEUSkyqwE/JxcbCHhqcfgNk3vRSV0q5qt669hKByaFtQCCThcrKIi3/0PXR/+Q5JBEjOvWjnVJgo+qMd8PGqN0vNQTJKl2wTy/vO/H1CZs4PknEB+6lc7i
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04319ad3-e664-4e84-165b-08d5d2066e1f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7193020);SRVR:SG2P15301MB0045;
x-ms-traffictypediagnostic: SG2P15301MB0045:
x-microsoft-antispam-prvs: <SG2P15301MB00454BAA682FCBAEE9CF7EE0927D0@SG2P15301MB0045.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0045;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0045;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(14454004)(81166006)(81156014)(186003)(5660300001)(8936002)(5250100002)(93886005)(2906002)(68736007)(3846002)(6116002)(4326008)(6512007)(25786009)(10290500003)(107886003)(26005)(476003)(6246003)(72206003)(486006)(86612001)(7736002)(66066001)(97736004)(31696002)(86362001)(478600001)(305945005)(36756003)(99286004)(1511001)(8676002)(53936002)(2616005)(102836004)(6436002)(106356001)(105586002)(59450400001)(229853002)(31686004)(6486002)(316002)(22452003)(76176011)(54906003)(2900100001)(110136005)(53546011)(3280700002)(446003)(6506007)(10090500001)(3660700001)(11346002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0045;H:SG2P15301MB0062.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GTN7YuPdc4h4LFMoMlHbBjxPyHs5TNB0ALD35hWZtL8v3o/zBoIOBVjJM12xbV5siEZUR2Vyr3EsglLezr/3brCElEoVPgLvs2KuAUw/eKQDESdIV7a7/FixMVypPnJnwFYxbGOd2CnIXZMDG7MSrsXV2XBr7t0pTchw6eG4FCq+F56zrR3etjcuwV5wVBj1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1B80C11CD9751488D806E89BF959BD8@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04319ad3-e664-4e84-165b-08d5d2066e1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 14:52:19.7887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xNC8yMDE4IDY6MzMgUE0sIFZpdGFseSBLdXpuZXRzb3Ygd3JvdGU6DQo+IFRpYW55dSBM
YW4gPFRpYW55dS5MYW5AbWljcm9zb2Z0LmNvbT4gd3JpdGVzOg0KPiANCj4+IE9uIDYvMTIvMjAx
OCAxMToxMiBQTSwgVml0YWx5IEt1em5ldHNvdiB3cm90ZToNCj4+PiBUaWFueXUgTGFuIDxUaWFu
eXUuTGFuQG1pY3Jvc29mdC5jb20+IHdyaXRlczoNCj4+Pg0KPj4+Pg0KPj4+PiArc3RhdGljIGlu
dCB2bXhfcmVtb3RlX2ZsdXNoX3RsYihzdHJ1Y3Qga3ZtICprdm0pDQo+Pj4+ICt7DQo+Pj4+ICsJ
c3RydWN0IGt2bV92Y3B1ICp2Y3B1ID0ga3ZtX2dldF92Y3B1KGt2bSwgMCk7DQo+Pj4+ICsNCj4+
Pj4gKwlpZiAoIVZBTElEX1BBR0UodmNwdS0+YXJjaC5tbXUucm9vdF9ocGEpKQ0KPj4+PiArCQly
ZXR1cm4gLTE7DQo+Pj4NCj4+PiBXaHkgdmNwdTA/IENhbiBhcmNoLm1tdS5yb290X2hwYS1zIGRp
ZmZlciBhY3Jvc3MgdkNQVXM/IFdoYXQgaGFwcGVucyBpZg0KPj4+IHRoZXkgZG8/DQo+Pg0KPj4g
WWVzLCBpdCBtYXkgdGFrZSBwbGFjZSB0aGF0IGFyY2gubW11LnJvb3RfaHBhIGlzIGRpZmZlciBh
Y3Jvc3MgdkNQVXMuDQo+PiBXZSBtYXkgY2hlY2sgYWxsIHZjcHUgcm9vdF9ocGEgYW5kIHVzZSB0
aGUgaHlwZXJjYWxsIHdoZW4gdGhlcmUgaXMgb25seQ0KPj4gb25lIHZhbGlkYXRlZCBlcHQgdGFi
bGUuIElmIG5vdCwgZ28gYmFjayB0byBjdXJyZW50IHdheS4NCj4+DQo+IA0KPiBJJ2Qgc3VnZ2Vz
dCBhbiBvcHRpbWl6YXRpb246IGtlZXAgdHJhY2sgb2Ygd2V0aGVyIHJvb3RfaHBhcyBhcmUgZXF1
YWwNCj4gYWNyb3NzIGFsbCB2Y3B1cyAoY2hlY2sgdGhpcyBvbiBjaGFuZ2UpLg0KPiANCg0KR29v
ZCBzdWdnZXN0aW9uLiBJIHdpbGwgdHJ5IGl0LiBUaGFua3Mu
