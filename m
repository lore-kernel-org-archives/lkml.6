Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8784C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C20B20836
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bB/eRSyc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JcidG8zR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C20B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeIEFkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:40:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56654 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbeIEFkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:40:32 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8517jaq027879;
        Tue, 4 Sep 2018 18:12:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=XuIiTB9b9mtBqcklf77OU23vQtieLW/xX2Bw62r1FkY=;
 b=bB/eRSyc2voA0DaQVIVavs+MFXibWd4ebKLiFjm46LrOEQ5U/3nyMxg9KpnDU9eRz6FG
 Hpbv7G/7Fx0Pqi0lNLqm4YyhIGMVNitegZCfHxHcVG7XcR7vePo3CyCkKeSg8ZftbMwD
 4Pe7Bs45jGqWfybwwEBzxoKBqp0sJoxLXRw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ma5480139-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Sep 2018 18:12:49 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.16) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 4 Sep 2018 18:12:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuIiTB9b9mtBqcklf77OU23vQtieLW/xX2Bw62r1FkY=;
 b=JcidG8zRQaO/NmniJhRtXchtf6a0r+rudljwAczQcp9XEA8FBKuc1bZmXqxSVQDa1pvlspakYCjQmWmzvRWBndiS9ASvwSJze2XXd4WTzXtHKD+mLOdyrNBDl4PoPmwy8e5Gin+rFDTN6Gu4d/TSHXsE6pEfu38zCVcVVHc8n60=
