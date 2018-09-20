Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7483BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1981D21527
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DJGFHdVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1981D21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbeITI3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:35 -0400
Received: from mail-dm3nam03on0091.outbound.protection.outlook.com ([104.47.41.91]:20832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732415AbeITI3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G6JKJa2uFJErZoJeGSMQfIHrs1r2IJZrrH+fzzfI8Q=;
 b=DJGFHdVV28LMJSdIlOYsc0nN5FORDbgOahEGM+vnVoZdj1CLVTsqEwJ4XniBlt0RpSJ3vlg+g37m0T52b0AdV6GU6Bgg8RoOL68V6pG/bpnUSgddAmaKswXgqZ2BNlF4tgJF2sahuCJXiXKB3m+fE8nbY6Zp1F8vOk6dTZ8HgYE=
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
CC:     Martyna Szapar <martyna.szapar@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 39/56] i40e: Fix for Tx timeouts when interface
 is brought up if DCB is enabled
Thread-Topic: [PATCH AUTOSEL 4.18 39/56] i40e: Fix for Tx timeouts when
 interface is brought up if DCB is enabled
Thread-Index: AQHUUIxUXsR5bLsyjEyGiN7XzsqEhA==
Date:   Thu, 20 Sep 2018 02:47:54 +0000
Message-ID: <20180920024716.58490-39-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:7hEbgk8AWf2bzJicNMDoANfgYhckgph6e3HnMT9joWGQq+KpuY12q0ucfejyClB1fXNcNQjl/3+vU+XJ/lrvNXpxqiYr5sgGciRbJd+9n3ZZtyk2FbXIMPdVwrrxK8JThpSrZjfrYNcl2QAk7y0/Uehh4PQYpfPyKyD1jWApI0yxoO6v/vkMUDEobOeqm1LkJ1QOpSDhXL4u4Dm6h6zkK7J8CzREN+c5dTKmg5uurgnngoVKKF7kRf3IyWPHYn9caJCoi+2bbz7Aouen3vVMCcooqeN9AmuRXnM2UMS9MEo44oP6lg/FxGxog80+/A+ML790XEKy4mKs2LtgyjtSpAAaA3HN7Uxxjpsjfw4T/1zsamuyAhgdVOY5VybS4U9FF5RpOLvtFhtTTwaVKW6q5Tbo05JaPAoPLKYxNmdrTFaqUH78/cYH61b/C+s/Q4LoKRhSg+5PHa0Z10kfkbty3w==;5:Bh5dui9sxPpBlStQ8y7ekikUTw71f3B2hLkMDWiE2CLBM55jQVx4k9Ut6htZkDm8ANif8T1vhJVCzw/73Dbauu7/CsNdzkB61rdvzgvp1xBKtCuHFr0pBb4Ykoa5f7xGsKCO+R6gVYUoUkijGODtdx3w6EN/CPjfdfCxVhOVzRs=;7:LlzN0cLT2qVrcL6BGeJ4FR3lawkiMe8JlBz6bmAbbzxTCOvmug+RJQfYpgvKpe5SqyK1Ng1ibzS3720nZv0qQ6NJfVXOco7ntjKpqUoLDelXyaAi1UkcDuu60ssxG19MeX10SCnrRefFaOMvqc5OaUfZ0MWnr+9kc3OMO/7txJ6S7dB3LsYMUySiy1VOxoPCw6r6I+9OIP+smekmHuyZJiwoSZhpl27b6vqwxXDA5cQqziaTsiuYENYqidgUhkTx
x-ms-office365-filtering-correlation-id: 4f453cc8-cfec-47b9-8464-08d61ea388a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB01654D2079D5748774E1C9C9FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(575784001)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: M3T2GeKz1as85ia9rFTc4/qqGWX9j7meCWEbKk1SXtIINRtqTGtfmSxn8Bd4Kk/yf0GM7FvVVAuSznOmvawKryuScPjtOk3wN6XcXndckAEO7kRuBgltnOnriyDPCafWulUF7JmiJaK7alUsp6HAjutkcRxN/TgfDbkT0SQy77+P0R/W5X3fOiIIzoGi3GY6EaEdrCiAakYiOeEeF8OYo2hApskivCtg6fHzX2Nc61mGnWXWhgrVrV3YrKCQYvyGFouCyJ33upjC6kqTBV6GUu2Euok7klq6eF2oxTY/pr708UAHEhsteOSUQlVA3tvkJJkYrljAysto4I1QN6RrA/2x6BXsm7v19ybN9meG5H4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f453cc8-cfec-47b9-8464-08d61ea388a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:54.5387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martyna Szapar <martyna.szapar@intel.com>

[ Upstream commit fa38e30ac73fbb01d7e5d0fd1b12d412fa3ac3ee ]

If interface is connected to switch port configured for DCB there are
TX timeouts when bringing up interface. Problem started appearing after
adding in i40e driver code mqprio hardware offload mode. In function
i40e_vsi_configure_bw_alloc was added resetting BW rate which should
be executing when mqprio qdisc is removed but was also when there was
no mqprio qdisc added and DCB was enabled. In this patch was added
additional check for DCB flag so now when DCB is enabled the correct
DCB configs from before mqprio patch are restored.

Signed-off-by: Martyna Szapar <martyna.szapar@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethe=
rnet/intel/i40e/i40e_main.c
index c944bd10b03d..5f105bc68c6a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5121,15 +5121,17 @@ static int i40e_vsi_configure_bw_alloc(struct i40e_=
vsi *vsi, u8 enabled_tc,
 				       u8 *bw_share)
 {
 	struct i40e_aqc_configure_vsi_tc_bw_data bw_data;
+	struct i40e_pf *pf =3D vsi->back;
 	i40e_status ret;
 	int i;
=20
-	if (vsi->back->flags & I40E_FLAG_TC_MQPRIO)
+	/* There is no need to reset BW when mqprio mode is on.  */
+	if (pf->flags & I40E_FLAG_TC_MQPRIO)
 		return 0;
-	if (!vsi->mqprio_qopt.qopt.hw) {
+	if (!vsi->mqprio_qopt.qopt.hw && !(pf->flags & I40E_FLAG_DCB_ENABLED)) {
 		ret =3D i40e_set_bw_limit(vsi, vsi->seid, 0);
 		if (ret)
-			dev_info(&vsi->back->pdev->dev,
+			dev_info(&pf->pdev->dev,
 				 "Failed to reset tx rate for vsi->seid %u\n",
 				 vsi->seid);
 		return ret;
@@ -5138,12 +5140,11 @@ static int i40e_vsi_configure_bw_alloc(struct i40e_=
vsi *vsi, u8 enabled_tc,
 	for (i =3D 0; i < I40E_MAX_TRAFFIC_CLASS; i++)
 		bw_data.tc_bw_credits[i] =3D bw_share[i];
=20
-	ret =3D i40e_aq_config_vsi_tc_bw(&vsi->back->hw, vsi->seid, &bw_data,
-				       NULL);
+	ret =3D i40e_aq_config_vsi_tc_bw(&pf->hw, vsi->seid, &bw_data, NULL);
 	if (ret) {
-		dev_info(&vsi->back->pdev->dev,
+		dev_info(&pf->pdev->dev,
 			 "AQ command Config VSI BW allocation per TC failed =3D %d\n",
-			 vsi->back->hw.aq.asq_last_status);
+			 pf->hw.aq.asq_last_status);
 		return -EINVAL;
 	}
=20
--=20
2.17.1
