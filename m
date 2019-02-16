Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DFBC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 17:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B31A222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 17:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w05Oka0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbfBPRV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 12:21:57 -0500
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:20944
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbfBPRV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 12:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrrtgL10USrU8z5bVzmeLL2+2JT/cJ32zGarC0vfZhg=;
 b=w05Oka0bX3+rNL2CLDG9YHuN44H5ACObU9U2hfwkwEwNkAUtrXW+aeISY30YQle5sSZCdvaMu6vg+JL8y1BtlXabEJ1vrtuNYeNniVj/pSVa8tEvMQPNsfpX/JlZnKVoyi5HRVEDG+rDdhavHf4RvG7HrzM+cwSQyvLfza/C1bw=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3529.namprd12.prod.outlook.com (20.179.106.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Sat, 16 Feb 2019 17:21:53 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::2809:46:d708:b9c1]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::2809:46:d708:b9c1%5]) with mapi id 15.20.1622.016; Sat, 16 Feb 2019
 17:21:53 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Joao Pinto <joao.pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: Fix NAPI poll in TX path when
 in multi-queue
Thread-Topic: [PATCH net-next 1/3] net: stmmac: Fix NAPI poll in TX path when
 in multi-queue
Thread-Index: AQHUxTRM9W3Erm9V4kWPAI2fSgGxB6XhlMGAgAEZCYA=
Date:   Sat, 16 Feb 2019 17:21:53 +0000
Message-ID: <d3f2bd0a-bc2c-a340-17bc-58356bd7a6a9@amd.com>
References: <cover.1550237884.git.joabreu@synopsys.com>
 <76da803a662214b024bfdb95731c38e45aef426d.1550237884.git.joabreu@synopsys.com>
 <c6a38836-a0d7-608d-39cf-ea770db78c95@gmail.com>
In-Reply-To: <c6a38836-a0d7-608d-39cf-ea770db78c95@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0081.namprd12.prod.outlook.com
 (2603:10b6:802:21::16) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5b766cf-5f3e-4008-e9c9-08d694333e8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3529;
