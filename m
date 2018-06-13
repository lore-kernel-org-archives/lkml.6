Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 16CEEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53BF208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nBmBuJfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53BF208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935997AbeFMVHs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:07:48 -0400
Received: from mail-eopbgr710113.outbound.protection.outlook.com ([40.107.71.113]:11293
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935965AbeFMVHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLsu5mOfDQKIMivTzhIaTaKRxJZESks47J1xdCiT8Go=;
 b=nBmBuJfi/COYl0CaARL+N/h4OHxnyrea1tAfDiYGxOyTRiyGc1VYTPjO0TsJx/uQdIBlykKPXRdRBZYTY9MNYCaTmTXftW5rax5MuogVDAkD6dOJ8cUftTez9mLdBXmkY9MaFNp3k3yCGfFpc1IsJxQ/0SQarF2C6aM0dAhFh9k=
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com (52.132.114.24) by
 SN6PR2101MB0926.namprd21.prod.outlook.com (52.132.117.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 13 Jun 2018 21:07:41 +0000
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::a8d3:afc9:87ec:813a]) by SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::a8d3:afc9:87ec:813a%7]) with mapi id 15.20.0884.010; Wed, 13 Jun 2018
 21:07:41 +0000
From:   Yidong Ren <Yidong.Ren@microsoft.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Yidong Ren <yidren@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] hv_netvsc: Add per-cpu ethtool stats for netvsc
Thread-Topic: [PATCH v2] hv_netvsc: Add per-cpu ethtool stats for netvsc
Thread-Index: AQHUA03xJw7BTbCmTka+qtF/PXCtsKReq7CAgAABeVA=
Date:   Wed, 13 Jun 2018 21:07:40 +0000
Message-ID: <SN6PR2101MB11358FB238704629F7E5BC07847E0@SN6PR2101MB1135.namprd21.prod.outlook.com>
References: <20180613193608.444-1-yidren@linuxonhyperv.com>
 <4c853799-44e0-ff33-3555-41982d601ebb@gmail.com>
In-Reply-To: <4c853799-44e0-ff33-3555-41982d601ebb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=yidren@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-13T21:07:39.4538584Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [131.107.160.111]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB0926;7:NmZiDQVhI12stYOqLONT1oupgHl1YbikpPdqI4YuO90wbs2sJN13yKcwclwZNczR8Ha98jhL94oHwtmGgoNrmZeqjSvx4H7SFg7mezwB45XE23o45pSbaHbO8yWF9Y2hxaNLvhHJNjGgWtUeu8ZPV9qNPIKjEJGpk62AyttRn55FZQiGer5sUb59bY25I3ir5j8Ys33B5LBXcyKPPshnFQfNVWh1N35jor9bOSypG3uI4CJ0OJPI/kvvzQ8CPp+Z
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a4069008-f981-4241-bdc1-08d5d171b32e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:SN6PR2101MB0926;
x-ms-traffictypediagnostic: SN6PR2101MB0926:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yidong.Ren@microsoft.com; 
x-o365eop-header: O365_EOP: Allow for Unauthenticated Relay
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <SN6PR2101MB0926C9BCCBCED2843F39B1C6847E0@SN6PR2101MB0926.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB0926;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB0926;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(396003)(39860400002)(366004)(346002)(199004)(189003)(2900100001)(7736002)(10290500003)(66066001)(25786009)(14454004)(486006)(68736007)(110136005)(106356001)(105586002)(72206003)(39060400002)(3660700001)(26005)(3280700002)(2906002)(86612001)(99286004)(5250100002)(476003)(316002)(2501003)(22452003)(53936002)(5660300001)(186003)(55016002)(102836004)(2201001)(76176011)(6506007)(8990500004)(97736004)(6246003)(229853002)(7696005)(9686003)(446003)(8936002)(74316002)(6116002)(6436002)(81166006)(8676002)(81156014)(3846002)(11346002)(1511001)(10090500001)(86362001)(478600001)(33656002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0926;H:SN6PR2101MB1135.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 63bCUy7B7E4ozcslstO2kENbZnsi+O9nt5O0ChHbxGVsSr+Ma0UyyM9qphpesYJABpna/YCUERryiTo41tZk2FBQtUh7YWtqfH+ahSYCrENUsNhlMpcgU7uWMoPqRkSjiqDy4Srd9aS6VnJ1xktqaUh61fZcLLPWLPAn0ZeuyM1aTyL232zqQXHDF+8yUtoO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4069008-f981-4241-bdc1-08d5d171b32e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 21:07:40.9376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0926
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBFcmljIER1bWF6ZXQgPGVyaWMuZHVtYXpldEBnbWFpbC5jb20+DQo+IFlvdSBhY3R1
YWxseSB3YW50IHRvIGFsbG9jYXRlIG1lbW9yeSBsb2NhbCB0byB0aGlzIGNwdSwgcG9zc2libHkg
aW4gb25lIGNodW5rLA0KPiBub3Qgc3ByZWFkIGFsbCBvdmVyIHRoZSBwbGFjZXMuDQo+IA0KPiBr
dm1hbGxvYyhucl9jcHVfaWRzICogc2l6ZW9mKHN0cnVjdCBuZXR2c2NfZXRodG9vbF9wY3B1X3N0
YXRzKSkgIHNob3VsZCBiZQ0KPiByZWFsbHkgYmV0dGVyLCBzaW5jZSBpdCB3b3VsZCBtb3N0IG9m
IHRoZSB0aW1lIGJlIHNhdGlzZmllZCBieSBhIHNpbmdsZSBrbWFsbG9jKCkNCg0KR290IGl0LiBJ
J20ganVzdCB0cnlpbmcgdG8gYWxsb2NhdGUgbWVtb3J5IGZvciBlYWNoIGNwdS4gSXQgZG9lc24n
dCBoYXZlIHRvIGJlIF9fcGVyY3B1IHZhcmlhYmxlLg0K
