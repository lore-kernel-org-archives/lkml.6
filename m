Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54C3C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB9D24011
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fohHZoww";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jX3+zQKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB9D24011
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeGFBGM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:06:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50740 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932128AbeGFBGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:06:08 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6614qTr024164;
        Thu, 5 Jul 2018 18:05:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Z+sYJscQ3ypqjfgib0j7X3Z0Qreuz+lz24p8wob/Peg=;
 b=fohHZowwBFehu53Vo1JZW0Q7IgqDQxrGPqBvBZPC1UBJ1SGwlSG6zCl377eGQTCA+UoB
 mx/mMJaJE+hVBXPmUUYttebdEJsfsvu+cTQY9vT+JOMY5jxlGGqGQPJBIuyWACxcXQ58
 oQwuc709qQzkQKCCiJP9M816JNyEwlvarfI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k1u9f0d4k-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 18:05:45 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 21:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+sYJscQ3ypqjfgib0j7X3Z0Qreuz+lz24p8wob/Peg=;
 b=jX3+zQKPbUJ2ODAE6dXTM5O/XIU3q5TL3qR0w+nkDnTX8tarNDXllzFMESoZcM0awkFeo4xA4oWnIfr87WKxJjjm0g6dKpbiSa3HYCy64ycZzRANIn9QdNfsw+m/E1LkcXz6bdPJEio3EBcZ+qYj6FGJVeoPTBm0ECPE1tbML58=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4fc0) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Fri, 6 Jul
 2018 01:05:36 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next 1/2] bpftool: introduce cgroup tree command
