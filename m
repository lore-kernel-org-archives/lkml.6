Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB98CECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E1B2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VJyY9TlX";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Y/L248cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E1B2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeJTGL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 02:11:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60852 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbeJTGL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 02:11:58 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9JLsbtF029009;
        Fri, 19 Oct 2018 15:03:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dLeQPCUVKrkevWCO2ScNAxBDeRmpFKm6jbmP84Rtr/4=;
 b=VJyY9TlXjaHCMqjB8HFOpMOvgsTGM/KlJx4iJdxPMsZnaeFmcGuiZR0UTzb2NRzCD6iw
 uECG6n+aWvl5uHsYXMgklZN5wYItJ70AW6VNMztXZCSGZnf0kY5nR3/0iEnZxEJq/YJq
 brIpr/VbS5DLVkbWVlK5gsdplYQLvXPVOzs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n7qdw81u8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 19 Oct 2018 15:03:57 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 19 Oct 2018 15:03:42 -0700
Received: from PRN-CHUB03.TheFacebook.com (2620:10d:c081:35::12) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 19 Oct 2018 15:03:42 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 19 Oct 2018 15:03:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLeQPCUVKrkevWCO2ScNAxBDeRmpFKm6jbmP84Rtr/4=;
 b=Y/L248csYKzpBYUApd2PYEhp0lFrLjUiDGnl+ZdG4QrZlVfvm4wiKPgy+6gi+oFxTuB7m3kwvURKUe+x0aGuErZ5fYH86pLmMA2b3BClc3jJ/FimGpLNkr03FQC7c2uSAu1as2AfzVn70asC25HBENkdA+PrCHMqRzwHRqAYo50=
Received: from MWHPR15MB1264.namprd15.prod.outlook.com (10.175.3.14) by
 MWHPR15MB1262.namprd15.prod.outlook.com (10.175.3.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Fri, 19 Oct 2018 22:03:38 +0000
Received: from MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::bd3a:770a:b6ec:1521]) by MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::bd3a:770a:b6ec:1521%4]) with mapi id 15.20.1250.028; Fri, 19 Oct 2018
 22:03:38 +0000
From:   Calvin Owens <calvinowens@fb.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 1/3] printk: Introduce per-console loglevel setting
Thread-Topic: [PATCH 1/3] printk: Introduce per-console loglevel setting
Thread-Index: AQHTOLw+OVEsRasdjk6dUWix90EiMaUoDQSAgAFwpgA=
Date:   Fri, 19 Oct 2018 22:03:37 +0000
Message-ID: <20181019220314.GA8164@Haydn>
References: <08c1dc1a96afd6b6aecc5ff3c7c0e62c36670893.1506644730.git.calvinowens@fb.com>
 <20181019000403.GB877@jagdpanzerIV>
In-Reply-To: <20181019000403.GB877@jagdpanzerIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:301:1::19) To MWHPR15MB1264.namprd15.prod.outlook.com
 (2603:10b6:320:24::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:5329]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1262;20:qhHjl98IQ+ia/MXIwfV3XnP8k4CaLJq8iKqmRATrtz+XQjr1KD+i2LqmYTliSjc7BqkUq2wwe5pZFJbgGZBGLpneNxFsTwfGoYgBb53pVAv4Xp0d6XHLKzOytDA2ZfdSrsa9ZztBHyOIWynhFush6eyWPbsOjOoQVsKA4Xn8krI=
