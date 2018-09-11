Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A15C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA7D20891
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA7D20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeIKXMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:12:41 -0400
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:59956 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKXMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:12:41 -0400
X-Greylist: delayed 7759 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Sep 2018 19:12:40 EDT
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 21EAE91;
        Tue, 11 Sep 2018 18:12:12 +0000 (UTC)
Received: from G9W8672.americas.hpqcorp.net (16.220.49.31) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 11 Sep 2018 18:11:41 +0000
Received: from G4W10205.americas.hpqcorp.net (2002:10cf:520f::10cf:520f) by
 G9W8672.americas.hpqcorp.net (2002:10dc:311f::10dc:311f) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 11 Sep 2018 18:11:41 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W10205.americas.hpqcorp.net (16.207.82.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 11 Sep 2018 18:11:41 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0961.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Tue, 11 Sep 2018 18:11:39 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283%2]) with mapi id 15.20.1122.020; Tue, 11 Sep 2018
 18:11:39 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] ext4, dax: update dax check to skip journal inode
Thread-Topic: [PATCH 1/2] ext4, dax: update dax check to skip journal inode
Thread-Index: AQHUSekFUjINM6/+Z0KwkBt2ibRdAqTrXoCA///9roA=
Date:   Tue, 11 Sep 2018 18:11:39 +0000
Message-ID: <19388d015c54202ee3d1e8526677ccdf7d46cd02.camel@hpe.com>
References: <20180911154246.6844-1-toshi.kani@hpe.com>
         <20180911154246.6844-2-toshi.kani@hpe.com>
         <CAPcyv4j0zF+OjqPywkmZLgGiSjNdH_9SwpXjS=92bqT9OXZ_MQ@mail.gmail.com>
