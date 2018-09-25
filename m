Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1A8C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5208D20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="J+0zrsTn";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UXqT/wBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5208D20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeIYVaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:30:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35894 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729484AbeIYVaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:30:02 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PFJr19031887;
        Tue, 25 Sep 2018 08:21:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=zQ2ZhPPxLRhusbElsNPCXIFylImMIBmUNcQaQNZqod8=;
 b=J+0zrsTn0QMh3TY+HhA9O8atv11x+5F4SdlFngEMwd7CQUd7h6M/toMpzlAbHGc2ysfL
 EaWMs4MCpnqp0+XGF7wEEB6SIMzS5R0rtQvOaqdicrjAgYryxr5Ju4pTPMMZUwlLzp8N
 ck/Df+PumzKB2ljzNYIXYsivy4N2V2vrHkE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mqpp2079y-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 08:21:42 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 11:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ2ZhPPxLRhusbElsNPCXIFylImMIBmUNcQaQNZqod8=;
 b=UXqT/wBF3HsPTI7zQNfQQMo361Ca2wKedNtDPf+BR0kXyLEL75W02+U6nGsh6aWS1Gr0lFC94T8w0CcDuAR7Y72vKoTQhsKBOIaL+dbk9AD3K+GHgziEfWSy8D52rdiEXf/lfh5HLa+iGNZkXZIdJwy8G2ovVTAxyPk65X6wGME=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:f4c5) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 15:21:37 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 03/10] bpf: introduce per-cpu cgroup local storage
