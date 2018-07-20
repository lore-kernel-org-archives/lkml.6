Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C512ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CC520671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ONAJkDL7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NpXIZW8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CC520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbeGTSgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:36:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38238 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387881AbeGTSf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:35:59 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhhGS025819;
        Fri, 20 Jul 2018 10:46:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=RNzNoL016CGiQQf0XuuYU8ctUIKWHojf4gQYXRwiRE8=;
 b=ONAJkDL7YuxiQ3e11Zh3Mv/fUc9pfo5ysPJ/o1TjtfKcZLXTjNH2dLq0Cil0MtWYeVzB
 YfvrSpWFB4QxTz2r3Jz9fUGYRuUID2brnuMDkxtWaBV329jpUrPdsJ7slNTXDRXBcR+O
 G2IP16a5KMKnDF+oMF+uToInbbfeBBaj0WI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbmbv80dh-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:46:20 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 13:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNzNoL016CGiQQf0XuuYU8ctUIKWHojf4gQYXRwiRE8=;
 b=NpXIZW8oEGq6cBEtvV2xypECEybKE0M06jSM33ArPfQajsXOB7MiPCZtw/WWRr7Je+Vt6LCnBUKb4YLPA+y90HkZ180kUHtOobVOij5/rY8ykR0mBDNoSl/Vzld/iPW42TLvOrEBkA/DRbwdluXXrhvN2/FbOq3MQIBGA9CMztg=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:13 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v3 bpf-next 00/14] bpf: cgroup local storage
Date:   Fri, 20 Jul 2018 10:45:44 -0700
Message-ID: <20180720174558.5829-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:ca05]
X-ClientProxiedBy: MWHPR17CA0096.namprd17.prod.outlook.com
 (2603:10b6:300:c2::34) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f458719a-4eab-4bba-042c-08d5ee68aff5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:6y3DczA6X+jezEdXWc7qWBJswzgEZsx4tplaXpLo4rvXLS7FnWzHhqlvV1RKRDsb9bQuCOnZqD6v/SPrN9JBH3BRReXbtR+hjP7tsJUA2lGILNwDeuJxGXPThf1f3awesIhqewCzcle+YCJI2A43kGBXEocP6mN3IBUfHLKE10BPeNyG/jYdJ1swuvz2il+8hy/jnqudbOZHeOlGzKInutW2qfjx1lsRPmrBD49euEb8SQyVBIU4PSdSil7H7F94;25:UyWbm/xA2Pg2V+xSzEwoVVZBMFx6fUFKD90+4jRSVSbqNJmwYRhIlrsfHVw9Ylub6KJ74jWPZYqe5PEIB1yw6pDwR46s9NopXD32sPdUZNS8wIFG8g/ekhfmL/DIaTbPwJTOfl3HNAQbh5CFU4YCyE4gJ6geMg31kB4bInZPv6KY3X4H22BQSkTElxPbliCFnAh8mxRsKMEQfAoy/pgQuPumRe5iEiyT3uyydYwsG5rBCL66YxJlBoao1fnHS/J9MyeTisFBTjdh2YCr8+WxVFCpua7m9PRCL9fZyC+TQHi9yRW1cg2I3LyefHEU4X+GeMXfiVSyN+glPrDXzrxkEA==;31:AXH3KD4+GBN0yU6ZmUb48Ndpb10/mYaXcq/wY2Hs/ds+6ki+S/f7gstD5bioQGpeMg/ZIMR5kMR/YMkxaKF7pR1PZyq8rBx9Kt8bsRQGorVj9ny9lXCgfKAWpoEpf/lTaQrmyrkzhaRy2NxtoVHvBDiuGuT6yY8m3rQY8hPds8j6cIPCGnLWEpc737Rybhb+JIqU7GMOB1d8sFChe+9XvrWwLo1P2kdKW8EbCSS/5pE=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:vkHO+t5II2erBlU/a33vqo11qBKK6fvjZSfeb4byDVvt8E6o3aLMmhLRmkbyv40zhYe/uvh4bxJaJXhIPZeCoULFJnk+7GjPtfrDXP+/x3lWGzdlnr1yPJVry7lC85SCg8yeg0kDjZC/V+LO/1gJFPjYtsLbgUoinUCRxMamB7fNGOAgnuNBgbemAgYPHWOsN/4J7m9c273uCA9cYFdExlyFGK6E/NgG/4zsQtogpvJ9qW/N2tdBJBtfCBsyvsqADZ6ZcdMvoOZ16XvVzktlee1rEjQClWYwUh0/2UZtOeX+PvzzLLoXbRT6/gFRDa+FuY7S1P/oceORKwO/6wQ8LsPiQJLvk4+5y44IQqemSJLEVQkVE4f7ppFwF3caCFdqqV52K0aCcJOzGRSUQ2+f5HPcdxAoNoJZuVxasmxAJmzZgzZ9OJXinwMaushLIRgEefKgNYwWseVgjO4FgRCCNfpbxf4soemMaOs0ttsgklP5k6a9A1KtcFVGrQ6ayAK+;4:AoNuIEc9JpeqrNHJ026Kq82m1EBdcxARhgsfxicwloWqgJw0ymNaybfwaj4mK8Jc+MVv4PXH1hTO/P7Xp0VYkEtZyOIhRxRSN4sZ8l0xED/ADWmqBi8HwObmw2douUukTtpimE9WUP+tn3j4Zmde6v3ykkRKYQzPvrg2xu29PtA8o/VQOWoIyAtDSJ8kc6nnBQUa2ynX+M2B08aYzOhJHAtnN91UJ/3gg+AK3+G/+AdiFY8TP9FL72WH//tb9AhMO/4BRSJ5pkWtT8a5NE7zD/YILUZ+xAstPrnBeDGWQOovP9KKNO7oPa8j/FCIzHIy
