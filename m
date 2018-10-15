Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36C9C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45460208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="h2KPG+/S";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aFG2reSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45460208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeJPBNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:13:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35918 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726638AbeJPBNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:13:44 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9FHPG3e012788;
        Mon, 15 Oct 2018 10:27:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rRIObCYSLTDekuwc2+CLnzHLwUfJeMQNGPUZERy2cks=;
 b=h2KPG+/SgRrgDvq/+NOQlue8WXj4MadNn7JKN737mQyouwRR665NAcnotEbddQCDr8e+
 idCvXow8Z1UExNNb8yRHibQusOzKHjuLpIl/cocPgJ1GRMuJL++sT9/jgDgBmup16MXD
 mdBQkZo5fK+dOsYFrh61pgM0wUbWBuhj0Mk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n4x6b07ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Oct 2018 10:27:22 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 15 Oct 2018 10:27:20 -0700
Received: from PRN-CHUB10.TheFacebook.com (2620:10d:c081:35::19) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 15 Oct 2018 10:27:20 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 15 Oct 2018 10:27:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRIObCYSLTDekuwc2+CLnzHLwUfJeMQNGPUZERy2cks=;
 b=aFG2reSmtL9H1g3vttwixN1Rk5yCNs74I0mlmHhV8ghPnZ3s/faeDtgImJa0hluun8j8f+MTlmymKwiRo4n3ObgU0QrbcGVSubktsxc8ESgNsU29mrdrvVfAv+PBM86qbc1GQG0IgmsCOLi7LOacKl2HKnbnDcRZt5A3a9HVyIs=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1591.namprd15.prod.outlook.com (10.172.162.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.31; Mon, 15 Oct 2018 17:27:19 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::2d43:ae9a:18c0:ac8b]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::2d43:ae9a:18c0:ac8b%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 17:27:19 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH net-next v4] net/ncsi: Add NCSI Broadcom OEM command
Thread-Topic: [PATCH net-next v4] net/ncsi: Add NCSI Broadcom OEM command
Thread-Index: AQHUYlhQZUxkpBOuN06jkP+jv3xqzqUfk1EAgAAckoCAAG64AA==
Date:   Mon, 15 Oct 2018 17:27:19 +0000
Message-ID: <E805AF11-4C0E-4184-9699-94D10704D853@fb.com>
References: <20181012182008.1665690-1-vijaykhemka@fb.com>
 <69cae9d44cbebb2cd4f468dc710d6a97210af835.camel@mendozajonas.com>
 <9c82f52a7ce3fb9052600709a10783b23ef88457.camel@mendozajonas.com>
