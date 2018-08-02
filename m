Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1ACC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2EC21580
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AezSuOPi";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="N41cNR/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2EC21580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbeHBXVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:21:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59138 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727262AbeHBXVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:21:24 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LROUc012185;
        Thu, 2 Aug 2018 14:28:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=KYnSp7NsKyMzyHdhSDtQhVvHlpJLTQwyiFaE9Hw63ek=;
 b=AezSuOPiAJL8HZgIKNFSc8q5VYUCaj4qLQXdSG+w1u7Bfuh8Z0Ut2lj8fTKYj1dem2P5
 w4QBUp2xw6sN7Txftd/k/956+hp3qgWb/ny1aECdAAQ/aq7XvL1qoJ7xfAaWu/o1s4C4
 Df/rwi8OXVhfae0rMsswPRS6DZjmg+64lI8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2km6jy8nt5-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:28:06 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYnSp7NsKyMzyHdhSDtQhVvHlpJLTQwyiFaE9Hw63ek=;
 b=N41cNR/lLPK+zjIk+MDda33gExC7HGpZZmo2oO5G0ZgGkozRXmZB6ixi6rUWOeMAfyfoguU+DI2ZxhOG/DtdoSdSvwuT2otUnDZG5odijXquMuLYihWAPsQV1w66a37zJu38PbQRqhaJavQkoaRSb/KghA1PHm8h6tJfcM7oKSw=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:27:56 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 04/14] bpf: allocate cgroup storage entries on attaching bpf programs