X-Microsoft-Antispam-PRVS: <SN1PR15MB0175F67B324D37086B774F4DBE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(5024004)(476003)(486006)(6916009)(386003)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:zRWFG7vw+3JQDDdOxAD8cZQKuYZDjW5EPj+HDbinc?=
 =?us-ascii?Q?N+wJQmMsS/H4jt9pACwmlhwnRlaeplRs4qxCorbl2jr30j6sJ1cuh3VRqy4c?=
 =?us-ascii?Q?pLFzAbv/eA6NB/r+tGr232AdsGX+9yOQWpPW9VGtvpFQXGxVLZey/qV00su/?=
 =?us-ascii?Q?SwCgWI8YvyqDnIE4k84+NRuknu6HXqDLgZ6JrODLsMi71B5junCRzGnhPrK5?=
 =?us-ascii?Q?yyypiwtEta89ZROl8m++88fMUXuZiJzbTdAm+EEAXWSd0Rfm7XXbYdf3AALm?=
 =?us-ascii?Q?erpOK3ar9jJJnya/PqBPHn4AR3qs5nRaoGWriuuu49vJroKY5TeKMbYIswRK?=
 =?us-ascii?Q?MueWLkN716Dasy3ZtmjjKJBB8CMVw+QlZUyxeTkaX1C10FQEJZy274DKJL6w?=
 =?us-ascii?Q?cLbVg0WQlV2Wk6J233mkbBeJm6uqndFOBDGThXUbKivmx9VwiJPOW1XqszIk?=
 =?us-ascii?Q?lJUpBnL0+VynYtnoHegPOE/YDVSRgH4g+pmTdjQyELRyei+cOQT3N0+5JyCb?=
 =?us-ascii?Q?XwmzBfKvBpEyaMWj6v9A2L1sxxgd4kyKBhoYYeTu3sfAmSnYDaR6mTcdOi71?=
 =?us-ascii?Q?zdB4crY5oydtUwgv8uASSNoNwfCu7I5Nn6ZbIBXqyX2xixOAZWZjFN/rHXw0?=
 =?us-ascii?Q?adan1gdg4QpNudMSxGwNrNNmg+hB3PrWN6K4pVtcM86mXt/7L8gMrVU6ffyb?=
 =?us-ascii?Q?BNz/YxppwPOVXZmHpSJgoaQw5zQoVHgC5nyN8Me5yXE91e0WdvTn5p9NAUUM?=
 =?us-ascii?Q?J9Wbqx7N0ZnZE8KE+h2F/O04IYFx9VV9ydeHIguo5H693WVUlrSh5gnoEaxP?=
 =?us-ascii?Q?1I1YD/XdGQsV71b4vObJo4xW5BqPeEV0UdT/inQR8seuKplF3MvhGlnX6aia?=
 =?us-ascii?Q?gzx6O2hENNwrBqqjvN2uNDt7KbUWoK8jkND+I4zucjU5i5Ew/aiI8TMD8LI0?=
 =?us-ascii?Q?lSSVyhVfzOoev9DYGDsXWyTDNBoXFm4aWwhPNK9C8NbXEnPaIneXgjtU4Vul?=
 =?us-ascii?Q?HT23GhDBduldqeDRNcd7u1fiRRVWvMM3JiLXrQA3mJ4l+pcd4z0ugq+KhIL8?=
 =?us-ascii?Q?qX7ZvAYBK7OI2bILCiJgvNYRkdgcEKaHbzbkkaZGCKIddOCr50A5nQu9jkD0?=
 =?us-ascii?Q?x7DALWQ0NQvSeJfs24gS8tTNiUW//ug2kM97BJUshWs5CYqnw0A/ZHLW1QTK?=
 =?us-ascii?Q?KdN4OoO9RSzqfnolJEUN/S94FfP65RIqK4YecihYSmK161BJ+9RdkOPbF8uR?=
 =?us-ascii?Q?5tIZxKd4IN3p1POujQ=3D?=
