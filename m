Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAECC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8412083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iHGIL8j4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8412083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeIGFOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:35 -0400
Received: from mail-eopbgr690135.outbound.protection.outlook.com ([40.107.69.135]:4506
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728868AbeIGFOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gj3BV7dXKSVqaFzof6/mm/cC87HFgZvqLRpCgFokRVc=;
 b=iHGIL8j4JHNIldYKo7uSv0sWy+l7al5zf31CbwT1kOftuWIX9Yyq8u8AxIMu0DuV5Zcuqe8QSeN+D6Hcz4FxvbGZvS9iSfuKL95xVQDLBBng0TqiqE7gKbBrUE7CcnalEtKerO4YhaYz8eZm7QQwK9Ij/xtbcVW4fQzn6HdLxqc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mikko Perttunen <mperttunen@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 20/88] clk: core: Potentially free connection id
Thread-Topic: [PATCH AUTOSEL 4.18 20/88] clk: core: Potentially free
 connection id
Thread-Index: AQHURkLDAUz3Z7IyaUO0yMPJCMDHjQ==
Date:   Fri, 7 Sep 2018 00:36:06 +0000
Message-ID: <20180907003547.57567-20-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:HOkvaPhtcVCI+tciS9BuUuelN0R8hTh5ieXY+MCEr/UN+zAJkTitN+ecUv9xBLf8wq2yUUHbEIPw7VgA5/BiDPK5wEwzdiIBGo54SPMD+MBld2gEsshKaSEmaQHGYvgyrVCTT8wwouHXXol40mYn0VDOeF2bfCkIxIrjAikiVR4oIzUfk6xAAQKBzpeKL1KwB9JR8WzbU+ltEyvWbKPubCcKOQ8Mdi/9qrqDurLm1CKQRoQck54ZgtH3lamPZ3iP/Z1W+xtOS8d3WuNn4IcILnf0bRAZQU+RDIk7ZoCsRtIk7PVsiR7QQyrGU80cXgXrsmwnMrB/QOR9348T+IBkNFQNC5O42ds9GsCmV96J8WhwLsPB4dsNxsWxTPa/Y8oXC5LZuv8K3MrUVHVAOO6TK88mzRjq6Cx/E6txZRyLcTG/W58rCs8JUWpYm45m/+1WV+ADThHWTIMUl6ZYAvPtRA==;5:WOqASOzciFY/ZxgKEwiBFhBRKz0/jEcmBoNLsFCmf1wFWN6Sqqh41ddwr9jjQdkSiVo8Hu1O0gi77Gld8WTpZSohEREfCcsd3u6KQnSLYtdwA0d9VzMgxlStLRgUxbmCyj1Asb/Wxq4MDc0Mzb14Wi7Vu8yIxREAtl/1Unuj8i0=;7:8tMkRUu56c3prW3XE7mPEi9XRfbHqI+bfYeil3K/x/o/jdEKpoilFzXJg4qdP6gseQVnhfKEMVb6xX8CxAtf8kZeH8aF5C1QSaJVlYiFqX8tG/opDOIn6f6xRfSwbOU+Vgyr+c/MOLM8rhJV6wimTOIQuq0Pd0B/xvELfLxbhn2Okxw83waJ6RsGwt080Zaoz190jbE1vENO9CyJ59NN2UQGn8mlBzN9TnTCAJduaC/3d7YdMZ06S64luqEZEGl4
x-ms-office365-filtering-correlation-id: d7f6730e-7c79-420d-e25f-08d61459e657
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07739A02E5FCEAB60D7E5CFBFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(18589796830644);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yBbKS8okd46BLDynFP2EBv70obO8WJ9eS3RC9AJfEJECwZtsBxrmDUoOIac0fA7YByVUvabwfYzHSqltm5/A5BZfWOaENCi2yDHxRGG1VlV5PvmM4SStT0UWCBUvEDIENMiIyZCF1bIWvQeaJva9oSD8XAnQehU7RC3Ha9U3TH//BSh2V4/zbMOWHw4enqh/jJ9NOSYFW1cVlV/BlRpF576BE//m0BsLc3Dpd8mzlbaTSJf6GOVGUJuh84UmMH3xRYPZRIhfugh7k5G/uw1XVkBO+IX6OF7VFKaUya4wj8RhwY4RAKY1mBgw7cQiko0rEDiNEw2gceAiEThuLfmLJS1QTKzZWEgiaXeyb+4e+bU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f6730e-7c79-420d-e25f-08d61459e657
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:06.7356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
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
index e2ed078abd90..2d96e7966e94 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2933,6 +2933,7 @@ struct clk *__clk_create_clk(struct clk_hw *hw, const=
 char *dev_id,
 	return clk;
 }
=20
+/* keep in sync with __clk_put */
 void __clk_free_clk(struct clk *clk)
 {
 	clk_prepare_lock();
@@ -3312,6 +3313,7 @@ int __clk_get(struct clk *clk)
 	return 1;
 }
=20
+/* keep in sync with __clk_free_clk */
 void __clk_put(struct clk *clk)
 {
 	struct module *owner;
@@ -3345,6 +3347,7 @@ void __clk_put(struct clk *clk)
=20
 	module_put(owner);
=20
+	kfree_const(clk->con_id);
 	kfree(clk);
 }
=20
--=20
2.17.1
