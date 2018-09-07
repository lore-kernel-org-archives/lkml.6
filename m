Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EBCC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4B920844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GJ4lf/of";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="k0QTgckZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4B920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbeIHCSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:18:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33750 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728060AbeIHCR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:17:58 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w87LXsrs000946;
        Fri, 7 Sep 2018 14:35:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=oTxGKhiP+NEww54oxcXkTwqCdMKJjkNRMV5elPBvqmI=;
 b=GJ4lf/ofUcU9QS+BM+sKi7llUtw2RDVadn1CgL0Gwg6Rirfc/86oVSE3zNWPD/9JqbIW
 bA3PYQQ4kSiMtkTngP0R6k+zW0vF6HWsXk7UtSTheM+Lsqid+BjQ7scbbqGDLOBIqtM2
 VQD+38n3ie8ZcZLByk7TKHAxtu91R2fpF2k= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2mc131g1p4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Sep 2018 14:35:03 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 7 Sep 2018 17:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTxGKhiP+NEww54oxcXkTwqCdMKJjkNRMV5elPBvqmI=;
 b=k0QTgckZu4lgG+BJ6msQtxDKne1IM6amcfss3UI5TNBpk32p8buj/hnKxoBCSVilXgaAHANQA/k1cM2vLyUkcnEXuntoQ2ABW6ESM8qVnEZyb3eiAlihDarNHNFbezURk6sqSkJXNI/NzwFrXMFXmarHqrfIddUN6eqknsQ8AlE=
Received: from vall.thefacebook.com (2620:10d:c090:200::7:36ec) by
 MWHPR15MB1230.namprd15.prod.outlook.com (2603:10b6:320:23::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Fri, 7 Sep 2018 21:34:58 +0000
From:   <jgkamat@fb.com>
To:     <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <jaygkamat@gmail.com>,
        <jgkamat@fb.com>
Subject: [PATCH v3 2/2] Add tests for memory.oom.group
Date:   Fri, 7 Sep 2018 14:34:05 -0700
Message-ID: <20180907213405.31574-3-jgkamat@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907213405.31574-1-jgkamat@fb.com>
References: <20180907164924.13789-1-jgkamat@fb.com>
 <20180907213405.31574-1-jgkamat@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::7:36ec]
