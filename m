Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2938FC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8185208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ntUJdm5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8185208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934890AbeFMHs5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:48:57 -0400
Received: from mail-dm3nam03on0052.outbound.protection.outlook.com ([104.47.41.52]:15680
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934806AbeFMHst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnmwh9axE8ic1PC5UAXd/04U/M5HzL9uIaRLRwxx9R4=;
 b=ntUJdm5IrYmXckTB34c2k8wrvfzRhq4qTInakLh1vfWSq7QKB7V1mmxPuo4bX5zvYxQb3ZVRmeoc73SkNAw8AiuVdXPhWLAGzLe+tTzQmJKUaZkQbLV3+i6MpIzFKTGuz+6ZUMWBSCJjSoGUQcjdcmvcjAqrjOYjqKUoAkt7nDs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 SN6PR05MB4589.namprd05.prod.outlook.com (2603:10b6:805:38::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Wed, 13 Jun 2018 07:48:46 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 2/2] drm: Change deadlock-avoidance algorithm for the modeset locks.
Date:   Wed, 13 Jun 2018 09:47:45 +0200
Message-Id: <20180613074745.14750-3-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180613074745.14750-1-thellstrom@vmware.com>
References: <20180613074745.14750-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0402CA0057.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::46) To SN6PR05MB4589.namprd05.prod.outlook.com
 (2603:10b6:805:38::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c749063e-13c3-4647-7351-08d5d10218b2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4589;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;3:UEE4Ep1qELWQhBypOQqXusG1yCClrXy9NtKNW3BZ6IyfbpnY6Dk+aa2G/0XXrCMwkjvbQi2muWTlHC6oKaIOdZDEX5LM1D5X/MSeDPxvbA9FGzFes0vClJwd3tt/dY8iDJYEB1wfkyWrJKRL4P1eIJjREMAx+x2o1kvfEP+F9NCuGLd/s1vS0dQQC5L9S2mAShZv4U2SRtEx+APeRqsSVza2w+ujBSdwxJ20tXz8slrRzm2fPLhmPT+WdDMIull/;25:7c4Li/Q7lOPTdSrLugrcVm0pLnTcouCrDbngazbeSbcwbeRNJGlRWXd9jMnmGzPq3rtxbBqQUBg8Ogtu8xsIRnImWqUxTMDcN/cZaX9Bzsb319O27DSmqGxWAZUThO+tjKKaKyKBPxLSS4UhG7S/yuL4d1XkH49/aIfjYyfN1CBMdaBG0MKTat+h2h579L11XZgxukBoqmQSNObW3oTmb25oGgb2bxOo6e82oZSDmyMal8BxbYi+G6yuaWGSMXqvcqvn1A9J3trwVwHDZGE2DHqa7yH7Vp+/1gXsVPhMwBvSSyiMsOmvk6zSCCKLu2HXPS1vQVUxdrnoqhiAcsD0ww==;31:wtOGP2Dd5MH5pB+A3D+apRW1J8pk4jt+VL6e1udqIIOYpxs9DP7UEvxVtJUIwWSNtCZaX1cJtMmQUaKwteHI07gnQV5WKvlff/ppHAhFr3A6AraVgl3m3CvE0q9CVSff5yvyRIyITaEFHlpX5G7qia2tbnVSwz4UrO3ahoOrg24sD/9QBTUtLSwCOkUMNxFLH9NQx6UrRf6aFHGioZsXWzP3q3CEAk3lViFgAfPtA60=
X-MS-TrafficTypeDiagnostic: SN6PR05MB4589:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;20:WObg+l6YtPZgMpijtx00DX6Rg9kzn06J8YA8LS+8TDW+C3eTUn5Vkw48sNO15bXIxcYHrJ3sPqKqDBiDwS1oI1BTexUxJqRW8WoSVHdfvEZ5Vaxxr+cRmY4OvjfW4Ow0r28oYGvqQ3lap6pyrRSQiNUCr3y5R85BpVUmSUxsLaKTDCAH891VYHv5gAbFs7zX2SRpPy0EZ+4wkUB3aleGKWP6xwi/eRWMwNQgSHxWQ3VdQZ5O6S7QW9YxW4WEIwItNcY35pW9TOluGUMP6SRT7C5nqDKY9yUdYB1HppkTVod7W2TkkTzAOxwsZQFKJe5jtaJ9YvCd+8IEByaa9qv7rv/F0csNrr3PEG2mEaxB+7ezM6X52p2fhMMiWJM605fldF+yQd4kWeMJ5of/3omcr960vtgdgMEGAfWJBn7wyrsaqoVd5U1exa7mMT/TsFqvYSwikgcWvLiJslYKeV3fZUGRYI5PTX0pymUqQAQ2AqasWDex/XTl3c2+uxAuK3sX;4:HnZ07k8cNi/J3W6iatHZVp5haCOqlauBBB1903fCNd7mq1dfuT/B+3HnFWrMDCKQWYbq/lO7Rm+gSfz1amA0khEGpTaGem+sibB7EiWME3pVcpAqGOGn3lCPpslG9W6LfDs3nN6pTt2LUKAF3e/e6x16ONlm9LwWkyyX7LzZsSUOn1Fo28pBPUMoWSpRyLzszFO1VMN+Nx2+MGDYDyGKgLEcSelXJYs5kQ/WZTXo6iCyvtSf8mN0DycXpY6VYJiUtuyIMSOo2mx62neMovnSGGdYOtHT4jX44EM+bKB3p1oFktjXivr/6yWp5sC84sBz
X-Microsoft-Antispam-PRVS: <SN6PR05MB4589902D62341B7D131310A0A17E0@SN6PR05MB4589.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR05MB4589;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4589;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(346002)(39380400002)(396003)(376002)(366004)(199004)(189003)(81156014)(25786009)(476003)(186003)(16526019)(478600001)(486006)(2906002)(106356001)(107886003)(48376002)(50466002)(53936002)(8676002)(81166006)(8936002)(305945005)(6512007)(7736002)(26005)(956004)(2616005)(6486002)(5660300001)(59450400001)(316002)(6506007)(105586002)(386003)(4326008)(11346002)(446003)(51416003)(76176011)(52116002)(16586007)(36756003)(97736004)(47776003)(1076002)(3846002)(6116002)(50226002)(66066001)(68736007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4589;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR05MB4589;23:8YF2WEqZHxMTjpVBXMUSgCyUQHGQnrJwxZiueHX6p?=
 =?us-ascii?Q?ove7+rnO6pFdYab0vDMvXOF9wbuMuy765U4Aqhf64+mI78RqKCEheuzTH74r?=
 =?us-ascii?Q?8iATtP5tdglp/8sXxl3Ht+KhNAwKjiJS72lUWblGPXNREvmyf6LOxnzJgl+f?=
 =?us-ascii?Q?ywa308fCXMRHZXydQ36csh7eKELDpL+resuqS09SE51xredB4PEAxMkbu27I?=
 =?us-ascii?Q?vi0GAodpfyVbWin9QRqgjEPZ60LalQPr/zDGQU9KV+4RqQA54R6MRLEXIIjw?=
 =?us-ascii?Q?ixDnQPa5R74Nht8T5eUrwAUerwB1MtDCZwMCGqDjb59JOE79hmhfha4IviCJ?=
 =?us-ascii?Q?yr/SAEPTRWqYtePnZX43cCe7U5lc+aks9MzJdgRgRbru8J52G1O79UjQmCcX?=
 =?us-ascii?Q?H9paQYBAxgbHkPP2L7uh9KkSIep1Sr+5x8v77FAA9HcesR4sMR3WxQFGn97m?=
 =?us-ascii?Q?hArPV9t/ZGKm+PT2h+ixvju22pcoVyqCLphjyQCt4Fo3xJ6Htpn15PIKqgmw?=
 =?us-ascii?Q?cYmW/29e09Ik9ffZi6ZGFRGRXJDk95QOoZPA87i1UXy/fDyhfkOSomPHCv+s?=
 =?us-ascii?Q?zd83R9A2ijL4K6zikMdyUKgog5V4rhNYi/xjDOawTVjHYm0rQJfVf0po8LPU?=
 =?us-ascii?Q?Dj29/WEKX0Rdb9iw70k8mwo8falijKa6cxMLFHsarChEAu4ZBm8mee5SBYcU?=
 =?us-ascii?Q?974ALCgkRKc50YihKFvghdTg/e42yVX13/D7xEoWOGtJBu9u15UClJuJQ5qm?=
 =?us-ascii?Q?c9zXnagJhHZPD6XQ5V4GQ6eVgueAR7c1gDcx1forVOvGbOm3XI9n6YBQhCGb?=
 =?us-ascii?Q?YtYsbY6SeDfVNpOZvqV6eXr3/Jx7B9CB5aQGCedj0BWIpiN3M7swGsdye4E6?=
 =?us-ascii?Q?QjfXUGgvfsjstOs/FwmgQ3u+abqKWwQ+dpwGxn70BeSOuoHkLbX3oMh0o1O5?=
 =?us-ascii?Q?WCmUMIUnOAW2PEFsM5pIUx/lJ4guRPmqabePkiEaIHB7XeyBqc+ZEZtLz1Mc?=
 =?us-ascii?Q?x+bdGCdBpR+5zzfpZIqXpWggelO1vQ90tozVc5Z+jkiQF43LfX4lzfCB8KMO?=
 =?us-ascii?Q?LoQinTADEe1C3MxwnDLCB45BWgAzeCBF0h4DdE8djJNQQefpleotWjwbUbA1?=
 =?us-ascii?Q?0cX9rbm0srzw4CF+VshXfCQ/Zean+jqks67B2c5VuvmwbeoAahQjTfsFEmpx?=
 =?us-ascii?Q?/J5Weq9OLJNiDGIGBe3ol0KddnN/nOMCqgNqran0mnopIDE59iH7idq6w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: EDkZJIxlbQVdpJQJWVU3GPQYLUy8w7apfEArvrEV3lsPmIjV3+/NhCeQJ3MgFoyyI0EJfSkPaRcVW7Cea4Vso3DJPF3O4q+vB7fDkQGX7wZFr6yVr0bqaI63y7t119Br5CCLYlFglVX8phnNGwceiQ6Y9FSCEz2DEXRAqYPVVh+L/7FJAeZpLEJzJr/JkIVp
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;6:P9EismZspYjCM1Q3MO31uPgml3JAOpNfavGZwlrXI2z5mcK4EQkiALbWu6XzCgjqUpk0TITd2xQGVeAKAoyXGWumL8v+vIy30aWVcw+AAG46rXmPRWDC6r1Sn2J6IH0e8HoUe2bVC4qcpAwBf19jzSK5V0nA+GH9CEQqRkTW4i6TKu9IPCTTRHslNDqTVUiPS0zQvpaq3MTsHCmSUrX/1lUH5yldriFs6xMq1rJp0HWyJAiOwnABE3iVslGcqEoci/JLxvJbIgY0UoqeDMlvJ/KZKTuVW8ejvihmL+rBhg6yOi/9BFRlB2xkg43YIJPV8emajteHpbpgBdOUbNRR5SR3552FJ7zAHyxubJAP7YW+WFXReUyztHkIj6vV1Ybm4/wboIcMVnoZLPYn0bAjxZHQWEDv+vphApL8y+gxtrDGIPNhIzz1ARR7nnbAsM66kk3gpKuXmND1wqLHANxrug==;5:6z3L/z7oe22ekNJXjizWAMZadZClXYH32Ja+LszSvE1kPYrxnW6e5cwg06OROShDez8jACpyheGXde4Ipgr4e9LAEFP4p6vUZzyU4qvRfLXVM9rg8DCnNlS/xk/HwF4kqE3MeIGiyO/Y0UG28DBi+NJodoeWbzYz5KtEGYA0ATw=;24:7+1/gEtB2T3IZH/Tu9iwk4o5/aAAHX+LpIlpHJj3aG5tg31N0c5NV4o+nArhaPF85M8aM1cFr2MjXQ+IAfR0bJ/A+GrpDcqNtmpcu0/GPek=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;7:W+Am4+YcO60VtAtIjRjhK7XUVbFQEX3/0TGlPlZIQeUrd4VJEydnMjze7AAPp821BGOG0BzhpKZRH+dpmKj7abDQZm6/GgCsW8yuuvF9ab/R3r7mu2sCwEDSAB/Cm/0H6WKg2q85h3IC76gBGWS5O+Fbj3iNexHtTcJySmLk3rtThKEJlnJO9US57S99iYQa+Gs9d197VCUbA3gpvnuwSbPmoDdnV3ywh5DajcfFz1wNtDsdesewK0v9MDRH1vpG;20:LL6bhR5qX3qef/62ci/qodjWnLzEIO4y1ITsG0soTwB6oX3imMXFTXGKX8aIFxA0JJRwT7YluBcXQJNY5ypamHJEt/VhdipuO6hcL73wBEehv78d3/A5tB2kVkUaRT/bsWsvVu1IK0OiQxtksBPwZQrxWkRdZZy8E8uLCxrX+RE=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 07:48:46.8374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c749063e-13c3-4647-7351-08d5d10218b2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For modeset locks we don't expect a high number of contending
transactions so change algorithm from Wait-Die to Wound-Wait.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/gpu/drm/drm_modeset_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index f22a7ef41de1..294997765a2c 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -70,7 +70,7 @@
  * lists and lookup data structures.
  */
 
-static DEFINE_WW_CLASS(crtc_ww_class, true);
+static DEFINE_WW_CLASS(crtc_ww_class, false);
 
 /**
  * drm_modeset_lock_all - take all modeset locks
-- 
2.14.3