Date:   Thu, 5 Jul 2018 18:05:20 -0700
Message-ID: <20180706010521.23097-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4fc0]
X-ClientProxiedBy: MWHPR2201CA0096.namprd22.prod.outlook.com
 (2603:10b6:301:5e::49) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7580f3ab-cc40-406a-23d4-08d5e2dc95d8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:5z68ZZ4YKAd7PWf6ZTEKUvvZSPGTtC6X35FLBNm0Szvroa9ay0E8DPiZKsMcbkXW+rM6OgvpoGJDbLWgj7g37PNFfgR0efjVMHxswuaZRapjS4AhTPz7Web9gFWz/1GSn5rc+sMtOIgq15f0Ts1eORPegfR4kMfmaCsO9vEhdJtST0uKs0Sx4PKiE+cSy5qIKJZTi2ancSBBqkJQnOfptX3K+EXhl8JJcIAFpkodpjNx+WRhkK5Mi7hbAHN/IHHm;25:84uqJ/3iszdEMPc1zJkdq/9YZDsP9hgGPGFybfZIC0Y7ndfQjTD57nuIUYFtmnGjBUFgyj2qCpKtWX/luFZ7ZTyuMxqkrNpkT98k7AKuolR9ey9c0NpdHbWGoWpy0iIP/eQHsVMOEiCGgSLv9aH0aYFXJMtRxzLxZb3x8ha9FEoSNNXwgQ4ndw3ro2LeyFxzIjcRPKVEomHcQVJfjbuqzjrdLqRlSuel4Q2r1v+nc8VYmDUshEOP02ScquYeNctzwhvAiAIepL676U0nnf151/qb/QAnrHrGpRJLj1gSsTgNqZGubGrpPN8B16fxKx9+mHcBKYFfrU5hWHOeEjHuIA==;31:RwqHtlJmDohVOXGUZQ13I+1S3aI57oUmRPfpYbiHbA06phdT+/eh0VkV9T2HPU6TSeyNHn8AY5856Gphm2xIedN2D0fVTW10JlpSItMqXBM7aHS7w66s/ulcCy7frzJiSTpmey7bX3Au1GjUl/vL14F5TqUSFSJpnjOYz6r+xUnzhIaMYOpFadlJm7YkYhV8TmnMUUNEYRm5neZd/XsMJpZseezSCYNolmtdhAnI/Zs=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:FH7O2zbRQwmy0/9JK1OdMVS84y6/b6dSC5+peN/WsU6h8/iNYxOeeZJgHpdBehE2Rb8XRokgEdHtVo6IW6PRzN3hX5l9a+V7rE44FvjlyVn+XQzlbG85/jaW8v45oiZUmloE9hxEbPO/7ZKuL1JBwRfFh+MAzIbWllJR5DcWv1ojVg8r0aDm2oq06SnbAiEz0HPAeqWSbYhLWVUKWHzvgkiLKjFlIDPx2ytJoLPLhoJy79jpxGl5wr/5TmeBcSFYkAz0vERqhYNdBG6iaAJYiDno/wNk4rU9xR2tJ6XJvzwNdOzcidtmoF2eQ5KvR1bqCelClpcyMueHLgMx/cEtxSVNaz2aTGUNdILXBVVPsPAq2Kasn3fP0QSByvMTr4wDRAFLp2qlwZga/yxWFtkyecck8XaDpaoSV0yryudTu6PL2jF3opYM2rWezftJWtXjtXjO6ehfjT+W9TKdhl3x6fwzqRj9G6crPBpn959ffkNcQfrg3KgLeNERjHWljmDu;4:XhThNv/WdUE+2AdfBaaK6oRTDBMoiPC+DiyX/e2gmSy1ZcMApArbmsy+rRH2GFbTJAP5wtZOu1dbdjttM5iwPn9Mv6HbxArT6xABqOZVlqIRHTDC7FCvmhXyFFqgUtIxRcoQw3KO/X4N+U84Q7Ww0vZ5kOfmAFTt2Y0Tytu8HoQSft7hdfl3jKDI1Oan1+3Ayuk2SUFXeP46p4HqceqJm788VwonVdoiqJdVwJswXYSBLZ7Qe0g//JZsaTMF8SLcdoXDtQcx8bw2Aszp+PpQ335Y7wL83WHo1IRXE6P9kdWJpXCBae0VfwrfxFk3oje1Z8/fBUXxrT8izATRjD6dGLLDQhCqh6vxVDIPbojFRrQ=
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167994E35B92F46E62AC79FBE470@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(81227570615382);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(2906002)(106356001)(186003)(6486002)(36756003)(86362001)(53416004)(386003)(52116002)(50466002)(52396003)(51416003)(48376002)(50226002)(2616005)(16526019)(476003)(7736002)(6506007)(105586002)(25786009)(305945005)(2351001)(4326008)(486006)(53936002)(478600001)(54906003)(81156014)(8676002)(39060400002)(14444005)(6116002)(16586007)(316002)(46003)(6512007)(1076002)(5024004)(69596002)(8936002)(2361001)(47776003)(5660300001)(81166006)(68736007)(6916009)(6666003)(97736004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:Ofvrbc/HsLjEnpf8lL32mgFY6DQrmUf19YnMuhXAH?=
 =?us-ascii?Q?L1ee2IzJkWunZ7BHxLgzRSGHTm/guaDSKS0tE5vZoCxhmL5n7uB4AVid6noZ?=
 =?us-ascii?Q?1LsRnazgRgWD7MQiGMNjBhxypMBKL4Q3mpRu84WkJB94ObDesFG3KrkjzHWU?=
 =?us-ascii?Q?KruCuGS4M8UdWK+moqE9ItzjLpswmKhkFWMUVr6u5jpa4s8NvkLEIkbCnU9i?=
 =?us-ascii?Q?4ZoyEVPoUZWHTGdyUftDhiFQe5SboOPRoz48BDSiC39qfcQXj/lor5NannYz?=
 =?us-ascii?Q?seqmHQe4WCCcmrDJbDPRrlR++sPjLTIrNfQ3GNTagX3wi6QKb6OriK8Xl0VQ?=
 =?us-ascii?Q?pat+X6obxTNBIaWJkIZNtJU7XXqjOJPciGAH4HJSMj/O3xxJ0c6Sy7pRh+W7?=
 =?us-ascii?Q?mQe/ex0hmvz37eOQ5nZXVg3SbO799LdUYsAdSn6cWY8Dv8i4fzww8GWJi6Ja?=
 =?us-ascii?Q?wF8eGJcMGQ0XCIHG++MtZWU0SO2IY2fvF6dXWWvkqzFoAm0cWTKMG+JYtnDq?=
 =?us-ascii?Q?MDdAhfGQnDhnoq3vbKzxSEFWEYi9PwZR8YtvPnaLfdS9wbSeGhytWt2lgvgN?=
 =?us-ascii?Q?bV1atopeFck8zv5Cvc+ZdS2OSkfGN2J5b2ykwWrRWRPCdj5vs4e8UOnLjcem?=
 =?us-ascii?Q?hBM17r0/qR4L0mvHUX4Tbl97Gn11grcYoQ9iH1CFstfU1M0jok4NbV6In76Q?=
 =?us-ascii?Q?OiGj8eCJ3fL77VS+GCOONoKOv7nEQoq5eMwTcmaQsIyNcr1uek0BTjcMSypU?=
 =?us-ascii?Q?59tEH+I45X9aur/XIgCqQurEKWjOYMcBP/Y0TUE0YkOs4HNovLxhATbN7Lwv?=
 =?us-ascii?Q?igAlZJx02TtMEvowfDfxZ9i7efolHKOiXYhVbAEiWxTP7wiKVsST5mOpkbNk?=
 =?us-ascii?Q?AC0gJmI7qNgt2irRrqQogel2eFmixBqtjAGUjyhfXkP96iTaYA750qdfFDOw?=
 =?us-ascii?Q?Bdr6XdZgEFKVI8MDyd6haXRiZUyFcvqPBkKOhuVtJz55ui9euC9qfzxI07P+?=
 =?us-ascii?Q?psWB9ptaEPdp66To9SUWah/q0D0ABqwPtCx9r8xsAxtVYRzzYHGbSCz4SH8m?=
 =?us-ascii?Q?42BM12hLpHTfJmEu7BoxLDCql1hjzS5DgdsF/kkg4imSV41BMOy1IlWST9Ty?=
 =?us-ascii?Q?rOo+rGUGR6zL/4jUkQoernGIDec+wNoytMJDPQwk6QrPhYaW6xMoDKu7RPMi?=
 =?us-ascii?Q?1f6lQMCZ7K3yWr/DjSjzrcav6UuZzCT+q5Ss0+0S/f2Ja8bLTQ9gfolatiSW?=
 =?us-ascii?Q?GhgvUUDOepXVeKQCsSRgECFv0PrzxHu3cYqa+SoZCyPQ7WMP9qHinDqnf+dU?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: tH7Q+6jHrDEPM67Dm9WTNuQdORl+qpaYcXu7EbeoQ5GzeRVfDIMDwkDn38sIRp4pKt4Yq1UHjNoDPho6THWCuHnKuGo/Dzvz6bAsChE3KO5i7tBO1i9wpOF/uU881NEhohK3K2L2/Z1mZeTtHi1yetVip5RYmSTm8m/wvHy+E3f0vbzgdXII7ng4YCY1bIB1f+2JRQVC6TzUZJmf7c1Sz7QLXYyWELZzfHIOSCzjCPcincpvHgDZVaB/FKwQe199tLR2febhYEpI8nli43mwuNkIa/8X8lEYZ+g9VPrL5IEtrf85byJKw6FP5LeCamEwQSggrVWNaiKfICsa08G2fo4s0sitYDZhYZFoVbEEu+c=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:6nPtnGFzHw/3ltmylooLi986LfOHvC3MCtJS5+XZiV7Xbfcrz+a0yb/V7GSLIByt/JtSc7NdxHUP/tPBUUgboENU8YAW2N9m0O0f/hdJ/SrNCQSto6eEPKXz7aKoOd6kJlO2ylbmPESyXAr84GWc7Kluxx2UyAHGcC260fV7n3IcsyKLZ+MYE2ipsdjb1SuA9X7H5km49dC/hz1hRKZ793xHn1cqLxQgI3X4jAiAP5D+4/Zjpm2eqjAou6WpP5Xj0yHxOP/B/s/1q7z2z3azDoupoM8v7KTqspgVwAPVIr/NXxecZGeMIPFdmcnaGPP+XYASJiOuq1ZFAvMOrpx2v6kuKkJuHSc3XcPV2VzhoM+bqXcqgRp+tAcENDM/JiKZdAIqEQUw528FIbf6tB2004ckHgPYgzCatM0rDYxIXta+glQOiZs0XnVYKMk5asZ4MSXXSqT5EdiJ2JEni2mIKA==;5:UCsLx4NPcTAfQhjjMT2JjXRVBJ1r6a+QiI/o/qMkhZhhjcWruryGQJEFqzxgCwg/4VibcswOOQIZzRvIJKYgAvLZRyKgvo8PUaVLtkZkbCwUlNVUKOJvnNAWb0ekcpAGVDDCsKjoWuGUukrlg+hJGrJmwQ2KtqVEJRS0g4S/4ZY=;24:83Mbv/LOerf3SNDN3EmzoVnLlAeW6kUD52U4aKOAIheSrPc+ggsCs2wO1b7hxxTwuiwRZ+Co8qQN1R+IQwXHILOtSCNQUhadzzEwv9DXbEA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;7:kYdCuaJSkWSOiZheDKNRywXp3isBCdSBRExbFA6B2G5YsnrEtJYWrBzE5Y79vwciwVhtE5yfQzaWEC9/c0PGsI33JXkYgsSo1KJXH+Gi7VgT+/DXGCFhP9nwjY6NeKMGGA23LID6GzaJEFyHnfQoMUaW6afQLySn66CNUfeKXdIAVkv0Dt02eDNjD45c6MvwA2fWs7+1k32UXS1XpGx1ha+wjvUH+FA5exMqOot0evl9n9p20JbNkCVDAHJ4sqbf;20:c1EpvJjRKVxsNypezdfGHv8pK4TUVWhF9mL1D7uRo6mxucxK3SGXl9kBTJsiAeanDvqLjr7PRBcR0s22ndNUpRPGn04ANk0PFMT/03knUIPHSUTY2a90iBUHFSc80La1VCLzlYtc/3/hDxR1lMlxEudPQqR5zgK2qnPM/nOHEwk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 01:05:36.8557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7580f3ab-cc40-406a-23d4-08d5e2dc95d8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a new bpftool command: cgroup tree.
The idea is to iterate over the whole cgroup tree and print
all attached programs.

I was debugging a bpf/systemd issue, and found, that there is
no simple way to listen all bpf programs attached to cgroups.
I did master something in bash, but after some time got tired of it,
and decided, that adding a dedicated bpftool command could be
a better idea.

So, here it is:
  $ sudo ./bpftool cgroup tree
  CgroupPath
  ID       AttachType      AttachFlags     Name
  /sys/fs/cgroup/system.slice/systemd-machined.service
      18       ingress
      17       egress
  /sys/fs/cgroup/system.slice/systemd-logind.service
      20       ingress
      19       egress
  /sys/fs/cgroup/system.slice/systemd-udevd.service
      16       ingress
      15       egress
  /sys/fs/cgroup/system.slice/systemd-journald.service
      14       ingress
      13       egress

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/cgroup.c | 150 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 145 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 16bee011e16c..125d5b6db568 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -2,7 +2,12 @@
 // Copyright (C) 2017 Facebook
 // Author: Roman Gushchin <guro@fb.com>
 
+#define _XOPEN_SOURCE 500
+#include <errno.h>
 #include <fcntl.h>
+#include <ftw.h>
+#include <mntent.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/stat.h>
@@ -53,7 +58,8 @@ static enum bpf_attach_type parse_attach_type(const char *str)
 }
 
 static int show_bpf_prog(int id, const char *attach_type_str,
-			 const char *attach_flags_str)
+			 const char *attach_flags_str,
+			 int level)
 {
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
@@ -78,7 +84,8 @@ static int show_bpf_prog(int id, const char *attach_type_str,
 		jsonw_string_field(json_wtr, "name", info.name);
 		jsonw_end_object(json_wtr);
 	} else {
-		printf("%-8u %-15s %-15s %-15s\n", info.id,
+		printf("%s%-8u %-15s %-15s %-15s\n", level ? "    " : "",
+		       info.id,
 		       attach_type_str,
 		       attach_flags_str,
 		       info.name);
@@ -88,7 +95,20 @@ static int show_bpf_prog(int id, const char *attach_type_str,
 	return 0;
 }
 
-static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
+static int count_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
+{
+	__u32 prog_cnt = 0;
+	int ret;
+
+	ret = bpf_prog_query(cgroup_fd, type, 0, NULL, NULL, &prog_cnt);
+	if (ret)
+		return -1;
+
+	return prog_cnt;
+}
+
+static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
+				   int level)
 {
 	__u32 prog_ids[1024] = {0};
 	char *attach_flags_str;
@@ -123,7 +143,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
 
 	for (iter = 0; iter < prog_cnt; iter++)
 		show_bpf_prog(prog_ids[iter], attach_type_strings[type],
-			      attach_flags_str);
+			      attach_flags_str, level);
 
 	return 0;
 }
@@ -161,7 +181,7 @@ static int do_show(int argc, char **argv)
 		 * If we were able to get the show for at least one
 		 * attach type, let's return 0.
 		 */
-		if (show_attached_bpf_progs(cgroup_fd, type) == 0)
+		if (show_attached_bpf_progs(cgroup_fd, type, 0) == 0)
 			ret = 0;
 	}
 