X-Microsoft-Antispam-Message-Info: KusYwVf0JEP4Ta1XWREP1x05+LwXeMLaK0w94v7bH9t6VuHwxnMQCEOllfvDe/f6Nz9bb2tOrdJNFg8P1dn+cc9+oLCu7q4CZQVTE8GkJEIat5ZLHAUgNxY7wczd/faWLFbk/Zq8P5qkB8JfCrbz2mjzQvgMf1dG8hdUcnd0sxPCqv+JHX/PyoV8uUcpYvKbxPfUy+psxJQOmBOWGmlFEEEeB4d20GHDoXbMoV6wvoh61mcDzWNmjaL1bVno6QIFCAWndI6O4axISjn5YLDKdKS9M1hNCK4AEbwyC6PENEPFUCBKdaoy8YdFxj1kTPxWh1euEGs0SlnSA9xUYB6lhjjSI3jt8KtwZg/+ZbZJt6U=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:CKrssMlGWCdIZ+G19f5YJT0kSNWcthNV7gEy+arCWWPIZHM0owyWFIlYoSm32QhnhZHpobKhmvVmgXlikkaEjf6mypjyJ04h8g8tYj3/YYNpdIH3iQGFEjcaKla4X9YrimezRsAXqKvwPA19Fywvqnt9WMv2h6RnPDBAdmgTn4HsVMN9Pw7orY2aJ5cIxYtyl7N8AKWQHshVCHcFSOWZ7e35ccpSEYg2qGoTI7Qt3EbdlV89VpUJLnIquPMY32QlTRTR1Fuljh0yEsuTKAYNnyfwKuoy4flctnnTBUzR4a6ekfffsR0/4ogWuPs6ECkw7i6vK4vYYiZLmSAHp3iMwBBU1UCvOB4IfuDaAbR3S2soX2xGcdQpE0E0q1Pct+yV68TY9fZW5j+rHWy78mKcxewpQPLjuWbl6anFLq662UkpG+jUyEWMTvEI11z0BjmTK43Sd4X/E8Y0OXf1vligSg==;5:XnkVtfB5tc8ZA+CM6Y9tw/MxNNZ/jltsADsmuDS0zZMxDeGmuF7HY7rzMDkM1UuyyQsmDFwaugZhx6NYK/H/aovqOhFggShoS7Hv00l6IHBt3RchUeCZ4PJ7W0wkCZ9XpQJrRRQHAD+3O8nQyKXvQKJzlcJpEnG0VlZkPkg5KZE=;7:usgIMl4EFBEoCJ3wwhne5OvTDJa8xhSDNvNJfcFloaojZz9C4P43ujUfg0fV/kn1NwaUq3cP4QZvSCw5P1dRKOh93szm+L93IF4mMsfIHXYcw6oXZsxBNiS/VO+vbmhxDqnm3b6Ai1wjTnhvpjG2gHfTwJbo+OuSEA0Do99G+85fdWGYsNt9xjIXOgjjuIV9Ph6fceKOzsS7JwjWTjGTwgm7ZUoTe9Os40CkM5I4I1tAXluyHD/QjrWa3BJZ8SAr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:0HY9S9AdAxEqInTrUPmt88P1OoK+f2BxG+LD+YMHztAwM4hVfaIXdNQCNznsHYo7XW0lUdtI6Nr8d69KgOHSgz5zzBGW2TP4sS2L9VMykXMBIQoV1f+ixkjdyAaYf4l2y/d70dgLvNtWWjBuPawXjiojIrbkJXnnQLL7gTs+2fc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:13.0966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f458719a-4eab-4bba-042c-08d5ee68aff5
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

This patchset implements cgroup local storage for bpf programs.
The main idea is to provide a fast accessible memory for storing
various per-cgroup data, e.g. number of transmitted packets.