Date:   Tue, 25 Sep 2018 16:21:07 +0100
Message-ID: <20180925152114.13537-4-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925152114.13537-1-guro@fb.com>
References: <20180925152114.13537-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:f4c5]
X-ClientProxiedBy: AM6PR06CA0025.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::38) To BLUPR15MB0163.namprd15.prod.outlook.com
 (2a01:111:e400:5249::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e79be0c-482f-4b1a-e4b7-08d622fa9683
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:1Z0XYQE5CJZ1e/k7JdZ83e9NmqlmRuFltstvh9+KYJaWLPNk4eoSLGIfVH3v2gSFz8JRxfh1XStM+TjcUyNgEj1pxI1TsWgD739tYGT9Ww5H2Z9H9DqQgT/E9f2BPTvgXf17CH3MFGNtWYLt13HSnseNVFJ70bFF4hHqfEALiyWjEaAnM6r1neXpSosDJx0Po8xv2HANh8KX8qo0XO/XF9tsBkzHQpWMjh3/MeKYU9TQP93+3EwDk9A6+bubXXXS;25:TyZL0ZvffJtV+kYBN8Xpqz0kqbVUBomYEsSbLkCddxbaMHDz19ZAiFxtk+9hadFhb7IC1YfMW9xZd+1Ecb4xoa/9Iva/2qKXAJdQDdh2TArDt6JcQI9a0d5h2kTsW9AX3PtphptaLuszDXKpm4C6iFTg5xWqegIdGny64W+yPFEGEDN4/FQjsaou3OpQ2JEb3zIg/iQlKjeGK7qYxMAR6QKC0SRkX+d9JX0hQWBhjAfGl+Gs8YV/fWockJrBNJeVP1tkvAbug8ZqyJKu/SZhOkJRHYv0oWqvn3nfjx8oVb/OFf5/JjK9SpgCTBHH3u1Nwc1nl9MU3v9yvr9phoZQ9w==;31:bu5A1SZ6Ee9KrunLOVT+UFbj8rawDC9nuECBIDiBrrFlDR1ouIEWegX5lWaMlXIcEreU3e58m1Lvzb88T9DSZ7C/HVV2VlhKwhwbgPQT26i5NHgME/N90+whZtszNE2ou9nLH39DgOcoYwRW3I1N/9d0Y6zQco6omVMjpIvWGo0/QiILaVoRF/rG8QIxmtEfLFQPrtryPQfWUEroHRT8KmhwHBm5LlQxPrcGYBfSL2s=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:Ui/pZyC1Mj36x6botFZT7tMhYctBpPFQVD4p8yFX9mixVtdu3LmVQBu+UChQqmPvEcFRP9AR7AiyPOTCXDmny+qzx1rICD9+ynWnrvhubxo3//5eNjlgC3lynyX6VC+6JhQ7ZEx4w2pvYKIXdAiAdedGeAwmKCo0lQv5UIn0Nb50/tPkWsVVnoxeWahw0QdxicxGwzqwnaCOsntHIzcjl0rR1kHQflkylpxG9WOB9oMD00VTpbVT4H43fdtaC12AecZeNgqBpiqpNW2SnnhkCVH7MSRm5DOeGQtykIAX7YtruvS6wlTSvpgKEaAIlxIHOl/XJAOvAJTTFjjC/EW9ojBHyjjyg0LjVOzmGvMB5UEFvSDUA2h5DnE0iTPYywQx7KqyaZ7hco8z9IUaBczr8HUtM//+zDdj6dhj9vRb9YE2bEPW2IW9N9CB1xKi2nZkCoOYuhHdU2Tua/oscQagK0bTlamqFfLV4vqQegT/1GoVXGwWuSAm83vzpBeO37iD;4:OEtdYU1DIDiuZFET9v30BVnL435iUIuydm/MDSxOLy89WBzE+4dStv2L/6aMy1n8jy35ShbfGQdJJtmDZSyqMqY+Tk+Fel2fSAwyN4dwoh5YFOsvTsfVNLCiGCrTHxOMEY0T7LDzKh5S6zk5yauVVfDl6+ADSZNcGrf8l03oSjn8CyF0LzAxcMgr6YnD7WfbRvAV5PaIy+MhwCN+Uf0o0WPjk6Ra21MbK+CBwOwrfSjOvU2cQkkq79nmYXTQeyQvGQLmZbYytkqIzfenUIRV0pgc+2PEnGjDEJLqElEjjLlOLauR7JbuupUhzKu4a5X31LQ7DFaUvJa9UZGl/zoSgQ==
X-Microsoft-Antispam-PRVS: <BLUPR15MB01638AEAFDF8371C3E2CB02CBE160@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(106356001)(105586002)(16586007)(2351001)(36756003)(6116002)(53416004)(7736002)(1076002)(305945005)(2906002)(4326008)(6666003)(186003)(16526019)(54906003)(47776003)(6916009)(50466002)(53936002)(48376002)(6512007)(316002)(5660300001)(51416003)(52396003)(486006)(446003)(52116002)(476003)(2616005)(76176011)(2361001)(6506007)(46003)(386003)(68736007)(11346002)(97736004)(25786009)(6486002)(8676002)(81156014)(575784001)(86362001)(478600001)(50226002)(81166006)(69596002)(14444005)(8936002)(34290500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:1wef5zVq94RO+i02huUPaIuWBgbEiYIWilmhTKcAT?=
 =?us-ascii?Q?/bCJ7ZUIHADBQPb7TtvuJtPz/JlT3TtvrpI03wV6W8TUTqHwx/QXpY9V4Zwd?=
 =?us-ascii?Q?LUt1qJY6m5Dfi2JcpNWGSXJ+VtCGc/UPiOp/fOajJfbtNm3znErLEDCdIeJK?=
 =?us-ascii?Q?t4a+b8ilW7Fer0+NFmOX9aUsMUbc/wr3p7ZSH+u8BLKiANqitluHwIpjp5hh?=
 =?us-ascii?Q?MNov/nbaJMj6kPDwYrISsMzPVfzEUC9jCGI4UGdOecac9iE97tvuXMTh7Wy/?=
 =?us-ascii?Q?dRJzJhJor1Br/2XK3DjQk4RP4VgtglwrK2xomUDEoaLbjiAdJXuGOFOdGwhd?=
 =?us-ascii?Q?HUVArW5EjmcBAVdYWnDjtZ7QuCTdz77lVjP68dznyhN3eAAp9SU7Ydt6/KU5?=
 =?us-ascii?Q?+c2PMaoXwVk4CJW/lTzNTroFyTWehd8bQxsF7nD5DoMVKXpVlRDoMKY2/KBA?=
 =?us-ascii?Q?ZHRoMxjak7+Y7qIFsNy/NVnEBNVuEAKgyWcbUyrsoO6Tj8sV7ck64In95JGw?=
 =?us-ascii?Q?RIfET1csKLsqeL9JgNRyEkzVf3llBsiz+hqzUENVLE+RyhlK/5m9+X705/II?=
 =?us-ascii?Q?zJVFlcSZO8BRse1voPQ8jFNf0luC4tD8T8iGgSpFglJcy0aum2IWEpX1tq0R?=
 =?us-ascii?Q?BG2bqUIsg7w9/KJ2KjNnDUdNp+rGfHLAf1JjQ3gD1HZFaOh9vUvDlgp6KYB2?=
 =?us-ascii?Q?Yy3tdqDOqYOv882VZJs1JzPxtMBjsc8kjrBxwKug6wkGOg+VM7r8hVkt1up0?=
 =?us-ascii?Q?+90ngq3A2YijWFeml+DZBaWFYwsnYqamxBCaAi0X33S0rhawKPTQpUvM31fr?=
 =?us-ascii?Q?ZkZzuVcEnrhpQkrY088UtfELneNx5e5SpNec/pcvs02w78U6sHjo8/d6RG46?=
 =?us-ascii?Q?njr1vKsLLqLu7HKO4n/8n9K3xeKl+uiBlGAAmD7Z70UQ4BEx+jrCjtVXNesC?=
 =?us-ascii?Q?d3pd5gn2useuMBdOkbAga/1J31EV+yA1WGOFw3092LKD4PQTx3ZTEjm2MdvQ?=
 =?us-ascii?Q?FjrspwlyoWXw6DOoprbir8uBVKuvaItxDfPW5xnTCBgLsDqoL49/HXRXIj5v?=
 =?us-ascii?Q?ql+v5wvS5VpsKVUpvPT/lt39yejRR+Gge6OQHM5jc44L5n4Tqh0qorEifinM?=
 =?us-ascii?Q?OA8a3Ust11mC7964wbrmexIu44tPqMEpLkjJFyDl2Q6axbA9SM8gOgIgDrAe?=
 =?us-ascii?Q?rS0rlE0Y++/al01Y+deJt5dGDe9a2gQtnkomcRbd8E3oDSvMcxQ/YQS5ASFV?=
 =?us-ascii?Q?jWDXeQbDA+dRkWVwPgkwdxSUvFHOPU64166zxda/GKkbwUlVziAw6LLaZ1LJ?=
 =?us-ascii?Q?kL5y8Zo9wrlb/rf9CFmxLEpmUFSgP+FIXrJPDjzFka7?=
X-Microsoft-Antispam-Message-Info: QpKOfhBJiHQAIAH5VTi62/HPG5ehz8Us4v5qCPNoPPpLJrMsWphuCZNRGdGaXIwuKLbJOqWcmftxKhREcVMOisMaCjmEVgUbs37UzJUXPBuEG9OVd91NgTDPhsISJcEL+7RNgEAX1Zq05aNbytJsJPhSfpKtnEUsKwBkuEgUCXMuyCF+ztbMEA3jenF2l5ZtmlenZJVJBNX+LEbLHBGTzpDv1bVxrze34TAh/+Q1W1B6viSGldYW+wIygiZ2Zi09LIeVU+6Q7de0m49BL+GKBcRan/O4TlOaO/7V34z9OH4DiJlYJJ5V+H4ylE0WqgvPh4wCH37AbUibNo0teE1YBetqfm2KmIEnSp83V/Zc14o=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:tRPpAKVdrkg+amga+rxnf9s/5dGWSij2gCtHekyUXwHSYET1a3wEYDqDV0eBCLKqdq1ZL1QCxxF7oopINWYGTp8eMygMN/5X9O+z8V75nG2Rjl+EzTfdG52W4DgXdwH6SVAUCN/0mwW4BR2z7bdP1h9ApgNwmVrlOAJhVphRl5C+uOO2qrr0EEYQLHcnLPsl0T12YDd4mki5qlT+L8nI43TADbYc/EVrak3QwQWcgQ8xVBAL4AOny7y2BYUcHKe76mmhxvkmefR7eEYboqBwg8dnOknR81T+9twOSiaH56uVoQY8ikAu89FvdB6tBw8OnQBITuFDLg9pFVZ2KERp//AvhNMnPXR7tgk3VZ/kReZQj6g0DhBh8zlinLTHqAn7vmRRm1BErtaq+iiNfMiGGqPLHBp0fKcBdf+FDkf8Cq80yvyRVNa4lCq8xftbdprVwwUoSdRL78Cv1Ta4nn+qMQ==;5:6YgN72pvvyPAt1IpISsLBkjc/TASx4tBcyRp5WmbSXQG/8vtmlPGhLaENQzMec5vhWP67lMIZ6byXpzLOz7dHMYuPWDUZOQzgMxkbKWBRnlpWUbx8l7o44lRZLMnY1cynsmbDkno+qNMrRmrC5StYL68txo6rmNAlY0sRJ55PQU=;7:KTPurQlzTigC8lbMySgWpglo2iPsAUus7xhsoi/RBjA7eNvbrvBIKuSbqPbPSqegDDIkEfxJBkWhYce9RrqCFuvcLyBmBYcrb7wX9seHtZqY8aGwkLx+A+mRUndEz8WnJH2mUui6MjyR1Dp47B9xW9S7C1dFycL4pGVur4CdPjOaqcCfh9VPOpNShOch37NWWiK7ZQAc84TjZ43Xf/ew8glyumbVpMsFHhzPRvmFx/qv8yO4PNxABok/qNj/xxw3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:xbAKDIrfZGlnASc28a9if0Fh9tGy9Ve/j+pFw1X2NJN9sY/1GVMwodHCssgC3XXiTAcjI6g2ujW7N9ow6QtdXQj3mX9V3nUrMMVX2mT0BBkLG7Bv+0uFqWcLXLJlZd5mnxg/V4a/V+XFM7TlP2J6rNpDGvlo9Q2xa18wBxwmp6Y=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 15:21:37.3360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e79be0c-482f-4b1a-e4b7-08d622fa9683
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0163
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduced per-cpu cgroup local storage.

Per-cpu cgroup local storage is very similar to simple cgroup storage
(let's call it shared), except all the data is per-cpu.

The main goal of per-cpu variant is to implement super fast
counters (e.g. packet counters), which don't require neither
lookups, neither atomic operations.

From userspace's point of view, accessing a per-cpu cgroup storage
is similar to other per-cpu map types (e.g. per-cpu hashmaps and
arrays).

Writing to a per-cpu cgroup storage is not atomic, but is performed
by copying longs, so some minimal atomicity is here, exactly
as with other per-cpu maps.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf-cgroup.h |  20 ++++-
 include/linux/bpf.h        |   1 +
 include/linux/bpf_types.h  |   1 +
 include/uapi/linux/bpf.h   |   1 +
 kernel/bpf/helpers.c       |   8 +-
 kernel/bpf/local_storage.c | 148 ++++++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c       |  11 ++-
 kernel/bpf/verifier.c      |  15 +++-
 8 files changed, 177 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 7e0c9a1d48b7..9bd907657f9b 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -37,7 +37,10 @@ struct bpf_storage_buffer {
 };
 
 struct bpf_cgroup_storage {
-	struct bpf_storage_buffer *buf;
+	union {
+		struct bpf_storage_buffer *buf;
+		char __percpu *percpu_buf;
+	};
 	struct bpf_cgroup_storage_map *map;
 	struct bpf_cgroup_storage_key key;
 	struct list_head list;
@@ -109,6 +112,9 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 static inline enum bpf_cgroup_storage_type cgroup_storage_type(
 	struct bpf_map *map)
 {
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
+		return BPF_CGROUP_STORAGE_PERCPU;
+
 	return BPF_CGROUP_STORAGE_SHARED;
 }
 
@@ -131,6 +137,10 @@ void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
 int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *map);
 void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *map);
 
+int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
+				     void *value, u64 flags);
+
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
@@ -285,6 +295,14 @@ static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
 	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0; }
 static inline void bpf_cgroup_storage_free(
 	struct bpf_cgroup_storage *storage) {}