@@ -173,6 +193,123 @@ static int do_show(int argc, char **argv)
 	return ret;
 }
 
+static int do_show_tree_fn(const char *fpath, const struct stat *sb,
+			   int typeflag, struct FTW *ftw)
+{
+	enum bpf_attach_type type;
+	bool skip = true;
+	int cgroup_fd;
+
+	if (typeflag != FTW_D)
+		return 0;
+
+	cgroup_fd = open(fpath, O_RDONLY);
+	if (cgroup_fd < 0) {
+		p_err("can't open cgroup %s: %s", fpath, strerror(errno));
+		return -1;
+	}
+
+	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
+		int count = count_attached_bpf_progs(cgroup_fd, type);
+
+		if (count < 0 && errno != EINVAL) {
+			p_err("can't query bpf programs attached to %s: %s",
+			      fpath, strerror(errno));
+			close(cgroup_fd);
+			return -1;
+		}
+		if (count > 0) {
+			skip = false;
+			break;
+		}
+	}
+
+	if (skip) {
+		close(cgroup_fd);
+		return 0;
+	}
+
+	if (json_output) {
+		jsonw_start_object(json_wtr);
+		jsonw_string_field(json_wtr, "cgroup", fpath);
+		jsonw_name(json_wtr, "programs");
+		jsonw_start_array(json_wtr);
+	} else {
+		printf("%s\n", fpath);
+	}
+
+	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++)
+		show_attached_bpf_progs(cgroup_fd, type, ftw->level);
+
+	if (json_output) {
+		jsonw_end_array(json_wtr);
+		jsonw_end_object(json_wtr);
+	}
+
+	close(cgroup_fd);
+
+	return 0;
+}
+
+static char *find_cgroup_root(void)
+{
+	struct mntent *mnt;
+	FILE *f;
+
+	f = fopen("/proc/mounts", "r");
+	if (f == NULL)
+		return NULL;
+
+	while ((mnt = getmntent(f))) {
+		if (strcmp(mnt->mnt_type, "cgroup2") == 0) {
+			fclose(f);
+			return strdup(mnt->mnt_dir);
+		}
+	}
+
+	fclose(f);
+	return NULL;
+}
+
+static int do_show_tree(int argc, char **argv)
+{
+	char *cgroup_root;
+	int ret;
+
+	if (argc > 1) {
+		p_err("too many parameters for cgroup tree");
+		return -1;
+	}
+
+	if (argc == 1) {
+		cgroup_root = argv[0];
+	} else {
+		cgroup_root = find_cgroup_root();
+		if (!cgroup_root) {
+			p_err("cgroup v2 isn't mounted");
+			return -1;
+		}
+	}
+
+	if (json_output)
+		jsonw_start_array(json_wtr);
+	else
+		printf("%s\n"
+		       "%-8s %-15s %-15s %-15s\n",
+		       "CgroupPath",
+		       "ID", "AttachType", "AttachFlags", "Name");
+
+	ret = nftw(cgroup_root, do_show_tree_fn, 1024, FTW_MOUNT);
+	if (ret && errno == ENOENT)
+		p_err("can't iterate over %s: %s", cgroup_root,
+		      strerror(errno));
+
+	if (json_output)
+		jsonw_end_array(json_wtr);
+
+	return ret;
+}
+
 static int do_attach(int argc, char **argv)
 {
 	enum bpf_attach_type attach_type;
@@ -289,6 +426,7 @@ static int do_help(int argc, char **argv)
 
 	fprintf(stderr,
 		"Usage: %s %s { show | list } CGROUP\n"
+		"       %s %s tree [CGROUP_ROOT]\n"
 		"       %s %s attach CGROUP ATTACH_TYPE PROG [ATTACH_FLAGS]\n"
 		"       %s %s detach CGROUP ATTACH_TYPE PROG\n"
 		"       %s %s help\n"
@@ -298,6 +436,7 @@ static int do_help(int argc, char **argv)
 		"       " HELP_SPEC_PROGRAM "\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
+		bin_name, argv[-2],
 		bin_name, argv[-2], bin_name, argv[-2],
 		bin_name, argv[-2], bin_name, argv[-2]);
 
@@ -307,6 +446,7 @@ static int do_help(int argc, char **argv)
 static const struct cmd cmds[] = {
 	{ "show",	do_show },
 	{ "list",	do_show },
+	{ "tree",       do_show_tree },
 	{ "attach",	do_attach },
 	{ "detach",	do_detach },
 	{ "help",	do_help },
-- 
2.14.4

