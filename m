Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B11ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ED320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SYsYSJbw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CQuARcHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85ED320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbeGTShF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:37:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38242 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388126AbeGTSgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:36:02 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhhGT025819;
        Fri, 20 Jul 2018 10:46:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=8NLCIWV9StwuXUEJ8T6cx3ZSKB/bXi1rvW79EoOIJK8=;
 b=SYsYSJbwR+YEJuUNuvsrI27aYMCBekG7foQFnSFQzBhkJl+7UXf6JnxMpvTqRfOva0bT
 MqHo8Hk+2Hx0t3U8LshJw2rvCrPFOJzXJiqbpoO3ARytW9KhAOMSboEYBR1bIfkglL+V
 PrlCckpicidfotl57GxUUBiXOo7FfggRUCM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbmbv80dh-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:46:20 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 13:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NLCIWV9StwuXUEJ8T6cx3ZSKB/bXi1rvW79EoOIJK8=;
 b=CQuARcHt/ITh5QSLnRGcCmOEUn8tBBA6siXfXrLvpXcfTyWysyDcc+Cv/n7Sl4mfvYZDWMG5nL+7jMH5WRbiEjEW6J5UB+VuXpB3vyhgy6zNVDwcwiNgOPuFhpeQNPyl3ErZM80ac/Ajoic7kFgwLzDrTAhpbYRGrlHg32/fsiY=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:15 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 02/14] bpf: introduce cgroup storage maps
Date:   Fri, 20 Jul 2018 10:45:46 -0700
Message-ID: <20180720174558.5829-3-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720174558.5829-1-guro@fb.com>
References: <20180720174558.5829-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:ca05]
X-ClientProxiedBy: MWHPR17CA0096.namprd17.prod.outlook.com
 (2603:10b6:300:c2::34) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bc31e68-116c-4155-53bd-08d5ee68b14a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:jpd8Pakc26AIvOaSfDI7bSeHIbCWuc4DoCcTYuN2TDXBusIqpVGQQSDmTNgYWVOL3ZUfuUbwJ9mqYQ+4iY+wYBGXSNGyhhZnLKYf1IOE6qkuLHLFj/sGjuW9fsQtjBryhxIEhMDuYB60qDs1pi2hPKJt3zcItXI0D/2zbqYvtYEc8msEHFKL55BYCPjMehpVt3/ICMvWVUh3uRKalRjOlH0P0BB0//yf350EkOizMcp6ajJe6SP3DWb6j+0ydJjB;25:T29jSHt1NOo9NmM3N4ZsKZRn8jedJKDHbgP1NlhPNTERj2hn2UeEBaSK0Mh7CjfZcDwOBWc24/p1XcXyxfocmNKgVRAwApGEYK55/9lPzl4x43YwebCZGUqpWuRE3AFG7F1J945HGL/v8n2sVnVb+KuOSg30y65Z2sl01kf56Ba7M1QYUOoOXJm8idd87Kml4WkzzJk64mimIH7SPQLsI+OPgVMyy4MERsbN3084ECIq4RxZqJyuS1qv1GTxCyYW4CNf2jiNzJX97ZS2V2Nq+KFeOoNDaWenOeP/JiSPIYyB8bU9FMNLbiAvuDwbl8nSMTZ8bMQXJNaYitKv8K3g4w==;31:22AC/i9m9OFndGmCz2aUA1tsGlSTQWKxdseI70ogT9zyt857LlUCcDSBTgAQACn3EsgZkPUea2LwsRqv4VM9OkPOQZkNBOwpRATlQ7/gpF5CGc66isbrImOXts00PcW2vwed/8tvSPmDF0kDpIDPf7iFFLjuzyT/OMOdzwX5GhLBVpJotP2oGNz/7D7rRfzhAUWPca2FQJHAR/tKXX1eBhuyS5rwLZpIwb5xeHL1iKU=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:mwtXGHIrOS/KI2n9GIPsFUTaXDGw5iNYcsnUlNHUAOcgLuR95VNswkj2spE1+9QuyfobS8pJUOTgEQj3tU5VSaTq2k48g12ynijVSLaaKuKgUZ0xxD7UrriQw9BB4vHAU6U7f1UxgPJn9Ws78pBJmwdO4cK20thCjnINuQkHitQepSl07/GoGlWx3iVcSbi96dknfpx2Qmz23L/G/Hbb3BOwiIjFk/HafTEO4A0bAd5k8SwV4GbiHdrgYgI/Mx9OyqXOiJkGHC0Ub4FbkGGaqMUKzd2p7KFPGx5hJMKmHScsYIGLjT9aWYPNEMuS3cQ/pQPJPPEPPR3PMPgnNCh8JXiRUB2Ya9V95RKDPJqCkrVrFsY1W4/vRNtkmpe0172nUExX7pcdkYo52dWG/ZIrhu4ASfqr9VRqzzh96NTknqO4Sqp4dtdo102GaqzZ9izdasjbcVU3Zc3GZ9AZeMauXQPSmedEstSLE023cYP433NbP9CyjQm9GE/rXP3C3vNe;4:eGOvMOTjqBTzkoDE6ad1FQGqeTqBp/QPYy8biSxoNBiiiZtjUJEUlE41vxWGGVuRoGG5JuwY10gpjcC6DTVzbCV19uVzD7hUsZek9Bzz8tHZg4MnNxjltMOsL1wADWP5IsIDe2EobgAY0+BliZKKmseUPCVIJsJR2asjDSoY/MZPTLBX0HxMspuvqHsUdgqhY1AulyP02zQfBMed0dXfjyiTCrnEUoNMEdJjscqOm3+zejnhp3D3IGIviG58Ovg73UMJAu11HGT/a2nSH6C/KBzL/E3MJ4CEVOK4LnpUqXdkVTMLXNZNd5VbNj6+BTs+eSt5SeThuTFEWN481E6ZvdfOGXW+nds9j/bqF4o3ONg=