X-ClientProxiedBy: BN6PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:404:121::27) To MWHPR15MB1230.namprd15.prod.outlook.com
 (2603:10b6:320:23::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d950a612-607c-4200-4b19-08d61509c3d1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1230;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1230;3:BZgjMGgw3w0M4AGJw60GMua/Ecu20OUlibWEQqN5ahsFOp8sLKJdEot4Tg93nbB3ipOZxFNg6Lh4Cwjnci+ywxvrZpnLmM9L06DH08U5IKMAoSxaX8U/DgEqIKJ37z9Z4btm1l6uaNeNuFfTXYPMwkiWvFbRSiPkPsdSMTN0Wzw2j67x1nYiDchGejREplHkHK93/W8D+DZHa67iy+1N2QxNA0IjJzkKD0qf1OnilRr2mRGY0LMuhX+l415KHrbY;25:DRnH+3xWxM6jrveYqT5IuelwuZ9g7yhS4LM4hRNb5SD2afti6psk9mGQig6MkBtx/YQ9QM//mFtZYofQmT0HwfKeZ40tGn1gMZNOVRAZ+iLbm6A7GSQOlGYmhbNaq7nG/tnDbLjXtl/5NStipQ5eQ777LCx3aIQD3DJ+jSvpLxJ1aZX82o1G+bwK2Igmzlha/CYShlynz+aY0bIiddjs7fRhKXMiMx+e/YNjAPdSl+xbfkYHdg19xLBhh0Q1YbGRayBvQESLwHxVBvwlIDZ0QiXw6BhWxpAzXBJADb8Xk8BFlzn8U2sBeYEE33Ws5mecrRkPqlTxlXw8mUx2w/ZjwA==;31:vj6oQ5UcN71+/BawpSk5GxBlJ0L4n9OXxW7qdL1dmxLGw69ZsUkCL1cZ+/5En+wHcv1bAYd85F1x0xGrKhICzW9s6qolgg5yRt1TZ95Z2x2MqdZ/HtcapfkMyTrqdNnL+X5mLGk1D393HMV0C23AA5mntzPMFRXd6xm4gswesuDFOsNf6TIeGO3BQjTiT86CCPpngewcjYplSig8xvyT9pLQ5VLWTnshdCHIe+OPbqQ=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1230:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1230;20:Y+4gP3WsLaCU/WZqLqKhGv8dPL6HpUn+NCMt3BLBnloaFUPVS9dpbWCaoWDgXUFBvigRgsw234NCqPgAvi+iq7829vzIKfeevqax1QjnmaqBBiQMlc7CyWnK881NOByssRyqxJli9kX70VrRs08cMVe0M/OPelni2M+0fB0GpBOozQYZ+IRy/6/h5Bix7J+z/cNb6vftydre0Kul8IU2+y99B+rP0Y4LRzrD9cP3j2AD8cSYoqt85AUfcE0Eck83UXUz3y1SD/tvmYPbwgBc1MGUTVQ0zusN5WkqUjhGGsqtNhCvHGdywWbOV7lwv/uXWMJZGBhoegls4IBDG4r8wOqxk6a41v/oicVC2wIwq3R17OQLnj5cXAe0aahf7UuV89Lf3aQNbWorNVXNmYurDJpRdhLI5r8vuNLTq51xyjDMnoJZAWvGpC0Pqa6Mhjidq15PrIRKfNGFdOyDT0NsCmpl7IhYZZRbDrddG/ehemSfzIX61xp+6n5tlT5OLXu8;4:+kA8tGLTyZbnLtfgxg1Y0cEB8CVcNjDCRQfMy/9szKugl2reuP5CfTLY+Bj7+Hr2PrF1quVoknqe73KO8Z60zkNdUUBFz5TkeM8+BmREW2XNFOW7/fyaXmGNfC21NEMMkhVwkOiHq7SB6IAOkCzl/Jq3NquY2/6k/ZJB/x4/I0e4NjYBKfc7v+hDtwrLP6NJKHoRXSyJAkh+ytzJrCYMu3xnBcwsHz+6YeiywsYRYtWMVmeSy3FZuWw9JE5eGFsFP6rdcmIcAx6WE85f87PlrIsPRmb68iHLG8/anQMnrBtqfmNengcNMIr7CT6TDzaN
X-Microsoft-Antispam-PRVS: <MWHPR15MB12304130C45E430C966931CACE000@MWHPR15MB1230.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:MWHPR15MB1230;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1230;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(446003)(105586002)(11346002)(53416004)(25786009)(69596002)(52396003)(76176011)(97736004)(52116002)(16526019)(51416003)(85782001)(186003)(486006)(4326008)(47776003)(478600001)(54906003)(1076002)(16586007)(6506007)(316002)(386003)(6116002)(2351001)(39060400002)(106356001)(50226002)(476003)(6486002)(2616005)(5660300001)(36756003)(81156014)(7736002)(305945005)(9686003)(6512007)(2361001)(50466002)(14444005)(53936002)(81166006)(8676002)(33896004)(6666003)(48376002)(575784001)(46003)(86362001)(6916009)(2906002)(68736007)(8936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1230;H:vall.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1230;23:no6Rq0oWb8LMz4vQgOAyHYRqBIA9iu/eC4+GJ/WP9?=
 =?us-ascii?Q?Aj8lgefEjuaNb31ac0cAo4oAMm/CeBdpIl0NLbzvgVvYb03jMbmSr73DWcqF?=
 =?us-ascii?Q?T8qprq0sBZIFHhaIF6GlUJlt87wYxjZEWzmR8MVxJWQstHDkzRDlOF6nq6VF?=
 =?us-ascii?Q?rvnbCtpPkNzVOeDRvoVjR+KciXin4pSZk6jyLT7O82StYEl3zSDAj580lr01?=
 =?us-ascii?Q?0voC18d/DyLFgaRZPEgTFKOnXQuVUwWtTi88TayQPz+C01Br5SbNw+QcV8xZ?=
 =?us-ascii?Q?yGutGeeC25ogyzxGM/wRxo7RvlI9OmweBxI7Bh8RRMExgN4Fvz//F38NY8O9?=
 =?us-ascii?Q?sk8VYRup2L2DBOW7QONaQuNSJCeiqYjgoGh+MSwRz8cvsVVl+g2V4FVPKkP9?=
 =?us-ascii?Q?U8p4yK47QoWAfnRuKm81oO7eyKyYgorchjpEOjM7q6m9IQUQrfh+xaxhModr?=
 =?us-ascii?Q?FBDmHikiN62ElR8IpT1ZwnBbLkxCvO/fpqAvdjU6FA53b8+XDN0npQGUBfKr?=
 =?us-ascii?Q?SSLh96Ypj8nwuZWwtSwM4taNtttU8StCkunIbnX/2F8mXNJEV7a+ELRVv2sF?=
 =?us-ascii?Q?SB2jPhHxU5dPiFTm3ipxDdClEb+BBQExq02xJEauki6+cuQ3IgimMdkOg2JD?=
 =?us-ascii?Q?8YEBkflBoAI5R+bGXcXgMA4jOAXmOZ+U5izenwoCt+xnK5uPjgW+cE/BTyVm?=
 =?us-ascii?Q?iFIsYTL3922JZqzf6u19/a57LH6aUtabfzTnlCSqPrss9dvKM7Rk+KdWyk0o?=
 =?us-ascii?Q?pYaegtgodqtpITUvPz8wm7zSPwqwqtBnuIjPav4OAbsp5fKiSfUiUJg6nmtD?=
 =?us-ascii?Q?ayfwKPu1EZhfkPzSmdrL+qaD9rsejjsdIhh0JFIQmiBGEd7PiLyFtxU8F80N?=
 =?us-ascii?Q?aWDOrsP+oAc0PU9NfCzZ/hL6kNFmV0h4MruHrfpcqlOBPpfdTtYIyvH22rvb?=
 =?us-ascii?Q?hzB41bhUtM+zXeXdh21vF+MYSpGAn5Vyw+kJIYd0yA3YVbKj9mAn6wEOISRc?=
 =?us-ascii?Q?TUPvgpBdS6+TLdr04IUU+Id40Zt+0EXzRPY69NWuAczEU1ZMifrE3QffUyN0?=
 =?us-ascii?Q?n0prObDEPGTUI/IXWf6WPs40vyOh/RDVY1ImUFwPDQCO1KjAKNfT6i0/XGuu?=
 =?us-ascii?Q?cdWYiUCmNkFQ8uPy8EXdxsEbY2WvI+lOHwp2i03z80B+jMiCNSZq/S/Plvy0?=
 =?us-ascii?Q?ODqqwS2m8dOcDVww40ltrb0omqKgWXy1DaHfh91eronBlxFecMTXPZJorwae?=
 =?us-ascii?Q?ZIhYu6lE6QiZq0R957n0TnAxMexI1dAJuR5c4ljgUWcyy3IWetAGmtmaxfuz?=
 =?us-ascii?Q?t2xrb8xzjP3ybEa4pS6KEGKn+ZVoV2Lg6S5eL3fi2ybRFWVWfJDeUhD8iOPE?=
 =?us-ascii?Q?rjsQfCzxRukxzoxnA3DhO8ZsbVPnUP+50376p0G2qXuCTGx?=
X-Microsoft-Antispam-Message-Info: Hqx+dM5MbjWAGACz0ucwVAIIGoEl4SuBmk5UkfVRUx4BvnOdtcIgObtXTQL5ADwOTOMGv52C3srETJwgRAGlWK5J4JDjX2r9Z8WEcYNIQ/jz+6GyfVyuXeTd7mwC5XlRxhaQI60pKUmRPEmG8L220yBE3OaaNSkAq3kRtHppojhFrVpXr6yE+n9xTqyBEOC/4uIQX8WM53F91YkW4xbElyWgmXJoSMAS5Z5lc39VUukI8r9Q66zegpCWj12qGruOyI3oHq3+eGMDd/J3ySX8h7pYyoaGHZ6ZYeE9GOL8+Wukq+glDjwzbylnQGb9aMFbZHYLIsyCM76B9963rTtBQ+/9G25lbImiev7HrIr6JLc=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1230;6:H5B4Lc+NjHTKbtNrmly4MByI8n4TZO2NaAfr0kYmDv/rQG0qQaaOJyE1ntP0MHTTbFlW3AqObFOht1Zv4L8b5Kq+iDm4pdYB23NonpPddcIP1bK3/tp4TW5Fc5o6m13czjL/6D8oUwKdzZ1q+0GIadoLf7AaD8P2XqJCQAwrpkwuMJzD2tU19vUZxvJiI3sXWR4PvNyjLPENBy0n/YtXPTn5NcTX4VNcNjGZPH2npSxrIyP/tek92ej5weLxrbDCoJqh+FJaR6nZFhvr68INXWYOUzMMRS0n/CskUdDzJqJJuzbMPkp3V8jQ02/V48s3/Y/alWZ6yDKnN7Gq8ZUhRCOBkLb5kA9K3Umrtwq9Y9QcEmICaqFBmyNWb2E+IwihAIDav9Hz/ydi/YQWsLRQqR/YZATDhuMKNyBNhx7XogyBYWnGsGsLuFsKP1757i1sWZfPxW7DOx9tXA6VYZpmXg==;5:rl1dCBM9gKPHyQy9fxEShv6mPitHUKCmX7tYGSG6kPHnWq5TG0cCGpwkaWKxMCgmPwkCqbR72gIbKwEQnnKxLZO20aRr9JotZI/OpGi1tFiJ9Oyn60viNrmdlTiy2gLTTmksqqjbphiLZeX+187pRhsJweJfFoOSHhdDjKRr43A=;7:YSO2xX5Sq8fqt74NY9YlWhNyXgP8jM8tDy2MY60Y0kd8waFF5NCcW3hyHxmjwxIzaHT5GSylxOT/rETwoqillpBAIY+PkWWvJW/7YxR6GEfkXgdCuzzXKF5wPzoeI0/b4uV7CU8icwTNoz3p6BKMF01e6Zw0o0rkv6/N4bgHutbIdtnpryk0MbiH7NQNUAfhptCcstmGIjZl2wPauP7NAUSdOamx0//0u3UmQe4wMypzXfu+C618xSGTf5Bs8jGL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1230;20:8oT07ZfGQJesM9NNR3ZwpsB8Y4tygR6kKZvk0pM2rhwn+Rmod+5dk/4oar/U9Uhn7pMrBntBEYQvDNsyDfy2cozWJwfmPY3eXUimAa5e+G9gZf7e6lFBmz13Kp74l8erUA4jbgCvTs18X5oqq9m6yIPRV15kEQ7gVfL8oBcyj74=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 21:34:58.7042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d950a612-607c-4200-4b19-08d61509c3d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1230
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Kamat <jgkamat@fb.com>

Add tests for memory.oom.group for the following cases:
- Killing all processes in a leaf cgroup, but leaving the
  parent untouched
- Killing all processes in a parent and leaf cgroup
- Keeping processes marked by OOM_SCORE_ADJ_MIN alive when considered
  for being killed by the group oom killer.

Signed-off-by: Jay Kamat <jgkamat@fb.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c  |  21 ++
 tools/testing/selftests/cgroup/cgroup_util.h  |   1 +
 .../selftests/cgroup/test_memcontrol.c        | 205 ++++++++++++++++++
 3 files changed, 227 insertions(+)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 8b644ea39725..e0db048331cb 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -340,3 +340,24 @@ int is_swap_enabled(void)
 
 	return cnt > 1;
 }
+
+int set_oom_adj_score(int pid, int score)
+{
+	char path[PATH_MAX];
+	int fd, len;
+
+	sprintf(path, "/proc/%d/oom_score_adj", pid);
+
+	fd = open(path, O_WRONLY | O_APPEND);
+	if (fd < 0)
+		return fd;
+
+	len = dprintf(fd, "%d", score);
+	if (len < 0) {
+		close(fd);
+		return len;
+	}
+
+	close(fd);
+	return 0;
+}
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index fe82a297d4e0..cabd43fd137a 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -39,3 +39,4 @@ extern int get_temp_fd(void);
 extern int alloc_pagecache(int fd, size_t size);
 extern int alloc_anon(const char *cgroup, void *arg);
 extern int is_swap_enabled(void);
+extern int set_oom_adj_score(int pid, int score);
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index cf0bddc9d271..28d321ba311b 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -2,6 +2,7 @@
 #define _GNU_SOURCE
 
 #include <linux/limits.h>
+#include <linux/oom.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -202,6 +203,36 @@ static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
 	return 0;
 }
 