Date:   Thu, 2 Aug 2018 14:27:20 -0700
Message-ID: <20180802212730.18579-5-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180802212730.18579-1-guro@fb.com>
References: <20180802212730.18579-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:300:94::20) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78ad50e3-8507-4df4-b505-08d5f8bed0d0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:TsOu3QOMRTYOqlPxazl8yrdryU98L75+ZwS+CsjXa4sKv92aGWkJKQXak4WDKCExHpgcXyMmcPKahHtXsJvNpOs8lsJQVWL7JbSnHdC/tpk7umh0Lqo8rsb1xzBGP48smZ8O/fFjatCaOa1jFfWPSbrXEC14OhXpDPsreY9k4nv+3GSEZeCebI7h7l07NmhqfhlLPwl+LqQXXDcCN2qRCAHSTjfMVnAmXkQY7DtIchY5vwFP1gp7uAF5wHFTjxJK;25:5Y7wGV1yuouf9aV2x74I+fqwHRUW0kRPjq8yK/64xKdQ+0YqBwgUQ2B3RWkYcjz1q6cSgye3WOtIHJN/NkzvrLFKDSxo+Llyswx8wFKuQq+y/toyA9hPTtTQH4N6arKclDel/FTUC8V07TXdd84nHd4tBJpt/my1faCUnFzpBcmYSkRYDEK1Pex4cdZEwoLuYXDy2Mt3yRqvKoCEA8zPAiZ1EaBtUeS6plIbXI1/WmIN8Eg+MZkJjyAqaX2Y7Y2vr+GGfJQEP551iEDvUBLU7+NbB5TbxMKThYWZIGb5Y08EBdX/XfU3ZfSxwVGKOXXW+6g7wjD1/w8DtAvvo+MYYQ==;31:ZvdIiEUhiyYjsdh86rJu/UNk5Ga31zd1jMINmGhq4buhMt2XSBuYvhMi1gC6doc5ttuBiOaf1RaQhQH8UR5BOx0AJvacBGM6NPiwGshRpxm7vR1JZxl4jsoY8TLm+4pKHJvLBaDW+GdSNFmZMUhArw/EfKDS8FpXaYEn0gOPheOHqI0D7c4lPacadSrrCSrPjvRkRpQKXXT+RjA8n3DAu4qSnJUB4F31qBeggfTAWQY=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:bGPdWd5/oF/clUNgfRVm7B+S45lsEfnFgUUoSyhkwP6cBmOOiFi2Zvoqy5ruQiDohItjZmoUeaWTyvTRyVLnxTFRuk9EfF6ec+PG4kbGkloLYaZoxl0h/JqzTYF+/rJvz9qGgPO6GHSPvEIi/o8Den4k7/Wl9G2it9tdsYkh4xBN3iMPKetZtAa8RJNGLA+ihVBuEd2t+glq1wGlXzIX/la96lMqVVgtAMRsveSD462GnuCHe7uHgqGzByFd4lWcR1HO4qk1d4jAKM0LDv9nZLNjdmCLlthHfQolOTKr/2v2NHt+krQgca3ZGSJSpXEE4Tvj4qeE2gEHV811JGYblc+UK5QPCZAtu3c3nSUFTxLszN1MnIHGpvsvup4qIz7geT/7KM3hPwRQX8reIfMGoPlzUN0+mo6agRP2/tYIqjiPHAGXSEcB11yCrhne9yk2fQua6AT824y3mNc25cA7k1g4KLuPstx+UiBW0LN84vd0fiUuNSdlDB/WaiAUC9d8;4:LmZBpegTq2CrBCpZ83Hnh/KhgI9ZkldrCTwUIxOvdOcZzjYPBpQMEtUPL6RLEtkd4q7CratexgKylp/JsoYtRpvoXjGGGMR9Qkau2PZq3dpbnrrr+NZGtGY8FMsu3d5iZyi70vOVi0yYuuVd6wJcFQM9N1FL8kykAQ4FaPBVbhPnzJs0uEy68gkqgPeCs7ubIB12rO+Dmb6jrKDaxLKNNvRCN9O8DSXA8zCxXLdkjsjlC9IwcY9QummYMd75pWB6svG3SeraQIbZAov1caIcFHAbrKlzRSqKqKlyv/0VoWb0FvXel/V6C/hmLzg4EPug
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167D3905F09145B5F3B2A23BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(5024004)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(575784001)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:IZ3FenyxjkyK+I4NdfJikPfkZ52JOYlV2nfsyxnC9?=
 =?us-ascii?Q?INl6rM+PLpLGbD0K7C183wAiaJxT1OTuWb3Z0Me9PQ4CbLBf4LaRd8Jsv7tS?=
 =?us-ascii?Q?rfgjEpinHqf/mIzxAWzyDRjmPpDJf+1OJ/napyc0LsnRyNHYATgfSLCQez8M?=
 =?us-ascii?Q?Dn/UlT0CZMNJg5IeOa7AZlpXzJPkDU9JffEHlzimKvZnSfYN3RKmR1TZ9S1i?=
 =?us-ascii?Q?/iAhUvG8gqAHUAq0QDwiHiBT4qPyM/dAIrJxQ53TgdhiXQ4SewD6MZ2aEuGq?=
 =?us-ascii?Q?0f7/DGjVGKAJil7ogRh2A/FIGk0JBX8TvghDjQqUBrOtCEnRvZhI+XIxMVis?=
 =?us-ascii?Q?eR51pA6ignZgdAQpjLl/cGAnN92R8repqDrDsuqZIenIVfY2uubQSKEW6/Zx?=
 =?us-ascii?Q?JPjDmBZvTaoOU69enRZjdjulvs5qYoNa5tTSMj2ueuaPnFXQxTNe+mmqU8Kd?=
 =?us-ascii?Q?wCNDHd14zm0vh22tIKb6n56XGbp67tPuZizKjdtVSdyedCvzLm2DGY/voaZB?=
 =?us-ascii?Q?ZQ0zW0MdrCpL33Mto8yNd7N8c8nwbYXtwd2HNbTh1OxLd01VuA/yQVlUlo6d?=
 =?us-ascii?Q?DwuAyQBca8RKJuYveKHTHXwDEm53kKY0nE/NHCblwmFQO6NXpMaN0LXG0tQ4?=
 =?us-ascii?Q?dpuTV3afktF2S4hjszmQNb6hLJlHFiDnabezXzF/JoEPM/3rrdsmZD05Vu8F?=
 =?us-ascii?Q?cchjLtIxzazLdOpJfBGOdl2/GV5mYaBw3bHBRW/Ce7e4WnNodRcy4BG6yUE0?=
 =?us-ascii?Q?yCiWrN5Yhwadp3VrxlnfkZh1D9I20JF42aSM9uhu3RKfZ6MLcrEkWTYNm3lz?=
 =?us-ascii?Q?gYMVEqIJPnoxlX6BBLLd8YVeeoV/jJ4nEr1ZaqsojPh5q7zYpILColzbsAUt?=
 =?us-ascii?Q?+TA0QZXax15g5LM2LNmAi7A95rVtpHziJIjeNtUXoH/COtEofPzoNT/dy5wx?=
 =?us-ascii?Q?b+VL2mOalFboM7M4TmSLM7OSFQKb5uhwsmSCsMjPoAk5xfN/1qECp4BWH0ki?=
 =?us-ascii?Q?qSOsazS3vsly25ZML5wWGwVmemIMqgXlipPnXVj+3xgM37Ol103TmstyGZvY?=
 =?us-ascii?Q?ezrOhLeSyI1SXJHMFs19YjtR5J1TBqNOZ2rZ/UWc8NzbZnwHWeETwy/Ott38?=
 =?us-ascii?Q?ScHbMaH2FV19fhjY60o02vG832te0658fuCpcVZWjbtE1g3CAETvGC/VxIsw?=
 =?us-ascii?Q?BSG3bC5pT+zwy3bwOPsZN7p0T0PBiGzPW+cntjVIexEkSD0bWnEiGNMRju7g?=
 =?us-ascii?Q?Oyc+SCcf/0qx4aMTN+snoEj9nbIQLoAwrrkNwd8XJV3KKN7XGHdXfj1o3lT5?=
 =?us-ascii?Q?M4d4ZQRUJbjpxeknlY48GjDF5g2gZ7iXUV/PBtdHo7s?=
