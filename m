Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D45ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E2D2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MqsbueWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E2D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbeIXVDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:03:02 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:30464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387735AbeIXUwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0cxnNgu73jPIucWXTVL+bnAEiP2tN42IZdm1vjSmgU=;
 b=MqsbueWZ7G7oOdRs3VxlUp+ZFjxFFjPSH6juyMfEVF1uldDGjReSfrO+sgBSwsGrkDgbCKgNsbsdI2paah27PtoUdS64lGdG67nb7tFDyN4T2eKDibmQoXeQan9/QcdWaCSA4W8uppInvhgBXQeRpmqlJlYA+5hvERbzAx8Cky4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yuan-Chi Pang <fu3mo6goo@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 09/36] mac80211: mesh: fix HWMP sequence
 numbering to follow standard
Thread-Topic: [PATCH AUTOSEL 4.14 09/36] mac80211: mesh: fix HWMP sequence
 numbering to follow standard
Thread-Index: AQHUVBW5XPfoWC45IkKS8vq+uQO2Rg==
Date:   Mon, 24 Sep 2018 14:48:58 +0000
Message-ID: <20180924144851.164533-9-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:+FFSEjMW0KRzvv8Jaew85ZOMyKXsihK6C8hsD6J1Vb2r0gLHPl2Gpvpl45DajCFKTNupcpSSo5Zjy8O04hsGvuqC64mc/MZQWbeaWCiVcBJdCIUAxxGiVHDh42AdCb29GMz29tGKoG1U4xfEUz7y2GW0+dAXyB+5MYY5TFywzro8GDeGHILBnYxtPpomp3FwmqYX/VgkdGjysTSVatLCdLxiGWOX+eBKNGyLpkLAmnIM98tVSNcd4b2Ftr6XE4jCsBFOttoLkzyZBEiucvdvgll71QBcK5FlqNzRwydNNyyu6G9o7PYrkNvv0nXK48kCbggx1jgxR8I5UGe8Mqm11+lX/2We/kXhzgtIHHCD2ckcK5ZVG87L6giJ66FitB7zy9qShonU2/2vGUrBy5sLODTrxppZJ9N0tw33PvsmMlSSkrmcAnTqFtK4oZwmJm2P9lbHh31ynbc5z6z1w/63NA==;5:dZMQoD001etrslGrWNDTSAqTD1MLNjWMaYUFoIVf/zmOSE5Kj8KndJMo1tWM2zxG3/AVIh5OPOOnYTrIs/DDSk6MeWTznzeoSNCl8L8X8DvRW4BXDaIaTdJ8+OjRdqZkj0kjDM5CMkToMk3MQ9lnrSmJD62skvsRVmy2bBD+3L0=;7:lCo2prj9BzCVFk6Oobenlmc6/0WRRIDqJSQC/basqY7C7tAQ/jCWRIppyVtMw7I7JxF2vPefICw1Vbom0XY4Ub01XX6UHP0E7rQeFYfdN0cd+Omlnl8ErQT9uSVxlEdG9VvUIshJ8U4KdRuZ6FvvxA5DV1EU6HdtLidN/HFU8zeDwd8fbv+yAptzMk7mnL4NvSQ6ews9ofogdvaJhFQVkOAtjXfFplIlWDvlPxzm1wbJwtkpDEjmrLhcYYLR9L1j
x-ms-office365-filtering-correlation-id: 5f7dca26-31e5-42e3-c2ec-08d6222cf61d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018198F2FD02A9DEC03A95DDFB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(39060400002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zrTYgGDpDUIdyyx+AwPR5o86cXwB+NWB67yFRS59NF5X1m0iuVAzA+9RX2RCFopoR910IARctak69GGdVwCr884N4UPOj8oPqcUzo2l346VGhh8PuWpym1RpIEK087XSQood1cQGpnCfBWkhscDcOxeEYjFRvcAcnGdIxfTT4xpmev8ulOkg1B3Us8UHapbZtByqn7d16Ye+hkZCLlSbiNEs0gq/GEqSYeUnimbmhtNHsA1903LHNEJ/6UPgJYefeOSgP/n7es7oAVHNocl8eDZakf9h50NSkr3+DPcmMibol4vDGdG+n2NAA4bkEgAsHxgrZDKTYdryxx1CgFXPkG8dT8iBFANwP+rI7vKey0E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7dca26-31e5-42e3-c2ec-08d6222cf61d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:58.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuan-Chi Pang <fu3mo6goo@gmail.com>

[ Upstream commit 1f631c3201fe5491808df143d8fcba81b3197ffd ]

IEEE 802.11-2016 14.10.8.3 HWMP sequence numbering says:
If it is a target mesh STA, it shall update its own HWMP SN to
maximum (current HWMP SN, target HWMP SN in the PREQ element) + 1
immediately before it generates a PREP element in response to a
PREQ element.

Signed-off-by: Yuan-Chi Pang <fu3mo6goo@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/mesh_hwmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index d6d3f316de4c..055ea36ff27b 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -572,6 +572,10 @@ static void hwmp_preq_frame_process(struct ieee80211_s=
ub_if_data *sdata,
 		forward =3D false;
 		reply =3D true;
 		target_metric =3D 0;
+
+		if (SN_GT(target_sn, ifmsh->sn))
+			ifmsh->sn =3D target_sn;
+
 		if (time_after(jiffies, ifmsh->last_sn_update +
 					net_traversal_jiffies(sdata)) ||
 		    time_before(jiffies, ifmsh->last_sn_update)) {
--=20
2.17.1
