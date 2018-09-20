Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D012C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EB720867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="S4UBBBiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EB720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbeITI3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:35 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:53376
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388036AbeITI3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZLwyjfTQRNa4BG5cAHt9aCDn0Jx5Wj3LPR/YwUtseI=;
 b=S4UBBBiwLCoi6VLk9YLgUSmC4lIly8QbCvPzOBDcusTHtjyDWxpgjQitagEsu+6NhIHcbwEcf/sQU773ICkZCbDNAVG7OyBObwMFfN4ZCOhW6xVr2f1cjDSTNE6vCC0n8+zCz7sKSfnBqbOm8qNHKKp+OM0oDgARCoi1pVyK63s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 40/56] i40e: fix condition of WARN_ONCE for stat
 strings
Thread-Topic: [PATCH AUTOSEL 4.18 40/56] i40e: fix condition of WARN_ONCE for
 stat strings
Thread-Index: AQHUUIxUUI5r1Rf/ZEyc2I95/+B3ZQ==
Date:   Thu, 20 Sep 2018 02:47:55 +0000
Message-ID: <20180920024716.58490-40-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:qiXU6r2joLcvCxTGQhYk9ZCawkrnvBmdOKPpDo/AfGvejiFifz5wQYaSZTQWn4HHscIJbZSogvzmdPkD+lBsPFPPaEiLz3k/49bDwgXKcBrK7zDeebvuYGfFfFPnyR2YgKfW718l2M6R4KxPz/jn0tpsB0KrS7XEZ9N9PD/HYG3CVjdCFwA6bA4apKrgj/BAmqRxMqwbBpmflj4fcTmaIjXa8l2sFdkpqhUSnvRyUehevSGChwE+TdQTitG8+OezYSdm6I8A+ppEAcnHrRkcWRyfAyh8dN3HWha8NmW+PSJqaw07moabYv+iw0gBhQDNN5Wx+VcLMS7Z72aOpyPmCWjtcIA6xyRC6aEtRbWdIU4+2c1BWZMsXNf4PfjIbfl30/6ibPZ9nqlL+m4I579paMn19IlGLSDlZDEdIGnMYJ4F92Ig3Bq5vFkjODasS6IqrHxoBA/55SZtBko8UFG4NQ==;5:46g3KipYgEDN/WS9CgwtooLzmH4bZ1zy5UaFC+hRzzOOAHIk5tt6rIC1bJUIlmlAq0YjsrQw0irisWdaYdanHYO6lJaQqXEzHOmY13YzsKaqZdWXJgWcPSL7oxOW+sOkAj9qOlHpKgCKCNrb79YLmh7BmmjXXwvNRwZMn0spg4A=;7:lnr/y2Xq2FMa6nFaNDczRN03qoR/hlRjECg3cyWvfANLyWby1DUFI8RtFMrTXGLkBwhAiKwkr7DI0QpdbcweXcJFtcQQIpLGH3Z0vroEs7necVozSnJuN97fAHyYsbgxxch1v5zlp7+hLjHlmIrjFAMjy8avtBPHqP/eHlvXs6vsSPSH6eBSKhxsvzic5ru/2oKnTgYaEUDpBifa1M1Kyu7nFcPrJyLWuMFcxDSv1HCy1xpNDW1EIgVzegTI5XTR
x-ms-office365-filtering-correlation-id: 09f50f10-12fa-4c3f-31b8-08d61ea388ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB01654C5AEAF55DFD89F9C0D4FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(228905959029699)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Hj8OmVUwxMVAt0V2rMij8kcPVp79M+kLlOpDRo+J3LppSi7HIBHhytzqUrNF8fBuiLVweZsDdFqKCd4PsWOg+I8RB+Q5BpJkbPiuyR2nP8tzri8uNJWg67ASftFxTDY0KrAI4/bxDFbs7c5cYk0DOG8e6JBsnnqrpmPRtRu4v8RnysMVV45tuul6aYCcRzKqPilx5hvnwRuk5l7nJbTtlnhXxzgwNbcQJ0oBscMQQN4YT0WyYRA+iW6xw3qjlOC5sEMa7T1uN2Q94OpN0V0SDd/G1vOj/OT0gEJFAKZc3MkFqfKi4JrtUS+O21Vd2KeWMD2zyuTD/ttlJuS1XgfWFk41cqdbJPHycIesLCz82bA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f50f10-12fa-4c3f-31b8-08d61ea388ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:55.1168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 07f3701387dcab3a4fb0166098fb2754a1b927e1 ]

Commit 9b10df596bd4 ("i40e: use WARN_ONCE to replace the commented
BUG_ON size check") introduced a warning check to make sure
that the size of the stat strings was always the expected value. This
code accidentally inverted the check of the data pointer. Fix this so
that we accurately count the size of the stats we copied in.

This fixes an erroneous WARN kernel splat that occurs when requesting
ethtool statistics.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Tested-by: Mauro S M Rodrigues <maurosr@linux.vnet.ibm.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/e=
thernet/intel/i40e/i40e_ethtool.c
index 6947a2a571cb..5d670f4ce5ac 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1903,7 +1903,7 @@ static void i40e_get_stat_strings(struct net_device *=
netdev, u8 *data)
 		data +=3D ETH_GSTRING_LEN;
 	}
=20
-	WARN_ONCE(p - data !=3D i40e_get_stats_count(netdev) * ETH_GSTRING_LEN,
+	WARN_ONCE(data - p !=3D i40e_get_stats_count(netdev) * ETH_GSTRING_LEN,
 		  "stat strings count mismatch!");
 }
=20
--=20
2.17.1