Cgroup local storage looks as a special type of map for userspace,
and is accessible using generic bpf maps API for reading and
updating of the data. The (cgroup inode id, attachment type) pair
is used as a map key.

A user can't create new entries or destroy existing entries;
it happens automatically when a user attaches/detaches a bpf program
to a cgroup.

From a bpf program's point of view, cgroup storage is accessible
without lookup using the special get_local_storage() helper function.
It takes a map fd as an argument. It always returns a valid pointer
to the corresponding memory area.
To implement such a lookup-free access a pointer to the cgroup
storage is saved for an attachment of a bpf program to a cgroup,
if required by the program. Before running the program, it's saved
in a special global per-cpu variable, which is accessible from the
get_local_storage() helper.

This patchset implement only cgroup local storage, however the API
is intentionally made extensible to support other local storage types
further: e.g. thread local storage, socket local storage, etc.

Patch (1) adds an ability to charge bpf maps for consuming memory
dynamically.
Patch (2) introduces cgroup storage maps.
Patch (3) implements a mechanism to pass cgroup storage pointer
to a bpf program.
Patch (4) implements allocation/releasing of cgroup local storage
on attaching/detaching of a bpf program to/from a cgroup.
Patch (5) extends bpf_prog_array to store cgroup storage pointers.
Patch (6) introduces BPF_PTR_TO_MAP_VALUE, required to skip
non-necessary NULL-check in bpf programs.
Patch (7) disables creation of maps of cgroup storage maps.
Patch (8) introduces the get_local_storage() helper.
Patch (9) syncs bpf.h to tools/.
Patch (10) adds cgroup storage maps support to bpftool.
Patch (11) adds support for testing programs which are using
cgroup storage without actually attaching them to cgroups.
Patches (12), (13) and (14) are adding necessary tests.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>

v3->v2:
  - fixed more build and sparse issues
  - rebased to bpf-next

v2->v1:
  - fixed build issues
  - removed explicit rlimit calls in patch 14
  - rebased to bpf-next

Roman Gushchin (14):
  bpf: add ability to charge bpf maps memory dynamically
  bpf: introduce cgroup storage maps
  bpf: pass a pointer to a cgroup storage using pcpu variable
  bpf: allocate cgroup storage entries on attaching bpf programs
  bpf: extend bpf_prog_array to store pointers to the cgroup storage
  bpf/verifier: introduce BPF_PTR_TO_MAP_VALUE
  bpf: don't allow create maps of cgroup local storages
  bpf: introduce the bpf_get_local_storage() helper function
  bpf: sync bpf.h to tools/
  bpftool: add support for CGROUP_STORAGE maps
  bpf/test_run: support cgroup local storage
  selftests/bpf: add verifier cgroup storage tests
  selftests/bpf: add a cgroup storage test
  samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage

 drivers/media/rc/bpf-lirc.c                       |  10 +-
 include/linux/bpf-cgroup.h                        |  54 ++++
 include/linux/bpf.h                               |  25 +-
 include/linux/bpf_types.h                         |   3 +
 include/uapi/linux/bpf.h                          |  19 +-
 kernel/bpf/Makefile                               |   1 +
 kernel/bpf/cgroup.c                               |  51 ++-
 kernel/bpf/core.c                                 |  77 ++---
 kernel/bpf/helpers.c                              |  20 ++
 kernel/bpf/local_storage.c                        | 369 ++++++++++++++++++++++
 kernel/bpf/map_in_map.c                           |   3 +-
 kernel/bpf/syscall.c                              |  53 +++-
 kernel/bpf/verifier.c                             |  38 ++-
 net/bpf/test_run.c                                |  13 +-
 net/core/filter.c                                 |  23 +-
 samples/bpf/test_cgrp2_attach2.c                  |  21 +-
 tools/bpf/bpftool/map.c                           |   1 +
 tools/include/uapi/linux/bpf.h                    |   9 +-
 tools/testing/selftests/bpf/Makefile              |   4 +-
 tools/testing/selftests/bpf/bpf_helpers.h         |   2 +
 tools/testing/selftests/bpf/test_cgroup_storage.c | 130 ++++++++
 tools/testing/selftests/bpf/test_verifier.c       | 123 +++++++-
 22 files changed, 965 insertions(+), 84 deletions(-)
 create mode 100644 kernel/bpf/local_storage.c
 create mode 100644 tools/testing/selftests/bpf/test_cgroup_storage.c

-- 
2.14.4