X-Microsoft-Antispam-Message-Info: pwo9ervwg0We/TVhIC2PaOzZA8Oj4GU7vXNczWlqYKkRl8LndwzmcGPKtWwGst9fr3SR7/qUPJOxap4+1s9JdgYiRKYui5qXKx7u7+0iEai5w45R50pjKJov/SzsyJRoBFZA+jZ8Pd4GhxGnpjcVecSXUNwD/5zdYLmZZhjLT2NLSwuDgLn13jzfi3DpWVquIIKy5pj6+fYRCPSZD7+A4ORXGq5mXt+L1sLilfBqeYidgNVIdLDdckp2oMcyxY78hoEPV56b0AhMMrb+qO/xJi2Nqh60zjuL2lrQZAmW5pEKkpbGfAfCmQ3ZhWnp/vNrxdFXp5UAtBL6NfSkKwjoqxY8t0oHicJUnSKIuRWlBrI=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:WBv4ErcDx0i4f2rqEogpS1uWwX6Y17Q8MmHBn97egovq1EtO/DSxmqSayj9XsqYzPhsy5XxKPFLf0l4aJx31vi2ubE8SXGQu5WwRKSNe8cv/s/UU3BTQZqwQiWzmL4NaOW1ypH/yOZmPt4dMNFpwD0E2hjKjTOYnqE8kB44Sfl4oQQeVn5tTp9Xr9wi1hbcPkwGWdEWKJtC8vNYsrv6bVXf5gOSlftDkSk3n25PgMGnkFRyddHH4nZYWCf1pmHqRRf04X3F2ydZj4/hdjig1CyV0Sv8+/sA1/IwaIsDPL6CfzuGleJtPOlj6Z8XXeH5QkBeJVOM9hQY0FFIxLCGnWjPIGrs7RuCU2I3ERDq/dQd0GFOkk/AFKMnpl4QBSfCDWP1IamsvXF5dWRC/2XnvbkKTr2eoMSthG35Ok4oTLa8PD0iyq9i5G4S2DqJxwAFU5jR/Tv/j78DRjDT2T6dFZQ==;5:LwWdRokxS9QnSoR+pGvu8NM+BB4ywoHIkiy3g8v/uz4Ecgl7zcCjYJk7bd02ptREKsfqqg/2XxR+RwAlGhuusxtPj02MDGLC17LlATQT42ogIp1/y3ic0dGyLBHDOCIaZUl3mY9HG2R2hvkt1ufn8f2fv8NQF3hvMXlQ4JYsQhc=;7:vh/mnJJCvtCwkqz0s2532YZj8CsLmWwRrZvSvo5OiWjBzu/NQgLyigw2VWqDaeiMviHxRA1O1n90HN9HgLyqgABSI6WZ8Of4/GuZAImYzceilpBSQswb1K9/+sq3kpqLdF3XJ+wy13K6g5ihk53OibsKuRkix0e4UmZxGCU/hxpmKaWcIUHrIjwz+lz9SsJu5MLeQlwKffK0fSpid1j5Lo/hil9RVpicgls8o5u58PYozvoPW0PvcuoSdMIFkVvW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:6MeSANxeF6F08YbUn60wqAoQ+/8ACb36M6xtVKmSCxCYk01wd8p1EA4t9x/6nMpAFkbTCz8H1U04VGYe+85aiojW068XHHK9HxebBp/PUzf01XMFtmBPWygezJS56RZ8B5nUYsXbjx/tleh5cenC1IhPLBY2hmaAC0MmkMWSW3s=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:27:56.6480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ad50e3-8507-4df4-b505-08d5f8bed0d0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a bpf program is using cgroup local storage, allocate
a bpf_cgroup_storage structure automatically on attaching the program
to a cgroup and save the pointer into the corresponding bpf_prog_list
entry.
Analogically, release the cgroup local storage on detaching
of the bpf program.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h |  1 +
 kernel/bpf/cgroup.c        | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 9a144ddbbc8f..f91b0f8ff3a9 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -43,6 +43,7 @@ struct bpf_cgroup_storage {
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
+	struct bpf_cgroup_storage *storage;
 };
 
 struct bpf_prog_array;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index badabb0b435c..935274c86bfe 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -34,6 +34,8 @@ void cgroup_bpf_put(struct cgroup *cgrp)
 		list_for_each_entry_safe(pl, tmp, progs, node) {
 			list_del(&pl->node);
 			bpf_prog_put(pl->prog);
+			bpf_cgroup_storage_unlink(pl->storage);
+			bpf_cgroup_storage_free(pl->storage);
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key);
 		}