X-Microsoft-Antispam-PRVS: <SN1PR15MB0175840C5BE86F92DA37CBA3BE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(575784001)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(5024004)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:diKC1VUCafO5q6PUtDWHqZilwxDAEiaaxnhHHO5Ef?=
 =?us-ascii?Q?FouXMWfJLCsFXTJUfRcUWYx8rBPtaws5SZJ2v3X2Be3ryqQNcPrSg9oZRCwv?=
 =?us-ascii?Q?hGdNTTniv8Oh61LxmpzzUwNp8MBzvwJ50/h7/VbSULQv58qDHiGjWYXzGVoV?=
 =?us-ascii?Q?sfBsoC6oiChrcQA58xh9kPztm+wLcqwnBCqQkABMaCU5/V9aFF5UsSz2/DjV?=
 =?us-ascii?Q?isNZiDgNkgGUJLSnLF4ZX/xRfgXt+5CO2NAf/tvpl052Q3FuOJZZVrYlzcce?=
 =?us-ascii?Q?0UtclIXP+ATj0Q7HJ+nh9Ck30OBEmSLvgwDFfMzvnpN2km69G9QZdnqzF86Z?=
 =?us-ascii?Q?eah44ZR+AMdCLYN6xvPLQ/wzjfBAZEHW5j7CnYhjrN85/zrd/gkH+D++ocQM?=
 =?us-ascii?Q?YwmL60WfkEkXP5vMxANJ/lk+UxDE4SGNoP2cmETkaCpvrD9+kltYOOPKyAPI?=
 =?us-ascii?Q?YzAE6lMPnTbNkk7aU03RGg+SzY1QL1Igfi2d/617QWV9aPeAFykqm5dKEKIi?=
 =?us-ascii?Q?RNZvW6jJ++OzbLsU8HDyGYV2oEgC4Yfssp3gUF3tXH4pWSlhkaumA6K4O34W?=
 =?us-ascii?Q?Xp7CsiaCCfZW8uXOcIcMysHrKTyiAhjFujxFIfRso9DNuPN+agyvMqR43O8d?=
 =?us-ascii?Q?20CwJtaWqptOrDwruL9CTWUK1SK/QBsFl3jFFGOvwu6IdfQxavz/0tXorFDI?=
 =?us-ascii?Q?UY7SLGIrlK5OeQ7yePxMFMqYmlQONaS4OEtfbhSnDh5/gzfEiMbitVxps1ae?=
 =?us-ascii?Q?4vYK+SYJ3EwpxVVUeMmFzilJUQtrd2fB5GvdOJVB7buPWDYXiFzuhs7o1Sme?=
 =?us-ascii?Q?EFAZzGYzXKbQg4ME79/h3wNN5RlU1o/hKNfM62hsAhezskXOu3XAM8vmim6X?=
 =?us-ascii?Q?El3Z3KbdwfbR8bTLrmjZilTAZVZe36GUMcInEKelHJAEAq40rqgUQ3yCGs8c?=
 =?us-ascii?Q?ykZGym1oA4weiwIL8hwvxeLxqrfFFR5rn7rfpNS2Y1C1Q0MkC8RL6NePGosJ?=
 =?us-ascii?Q?B8bKTaj7kEsjy8yftphkNucL5ls83fNK3p21KLlPz6JTp8Eq6Wq7qibLxUpA?=
 =?us-ascii?Q?Agh3zVI2TBCNczT0yUgGo0xeMROPDuYR5rxdo6sxRRfCY6YIClR/9qR+z9Bu?=
 =?us-ascii?Q?kNU2l3nerXNAlsEzyWD37/o6h9NJk57sIbp9u3OotYD3YdoERXz9KLizKor2?=
 =?us-ascii?Q?jBDr3qqiccH9GRL3Agq/ux++K6dXw1LPDnPs0yKq9rVl3eoD2Oge5S7S49FR?=
 =?us-ascii?Q?yAoQK7MXC0nGvMiBW11Bw5F1RRyaj0zYwSnjpN1nNwRl8+a3gPdy6iIXqUmO?=
 =?us-ascii?Q?pNs0OAdSYHi7IP5OTk4PDOWIJQ/qaliJeEUacSPAR8o?=
