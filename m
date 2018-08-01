Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666FBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C6B20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UQM9BsYS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Lmn/hm2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C6B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbeHAXZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54700 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387617AbeHAXZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:28 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LYhpr002833;
        Wed, 1 Aug 2018 14:37:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=L9lbebqNbhCiO73/tIaPEiFFZIfbNndWhKpd3yhwg0g=;
 b=UQM9BsYShYg5HDTZkiTZCOU6kheC9zah2pfdC38oKU5YO4deJro5+1OFWMWjh1aZeGVH
 tXL3vcDfGzGVw4pKmyLBm2E00ps5i24uOefZ9pNgeQibCUcG84dzfxGPll5k97UG6Hqm
 brJ07WK9RgJzPTf7hRU6h+KlCYcTJl2KsWk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkmqb0163-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:19 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.22) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 14:37:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9lbebqNbhCiO73/tIaPEiFFZIfbNndWhKpd3yhwg0g=;
 b=Lmn/hm2tbRTWx/wNHn8M4wX05ba1oFBr/T7wXVtr++z3oQnJWZwgoter6BamqluaZhq3Of2qEt3WPy4qxauryeu4lZ0Cjlq0vYHSFJQtJl9eEIfiTYpzfWFqdLvhMa6dpOfVu/WWuUWCehx9UZHrcrNVoCmv2BEppKmLp2qevLM=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:12 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 02/14] bpf: introduce cgroup storage maps
