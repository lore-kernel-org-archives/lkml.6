Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADD2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4690E20684
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZiDeLGpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4690E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbeGROQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:16:47 -0400
Received: from mail-sg2apc01on0105.outbound.protection.outlook.com ([104.47.125.105]:9952
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbeGROQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZSXZabI1YJtKhtU2QO//DBYAtMnhTIJV4Alqc6mPXA=;
 b=ZiDeLGpg0biBX/okq6ch9x3aNKEgqiOPsuIEC8bXrC0hCLGbPiFLV3bbDuLGKz3Ar1hvVJip/6SvElGACB17LkN76spLzlXTnSAwXHXCtvvuqNb7KXKbmghJVKZipg/DgPcnEMMmKu+zUdH6bZomSBFt28+EsFRugh1brnjxEK0=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0031.APCP153.PROD.OUTLOOK.COM (10.170.136.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.6; Wed, 18 Jul 2018 13:38:39 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0995.008; Wed, 18 Jul 2018
 13:38:39 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH V2 3/5] KVM/VMX: Add identical ept table pointer check
Thread-Topic: [PATCH V2 3/5] KVM/VMX: Add identical ept table pointer check
Thread-Index: AQHUF2ObcQUYklsGuUOa1wlPU7D6rKSU7q0AgAAbxIA=
Date:   Wed, 18 Jul 2018 13:38:38 +0000
Message-ID: <2b0476a7-cb4e-2ced-bbfa-5a72fe523880@microsoft.com>
References: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
 <20180709090218.15342-4-Tianyu.Lan@microsoft.com>
 <8326ebac-ea35-3e26-ae6a-e57b73e07783@redhat.com>
In-Reply-To: <8326ebac-ea35-3e26-ae6a-e57b73e07783@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0031;6:84eR99AsDQNF7cblyZEG3AVcmnurEnqE+jLaRtN92obP/xqdwjN4hxy/qKY8YxRweMyVWXN+MfTZSsuasfsUGcvvKIodvUrSTPNmFlEFOjkRMqIbupDRViSsc3Sf4pVe0483uJU8NTSQiiNyL9Ngdu5LDmwgiNVhz+uR3EjACiYt5TLNmQxB64d95X8kr8jhyEooxHhXoKq5OMRzE7ddtHxzefVodBwBJ4rDXI+C7Iygp1R/BkBhJgcpklP8HUuntop0hoam2/iJ1gQ+enWphBTluHKUS9//ieX6sES//n3U2+KXGXD/LtJlDWWUjcOg8+CySnbcxH4x8MSlSIGme21AUk1zcVCPIwd7IjyKQqLIFb6LMDmfxUBftxh0NcDunuVW5karPVKzPP+ZM4QNI3M1i36MUSuYti8v32djsm6Xiy+DroTS/Ypvk4kXKeW4Tk4cAmbivz/mMZbA0sFJRQ==;5:+sH6oyOLHsjE3Y2PFuVjMrqnAfzbVYo8kiWlG1Zg4/DjySY5+YWHMt1rNWdH+Nu+gTOC6UkLGWlyqTFeQjoACNLMACv+SuMK7yYTtwIYS32wlo84CdvRqkCrxJBwnhxEuyfySymbqLZ6xVIB8M0w6VJ1dI+J3IQ3Gnt+NXQ4gqo=;7:0EBHPFEW7ukPOqpH5vlsiu0o31wjDtNdfUkUcP2whK6m8UsiyAXgcHRjt139EH/D4UoUSREzYLdxynzZuYK3Vx1Mx5iooq6dCu1cBgZPZL9GOHjAhxz8yx63lYWVnCG0if1vck7FJkXTBY9C4D60RWjLBqHmk4GlGzyw1tRIwDflnHGG/Rc/XoIj6C5BLIshPXQM85ZMx/9mEr1Jfik7qxvQURMu0i/WSuVcQlW/M00GeDku44xu0LOZiaTquGWg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 767e586f-4961-404a-3c73-08d5ecb3c529
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0031;
x-ms-traffictypediagnostic: SG2P15301MB0031:
x-microsoft-antispam-prvs: <SG2P15301MB00317FDA3412152B58E32DC792530@SG2P15301MB0031.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0031;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0031;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(10290500003)(446003)(229853002)(6436002)(36756003)(10090500001)(31686004)(478600001)(26005)(6116002)(102836004)(2906002)(68736007)(6512007)(6486002)(72206003)(2900100001)(5250100002)(106356001)(97736004)(3846002)(11346002)(76176011)(186003)(6506007)(14444005)(105586002)(25786009)(305945005)(256004)(7416002)(316002)(8936002)(8676002)(2616005)(53936002)(22452003)(81156014)(54906003)(110136005)(5660300001)(86362001)(99286004)(81166006)(86612001)(7736002)(31696002)(476003)(486006)(4326008)(1511001)(14454004)(6246003)(66066001)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0031;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ce/IgwDqV8YB52yuojLTDuYuCHyr24xaCDYbGV2JJp2TIhrdUcekfqtOrF1hQah9zqo5bs3/5c8j+97BItRTVEMDxehlTl4uE+cI8O07MrT+1dFTYQmYAlOiRL61NYbrDujAaB07MSApIaVtMemcpRqlNsHtpIZK/z3PeL19UeCOtKe8FerT9qDEGQs1mSkxfa0hwVzsxTqiLQvmGTdlMUWjkldMSwnyJDii2+du+hEKxFBtUCZ5v+wR1ZnovReu/JLz1sZYUKAPdXaEyU67JvQLjMP8cvkhFlz9YQKhGl89dUVf5R3eLadoAX/xU8RQ8tgub0HXYX7GsJm4Y5yIgWtnYN49XlLuaDW/iVgkQIs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F521C52F8A8D40469CDF75D5672A6BDB@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767e586f-4961-404a-3c73-08d5ecb3c529
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 13:38:38.9684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xOC8yMDE4IDc6NTkgUE0sIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+IE9uIDA5LzA3LzIw
MTggMTE6MDIsIFRpYW55dSBMYW4gd3JvdGU6DQo+PiArc3RhdGljIHZvaWQgY2hlY2tfZXB0X3Bv
aW50ZXIoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1NjQgZXB0cCkNCj4+ICt7DQo+PiArCXN0cnVj
dCBrdm0gKmt2bSA9IHZjcHUtPmt2bTsNCj4+ICsJdTY0IHRtcF9lcHRwID0gSU5WQUxJRF9QQUdF
Ow0KPj4gKwlpbnQgaTsNCj4+ICsNCj4+ICsJaWYgKCFrdm1feDg2X29wcy0+dGxiX3JlbW90ZV9m
bHVzaCkNCj4+ICsJCXJldHVybjsNCj4+ICsNCj4+ICsJc3Bpbl9sb2NrKCZ0b19rdm1fdm14KGt2
bSktPmVwdF9wb2ludGVyX2xvY2spOw0KPj4gKwl0b192bXgodmNwdSktPmVwdF9wb2ludGVyID0g
ZXB0cDsNCj4+ICsNCj4+ICsJa3ZtX2Zvcl9lYWNoX3ZjcHUoaSwgdmNwdSwga3ZtKSB7DQo+PiAr
CQlpZiAoIVZBTElEX1BBR0UodG1wX2VwdHApKSB7DQo+PiArCQkJdG1wX2VwdHAgPSB0b192bXgo
dmNwdSktPmVwdF9wb2ludGVyOw0KPj4gKwkJfSBlbHNlIGlmICh0bXBfZXB0cCAhPSB0b192bXgo
dmNwdSktPmVwdF9wb2ludGVyKSB7DQo+PiArCQkJdG9fa3ZtX3ZteChrdm0pLT5lcHRfcG9pbnRl
cnNfbWF0Y2ggPSBmYWxzZTsNCj4+ICsJCQlzcGluX3VubG9jaygmdG9fa3ZtX3ZteChrdm0pLT5l
cHRfcG9pbnRlcl9sb2NrKTsNCj4+ICsJCQlyZXR1cm47DQo+PiArCQl9DQo+PiArCX0NCj4+ICsN
Cj4+ICsJdG9fa3ZtX3ZteChrdm0pLT5lcHRfcG9pbnRlcnNfbWF0Y2ggPSB0cnVlOw0KPj4gKwlz
cGluX3VubG9jaygmdG9fa3ZtX3ZteChrdm0pLT5lcHRfcG9pbnRlcl9sb2NrKTsNCj4+ICt9DQo+
PiArDQo+IA0KPiBJcyB0aGVyZSBhbnkgcmVhc29uIHRvIGRvIHRoZSBjaGVjayBoZXJlLCByYXRo
ZXIgdGhhbiB0aGUgZmlyc3QgdGltZSB0aGUNCj4gVExCIGZsdXNoIGlzIGludm9rZWQ/ICBZb3Ug
Y291bGQ6DQo+IA0KPiAtIGhhdmUgYSB0cmlzdGF0ZSAodHJ1ZSwgZmFsc2UsIGNoZWNrKSB2YWx1
ZSBmb3IgZXB0X3BvaW50ZXJzX21hdGNoDQo+IA0KPiAtIHJlc2V0IGl0IHRvICJjaGVjayIgaW4g
dm14X3NldF9jcjMNCj4gDQo+IC0gc2V0IGl0IHRvIGVpdGhlciB0cnVlIG9yIGZhbHNlIGluIHRs
Yl9yZW1vdGVfZmx1c2ggaWYgaXQgaXMgY2hlY2ssIGFuZA0KPiBkbyB0aGUgaHlwZXJjYWxsIGlm
IGl0IGlzIHRydWUuDQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4gV2lsbCB1cGRh
dGUuDQoNCj4gUGFvbG8NCj4g
