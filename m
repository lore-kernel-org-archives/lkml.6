Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FABC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D9320839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KJLo1H2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D9320839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeILAYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:24:05 -0400
Received: from mail-eopbgr680072.outbound.protection.outlook.com ([40.107.68.72]:63815
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726743AbeILAYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCqnqj55NBys6Xgpr/SJM1KPYpliTXNgahiTjWbbrGo=;
 b=KJLo1H2hffq6IStGw3hszYxBCHbNIBCP+awX+gPph/VH5praEaD53h8LjK4ctlWaRMrP9S/4ZhgAwzMZDkRnZMFzlftoRFwXTsO860qVs1nvxSpCH4Q3fhL+aq6OxobEvLmqBgvzXA1sGTVtiQi22fKlpZocBGcWi0+52WNDLuM=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1317.namprd02.prod.outlook.com (10.161.170.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Tue, 11 Sep 2018 19:20:20 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a%4]) with mapi id 15.20.1122.019; Tue, 11 Sep 2018
 19:20:18 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Olof Johansson <olof@lixom.net>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: RE: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
Thread-Topic: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
Thread-Index: AQHUK1L7QuzmZ44/ikWDKXlbsDGCKaTnX36AgAK/pTCAAUtNAIAARu/g
Date:   Tue, 11 Sep 2018 19:20:18 +0000
Message-ID: <CY1PR02MB2138254CC5B1C2B2D41AB725B8040@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
 <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
 <CY1PR02MB2138BF2252E1CE2C1747A78AB8050@CY1PR02MB2138.namprd02.prod.outlook.com>
 <CAOesGMhViv_D6GKYf3x02LGqthwEsfkUFWBdG7pCQqD2MGsEew@mail.gmail.com>
