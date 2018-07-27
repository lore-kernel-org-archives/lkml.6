Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32720C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB60C20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YQGmzLIZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QzgQ9Sfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB60C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389910AbeG0XRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:17:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49316 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389766AbeG0XRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:17 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLiZv8014706;
        Fri, 27 Jul 2018 14:53:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=/x8N1Jk6gVN+sXKP9uWCZsYhlj0Usy2cY3fL7ddilXg=;
 b=YQGmzLIZhlk7SEiHDsS7G8E/pHBIB0/AAeolG3ewWtilc4oEbz8ZsPTCg5WqTCVkgH3D
 mC1JEoZdaXK5AbtPce61tXI2c3NYdgdtvraPdXVthZp6mbNpBZb2XhMkrNuIY43k8YX3
 CkfwG9FZDpua1lhMInnkHWSCqmQXHThS1tA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb59g2n0-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:05 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x8N1Jk6gVN+sXKP9uWCZsYhlj0Usy2cY3fL7ddilXg=;
 b=QzgQ9SfyIBLHUFd/DszGlVFiidgc2m+DIWhWcfreGpB8vMFCsnOJMWAhAVWuj8l0Oaz15IJwPl+qEpRclJ8OD4AiIJPQVutebqQqV8IyVLSTrUkH/1l9a/eE1wbkt/0m1w3LjnGCnbibIa4KCQE3C8sSpUjXWyUbCNrH2WdY0Kw=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:00 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 01/14] bpf: add ability to charge bpf maps memory dynamically
