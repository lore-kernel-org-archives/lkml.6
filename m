Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DDBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C387217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="kz83DvL6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EZJngiYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfBRTdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:33:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54382 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbfBRTdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:33:35 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IJSVqn012247;
        Mon, 18 Feb 2019 11:31:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=HIa/12XbhDM0KThCXxwFTDSrfucOVuFRzB7CRdDmX5U=;
 b=kz83DvL6qgVmAGfkmIsbRCXiyLHAX2epH3HGsERW4uYdAhoeP6+BrsIGqaOneV3kwn+V
 GxqNXxq70rILltluNubaMN1yF56rzagL94Xxg+sQIYNg0VdWnk4AQikA+wtPUDLGtvuT
 ukZLOmEw7Vn/SqJ8KD+agX41IKgx71Skz90= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qr2eeg2na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 11:31:15 -0800
Received: from frc-mbx04.TheFacebook.com (192.168.155.19) by
 frc-hub03.TheFacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 18 Feb 2019 11:31:15 -0800
Received: from frc-hub06.TheFacebook.com (192.168.177.76) by
 frc-mbx04.TheFacebook.com (192.168.155.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 18 Feb 2019 11:31:15 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 18 Feb 2019 11:31:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIa/12XbhDM0KThCXxwFTDSrfucOVuFRzB7CRdDmX5U=;
 b=EZJngiYtoeggGfoU59BIpIqeBVFDHVl9+C/ZJ8KIbdhFMWCHS3K3tLvlbtXBzVwiQEu7a79+x8Q+mgpVMBba6mp6Psf+HoQ6fssTaCpjrhJe7EfWh/xsyhEC8bF5UG8+0g9cycY+3mOJodi9cF/5N8lTUGthbTvRRiQOZfVyvac=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2934.namprd15.prod.outlook.com (20.178.237.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 19:30:54 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1601.016; Mon, 18 Feb 2019
 19:30:53 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@surriel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Wolfgang Walter <linux@stwm.de>, Spock <dairinin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.20 71/92] Revert "mm: slowly shrink slabs with a
 relatively small number of objects"
Thread-Topic: [PATCH 4.20 71/92] Revert "mm: slowly shrink slabs with a
 relatively small number of objects"
Thread-Index: AQHUx5DFfbn2t2YpWUeoO4VrMVhutaXlrrEAgAAMzwCAABbegP//kAgAgACKxoCAAASfJA==
Date:   Mon, 18 Feb 2019 19:30:53 +0000
Message-ID: <10295CCD-16FD-44B4-A232-4DE4A1238FFA@fb.com>
References: <20190218133454.668268457@linuxfoundation.org>
 <20190218133501.533140116@linuxfoundation.org>
 <a998a5028aa3bb17a5a60fffd3db558223b84cd5.camel@surriel.com>
 <20190218161634.GA30873@kroah.com> <20190218173825.GB4525@dhcp22.suse.cz>
 <20190218185738.GA3745@castle.DHCP.thefacebook.com>,<20190218191421.GE4525@dhcp22.suse.cz>
In-Reply-To: <20190218191421.GE4525@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [107.77.214.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5f7efef-3a45-48c1-3e51-08d695d79908
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2934;
x-ms-traffictypediagnostic: BYAPR15MB2934:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2934;20:meE1fdxTWzw+1p0Pisi43iAGcglVK3oqKx41nR4BUISXb2oUQ1UGsjd0Jimvdn0L1Wt3OTc0Lyp1i6qbo6HUfx/8ea9tj8KmtwXmVi7M1ohbfP0gz98f19pMM4N2FkTrNc/lVt1PWDarNDrjRIOwlMZWX/xOcOwsBQslPnlvSd8=
x-microsoft-antispam-prvs: <BYAPR15MB2934DA1168CFA39582A50123BE630@BYAPR15MB2934.namprd15.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(8936002)(6486002)(6512007)(82746002)(25786009)(305945005)(99286004)(2906002)(6916009)(86362001)(5660300002)(229853002)(81156014)(81166006)(8676002)(7736002)(6506007)(53546011)(102836004)(54906003)(478600001)(93886005)(76176011)(4326008)(316002)(11346002)(6246003)(53936002)(446003)(2616005)(33656002)(105586002)(256004)(36756003)(106356001)(14454004)(9886003)(476003)(486006)(561944003)(6436002)(186003)(6116002)(3846002)(26005)(83716004)(66066001)(97736004)(7416002)(71190400001)(71200400001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2934;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 57Hk8Er2tEjJ5vhNIi5SuTCMFEuowoQiU0MacDVw2jwFwxFHkmgGW7eUB9+JTy01Q2OSRbJEjwech7VSvJ5JlPmUsQ/gOkgBioxdfflRC/aKegoPXRpRis/FvirFFpVeAQe+hbHw4XtNepakYzbJsPkcY6XH9oY5iqmFCM6sO+StVBPattJId9ZJEukGhmHz50BSgl1+QE5rSjmJrUaQzg2/+jGIHTBQBO5FcsGVupsc+1BhS5DU9hvDRdqPWuY268sE7k+JXsULOAgUWhwUbHmoctAFirBKntiyEVHnBn0C3i5sFKdlLEEkbpZ/m+gCmrek5n1ZSexBAjWuPLmy9aAKhJtsuvsAIUhyPgvlFOaBHWIemAochAEkpD7JS3FWqyU7moReHWlL+W8VhM6RNOC1hvD1UNlumknKgHsbpLo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f7efef-3a45-48c1-3e51-08d695d79908
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 19:30:53.6374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2934
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T2ssIEnigJlsbCBzZW5kIHRoZSBwcm9wb3NhbCBsYXRlciB0b2RheS4NCg0KVGhhbmtzIQ0KDQpT
ZW50IGZyb20gbXkgaVBob25lDQoNCj4gT24gRmViIDE4LCAyMDE5LCBhdCAxMToxNCwgTWljaGFs
IEhvY2tvIDxtaG9ja29Aa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPj4gT24gTW9uIDE4LTAyLTE5
IDE4OjU3OjQ1LCBSb21hbiBHdXNoY2hpbiB3cm90ZToNCj4+PiBPbiBNb24sIEZlYiAxOCwgMjAx
OSBhdCAwNjozODoyNVBNICswMTAwLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+Pj4+IE9uIE1vbiAx
OC0wMi0xOSAxNzoxNjozNCwgR3JlZyBLSCB3cm90ZToNCj4+Pj4+IE9uIE1vbiwgRmViIDE4LCAy
MDE5IGF0IDEwOjMwOjQ0QU0gLTA1MDAsIFJpayB2YW4gUmllbCB3cm90ZToNCj4+Pj4+PiBPbiBN
b24sIDIwMTktMDItMTggYXQgMTQ6NDMgKzAxMDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToN
Cj4+Pj4+PiA0LjIwLXN0YWJsZSByZXZpZXcgcGF0Y2guICBJZiBhbnlvbmUgaGFzIGFueSBvYmpl
Y3Rpb25zLCBwbGVhc2UgbGV0DQo+Pj4+Pj4gbWUga25vdy4NCj4+Pj4+PiANCj4+Pj4+PiAtLS0t
LS0tLS0tLS0tLS0tLS0NCj4+Pj4+PiANCj4+Pj4+PiBGcm9tOiBEYXZlIENoaW5uZXIgPGRjaGlu
bmVyQHJlZGhhdC5jb20+DQo+Pj4+Pj4gDQo+Pj4+Pj4gY29tbWl0IGE5YTIzOGU4M2ZiYjBkZjMx
YzNiOWI2NzAwM2Y4ZjlkMWQxYjZjOTYgdXBzdHJlYW0uDQo+Pj4+Pj4gDQo+Pj4+Pj4gVGhpcyBy
ZXZlcnRzIGNvbW1pdCAxNzJiMDZjMzJiOTQ5NyAoIm1tOiBzbG93bHkgc2hyaW5rIHNsYWJzIHdp
dGggYQ0KPj4+Pj4+IHJlbGF0aXZlbHkgc21hbGwgbnVtYmVyIG9mIG9iamVjdHMiKS4NCj4+Pj4+
IA0KPj4+Pj4gVGhpcyByZXZlcnQgd2lsbCByZXN1bHQgaW4gdGhlIHNsYWIgY2FjaGVzIG9mIGRl
YWQNCj4+Pj4+IGNncm91cHMgd2l0aCBhIHNtYWxsIG51bWJlciBvZiByZW1haW5pbmcgb2JqZWN0
cyBuZXZlcg0KPj4+Pj4gZ2V0dGluZyByZWNsYWltZWQsIHdoaWNoIGNhbiBiZSBhIG1lbW9yeSBs
ZWFrIGluIHNvbWUNCj4+Pj4+IGNvbmZpZ3VyYXRpb25zLg0KPj4+Pj4gDQo+Pj4+PiBCdXQgaGV5
LCB0aGF0J3MgeW91ciB0cmFkZW9mZiB0byBtYWtlLg0KPj4+PiANCj4+Pj4gVGhhdCdzIHdoYXQg
aXMgaW4gTGludXMncyB0cmVlLiAgU2hvdWxkIHdlIHNvbWVob3cgZGl2ZXJnZSBmcm9tIHRoYXQ/
DQo+Pj4gDQo+Pj4gSSBiZWxpZXZlIHdlIHNob3VsZCBzdGFydCB3b3JraW5nIG9uIGEgbWVtY2cg
c3BlY2lmaWMgc29sdXRpb24gdG8NCj4+PiBtaW5pbWl6ZSByZWdyZXNzaW9ucyBmb3Igb3RoZXJz
IGFuZCBzdGFydCBhIG1vcmUgY29tcGxleCBzb2x1dGlvbiBmcm9tDQo+Pj4gdGhlcmUuDQo+Pj4g
DQo+Pj4gQ2FuIHdlIHNwZWNpYWwgY2FzZSBkZWFkIG1lbWNncyBpbiB0aGUgc2xhYiByZWNsYWlt
IGFuZCByZWNsYWltIG1vcmUNCj4+PiBhZ2dyZXNzaXZlbHk/DQo+PiANCj4+IEl0J3MgcHJvYmFi
bHkgYmV0dGVyIHRvIHN0YXJ0IGEgbmV3IHRocmVhZCB0byBkaXNjdXNzIHRoaXMgaXNzdWUNCj4g
DQo+IGFncmVlZA0KPiANCj4+IChidHcsIGRvZXNuJ3QgTFNGL01NIGxvb2tzIGxpa2UgdGhlIGJl
c3QgcGxhY2UgdG8gZG8gaXQ/IEkgY2FuIHNlbmQgYSBwcm9wb3NhbCkuDQo+IA0KPiBJIHdhcyBh
Ym91dCB0byBkbyB0aGF0IGlmIG5vYm9keSBlbHNlIGRpZC4NCj4gDQo+IGRyb3BwZWQgdGhlIHJl
c3Qgb2YgdGhlIGVtYWlsIGJlY2F1c2UgdGhpcyByZWFsbHkgZGVzZXJ2ZXMgYSBuZXcNCj4gZGlz
Y3Vzc2lvbi4NCj4gLS0gDQo+IE1pY2hhbCBIb2Nrbw0KPiBTVVNFIExhYnMNCg==