In-Reply-To: <CAOesGMhViv_D6GKYf3x02LGqthwEsfkUFWBdG7pCQqD2MGsEew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1317;6:O9+51Dr6GHE5tTk3z2LAy2XKEpdlm6V1Er5qqJAgKERlXFH7j1PMlzBFFURKqSexmVd8rsw+Ogu1CDHhenC+0nhlKQfM5A375RTY+Th4RIT38pkjvoLNiF0Ia1H+9+5c3xAvyEZb2IqFMH2GHh5BwcVRFN68wof7LxZD/5OQPlxTvQGrTg3+ks+9EBW/18bDkhohWGZvZxL4PPsQyS+DSmXdJIGgkL09IidzF1haKhm19vkrweFPDYqj6qNptl+Cv7QGRboEg8yj8NHJgdotCmZF6RSTwyHGM6wUdHDiCx2jqUDK+Kp1mDeUzXLr43q8LEDKvvC/tLZOkeaFoFrQtjnkOYIATksIpzR2FZaref8BbUnA5O81XvbF51NIRKzPGKvr/hWd+QQ4aS/xmYjcrpGDCe13xZbPCGPrZ2btGVFnj2/+yQuoheuJeeBQTumVSSfR+214VkehJzmCTCRiyw==;5:5V+QZU+1bQVBQC7UHrAkNvF8fzHg+KyV90Bjw7O/RdxrNCOzPRlfzXMvhGyiyCbsNJmXX3N8H3sA/uboa2yw0QWZ5fOfkd1OU/hD+2UM6JOhDRvXDKl1gzJ695O1H4qw7Jsm4jPyZyUxgLIz2ke8gl3wVBMQQ0ivp88DAYwhMz0=;7:W5l/wyYHUzI5LACRFqo8huyfcU45QXQ3Zikjy0ONKGo6HxahKVx+1xQlRdGF9MYo1Y7ksmQJldX8dQc3dz1fKrlqwYb1KzCy5asJCJWyq/nGHIpKeDK26kw6pBrcDbBs/KV4VpJo1Jdy7PcJwq43P7A0EybHwii5IXGN98fZPimTPAfwfDQMWm028gehYqVbSXctBEqaIOHqAJfFcWWf8MnbbFLbYoVWqQ+CCWv//2vfeujzTz5utxrCnODyVrGB
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(366004)(13464003)(189003)(199004)(53754006)(446003)(81156014)(11346002)(81166006)(305945005)(8676002)(39060400002)(6116002)(486006)(476003)(25786009)(7416002)(6246003)(4326008)(7736002)(5250100002)(74316002)(2900100001)(97736004)(3846002)(106356001)(5660300001)(105586002)(33656002)(93886005)(72206003)(478600001)(7696005)(68736007)(8936002)(76176011)(99286004)(66066001)(217873002)(55016002)(14454004)(14444005)(186003)(6506007)(102836004)(229853002)(26005)(53546011)(6436002)(53936002)(9686003)(86362001)(316002)(54906003)(256004)(2906002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1317;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 946be7b0-336a-4843-87e9-08d6181b9c86
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1317;
x-ms-traffictypediagnostic: CY1PR02MB1317:
x-microsoft-antispam-prvs: <CY1PR02MB1317E7E979EF3095DF7804FAB8040@CY1PR02MB1317.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699050);SRVR:CY1PR02MB1317;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1317;
x-forefront-prvs: 0792DBEAD0
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hAYOM19rP58sGMqoyoiak63EJOzYMrkBkgrPzrhENZemYLfnS9r61UO+0J5OoIfl9eVh4QTjkQHWMZxWSSaOBHfZqhn4FER6iGdg91x9zzDQ9SKjtkjx2Efyj0zDgIzRYgKU/i+5lzrqZx1LWkQkSXA3ELqt7BQb29YJc6MbN6Y8JH5na2Cz3P2sp72fAWWFhKcp0Ep7YZGtZWIVUzQNsEpqKpSNKE99cN8eKlhUljgB/Ys68fP5umjnpTwwFTWTGQhBZU0Z5p0pKWQq/9P4mDz0TJ8429wAzsdqJ18CSd10r36H4cZAAIKimIPyrjjx4UNMl9gzqU/LKAr/5Kysc8Fk9M2GuVj8m/3kgJtiBMA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946be7b0-336a-4843-87e9-08d6181b9c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 19:20:18.7812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VkZWVwIGFuZCBPbG9mLA0KDQpDbG9jayBkcml2ZXIgZnJvbSBzYW1lIHBhdGNoIHNldCB1
c2VzIGlvY3RsIEFQSSBhbG9uZyB3aXRoIG90aGVyIGNsb2NrIGVlbWkgQVBJcy4gQXMgY2xvY2sg
cGF0Y2hlcycgZmluYWwgcmV2aWV3IGlzIHBlbmRpbmcgYnkgU3RlcGhlbiwgTWljaGFsIG9ubHkg
Y3JlYXRlZCBwdWxsIHJlcXVlc3QgZm9yIHJlc3Qgb2YgdGhlIHBhdGNoZXMgYW5kIHRoYXQgZG9l
c24ndCByZXF1aXJlIGlvY3RsIGFwaS4gSSB3aWxsIHJlbW92ZSBpdCBhbmQgc3VibWl0IG5ldyBw
YXRjaCBzZXQuDQoNCkZvciBmdXR1cmUgcGF0Y2hlcyB3aGljaCByZXF1aXJlcyBpb2N0bCBhcGks
IHdvdWxkIGxpa2UgdG8gdW5kZXJzdGFuZCB5b3VyIHN1Z2dlc3Rpb24gc28gSSBjYW4gbWFrZSBy
ZXF1aXJlZCBjaGFuZ2VzLiBGb3IgenlucW1wLCBFRU1JIGludGVyZmFjZSBhbGxvd3MgY2xvY2ss
IHJlc2V0LCBwb3dlciBldGMgbWFuYWdlbWVudCB0aHJvdWdoIGZpcm13YXJlIGJ1dCBhcGFydCBm
cm9tIHRob3NlIHRoZXJlIGFyZSBzb21lIG9wZXJhdGlvbnMgd2hpY2ggbmVlZHMgc2VjdXJlIGFj
Y2VzcyB0aHJvdWdoIGZpcm13YXJlLiBFeGFtcGxlcyBhcmUgYWNjZXNzaW5nIHNvbWUgc3RvcmFn
ZSByZWdpc3RlcnMgZm9yIGludGVyIGFnZW50IGNvbW11bmljYXRpb24sIGNvbmZpZ3VyaW5nIGFu
b3RoZXIgYWdlbnQoUlBVKSBtb2RlLCBzZXR0aW5nIFBMTCBwYXJhbWV0ZXJzLCBib290IGRldmlj
ZSBjb25maWd1cmF0aW9uIGV0Yy4gVGhvc2Ugb3BlcmF0aW9ucyBhcmUgY292ZXJlZCBhcyBpb2N0
bHMgYXMgdGhleSBhcmUgdmVyeSBwbGF0Zm9ybSBzcGVjaWZpYy4gRG8geW91IHN1Z2dlc3QgdG8g
aGFuZGxlIHRoZW0gd2l0aCBpbmRpdmlkdWFsIEVFTUkgQVBJcyBpbnN0ZWFkIG9mIGlvY3RsIEFQ
ST8NCg0KVGhhbmtzLA0KSm9sbHkgU2hhaA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogT2xvZiBKb2hhbnNzb24gW21haWx0bzpvbG9mQGxpeG9tLm5ldF0NCj4gU2Vu
dDogVHVlc2RheSwgU2VwdGVtYmVyIDExLCAyMDE4IDg6MDMgQU0NCj4gVG86IEpvbGx5IFNoYWgg
PEpPTExZU0B4aWxpbnguY29tPg0KPiBDYzogYXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZzsgSW5n
byBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+OyBHcmVnIEtyb2FoLQ0KPiBIYXJ0bWFuIDxncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZz47IG1hdHRAY29kZWJsdWVwcmludC5jby51azsgU3VkZWVw
DQo+IEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47IGhrYWxsd2VpdDFAZ21haWwuY29tOyBL
ZWVzIENvb2sNCj4gPGtlZXNjb29rQGNocm9taXVtLm9yZz47IERtaXRyeSBUb3Jva2hvdiA8ZG1p
dHJ5LnRvcm9raG92QGdtYWlsLmNvbT47DQo+IE1pY2hhZWwgVHVycXVldHRlIDxtdHVycXVldHRl
QGJheWxpYnJlLmNvbT47IFN0ZXBoZW4gQm95ZA0KPiA8c2JveWRAY29kZWF1cm9yYS5vcmc+OyBN
aWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IFJvYiBIZXJyaW5nDQo+IDxyb2JoK2R0
QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgbGludXgt
Y2xrDQo+IDxsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnPjsgUmFqYW4gVmFqYSA8UkFKQU5WQHhp
bGlueC5jb20+OyBMaW51eCBBUk0NCj4gTWFpbGluZyBMaXN0IDxsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgRFRNTCA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjExIDAzLzExXSBmaXJtd2FyZTogeGlsaW54OiBBZGQg
enlucW1wIElPQ1RMIEFQSSBmb3INCj4gZGV2aWNlIGNvbnRyb2wNCj4gDQo+IEhpIEpvbGx5LA0K
PiANCj4gT24gTW9uLCBTZXAgMTAsIDIwMTggYXQgMTI6MTcgUE0sIEpvbGx5IFNoYWggPEpPTExZ
U0B4aWxpbnguY29tPiB3cm90ZToNCj4gPiBIaSBBbGwsDQo+ID4NCj4gPiBBZGRpbmcgbW9yZSBj
bGFyaWZpY2F0aW9uIG9uIHRvcCBvZiB3aGF0IE1pY2hhbCBzYWlkOg0KPiA+IEhlcmUgaW9jdGwg
aXMgbm90IGEgc3lzdGVtIGlvY3RsIGFuZCBqdXN0IGEgZWVtaSBBUEkgbGlrZSBvdGhlciBpbnRl
cmZhY2UgQVBJcy4gSXQNCj4gY2Fubm90IGJlIGNhbGxlZCBmcm9tIHVzZXJzcGFjZS4gT25seSBM
aW51eCBkcml2ZXJzIGNhbiB1c2UgdGhpcyBBUEkgZm9yIGRlZmluZWQNCj4gaW9jdGwgb3BlcmF0
aW9ucy4gVGhpcyBBUEkgaXMgbWVhbnQgZm9yIGFueSBwbGF0Zm9ybSBzcGVjaWZpYyBvcGVyYXRp
b25zIHdoaWNoDQo+IG5lZWRzIHRvIGJlIG1hbmFnZWQgYnkgZmlybXdhcmUuIEZpcm13YXJlIHdp
bGwgYWx3YXlzIHZhbGlkYXRlIHRoZSByZXF1ZXN0IGZvcg0KPiBhY3Rpb24gYmVpbmcgcGVyZm9y
bWVkLg0KPiA+IERlYnVnZnMgaW50ZXJmYWNlIGlzIGp1c3QgZm9yIGRlYnVnZ2luZyBkdXJpbmcg
ZGV2ZWxvcG1lbnQuIFdlIGNhbiByZW1vdmUNCj4gZGVidWdmcyBzdXBwb3J0IGZvciBpb2N0bCBB
UEkgaWYgeW91IHN1Z2dlc3QuDQo+IA0KPiBBcmUgdGhlcmUgYW55IHBlbmRpbmcgcGF0Y2hzZXRz
IHRoYXQgbWFrZSB1c2Ugb2YgdGhlIGlvY3RsIGludGVyZmFjZSBiZXNpZGVzIHRoZQ0KPiBkZWJ1
Z2ZzIHBpZWNlPyBOb25lIG9mIHRoZSBvbmVzIGluIHRoaXMgcHVsbCByZXF1ZXN0IChiZXNpZGVz
IHRoZSBkZWJ1Z2ZzKSBzZWVtcw0KPiB0byBjYWxsIGludG8gaXQuDQo+IA0KPiBJdCBtaWdodCBq
dXN0IGJlIGVhc2llciB0byBsZWF2ZSBpdCBvdXQgdW50aWwgeW91IGhhdmUgYSB1c2UgY2FzZSBm
b3IgaXQuIFRoZSByZXN0IG9mDQo+IHRoZSBwYXRjaHNldCBsb29rcyBmaW5lIHRvIG1lLCBhbmQg
SSdkIGJlIGhhcHB5IHRvIHRha2UgaXQuIE9uY2UgeW91IGhhdmUgYSBuZWVkDQo+IGZvciBpdCB3
ZSBjYW4gZGlzY3VzcyBzcGVjaWZpY3MuDQo+IA0KPiANCj4gLU9sb2YNCg==
