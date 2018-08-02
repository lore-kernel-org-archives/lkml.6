Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9767C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E7D21581
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ebt4d599";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QamMpgLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E7D21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbeHBXWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:22:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49814 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbeHBXWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:22:53 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LSxYg015349;
        Thu, 2 Aug 2018 14:29:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=sgGXbrdugL6eMOukXWx9gxCL3wfTYLV5Rg7NE3kE1z0=;
 b=ebt4d59920SBKqe6jFkklMJ4b7k/E1lioPfKrVTrk2IY8MwANY0UMT/OfnDBFWtj6tcV
 K7zllhHa2uYY8XS5KZsJ5lzsTswiyvafz+XrzfyWTbsyh0q/3/4Iz4E2pzL+qu2lcntb
 a7O03o96FZjsVKgiCoiZ46rcQcbwWQif6t0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2km91w0510-9
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:29:35 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB15.TheFacebook.com (2620:10d:c081:35::27) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 2 Aug 2018 14:29:30 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgGXbrdugL6eMOukXWx9gxCL3wfTYLV5Rg7NE3kE1z0=;
 b=QamMpgLY1fnQ8TbEeOlmUtY34mFeumymUHqc9L/eKLJaBtWKjRLLVfuzICZoMimS4GTAXMrsONEEPG9gkgeEvMAXWumB5/Byv68RPZkE42eUD/QpGKm9a2Jc2Q8HA9iZ6eNkB0aTErHWMRPA4p3Jfpn59dFaafEDxOmjhxmN96w=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:28:05 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 11/14] bpf/test_run: support cgroup local storage
