Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79C6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492DC20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="idRHIhXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492DC20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbeKGSqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:46:10 -0500
Received: from mail-eopbgr710060.outbound.protection.outlook.com ([40.107.71.60]:47456
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbeKGSqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAs1w11vMXhndeMjJl7Lg7bd4LpeLDZW2Pg/tFXXJ9M=;
 b=idRHIhXvgcRIw+dDlDM9oqnfaE/emEQ5GIF6eKoHIQ8dB9g70wN3b0Tll2COa8vB9zNGhRWTc+27DFylIn0Oc/RwYGqoaS0XIbnAbl6oh8kbisXWAUXVF3on/FyJrcWPvP+SPwbd6GxcH8/0B9YT51PRxbF+05zjQ4fLFMN20GM=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0752.namprd10.prod.outlook.com (10.163.206.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Wed, 7 Nov 2018 09:16:39 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055%4]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 09:16:39 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "nkela@cisco.com" <nkela@cisco.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Thread-Topic: [PATCH] jffs2: implement mount option to configure endianness
Thread-Index: AQHUdhzsqXgjqeVdYEqFu2rUs5D51aVEBd8AgAADEoA=
Date:   Wed, 7 Nov 2018 09:16:39 +0000
Message-ID: <1e4c066d1896e2a0b8b146253d34d05cc4f9ab36.camel@infinera.com>
References: <20181106214928.40020-1-nkela@cisco.com>
         <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
In-Reply-To: <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR10MB0752;6:Ke1pks6lfv41qx34XMdwxXIkGVk01bVs6cKfL4gKOYCpjNhln3ggceQdPj85hTM4EUOI4IfvhK/u5pGHhkXP4fQDVwuZd6fhZqfQX3EZEJUMZz/A1FPH2PoJoJoOsUD5jyXlHtKsP7pkzqSC6/Itp44NXnFwbWHmQ3D98Ff+HxUhKBT7U0Oktv6iqlxnfcoLcZMK8gXLe2oSnYNshfKU3vopDrQPTLuWr5lGQMpD5y1JnUPihlluxkCWo8raoBc5vKYalwDvBn8GE+x/tWmemO83iIHVYFfPLkuHLHIO27/UDaeseH1nQPl2XVd49XKvQ8C5Nq8sHLKaMVA3HILE52sFYMf1WQag+WIvNIy2EIU+utMddsn83mGK82qD21h+uuidWDWEdYeJ/GTth7JXBTh++E9MM7ex5M0Io0F3BdHehsw52B+5hxB9Wjmd42B+ry6K7/hrPLq/5+xGQzKVqQ==;5:MB7QQ4cHcQjx/Nh97FGuoOTuXOOtfVBsH73E3JeEFj0TFcqdC8IvYaPxkBCYjP/GFUkph0MgpOFJXf1VSdEMaym4pRlYLsPrq22uNtk3SPpi/Wm9YNPNmBs9ZrAw7l9wnPPKWGPfA4y92b+8UlEv82jsipoWbQuvSH664b+Xv+o=;7:GveBxLAq/A5AgRX05b8E9qQYtKohZINmv2JvkhcUEGz7sQ1wdssvPHaf9J+y/D7BLvU0ipVeIJzd1N3DZSdUmbtLN3sboLl94/ANDIN0BoNvIgdVvThy+rh0sLOTAcX8sSK32iDlbV8yeW1Vl8MFEg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6f2d8f88-0ab7-47cc-f9c6-08d64491b98e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR10MB0752;
x-ms-traffictypediagnostic: SN1PR10MB0752:
x-microsoft-antispam-prvs: <SN1PR10MB0752946F95299DCABE6702EBF4C40@SN1PR10MB0752.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN1PR10MB0752;BCL:0;PCL:0;RULEID:;SRVR:SN1PR10MB0752;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(6436002)(66066001)(2501003)(6486002)(72206003)(53936002)(6512007)(14454004)(118296001)(446003)(11346002)(2900100001)(99286004)(2616005)(486006)(476003)(71200400001)(105586002)(106356001)(71190400001)(186003)(68736007)(25786009)(2906002)(102836004)(316002)(8936002)(8676002)(81166006)(81156014)(3846002)(305945005)(229853002)(478600001)(6116002)(6246003)(97736004)(7736002)(110136005)(36756003)(5660300001)(4326008)(256004)(76176011)(6506007)(26005)(86362001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR10MB0752;H:SN1PR10MB0736.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q/LkPBNNECXWNpuMG4YyPA+qHlpPeEOvxh9TphwpAfGWXVFYR6EFlrf0j2SZ40RItLDEMuIeru17ZgsWZTihggbNxsSG3EDMJi2ZUdp8dZIaXY1MsdCSMlqNWOZDNARnBIYcwnNFBUoq0Y2WspypTwdrne38Mb52X0xgZxr+XEHjMhYcat53eNLDYUm0I7Od0tSQxvj6SCHsJSRGSNXAwOXbohtZdA3xrToETMPH7AEjLw966xMoJ2QgnGqldawp77pDR0aTM6/WuRdDd7QDCt6BrZQ7kxoe5+exOZ1+2Fnl+uzQR6I14DXr2oh2KpaunyyW53KHedcTFdRtQGVaLF7ju4ubDSoI9eQWAt7tg4Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <160E64C7430E3C47BF2A92CFF2BD7CB2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2d8f88-0ab7-47cc-f9c6-08d64491b98e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 09:16:39.1984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTA3IGF0IDEwOjA1ICswMTAwLCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6
DQo+IA0KPiBPbiBUdWUsIDIwMTgtMTEtMDYgYXQgMTM6NDkgLTA4MDAsIE5pa3VuaiBLZWxhIHdy
b3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWxsb3dzIHRoZSBlbmRpYW5uZXNzIG9mIHRoZSBKRlNTMiBm
aWxlc3lzdGVtIHRvIGJlDQo+ID4gc3BlY2lmaWVkIGJ5IG1vdW50IG9wdGlvbiAnZm9yY2VfZW5k
aWFuPWJpZ3xsaXR0bGV8bmF0aXZlJy4gSWYNCj4gPiBlbmRpYW5uZXNzIGlzIG5vdCBzcGVjaWZp
ZWQsIGl0IGRlZmF1bHRzIHRvICduYXRpdmUnIGVuZGlhbm5lc3MNCj4gPiB0aHVzIHJldGFpbmlu
ZyB0aGUgZXhpc3RpbmcgYmVoYXZpb3IuDQo+ID4gDQo+ID4gU29tZSBhcmNoaXRlY3R1cmVzIGJl
bmVmaXQgZnJvbSBoYXZpbmcgYSBzaW5nbGUga25vd24gZW5kaWFubmVzcw0KPiA+IG9mIEpGRlMy
IGZpbGVzeXN0ZW0gKGZvciBkYXRhLCBub3QgZXhlY3V0YWJsZXMpIGluZGVwZW5kZW50IG9mIHRo
ZQ0KPiA+IGVuZGlhbm5lc3Mgb2YgdGhlIHByb2Nlc3NvciAoQVJNIHByb2Nlc3NvcnMgY2FuIGJl
IHN3aXRjaGVkIHRvIGVpdGhlcg0KPiA+IGVuZGlhbm5lc3MgYXQgcnVuLXRpbWUpLg0KPiA+IA0K
PiA+IFdlIGhhdmUgYm9hcmRzIHRoYXQgYXJlIHNoaXBwZWQgd2l0aCBCRSBqZmZzMiBhbmQgQkUg
a2VybmVsLiBXZSBhcmUNCj4gPiBub3cgbWlncmF0aW5nIHRvIExFIGtlcm5lbC4gVGhpcyBtb3Vu
dCBvcHRpb24gaGVscHMgdXMgaW4gbW91bnRpbmcNCj4gPiBCRSBqZmZzMiBvbiBMRSBrZXJuZWwu
DQo+IA0KPiBUaGFua3MgZm9yIGltcGxlbWVudGluZyB0aGlzLiBKRkZTMiBoYXMgb2Z0ZW4gYmVl
biB2ZXJ5IHNlbnNpdGl2ZSB0bw0KPiBwZXJmb3JtYW5jZSBhdCBtb3VudCB0aW1lIOKAlCBJJ2Qg
bG92ZSB0byBzZWUgaG93IHRoaXMgYWZmZWN0cyB0aGUgdGltZQ0KPiB0YWtlbiB0byBtb3VudCBh
IGxhcmdlIGZpbGUgc3lzdGVtLiBJZiBpdCdzIHNpZ25pZmljYW50LCB3ZSBtYXkgd2FudCBhDQo+
IGNvbmZpZyBvcHRpb24gdG8gbWFrZSB0aGlzIGNvbmRpdGlvbmFsPw0KDQpZZXMsIHRoaXMgbWF5
IHNsb3cgdGhpbmdzIGRvd24uIEkgYW0gbm90IHN1cmUgSSBhZ3JlZSB3aXRoIHRoZSBpbXBsLiBl
aXRoZXIuDQpDb3VsZCBvbmUgbm90IG1ha2UgY3B1X3RvX2plX1gvamVYX3RvX2NwdSBhIGZ1bmN0
aW9uIHB0ciB3aGljaCBpcyBzZXQgdG8NCmEgZnVuYy4gd2l0aCB0aGUgY29ycmVjdCBlbmRpYW4/
DQoNClRoYXQgd2F5IGl0IHNob3VsZCBhbHNvIGJlIGVhc3kgdG8gaGF2ZSBhIGNvbmZpZyBvcHRp
b24gZm9yIGVuZGlhbjogTmF0aXZlL0JFL0xFIG9yIER5bmFtaWMNCg0KIEpvY2tlDQo=