+static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key,
+						 void *value) {
+	return 0;
+}
+static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
+					void *key, void *value, u64 flags) {
+	return 0;
+}
 
 #define cgroup_bpf_enabled (0)
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b457fbe7b70b..018299a595c8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -274,6 +274,7 @@ struct bpf_prog_offload {
 
 enum bpf_cgroup_storage_type {
 	BPF_CGROUP_STORAGE_SHARED,
+	BPF_CGROUP_STORAGE_PERCPU,
 	__BPF_CGROUP_STORAGE_MAX
 };
 
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index c9bd6fb765b0..5432f4c9f50e 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -43,6 +43,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
 #endif
 #ifdef CONFIG_CGROUP_BPF
 BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, cgroup_storage_map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index aa5ccd2385ed..e2070d819e04 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -127,6 +127,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_SOCKHASH,
 	BPF_MAP_TYPE_CGROUP_STORAGE,
 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
+	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
 };
 
 enum bpf_prog_type {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e42f8789b7ea..1f21ef1c4ad3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -206,10 +206,16 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
 	 */
 	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
 	struct bpf_cgroup_storage *storage;
+	void *ptr = NULL;
 
 	storage = this_cpu_read(bpf_cgroup_storage[stype]);
 
-	return (unsigned long)&READ_ONCE(storage->buf)->data[0];
+	if (stype == BPF_CGROUP_STORAGE_SHARED)
+		ptr = &READ_ONCE(storage->buf)->data[0];
+	else
+		ptr = this_cpu_ptr(storage->percpu_buf);
+
+	return (unsigned long)ptr;
 }
 
 const struct bpf_func_proto bpf_get_local_storage_proto = {
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 6742292fb39e..d991355b5b46 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -152,6 +152,71 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
 	return 0;
 }
 
