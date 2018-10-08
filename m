Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E646DC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9CE2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="daFhcdie";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="M9CzoRKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9CE2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeJICbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:31:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58824 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727546AbeJICbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:31:45 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w98JHJX2013557;
        Mon, 8 Oct 2018 12:18:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=z2ztEOdHtPy8edXnlVh08QJdl90PYtqlogxdw3QpKME=;
 b=daFhcdieFf7DU/CVzV47FaarsZIrIZb8ut0HeJ/Q6HZPgowddJOgf9vG+aMAjriq1p04
 HlOx6Pz9dVNsc46rSxZtgC6l8wR2K5giR71NljghbgQql5E+AEJTV9Ui0WF8aHnT5RvG
 sLrbO46imU2Bsyu2oiEC+V2gaFwNYhIQPkc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2n0cp0r4ct-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 08 Oct 2018 12:18:08 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.17) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 8 Oct 2018 12:18:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2ztEOdHtPy8edXnlVh08QJdl90PYtqlogxdw3QpKME=;
 b=M9CzoRKAuNi7FoWdwuvQDHOveENQbU/lWVqt/ANeempFQOSUC06hLv9W8hL+OdeEb5zuZ2vPVTmap4C4AcgJ4hyXU7nuc9pbMQfpVByOZQinhQZeYutjJy3VJtM4nhL63OCQncy4amH6Q5wYIekT3e8/S7DmkkSTO/3ngGLT+O4=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.180.139) by
 CY4PR15MB1879.namprd15.prod.outlook.com (10.172.79.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Mon, 8 Oct 2018 19:18:05 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::2d43:ae9a:18c0:ac8b]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::2d43:ae9a:18c0:ac8b%3]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 19:18:04 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        "Justin . Lee1 @ Dell . com" <Justin.Lee1@Dell.com>,
        "joel @ jms . id . au" <joel@jms.id.au>,
        "linux-aspeed @ lists . ozlabs . org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>,
        "christian @ cmd . nu" <christian@cmd.nu>
Subject: Re: [PATCH net-next 1/2] net/ncsi: Add NCSI Broadcom OEM command
Thread-Topic: [PATCH net-next 1/2] net/ncsi: Add NCSI Broadcom OEM command
Thread-Index: AQHUXN3ylns6hin/hEqAgl9Tl4aPaaUUigMAgAC+LgA=
Date:   Mon, 8 Oct 2018 19:18:04 +0000
Message-ID: <567088A2-66B2-45FD-A2CA-46E476BFC856@fb.com>
References: <20181005190126.983734-1-vijaykhemka@fb.com>
 <ee398ff59257b33e64ba7b641bf29096972a5006.camel@mendozajonas.com>