Received: from vall.thefacebook.com (2620:10d:c090:180::1:e8b3) by
 MWHPR15MB1229.namprd15.prod.outlook.com (2603:10b6:320:23::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Wed, 5 Sep 2018 01:12:31 +0000
From:   <jgkamat@fb.com>
To:     <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <jaygkamat@gmail.com>,
        <jgkamat@fb.com>
Subject: [PATCH 2/2] Add tests for memory.oom.group
Date:   Tue, 4 Sep 2018 18:08:27 -0700
Message-ID: <20180905010827.27743-3-jgkamat@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905010827.27743-1-jgkamat@fb.com>
References: <20180905010827.27743-1-jgkamat@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:180::1:e8b3]
X-ClientProxiedBy: DM5PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:3:93::21) To MWHPR15MB1229.namprd15.prod.outlook.com
 (2603:10b6:320:23::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0240567a-d10f-44c5-4475-08d612cca8a2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1229;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1229;3:76j2v6fqFbjoJb6KXJCu8WTDnxrV3KV048jP5wepnuTQQhSJK+H1sWB4fjjibljDfRZLu/cEBWEbxWSy7Ob1uHVZE+PYuQCSIfAu9GIT5d338NgxoQ3Czh3B8Xp+nBYoIWmlDcvhe/FVsSiufDDhWmyU7SjfLW9dttoJLYbXICNGmaDjUEXZBGOwKCDTHcodU2riJsf8gn31zYX/F2Q7hBqFw9uh/JtXNtgM9S1Zb4We4tiEvHYdm+L/G3h9gtyX;25:BXj0gjb3ARcHYgM6/gj27SHMpOt5M/JBetvjuXyAc3zNyKlUcgmhO88jRkppSe7Rd60OlnR7ALdpTzDT5L6B0VwRrgpillAodmdktnN9s8SyxrjcAWaC8FTCBk46crKNDDR4rAYK+7bEa5rIado7aCDftBtmDdDP0Le+tXT86ZgVg10pgpbpbCgN2wySMB1JTX+XRi0RoDygvpMlsb+1z0SZgwCa0nt+4cCdHSbFAYmKkmIF6S6kg3QMBKLI2Ol2fVxuOK1nLYkG81Z5Dz9Jxh2MEBkHTzDqoQ5sxc2/g4um1JbyXe8RfNJuuNJxGll71HVtCl5QKgc0/SsBg/dwDA==;31:ZAvrdqMG4FJJJGu/VUF7FxC5Uo054iJlDoKMKgiJzDO6SpEQGod89IBTNJRRt2Hri12ost8XGW1Dap6HTPIn2QhYXSNKAg42M24gIPeBowyhcB53t7Ydt6VGO7nFJHP0kV6BzFiHjxSWYIp1bpYGDnPa3CqFR6nfQ+45dXREAs9/5Mc4edCDTIh8piFSyb0TJvJgcDXhZdrByhTILyUxfWKXRLIhPFZDveXh+15NV5M=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1229:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1229;20:KO03Esh/TxvZZLMpVzaN9hkfSyLnQOsNrNBpzblvuVoIyuF+p0ZumXr7wj0MoPoL8EKI1N6TnUdoEY/wsGarmtNKxyK/X2EIGd4WqUi0txykD5n3iJmTKwo1Gkbwax6wrlUwCwm29HWo+jWTsOwJubDklBMBzTpyBemhVoi+8g/0NHtY5J/Da8CdajicPoLkkPZbxI5bxugZSQ20tGaG7gOBVUgamRGUtlfA3t3wsfJZKL0FI/KcSqjWxj/P8uNO2CptWsqp0AiowJcENwik+LL7YZMYYGYDWGHGAuk8LYvcP9wX07Qbt1e32ITx8EN43vtYHLNY0iTOE2kgrVJSROEnG+UpgrkGAcWC+PxZo6WNFG2WwlmvZY3Q6qwy+ef6gliWyverJ11cUHTE02nM9kIqfbsxBr5mJW6VnsyX5BF5CoTWOb2bYA0LJlaoMEzD7xWOc/KSE2Tx0N0LydpPTLbV2dWs56RsFVndjhPDJBt89mDxnAMiZlXhSSSNC9Hj;4:oSEIov5iNEqiDv/7X/E56sKrOl+LndiKm8OdubXiw2eKB6O6d8U1JvhX8t48HGpr3/Fj9T040/6tUP1e6wh+uvlasdL8P7FX3P+beGzEFm7p9EwKgmj8gEC22l+AlNIPepLs6Sze6U3MVK8W5ZJznKraROq7IK7Bbg0FADo9YdehAuCwQZnzOOwSjvzF6wbexrqrOSJ1vDbsznCJ3hU4aUQ7jTRtnN/tKn5DQvcrV+24J9dThiotuG3t/J40uGdPeVVXKhoRCHMN7CkyWRMaahuT338QBt6RKpTxHifGDZbwyFC4ASRRSO/PKDgrfwxj
X-Microsoft-Antispam-PRVS: <MWHPR15MB1229C708398BC45DCBB10148CE020@MWHPR15MB1229.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:MWHPR15MB1229;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1229;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(33896004)(575784001)(6916009)(86362001)(8936002)(25786009)(54906003)(16586007)(316002)(6506007)(386003)(5660300001)(69596002)(6666003)(53936002)(85782001)(53416004)(50226002)(68736007)(81156014)(6512007)(81166006)(16526019)(48376002)(46003)(36756003)(47776003)(9686003)(186003)(446003)(97736004)(76176011)(105586002)(8676002)(4326008)(51416003)(39060400002)(1076002)(106356001)(476003)(2906002)(478600001)(52116002)(6486002)(305945005)(7736002)(11346002)(2616005)(2351001)(52396003)(486006)(2361001)(14444005)(50466002)(6116002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1229;H:vall.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1229;23:SIf5ithQeuNoypHLDZJnIxAhOhGJerR8+aJJaoEAh?=
 =?us-ascii?Q?5/eWDfaDb+O1Z5sK4odxY3F44w5wU7B1m0POr3BrbuU2mAJvpzMjTYJVADGZ?=
 =?us-ascii?Q?CsErdLpLL8jk6/+ayc13A1zsfQswqfpy1AF20d8RAqnxAmMYc1ybzuFF3P+p?=
 =?us-ascii?Q?Mse9JHADcxMgbY287Lmdzi5kfHJ13mNdcmjf50DYqAVR7zBWpL6G4eAFMI/h?=
 =?us-ascii?Q?NMjeNDFfocsJI1fayG5MKES2YOfB7L0E88LXhaNsu0AVLGNglr/6XPA8dFy1?=
 =?us-ascii?Q?p1ZdiAstHvUbI7Tp3W29SS9Nt777OuiMDZKSSXq8z2bS5PonHUAPNsGVOfkB?=
 =?us-ascii?Q?P6/cn+5g0K4n9dG86mgtvl0dF6CzrnrsCdSsQaRxp3nhUyqrGbRr2KlH4AYQ?=
 =?us-ascii?Q?StKdr8FEQ7jW9aDi/Fff8N14G4pMze+ryV4r3d6CREQMUT+ahzCFQjh05+ls?=
 =?us-ascii?Q?h+zkbncVwEM7DnxOwh4Y4VarF/9KHlZGbjYOfio7JbY+3qqC92vfRSgKQ34I?=
 =?us-ascii?Q?4cmOuF8nAX9gL+lyEzZKi3p6YLjkQbfEW9w4yHqeK6e0fqZlA9jtCV1rW4pa?=
 =?us-ascii?Q?NLP+pXF8lUqPviqUV1kVDgxy0E0D3RjURcS9Nwqsog2Ms5lDcPTLI+PJHlIp?=
 =?us-ascii?Q?CvROCo+iTpxAOdHvaCX1T27yZ19LcnIks6RDekZaewz0Qav6WFJlyRVeNaPu?=
 =?us-ascii?Q?iE5Ylg8QlUwgVQZUam6w6TTH38DhYnzjmzxAzFWbGYyZOswbNHwdQq2+DGPu?=
 =?us-ascii?Q?OE+QPdmYE5JFkniuccUTmoMeyyijLeSf6HEan4KQqdWuASdIo304oMeD1tl+?=
 =?us-ascii?Q?X2zi9IfSLv7RhzxD+AfOK9frc26uRTt6ey3O2Bu5tJrZ6DgkE0RA0RWaVs73?=
 =?us-ascii?Q?Nv6xQOWBXx1p7BNJsx0tof0ZNfq/XetoUcRKyDkqmEpc4i2toUnOd9dIQaTb?=
 =?us-ascii?Q?+05JuEL6ynlrVIv0HvQVPZrw7f2XhHEUlU00qgIERVD3GQskX168OQUialZ7?=
 =?us-ascii?Q?MetNO7+ZgkwWbc9zOGQdKZZVOOf2PsvpbKXOAP8H9BUh4gxHTYVtpVQBl/jX?=
 =?us-ascii?Q?uKF1xwRNcOWeyHD0H+5g7PVOSQbwS5vTqQqa0BHDE1iXMcMVxN4s47rZTw4f?=
 =?us-ascii?Q?kk4CN5R5eu/l6QJiP9FgRl0rPs7b9ZLbP42I5GhP4rBrifqWZbTwG0JQUBQI?=
 =?us-ascii?Q?Zi+hw84gVj0wB8vrr0Ww7HE20gRRLgvSogs26bc4WNIYjzoxCbKpM3bMAgST?=
 =?us-ascii?Q?V/Hpt0FRLVYiXJqJ3uJ7pyUyIvlMaxggnS+JhRz6N3Q/FaIqNvuvWnGX4aG9?=
 =?us-ascii?Q?nFs3D655r4dobteMh/mS+UGkUwRuFkmQg0W2Mh1niqf0Kh+nXnnmiwjuJwW1?=
 =?us-ascii?Q?aznUl3DIsVKpY+gLnyECxR1t9VZfEKpyV0fQaV6Zd33p8SF?=
X-Microsoft-Antispam-Message-Info: u+1AtdAcOumcwqMyRsbwRE032GDudEJz5GRo3E5ULtcXeZgk5S1BMWME2eEBMHsAiyA63B2IwIBhejiThil1GnNGVp04kwHzxU8Fkp9FBd/ffbmXUC5F0mWx8XIY51QWqx7bnYmaSwlW+eBmUYiqAnfpdgJ12+bNHdKg16+caIyPi4u8BRgUjnbSMKSSLx9jm+JhjcFgeUjKsEuA5tkfKqZCQ7Y1Tha+qhkAya6D69S8IVckSkY6yFiTXqFfoH1D6ASf/UCIF5K0uYQxwp5ESFGJxTmRF21F36zo8yLwcGecuULnO8NVhTGSgpT7MljX0QJG0206RTV5qnye8WN0yxmHkReULm7xpgkS+9eTqxU=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1229;6:KEI4Nx3xgvceN1e4G7k2qgkS85GEIiCMpggjCrlr4SxVOSfl4v+wFb6ur0eH5MHOn545B/Pr5NPuFatUUUMd63jG8+aFmPBfK9cFg5qo4tf1rGWP1yV4A9EjnP8H5uGMlFSEr0mWmh4xknqBjUUdfg57dZSh0qvoWMdC+w9rp3GwOZmt4VBleshbe6QrdpW82J0xZS5f252TedsPwC3Jopd2NOKoMkTXtglxbjP4X/+Y3P3sjWjFy9u70vDUC0wcHeQePhZKeL16Df9ijRVJIB/dafRu7DTwYEP+p1hNFs7Nbhg0N5eHQ9ipxPHLkoyFnV0/rw1c2ytQQdP70OZQfaTC3NdO/RU7PptfkG8HrK6Nfhc6hUBDcdhcUweAzMl1CpBUBP2pRPM95iqBuoiYVi7sQeyj/WFRBddcLlz7MFYf0T0kLD6w8ZFY5SpopxMYcd1umNQgo9nPMJEWJuQVig==;5:tjDWfLtaaHvVr65tevxMrRWWGqyeM2W24In9SlIv/rL0tOnUqrCf0U/SSI3kIbqLwalEzV/fWWvjptU9efg4uz05H+aP50UboYaXlRpd7x3o62fD7+PANrmH8tN+WQ55gQCR0cR/3GYc0JBpmtKtBK+aTZNoizZxp/FIBJuOgzo=;7:dj9uCNT+2EKgduYCtar6QatNwcq1a33cqbHDjqLQAaXOJJC+6oCWcjPITC5JcKXzLb3T5xmhxmkNnw+0YLTV1STQoMyBJNg/TWcNNB54OtbtlW6rNUeXR8jX3YnvkSf25zp5xkUPsUhljmoFMQVgCd+VcjylxTgqow7Nqz8gj1KuylDgg/fKTE35Ay4q7dC6mizY9RBbAbP/VUB7pfBlqwu6e6v6rHbJ1o/DHOrFqMfCldXOkPkgdE7/f/C8itfv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1229;20:8QOHF/lhse8UgLouY4kGCXJtc0i5RbFs8VWC8EIdcmxlyaF0EhF2mHU/Z9ZemazxM3Il1Qj8u5ofuZou/aJFXwAkwN/GBA/RMRWcncKlrTX2IfTE/Ee3DKr9l4eBicJ0WRxulCdxU7hJmO+Qo5KWnGXoUhYmRwq90N9X/JtZ7AU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 01:12:31.5713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0240567a-d10f-44c5-4475-08d612cca8a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1229
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-04_14:,,
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
---
 tools/testing/selftests/cgroup/cgroup_util.c  |  21 ++
 tools/testing/selftests/cgroup/cgroup_util.h  |   1 +
 .../selftests/cgroup/test_memcontrol.c        | 205 ++++++++++++++++++
 3 files changed, 227 insertions(+)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 4aadf38bcd5d..6799c69d7f03 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -338,3 +338,24 @@ int is_swap_enabled(void)
 
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
index cf0bddc9d271..017c15a7a935 100644
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
+		return -1;
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