Date:   Thu, 2 Aug 2018 14:27:27 -0700
Message-ID: <20180802212730.18579-12-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5194fd2c-69b3-458d-d409-08d5f8bed649
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:W1rYLl8X8yYZ5MiNDThU3ku0M7eLkSH2P37GRaohfy5OG6O4IOsBI52DaFGEhw3RDkmjmZI0J4SyIwJ1lKpCn2tG90kQNfiJ5d+ixZEXF+EcbdzxSdo9r0NhED0kV4DvemQZpYxsIMNFiOOC2FEEv6zDBFKutkWSNbrAgddNWFot9jaZPXfkLXBmrOmQRnJcsyrRMlYxTRLM3P9auUfnNfvuj4MxyH6bkWvaB8pn3pdMWxfR8BV15cwky23LAnM3;25:2GoGLnlJCfMP0xI7YTc6KBbLiZfc3IKsSUhoalXNKlsEo/CJFnqpGryx50Si8/RzF7BLgNBNj2k56ClB6rLKleJyDZAjxTPtW6JqLrUSlb3s7vSmPEgqG+B3XIhJXsC+YkKF7gmZzKaInlFxOjxFbtr65ohPnUELxyZ7+NBB37H76jPHCIEGZ2FqB5W76LZDMO4KBBkWwvMGkIaCUzY/qFkMFt+X+ZxA6h3KRW5GAKMKBpHTuH+9jTAHL4NS+oVB4E9WAWQLiMtk+KuPdcfs5rhg3zEyjwrkm3eMmKbkd082dGNn4utXsnbvKxSJaEIxQP4x0opSCDSokGBqnlSG/Q==;31:pbMsEMv+2Ms2vZ7JW+ynklRDHyXQgSt9xmDQk2L1IJmt+w70RfRhzaNFk2/5KhmK/JR+IJzE59UlUnBi2+P+7RUUdtb/RQ7d6vl2FDCN0Ztdd2uT5MYoCsHL1aJXLNlYEXAR5uM7vPFYxRLPDMp1KV+2GADpa5NXezXDWI6YA3zX7Dpb05ZDvX1MHtUy8Wtel1KPyHHFJed3lX6ND71ktolKCXxIpaVtAoXq3OLMbq0=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:7Yr2mVTd0i9m+1mHYhEpl6C8TJ/RBXDqVwNbs4Qp/yKYRgOFkxJ8eMpwlAEjtl9FP4Kx3A1OCxWTcGtthx/dzvea4AxfGSle2yYNFiAVxhEzXfTbpI7Ihdq9yGOvngrCZthLAdSY81r1sR09cWxzGyqrNOY1kEgj0ETjxmeRUkGbNE/4VltAUTDWZYLda9tJRHPoXg/RbIamLRvNRRpxyZrGW0XMh1wkBkj20GE35iD2GWGIgr/a/gLyF3oGYJZRKNuzLDm8IKMvvcP6xjaiD0E7/ptSvDT8LA+WUhuICntcBD68mWpP2J1a5WtoXorWdmpKZrfDQCJ2BbUU1aEAOFoBog9KV+HIYPjRo9cHRKXhYtTm8hMH0FTzOF0L6zWLC2AnGRlzC4+dgRa3oAnML1sf4BJ+EP8hD4i2CkSgp9NoShonKZsc2It3yL1ROhMdTSxGz1xiCTfSqgrm2UqOq7gLhHpu2seE4pj1RsaT99N2l7jSo8KhUrKokRgesOpU;4:k8ocBboPWicrYP7lcfJAkSVIlir/0qUGuctIoP+uMHppgBKb9y7qApch+JlR2y0U568qsVAhDLSa0x6Vr51KSqW9lI3GAV5ZQbb/9Xry8Mx64UjKhJC8wwMq4xUpAil2GS7hloQPEhBydqfEWD/hJsB+d4dMY7I9lih89550FfeMQYfdGNpQw/FuOaZRA759oNLE0QpyDfNWA/1jIKQTfkecsTeWdAEVYy00sPbHPqDK9vIV/DTa4DG6l4c2Cq4xe/8/1rxMjZ4kpKxEOOXS8c6wH7avAGzrf2P1q9WFXZeNOAQ9Tuibnf9hAW2egQC8
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167B73B9296AEC2EC63F56FBE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(5024004)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:yLq94gcmrW23B04ZLvMkEAKLX8AgzJ7zE12S77iQ8?=
 =?us-ascii?Q?mhP1M418fIe0MHrIZytp9jIt/NE/DKN40ARkK+Df9S/i+qRG0rgHg7lHT00+?=
 =?us-ascii?Q?/LzJm4sNst9qrq5DpSrrySyyJh6iQBIzjoLzM9z8oATxXtBvj2UzkDrpJnzz?=
 =?us-ascii?Q?E0QAePvTSqpzc1mCfihTA48xzEj/CXsrOdwhCejqNtqWAUysho4YgeAcaZu1?=
 =?us-ascii?Q?BJo41hLeMTxo4fAZaSKqp9rMdo6JZ5mGeLvm22dbKgWBe+llCeT5pUZljsZL?=
 =?us-ascii?Q?8jHRQqLGpewEoZ0hCFxFnzGcgo1BUX27QgCqSJ3AdUD6Y/QngVdGpqK6x8Kx?=
 =?us-ascii?Q?aUyEDEUHAu3RWCQx/AMiR9QTdcfpee7f1kD79+KBME9g/h1rkEgOJReIfqOt?=
 =?us-ascii?Q?RDiOF8NDM6acBEUC8QtNu2s8vMXawez0ilV5WKAZA9j+d+NbYNsP1I0EkKc0?=
 =?us-ascii?Q?VKjeHhPg/O79E67LsbtMBQipEKDWtFEPCS+FwaeyYROa9j5X+vuuT1uUszGY?=
 =?us-ascii?Q?EIDPAnrcB/jHMvphc3COUeREI7/PgQnvDgtysge6ATESdCdwZc6U3EeyyLIh?=
 =?us-ascii?Q?ei5924OUEVS1xpx34vkZ3qPkMRt+BQUp2YSj/ppylzwn22z7n6gYbCll3P74?=
 =?us-ascii?Q?1bP9xgBtiXO0L2bayOlJ9HvUj4daXAd+K4rkavVYuAvmG7wIRt4UgYFc5zpF?=
 =?us-ascii?Q?Cxu7XFQAFVgsciMD1moTZRZ/wMYGUUvGXjYpNYov+eEFcjLxlrU7LSCuUY1D?=
 =?us-ascii?Q?sDpjZOr0Kj4rmhMJxBy87Sy4QaMzi34cP/SbuN9Ru1x00U4WPV4NChPKrKZ6?=
 =?us-ascii?Q?HQyKtKUZ3QFanDalJ80mDonvXRgXdYeqUc9BOKABRocjGZN++mgxoNuKxYzS?=
 =?us-ascii?Q?3bevEjB34QladXw7ztbb/LYPVh4Cuabdl0x+iK6/DNMlfcQV6tXh0WD6EDEg?=
 =?us-ascii?Q?QtKwCwmidGY+OScotLNRVSCnNuKbJL5+/x7R1essp+JIVdNrGUFmHhT9GF8r?=
 =?us-ascii?Q?ZYACFejLqiPSBBtt4Z9a4JaKwlPJ9NlukgsyvNTwcSK9CGYRe7iggkf8r8pO?=
 =?us-ascii?Q?lFuKs2WPfChmqZ7VYJi6LDn6bjmCco/Gj8EJfM/BkLbZrGF5mx5jI1rUV2W/?=
 =?us-ascii?Q?DnwNDHx7xQynoF2c2piPRbd6c9t4NpaAS2EfL0damzCGVEoIAUi18pR9a7uX?=
 =?us-ascii?Q?ifUx78TpTz4aZgIjIozZMmB2cEyf01J0BxAP96bsaUEr78HHp0SHa+O9vg4u?=
 =?us-ascii?Q?8iACTLRg/v963Adn4iaYhjAUDQtVdGFlzEjy01mMYQQpQhVZmfKKhhVv58Q2?=
 =?us-ascii?Q?Hhf6n6oz5YAfAp9tsm39JE=3D?=
