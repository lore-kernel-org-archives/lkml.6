Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A874DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4FF208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Uyp+3svT";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Faz/O0UV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4FF208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeH0UOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:14:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50392 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727254AbeH0UOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:14:33 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7RGM8Fp012182;
        Mon, 27 Aug 2018 09:27:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=2itD7Bv4bnoeSEaWjV2FXU35V3cT3moJ5yiJs1BMCuA=;
 b=Uyp+3svTszTz280Vynv6RD0DoBbOSMtK+GGM4l7VMdPOeqdHj82x2L/uwO70AIXwfq3y
 I2isMcGLcG6yVaR8nSSnmUIJQQ9S/cWx/ASPkyRtaZX+WoPnOiocSRGgBvJHttVMFSlm
 l+KYCjdY/OJmumGAwfWOBW+YrGG8XvqeP9k= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2m4h470sg4-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 27 Aug 2018 09:27:07 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 27 Aug 2018 12:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2itD7Bv4bnoeSEaWjV2FXU35V3cT3moJ5yiJs1BMCuA=;
 b=Faz/O0UVGADygy6w5ogQQuxk65lk4u1DrSQ5ZAiLfj/71HqyItbEYWIfrzvtytftiX8VOBpVLRJpEjywDSy3iI9efP15sgY/EAoWIdZ9Beo+yE3RfYuFGfeA6NCI7HthUwGm4XOfkWwepSkI8DgeTf2CDLxo9ROkiyZTI58aW28=
Received: from tower.thefacebook.com (2620:10d:c090:200::4:4b2f) by
 CY1PR15MB0170.namprd15.prod.outlook.com (2a01:111:e400:58bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Mon, 27 Aug
 2018 16:27:00 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 2/3] mm: drain memcg stocks on css offlining