Date:   Fri, 27 Jul 2018 14:52:30 -0700
Message-ID: <20180727215243.3850-2-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b569751-14cd-4948-16c1-08d5f40b5273
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:oL67KgFuCX128pIuLXFvd3z+/2lNXeRAxsrNeIX1Tgun5TAeoRxt2F49B7axyso/cEEgpbAG/fDdmxT+c8B24J3Mtv0Y/6hLCLq1ZZ7lVCNfQAPQLboVAT0le53B/ufFjE7b/7wqVWP76EtAETbWP/OlmpS19INo0bRCLHFhzzHrmKGkZ4KJosZtlC77d1wE+QXIroibJhu7WUUa2ZOyeKQAZLkKwYRvVf52Wjuf7CIZLMRwYCsx1pkq1DyEg6vp;25:7r1k49TTmsuLR+D+VEcqxPhO1lHXV1838uUjRfit2Vr3Ejbm6aLcONSon60aMJ/2u0JJPdUuRGXgw1fgnwRxuJ8KhEElfeeEdiohW+R8awzB9jALnyJRtkzUOllRTZEHow8A5woreI0Jv2RRYT+hhm6qR3Tam7MTi99wiynNIxHQ7OzcIDBu7qTrdiQHBn1Ie30OnkmDAsixI/nnot3dcoZVz6S+B1r4TsFaK8XUJGkD41BDlAmm1xfF+kG13wIlbdxf9HT7eD7kcpW+QtuDXMbdOa+bzuqcHmXKA2dQTNQWNJTyFxUGfP0+rl406oql+LdSQH9Gmzlqbv2nm98FJA==;31:daX+xtQzndp/AWZQuI3OloQ+LoVZ/RfybQLoA7X3dUDEL9AF/LY+graPmPpWwzvQTZmPR1kKgba1UVUz8NntoT8pZGER9XwyFnUMDrykzVuo+EpYQoZchRYrz90fncQa7OCtqBG0xLxnoYQVhBRkIxvjA7es9aq0+qOH1N2wDtLZT6MhnsISpvJVi6EkGwctY98Ksy75TALlAT7DGMrkaodGO1WV4NuK06Q3Y/yeAQQ=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:7uOa0401jp9TJy528ewxKw8ltEOg8bDlV6+wZcGiL9l9O8CsJpDgZxs/zekyo8CXQWX0wzfzou1SF3C8BAG830gxwBOj0n5cb/uqWa50w1xxbFPUyxkyD2lpbzn9zv93KYj/QOO2AWCUlwWx4XSPHSVlECxxHRpL8h1rVEjYwt/vA+vm08n1LeDxAHBGYeWRool1fukMDuDbKuBoJnxt3aHmNo3E6Cgf95cW4ZuGj9725iNmSGiNkyX1NkhXt90ByK2LLrr6T6rVnmCtaQWdtSaDMHuNKF/BipuPmD7pJ/iNzXCcYn4Fvh0orbl99HPzw13SF6RksGYhYjoC8xLXOS1Jkuyg1z74ibc8A40g1BzDmLBYkmXuUb0XncMGePmAnKED28kZL9qDISNltdneSA0myC8rIqnSNutOqiVkGqDUK5HpaEWSIMh6dKeXxXqa4QZzjtc34jFu7qTnRiRzKPDcyWyN56cupUgF+dU41D3tBeTEXt7gdkvWEo3oBz4/;4:cIrjmQ1NfZxEycI8HuSeSTzkK48jHrFSrK48vUe1BA/7xpf3Ue7uWzhi8vRl4K0V0DPja3TXH2vQMGwx+fklWPAAX1HHvue6H6CA+QxMld0aQXd/NHYNwB/EEVIY9OpZ4qtZ0XhCATkLIpgUfHEk+1Rjiq5Xlu0FH1eZTrPfBogXdQW10H054pFZtciUak+VC0t+7vEG6o7/rWsm+JDV4QpDo3IsM+AocNADFHpx/FDywnF8HxN2845CDyC0j72YwB7vLQZplQkqORMAy+Qnw+vN63td6zXq3zZi/EDcWlBzJcqzRm0zrbjtL/rgJmhLxzUSqjuS5VLlwt2o7x4/An3ugODRPFEBQuKYNbHWIP0=
X-Microsoft-Antispam-PRVS: <CY1PR15MB01714898DE2C7187495F69AFBE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(86362001)(575784001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:S4ks0mP40XTKxm6y6nQIVQjBD1/+S1kf1w33hDNyn?=
 =?us-ascii?Q?sVvjgPcdVI6of5aYDZr9TE9oh9Cod+GvnY/3pnOgbtKtgKykmyAGAjiCtPA3?=
 =?us-ascii?Q?dtkYa4g1juiwUHwzKe1xUNbIeDRAaXmvW1LdoTk9xEP50K9D8ZWe8ma7j+Hz?=
 =?us-ascii?Q?mo8+rCe54PeCm/QdSPuXqykEdIY5X36kBaWvM8XL7HLR5OqkoF4xAdKHK8Di?=
 =?us-ascii?Q?4c12Q0Kow9IKT8gA+cbg0rZa9lzKnjzTFSDv4bJoqTMJTx31Nf8VbEqW2d4M?=
 =?us-ascii?Q?EG0r47cuUOdKQ+gjl746IDwVxi4jrv0jdroOvZWIjYFsk5tgOKvlHVmFgUSi?=
 =?us-ascii?Q?xmMv37+xUrc+y5ZnMld7IekZR08V+CPxLMH7u9658AKOYAUeyeEIwFktB+Xm?=
 =?us-ascii?Q?cCrbOzHmxq/NOoCbOFWxFnkcKsZfU3ejDbS+lj3AmF29pscsV9MIB83/uFIm?=
 =?us-ascii?Q?VGlkYedMKAzQFMmNDUJ2s8hG2PxgRXFFhv7TGdqMnsln9JE8jl12MeN2t8Wv?=
 =?us-ascii?Q?KDmHd0qRSG3nN3TISrJ3cXcAMJ6gF0GgqlLj4LmRJeQ5d9ETwrZcT8R7M+Zv?=
 =?us-ascii?Q?gAKt3i60vmS8AQRnI6o6uzbhQ38bAfvEoX7UlYL1shi7U/IcERadK8tRm+oj?=
 =?us-ascii?Q?Pkbp2LiR/irjoph/vBC4kV+NghV0hX1FKX+QeZA1llTHvg5lNP4IBVS/0/4s?=
 =?us-ascii?Q?l+Swoa8Ba52rgMGScHV2SqTZq4TomNInsAI0wL8BQUy0gLBYNLwpKouE5vwd?=
 =?us-ascii?Q?XiJvBi19iA2RoOILTf2HtO94DMDyvhJKFztdXr+YmS3319bSZiHukRl7uf0f?=
 =?us-ascii?Q?S9dpZ9Bjr1IDkLnBOErPHZhnfv5fFOc0jOVoVCWRvyAXpFK2uCLewFAeySes?=
 =?us-ascii?Q?mm1VHCTjyuoKoQ67z1AUgw2nps4g2DiBg8/fB+flcFoJ+5LoLyets/YB0C3X?=
 =?us-ascii?Q?sphnFTo9Nj6CDIUFeQYGhulizryhKsIDcE97aEVg8zgtXdvzaRongD4rP1+r?=
 =?us-ascii?Q?Ycy/5sNEG/NMiezijSYAamIiNYqbMmhxqXzkUApW+LONd+zyVTWv8eycqcBi?=
 =?us-ascii?Q?A12zBCMw0F+0eWQheuYyx/m76q6RWmcE8Fmi6SsgtwyHr9FtNDSTvSN7T0oO?=
 =?us-ascii?Q?kWmMnW7EkCcSn10cda1FMKEzXYu3elOlYkUj/qf3yN8oOZPFsXYDRMlECcfr?=
 =?us-ascii?Q?9GdfFKZmogaq22QuQVS0w1Gnur318yBpwnpc1vcy0GkE2vZIVOc9DK925XsE?=
 =?us-ascii?Q?KPQ68md+upw9bEsvDc8LvVG9LrtnAGtafgPHYQ6MMzqBMPXnalqh4xg+3JYj?=
 =?us-ascii?Q?GHVCC80IPZzHCW97X/qtf8=3D?=
X-Microsoft-Antispam-Message-Info: /D3MrbYIQOYyjTotIKZvFbp4HlgjSlTkXE8tHLS+8kBsPqm/cPKPE1uphG5EY9CVelLd0jbTMZCiPJ/GpCNMkvaaDQ5W8Nr46HgRtUyfQtqRHCTZpvGj5y5mLKPU1sOAH0abcrHLJaZO6mk9RzO1ms0p0gDf4TdSB8ElCs2Qt9I+UDnC36yq5IfyJQek6o1CEylEbJWcu4CVVlFaK797VwiG+E36V8MR/bbxNvZjc+GaE8JE49HA+17gUT5c8sIpQjgTHGnz56xGZ8QfFiHxROnUWDSc0ew3RNXwKrGJ+JSzCB60esM3Jbv3kSCsK8ygQiY5KGq/qn8NYqlCWA1Yzb7HLPx8w5rWqfhsjn2AJzw=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:avRmCGV8AfSSf0wHbwPXBlRQnPyIO8oS4YNPfpFAW74Yr9lJ4RwiVg89WXOPUpi5xEiasbs8ll2R5AL3pIh/E0YQTi+X0GFfVOUqVyGTiiajG0JFb+Jz/JqExuzVevEmS1bI6VCNFg78Y6eNIVwIKWMQFWFHAMbW5d4GPFBkiDI3f3sMZp7kQf3xXBiihJRnl8v5Hs9WV2cAts6TGyvQD/+KvWecGmvDbEQE4bb/evmK+DIl8LMWi5oIthYQOx1bh5LqUrHFEg4tl4KKlKHd1yRSeU6AdaejDUdzNtedGIFBIYHQ+lgJqhK9RyLRPNluNswwsEW0FD8KI0MfwuXgHyWp6tdVYhkkmlemKN1zlVhjoZZAPjcu+5JCaZw7LkLz1DXXjeQyLaDfLYnr5wWJOotKfiHI8sVT7ILcYLUDV0JqjSDFAFng6fBk8m+oKTkUKVg8tvrHaEyntXld3CFVGQ==;5:PmgBTZJA7yFk1QznbCEwYzZDVUk/dOlKHSEgdfDPfz8tYebjGZTlnUzuGPrhzx880re62ukPmDdZ0rq21dIyV9LGfhBctJ3t38KUB3KdK7SGCs3c/cxSjF/FI2K5VXnHcxpE/NLy328enlsdee1et1FOeIySx8oNklY+rIGrQlE=;7:V7j94WFDN1WP7IucX48EQZeZitx4ycttq0bnBJUbeHr+g2pGiuBuE9EGtpNYEYAJIHR1ZKf42uJFn3NZVrJeHppirjvGbKxFmCJd2om5XUJNjt2+bQahpVFGp+RtvKzIjt6JmyG7mZnNqA09E+/8v3pL3yju9pKy/WV/2TJqBMuAj3oJA6cJq5cJrwiKFPpXJB5nPsb2P1if+UNEeRf0AsNiCqE+wkkXgaCUWDdu7qxPUqw+0b4My4mUTvPMQMU+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:SopfaMgDufrfqb1QpdULm3L0HbwubDltxAawrCHTMDYyoAdFGik3AerndjhXravHvDb9MymHv+dqiNI+uCtg37TXF/8srZnDD+g2ugVfAiIfqVSIrpHcnJURQNHOkiD4EgBTg3gmZwdRquMmSe/R4Ca+xTNC2dPNd4A0u1U+HAE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:00.3401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b569751-14cd-4948-16c1-08d5f40b5273
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

This commits extends existing bpf maps memory charging API
to support dynamic charging/uncharging.

This is required to account memory used by maps,
if all entries are created dynamically after
the map initialization.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/syscall.c | 58 ++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b5ad95cf339..5a4a256473c3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -435,6 +435,8 @@ struct bpf_map * __must_check bpf_map_inc(struct bpf_map *map, bool uref);
 void bpf_map_put_with_uref(struct bpf_map *map);
 void bpf_map_put(struct bpf_map *map);
 int bpf_map_precharge_memlock(u32 pages);
+int bpf_map_charge_memlock(struct bpf_map *map, u32 pages);
+void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages);
 void *bpf_map_area_alloc(size_t size, int numa_node);
 void bpf_map_area_free(void *base);
 void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a31a1ba0f8ea..40119aef9ddc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -181,32 +181,60 @@ int bpf_map_precharge_memlock(u32 pages)
 	return 0;
 }
 