In-Reply-To: <9c82f52a7ce3fb9052600709a10783b23ef88457.camel@mendozajonas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:2d49]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1591;20:gt+wtf+hLNyskleYQNqVMC6NNxULHduQdbqbo5Pob67HixGVcESgzDccGWbjL03bir6PbRhnDBoRZ4FT6IABsomTmv8RE+xiC4Ehn5RzKq9PPFSxa1/s1EW4ZRMr7kPCNxmRiSGL3p1OWvDje8+RvcBQxz0qknvhPo/FN00SsYg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 833444d5-362f-4258-4d9a-08d632c3759c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1591;
x-ms-traffictypediagnostic: CY4PR15MB1591:
x-microsoft-antispam-prvs: <CY4PR15MB15916BE3D09222D2B93A52C6DDFD0@CY4PR15MB1591.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:CY4PR15MB1591;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1591;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(43544003)(189003)(476003)(33656002)(11346002)(53936002)(478600001)(76176011)(7736002)(36756003)(305945005)(561944003)(2616005)(6116002)(71190400001)(71200400001)(8676002)(81166006)(83716004)(14454004)(316002)(486006)(8936002)(81156014)(5660300001)(99286004)(6486002)(68736007)(2906002)(6436002)(229853002)(102836004)(2501003)(6512007)(186003)(256004)(14444005)(4326008)(86362001)(5250100002)(97736004)(4001150100001)(6246003)(54906003)(110136005)(25786009)(106356001)(82746002)(2201001)(2900100001)(6506007)(46003)(446003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1591;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZhDwmVL+xEBIOsg4JXRheUCssYErGslVO2nHsoAOaYldcOTLXEeM/1ovhaNvfEkdOm66ynN8T3NN06D/rmpw4Ywd5lgg29DKfpLvtfeOR9wJcqW5KQt2fjLZJsPJPXEbnZimGnVm5v8D+KZySrXn/3iLMNNaTj5c3YxtmUzoRISPlUR7XIr9vdvHN+j/PdD9cjv5L2hCQ61ysHkCsJPlBy43//OTUATasEF/1A9f/RVV8yqDZzK/VGXtYMwVnpkQEMGTob7DhTG2DIMjWaeYWT+kLB+MroO0IAVCPBe2VN5IPYpeQwvu/mD0wnaJu7D8KfeVAhgAtY3OfvrmTxcCu8gQPtqPS4b1lV8tjiR4WcA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A31354061D92CC489D3BD8004A4CFE80@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 833444d5-362f-4258-4d9a-08d632c3759c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 17:27:19.1742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1591
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEwLzE0LzE4LCA4OjUxIFBNLCAiU2FtdWVsIE1lbmRvemEtSm9uYXMiIDxzYW1A
bWVuZG96YWpvbmFzLmNvbT4gd3JvdGU6DQoNCiAgICBPbiBNb24sIDIwMTgtMTAtMTUgYXQgMTM6
MDggKzExMDAsIFNhbXVlbCBNZW5kb3phLUpvbmFzIHdyb3RlOg0KICAgID4gT24gRnJpLCAyMDE4
LTEwLTEyIGF0IDExOjIwIC0wNzAwLCBWaWpheSBLaGVta2Egd3JvdGU6DQogICAgPiA+IFRoaXMg
cGF0Y2ggYWRkcyBPRU0gQnJvYWRjb20gY29tbWFuZHMgYW5kIHJlc3BvbnNlIGhhbmRsaW5nLiBJ
dCBhbHNvDQogICAgPiA+IGRlZmluZXMgT0VNIEdldCBNQUMgQWRkcmVzcyBoYW5kbGVyIHRvIGdl
dCBhbmQgY29uZmlndXJlIHRoZSBkZXZpY2UuDQogICAgPiA+IA0KICAgID4gPiBuY3NpX29lbV9n
bWFfaGFuZGxlcl9iY206IFRoaXMgaGFuZGxlciBzZW5kIE5DU0kgYnJvYWRjb20gY29tbWFuZCBm
b3INCiAgICA+ID4gZ2V0dGluZyBtYWMgYWRkcmVzcy4NCiAgICA+ID4gbmNzaV9yc3BfaGFuZGxl
cl9vZW1fYmNtOiBUaGlzIGhhbmRsZXMgcmVzcG9uc2UgcmVjZWl2ZWQgZm9yIGFsbA0KICAgID4g
PiBicm9hZGNvbSBPRU0gY29tbWFuZHMuDQogICAgPiA+IG5jc2lfcnNwX2hhbmRsZXJfb2VtX2Jj
bV9nbWE6IFRoaXMgaGFuZGxlcyBnZXQgbWFjIGFkZHJlc3MgcmVzcG9uc2UgYW5kDQogICAgPiA+
IHNldCBpdCB0byBkZXZpY2UuDQogICAgPiA+IA0KICAgID4gPiBTaWduZWQtb2ZmLWJ5OiBWaWph
eSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4NCiAgICA+ID4gLS0tDQogICAgPiA+ICB2NDog
dXBkYXRlZCBhcyBwZXIgY29tbWVudCBmcm9tIFNhbSwgSSB3YXMganVzdCB3b25kZXJpbmcgaWYg
SSBjYW4gcmVtb3ZlDQogICAgPiA+ICBOQ1NJX09FTV9DTURfR0VUX01BQyBjb25maWcgb3B0aW9u
IGFuZCBsZXQgdGhpcyBjb2RlIGJlIHZhbGlkIGFsd2F5cyBhbmQNCiAgICA+ID4gIGl0IHdpbGwg
Y29uZmlndXJlIG1hYyBhZGRyZXNzIGlmIHRoZXJlIGlzIGdldCBtYWMgYWRkcmVzcyBoYW5kbGVy
IGZvciBnaXZlbiANCiAgICA+ID4gIG1hbnVmYWN0dXJlIGlkLg0KICAgID4gDQogICAgPiBIaSBW
aWpheSwNCiAgICA+IA0KICAgID4gV2UgY2FuIGxvb2sgYXQgaGFuZGxpbmcgdGhpcyBhIGRpZmZl
cmVudCB3YXksIGJ1dCBJIGRvbid0IHRoaW5rIHdlIHdhbnQNCiAgICA+IHRvIHVuY29uZGl0aW9u
YWxseSBzZXQgdGhlIHN5c3RlbSdzIE1BQyBhZGRyZXNzIGJhc2VkIG9uIHRoZSBPRU0gR01BDQog
ICAgPiBjb21tYW5kLiBJZiB0aGUgdXNlciB3YW50cyB0byBzZXQgYSBjdXN0b20gTUFDIGFkZHJl
c3MsIG9yIGluIHRoZSBjYXNlIG9mDQogICAgPiBPcGVuQk1DIGZvciBleGFtcGxlIHdobyBoYXZl
IHRoZWlyIE1BQyBhZGRyZXNzIHNhdmVkIGluIGZsYXNoLCB0aGlzIHdpbGwNCiAgICA+IG92ZXJy
aWRlIHRoYXQgdmFsdWUgd2l0aCB3aGF0ZXZlciB0aGUgTmV0d29yayBDb250cm9sbGVyIGhhcyBz
YXZlZC4gSW4NCiAgICA+IHBhcnRpY3VsYXIgYXMgaXQgaXMgc2V0IHVwIGl0IHdpbGwgb3ZlcnJp
ZGUgYW55IE1BQyBhZGRyZXNzIGV2ZXJ5IHRpbWUgYQ0KICAgID4gY2hhbm5lbCBpcyBjb25maWd1
cmVkLCBzdWNoIGFzIGR1cmluZyBhIGZhaWxvdmVyIGV2ZW50Lg0KICAgID4gDQogICAgPiBXZSAq
Y291bGQqIGFsd2F5cyBzZW5kIHRoZSBHTUEgY29tbWFuZCBpZiBpdCBpcyBhdmFpbGFibGUgYW5k
IG1vdmUgdGhlDQogICAgPiBkZWNpc2lvbiB3aGV0aGVyIHRvIHVzZSB0aGUgcmVzdWx0aW5nIGFk
ZHJlc3Mgb3Igbm90IGludG8gdGhlIHJlc3BvbnNlDQogICAgPiBoYW5kbGVyLiBUaGF0IHdvdWxk
IHNpbXBsaWZ5IHRoZSBuY3NpX2NvbmZpZ3VyZV9jaGFubmVsKCkgbG9naWMgYSBiaXQuDQogICAg
PiBBbm90aGVyIGlkZWEgbWF5IGJlIHRvIGhhdmUgYSBOZXRsaW5rIGNvbW1hbmQgdG8gdGVsbCBO
Q1NJIHRvIGlnbm9yZSB0aGUNCiAgICA+IEdNQSByZXN1bHQ7IHRoZW4gd2UgY291bGQgZHJvcCB0
aGUgY29uZmlnIG9wdGlvbiBhbmQgdGhlIHN5c3RlbSBjYW4NCiAgICA+IHNhZmVseSBjaGFuZ2Ug
dGhlIGFkZHJlc3MgaWYgZGVzaXJlZC4NCiAgICA+IA0KICAgID4gQW55IHRob3VnaHRzPyBJJ2xs
IGFsc28gcGluZyBzb21lIG9mIHRoZSBPcGVuQk1DIHBlb3BsZSBhbmQgc2VlIHdoYXQNCiAgICA+
IHRoZWlyIGV4cGVjdGF0aW9ucyBhcmUuDQogICAgDQogICAgQWZ0ZXIgYSBiaXQgb2YgYSB0aGlu
ayBhbmQgYW4gYXNrIGFyb3VuZCwgdG8gcXVvdGUgYSBjb2xsZWFndWU6DQogICAgPiBJIHRoaW5r
IHdlJ2Qgd2FudCBpdCBoYW5kbGVkIChvdmVyYWxsKSBsaWtlIGFueSBvdGhlciBuZXQgZGV2aWNl
OyB0aGUgTUFDDQogICAgPiBhZGRyZXNzIGluIHRoZSBkZXZpY2UncyBST00gcHJvdmlkZXMgYSBk
ZWZhdWx0LCBhbmQgaXMgb3ZlcnJpZGRlbiBieSBhbnl0aGluZw0KICAgID4gc3BlY2lmaWVkIGJ5
IHVzZXJzcGFjZSANCiAgICANCiAgICBXaGljaCBkZXNjcmliZXMgd2hhdCBJIHdhcyB0aGlua2lu
ZyBwcmV0dHkgd2VsbC4NCiAgICBTbyBpZiB3ZSBjYW4gaGF2ZSBpdCBzdWNoIHRoYXQgdGhlIE5D
U0kgZHJpdmVyIG9ubHkgc2V0cyB0aGUgTUFDIGFkZHJlc3MNCiAgICBfb25jZV8sIGFuZCB0aGVu
IGFmdGVyIHRoZW4gZG9lcyBub3QgdXBkYXRlIGl0IGFnYWluLCB3ZSBzaG91bGQgYmUgYWJsZSB0
byBjYWxsDQogICAgdGhlIE9FTSBHTUEgY29tbWFuZCB3aXRob3V0IGhpZGluZyBpdCBiZWhpbmQg
YSBjb25maWcgb3B0aW9uLiBTbyB0aGUgZmlyc3QgdGltZQ0KICAgIGEgY2hhbm5lbCB3YXMgY29u
ZmlndXJlZCB3ZSBzdG9yZSBhbmQgc2V0IHRoZSBNQUMgYWRkcmVzcyBnaXZlbiwgYnV0IHRoZW4g
b24NCiAgICBsYXRlciBjb25maWd1cmUgZXZlbnRzIHdlIGRvbid0IGNvbnRpbnVlIHRvIHVwZGF0
ZSBpdC4gV2hhdCBkbyB5b3UgdGhpbms/DQogICAgDQogICAgQ2hlZXJzLA0KICAgIFNhbQ0KDQog
IEkgYWdyZWUgd2l0aCB5b3Ugc2V0dGluZyBpdCBvbmx5IG9uY2UuIEkgZ2F2ZSBhIHRob3VnaHQg
YWJvdXQgY29uZmlnIG9wdGlvbiBhbmQgcmVhbGl6ZSB0aGF0IA0KICB3ZSBzaG91bGQgYWxsb3cg
dXNlciB0byBjb25maWd1cmUgaXQuIElmIHVzZXIgd2FudHMgdG8gc2V0IG1hYyBhZGRyZXNzIHRo
cm91Z2ggZGV2aWNlIHRyZWUgDQogIGFuZCBub3QgdGhyb3VnaCBST00gdGhlbiB3ZSBtdXN0IG5v
dCBvdmVycmlkZSBtYWMgc2V0IGJ5IGRldmljZSB0cmVlLiBTbyBteSBwcm9wb3NhbCBpcyANCiAg
c2V0dGluZyBvZiBtYWMgYWRkcmVzcyBpbiByZXNwb25zZSBzaG91bGQgYmUgaGlkZGVuIHVuZGVy
IGNvbmZpZyBvcHRpb24uIEdldHRpbmcgbWFjIGFkZHJlc3MgDQogIGNhbiBzdGlsbCBnbyB3aXRo
b3V0IGNvbmZpZyBvcHRpb24uIFlvdXIgdGhvdWdodD8NCiAgICANCiAgICA+IA0KICAgID4gPiAr
I2lmIElTX0VOQUJMRUQoQ09ORklHX05DU0lfT0VNX0NNRF9HRVRfTUFDKQ0KICAgID4gPiArDQog
ICAgPiA+ICsvKiBOQ1NJIE9FTSBDb21tYW5kIEFQSXMgKi8NCiAgICA+ID4gK3N0YXRpYyB2b2lk
IG5jc2lfb2VtX2dtYV9oYW5kbGVyX2JjbShzdHJ1Y3QgbmNzaV9jbWRfYXJnICpuY2EpDQogICAg
PiA+ICt7DQogICAgPiA+ICsJdW5zaWduZWQgY2hhciBkYXRhW05DU0lfT0VNX0JDTV9DTURfR01B
X0xFTl07DQogICAgPiA+ICsJaW50IHJldCA9IDA7DQogICAgPiA+ICsNCiAgICA+ID4gKwluY2Et
PnBheWxvYWQgPSBOQ1NJX09FTV9CQ01fQ01EX0dNQV9MRU47DQogICAgPiA+ICsNCiAgICA+ID4g
KwltZW1zZXQoZGF0YSwgMCwgTkNTSV9PRU1fQkNNX0NNRF9HTUFfTEVOKTsNCiAgICA+ID4gKwkq
KHVuc2lnbmVkIGludCAqKWRhdGEgPSBudG9obChOQ1NJX09FTV9NRlJfQkNNX0lEKTsNCiAgICA+
ID4gKwlkYXRhWzVdID0gTkNTSV9PRU1fQkNNX0NNRF9HTUE7DQogICAgPiA+ICsNCiAgICA+ID4g
KwluY2EtPmRhdGEgPSBkYXRhOw0KICAgID4gPiArDQogICAgPiA+ICsJcmV0ID0gbmNzaV94bWl0
X2NtZChuY2EpOw0KICAgID4gPiArCWlmIChyZXQpDQogICAgPiA+ICsJCW5ldGRldl9lcnIobmNh
LT5uZHAtPm5kZXYuZGV2LA0KICAgID4gPiArCQkJICAgIk5DU0k6IEZhaWxlZCB0byB0cmFuc21p
dCBjbWQgMHgleCBkdXJpbmcgY29uZmlndXJlXG4iLA0KICAgID4gPiArCQkJICAgbmNhLT50eXBl
KTsNCiAgICA+ID4gK30NCiAgICA+IA0KICAgID4gQXMgYSBzaWRlIG5vdGUgd2hpbGUgdW5saWtl
bHkgd2UgcHJvYmFibHkgd2FudCB0byBwcm9wYWdhdGUgdGhlIHJldHVybg0KICAgID4gdmFsdWUg
b2YgbmNzaV94bWl0X2NtZCgpIGZyb20gaGVyZTsgb3RoZXJ3aXNlIHdlJ2xsIG1pc3MgYSBmYWls
dXJlIGFuZA0KICAgID4gdGhlIGNvbmZpZ3VyZSBwcm9jZXNzIHdpbGwgc3RhbGwuDQogICAgPiAN
CiAgICA+IFJlZ2FyZHMsDQogICAgPiBTYW0NCiAgICA+IA0KICBJIHdpbGwgdGFrZSBjYXJlIG9m
IHRoaXMuICANCiAgICANCiAgICANCg0K
