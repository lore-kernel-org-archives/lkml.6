Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2377C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AAF20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="o/qFpUMe";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Do6Z8DCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AAF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbeG0XRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:17:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389885AbeG0XRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:18 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLjQuE006591;
        Fri, 27 Jul 2018 14:53:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Ryu44ss5h7o2fGu5+Ju+EPS40EB/buulD7nkK4JmyaA=;
 b=o/qFpUMecv60U/VGaWTrmjyGDcV078IgZMjE3P4DQ8lhCiS4ZTmueFkNnL5QK244+Rsh
 RMIYz4qBza8o8B6UDwg6KkWBKItNjeTWof452uBq5tseYtjxSMNIxmpC2VPZhJI0NVbj
 kAl/MHcuI4Zg8v0JAPemAoR279vdZllUnKg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb58r2md-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:07 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ryu44ss5h7o2fGu5+Ju+EPS40EB/buulD7nkK4JmyaA=;
 b=Do6Z8DCU5xEpbi/0U27bkUfd5Q4K/AZ8ped1yDSk2/e05VrrxMCvFg/Ujb27rfLTUJ6SUamWZJ6uEyPILNvn1kjVv/M0Sw3pXehW1XTeSIfB71sj40bwsYvpsluu7NQ2oRQp1/nU5L7fY6UCUiwK5OYOvMqoz8xYE5FFPHkwt1Q=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:01 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 02/14] bpf: introduce cgroup storage maps