Date:   Mon, 27 Aug 2018 09:26:20 -0700
Message-ID: <20180827162621.30187-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180827162621.30187-1-guro@fb.com>
References: <20180827162621.30187-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4b2f]
X-ClientProxiedBy: MWHPR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:300:ee::31) To CY1PR15MB0170.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f61cde31-c3b9-4af1-8f84-08d60c39eaac
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0170;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;3:ZNcK2zqpMZ1RSztEjgyv/y2XHVz/+vwzGoNTYCCCq3aS5ANfXLJ9yCXOxbTrRjrikJ4BKg+mzzyMcqmMYfUUgQkgU+wxo6r89S5U4pTdROId1W3uMabSQfvCJ94dP2IJzinfAFivqnS3qRvUKrKxs2jFjXH0AKkdFPY6CpXPKDEThlxFesNusmhxnHD4KnnjTlEdyXcHRu5K5YsL0t1GLcyEqxcuxYTRKTU+zuSuZm66vH01oOsJaz/cI4AZe53Q;25:j47U/Vil8uCi9pNvNYIkaTb12Id8Vh/zoClIucyAzTa4gaONXzrRj9U3LFB/weXdsFsP40O2cVMGrkQvSIDYEXzV1+1cjfEv7PWylSFqoHIKd8v+dByBVyUveq0qjLjyQPVtdhI5ygtFBwXK0lDE54Cck1WPKDyhuL5yu8pfso4+o6zQfLVsHgE+mV5wtjTiKHATs6GpF16X09Z7yKhlD3vL+33errtplysGnpRaQ8rhnyaTgsET1PkZhTIiOKNfEKxFslJ8Y3FmMMw1s+aTVThMwSXA2F7OBCYWBgoSK5dKJmoxMWjErTWywlPl597kzS1YwFfbMpjUwnpi2hBUHw==;31:wLK/hZHrdLFJU1Nm3g77iRev2H55sNT/TTmgz+s/G9pOY9ln6EKEqJ5WgD/QObyjPdW7WhGai+Gcn1i1wI2rRmgDhFcaa7S1ZOPk9bTXDdIl8m7LQoF/JjE5r4LKqsTr5g0720MI4+p+LhB67zPLEx2FUjMWJD6VEOGhf2Yx9gnBHUiHnlvEgw6LChPHUJ1WxuhIYnYE9uEvDtRC3JPnTWIQLhx6apoeItuWQ64m6aQ=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0170:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:5h6QnUwp54RJAdwr0FxZUy2c1AMJVqJxR9L7EAbdRNKsOWaiZHbQLxo1D54IIs6xy311KgYOMdhuIHz5mim3v4ocXmpyA/O0P6C4cCqaaTOMi8Fqgsv6GkWBiMSMHsHJcbUhxq4mahh8paZe+zYB5nO2UQwxBEmvbpSH/NxY5G5JtaaXeZiX5c8nDiIVuAL5wA4ZMxJjiRNEjJoWEq2FpvLrNcwLhUrDcpM0Zlz1b5vjfWozfQ0tmQZ50sNVCPXYfmBcGTx/xQUzhBQr6+GkGIs/HwdRpuZH4stsvKFvFRvOBd7gYl9p2q6zeIKdUQ5g+YTlqUff74EOJdkiQpBEslYqaHj6BUg6U7oVtKz3vJV5cUEGfut4oeyA5ee0Fy9IMP9gmk5VPpVWynyb+HhzGkGO+liTFW8et+mwXFGuPCkzMHqTb1fQSGsQuPth1ASkNUQwpzVnITDPtZXRtlAbUx4c770kPYN4cFOhMd0NgJnHQxWQbhPa9CdtdaYlD9/k;4:3tddJFV0d0W6cu13e3GlFcmXVO4GCkkLno55aJvyCTwjGRS74JyYvYM4Ee8M/jpJY0GZzvGKR6+uIgDf8u+Nxk6TPtOGCkRjl0aE1YMJAmuojmr2oOjLz9nsLMzRC0WIe5btwW9sRfLOvuyowRtySkGqRf01lEM2m1PCd7Ax5kmAuHnyOROpcDUWtEEh8l+lJbVQSCyZygTOZjy+aa+DdM1x2SBfgsk99TJa+x9bkXjWEcxsPGc0Bektn3q3TlJLbYCstPKWfBlauiYff7I79HLnUuyvvH7VvBakMY+CJPZuTtZDmy6ZV5XHRLCssH2UcM/FnS/EhiPSDn1Gh8No0RkjCUcZjTBotE/DNnOoviY7QyG5UkNUqQDMt8SakHmIqajqLdWU++sjYNBSlnkJsvrvZINXtigal21KqsPLQqk=
X-Microsoft-Antispam-PRVS: <CY1PR15MB0170B703C53573D91A591E5EBE0B0@CY1PR15MB0170.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:CY1PR15MB0170;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0170;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39860400002)(346002)(136003)(199004)(189003)(8936002)(16586007)(97736004)(5660300001)(81166006)(316002)(81156014)(76176011)(6916009)(6666003)(54906003)(6506007)(386003)(186003)(16526019)(52396003)(52116002)(53416004)(51416003)(47776003)(2351001)(69596002)(1076002)(105586002)(6116002)(106356001)(478600001)(46003)(8676002)(11346002)(2616005)(476003)(48376002)(50466002)(7736002)(2906002)(486006)(446003)(305945005)(36756003)(68736007)(6512007)(25786009)(86362001)(6486002)(53936002)(50226002)(4326008)(39060400002)(2361001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0170;H:tower.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0170;23:Xo4G+J5cXa0cRKAMLoNJhpMLxX3MBkk+fVZGbOL6Z?=
 =?us-ascii?Q?7jdpARAygUHIrMQ4bk4sdpADs9H3zN8QLEkHsbBqBK5JWSMiN6SPuc8/1noh?=
 =?us-ascii?Q?1+HUuaRavYc1DVBaz30KGf0uW5G6IplLzQT+aUELxL+E3pXoWTVE00ToG5Ot?=
 =?us-ascii?Q?aKmIPqHAU6fC1LEUcSaMXObd6aHgjBB4OMVTqb0yssvVXJJCce+X9364lGAg?=
 =?us-ascii?Q?r6v6DziiF5tiUSQy8Sr0439niI3kQ2zEVRg7kHkR4/VOCNUItx4uI617mNPe?=
 =?us-ascii?Q?9vE8Hjjil83hbecgSNxQg913NlLxbYlaB62jq7BjUkr7FeJAgzbRv79oBftS?=
 =?us-ascii?Q?K60ci4Uxq+bC2gyTEjbn7fc5P5PVveW2XwgrUkaAnAUcwKROaqDKxwB7dHaO?=
 =?us-ascii?Q?fctT7Y+Bk59agoI7CsBw+AXtUSKYzetRJ/twKYZdXcdOlZRMWayP/7E4owug?=
 =?us-ascii?Q?DBrw0k2rT6XwH0VzK3AY56R5sIEUQO6CxCcu+qE7w6r+qwpxP+vAbKw5UZI4?=
 =?us-ascii?Q?qiyiT9iS6Q4Y8OZWDdEAVLLRSga2ebmeomKBjWC44c4HXz2kRmPg/QkqcuPY?=
 =?us-ascii?Q?dlLvY4lL+cCbElzNHjAIKOxFRM4797/iZhoOys+zLtu6PUd0KGF53X/YHqjf?=
 =?us-ascii?Q?FuhqDUbtrgCSEa+XOqO32gJpWmZ7xMykVXk4QzIfEHnqyq+CnmyJbi8/fZLz?=
 =?us-ascii?Q?3GB4JvDk2EKsdIQs+km2PSnCya9aFQNvp7FZABN0w4u3mouk1YvIbPQqTiZF?=
 =?us-ascii?Q?RRmOPyuiA7qJDm3A2MqE2nzYwJ1f8v7USmliKNBhqfGk+A6yMFVZjrAfD2UY?=
 =?us-ascii?Q?Su+GfnhIdHurvdM3fiCryOrKSsRzeRhjw/BPUubslAH0TXceG9gjJ5iY/VU2?=
 =?us-ascii?Q?o9OJwSAWKIAvkiglxq5kJR5XEjOZYJAiDDUxrzyRH+Beau4cYowBS2OKiOEk?=
 =?us-ascii?Q?IkD4Iowjptq+6CsWVgC8IR8nbpJg1W3w4tbMyB1vFYS1eHw/KgYI2F4KXl2Y?=
 =?us-ascii?Q?aq0NG7mGajqc6tYcH754tKNrgjQS2I6T1aNzyzQ0T+JmNJYKrkQitB8BZG+M?=
 =?us-ascii?Q?tLVL86PaeFzYaZWtKLTPy4rpvutaGDu4AU4pGovdDdlJ2noySjFXwgEDJkuq?=
 =?us-ascii?Q?V9LHccBHUjSRghUTFfPPedHQjVtsX782PnVQ9OdKdLIms9G5zSpYg/fb2zLG?=
 =?us-ascii?Q?x2wt+LBrLoImla5Aw2vnQ18VGEqZmtvisNsH05wnq36XyzgWde3DSpG3dYvk?=
 =?us-ascii?Q?XRURo2rIrnvXg7ko2Y83Miyeb5hiHPj0ZMsvHAbwyouTSG1ioUysMy0Qflwy?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: jBYdhUYOBk13AGCQ1RLAQ6wO4lBRyp7hjgjrJeDrjespGBSiOpU/y0MaWSrbdZgZjBWBIXcUGnfBOsfDITaJmg/Tg3/oYAWIvEq5OoagPTglpeJy6xcDRAx0g1DYFmTz6Vp2Q1et75lDuuoYNw30fXJMS2bP44Jx/zdfxNyWMnGlZvFbI1oS1LLfhD2bAhBVQz1ShboouC3bLixzB7HFIB0ToR4i0H2LCqVNf+SGucdtIRb87S4yEApUP0cbC38PsEAqj+eUzVWjToP3wXrSgpsRkA33B7CkU3ckym6LSkDEyPa372SQwLS1FcWcTQi74BoSP/GugnfxF5gcNqGlsJe/fi8MWLerA/dpFLLjZ9k=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;6:KrtaSSMOnYoVTJD/xZBORC+p0QbEyLe7mvDWJayGy0o/1pq5VABImm/uif+Ttabn/6hjl1jTA8RIo7b3O5q3CWRgwKwXwR8JIFbEScYU5aCAwqESqd1uAhiaiQlg0TKXVt28Tnnel4n+1XI18esRdVNdL8SWLDq21Ey0sLid2NByzHBSHgLV4iN1nHxYA6mQ2/gNiI7u0TtHoLJe+6aXXoG2u/sdcHs8n7WukI3UwuNT+RDfh4qftQXDLcs/b4aosoJvJDIt3Ft0hibZ2+bRNEoPUBmdJqZFOxArJf7BMA7huYuPUSVr0Xx4h7F7XE7SI0Y/8XBW/aQrY1uRRLSNc4ayjRI27hFusmAFbUDLtmJy16fWDojwmBuQ/UsuwTNw1101MHTSdfNjhVwdbEgJevr5fc1hfvaMFtbKnSF1j3/Eqb7H2uFRcaOIpK1fcugXSd2GR7J3+bjlAtC72Ut+eg==;5:S2BFp4QUkRT09qIabLT/fGKtoiE+QeUiFPfhAImQWtUsqRcX96eFk79/8F1zDbN5Ulhau2+vNd8NyVsychFgSx2sBZJ8IXe80F5A8a3XWcCsgUYikR2XgOi2jTlfPVmuO4Ep4vPm00xWyy+Bw3iyMPIqJSNw793Em8L1fhl5ZNE=;7:22t3RXWEGeqNAavV+Gk+R5QOP7/crUAMhnqKWKhNMxfs+8zRl1Vk4nic2WCrTBDXGPIqSzIpCkkO10lSu+x3lmgKu/CMn5CaOpidTeVFsfxAcigvN5CpaUj6rP52vwAp3js/z2gDgZYFEB2SA+THqF3kKfRk9RHiX7VGyDjI8v0lD5dkfInKNGV+q1UnmP6Jb1ffxatcRfgzcorGMnot5MuHWHr45mY79JhsApSXnFQj4QL2km1CDH+MuwT4KADX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0170;20:VtR3We2WYz1ue6GrTzaga8b8OdwVJ9DczYblW/VxWizg+s/h44xKFtO4s2LjInO+JBYe7yvPOswARFi1k6KXb7p0Dn13zqPikTUq/v+9i9Fw2/cHEjUiNAiXhOGagxVCALDYIiQ+p4HmLm/zg1EC7z4sdMC2sE1LjT/+jyNnCEA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 16:27:00.3100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61cde31-c3b9-4af1-8f84-08d60c39eaac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0170
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-27_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memcg charge is batched using per-cpu stocks, so an offline memcg
can be pinned by a cached charge up to a moment, when a process
belonging to some other cgroup will charge some memory on the same
cpu. In other words, cached charges can prevent a memory cgroup
from being reclaimed for some time, without any clear need.

Let's optimize it by explicit draining of all stocks on css offlining.
As draining is performed asynchronously, and is skipped if any
parallel draining is happening, it's cheap.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 29d9d1a69b36..17ce6f2e6caf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4573,6 +4573,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	memcg_offline_kmem(memcg);
 	wb_memcg_offline(memcg);
 
+	drain_all_stock(memcg);
+
 	mem_cgroup_id_put(memcg);
 }
 
-- 
2.17.1

