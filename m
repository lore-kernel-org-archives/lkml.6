Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C4DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACDD2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eXMWFcL9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Hsnn0L7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACDD2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJJIPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:15:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55898 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725789AbeJJIPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:15:41 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w9A0qWqJ003406;
        Tue, 9 Oct 2018 17:55:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=b6y7/bG2BbJVxcJyDxk+QUmGlnm9kf0Scq8jJC4H44A=;
 b=eXMWFcL93YdFwNnPR2RXkUCbqAUm1234IBdbVLKt/uft6X9B6EOnxv3oom5oxBX59iy8
 xjI5s0gbeY+2LajxfzqFQXjb3dFtcdHlpcAJlliHrsJfNbUoYzfiK2HyF/r4kVVptQDc
 swJESBd+yLWMYAjdfadjcgZlyGJwHdeNhCE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2n13yb8kqc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Oct 2018 17:55:59 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 9 Oct 2018 20:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6y7/bG2BbJVxcJyDxk+QUmGlnm9kf0Scq8jJC4H44A=;
 b=Hsnn0L7gM5pLyI/LOXNA5zHrMH3YGX1jpJ2CG80QTyKgo6p9QvP8LmZSYYUXRuBIpmaEbgxF0cB9RT5MdxJlgk2CT+LNwTaeN7fr2Zk3IpPy/CbjkT4YWDzKQuipuhiO7cd7nfVa/LSeF20V5T7gu+XLLY43p/V7gVXkMtn8BkY=
Received: from BN3PR15MB0708.namprd15.prod.outlook.com (10.165.79.146) by
 BN3PR15MB0754.namprd15.prod.outlook.com (10.165.80.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Wed, 10 Oct 2018 00:55:56 +0000
Received: from BN3PR15MB0708.namprd15.prod.outlook.com
 ([fe80::7584:5268:e41f:306e]) by BN3PR15MB0708.namprd15.prod.outlook.com
 ([fe80::7584:5268:e41f:306e%4]) with mapi id 15.20.1207.024; Wed, 10 Oct 2018
 00:55:56 +0000
From:   Rik van Riel <riel@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Rik van Riel <riel@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 2/4] mm: workingset: use cheaper __inc_lruvec_state in
 irqsafe node reclaim
Thread-Topic: [PATCH 2/4] mm: workingset: use cheaper __inc_lruvec_state in
 irqsafe node reclaim
Thread-Index: AQHUYAC1cXmV+117hUiK8wm5KuNg/6UXp/uA
Date:   Wed, 10 Oct 2018 00:55:56 +0000
Message-ID: <9b7bafe74ca551c19c5470294a33ab5f9e8905f4.camel@fb.com>
References: <20181009184732.762-1-hannes@cmpxchg.org>
         <20181009184732.762-3-hannes@cmpxchg.org>
In-Reply-To: <20181009184732.762-3-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR08CA0076.namprd08.prod.outlook.com
 (2603:10b6:404:b6::14) To BN3PR15MB0708.namprd15.prod.outlook.com
 (2a01:111:e400:c491::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:180::1:7dc]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR15MB0754;20:+y0e0dFnSBwASoXtQFdKrYGPKUPsFcf59M0KNn1iiCuZon94Xi5xElNXfw9p0XJLKBCZTujzlAnNzhO4lCImP7G1kla86+1SR3x1xr+fSHTBoSwJNbk6ZMkkLRD2BvNycXl9jzbHE9FjH6/f5SZE9SNEC+h/MxaAYTii/kq6g4w=
x-ms-office365-filtering-correlation-id: ff9a2788-c06d-4b65-d371-08d62e4b229a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR15MB0754;
x-ms-traffictypediagnostic: BN3PR15MB0754:
x-microsoft-antispam-prvs: <BN3PR15MB07546C98C56E541219E0B9D3A3E00@BN3PR15MB0754.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(93006095)(93001095)(3231355)(11241501184)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:BN3PR15MB0754;BCL:0;PCL:0;RULEID:;SRVR:BN3PR15MB0754;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(486006)(110136005)(102836004)(558084003)(6116002)(86362001)(11346002)(476003)(105586002)(46003)(256004)(229853002)(446003)(8936002)(5250100002)(2900100001)(14444005)(2616005)(106356001)(25786009)(5660300001)(14454004)(6506007)(386003)(52116002)(6246003)(478600001)(118296001)(7736002)(305945005)(99286004)(6436002)(76176011)(68736007)(81166006)(6512007)(36756003)(71190400001)(81156014)(4326008)(54906003)(97736004)(71200400001)(53936002)(2906002)(316002)(6486002)(186003)(8676002)(12043001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR15MB0754;H:BN3PR15MB0708.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3l/z/BgNsRIkMITRf7RM8ay0ykEgK1MfnOsReD3BxzAzaoj0Ypwzp6aA4RXJnZUfKhfxo9Nj98BKc6053CItUNT6RJQB34rG/Cqv0VjZmQK+NWJ76xiAG+XFBWgxKBIWxzv/+uXDQrosVZcyMZDI05vftHTngEAOGAH8b6U7Spa0oknplE5YPrCkCZhWnF4k0gTjav+EOHbQ5NzvyVk80yVTlBIRumzDcc8noCGxrk+XTXHWtzKFvtCJujwNflatQwSEnbAYtJOcj9nmkKfzY5uh/gSJ05U4/FWkq1QtmvtOicvpa/hfNLivBcKisrpS72xtk8auAEjJfsnEeuH94lqWCt6HhOVlzY2Zmqt9lis=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7B1BE1BA1550D419B44172FB5F43B17@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9a2788-c06d-4b65-d371-08d62e4b229a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 00:55:56.1094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR15MB0754
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-09_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTEwLTA5IGF0IDE0OjQ3IC0wNDAwLCBKb2hhbm5lcyBXZWluZXIgd3JvdGU6
DQo+IE5vIG5lZWQgdG8gdXNlIHRoZSBwcmVlbXB0aW9uLXNhZmUgbHJ1dmVjIHN0YXRlIGZ1bmN0
aW9uIGluc2lkZSB0aGUNCj4gcmVjbGFpbSByZWdpb24gdGhhdCBoYXMgaXJxcyBkaXNhYmxlZC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFdlaW5lciA8aGFubmVzQGNtcHhjaGcub3Jn
Pg0KDQpSZXZpZXdlZC1ieTogUmlrIHZhbiBSaWVsIDxyaWVsQHN1cnJpZWwuY29tPg0KDQo=