Date:   Fri, 27 Jul 2018 14:52:31 -0700
Message-ID: <20180727215243.3850-3-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180727215243.3850-1-guro@fb.com>
References: <20180727215243.3850-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:fd07]
X-ClientProxiedBy: MWHPR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:301:1::30) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6b901e0-c2e7-4f57-a70e-08d5f40b5300
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:z+i+Trgy4ZHgh8PXFFuOiPl5AM4GMWgvZ8KL3xZBn9cJfJzMNlODUn/bmJFqbjIVqIhf3wRl/Q+Q65o7l9dTG2l2/x3Xxzvg4JoAUW4+uSGVoXSCqo5B2lR0ecWBeJg81ZX50Ih+eZQ+CqWclRoAZfbDf8NikllkpumX0LAlwt0VkXqTGrIIRQkwEz8af5UL5ukE4YpcsQrsT5luPOym/G5cl8GdgTVQuCaERLAf1D8hgdIZCSXzfhK98MotKzcW;25:sTuD0Q5jdKrcG1h8vA76xuYx4whQLl/QFu+WZUhBkJ6PGUfIx8/EVvmcBalCShwJnWmSp51aQM/ikDwPMBc9BNfjjPLkH6KHQiHn/BFUPPjIsmt79LIwF1ztPI74q1w8ndTBrpUuwuWEXdclV83oEpaghjv9xwd2W9vgtnI3DFEZpiNZGyyVbwBKMV5NiqjdecPrYDYNUa0+q0KKosqrO0H0C5Pt2TL9PmF+KOhOjRsLDQI5bVU4aJIxzgX5nd7nwzydq9iwOSM/PdyUCKJG3vNBRwQ2QkvOI7X94TMtHkBgnzAvaMr7vVRY9ujeXCklu+pGMq8CsKEfyO8JFOwAzQ==;31:jhUzoIrNR3mzdWKcJVJUf5paojWhJ3FXC32HhUU3Lnp8yY4zztGQEAs0OsYNO4q/ZvbBQURwq6kDcy56Zf4XfG/rLM6smy8JF2rc3U3fbQGaO+33GGCZHviNa8QcXldC7ZBm6VLG/IUpqNsVaasA5C4KJ0C8tyTo2srcRP9chulgRaqaCBZcvUM8x6q/aCbtRQIQJDQTD2E5ZfSJyWkfTgtqEpaRAqaMGd/1khnHo6I=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:1VlYz7kqBzpTSxbXqnTXiHNBCeX7bOGoDixltLMSW7WoIYzo4ohCWoe25XYb+c5elmWZ94EX5/CgYHwxpW5e77IBC7jOBb429MOFIIi8i2Z5zI82g+aP/Iik6fkep5ppSxNAXuz8Wx9u00SrSEYbpGPOGTSfnWdjtJb2ziCIXg5lpNFENmqdHFOhZdyK+bfd+8HCGxqUca8JRcT90zfy7y87CWm5xKOlBHEQ3bUYWHFz+kur/y7v98hd8cR2nm6YMRiNLbo/BGkMy/zybhDpyuVAtXOJaLrM15KloWXStVJmIrjP6FgAMwz1y4KhKmEiIXxNTq0JOcTj7vzgiYZL7TKOY27Zj39U1hcjV1iDmLTs8PQY88e0ziF22tVX83/x2e/QHKWPPKbWlC2rM00s551XBFRiJX3qfVIQwVadfkn8A4vD74eMd/I6BP6lQB8yargpnjxZVpbDbaGpVzHrMlPGxb/At7OgbmQJBUsN8Abjh0m2ODp+Od69V4Z4FZAx;4:DJJlEWuf5ByHMACpfZZ6o5emOhFNgV2Er/MYrNe8/uTG/LmhkWIKoyvxZOpW70vHRd5ancPo7iTVnxrOaamqArqcqiUg85blrON6uLwCeYkXKSzg8NteHW7m2gAgyYyyC3ZOeHfbezCcnRXz5uQfjErOaaDOQik658lWGvSxHldWHzvIdA4go5bUGJyUQ2cjsAPRCakraTu6J0q0AQSxBnEUk73yskWCsu+LVa7ZY/GJwK4ZAzAYlOQkshwF5td9Ss6Cy7txd28NCFNOp89RASZWbafkjkztnv3L7HVbhfV5ETazg2/G67rTagJS0ZI78TBbgt1xs1uYScQPYB3bjA==
X-Microsoft-Antispam-PRVS: <CY1PR15MB017187A08BB6968C66F789C9BE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(5024004)(86362001)(575784001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:fgeyZRxBXUoAyKE7buPEaj3ZbiqX/1lKLxFTwMRri?=
 =?us-ascii?Q?36NpxknRGG3LUYsVs31460fhCUD+t9FD0DmPJZ/H/EwdagGj/XRjWzwaeKdT?=
 =?us-ascii?Q?mr6aggPS88ugrp9anJd0+EyhETTL0TZc4B7iULIBxArrz9QR5B2jTVbRF4pm?=
 =?us-ascii?Q?FbEFL6LCfJCYaxAcAFavD6DDXZCHudXwpROtx18vD0OtzcS50Dzjo6/o+9W9?=
 =?us-ascii?Q?6Cn3cIELoH2x1nwCXLyVY7SqaF5N2i0YAVIFw3FXXPu19gpEmJpaqzCVPrZ6?=
 =?us-ascii?Q?WRM2A88k9CztDulRrNa8RGO7se2HkLIhXXW4CkUvC0epJWqexB+d2YrSJDBR?=
 =?us-ascii?Q?cTlQOG+nwQttAlnC/EBB4D8EkJhotsQ58MSA5wI9oDTB5L5Yl4jCrOpFKJHv?=
 =?us-ascii?Q?dljFAleyIpH2bMjSrBiSHWc7Zxb0e4JSBICV8s4nahZ4U8yEmg6hnHG1QJQU?=
 =?us-ascii?Q?jmLSPUxKg5PjzJxmKBMBvn7KMOo0mH1I7Asx1qW+HvP9Ei/eRMeQwOpZDpl6?=
 =?us-ascii?Q?nS2QnoGGuJaSrvCTjkzCZ1Zh9R7lRfvzsSY4Vlf21NQTuwUALLwugKB5agKU?=
 =?us-ascii?Q?5xZvMYZ0MpwEELZTeFJnUL29PDOiy5O9x5l/UExiR9ZbGpoIdP8g3TpyGmb6?=
 =?us-ascii?Q?rlt7YWwfrMV4w+PPZLWcVS+piF5A2tGX1THUXm1dDRF8pjWHlANA9iRsIGg+?=
 =?us-ascii?Q?2wsk55jkgrfvDJWW+7SQnCOxUqW0/kbnCaFmnOgO3cXFkhBY116vsH37Ns6e?=
 =?us-ascii?Q?DHCT+EZIWMoJFVi45NnEDNKHVj85zW+aLQLn93MuyiLZmRn2uoCIq5ry5YFJ?=
 =?us-ascii?Q?iPnxVFuquM37ZukmwRLIXVz6YMZQ1/7DLaHS/nh3XdWjZdhPKPheYbvX0/iC?=
 =?us-ascii?Q?aVOI6f8Gr4ET4Ap1FVfOw9+xPjIAAud9Tz8lyJlx3mMLEiETu6voCLEO7R4o?=
 =?us-ascii?Q?jov+LRt5i/7wouFlFi6ZuhU6ChAFOmxHVtJcMiuSngazmjOAV4pryHt6e98G?=
 =?us-ascii?Q?HgbXih3XjEAMaSAB4cAlHGCr+stD5l19WbhIZ4gmFKQrZ6y8GNIh3WQetA//?=
 =?us-ascii?Q?3x9lSdDw/RHX1g4v59R0/jctki2BswbyMvg/XqZupLQftCESfM9vEbTGhR7/?=
 =?us-ascii?Q?GmN2y64723dJfX0ErCyYVIa97qydBxqzbHNx2cqXCwmU4Bvj6B87agZZPdVa?=
 =?us-ascii?Q?AMtc/8O5la5ut7nb9+OpH4XoGpNUtGDCEi6SqTURgElTf8SP5N7qXtDr8jUL?=
 =?us-ascii?Q?ZQkB1lx6Qe88NnNm2t5f1WqFWhmGkLzaLZRZFGUqQJufQUkBAcjnzuRBHL/M?=
 =?us-ascii?Q?X5bLp1LB4CDoaKLIj0/4B5EsRUqCr2t3rpjnO+19ZrAoTHemHMjnDmtXvSlL?=
 =?us-ascii?Q?hoKVcTd+FPvwzeeCVHLrw+6bLk5vpvP/gwHQ4ey9F8Vqos1RQEygIgzEIbKr?=
 =?us-ascii?Q?ymfFMgFo+0qJeVvneHBzdqHuyGQlcs=3D?=
X-Microsoft-Antispam-Message-Info: jQBKz0hpIni06X3G1z5/S/9XU+73hjowCZzh/TxIIh4Kzm1R9C5q45WdyLUnqQ4jMyVUXtoU1qgnQNjjdlEphlde6tPwSs/vtg18UCmkdGKpMXLDcMeft9ohUPfzxR2iPQXF4flh0b6LJDCKDbTulOGLnbFJJPKPZB9bJsUC2fKqpXjwrI4zbKhcV6IBZybqVkXryhC7aA9Y4xHdxyeuRAndM0c3UYiikhwlj/IWx1AiXVoThcxK15HvFQe+MZK/bfUFQVepPEx9Ev43xGKJfwYI3M3uctXpyd9KF8+JO5bSETQoWzoBA6bBDoNs6Nfsf4oaEnJtTDT8KIAwaTwlG07Dx3qFwn1AiuWlPkwR18M=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:PaFkDaaKvd+nwKzgm5iYMdnN4bmtl5IH6nSMhcSC/jvoyAalRYrutnS8Tq8irG7Kx9AfZbLfjku6rCaTpwA6CYK5g8hLM9fcy9f4tbqDAKEyN+GF3CafCv3t3BaHSCiDLSPqrEmtXfk9IHITDRbU7u4BEnXY4x75AmzJxBX39SmMgpsa6/2t5mdhdRysK2Iu4kH6mRMfppZfjQDZoCOhpdaIaFVq3pZoyLykDGYowey/HLjWIKnQB2FWhHc9sMAkdsIlzgl8/Lne2N24KMBkypmZ4Jkwx08UNFwHoOTdDcnTbxt2oagohAikjdNiCsX2yqon0ZtWaOBx/k8/YTGBfJRrcZV0sPK/NX7r0yWoWhuqqhRAZ96gT62bOOdkJKov9xPmAtRHXI9GNsUbELKiQAxewjuB47AlS+NO1UpgtwjJE/OXDXFDOqtH1bV9UE6vKH6LFZ2xebnXdUaA6t2wdw==;5:Sz9J6l6pJCLlTp5r2wfqSHk+52gNLdtOdSRa0rj9f0Kp/rliJrgw0XN2FYndj2lCKPBTlJaHquK/PuGeR0sOFKLNh87nOtu3/Q0OxUF1e64SANwkj3tP5JUVwZvn8x3XNr80KcCbo2LUgQJkehshSDLCVQXYapdyFlQjP1w/jtA=;7:7pjO0eNYCcHI1qWMKQ6RbRS4K1CVW+ozwnHejVhQbMoEqY5B2zXFecKykGHqQwvnuWjElPjr4uSNF+EygujIhwA/XkEahY8JIQkLGKGcEalVMwpfxpzVqTg0HePtuihXLccU2KchLAkpYr1pMLufBFqLti9HWOkz7VUhPFb25odIsXcMfpEBKxUBP0YuQYCAenr+LyHZJGpwTC1kWFeL0mNGmfEo8E+Ag1scBE/rNQR1CwmCOhLZIbcvzDO2+9lQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:9hmPRvLsqgji0mnb161kzu23pSas/lR/hmqtD9WM846DcY9BGmi/Ig012lDXasw32W9+ygmBP8QNtw9f3yFfWum5UTclvJHjCRNzUjiq40mmCFy1l0kWaLVQpdnM76pKGlVOx3Zv5Uw1oezGLh6T9oFgJ/4a49V7bqwmn+X6+wU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:01.2638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b901e0-c2e7-4f57-a70e-08d5f40b5300
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces BPF_MAP_TYPE_CGROUP_STORAGE maps:
a special type of maps which are implementing the cgroup storage.

From the userspace point of view it's almost a generic
hash map with the (cgroup inode id, attachment type) pair
used as a key.

The only difference is that some operations are restricted:
  1) a user can't create new entries,
  2) a user can't remove existing entries.

