Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D21DECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06AD20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LAVNgOzJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IwWt80Ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06AD20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbeGTSiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:38:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388126AbeGTSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:38:25 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w6KHiNbI006915;
        Fri, 20 Jul 2018 10:48:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=4Y2yU/4yD3i5oNYcl/ut9DlMjS9+srPiVmiDH/K7ZZk=;
 b=LAVNgOzJaTCxx0bbgVZ3n5zc1r/N+29mxcxQvCZ+Zjesu4UXAJ/jDIA8Jv/PFUTP9QcK
 MmGn2RlMolh16ShsjoObOnM5TD4ZuTWfbiA5An/I4OHCw02ECq0wevu9nVQHzvTXFiyd
 54C7+Fm/Ybva2vTHLSBzP0UtrAlOF3RcXQc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2kbk20rbfb-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:48:43 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.11) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 10:46:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y2yU/4yD3i5oNYcl/ut9DlMjS9+srPiVmiDH/K7ZZk=;
 b=IwWt80NszDTkPg0doGYm4NffRXFNnD67yoNesYbhTf2R66Grw7xlq8PoUF7udLON+jsYi8mtIATEXexs5QC4IfsWVuXuavKIwOHvBX+UNhc9aqLsITLsKxYlCTO1auxOVhHJNWZZsaW9QzI0ANhxaTwrILsdl+pgpBIUhDnV1xE=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:16 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 03/14] bpf: pass a pointer to a cgroup storage using pcpu variable