In-Reply-To: <ee398ff59257b33e64ba7b641bf29096972a5006.camel@mendozajonas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::7:66ff]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1879;20:RfY+Dpn6mlgR6qDOI8aeBudBBLC6WEYU6AP8kuIfpyccBExx/VzodVup9OLkm8wdmuFwweaggwKVjJAvbLbg7s/siSZnTndoVA6/18ETv4oK1s1vE4aRvuiio+2zUmWWTVAMJqixmsFD/tteoUvpOAr3ADsFTdOdBwvse7w9M6s=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(136003)(346002)(366004)(199004)(189003)(4326008)(33656002)(97736004)(36756003)(2900100001)(102836004)(106356001)(105586002)(71200400001)(71190400001)(82746002)(53936002)(6512007)(68736007)(5660300001)(6506007)(76176011)(25786009)(83716004)(229853002)(6436002)(446003)(305945005)(2501003)(8936002)(6486002)(5250100002)(99286004)(186003)(8676002)(2201001)(7736002)(81156014)(11346002)(81166006)(2616005)(476003)(46003)(14454004)(256004)(14444005)(6116002)(86362001)(2906002)(316002)(110136005)(486006)(6246003)(54906003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1879;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 46eb5df2-e809-43b5-74aa-08d62d52c59c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1879;
x-ms-traffictypediagnostic: CY4PR15MB1879:
x-microsoft-antispam-prvs: <CY4PR15MB1879A573C15E0E413F51A436DDE60@CY4PR15MB1879.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(81227570615382)(158342451672863)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:CY4PR15MB1879;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1879;
x-forefront-prvs: 081904387B
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EsgRws4tWoaQ/siqiWWt9SsftsQXPDYbB8ZkE5U6CAnAx3d/yZnb+CV/Fz8d9g7sHYwz6ZK019HL+114Blkwl9Gf8hVQKRv9QB6XWNcu7Wdef1Yv2AWCZ90WcqUNZ1LS3ze4GIaS65tBzHggFmX0z+yhHufXINpMtf+l+CJK5pEPsoGrTUmroPvonrBAKAIVvgL/AcJBDnJCM50WFZx0BLtp/P9IhcHXFYLaZE7M9oyQPAy3GvMnOW7eQurQ8pXCkyw1o5lAgIRlGbso4aa+BF8GDKqyBMLTRbIONx/2UvxK14n3TsYhMoY8P/8CWTzuFwsiqEUykqja2ksbyiNEXDJRcGUH+2DJU4gEOIrUtv4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CC8532C41E096469B09DC2C9547B3A5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eb5df2-e809-43b5-74aa-08d62d52c59c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 19:18:04.4656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1879
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDEwLzcvMTgsIDU6NTggUE0sICJTYW11ZWwgTWVuZG96YS1Kb25hcyIgPHNhbUBt
ZW5kb3pham9uYXMuY29tPiB3cm90ZToNCg0KICAgIE9uIEZyaSwgMjAxOC0xMC0wNSBhdCAxMjow
MSAtMDcwMCwgVmlqYXkgS2hlbWthIHdyb3RlOg0KICAgID4gVGhpcyBwYXRjaCBhZGRzIE9FTSBC
cm9hZGNvbSBjb21tYW5kcyBhbmQgcmVzcG9uc2UgaGFuZGxpbmcuIEl0IGFsc28NCiAgICA+IGRl
ZmluZXMgT0VNIEdldCBNQUMgQWRkcmVzcyBoYW5kbGVyIHRvIGdldCBhbmQgY29uZmlndXJlIHRo
ZSBkZXZpY2UuDQogICAgPiANCiAgICA+IG5jc2lfb2VtX2dtYV9oYW5kbGVyX2JjbTogVGhpcyBo
YW5kbGVyIHNlbmQgTkNTSSBicm9hZGNvbSBjb21tYW5kIGZvcg0KICAgID4gZ2V0dGluZyBtYWMg
YWRkcmVzcy4NCiAgICA+IG5jc2lfcnNwX2hhbmRsZXJfb2VtX2JjbTogVGhpcyBoYW5kbGVzIHJl
c3BvbnNlIHJlY2VpdmVkIGZvciBhbGwNCiAgICA+IGJyb2FkY29tIE9FTSBjb21tYW5kcy4NCiAg
ICA+IG5jc2lfcnNwX2hhbmRsZXJfb2VtX2JjbV9nbWE6IFRoaXMgaGFuZGxlcyBnZXQgbWFjIGFk
ZHJlc3MgcmVzcG9uc2UgYW5kDQogICAgPiBzZXQgaXQgdG8gZGV2aWNlLg0KICAgID4gDQogICAg
PiBTaWduZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4NCiAgICAN
CiAgICBIaSBWaWpheSwNCiAgICANCiAgICBMb29rcyBnb29kLCBhbmQgSSd2ZSB0ZXN0ZWQgdGhp
cyBvbiBhIEJNQyB3aXRoIGEgQnJvYWRjb20gbmV0d29yaw0KICAgIGNvbnRyb2xsZXIgYW5kIGl0
IHByb3Blcmx5IHNldHMgYSBNQUMgYWRkcmVzcy4gQSBxdWVzdGlvbiBiZWxvdyBhYm91dCB0aGUN
CiAgICByZXNwb25zZSBoYW5kbGVyOg0KDQogIEhpIFNhbSwNCiAgVGhhbmtzIGZvciBmZWVkYmFj
aywgSSB3aWxsIHVwZGF0ZSBjb2RlIGZvciByZXNwb25zZSBoYW5kbGVyLiBQbGVhc2Ugc2VlIG15
IHJlc3BvbnNlIGJlbG93Lg0KICAgIA0KDQogICAgPiArLyogUmVzcG9uc2UgaGFuZGxlciBmb3Ig
QnJvYWRjb20gY29tbWFuZCBHZXQgTWFjIEFkZHJlc3MgKi8NCiAgICA+ICtzdGF0aWMgaW50IG5j
c2lfcnNwX2hhbmRsZXJfb2VtX2JjbV9nbWEoc3RydWN0IG5jc2lfcmVxdWVzdCAqbnIpDQogICAg
PiArew0KICAgID4gKwlzdHJ1Y3QgbmNzaV9yc3Bfb2VtX3BrdCAqcnNwOw0KICAgID4gKwlzdHJ1
Y3QgbmNzaV9kZXZfcHJpdiAqbmRwID0gbnItPm5kcDsNCiAgICA+ICsJc3RydWN0IG5ldF9kZXZp
Y2UgKm5kZXYgPSBuZHAtPm5kZXYuZGV2Ow0KICAgID4gKwlpbnQgcmV0ID0gMDsNCiAgICA+ICsJ
Y29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vfb3BzICpvcHMgPSBuZGV2LT5uZXRkZXZfb3BzOw0KICAg
ID4gKwlzdHJ1Y3Qgc29ja2FkZHIgc2FkZHI7DQogICAgPiArDQogICAgPiArCS8qIEdldCB0aGUg
cmVzcG9uc2UgaGVhZGVyICovDQogICAgPiArCXJzcCA9IChzdHJ1Y3QgbmNzaV9yc3Bfb2VtX3Br
dCAqKXNrYl9uZXR3b3JrX2hlYWRlcihuci0+cnNwKTsNCiAgICA+ICsNCiAgICA+ICsJc2FkZHIu
c2FfZmFtaWx5ID0gbmRldi0+dHlwZTsNCiAgICA+ICsJbmRldi0+cHJpdl9mbGFncyB8PSBJRkZf
TElWRV9BRERSX0NIQU5HRTsNCiAgICA+ICsJbWVtY3B5KHNhZGRyLnNhX2RhdGEsICZyc3AtPmRh
dGFbQkNNX01BQ19BRERSX09GRlNFVF0sIEVUSF9BTEVOKTsNCiAgICA+ICsJLyogSW5jcmVhc2Ug
bWFjIGFkZHJlc3MgYnkgMSBmb3IgQk1DJ3MgYWRkcmVzcyAqLw0KICAgID4gKwlzYWRkci5zYV9k
YXRhW0VUSF9BTEVOIC0gMV0rKzsNCiAgICANCiAgICBJcyB0aGlzIGNvbnZlbnRpb24gZG9jdW1l
bnRlZCBzb21ld2hlcmUsIGFuZCBjb3VsZCB5b3UgcHJvdmlkZSBhIGxpbmsgdG8NCiAgICBpdCBp
ZiBzbz8NCiAgICANCiAgICBBbHNvIHdoYXQgaGFwcGVucyBoZXJlIGlmIHRoZSBmaW5hbCBieXRl
IG9mIHRoZSBhZGRyZXNzIGlzIDB4ZmYsIHRoaXMNCiAgICB3aWxsIG92ZXJmbG93IGFuZCBub3Qg
Y2FycnkgcmlnaHQ/DQoNCiAgVGhpcyBpcyBhIEZhY2Vib29rIHJlcXVpcmVtZW50IHRvIGluY3Jl
bWVudCBNQUMgYWRkcmVzcyBieSAxIGFzIGJhc2UgYWRkcmVzcyBpcyBkZWZpbmVkIGZvciANCiAg
c2VydmVyIGZvbGxvd2VkIGJ5IEJNQyBhZGRyZXNzLiBJIHdpbGwgaGFuZGxlIHRoaXMgRmFjZWJv
b2sgc3BlY2lmaWMgY29kZSBkaWZmZXJlbnRseSBpbiBuZXcgDQogIHBhdGNoLiBGb3IgZ2VuZXJp
YyBCcm9hZGNvbSBjYXJkLCBJIHdpbGwganVzdCBnZXQgYmFzZSBtYWMgYWRkcmVzcyBhbmQgbm90
IGFkZCBhbnkgY29udmVudGlvbi4NCiAgICANCiAgICA+ICsJcmV0ID0gb3BzLT5uZG9fc2V0X21h
Y19hZGRyZXNzKG5kZXYsICZzYWRkcik7DQogICAgPiArCWlmIChyZXQgPCAwKQ0KICAgID4gKwkJ
bmV0ZGV2X3dhcm4obmRldiwgIk5DU0k6ICdXcml0aW5nIG1hYyBhZGRyZXNzIHRvIGRldmljZSBm
YWlsZWRcbiIpOw0KICAgIA0KICAgIEFsc28gYSBtaW5vciBuaXRwaWNrLCB0aGVyZSdzIGEgYm9u
dXMgIiciIGluIHRoaXMgbWVzc2FnZS4NCiAgICANCiAgV2lsbCBiZSB0YWtlbiBjYXJlIGluIG5l
eHQgdmVyc2lvbi4NCiAgICANCg0K