The lookup from userspace is o(log(n)).

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h |  38 +++++
 include/linux/bpf.h        |   1 +
 include/linux/bpf_types.h  |   3 +
 include/uapi/linux/bpf.h   |   6 +
 kernel/bpf/Makefile        |   1 +
 kernel/bpf/local_storage.c | 364 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c       |   3 +
 kernel/bpf/verifier.c      |  12 ++
 8 files changed, 428 insertions(+)
 create mode 100644 kernel/bpf/local_storage.c

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index d50c2f0a655a..7d00d58869ed 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -4,19 +4,39 @@
 
 #include <linux/errno.h>
 #include <linux/jump_label.h>
+#include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
 struct sock;
 struct sockaddr;
 struct cgroup;
 struct sk_buff;
+struct bpf_map;
+struct bpf_prog;
 struct bpf_sock_ops_kern;
+struct bpf_cgroup_storage;
 
 #ifdef CONFIG_CGROUP_BPF
 
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
+struct bpf_cgroup_storage_map;
+
+struct bpf_storage_buffer {
+	struct rcu_head rcu;
+	char data[0];
+};
+
+struct bpf_cgroup_storage {
+	struct bpf_storage_buffer *buf;
+	struct bpf_cgroup_storage_map *map;
+	struct bpf_cgroup_storage_key key;
+	struct list_head list;
+	struct rb_node node;
+	struct rcu_head rcu;
+};
+
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
@@ -77,6 +97,15 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
+void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
+void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
+			     struct cgroup *cgroup,
+			     enum bpf_attach_type type);
+void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
+int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *map);
+void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *map);
+
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
@@ -221,6 +250,15 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
+					    struct bpf_map *map) { return 0; }
+static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
+					      struct bpf_map *map) {}
+static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
+	struct bpf_prog *prog) { return 0; }
+static inline void bpf_cgroup_storage_free(
+	struct bpf_cgroup_storage *storage) {}
+
 #define cgroup_bpf_enabled (0)
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk,skb) ({ 0; })
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5a4a256473c3..9d1e4727495e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -282,6 +282,7 @@ struct bpf_prog_aux {
 	struct bpf_prog *prog;
 	struct user_struct *user;
 	u64 load_time; /* ns since boottime */
+	struct bpf_map *cgroup_storage;
 	char name[BPF_OBJ_NAME_LEN];
 #ifdef CONFIG_SECURITY
 	void *security;
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index c5700c2d5549..add08be53b6f 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -37,6 +37,9 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_PERF_EVENT_ARRAY, perf_event_array_map_ops)
 #ifdef CONFIG_CGROUPS
 BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
 #endif