+int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *_key,
+				   void *value)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+	int cpu, off = 0;
+	u32 size;
+
+	rcu_read_lock();
+	storage = cgroup_storage_lookup(map, key, false);
+	if (!storage) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	/* per_cpu areas are zero-filled and bpf programs can only
+	 * access 'value_size' of them, so copying rounded areas
+	 * will not leak any kernel data
+	 */
+	size = round_up(_map->value_size, 8);
+	for_each_possible_cpu(cpu) {
+		bpf_long_memcpy(value + off,
+				per_cpu_ptr(storage->percpu_buf, cpu), size);
+		off += size;
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
+int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *_key,
+				     void *value, u64 map_flags)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+	int cpu, off = 0;
+	u32 size;
+
+	if (unlikely(map_flags & BPF_EXIST))
+		return -EINVAL;
+
+	rcu_read_lock();
+	storage = cgroup_storage_lookup(map, key, false);
+	if (!storage) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	/* the user space will provide round_up(value_size, 8) bytes that
+	 * will be copied into per-cpu area. bpf programs can only access
+	 * value_size of it. During lookup the same extra bytes will be
+	 * returned or zeros which were zero-filled by percpu_alloc,
+	 * so no kernel data leaks possible
+	 */
+	size = round_up(_map->value_size, 8);
+	for_each_possible_cpu(cpu) {
+		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
+				value + off, size);
+		off += size;
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
 static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
 				       void *_next_key)
 {
@@ -292,55 +357,98 @@ struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
 {
 	struct bpf_cgroup_storage *storage;
 	struct bpf_map *map;
+	gfp_t flags;
+	size_t size;
 	u32 pages;
 
 	map = prog->aux->cgroup_storage[stype];
 	if (!map)
 		return NULL;
 
-	pages = round_up(sizeof(struct bpf_cgroup_storage) +
-			 sizeof(struct bpf_storage_buffer) +
-			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	if (stype == BPF_CGROUP_STORAGE_SHARED) {
+		size = sizeof(struct bpf_storage_buffer) + map->value_size;
+		pages = round_up(sizeof(struct bpf_cgroup_storage) + size,
+				 PAGE_SIZE) >> PAGE_SHIFT;
+	} else {
+		size = map->value_size;
+		pages = round_up(round_up(size, 8) * num_possible_cpus(),
+				 PAGE_SIZE) >> PAGE_SHIFT;
+	}
+
 	if (bpf_map_charge_memlock(map, pages))
 		return ERR_PTR(-EPERM);
 
 	storage = kmalloc_node(sizeof(struct bpf_cgroup_storage),
 			       __GFP_ZERO | GFP_USER, map->numa_node);
-	if (!storage) {
-		bpf_map_uncharge_memlock(map, pages);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!storage)
+		goto enomem;
 
-	storage->buf = kmalloc_node(sizeof(struct bpf_storage_buffer) +
-				    map->value_size, __GFP_ZERO | GFP_USER,
-				    map->numa_node);
-	if (!storage->buf) {
-		bpf_map_uncharge_memlock(map, pages);
-		kfree(storage);
-		return ERR_PTR(-ENOMEM);
+	flags = __GFP_ZERO | GFP_USER;
+
+	if (stype == BPF_CGROUP_STORAGE_SHARED) {
+		storage->buf = kmalloc_node(size, flags, map->numa_node);
+		if (!storage->buf)
+			goto enomem;
+	} else {
+		storage->percpu_buf = __alloc_percpu_gfp(size, 8, flags);
+		if (!storage->percpu_buf)
+			goto enomem;
 	}
 
 	storage->map = (struct bpf_cgroup_storage_map *)map;
 
 	return storage;
+
+enomem:
+	bpf_map_uncharge_memlock(map, pages);
+	kfree(storage);
+	return ERR_PTR(-ENOMEM);
+}
+
+static void free_cgroup_storage_rcu(struct rcu_head *rcu)
+{
+	struct bpf_cgroup_storage *storage =
+		container_of(rcu, struct bpf_cgroup_storage, rcu);
+
+	kfree(storage->buf);
+	kfree(storage);
+}
+
+static void free_percpu_cgroup_storage_rcu(struct rcu_head *rcu)
+{
+	struct bpf_cgroup_storage *storage =
+		container_of(rcu, struct bpf_cgroup_storage, rcu);
+
+	free_percpu(storage->percpu_buf);
+	kfree(storage);
 }
 
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
 {
-	u32 pages;
+	enum bpf_cgroup_storage_type stype;
 	struct bpf_map *map;
+	u32 pages;
 
 	if (!storage)
 		return;
 
 	map = &storage->map->map;
-	pages = round_up(sizeof(struct bpf_cgroup_storage) +
-			 sizeof(struct bpf_storage_buffer) +
-			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	stype = cgroup_storage_type(map);
+	if (stype == BPF_CGROUP_STORAGE_SHARED)
+		pages = round_up(sizeof(struct bpf_cgroup_storage) +
+				 sizeof(struct bpf_storage_buffer) +
+				 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	else
+		pages = round_up(round_up(map->value_size, 8) *
+				 num_possible_cpus(),
+				 PAGE_SIZE) >> PAGE_SHIFT;
+
 	bpf_map_uncharge_memlock(map, pages);
 
-	kfree_rcu(storage->buf, rcu);
-	kfree_rcu(storage, rcu);
+	if (stype == BPF_CGROUP_STORAGE_SHARED)
+		call_rcu(&storage->rcu, free_cgroup_storage_rcu);
+	else
+		call_rcu(&storage->rcu, free_percpu_cgroup_storage_rcu);
 }
 
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8c91d2b41b1e..5742df21598c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -686,7 +686,8 @@ static int map_lookup_elem(union bpf_attr *attr)
 
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 		value_size = round_up(map->value_size, 8) * num_possible_cpus();
 	else if (IS_FD_MAP(map))
 		value_size = sizeof(u32);
@@ -705,6 +706,8 @@ static int map_lookup_elem(union bpf_attr *attr)
 		err = bpf_percpu_hash_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err = bpf_percpu_array_copy(map, key, value);
+	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
+		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		err = bpf_stackmap_copy(map, key, value);
 	} else if (IS_FD_ARRAY(map)) {
@@ -774,7 +777,8 @@ static int map_update_elem(union bpf_attr *attr)
 
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 		value_size = round_up(map->value_size, 8) * num_possible_cpus();
 	else
 		value_size = map->value_size;
@@ -809,6 +813,9 @@ static int map_update_elem(union bpf_attr *attr)
 		err = bpf_percpu_hash_update(map, key, value, attr->flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err = bpf_percpu_array_update(map, key, value, attr->flags);
+	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
+		err = bpf_percpu_cgroup_storage_update(map, key, value,
+						       attr->flags);
 	} else if (IS_FD_ARRAY(map)) {
 		rcu_read_lock();
 		err = bpf_fd_array_map_update_elem(map, f.file, key, value,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e75f36de91d6..d94073deb68a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2074,6 +2074,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 			goto error;
 		break;
 	case BPF_MAP_TYPE_CGROUP_STORAGE:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		if (func_id != BPF_FUNC_get_local_storage)
 			goto error;
 		break;
@@ -2164,7 +2165,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 			goto error;
 		break;
 	case BPF_FUNC_get_local_storage:
-		if (map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE)
+		if (map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
+		    map->map_type != BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 			goto error;
 		break;
 	case BPF_FUNC_sk_select_reuseport:
@@ -5049,6 +5051,12 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static bool bpf_map_is_cgroup_storage(struct bpf_map *map)
+{
+	return (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE ||
+		map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+}
+
 /* look for pseudo eBPF instructions that access map FDs and
  * replace them with actual map pointers
  */
@@ -5139,10 +5147,9 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 			}
 			env->used_maps[env->used_map_cnt++] = map;
 
-			if (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE &&
+			if (bpf_map_is_cgroup_storage(map) &&
 			    bpf_cgroup_storage_assign(env->prog, map)) {
-				verbose(env,
-					"only one cgroup storage is allowed\n");
+				verbose(env, "only one cgroup storage of each type is allowed\n");
 				fdput(f);
 				return -EBUSY;
 			}
-- 
2.17.1