-static int bpf_map_charge_memlock(struct bpf_map *map)
+static int bpf_charge_memlock(struct user_struct *user, u32 pages)
 {
-	struct user_struct *user = get_current_user();
-	unsigned long memlock_limit;
+	unsigned long memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-	memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	if (atomic_long_add_return(pages, &user->locked_vm) > memlock_limit) {
+		atomic_long_sub(pages, &user->locked_vm);
+		return -EPERM;
+	}
+	return 0;
+}
 
-	atomic_long_add(map->pages, &user->locked_vm);
+static void bpf_uncharge_memlock(struct user_struct *user, u32 pages)
+{
+	atomic_long_sub(pages, &user->locked_vm);
+}
+
+static int bpf_map_init_memlock(struct bpf_map *map)
+{
+	struct user_struct *user = get_current_user();
+	int ret;
 
-	if (atomic_long_read(&user->locked_vm) > memlock_limit) {
-		atomic_long_sub(map->pages, &user->locked_vm);
+	ret = bpf_charge_memlock(user, map->pages);
+	if (ret) {
 		free_uid(user);
-		return -EPERM;
+		return ret;
 	}
 	map->user = user;
-	return 0;
+	return ret;
 }
 
-static void bpf_map_uncharge_memlock(struct bpf_map *map)
+static void bpf_map_release_memlock(struct bpf_map *map)
 {
 	struct user_struct *user = map->user;
-
-	atomic_long_sub(map->pages, &user->locked_vm);
+	atomic_long_sub(map->pages, &map->user->locked_vm);
 	free_uid(user);
 }
 
+int bpf_map_charge_memlock(struct bpf_map *map, u32 pages)
+{
+	int ret;
+
+	ret = bpf_charge_memlock(map->user, pages);
+	if (ret)
+		return ret;
+	map->pages += pages;
+	return ret;
+}
+
+void bpf_map_uncharge_memlock(struct bpf_map *map, u32 pages)
+{
+	bpf_uncharge_memlock(map->user, pages);
+	map->pages -= pages;
+}
+
 static int bpf_map_alloc_id(struct bpf_map *map)
 {
 	int id;
@@ -256,7 +284,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 
-	bpf_map_uncharge_memlock(map);
+	bpf_map_release_memlock(map);
 	security_bpf_map_free(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
@@ -492,7 +520,7 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		goto free_map_nouncharge;
 
-	err = bpf_map_charge_memlock(map);
+	err = bpf_map_init_memlock(map);
 	if (err)
 		goto free_map_sec;
 
@@ -515,7 +543,7 @@ static int map_create(union bpf_attr *attr)
 	return err;
 
 free_map:
-	bpf_map_uncharge_memlock(map);
+	bpf_map_release_memlock(map);
 free_map_sec:
 	security_bpf_map_free(map);
 free_map_nouncharge:
-- 
2.14.4