Date:   Wed, 1 Aug 2018 14:36:37 -0700
Message-ID: <20180801213649.30751-3-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213649.30751-1-guro@fb.com>
References: <20180801213649.30751-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:18d2]
X-ClientProxiedBy: MWHPR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:301:73::30) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66be73ec-c537-4bbe-eb43-08d5f7f6f17f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:0tdC8ITd9GksYkA3AHC54o56teKiFI2eGYrlHiP/3xzyM9H8UiRKcx9VzP/xWsMRdoUG9X8VqEs457s4HVhDxwGwrK+uNKFu/8xGhnaG7Mz+UHtquHGfRsH+bEAbphaAwY4RSZlHE2RSPH9tCFl5R6Q3bd+z3g5xngGiwR0j7dTGGkI+iXRbe9SPfIBU/4gY9QLtmoicjqjzdHU2obo+V1xSqf1HhpjofQ32h2nyTfBHbT8QR+q7Xpd91VqNNygV;25:hUuVJaZLjZA+ByNJPb9G5dNbRmIfDBJHNeJbsKhDV50mySI0UKRYQ0LPFd5CQjazO4g4bRR8/H+sjaRaiZxvNjfYbuSGbuxHGGEzg3+QJSGRspm5CCYlUhwqJvtK7E8g6Twvi9aWf/nilbtCj9HZ42bOPJPE5uANnYBhCs9bIuPVI8rNysUShlb4FcAgVopLv6npxRCoYuHeXE5spSzC2LpdFuG0ijSqRAYPXrW8f3c6tgcJ4gCNlODtSbxLmhcXbdaUKbH4+Lec28uEKCQGc29Gd0LX57V73enS/SXYZVKVwFPWHFWat5nsuUrLxwnXHDsja+nwbFOxKnHBLyPUUw==;31:QBqkjaG67ghEnWJFkaOOOXgR5Zye/JUNwf7ucoE4Iz0sR7tbF260RS8tar/BeQbQ2SKJvjDguE+pjeCOY7dXDKXAdem1Fg+kRZiOxXW7UlQF/DocW03IFkaW48lfIHjcn4iPx0+yftXeA09j81i8I6nVE5x3U5pzPdpqFxoPCfORmK0vHHgfDsejSidIj183dATWFbzkXcQIYvLpH63d+jNfRSlyKicQ6UASwId2RAk=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:FVYc4VlO6N+ya9rdAeln3e1cUFsXPOI+eI56VKTBipA+BQTvwG+Ob7fF6j/QoScBnrC5Aa9z9RVaCUvKOWzKnsHvg7jYVMI9CsTGhbtffvQSeAzIiqAeiOzh4QW22QMep2dmYV+HaCgP2PkalCVHtP8XyOIA1SJnrFmQ2gBS1f/JXKpPDq6ei+7biYK7QBP7O+KhU3C3R3CSNf6fll5ZkTFs07D3zVvPXxBOr2dlQkVZRKWWGQrFp02COrzdkwJglziofq54xMhvmT6yCXn/UDOiYS/9Lw23Ip0aFQdpzcMWck+aMggzazP0DyML7iD26Czt3b73x6pd7kU+BjswVf68/VmW/kP5VmXfWYSOSufo9SBtY/klyrDCi/VasyAIDDfbuplzhMy7MCXimy0CyEpDwTicekskZBIFQ9yndQnspwKLjSDO/xICFqti16Sf2M1XDIHEBrw1aVRWryZbcSYy+Gz1vRK0zhQLbMt9CV8efSXi+XCuJNXThZ14xjAp;4:Afk+Ir0viSOa5Qk3uHzcfvc+zqFLSumwv+mkSbVpoJqoISU/f8Z18tZdFNjaYs0d7Lsq0+d6Vx8eVOhNyZ4wvzY/Rnz962SBOZIvgegLoMs8TkkeNKjL+Kel6QiHWomgSIiXEWCIknLt+6d5S+5S7dEyPR+/9AbkLTfVhQmDpw+Rcjb2bne20MYXoGt9NDXvgIfN2nAhsvLqINH3QRC552+G9OiVVdEyPpX3uXLyE6BD7ma1QMV8UCvaUa3wD7en8LsiJFuYKSKE2eMSm//LGArOrObbcIYFsPVd1NcuFdDm2g3O9u1JL73Pv163kTONUi4GBAOGc2trh6sJe+4KBg==
X-Microsoft-Antispam-PRVS: <BY2PR15MB01670E1D48AAD1378640F667BE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(5024004)(69596002)(14444005)(106356001)(575784001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:vr6YM3LpAFOyZI1Uq2LEZo/DhUg6rKf9wIDOgflXJ?=
 =?us-ascii?Q?kxBJgpVmELeqHXj0aoJFgeRYEQ9VHCFXdYz0NdS8CoXeU3EN2qhc4A4R/CiN?=
 =?us-ascii?Q?wqR8UhjSbFEiGUq3hV/K3Jv2vMPkuu9usjSYQ0XzINjmQgSx0IW+YeQzHTrx?=
 =?us-ascii?Q?9bmrJa1rYxtQI/5ygJgGEpRmYMoqd9ayeYAuykjuOMY/vAWrc2+0IhuziOn4?=
 =?us-ascii?Q?ClkG+eAJFG1lTMLr+GhhXVDpHadtkWe74QG/KAm6GCuAyda2KnoYuhtR71FV?=
 =?us-ascii?Q?FNm+IyRf1YaeXxhV5ucWYbInZoa8hTSrZbYfgSDbyzv8Q+yCkphEm6lKiIp9?=
 =?us-ascii?Q?UFkMdTxtImnD1iZgDa13u5xIam5118ffceacy6H4ElYSUvMptbadDuanscJB?=
 =?us-ascii?Q?ZhQUWGmriqZh5k70dKTDR5Ig5/BtBRGpbpO4A3sm84wJ0ICBpSkAtN+R22zF?=
 =?us-ascii?Q?nmgyxNee9f8L1inFmnRsYZ76dgGQ8HT5gXgQvEuxvRGnZ3+XWyU0oQ9XyXXv?=
 =?us-ascii?Q?5gw184QlRmGk/ITNE3v2LRBFAg+3DAAEY+Uw3iLwqThYTQxC2t5+gJzlOAfr?=
 =?us-ascii?Q?ZOh7AHjmFiEDClMzw+IQzwgiTQfHzpsoF0t+kUBgsG1kQ/wm4oMD5k5GnWnn?=
 =?us-ascii?Q?6sjgdGU32Oemo6KfrmA/fvbRr2jhfFI8betdWMmNPopX4JrXuGdmkxcs9kG/?=
 =?us-ascii?Q?q7F6JRbjs2APLJyK6cX+P64M6GzYWA+mvvs0QzCoFTgMmXQ6MdVbKghEZfNK?=
 =?us-ascii?Q?dHbmFSF8JgdDlbWYu/JyOU7TDs9/ULcfq4Fan2TwuvazDlkj5pemfiOfliGE?=
 =?us-ascii?Q?34/kx+prrbdrTgmETSz1bHOnwkqeI6yf9MpI9/+Ds4ArNkmg+U9z8x+WBUvl?=
 =?us-ascii?Q?AR6LFxByyCmGTzco7BrKhAlfxccsmmts8/putTIJhYQ58hfsScFzSHI0QvL5?=
 =?us-ascii?Q?uJNhLvVFEm2uxQJZPnWJQadrrPFwmm94X7bW6fGnEATkHVfJ9OcEB2myK9wc?=
 =?us-ascii?Q?cc8AmGcTk28xcboNI90eDDDy+11r7FJ7U0gO55eGBo5A11OcnlY1M3hAwH2z?=
 =?us-ascii?Q?w/3fQShdLD1pPJeGly21M183VZlQT4DySBJwNr9zyYyAqjL7GuajVFJBr8/H?=
 =?us-ascii?Q?umXcvEKMlFXxPxJUuvXff0AgTyvdTPYKwyCJGO70dLuQjBYC0jd31j3gnZ9N?=
 =?us-ascii?Q?soMf1QAYUdmeEJ5gH5TLTGSx2vdeSDmA2ay1nToSUv9RXrpJflJwkWXLluJA?=
 =?us-ascii?Q?mjF0h6X3FlnTTc1W1pvXfJ9yU51nqD/+gt5uLWwbUhX9bvdrEmsEu27oocva?=
 =?us-ascii?Q?TX4ld/HAT1cp9kxTLcUXqqXFgn3DJjs+K7t0LaLkK/r?=
X-Microsoft-Antispam-Message-Info: ps7DMdVamToA2aw+6JrzX5+kuI1Luu3fX0SCbdGlPCsqCx3ODX2PJHkDGLZijepRRKajoVtHWDUmEchJX6U87ZmPu5S8WrZ5jfuUvDv/7CyEOMTsleQIV2Kpr3VUYEgT32te7AStNh3Jo4wfr9zi1U0p0CdsAyXOo+zuqsaGSJvYS2sJciXPAZh+RuUXyT8agar0SS3S+m53DGwWSTy4HgSPU64o1CchQtfIAX2x75prilghVSqiQKcZrcAI1v44De9KB/sQ9EclTLceJwj86ySusAQB84NlnDBrkmru0nQFYwB6sQWr5cDdx6/WaJVWLVh9u9QeZ4THgejYaXGns3cK32BzzpFzPLQ9zJW8fW4=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:7tKkEZurRjKfSAs6fwc9TZCpYK3EgMN1T1QLsecjuJfk2nISmFErzGMgjTOIW1qtTl2ruCw5Yt4DMnffgDhbU+F/vcEl6ffhyG/2xwUvRVxZfSqa/pN8MKaz8e7VCKuHf9Vh3oU245m1cgKzXFbjv1u+63+sxApFqnY09k7OS96dYQXMtsqv1WUZuljaMPSdY56NOGFGahlOzeT8z5nUqXM0MmDPNmOVkZmqsSsc6DpQj6frL2/HZLCsYB0acElPCPNIqLhzwK7i7S788+u70BZs2cZMxz9fglsZDg3ADMv2hWhZVn3xDbwOoy66Gnm2lnChaOhVaYTLpGK3y/t4LVZpJ4w3YIuKEhtTyaarkE7sxetqVwSubdrarfK1ZnLdheE3n5NUMbAvLIib6lUItjuH1v153vnotWv1TufTOhGkAsUZg7umxaLfZsR8/qXC1ht7Rj2jodaLYQqtDYYsrA==;5:sowELAyc72U+fn9Wo4ZUVPqsWgPpATb+7vH7AVx39GyFQSyEVQoWaAPw12ib7Lk1pv3Ahy04BYKFYpVFqXKtZLtB0N6OMH3ox2z2RquhH28CoIsGcGTr2lK+WFON1IJQXlDhspZzpEEgxjDeFIhxEAWoOji8aUeKxTMBWekIZPM=;7:VUzHvb5PPlQec6Cf9tLdmmfZ3vn4LSHTVzIxcJfP6dt5/q5MkaO+33zrMnXBksIW2Cjnq7y5bgH+loFu030Olj0o00XXJwWNiXpA/q450H8RGgXWheMK13iQABayI+np3wQzFuXOEsDcah8tGbW7RiFb6tiPmvjX4OFwPsyCxD1oQSvKub9nq9vaNSs4g3WQmwZx97utaFimoI8MGOSwb96n3g7FBCFgDKwKcYIikVUFAhQdQjPKFSQ0cNqYTrnr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:vGhHLv6VL4VtqUFLOXvd3cbHQOwwSe5BifTKS1iRNPaC6sLmFKXLHmEnhNkqE3CccECUSF+dNJskOcxs7ZNU6I40DKVdJNdV5vra4cUlN0D0UqTOX5vqjpPW4qe3i6JrTHWS1dgdAjLU/uPeeE92QrdoSDL2n43gz1JRobskdPE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:12.2035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66be73ec-c537-4bbe-eb43-08d5f7f6f17f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
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
 kernel/bpf/local_storage.c | 375 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c       |   3 +
 kernel/bpf/verifier.c      |  12 ++
 8 files changed, 439 insertions(+)
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
index 0ebaaf7f3568..b10118ee5afe 100644
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
index 000000000000..c2df725a46eb
--- /dev/null
+++ b/kernel/bpf/local_storage.c
@@ -0,0 +1,375 @@
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
+#define LOCAL_STORAGE_CREATE_FLAG_MASK					\
+	(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
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
+	if (attr->map_flags & ~LOCAL_STORAGE_CREATE_FLAG_MASK)
+		/* reserved bits should not be used */
+		return -EINVAL;
+
+	if (attr->max_entries)
+		/* max_entries is not used and enforced to be 0 */
+		return -EINVAL;
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
index 7958252a4d29..5af4e9e2722d 100644
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
index e948303a0ea8..7e75434a9e54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5154,6 +5154,14 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
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
@@ -5180,6 +5188,10 @@ static void release_maps(struct bpf_verifier_env *env)
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