+#ifdef CONFIG_CGROUP_BPF
+BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
+#endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_LRU_HASH, htab_lru_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 870113916cac..a0aa53148763 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -75,6 +75,11 @@ struct bpf_lpm_trie_key {
 	__u8	data[0];	/* Arbitrary size */
 };
 
+struct bpf_cgroup_storage_key {
+	__u64	cgroup_inode_id;	/* cgroup inode id */
+	__u32	attach_type;		/* program attach type */
+};
+
 /* BPF syscall commands, see bpf(2) man-page for details. */
 enum bpf_cmd {
 	BPF_MAP_CREATE,
@@ -120,6 +125,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CPUMAP,
 	BPF_MAP_TYPE_XSKMAP,
 	BPF_MAP_TYPE_SOCKHASH,
+	BPF_MAP_TYPE_CGROUP_STORAGE,
 };
 
 enum bpf_prog_type {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f27f5496d6fe..e8906cbad81f 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -3,6 +3,7 @@ obj-y := core.o
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
+obj-$(CONFIG_BPF_SYSCALL) += local_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o
 ifeq ($(CONFIG_NET),y)
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
new file mode 100644
index 000000000000..395e7278ec75
--- /dev/null
+++ b/kernel/bpf/local_storage.c
@@ -0,0 +1,364 @@
+//SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf-cgroup.h>
+#include <linux/bpf.h>
+#include <linux/bug.h>
+#include <linux/filter.h>
+#include <linux/mm.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+
+#ifdef CONFIG_CGROUP_BPF
+
+struct bpf_cgroup_storage_map {
+	struct bpf_map map;
+
+	spinlock_t lock;
+	struct bpf_prog *prog;
+	struct rb_root root;
+	struct list_head list;
+};
+
+static struct bpf_cgroup_storage_map *map_to_storage(struct bpf_map *map)
+{
+	return container_of(map, struct bpf_cgroup_storage_map, map);
+}
+
+static int bpf_cgroup_storage_key_cmp(
+	const struct bpf_cgroup_storage_key *key1,
+	const struct bpf_cgroup_storage_key *key2)
+{
+	if (key1->cgroup_inode_id < key2->cgroup_inode_id)
+		return -1;
+	else if (key1->cgroup_inode_id > key2->cgroup_inode_id)
+		return 1;
+	else if (key1->attach_type < key2->attach_type)
+		return -1;
+	else if (key1->attach_type > key2->attach_type)
+		return 1;
+	return 0;
+}
+
+static struct bpf_cgroup_storage *cgroup_storage_lookup(
+	struct bpf_cgroup_storage_map *map, struct bpf_cgroup_storage_key *key,
+	bool locked)
+{
+	struct rb_root *root = &map->root;
+	struct rb_node *node;
+
+	if (!locked)
+		spin_lock_bh(&map->lock);
+
+	node = root->rb_node;
+	while (node) {
+		struct bpf_cgroup_storage *storage;
+
+		storage = container_of(node, struct bpf_cgroup_storage, node);
+
+		switch (bpf_cgroup_storage_key_cmp(key, &storage->key)) {
+		case -1:
+			node = node->rb_left;
+			break;
+		case 1:
+			node = node->rb_right;
+			break;
+		default:
+			if (!locked)
+				spin_unlock_bh(&map->lock);
+			return storage;
+		}
+	}
+
+	if (!locked)
+		spin_unlock_bh(&map->lock);
+
+	return NULL;
+}
+
+static int cgroup_storage_insert(struct bpf_cgroup_storage_map *map,
+				 struct bpf_cgroup_storage *storage)
+{
+	struct rb_root *root = &map->root;
+	struct rb_node **new = &(root->rb_node), *parent = NULL;
+
+	while (*new) {
+		struct bpf_cgroup_storage *this;
+
+		this = container_of(*new, struct bpf_cgroup_storage, node);
+
+		parent = *new;
+		switch (bpf_cgroup_storage_key_cmp(&storage->key, &this->key)) {
+		case -1:
+			new = &((*new)->rb_left);
+			break;
+		case 1:
+			new = &((*new)->rb_right);
+			break;
+		default:
+			return -EEXIST;
+		}
+	}
+
+	rb_link_node(&storage->node, parent, new);
+	rb_insert_color(&storage->node, root);
+
+	return 0;
+}
+
+static void *cgroup_storage_lookup_elem(struct bpf_map *_map, void *_key)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+
+	storage = cgroup_storage_lookup(map, key, false);
+	if (!storage)
+		return NULL;
+
+	return &READ_ONCE(storage->buf)->data[0];
+}
+
+static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
+				      void *value, u64 flags)
+{
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+	struct bpf_storage_buffer *new;
+
+	if (flags & BPF_NOEXIST)
+		return -EINVAL;
+
+	storage = cgroup_storage_lookup((struct bpf_cgroup_storage_map *)map,
+					key, false);
+	if (!storage)
+		return -ENOENT;
+
+	new = kmalloc_node(sizeof(struct bpf_storage_buffer) +
+			   map->value_size, __GFP_ZERO | GFP_USER,
+			   map->numa_node);
+	if (!new)
+		return -ENOMEM;
+
+	memcpy(&new->data[0], value, map->value_size);
+
+	new = xchg(&storage->buf, new);
+	kfree_rcu(new, rcu);
+
+	return 0;
+}
+
+static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
+				       void *_next_key)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage_key *next = _next_key;
+	struct bpf_cgroup_storage *storage;
+
+	spin_lock_bh(&map->lock);
+
+	if (list_empty(&map->list))
+		goto enoent;
+
+	if (key) {
+		storage = cgroup_storage_lookup(map, key, true);
+		if (!storage)
+			goto enoent;
+
+		storage = list_next_entry(storage, list);
+		if (!storage)
+			goto enoent;
+	} else {
+		storage = list_first_entry(&map->list,
+					 struct bpf_cgroup_storage, list);
+	}
+
+	spin_unlock_bh(&map->lock);
+	next->attach_type = storage->key.attach_type;
+	next->cgroup_inode_id = storage->key.cgroup_inode_id;
+	return 0;
+
+enoent:
+	spin_unlock_bh(&map->lock);
+	return -ENOENT;
+}
+
+static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
+{
+	int numa_node = bpf_map_attr_numa_node(attr);
+	struct bpf_cgroup_storage_map *map;
+
+	if (attr->key_size != sizeof(struct bpf_cgroup_storage_key))
+		return ERR_PTR(-EINVAL);
+
+	if (attr->value_size > PAGE_SIZE)
+		return ERR_PTR(-E2BIG);
+
+	map = kmalloc_node(sizeof(struct bpf_cgroup_storage_map),
+			   __GFP_ZERO | GFP_USER, numa_node);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	map->map.pages = round_up(sizeof(struct bpf_cgroup_storage_map),
+				  PAGE_SIZE) >> PAGE_SHIFT;
+
+	/* copy mandatory map attributes */
+	bpf_map_init_from_attr(&map->map, attr);
+
+	spin_lock_init(&map->lock);
+	map->root = RB_ROOT;
+	INIT_LIST_HEAD(&map->list);
+
+	return &map->map;
+}
+
+static void cgroup_storage_map_free(struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	WARN_ON(!RB_EMPTY_ROOT(&map->root));
+	WARN_ON(!list_empty(&map->list));
+
+	kfree(map);
+}
+
+static int cgroup_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	return -EINVAL;
+}
+
+const struct bpf_map_ops cgroup_storage_map_ops = {
+	.map_alloc = cgroup_storage_map_alloc,
+	.map_free = cgroup_storage_map_free,
+	.map_get_next_key = cgroup_storage_get_next_key,
+	.map_lookup_elem = cgroup_storage_lookup_elem,
+	.map_update_elem = cgroup_storage_update_elem,
+	.map_delete_elem = cgroup_storage_delete_elem,
+};
+
+int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	int ret = -EBUSY;
+
+	spin_lock_bh(&map->lock);
+
+	if (map->prog && map->prog != prog)
+		goto unlock;
+	if (prog->aux->cgroup_storage && prog->aux->cgroup_storage != _map)
+		goto unlock;
+
+	map->prog = prog;
+	prog->aux->cgroup_storage = _map;
+	ret = 0;
+unlock:
+	spin_unlock_bh(&map->lock);
+
+	return ret;
+}
+
+void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	spin_lock_bh(&map->lock);
+	if (map->prog == prog) {
+		WARN_ON(prog->aux->cgroup_storage != _map);
+		map->prog = NULL;
+	}
+	spin_unlock_bh(&map->lock);
+}
+
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog)
+{
+	struct bpf_cgroup_storage *storage;
+	struct bpf_map *map;
+	u32 pages;
+
+	map = prog->aux->cgroup_storage;
+	if (!map)
+		return NULL;
+
+	pages = round_up(sizeof(struct bpf_cgroup_storage) +
+			 sizeof(struct bpf_storage_buffer) +
+			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	if (bpf_map_charge_memlock(map, pages))
+		return ERR_PTR(-EPERM);
+
+	storage = kmalloc_node(sizeof(struct bpf_cgroup_storage),
+			       __GFP_ZERO | GFP_USER, map->numa_node);
+	if (!storage) {
+		bpf_map_uncharge_memlock(map, pages);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	storage->buf = kmalloc_node(sizeof(struct bpf_storage_buffer) +
+				    map->value_size, __GFP_ZERO | GFP_USER,
+				    map->numa_node);
+	if (!storage->buf) {
+		bpf_map_uncharge_memlock(map, pages);
+		kfree(storage);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	storage->map = (struct bpf_cgroup_storage_map *)map;
+
+	return storage;
+}
+
+void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
+{
+	u32 pages;
+	struct bpf_map *map;
+
+	if (!storage)
+		return;
+
+	map = &storage->map->map;
+	pages = round_up(sizeof(struct bpf_cgroup_storage) +
+			 sizeof(struct bpf_storage_buffer) +
+			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	bpf_map_uncharge_memlock(map, pages);
+
+	kfree_rcu(storage->buf, rcu);
+	kfree_rcu(storage, rcu);
+}
+
+void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
+			     struct cgroup *cgroup,
+			     enum bpf_attach_type type)
+{
+	struct bpf_cgroup_storage_map *map;
+
+	if (!storage)
+		return;
+
+	storage->key.attach_type = type;
+	storage->key.cgroup_inode_id = cgroup->kn->id.id;
+
+	map = storage->map;
+
+	spin_lock_bh(&map->lock);
+	WARN_ON(cgroup_storage_insert(map, storage));
+	list_add(&storage->list, &map->list);
+	spin_unlock_bh(&map->lock);
+}
+
+void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage)
+{
+	struct bpf_cgroup_storage_map *map;
+	struct rb_root *root;
+
+	if (!storage)
+		return;
+
+	map = storage->map;
+
+	spin_lock_bh(&map->lock);
+	root = &map->root;
+	rb_erase(&storage->node, root);
+
+	list_del(&storage->list);
+	spin_unlock_bh(&map->lock);
+}
+
+#endif
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 40119aef9ddc..23978d898938 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -957,6 +957,9 @@ static void free_used_maps(struct bpf_prog_aux *aux)
 {
 	int i;
 
+	if (aux->cgroup_storage)
+		bpf_cgroup_storage_release(aux->prog, aux->cgroup_storage);
+
 	for (i = 0; i < aux->used_map_cnt; i++)
 		bpf_map_put(aux->used_maps[i]);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25e47c195874..11d3669bf854 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5152,6 +5152,14 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 			}
 			env->used_maps[env->used_map_cnt++] = map;
 
+			if (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE &&
+			    bpf_cgroup_storage_assign(env->prog, map)) {
+				verbose(env,
+					"only one cgroup storage is allowed\n");
+				fdput(f);
+				return -EBUSY;
+			}
+
 			fdput(f);
 next_insn:
 			insn++;
@@ -5178,6 +5186,10 @@ static void release_maps(struct bpf_verifier_env *env)
 {
 	int i;
 
+	if (env->prog->aux->cgroup_storage)
+		bpf_cgroup_storage_release(env->prog,
+					   env->prog->aux->cgroup_storage);
+
 	for (i = 0; i < env->used_map_cnt; i++)
 		bpf_map_put(env->used_maps[i]);
 }
-- 
2.14.4