X-Microsoft-Antispam-Message-Info: 1PeRJqdWMbYts7v5KE/51xR5MyXnnjN/AhYPS8jRfmHbFjAs/11Sv6cF+OiNKM1fgYakeK6AxsVDn9DXZwr7JZfMUV7wlS3b2EdqqiNMQ+jr+Aq1uDuP/d6gveSdXwkws1t3S8wQte3gEuALdJpELp0X5bzfzZ2ZfWsLWz/DEdjgoFG4K31CPCzH83LkCuWcCt0zXiLWjSFr68BNa/qDDML1yRRMihLGvAkjUg4mNPwWw73hjOa095kN9sEotrP0qmwjv6SdlMbeH8O/zdR3mqAab9uh7p49IQe22JNHJo6KnGAcrRqAKvxsLqDOQJQco8dzBuv1sHz1PPK8hepsdxmZ3Tj8Knr6JWcY20Uk5e8=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:8J4u1L0FWWtBoO5YZKV8P1jhdS6Eun2wqyuP8aYi03yLABdz/6HwEMgMtyCF5aZnENdYwDDa5+MIRZ0Zr/gx1sbzJRI5jA3ETjaS/tRiXLNt9Asr3skq3/PHmEcO80EYGzUGYrAtK08SwPQzPjI1fHR8SFxMTSZFKXNrHjTApZQixawtrKTYEmucJiXP/KkWZV9m6f3LIpLcwxIstqpHtHenAs2MTYyWWqQrsNDXUWR7moKQuAsAJF7nSxJTGfXi8BetvSxXtarTGgvfH+XYGMOqnfNOPCLvgPr3kZq9KHE2MZvMC+EKGFfcWHsLJxuTd4ycVifmxkDzcxCtLL//WiQ83aC8TX6dqmROmkGcHkTWqL/QUmAj0WsS4/V/BIKJjxdiRRJDltIGu6r/TojVGfq5QLUX7tjOC/P2A/5PGqucq2iZR6O4Bsh4Az+PLc7CH+28/RJa11RQAqiYW/Nw1w==;5:wdJpua/Ylcx1r/vTKd4Ra/Vf2nUs9mjKlrs+a107vN2G792Yu+roaeYlENaSQCrZLrd7NgdYbP96cSVIqoXOV14I3NVfXsfYfXWvR5t2lcX2EmLsXYM9UKeVlvy3FkY9ua+5gQaQo4TvhCCTz1MJzhPP8yGTwRuD9CTci8sARAQ=;7:Q9p+DT6BVQu/57d6gWPsnxwexHdk+y13Y/53y0dgqBfNP3/k/qZ9drX0J+8zo9LJJKWf4Z8BEsfNCjjALNgBTjcHV1IboTAFKfcUuXSTXHNmIErIJoU7yVC3uPZSOeQSZ8x9RO8oh1nwqWUuiErqs5XK/TLQkomAKg6msPnqfIEBKl9HuVYq+A2EgkFMmklX8miIJj20t3vcj+Nxzqhw7MqGYeLRyrGIZnRP+ruxFBrQiHlDCs3YaKLR8o2UB6nL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:StTqo0lhxZ8BQPpdGCAT7FiEH07lU4FQOhQdIEMumwXX9Y7erXS8eDOYFy7UTp+a3E1el3FbtWfMVsmzZtCVG5fVMDCA8/1hNxNC5VjFflNQmBs75MmkCJyprLeMr22vbnk/RJEM/G167VyDSIRRujYtc7zBv4MAxedu/OYQ/AI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:15.4205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc31e68-116c-4155-53bd-08d5ee68b14a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_05:,,
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
 kernel/bpf/local_storage.c | 367 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c      |  12 ++
 7 files changed, 428 insertions(+)
 create mode 100644 kernel/bpf/local_storage.c

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 79795c5fa7c3..6b0e7bd4b154 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -3,19 +3,39 @@
 #define _BPF_CGROUP_H
 
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
@@ -76,6 +96,15 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
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
@@ -220,6 +249,15 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
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
index 000000000000..940889eda2c7
--- /dev/null
+++ b/kernel/bpf/local_storage.c
@@ -0,0 +1,367 @@
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
+	struct bpf_prog *prog;
+
+	spinlock_t lock;
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
+	/*
+	 * This lock protects rbtree and list of storage entries,
+	 * which are used from the syscall context only.
+	 * So, simple spin_lock()/unlock() is fine here.
+	 */
+	if (!locked)
+		spin_lock(&map->lock);
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
+				spin_unlock(&map->lock);
+			return storage;
+		}
+	}
+
+	if (!locked)
+		spin_unlock(&map->lock);
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
+	spin_lock(&map->lock);
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
+	spin_unlock(&map->lock);
+	next->attach_type = storage->key.attach_type;
+	next->cgroup_inode_id = storage->key.cgroup_inode_id;
+	return 0;
+
+enoent:
+	spin_unlock(&map->lock);
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
+/*
+ * Called by the verifier. bpf_verifier_lock must be locked.
+ */
+int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	if (map->prog && map->prog != prog)
+		return -EBUSY;
+	if (prog->aux->cgroup_storage && prog->aux->cgroup_storage != _map)
+		return -EBUSY;
+
+	map->prog = prog;
+	prog->aux->cgroup_storage = _map;
+
+	return 0;
+}
+
+/*
+ * Called by the verifier. bpf_verifier_lock must be locked.
+ */
+void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	if (map->prog == prog) {
+		WARN_ON(prog->aux->cgroup_storage != _map);
+		map->prog = NULL;
+	}
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
+	spin_lock(&map->lock);
+	WARN_ON(cgroup_storage_insert(map, storage));
+	list_add(&storage->list, &map->list);
+	spin_unlock(&map->lock);
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
+	spin_lock(&map->lock);
+	root = &map->root;
+	rb_erase(&storage->node, root);
+
+	list_del(&storage->list);
+	spin_unlock(&map->lock);
+}
+
+#endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 15d69b278277..0b089ba4595d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5140,6 +5140,14 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 				return -E2BIG;
 			}
 
+			if (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE &&
+			    bpf_cgroup_storage_assign(env->prog, map)) {
+				verbose(env,
+					"only one cgroup storage is allowed\n");
+				fdput(f);
+				return -EBUSY;
+			}
+
 			/* hold the map. If the program is rejected by verifier,
 			 * the map will be released by release_maps() or it
 			 * will be used by the valid program until it's unloaded
@@ -5148,6 +5156,10 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 			map = bpf_map_inc(map, false);
 			if (IS_ERR(map)) {
 				fdput(f);
+				if (map->map_type ==
+				    BPF_MAP_TYPE_CGROUP_STORAGE)
+					bpf_cgroup_storage_release(env->prog,
+								   map);
 				return PTR_ERR(map);
 			}
 			env->used_maps[env->used_map_cnt++] = map;
-- 
2.14.4