Date:   Fri, 20 Jul 2018 10:45:47 -0700
Message-ID: <20180720174558.5829-4-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 600f0b2c-af7c-4965-7905-08d5ee68b1fb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:rfK5K2RHRZYqn0+CoUD2q0y3RZr5W0KY0E8MtvauI/6iUH4NOngTz37Ua2uXGLbER3k4pdTPhTJyuw+5sOaePRKEoj2X1sea7f+h6eEVSjBjd/HlzD++JFhoXnmVh4GaDeKYjANkAf9CXQXAAAVgafMIA4ss1U0/4EIW6tRf7zONflox6I+rArsd+G7JtMeVwwM/HjUWTb2TMm70BvN+dLhi27prcVhyoKqRQplF1wADBr9WARYIZWB0LiIxoeXr;25:IVNjJTYlwlqDv1NadqFd7+pX4JXrocx2JLdK2MZhU+2LaI4uBzgJpeIzmCIEfXTeqzjLz3+eYkxPS8n9nONZXb/3fa0MKX8r1bbnqZ1Jt4Cf+U2k80c+lbCzykgGeFzRZByq11+Ey2sUWPYEUzEC8Soq/pyxgvgfv0iGJLALtWyI1TJu0odVwy+6fis/mDE71p0E+jPSAVl7iP0KN5k2NOV90vh6urDqQR54sWgBz8L5dOENIJ38bF9KQHP2Zwm5wIhFzhFrX05W6fKvGrdiwDV6HdfgPWNC/WZIJ1smHPZFIzVEjxnUlq6NeTr1HJjU+6XDG3n1CX+ob4jb7Jm15w==;31:yFS9Ell4mgPdDJINpBc+nU+uoOR8PPswLJw+7hrNvf5GNdrKA2xklk72tOnTdBxe7DeEpQIwG+nxhsUNw0H2oKvFe7jgLzul+pNEF2gUAHGWAYfq2Qiupm4iEzNQVoFeemmfrulUuh7stky4TqtGJzF/0xunLMhYrw52+IGCHom0DlbWF+vuZG8zVA9DLtkCJ0nA2vjSl5oISMZz5HxVNtd7f/234BUNUV6Wnx5EjC0=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:xobZdQdZCpHcFdQhhLOAeVXVFtcZMRAMEjgsnvVofBQn1Lfjkir08C5rY3jg49Nqyngs9odvY0hxz3A0n7QOYzQrlel7dGr4P4SN5+knZouXN61XTN74Du6irpAuAwvs8KkLuqIfm6CzNh/KJxWkaRZ5uhh3xyNZ8gNGHucNmNPDAwFsIiatTTeAK1uAuj8nxxuFjBiZoHIqUk/9pguCu4G8vvoaDfUEf6AAACxw8hfjIRRqZyHurlGcK+IEuz42gAVnVko7KwIs842DW2n5cyrfRNXqiZ5dbJY93i4BSkuakyR5ZX0+ImnIivU2owVdLlAzR2sa+leigA0SB9dhsrpRIi4LY2LsBSyjw2gJGKFUW4bfNhEPjX68qA7p09Xa9MapkxyEg8HEc1tOX/gslgVx6qWoQNqBJeVWkF6gwA76LMoxn1dDd/6BWVU6wWwW0G7GmdCXwWcXKEduSH0yfrwslrULeAj0JxgMK5XCFMslxu23a5+2sIzACTKnj7+r;4:4G1XCFlGT7e8HgHy2aDFUgl53LQx3yQayB90RbB0nonrqhxwwQ1Nwl3HnZwJlaHzHL+MsFjUQjMzWRPuof/pNq+cZbMIYKN0AM3N4JtzKcIAeDRbQ+cMf1NPaJUb4GPXWVK/kLhv+H7x/fkF1Q4vaKOw7zpxr90T4NpHTrmZFv5NvOgKDokzyk68WF8yYSDRCjimjT+zBmJn9l3H40AozQEtlejV9FrepESO8MU1Hb0oXck/Y1lCKw85iqnEPAYrdpbuHOxCLua4eB2nDI81xgsDl5X12Aar870qqgQEaW/mmcW9yf4g04hn5AXpNIJ+
X-Microsoft-Antispam-PRVS: <SN1PR15MB01756C30AFE83513E9B5F0CBBE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(575784001)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(5024004)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:z4tvWUk0VRVlwTtMldXIo1jKWH1FKL5v4RsCkIY7B?=
 =?us-ascii?Q?+VKhPZna2v+2ezVtOtpVjHCNDjsjnE1hRXRbzZ8f+bb1p/bppON20ZnNC9m6?=
 =?us-ascii?Q?PLzLlN1D+NwKEN0DWsguwb0VcOFJkCCbiX+LmuBsT5ONNIaLUwXOvvQYyNUZ?=
 =?us-ascii?Q?by02PQGWAWqMnQXJcf+lkfrdjHMWVPe48It2AteG+nn6FPiAZDyutyti1B39?=
 =?us-ascii?Q?kTChO8y4fFjV+4N86eCtVBrAWzsWnehbWVQCf20FlN/khhxXLaFvCIGX/FHP?=
 =?us-ascii?Q?WLNj/XqKwG56FybAdcA4ZkMr0kxIndvu1c1YxRH7Pltm5tJQhBDm0fGYWPnL?=
 =?us-ascii?Q?5/YiMTioJnGTV9k3UzrLCWeDzweY3azYcMRL8pR0SxtRhZUv6u4++eGLBTFy?=
 =?us-ascii?Q?ZCYRfLL7C5Sk4ug03ox1nJ5PlmkRvxRrKDj/mpMDV/Qr4YvMxmO6VVyhzFuw?=
 =?us-ascii?Q?xLfeA7yhFGa38YUjtoVNuesB5XOwFtP+w7yZf5snS8YdsmoyoJtv8MSA83x2?=
 =?us-ascii?Q?9ZBe2Lia40al16XLd2O8XHDsiWKj5EbLuCUMeo9oybH4CkU5vsZ6SLx4ACoT?=
 =?us-ascii?Q?RBR5/0Ss8Vlz5N5VtfF04xWYG9PDz4IdFXJ2yXNeBTSJ1KVqLsG044KCH41P?=
 =?us-ascii?Q?S/HmcsBdmmoHwP6cADfsCS0W4behwl3YV2o54QGd0/EtAeMZ9Hz8XeCCOELj?=
 =?us-ascii?Q?477csiK9Y/p9fa9LfDaKQtEctGZaethO52twWYnwzjuNqdu6slYPtVy25k5D?=
 =?us-ascii?Q?qCEuTpSLWbi1Q1MNQGgJ/iIP5Pj5xBk5m61SGAD5OcUXQtgGuh9AJ6H0aYDf?=
 =?us-ascii?Q?ahMghSL1UM0CUyXnsKFk3dWagr3Fyws/CE0XMIVgt7B9NOkVUHySJxWqG+cI?=
 =?us-ascii?Q?p1F40Uky3SvhGnGH1GmO533o6pgOC6pXhBlUftgzKqeLPfbJybO1YO3JlBsT?=
 =?us-ascii?Q?OmOFgVlzX5ypes9+ZlqO/Mi9DQiogd3bIkaLeCvgChjaqcsMIxhJz9qMSduU?=
 =?us-ascii?Q?7Al7BlGjSu7vPL7zYZmUStQ5EwxgLEFLKg9crRVgbedXG+V1go3oBI4eqlR4?=
 =?us-ascii?Q?OuMmJDVUiWR1h5gJ9fZ/d4Mmepi9NnXMGjiVxaLGkDbVz5HZdiMSsTFPl3E3?=
 =?us-ascii?Q?acapUzwqzIMa8WshJliTNpd8i/OXTlEuIeBFLh4uyJKdofYTy2YpoCsomCMg?=
 =?us-ascii?Q?oHhrc/2HSWaZNNah63+K6NCz4YBJHuN0bP+mUnQb58OHTFLbYvwehdZoM1tF?=
 =?us-ascii?Q?yC0rTOCXyiIKm9hSjC2RRyrbclJaENSbGaZ6ii8kBVCPWvPEYs22XbSRGhN5?=
 =?us-ascii?Q?BLnyFfLtCfOz2j/Jh1Xfo1GUimQtuE4BAtxj6nQaZux?=