+static int alloc_anon_noexit(const char *cgroup, void *arg)
+{
+	int ppid = getppid();
+
+	if (alloc_anon(cgroup, arg))
+		return -1;
+
+	while (getppid() == ppid)
+		sleep(1);
+
+	return 0;
+}
+
+/*
+ * Wait until processes are killed asynchronously by the OOM killer
+ * If we exceed a timeout, fail.
+ */
+static int cg_test_proc_killed(const char *cgroup)
+{
+	int limit;
+
+	for (limit = 10; limit > 0; limit--) {
+		if (cg_read_strcmp(cgroup, "cgroup.procs", "") == 0)
+			return 0;
+
+		usleep(100000);
+	}
+	return -1;
+}
+
 /*
  * First, this test creates the following hierarchy:
  * A       memory.min = 50M,  memory.max = 200M
@@ -964,6 +995,177 @@ static int test_memcg_sock(const char *root)
 	return ret;
 }
 
+/*
+ * This test disables swapping and tries to allocate anonymous memory
+ * up to OOM with memory.group.oom set. Then it checks that all
+ * processes in the leaf (but not the parent) were killed.
+ */
+static int test_memcg_oom_group_leaf_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent, *child;
+
+	parent = cg_name(root, "memcg_test_0");
+	child = cg_name(root, "memcg_test_0/memcg_test_1");
+
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_write(child, "memory.max", "50M"))
+		goto cleanup;
+
+	if (cg_write(child, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(child, "memory.oom.group", "1"))
+		goto cleanup;
+
+	cg_run_nowait(parent, alloc_anon_noexit, (void *) MB(60));
+	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
+	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
+	if (!cg_run(child, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_test_proc_killed(child))
+		goto cleanup;
+
+	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
+		goto cleanup;
+
+	if (cg_read_key_long(parent, "memory.events", "oom_kill ") != 0)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	if (parent)
+		cg_destroy(parent);
+	free(child);
+	free(parent);
+
+	return ret;
+}
+
+/*
+ * This test disables swapping and tries to allocate anonymous memory
+ * up to OOM with memory.group.oom set. Then it checks that all
+ * processes in the parent and leaf were killed.
+ */
+static int test_memcg_oom_group_parent_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *parent, *child;
+
+	parent = cg_name(root, "memcg_test_0");
+	child = cg_name(root, "memcg_test_0/memcg_test_1");
+
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_write(parent, "memory.max", "80M"))
+		goto cleanup;
+
+	if (cg_write(parent, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(parent, "memory.oom.group", "1"))
+		goto cleanup;
+
+	cg_run_nowait(parent, alloc_anon_noexit, (void *) MB(60));
+	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
+	cg_run_nowait(child, alloc_anon_noexit, (void *) MB(1));
+
+	if (!cg_run(child, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_test_proc_killed(child))
+		goto cleanup;
+	if (cg_test_proc_killed(parent))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (child)
+		cg_destroy(child);
+	if (parent)
+		cg_destroy(parent);
+	free(child);
+	free(parent);
+
+	return ret;
+}
+
+/*
+ * This test disables swapping and tries to allocate anonymous memory
+ * up to OOM with memory.group.oom set. Then it checks that all
+ * processes were killed except those set with OOM_SCORE_ADJ_MIN
+ */
+static int test_memcg_oom_group_score_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *memcg;
+	int safe_pid;
+
+	memcg = cg_name(root, "memcg_test_0");
+
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.max", "50M"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.swap.max", "0"))
+		goto cleanup;
+
+	if (cg_write(memcg, "memory.oom.group", "1"))
+		goto cleanup;
+
+	safe_pid = cg_run_nowait(memcg, alloc_anon_noexit, (void *) MB(1));
+	if (set_oom_adj_score(safe_pid, OOM_SCORE_ADJ_MIN))
+		goto cleanup;
+
+	cg_run_nowait(memcg, alloc_anon_noexit, (void *) MB(1));
+	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
+		goto cleanup;
+
+	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 3)
+		goto cleanup;
+
+	if (kill(safe_pid, SIGKILL))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (memcg)
+		cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
+
 #define T(x) { x, #x }
 struct memcg_test {
 	int (*fn)(const char *root);
@@ -978,6 +1180,9 @@ struct memcg_test {
 	T(test_memcg_oom_events),
 	T(test_memcg_swap_max),
 	T(test_memcg_sock),
+	T(test_memcg_oom_group_leaf_events),
+	T(test_memcg_oom_group_parent_events),
+	T(test_memcg_oom_group_score_events),
 };
 #undef T
 
-- 
2.17.1