x-ms-office365-filtering-correlation-id: 1c5c787e-8343-41ac-80fd-08d6360eb837
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1262;
x-ms-traffictypediagnostic: MWHPR15MB1262:
x-microsoft-antispam-prvs: <MWHPR15MB1262027B61447ED71B14587ECEF90@MWHPR15MB1262.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(81227570615382);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(93006095)(93001095)(3231355)(11241501184)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1262;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1262;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(136003)(366004)(396003)(39850400004)(51354002)(199004)(189003)(54906003)(446003)(186003)(106356001)(11346002)(2900100001)(476003)(25786009)(53936002)(97736004)(6246003)(7736002)(6436002)(71200400001)(8936002)(81156014)(81166006)(316002)(33656002)(33716001)(5024004)(14444005)(486006)(386003)(46003)(6506007)(105586002)(256004)(71190400001)(86362001)(8676002)(305945005)(2906002)(6116002)(478600001)(52116002)(4326008)(14454004)(229853002)(5660300001)(33896004)(6916009)(76176011)(9686003)(6512007)(68736007)(102836004)(6486002)(1076002)(99286004)(5250100002)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1262;H:MWHPR15MB1264.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xzrG8y/fflM5jrNjyebQb9Bx0yao5mZM8KC5n6K6wXdk32ZgmW9hkYqVkzfGRp1082OuzWHbtfNj5WFZaHDiEX4jtsEjoEMYRFkRhOLw/aihHkuzWYQ5CKRCS0QQHPaq5ob1OLMiBwKf7HnguOzZunqXwZ9DyRIMyM3L3BrknEl5QnGGMvufQzjkGTjyoV7bcIR36pMjEqkgUwSdDLJlYyEJyKX1Z4CGc84GamDZEAJ/bsG5c3sJKmosamnFBBqIl7wH0KQt6cRhnAas1VSO95F3e60/19iPUNkdTcut2eHdZ1excJjOevFZGm8Agu6z8ItIdoczTVLwHV9X/DIsJx+Bt3UXX5ABjAAoiGdQIJ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F8513DD920FE742ADCB168FFA263534@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5c787e-8343-41ac-80fd-08d6360eb837
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 22:03:38.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1262
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-19_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpZGF5IDEwLzE5IGF0IDA5OjA0ICswOTAwLCBTZXJnZXkgU2Vub3poYXRza3kgd3JvdGU6
DQo+IE9uICgwOS8yOC8xNyAxNzo0MyksIENhbHZpbiBPd2VucyB3cm90ZToNCj4gPiBOb3QgYWxs
IGNvbnNvbGVzIGFyZSBjcmVhdGVkIGVxdWFsOiBkZXBlbmRpbmcgb24gdGhlIGFjdHVhbCBoYXJk
d2FyZSwNCj4gPiB0aGUgbGF0ZW5jeSBvZiBhIHByaW50aygpIGNhbGwgY2FuIHZhcnkgZHJhbWF0
aWNhbGx5LiBUaGUgd29yc3QgZXhhbXBsZXMNCj4gPiBhcmUgc2VyaWFsIGNvbnNvbGVzLCB3aGVy
ZSBpdCBjYW4gc3BpbiBmb3IgdGVucyBvZiBtaWxsaXNlY29uZHMgYmFuZ2luZw0KPiA+IHRoZSBV
QVJUIHRvIGVtaXQgYSBtZXNzYWdlLCB3aGljaCBjYW4gY2F1c2UgYXBwbGljYXRpb24tbGV2ZWwg
cHJvYmxlbXMNCj4gPiB3aGVuIHRoZSBrZXJuZWwgc3Bld3Mgb250byB0aGUgY29uc29sZS4NCj4g
PiANCj4gPiBBdCBGYWNlYm9vayB3ZSB1c2UgbmV0Y29uc29sZSB0byBtb25pdG9yIG91ciBmbGVl
dCwgYnV0IHdlIHN0aWxsIGhhdmUNCj4gPiBzZXJpYWwgY29uc29sZXMgYXR0YWNoZWQgb24gZWFj
aCBob3N0IGZvciBsaXZlIGRlYnVnZ2luZywgYW5kIHRoZSBsYXR0ZXINCj4gPiBoYXMgY2F1c2Vk
IHByb2JsZW1zLiBBbiBvYnZpb3VzIHNvbHV0aW9uIGlzIHRvIGRpc2FibGUgdGhlIGtlcm5lbA0K
PiA+IGNvbnNvbGUgb3V0cHV0IHRvIHR0eVMwLCBidXQgdGhpcyBtYWtlcyBsaXZlIGRlYnVnZ2lu
ZyBmcnVzdHJhdGluZywNCj4gPiBzaW5jZSBjcmFzaGVzIGJlY29tZSBzaWxlbnQgYW5kIG9wYXF1
ZSB0byB0aGUgdHR5UzAgdXNlci4gRW5hYmxpbmcgaXQgb24NCj4gPiB0aGUgZmx5IHdoZW4gbmVl
ZGVkIGlzbid0IGZlYXNpYmxlLCBzaW5jZSBib3hlcyB5b3UgbmVlZCB0byBkZWJ1ZyB2aWENCj4g
PiBzZXJpYWwgYXJlIGxpa2VseSB0byBiZSBib3JrZWQgaW4gd2F5cyB0aGF0IG1ha2UgdGhpcyBp
bXBvc3NpYmxlLg0KPiA+IA0KPiA+IFRoYXQgcHV0cyB1cyBiZXR3ZWVuIGEgcm9jayBhbmQgYSBo
YXJkIHBsYWNlOiB3ZSdkIGxvdmUgdG8gc2V0DQo+ID4ga2VybmVsLnByaW50ayB0byBLRVJOX0lO
Rk8gYW5kIGdldCBhbGwgdGhlIGxvZ3MuIEJ1dCB3aGlsZSBuZXRjb25zb2xlIGlzDQo+ID4gZmFz
dCBlbm91Z2ggdG8gcGVybWl0IHRoYXQgd2l0aG91dCBwZXJ0dXJiaW5nIHVzZXJzcGFjZSwgdHR5
UzAgaXMgbm90LA0KPiA+IGFuZCB3ZSdyZSBmb3JjZWQgdG8gbGltaXQgY29uc29sZSBsb2dnaW5n
IHRvIEtFUk5fV0FSTklORyBhbmQgaGlnaGVyLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggaW50cm9k
dWNlcyBhIG5ldyBwZXItY29uc29sZSBsb2dsZXZlbCBzZXR0aW5nLCBhbmQgY2hhbmdlcw0KPiA+
IGNvbnNvbGVfdW5sb2NrKCkgdG8gdXNlIG1heChnbG9iYWxfbGV2ZWwsIHBlcl9jb25zb2xlX2xl
dmVsKSB3aGVuDQo+ID4gZGVjaWRpbmcgd2hldGhlciBvciBub3QgdG8gZW1pdCBhIGdpdmVuIGxv
ZyBtZXNzYWdlLg0KPiA+IA0KPiA+IFRoaXMgbGV0cyB1cyBoYXZlIG91ciBjYWtlIGFuZCBlYXQg
aXQgdG9vOiBpbnN0ZWFkIG9mIGJlaW5nIGZvcmNlZCB0bw0KPiA+IGxpbWl0IGFsbCBjb25zb2xl
cyB2ZXJib3NpdHkgYmFzZWQgb24gdGhlIHNwZWVkIG9mIHRoZSBzbG93ZXN0IG9uZSwgd2UNCj4g
PiBjYW4gInByb21vdGUiIHRoZSBmYXN0ZXIgY29uc29sZSB3aGlsZSBzdGlsbCB1c2luZyBhIGNv
bnNlcnZhdGl2ZSBzeXN0ZW0NCj4gPiBsb2dsZXZlbCBzZXR0aW5nIHRvIGF2b2lkIGRpc3R1cmJp
bmcgYXBwbGljYXRpb25zLg0KPiANCj4gSGkgQ2FsdmluLA0KPiANCj4gRG8geW91IGhhdmUgdGlt
ZSB0byBhZGRyZXNzIHRoZSByZXZpZXcgZmVlZGJhY2sgYW5kIHJlLXNwaW4gdjI/DQoNCkhpIFNl
cmdleSwNCg0KSXQncyBpbi1wcm9ncmVzcywgSSdtIHNvcnJ5IGl0IGhhc24ndCBoYXBwZW5lZCBz
b29uZXIuDQoNCkJ5IGVtYmVkZGluZyB0aGUga29iamVjdCBpbiB0aGUgY29uc29sZSBzdHJ1Y3Qs
IHdlIGVuZCB1cCBuZWVkaW5nIHRvIHJlZmFjdG9yDQp0aGUgY29uc29sZSBkcml2ZXJzIHRvIHVz
ZSB0aGUga29iamVjdCByZWZjb3VudCBpbnN0ZWFkIG9mIHNpbXBseSBjYWxsaW5nDQprZnJlZSgp
LCB3aGljaCBpcyB3aGF0IEknbSB3b3JraW5nIG9uLiBJdCBlbmRzIHVwIGJlaW5nIHRlZGlvdXMg
YnV0IG5vdA0KcGFydGljdWxhcmx5IGNvbXBsaWNhdGVkLCBteSBnb2FsIGlzIHRvIGhhdmUgdGhp
cyB1cCBzb29uIDopDQoNClRoYW5rcywNCkNhbHZpbg0K