X-Microsoft-Antispam-Message-Info: OgrmPL40jw7ZV5XBSXwC+fS6U8By0qtxyEb0mrMMG/pDDccKAIQKs3B+6fmvY4dUTTUEPnXYsyjL0Khorr1VZbPSL64JVqLrGiF5taS2BXNUktc+g10J9x7SsJOW6GFjlmkdm7iSS4zDwGAaweIhCAB4y4k8iyfjchobtXyZMPa/3MQP8l617oiYkvL12fAZe++Vs6XTVoQpVPLY4ZDRQ7qlj7tQ7CkX+BcXzwAKDG7z6pQo20aoJXRv5dFzX7OC8HOOWJ1hGc7TKp+RkssPcUIiF1VuMEh88+26FvX4DziRIrsRKHrgVi6hUfPsXidhSonqEHGLq0gsDGg5QcCVi5UrvZ8UhINAlobgt8qiJ34=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:JI6H1mJnN3/WvatVJVSOiv2Vsd3YlmUYxip278fB8whPJS/d/P8rkw+UMxG/LJSJCMp1porHM7Nrbaz28C4Rnzmgig7CEUdaLvcCIOdoIhPBy+oykaU/zp384yR0ltCM9lBFwGFBo1hRZbuIul4qJtHXphYmoxqZSX0PB4rwT5s5VmX0Oor8FpofQuIq1FUVS49ok/I9mLvOlcIGyDL+eFczj2z85JZQCYHZH3hWbNTmS74bRNxr+h0eIw+zfOruBJVB+wumwqPLPxlDZYV6uVoFRPqz175zrwDByTaxlARgTzI4p1x17sC9M3+1ZRGHhWVFXkQ0tiDoEgkc5mcHlgdcNbBuX61K8Tv+3XsT7s60hHIXdcxtPJdQnDoLnPA+hpNO/vdRpr3yec3DyFi1joNDM3DQiDgAW5m+oG9VE3JmAcVJb6S5eMsGHTMts2XdkWQzUJOeaX8bEz6h0eQUYg==;5:1nGPIYOiFEycz6Q9v/oEpm8CXDXjqSk+f2BDf1cbYWfgPjUponDFAiwnrStdzqcjYzCjtaRUQKTmTOM0Gh6SMw9cRkie6EfQDD+1vsMQvpwWRreeN88VZbeBPO4ltOWP1toCCu3qkY+ls6p3cjpptnXagyRMCDL83LyyB1h74sA=;7:wsPlLXUGtGcagPmQTD1W8oLfGBKiSr4/WyMgZQcdNbQjEKxGnQdFRZ7HbB5sktjuZn01yKJS3UOinjGdVMCfFFeX3XLbJBIoa8HgoOa7VHgcZMAMTxPjjE8WArrTF1orgBSOpbg8Ub1DDDGbpTMlNMurfbmhz1ehqk5vKT42CUF8HM9jdVIWe/3FP7XaD2byfy60FthUfi0eIAcA5F0YhOiTbeMK9UrG9CzTuNQX5BbUeD873Oy1MITkRyTI2g64
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:q78xS1xoLU9BC/f4zhL5OA2DrSkyhmr//4qkNRYXRTD3E+QlO6eRywItdMzDE9hHEl4MMVplCoH3HHN0oZnbaTVd3XYFgot65HJAd0OKQP8c4/nr8jyzg/H82JXX9gQz/y6ov5vlMyXMzeU1NPLgi+1K9oruTrGkK64+oDdXrBg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:16.5824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600f0b2c-af7c-4965-7905-08d5ee68b1fb
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

This commit introduces the bpf_cgroup_storage_set() helper,
which will be used to pass a pointer to a cgroup storage
to the bpf helper.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h | 15 +++++++++++++++
 kernel/bpf/local_storage.c |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 6b0e7bd4b154..1b1b4e94d77d 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -3,6 +3,7 @@
 #define _BPF_CGROUP_H
 
 #include <linux/jump_label.h>
+#include <linux/percpu.h>
 #include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
@@ -20,6 +21,8 @@ struct bpf_cgroup_storage;
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
+DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+
 struct bpf_cgroup_storage_map;
 
 struct bpf_storage_buffer {
@@ -96,6 +99,17 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage)
+{
+	struct bpf_storage_buffer *buf;
+
+	if (!storage)
+		return;
+
+	buf = READ_ONCE(storage->buf);
+	this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
+}
+
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
@@ -249,6 +263,7 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
 					    struct bpf_map *map) { return 0; }
 static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 940889eda2c7..38810a712971 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -7,6 +7,8 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 
+DEFINE_PER_CPU(void*, bpf_cgroup_storage);
+
 #ifdef CONFIG_CGROUP_BPF
 
 struct bpf_cgroup_storage_map {
-- 
2.14.4

