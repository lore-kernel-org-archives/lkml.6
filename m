Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB00C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0817220844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QwjiY9kE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0817220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeIGFbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:31:55 -0400
Received: from mail-eopbgr710122.outbound.protection.outlook.com ([40.107.71.122]:40960
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728295AbeIGFQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JL/60+GdyRIbrLanMPfiaJeqEym2zpobdDMeBlG4xk=;
 b=QwjiY9kEMxuq6z55xnd/q0vgf4ksem2uXIzBvnmnijlF7mmQrzbUpNoj34ooBdEB2jP/aHpdHqC1kjpvyHTCbWxs7ipUXVK5yL9r6xxP+8RY5fgu8yQ7H+yTgVlL2yDOXiQuR1oa4wkVHQhCi1ckCVdyfIJvmEF+GTEI3e9nOys=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mikko Perttunen <mperttunen@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 13/67] clk: core: Potentially free connection id
Thread-Topic: [PATCH AUTOSEL 4.14 13/67] clk: core: Potentially free
 connection id
Thread-Index: AQHURkL1zWJ38iPOZUS/L3gTH96ByQ==
Date:   Fri, 7 Sep 2018 00:37:29 +0000
Message-ID: <20180907003716.57737-13-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:kbAC//mOPkeuNEkYUbPjR+aiqEQ9zYpnARmUkXlVxSGgxx93AZU3ts5C4KLnn/ZIDZ0mxC/9RcDaQdDgF/X/2GAVFk4UZGxxjHiS4RFsa8D/viWKjGOvcKiDl6LG55NzFjf/7+WDHS+lm/rYePIf+94K/9KKbp1hJ0xvL9hj134eUe9UyfLzG+IUy93oWqo/tArpIzEnh5FLfbZKntbbj0c7wnwDt5ckXnSnvXmwZstRXR2nIDjCO0Q2xk2bzDokwkW4WoybdpDXeImiHcRcHSvjcHyEuq6Wet6wdYT9vK+8NfH0az3/xVvYKqpdxsdYvEy0/KwgqHN1x5/8m39WMb+vT99l04wtpmLpYi/+CjZLLEEb5ItBQxMJCN+pjIXwhOlqdPlErFafqp6ZhE9uOBuUqHApzHlgGnkKFGUtlHDmOwar+fH0ZnxVQC1LmKtTU9MQsXnUSQXqYVnDDBVxSg==;5:z+k+MuAc7ypbkKiP9IJJrQeh3RSUs/f1egouRHPeKPrT2JHoD5XQY5Wf3hycG9BsIqZk58aFTun4yylMi+lqLsHb1H9D6KBF3gBsOCOG4Hb//nPM9i6sbwU9HbQcSgEtt1fzrXBcq3sLVEreH5cRGw1Cnca2tPkyNI8rSaOsxZU=;7:OBp1gPX2AqXd3i/OTWCtlOerzppNIvNN4mc7s3rcewgzvbNv73EfrV8x/hKuw583N7VYGV8pa7g7f43VwO78SQNOR/Vd2HdxNy0oDrMe0z9EFXRGXmo/KRrbnF4f2h15xZe4u0hFlV1WCvJxVLMFtClCWzkVuELwkBq2sA4RReOaNuDXiUOfXKUCOLHnrl9sK8srfZA9kGa0wS1F+ida+uozm8B/XffH+JnCYAO2ie2/OFVk0C3GJPMpArhf9IEJ
x-ms-office365-filtering-correlation-id: b1fbe643-acd6-4d88-2c84-08d6145a33f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB08395A076B5939330288A9E6FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Ro6qVC5S7is84H/o7JA/fFUD95btBn52Yqne3oslmZ6/csDvjqBS5tDiLAK/GR2cSRgp0qB9pK1ZnrVBivnDW3oyLpzLUgb7JRX7OCea3DFrt7PakXEOkRSgfJzkgP5/wLsv9xit6F4mNaqcqy5tUPi/txcBbhOkHx1yz/RiqvRpizyV0EVVFhMHRDYvsj7Kov+tDG+1vCy62n600ax/7ovFsVJi1TOhpH562H1s/E1VBoGDXhPTl2Fr3ofqq/6aHfQ78zlfsQi+Oq3y5ycXku6CFFGJNKEyyoiwLze3MHixc1btfwmc1iPwN/m5/N+nDvEDa16YkacsoUrRNl95sz2dyIYbKT6TKeRQuWxhFSI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fbe643-acd6-4d88-2c84-08d6145a33f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:29.6046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

[ Upstream commit 365f7a89c881e84f1ebc925f65f899d5d7ce547e ]

Patch "clk: core: Copy connection id" made it so that the connector id
'con_id' is kstrdup_const()ed to cater to drivers that pass non-constant
connection ids. The patch added the corresponding kfree_const to
__clk_free_clk(), but struct clk's can be freed also via __clk_put().
Add the kfree_const call to __clk_put() and add comments to both
functions to remind that the logic in them should be kept in sync.

Fixes: 253160a8ad06 ("clk: core: Copy connection id")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 6f4c98ca6e50..a3f52f678211 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2557,6 +2557,7 @@ struct clk *__clk_create_clk(struct clk_hw *hw, const=
 char *dev_id,
 	return clk;
 }
=20
+/* keep in sync with __clk_put */
 void __clk_free_clk(struct clk *clk)
 {
 	clk_prepare_lock();
@@ -2922,6 +2923,7 @@ int __clk_get(struct clk *clk)
 	return 1;
 }
=20
+/* keep in sync with __clk_free_clk */
 void __clk_put(struct clk *clk)
 {
 	struct module *owner;
@@ -2943,6 +2945,7 @@ void __clk_put(struct clk *clk)
=20
 	module_put(owner);
=20
+	kfree_const(clk->con_id);
 	kfree(clk);
 }
=20
--=20
2.17.1
