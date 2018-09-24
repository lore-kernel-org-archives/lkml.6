Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A68C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3749D2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jBShx/pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3749D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbeIXU7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:59:05 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:29512
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387990AbeIXUxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBst8aF2g/RU3669Ch2l1MG/SB4G0kRyhkb4kULPubI=;
 b=jBShx/pjVr1QG2WnFdFeRAru2rHHBRMnDzpzvDyG8uzI8JynRgYK1fuF9qazX3cqQl3oaCpJS98jmKMAheCzSVWBOe5I9qfNKRUBnLEnHO4ksWxsUegtf20CLSg5nW9Ob5VEWhK2xMOKLMB/s6AbagNzpuh3hGS4ZfPIp3rn9+A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 29/36] mac80211: fix an off-by-one issue in
 A-MSDU max_subframe computation
Thread-Topic: [PATCH AUTOSEL 4.14 29/36] mac80211: fix an off-by-one issue in
 A-MSDU max_subframe computation
Thread-Index: AQHUVBXAjxky80+fEkCkXkA6we4j5w==
Date:   Mon, 24 Sep 2018 14:49:09 +0000
Message-ID: <20180924144851.164533-29-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:TSAK2yvjeVaEF0u/aBWQJ97s9pOoLOF0WT5cFpYbaWtJrCX8rWWt6hy75zQ0bHG0rJla8uZIVUBRjGSWLEikOzoT+1LnbTMbm00e6YPTEfhDAziOhJr7qmIrPu90m82RZx3dtIDMHBgWlv7Wbm5fcfagUdWNaECKXGARh8zaFrTjTVjLlHTOV+5trMgMOIDzZ5+tKSY+YGQ0M5EcyRzK5lbDThL6jfZMGqKA9JxahCudELJRK2FUFESI0h50LQBX0lohZhZiqOqMBdqARJUuMKsFj/zfkq7Yc11upzsjQtQFGX5W3g69VQcOe+6jPQk+fh9BlxuHlyunETvB9J3izaHXesXKYqqesa7rDfR4XVHD5LDAHVrZrHhaLJukpiSD33BP5viLV1XiGSvviMjbRmjfu3plW/UUA+pDdprgb+aUmBQpq/FMx9AA3eW73WwUK0CJNnEqvzkNrpfuEAR0NQ==;5:E5dy/EGhnrVudiQHwdQxC2KTQBC/X7Iqo7oQt78iO8UOuh/jrgqywGF6fZoacxVH6QaezV86ELowL/by1mGeNpoCt9o5NedeDlmvdOBsmBGma7SO+z0pc6ppLRmKPaTD9Z6+2KhwoNpd7KZCZZHpJob/Ka4WDHB4KYKfhjjubsk=;7:r5kUjb3SiP51sLvHxawjvNlETxbUyFauxBb6OjG9mE2mXTSM6gNpuuHaVWoFwczP92sZu+4QqWdj6d1tVGnMtvKs45wUkBRtugVIbB9ohUSutx6a9uHaDhU6M4C3r6AVvoSCUdbJFpx8uuSWGrJUd0Hv+8W0H0KPJzXSqVTVuFCV94Xb71vzyw6cMyEySML6TvO9nQ9BVpqhFd+9hMws9QK6YcDMNSy38vhe9Mp90ZlJ9NEMEJu+O6Xlu3+hvra+
x-ms-office365-filtering-correlation-id: 40d9bd2c-c764-45ee-ef0d-08d6222d0d14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB047017761D7EFFC61B0E07BFFB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(14444005)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5YMcnJhopjoG9ei7JVp/LhLj70juc3ch8VcuDhdZWXycJon9Z2Xs/4tC35WZoKtS3mTAMhGMaxYEJ1CH1EvwVCE0sNvK11lwb4UNO+r0CHCzgmpNdoqTTlVZfN0OTv6q8j9XzPIsBeZqLQnUwKESAXcbVi5flrC2cF9/vb3orl1vjVxIcr3OUVGrS89h1sdgz25k3sHdx/4HW2llmLNoJ6Pj+sl6kmzvqJRRO6lXNha9MLjmdkYx97DRFy8IkmWSmqnFtkqrn/WsyCUi/CqZbPXhuWwQlLEttRo/YSifTFsj5h32wLY6LXocLMC0Iea3SMeNCTRz7g2EoAnA9RB7UiOPJPH74trjhvD0EmFXYkI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d9bd2c-c764-45ee-ef0d-08d6222d0d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:09.9158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 66eb02d839e8495ae6b612e2d09ff599374b80e2 ]

Initialize 'n' to 2 in order to take into account also the first
packet in the estimation of max_subframe limit for a given A-MSDU
since frag_tail pointer is NULL when ieee80211_amsdu_aggregate
routine analyzes the second frame.

Fixes: 6e0456b54545 ("mac80211: add A-MSDU tx support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8320282ec3b3..d8fddd88bf46 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3123,7 +3123,7 @@ static bool ieee80211_amsdu_aggregate(struct ieee8021=
1_sub_if_data *sdata,
 	void *data;
 	bool ret =3D false;
 	unsigned int orig_len;
-	int n =3D 1, nfrags, pad =3D 0;
+	int n =3D 2, nfrags, pad =3D 0;
 	u16 hdrlen;
=20
 	if (!ieee80211_hw_check(&local->hw, TX_AMSDU))
--=20
2.17.1