X-Microsoft-Antispam-Message-Info: sn9y6gKfdkZE5iiXaBBQcIxN7s5PLNI3LxUMePDHOReQgmDQFBB3DQ5IvT4Tmqva1049ikk0CqkaG+QXFfgUXhbduTxTHCObtlhQJC4FlYgbXtsgNpd/mjQcUDSVbbZ+59bvcL3k3j5qIaV8p61XkRLv0+fPovYxwylA9mHQwcMJBOQba7T+JbOO2VxoPw8BqQvv0+aAYGhMkNiuqgFMvOAcM/AXN67+gM6SMha09/lSoWvacmil+F+520Urar8/g6V9/rBHXAakygGHkRN8WQ4zeFIzJ1rJXEgkT1vW3+sNdZY+Jo/mB/4nFYa25MkP8He94bxteqKP9AOF7DsY/it8AE7/CxA6lO8ZAmvvG10=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:qrI7hCZdYDTtcpypU7zzXw7Exk+1XhGe+h2JCaG6r5YfTzg9yvYplFEaUmRdH3714YxlFQqmL1XLjQIvCEFpSreoMtDmQuwxwKxIzTFBevvyiXOPJOpMeIid2Jyujz9Y/27jOLbB08OT8rQWOd7EMkqN5fnivvA9wRMUd6Ydj/dpZEcMpgAUUuphtwEQFO1B9noJOn0sR08AJLGXoHxC/HKyTh+KpV6m3vPLcx3c2sMknDBVkUERnpguxj7EtqTfnNoAhdEjiVq8SaxTttXgjTHoewF159Q3jwpZHtDVNqS14lPTDWJg4brNPI8/65H3w8M+ziUR9tPK4frsQvBWgveO0WvEO5Qxs6WHuxFQIs9MpUwQE/+h5bCHGRsOTS2B7pqJmPg1m8/iZV82/hmvg4eDmr46BXO2DOeJG7sBwNX394dojINoWCdWUI5PU1WnqpS9Z6lYELCoOiunnAV4FQ==;5:AL0u/Y8xqRaNo7yt1MWVR+paGe5E5T/GsSXzo7ERjWFvX7U+YTfh05Wl4shoeLQwWj4KqcWXihqH26XDCKAzZxmmD1ZEU5VFI2vpqB1ybMtkyHOfXoFdCJmgtfBsUJWRS3UVe7SUShd1AoTuAFpGfRpPEYW56cMjoYG9BRbN4fs=;7:X32bhX51nlY6KMlszuo5f/I9MUOPSw5Wj3oxSoKL8To5axS044rWUVtokbUn4tp+yvtU1ubpQFF582PPVo9JrpbF0zj/WZd17RkEPasqgiik44IOIWRkyDfzm1C08tGQpEBZX3byAkm4Oj4xey3pNwClwNEnuJpF59LQ8aEVSFhOSE7j4fcC6XEpwJ2YnwmRMxs53OZJh3CNKefg8LoJEE8p8cQtXE92gtMx1zGJELaw8Iiqwmza6NVBOj4rvKLZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:zJth/R9y7wBnj3eoKs29oJLzDfuZeCDzlinq8Dc55d6XEOHKCvVXTUN1Z+oYq7ZkgRGhBEOicV5AtGUkaEoX1TLvxyONkXbJhzEqEtRc1v7rqXWr3vYUZ2m8H3DY1Y3rqKTv42p8wPQMeigMtKfQhG9z70uY6o+fjo5cYqqaG1U=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:28:05.8844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5194fd2c-69b3-458d-d409-08d5f8bed649
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

Allocate a temporary cgroup storage to use for bpf program test runs.

Because the test program is not actually attached to a cgroup,
the storage is allocated manually just for the execution
of the bpf program.

If the program is executed multiple times, the storage is not zeroed
on each run, emulating multiple runs of the program, attached to
a real cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 net/bpf/test_run.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 22a78eedf4b1..f4078830ea50 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -11,12 +11,14 @@
 #include <linux/filter.h>
 #include <linux/sched/signal.h>
 
-static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx)
+static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx,
+					    struct bpf_cgroup_storage *storage)
 {
 	u32 ret;
 
 	preempt_disable();
 	rcu_read_lock();
+	bpf_cgroup_storage_set(storage);
 	ret = BPF_PROG_RUN(prog, ctx);
 	rcu_read_unlock();
 	preempt_enable();
@@ -26,14 +28,19 @@ static __always_inline u32 bpf_test_run_one(struct bpf_prog *prog, void *ctx)
 
 static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
 {
+	struct bpf_cgroup_storage *storage = NULL;
 	u64 time_start, time_spent = 0;
 	u32 ret = 0, i;
 
+	storage = bpf_cgroup_storage_alloc(prog);
+	if (IS_ERR(storage))
+		return PTR_ERR(storage);
+
 	if (!repeat)
 		repeat = 1;
 	time_start = ktime_get_ns();
 	for (i = 0; i < repeat; i++) {
-		ret = bpf_test_run_one(prog, ctx);
+		ret = bpf_test_run_one(prog, ctx, storage);
 		if (need_resched()) {
 			if (signal_pending(current))
 				break;
@@ -46,6 +53,8 @@ static u32 bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat, u32 *time)
 	do_div(time_spent, repeat);
 	*time = time_spent > U32_MAX ? U32_MAX : (u32)time_spent;
 
+	bpf_cgroup_storage_free(storage);
+
 	return ret;
 }
 
-- 
2.14.4

