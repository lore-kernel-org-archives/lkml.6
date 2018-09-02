Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6F7C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F258C2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nIMHHY2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F258C2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeIBRUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:06 -0400
Received: from mail-eopbgr700093.outbound.protection.outlook.com ([40.107.70.93]:58944
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbeIBRUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OrLWNjlhD9Kl/YLUgvBtxwIWrsY4qMSVOsivD7hF+8=;
 b=nIMHHY2v7U6qUXpJ4MVAdOyuXtRjwZ7RQo+WDwpHyIr2Cvrds7/6u25cU+ijwLyvRi6+N+kQeHBws8iQSJMN3i3vyYm2Uk0GsDK08KRt9g8fKdpB5RqbzbqE/dVpZzFkgZsvs861wgXoWDqnTa2FyfaCbM4H1N+BmB8JNQ1g+M0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 055/131] ath10k: prevent active scans on
 potential unusable channels
Thread-Topic: [PATCH AUTOSEL 4.18 055/131] ath10k: prevent active scans on
 potential unusable channels
Thread-Index: AQHUQr1wtoFadkBsq0u2LsedgogPVg==
Date:   Sun, 2 Sep 2018 13:04:10 +0000
Message-ID: <20180902064601.183036-55-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:fveiMD6GwZi++PjO9Vf3JFKapTdkUHv+ICE6r/NPpGYUruADROr2Ji5pp3WHHncphc4kFbT8gxF40oyJxWqNPqNrAl1tp4n2ztqi2n3NZmcASJwc2zFNcyh1xRU/AX2HNE3D8ABzxUQhTo2DcZrEp5WTBnRY+jO6btVihW/vJp72h6SfWxw4AJFT40ctojAJdVmVL8m2lA4ItmQFdyJf2jMYJBzBbbuik22NuFZRoaF2PpSxMs821xjpoWPSgDpjr3VzP4/WQjr8yFSlDcDpHbzSV/XdjlGzuCSsVMCo2XCbRzLD3Mi/JK3hzyQH3psaRsZGSpfUCNJ9ykRuq8ltT+EPJzFBBKhrtNBaYtqXwScE0019fqUaMpJ79MNHYmK61UyMFx4ci1+fNsnRCbWEVLnxFH9iIX9Q5wlnaoXAFwzsMHSAld91ZTK2BtWkCPwsOFjE7EFXmb7aIKY/wPpDqg==;5:JKCEreXa+Xmve1a87uupWP+IKvcAjrh/F415jsV4N7oM8P9K1DTT4SlYS0NmXAKTAuhUZ/XXp9M4D4jxQNELSBvVpGsOA4puSbr0SqoufcDjg7mcIvXLNc4SAF//gcNhpmhhzm3QuzWy6Ycvfzd2HC4t6vMmvfcy4IHyYxNnKP8=;7:VUQ4UMxABodXobl7RJ2f6bMX2alBCGUnyNGL0noU+r9R8vq/1rCILALabyfbHcQ8bCfGKBNCaU4Tr4zJXJgGkdweqFk33iAzaNrJbpvq/eW6yKiKsPCViDcH4tyzoURAEHqMpP6vxOI+LO4Mr9eFgujhu08KEY02G2owLGtNfPoi/zKZFFU5gLbUXcu08HcGuPzsfuCwnB0dXdOekihFqPQQbCIjeXeptQz5nQ/cR5idAyQXnU0bXyEae4i0BJjX
x-ms-office365-filtering-correlation-id: c7f26d5f-a853-4289-a800-08d610d4969e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01203D31CFB7EB2AD9FECC0CFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t6p5Q6cK6Sw7Z0Z/8sUPHfv9NoCLAKH82jB1zpUCGw1/46j5yOCLJxOKLfjUmV3LqQD7Pw4gXSD+XAq4taIXgmVoEnCej7NuWorMkqj7wPOLVajX5/Kz2OwZ/xQSp2kqyHScpUVHYGZq9f/PkSmNSE3NZC7Ghx2sL89/z0lPFJ0S9G1TJ3wqtPdk20Cq0u8ArhPf68DDMumAWLvSfrhlz677ZvkUHOi4fBKrPa2R9uEFoEC2NopM9ssGYX8rEduJQhFjf7vRbNeEXwx3cnIey+IzEoecp02Q3rylXXEQ1bEwP5KnOK1teJOSvqK+KL43hvz8sWgEPdmrqEy7fcPauPDQCcC2bMS31UL9KZHvd9s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f26d5f-a853-4289-a800-08d610d4969e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:10.6016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven.eckelmann@openmesh.com>

[ Upstream commit 3f259111583801013cb605bb4414aa529adccf1c ]

The QCA4019 hw1.0 firmware 10.4-3.2.1-00050 and 10.4-3.5.3-00053 (and most
likely all other) seem to ignore the WMI_CHAN_FLAG_DFS flag during the
scan. This results in transmission (probe requests) on channels which are
not "available" for transmissions.

Since the firmware is closed source and nothing can be done from our side
to fix the problem in it, the driver has to work around this problem. The
WMI_CHAN_FLAG_PASSIVE seems to be interpreted by the firmware to not
scan actively on a channel unless an AP was detected on it. Simple probe
requests will then be transmitted by the STA on the channel.

ath10k must therefore also use this flag when it queues a radar channel for
scanning. This should reduce the chance of an active scan when the channel
might be "unusable" for transmissions.

Fixes: e8a50f8ba44b ("ath10k: introduce DFS implementation")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/a=
th/ath10k/mac.c
index 836e0a47b94a..747c6951b5c1 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3085,6 +3085,13 @@ static int ath10k_update_channel_list(struct ath10k =
*ar)
 			passive =3D channel->flags & IEEE80211_CHAN_NO_IR;
 			ch->passive =3D passive;
=20
+			/* the firmware is ignoring the "radar" flag of the
+			 * channel and is scanning actively using Probe Requests
+			 * on "Radar detection"/DFS channels which are not
+			 * marked as "available"
+			 */
+			ch->passive |=3D ch->chan_radar;
+
 			ch->freq =3D channel->center_freq;
 			ch->band_center_freq1 =3D channel->center_freq;
 			ch->min_power =3D 0;
--=20
2.17.1
