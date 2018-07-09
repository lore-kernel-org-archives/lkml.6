Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9112C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE3720852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IOX4jCRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE3720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932949AbeGINvl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:51:41 -0400
Received: from mail-db5eur01on0130.outbound.protection.outlook.com ([104.47.2.130]:1280
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932436AbeGINv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVIkMKluqF3P0u6svcyB1m2oozinjI9FUNAMv7CpbZQ=;
 b=IOX4jCRmSj7e69y31qvh3M3WtLws02hFTY56bP6NTCFCoklMAg4bgQtuM9tN6gVc3+54jlcMevJiUIqXKaBb2BmaDeRexPpEKkyuu7QeVRvPTgCZD0yNfritnXNJfWwjvk8P6wUpAQ9bJng01kDuNR/lE7pFMf+U0UXmogaPS6Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
Received: from work.sw.ru (185.231.240.5) by
 DB6PR08MB2773.eurprd08.prod.outlook.com (2603:10a6:6:1d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Mon, 9 Jul 2018 13:51:23 +0000
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jan Dakinevich <jan.dakinevich@virtuozzo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH] cnic: use kvzalloc to allocate memory for csk_tbl
Date:   Mon,  9 Jul 2018 16:51:19 +0300
Message-Id: <1531144279-26687-1-git-send-email-jan.dakinevich@virtuozzo.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P189CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::24) To DB6PR08MB2773.eurprd08.prod.outlook.com
 (2603:10a6:6:1d::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba6c202a-c1fc-4e32-44dc-08d5e5a30fa5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR08MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2773;3:ViU1E0vJ7Sa9YZQPjFC2B27CMl7hHPMLWEqRlPrMxL2VUVn2Z/dFBGMksSxNmyyOSGzLHEHu2piOXTKj6/QG5dbFPc6PVw8/t+Ya/sbBwG7mTBUI4qOwlQdnUz/VFoxAzpD+eXaN50Cxjoezr4zCbOTmq1DNh6IbsJ1l+D8UAZCliv+SYsIrTEVSSmdHpRG9sE/IGpsfdafrV5qcbARCr4S30bPSyMI1vdxF9lB16op+qIS5a2/qoLaEXuvLK/4+;25:KUvM6y+fEzFhmhNbRvhhrklIlbrapMiD7Gh+btDquSI3dseX30T/YOwmKGgvSORq48oNioz4w7B1NpD7CNSdhIMmKYHa4if0O++Vz3ZAzLufvGEvYcX8YOASOfHnIgTAgBH0QraxMYxX9lSWN+nMxV2MPJcn+yJQ3kemR74uG+SFkM7yxXJIdVufctFubK9WbkfQFIuE7Ie7C5nSkB69JJ06aGTqR5SxvgqskakpMgCa/EKQMjuEcGYs+gwHGD1Izc4RxQfTpGmzL097TWTrO/32x+In4jglxoepoQGcSwSk6KwFjGBAZvdPVEpdDs4dwkHJPu6SSucTOL1AaflGww==;31:aYmc66ABaauPfGcf9Uyye7OBMQ9Dcj4NQyKJwe7SxpwSbNmGhl2kWT5fhRjTLpc5B/ITYAkVW88VjM76DhqRf8hcGOGK6EwOiuPz4rpy6YRmzuJvpImRYFk39jM4NG5QySSXHt2emVL5FDnCatFHU0j3cHpnrTkGYm4rR4yWTnKJuws7+FcDqK76xq5CgDEpBsco6/KX0Au+g1Rz0Q2BLdfgJwfL2ZVp0JN+JSYErM8=
X-MS-TrafficTypeDiagnostic: DB6PR08MB2773:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2773;20:nYs7NQR24nbToDvt4j9qeF2fa/7uIDlCA5fWLPxkYyNJiLRW2kxHrt2FHIaC+/iFjLsQB0Ea6EG67/kN89W0wBLpCfB7xIlIM3YdIA4nKPotgP0fKIYegsTFpKoZfeXf0LguHpaShfoLyn8VB9crfn3fLWMZQ/nB0Yt69Y8Yee0PoskbmNnV+qqSMvO/zR56WxS1y+XtRRsN3Usvs/iGyL3nwLje2JkD+/tg+Lm/oTAfnENzA6lkm087gStzKQ69Vxw75sC+G3dia2LLs10qz1Ed4+UfygeISX9yUVo4IMxTWLHfsDTPkmiMsFJsJ5oyqhGWL8FSiwkFZDhZLZtXsytVKjqb84hygw8oEnUIMYt7y5KllVzeBcMe07PUallA8DmOZ18nbj0tF/lrVWfR4tXimhRYPgCtrtiedQTFITiYm1au7hc4mmv6MalW0OeVG2ubmFCPp8FIak32CaKAUPVLuW3M3qRXR/qQkBBPs0uqEEnAATq2oG0fstM26E67;4:n6V9oOIUMSJ59kwwsgs6RKy1vzzU0jA1eg1dpxg7uTYf5sxtRS4zw9gcvtspF8OzubMj8MF1a+lKGlzRa2NrD3pRDR8p1WY49o2kfRWn0Sdj4vkMetBW8OH/mlc6jzV31I1m4hjBi00RpkKbhy03NZ3IoOyjJHLg3z4RYklMlcwlGkOO8tzQ/MkG5h3TYf2gYm5LC86YSlUaa2SgRKzPowvXVjCWGM2xs6JAW2uLgnMbco9kD3OXixOaATwSxxVafVDemr6LsGRpvKzziurS4Q==
X-Microsoft-Antispam-PRVS: <DB6PR08MB27730A0980BCF054F69C5F8B8A440@DB6PR08MB2773.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR08MB2773;BCL:0;PCL:0;RULEID:;SRVR:DB6PR08MB2773;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(50466002)(6512007)(36756003)(66066001)(5660300001)(47776003)(53936002)(97736004)(6666003)(107886003)(48376002)(6486002)(69596002)(4326008)(3846002)(478600001)(7736002)(6116002)(105586002)(106356001)(25786009)(53416004)(26005)(16586007)(110136005)(54906003)(1857600001)(386003)(6506007)(2616005)(16526019)(44832011)(956004)(486006)(68736007)(186003)(50226002)(14444005)(2906002)(305945005)(86362001)(316002)(8936002)(52116002)(51416003)(476003)(81166006)(81156014)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR08MB2773;H:work.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR08MB2773;23:9HRATBNMPcIhePmM2cJe50LhyeJ4Hb13BEwZUlP+5?=
 =?us-ascii?Q?FMqmd7YAgGiUQWCzsiT3l7m5+jfuBLh71hm2YOWlruR/0A6MYjNT1y0bakqH?=
 =?us-ascii?Q?1JMleZqtGez+ITtd3a8gxC4zWbCehbl3ly+V5uvVfcq7tBTyBE61UWPt/XyC?=
 =?us-ascii?Q?96XPWO66NF3PvuTu8Sxcrci9WRl6P5ttPgrqME3BWqhnk77XPBkKCNmRoUA9?=
 =?us-ascii?Q?hAUA9sRfv/yuzTg/cZVOrNw/0gh20lroy/dS3NyFUVZe3W1lGSKsYK2a+LVA?=
 =?us-ascii?Q?F4BvlHZhl7yENQq2NTpBQpm+oLErzxRx6eLMXCjZGKeecjJnTX9ssQ9Qwinh?=
 =?us-ascii?Q?BMGasO6Mfsu5xCp0GxOmSpadx0qOUYrL3fsXV76eAnepkFm8FdtIDz+VC/FD?=
 =?us-ascii?Q?jbmVpIG9G9ZYKYbTSQXrcjAANioN4ECIDkpyA5MUo7lB9kEF92JG6+U0d8rq?=
 =?us-ascii?Q?q3XHKgW+EnNlRZZJjz9+cRhbF+6VFNusaejMjfuGv04lhlq6JwbHEtBghm4L?=
 =?us-ascii?Q?tYuf2dFcNTn2GKBvBNQ3NUMBoWCBrhcsdZRuC6WDLem7vzSKuiytzDLRwd07?=
 =?us-ascii?Q?3bbdlqqf0YInthoJOJhPfk0K3TGpXNL39+aV456uohRbtwcj1tuHzEoJ+5Ja?=
 =?us-ascii?Q?uyWJZcIBOrDfTe66oXy4fHPxKbTcTl8oNh30Q3YXYEL+jJ2R8L1bMOQootHY?=
 =?us-ascii?Q?CohqU1fcU1SiLK+0YOeCUKgTB4PoULgUwJaFSVid7JuzXFutGK06d63wY5B5?=
 =?us-ascii?Q?HZIBMskPh5Nm8fj6/q4I5BgpVuhEkiO0TYz1AYt7cYYZIXrmRD3UMYVTlHN8?=
 =?us-ascii?Q?xLI2fxy92im1jZPgsl88OjuyAXDj7npeZf9gdXGCpvE6U5YZ8+gXxQqWywgF?=
 =?us-ascii?Q?hOueHRk7EnE0ZeLpk9BZAkzInQheE2XppwuPk5eUDtoj0R3uExyVFGqBZ8my?=
 =?us-ascii?Q?0eMeoeS3yqwHQv+IQpK/o6Hnbvtv4Yp1WJ6mTXg9Zcc5aWvotZVOylnhFTSF?=
 =?us-ascii?Q?dpMbT0Jq+uZG8OTaOslpHvYwX5ImhXnxiECLGUvDlC1/R2UL8Kg9PMdEyRi0?=
 =?us-ascii?Q?1xFLO1AQr7D/0qUA4EeIokcirHMjrHPgCVUabpp7Jwk6y/bNKh2jZ/dcTOlU?=
 =?us-ascii?Q?0N9V+ErRNCEC11eicaY/QOuG2UyUM4LwbojVDvSpM+SIaqaNvpKmN5d33uoR?=
 =?us-ascii?Q?/YcyT1IkeiGfay9YzfXONep8r6xVC0KNZw3CeZoYbKaORWtbPB2QKszCIF1+?=
 =?us-ascii?Q?zQFSPrK4ffOBC8GQQA6XFdsQzvXDgiWri3RnC9z?=
X-Microsoft-Antispam-Message-Info: P/w7V95Se929CmfXDkslji0xkaEf3MBJAx4Q3+7o1HIrBk0+iTDLrJ0FdNGg/jcHqDInrkOyIac+PLp9ws0Zqe7UBEXelMoyNX8nJDTwQ3EtCig6LGQ5fAP/OhI/gB/0sbHr6AsnWIewB495kc01it4ZfCBBQvmLGd593lSx564s9DCfiHvQyfLJ3q+vQYRGOvOsGwJrO+FzOWc6GcfSH8ORm2jd9268QPSDuipRYKzZIyE+s6lyessrTM+5pxDACUN9pEh+qSFNdy+Mu6xKqXbIviXo2REWJCCUGasTgFNnk5mFrcGreB4a9sV4VHf+aHZH7uk4/yDCsH179wbgsK82Y1cdL/zNlMde8GPqtc0=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2773;6:s6fZYpJ+0mI8ZcAzxyZGUx37RhYXgU4G2d9XUUIzqByJjLZo39pCqrR6ZtHgEvb13aOIpjmdcHSh6pQo1lGWrSarfxE/OQ3u3Yyc0dXlJCEbKFs1X1XflwIGhwk6sC2OPLiuJeKlh0h8g1b7XMNzzgLSUiBJTJmowdPA6lFebMmimybCWEd5BBJEqOHpVx4LOCmIe4vO08To+5YVPT/veuF7f55IEqI1659DM+qWaFb/CM9CfYm00y7v9jTJR8HyK7bmJcoxeCfvX6HztUTA4m9tL0iR5hE2XPpVJvYpSwxAPrvpgt3r14voKnMgawITTrMG8MM4Pz8sqdYIUD95XBA5+ERBLJhdLbzsmQXzuneZDz0OAmnJ9uQgyZgUeC7gcxDdjj6nHWFrreMt7+M3kBAS8ZL00bH/b7zCDFr2MW9/mo1Bay2t/LXc38lblhhOv1JApZRnacFXKSlV+1OOKA==;5:wj8UsDJcdZkqXmn51kQESns6Zrr5qLNm6PH/ydMOGtQxux6G4spTjJHdDsn5bduegokzzSBtUFt71zQlkJE6a17DXTucyLkUzVCcHylqA6ocTbTcI5aP+hutPHwFlEkhjOg59qYeU55GiMvbh2gjNCXFTQG7JiAZUPOPqiEcXE4=;24:8CEDVB+fBhtBlQquOycLzJO3RBufWdvRQfCnWOaFnQVu2Dl+fs540rMMVfD6bVYndV3PeR71otzJA/qn68mCEK8C/pnKRcKQTO1+naFl2Jo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2773;7:HJ3Kr7YjccXItC83Ll8afu/8/7j9MgYxbUM2F1z+hmIkequfZO1cW1rY7LT2TbdEIMQXT8ofjWy4goKSr2FLtw53vlWFKTcoM0XgWKXAi9S//jse5uFSaN9pX3oVN7EirjemHQN91yAvRORu5rQtRV3tbgPWoBd3EbNzD0qJF+uF9Luqpi7s84bfRvwvLqbjmVMmaTtVYhRBc5elnFbZT2WsQ0OlE5hXDTpWqx7BwT4cok7b+CfKNwizITKbpBH0;20:ICGSbCPtisFo2qgrwmsrBLso3U3pCNowQvX6PXwVgzj+QZXP6fXbGclvPaT2Mv6DtD2ZKfOuSg8Tyru8Ivp1CRDFu246pVhWXamrZGTR5w9ImHENNPGrgRFnmjtCFbl9ZjES0YfrccQ+eeyAERCvXq5CUL2WA2vAS2YQJRXiO/Y=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 13:51:23.5373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6c202a-c1fc-4e32-44dc-08d5e5a30fa5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Size of csk_tbl is about 58K, which means 3rd order page allocation.
kvzalloc provides a fallback if no high order memory is available.

Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 drivers/net/ethernet/broadcom/cnic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index 4fd829b..1bc5d4b 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -4090,7 +4090,7 @@ static void cnic_cm_free_mem(struct cnic_dev *dev)
 {
 	struct cnic_local *cp = dev->cnic_priv;
 
-	kfree(cp->csk_tbl);
+	kvfree(cp->csk_tbl);
 	cp->csk_tbl = NULL;
 	cnic_free_id_tbl(&cp->csk_port_tbl);
 }
@@ -4100,8 +4100,8 @@ static int cnic_cm_alloc_mem(struct cnic_dev *dev)
 	struct cnic_local *cp = dev->cnic_priv;
 	u32 port_id;
 
-	cp->csk_tbl = kcalloc(MAX_CM_SK_TBL_SZ, sizeof(struct cnic_sock),
-			      GFP_KERNEL);
+	cp->csk_tbl = kvcalloc(MAX_CM_SK_TBL_SZ, sizeof(struct cnic_sock),
+			       GFP_KERNEL);
 	if (!cp->csk_tbl)
 		return -ENOMEM;
 
-- 
2.1.4