x-ms-traffictypediagnostic: DM6PR12MB3529:
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3529;20:jL4T6EJfzcOn1Wy/jcrldFpzbpNH64hOKxWVP2JynpVzcoijxCeeutS/KjU9cjDmKv2t/AqqTxH5d2saX4/pD52ValFwrtl7EP1WqL4Z8/bYaNVim3xH2Oaa22Zyy+CHbNd40ClDd2A7JA+7ZR9c5M3RdlYBkU793XFEO5A5B/VOhhno1Y1VZp4+rYifUWB+wskkFFcroY7N3dC0m1sgr8+4dzXOzh8BoGHPyp/KKXKMk6kb3udCILGYWio5FcNW
x-microsoft-antispam-prvs: <DM6PR12MB3529BCA81A6BC0F74F4C9FB7EC610@DM6PR12MB3529.namprd12.prod.outlook.com>
x-forefront-prvs: 0950706AC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39850400004)(199004)(189003)(5660300002)(54906003)(7736002)(110136005)(3846002)(66066001)(2201001)(105586002)(316002)(102836004)(186003)(386003)(36756003)(31686004)(6506007)(6512007)(86362001)(6116002)(106356001)(31696002)(53546011)(26005)(53936002)(446003)(305945005)(25786009)(478600001)(81156014)(256004)(2616005)(8936002)(14454004)(71200400001)(71190400001)(6246003)(11346002)(97736004)(476003)(229853002)(99286004)(2501003)(486006)(6436002)(52116002)(2906002)(8676002)(76176011)(68736007)(4326008)(6486002)(81166006)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3529;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tFkmmQwG/9UUvXMkwgeL4KYePSRkqB6QblYxj5LYr5zgXScU2NGF8zkmWX2joBG1Ha4PacbeNrK1V8eD84U1fcyAtKUx6krda8X2d1khlVRjQ4liz2iWp4yxdDam8QB0abKylRRrkTnEd4iWGowG8kEt6Gq8jzIQLJybXZaKGzPMwepRkp5I6bucE3fTX5NVgTs22HGsjnI7pG41fcF6pJd/JCz6LFDGeQ+LKEqMQY+pVYay5sSNavJjcnPZrYHMHs2K8mZmdqkLeyRhmhcYgeSa/B5FRn/O9p30wJNFCTxOu6k/hEl1HYucU1KOX5MWXIQtShn2ZnJ44sxwzT554aiNBG81N4EskoBUosOIaEsN6moUsS6d4UlAA5H2Z1TgMCg0sv/9UunfhKdGMFDo2fdRvOpUD4DKeQjNFFENKcc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A60EFC9E637B5408B3684651108680C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b766cf-5f3e-4008-e9c9-08d694333e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2019 17:21:52.0349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3529
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIvMTUvMTkgNjozNSBQTSwgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToNCj4gT24gMi8x
NS8xOSA1OjQyIEFNLCBKb3NlIEFicmV1IHdyb3RlOg0KPj4gQ29tbWl0IDhmY2UzMzMxNzAyMyBp
bnRyb2R1Y2VkIHRoZSBjb25jZXB0IG9mIE5BUEkgcGVyLWNoYW5uZWwgYW5kDQo+PiBpbmRlcGVu
ZGVudCBjbGVhbmluZyBvZiBUWCBwYXRoLg0KPj4NCj4+IFRoaXMgaXMgY3VycmVudGx5IGJyZWFr
aW5nIHBlcmZvcm1hbmNlIGluIHNvbWUgY2FzZXMuIFRoZSBzY2VuYXJpbw0KPj4gaGFwcGVucyB3
aGVuIGFsbCBwYWNrZXRzIGFyZSBiZWluZyByZWNlaXZlZCBpbiBRdWV1ZSAwIGJ1dCB0aGUgVFgg
aXMNCj4+IHBlcmZvcm1lZCBpbiBRdWV1ZSAhPSAwLg0KPj4NCj4+IEZpeCB0aGlzIGJ5IHVzaW5n
IGRpZmZlcmVudCBOQVBJIGluc3RhbmNlcyBwZXIgZWFjaCBUWCBhbmQgUlggcXVldWUsIGFzDQo+
PiBzdWdnZXN0ZWQgYnkgRmxvcmlhbi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb3NlIEFicmV1
IDxqb2FicmV1QHN5bm9wc3lzLmNvbT4NCj4+IENjOiBGbG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5l
bGxpQGdtYWlsLmNvbT4NCj4+IENjOiBKb2FvIFBpbnRvIDxqcGludG9Ac3lub3BzeXMuY29tPg0K
Pj4gQ2M6IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4NCj4+IENjOiBHaXVz
ZXBwZSBDYXZhbGxhcm8gPHBlcHBlLmNhdmFsbGFyb0BzdC5jb20+DQo+PiBDYzogQWxleGFuZHJl
IFRvcmd1ZSA8YWxleGFuZHJlLnRvcmd1ZUBzdC5jb20+DQo+PiAtLS0NCj4gDQo+IFtzbmlwXQ0K
PiANCj4+IC0JaWYgKHdvcmtfZG9uZSA8IGJ1ZGdldCAmJiBuYXBpX2NvbXBsZXRlX2RvbmUobmFw
aSwgd29ya19kb25lKSkgew0KPj4gLQkJaW50IHN0YXQ7DQo+PiArCXByaXYtPnhzdGF0cy5uYXBp
X3BvbGwrKzsNCj4+ICAgDQo+PiArCXdvcmtfZG9uZSA9IHN0bW1hY190eF9jbGVhbihwcml2LCBi
dWRnZXQsIGNoYW4pOw0KPj4gKwlpZiAod29ya19kb25lIDwgYnVkZ2V0ICYmIG5hcGlfY29tcGxl
dGVfZG9uZShuYXBpLCB3b3JrX2RvbmUpKQ0KPiANCj4gWW91IHNob3VsZCBub3QgYmUgYm91bmRp
bmcgeW91ciBUWCBxdWV1ZSBhZ2FpbnN0IHRoZSBOQVBJIGJ1ZGdlLCBpdA0KPiBzaG91bGQgcnVu
IHVuYm91bmQgYW5kIGNsZWFuIGFzIG11Y2ggYXMgaXQgY2FuLCB3aGljaCBjb3VsZCBiZSB0aGUN
Cj4gZW50aXJlIHJpbmcgc2l6ZSBpZiB0aGF0IGlzIGhvdyBtYW55IHBhY2tldHMgeW91IHB1c2hl
ZCBiZXR3ZWVuDQo+IGludGVycnVwdHMuIFRoYXQgY291bGQgYmUgdGhlIGNhdXNlIG9mIHBvb3Ig
cGVyZm9ybWFuY2UgYXMgd2VsbC4NCg0KV29uJ3QgcmV0dXJuaW5nIHRoZSBidWRnZXQgdmFsdWUg
Y2F1c2UgdGhpcyBuYXBpX3BvbGwgcm91dGluZSB0byBiZSBjYWxsZWQNCmFnYWluLCB3aGVyZSB0
aGUgZHJpdmVyIGNhbiBjb250aW51ZSB0byBjbGVhbiBUWCBwYWNrZXRzPyBJIHRob3VnaHQgdGhp
cw0KanVzdCBnaXZlcyBvdGhlciBkcml2ZXJzIHRoZSBvcHBvcnR1bml0eSB0byBydW4gdGhlaXIg
bmFwaV9wb2xsIHJvdXRpbmVzDQppbiBiZXR3ZWVuIHNvIGFzIG5vdCB0byBiZSBzdGFydmVkLg0K
DQpUaGFua3MsDQpUb20NCg0KPiANCg==