In-Reply-To: <CAPcyv4j0zF+OjqPywkmZLgGiSjNdH_9SwpXjS=92bqT9OXZ_MQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0961;6:IxOW7g9fTTOu3guz9/cQXxJopCZyvIOzvO7ZBv76TcqwAn8y4vOsSebdqCspiXFElLO85P+rLfPTzT+l73RaGAo7oSc0BITs0aKPN6h2SUP6zyqMGkH6AgWMTfatIqSK2fYJS7axCJYb780OsGdQisjZA1+RVtAdQ248+zP2pTKV57Syf3qB+8g/DhaRNGSuWbjjCLyBlcEXsXNJuy6rUUwx+EKWWhf/nk8GYQm08DQnQzI1FhJIO8b+HgKwuZsMlTxDtpaORRPSUjxpg9gJ1NBR6X/V3dha1J/3pRPsAhKPTaPEF6RZkTxL+0BQwF0NcGJ4X3LWCMMS8HOAa4NM92DOFELmxxZPn5RDfxLdB5pZLiKEZYKBTk959wdj2k8MYoOIG/NrbFhWTGMpWqZ3xSSQxzbFtKug1q7Mddwczn8ry3ZZQNfRRQmImhAijDAcAmX84UvViKyv7UUpvZwdpA==;5:x6l8VW2TLOEPuiYI10m0ebylBsAO7nhSPJw/LH0UjNpTfrkNXRhLTr6kKxV2ag5j7tOdLxqYiG5QMR7ti1D1O2B06e/7q5d4n8O0/if2+MqO5oG5sbC9Ryn8Ueqhq1KZ4FMW9Oc5lbnljzErDmfrdDEvBoK0ZVvx5fc3IpbFmWo=;7:ICIDr8emv6YU3/TtDrQYphxsF16K7QeTN6z4TWsPbYH9VxCVQxtoJjqbQSp1VQIMepRgANPgUB2k3WaoWzWE0x8lkrevE9p4HnzaJ9kWYy9h+M2yx9vu0TbXVLFSz5ovPdUo1SioUKEzowvDwbysv+HaHLxYO/3jY/xT5PLJB6C8tkpZght/Ko7Q0waEmbDc85Z01KS0IHbgIq5b/VnJDvJGHOxFndohbzxRAuas0BO6GfGomv4On6fLcfTklnSw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e5cbe4b7-2a8c-4476-560d-08d618120555
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0961;
x-ms-traffictypediagnostic: AT5PR8401MB0961:
x-microsoft-antispam-prvs: <AT5PR8401MB0961D3270E3A1566669142EF82040@AT5PR8401MB0961.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(9452136761055)(222181515654134)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:AT5PR8401MB0961;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0961;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(68736007)(25786009)(6486002)(99286004)(118296001)(11346002)(446003)(476003)(54906003)(2616005)(316002)(575784001)(86362001)(486006)(229853002)(2906002)(7736002)(5660300001)(305945005)(105586002)(106356001)(14444005)(256004)(2351001)(15650500001)(6916009)(102836004)(6506007)(26005)(36756003)(5640700003)(2501003)(5250100002)(53546011)(186003)(97736004)(6512007)(81156014)(66066001)(2900100001)(53936002)(8936002)(81166006)(6246003)(8676002)(6116002)(14454004)(6436002)(478600001)(4326008)(3846002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0961;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kDDr7RPwKylfSH1MDBv/KTDKmiEDeF/QwinFkwt/n2DIi0G3hJEFE9T4axofirPm9U3fnTZXtvkFma4LOpeIC6S8m/4F6bAgMG8AF8kTBAQUVNvPcbwuCvjWV0Dn9yWdSxkHkcwI+Fbz9D3wkrQ2bht0FUl72KwPoK4C5SoKDU8VhwzzVcjqBoLFZ9RZfLcmNpIXNfoBw933GCSgtBfzi14yTeqefC9ZOk2vu11mbhPmlCehuFLZ4bBrtIzh9LGxGq9mIZtqfK0mGwOS4+Nyc5cBbqJ6SvmM/oiCMZ9VFpZiiLgebVqM4WfixQFay4wpvHAD+bt3vPfko4BoJv2wo/qiBy2lsrg3WeQnca666sQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A8A9F59A15EEE4EB1D10A8094F9B84B@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cbe4b7-2a8c-4476-560d-08d618120555
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 18:11:39.6749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0961
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA5LTExIGF0IDEwOjU5IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIFR1ZSwgU2VwIDExLCAyMDE4IGF0IDg6NDIgQU0sIFRvc2hpIEthbmkgPHRvc2hpLmthbmlA
aHBlLmNvbT4gd3JvdGU6DQo+ID4gRXh0NCBtb3VudCBwYXRoIGNhbGxzIGV4dDRfaWdldCgpIHRv
IG9idGFpbiB0aGUgam91cm5hbCBpbm9kZS4gIFRoaXMNCj4gPiBpbm9kZSBkb2VzIG5vdCBzdXBw
b3J0IERBWCwgYW5kICdleHQ0X2RhX2FvcHMnIG5lZWRzIHRvIGJlIHNldC4gIEl0DQo+ID4gY3Vy
cmVudGx5IHdvcmtzIGZvciB0aGUgREFYIG1vdW50IGNhc2UgYmVjYXVzZSBleHQ0X2lnZXQoKSBh
bHdheXMgc2V0DQo+ID4gJ2V4dDRfZGFfYW9wcycgdG8gYW55IHJlZ3VsYXIgZmlsZXMuDQo+ID4g
DQo+ID4gICBleHQ0X2ZpbGxfc3VwZXINCj4gPiAgICAgZXh0NF9sb2FkX2pvdXJuYWwNCj4gPiAg
ICAgICBleHQ0X2dldF9qb3VybmFsX2lub2RlDQo+ID4gICAgICAgICBleHQ0X2lnZXQNCj4gPiAN
Cj4gPiBJbiBwcmVwYXJhdGlvbiB0byBmaXggZXh0NF9pZ2V0KCkgdG8gc2V0ICdleHQ0X2RheF9h
b3BzJyBmb3IgREFYIGZpbGVzLA0KPiA+IHVwZGF0ZSBleHQ0X3Nob3VsZF91c2VfZGF4KCkgdG8g
cmV0dXJuIGZhbHNlIGZvciB0aGUgam91cm5hbCBpbm9kZS4NCj4gPiANCj4gPiBGaXhlczogNWYw
NjYzYmI0YTY0ZjU4OGYwYTJkZDZkMWJlNjhkNDBmOWFmMDA4Ng0KPiANCj4gSnVzdCBhIG1pbm9y
IGZvcm1hdCByZWNvbW1lbmRhdGlvbjoNCj4gDQo+IEZpeGVzOiA1ZjA2NjNiYjRhNjQgKCJleHQ0
LCBkYXg6IGludHJvZHVjZSBleHQ0X2RheF9hb3BzIikNCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJu
ZWwub3JnPg0KDQpXaWxsIGRvLg0KDQo+IA0KPiBUaGlzIGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0K
PiBSZXZpZXdlZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQoN
ClRoYW5rcyENCi1Ub3NoaQ0KDQo=