@@ -188,6 +190,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 {
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
+	struct bpf_cgroup_storage *storage, *old_storage = NULL;
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_list *pl;
 	bool pl_was_allocated;
@@ -210,31 +213,47 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
 		return -E2BIG;
 
+	storage = bpf_cgroup_storage_alloc(prog);
+	if (IS_ERR(storage))
+		return -ENOMEM;
+
 	if (flags & BPF_F_ALLOW_MULTI) {
-		list_for_each_entry(pl, progs, node)
-			if (pl->prog == prog)
+		list_for_each_entry(pl, progs, node) {
+			if (pl->prog == prog) {
 				/* disallow attaching the same prog twice */
+				bpf_cgroup_storage_free(storage);
 				return -EINVAL;
+			}
+		}
 
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-		if (!pl)
+		if (!pl) {
+			bpf_cgroup_storage_free(storage);
 			return -ENOMEM;
+		}
+
 		pl_was_allocated = true;
 		pl->prog = prog;
+		pl->storage = storage;
 		list_add_tail(&pl->node, progs);
 	} else {
 		if (list_empty(progs)) {
 			pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-			if (!pl)
+			if (!pl) {
+				bpf_cgroup_storage_free(storage);
 				return -ENOMEM;
+			}
 			pl_was_allocated = true;
 			list_add_tail(&pl->node, progs);
 		} else {
 			pl = list_first_entry(progs, typeof(*pl), node);
 			old_prog = pl->prog;
+			old_storage = pl->storage;
+			bpf_cgroup_storage_unlink(old_storage);
 			pl_was_allocated = false;
 		}
 		pl->prog = prog;
+		pl->storage = storage;
 	}
 
 	cgrp->bpf.flags[type] = flags;
@@ -257,10 +276,13 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	}
 
 	static_branch_inc(&cgroup_bpf_enabled_key);
+	if (old_storage)
+		bpf_cgroup_storage_free(old_storage);
 	if (old_prog) {
 		bpf_prog_put(old_prog);
 		static_branch_dec(&cgroup_bpf_enabled_key);
 	}
+	bpf_cgroup_storage_link(storage, cgrp, type);
 	return 0;
 
 cleanup:
@@ -276,6 +298,9 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* and cleanup the prog list */
 	pl->prog = old_prog;
+	bpf_cgroup_storage_free(pl->storage);
+	pl->storage = old_storage;
+	bpf_cgroup_storage_link(old_storage, cgrp, type);
 	if (pl_was_allocated) {
 		list_del(&pl->node);
 		kfree(pl);
@@ -356,6 +381,8 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* now can actually delete it from this cgroup list */
 	list_del(&pl->node);
+	bpf_cgroup_storage_unlink(pl->storage);
+	bpf_cgroup_storage_free(pl->storage);
 	kfree(pl);
 	if (list_empty(progs))
 		/* last program was detached, reset flags to zero */
-- 
2.14.4

