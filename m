Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749BFC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C5B20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O8wqw8AI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="a6dQvJ2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C5B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390177AbeG0XS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:18:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389962AbeG0XRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:21 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLiNix014649;
        Fri, 27 Jul 2018 14:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=sgGXbrdugL6eMOukXWx9gxCL3wfTYLV5Rg7NE3kE1z0=;
 b=O8wqw8AI6W0bVkes0jwAdfTL4sAKLzmKyLygK4TaEMXDRxsa7mNSS1EMCFZVSgFWGLUK
 QI6dKEUwSjYAx2wEHrMTM17VNNJMJbOfEyuqTYbcF4cpM0wnERSKFAmvkzInjCIVagvK
 oqVeiDCnBZpXAm+gCi4uGC7d3SkAIlvP8rk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb59g2nd-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:13 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgGXbrdugL6eMOukXWx9gxCL3wfTYLV5Rg7NE3kE1z0=;
 b=a6dQvJ2t57l0Q8KMYAqerAAd3zfTAtbmLDx/j4SXtCD/jKlcfMHMTDJFb0mZBltSC6ZjtDgb10ZVxrRmDp4zOsdySf+Q/vOV4ppM06N3Dngv5QIt6Y0HjASGsIWdYT3StS68OD7y/nriEXhHi+BcvbddFBuCSvwBr0dL14SIVPw=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:09 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 11/14] bpf/test_run: support cgroup local storage
Date:   Fri, 27 Jul 2018 14:52:40 -0700
Message-ID: <20180727215243.3850-12-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: a5baa641-7961-4b90-db27-08d5f40b57c0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:7oHEfIzE5sfthlYk7HUROmlNAZ7/gekm3SRZEgLWuoEUCf/PzRjrE9y1+pJjIBaBmM0T12J0ryL5O/9RktJOZBqxfu8PHn6oYXvdR74UZblxBPDKNP5H6GBGhcvGsL8oVZKNTi4vaIPIlihAofamE9NZdntBwjbDmIwQSLVYKk9mXLpANV3jLeVmAFKjXJcdIbA/Behoxk3f3ryzX9r8W/Co2konBKsi8lFCqfRbhYKgKJqoUnpkRKLIFuXwMlr2;25:rox9Fmwn88thuEbeCTzVJ85rEM8V/qs1vd6K4PYsNowwDxZoVJjMHEcWaq8LAYs0aECx4rHJqpCxaT9O33PbVcoZzn5OKKATbqtkLn9SwPofqgvVA4s6KASDafmRnqGE6IZMvzKYXXND7UrvC2zXHQ6UQd+DdR/ZgYUSDX9BFRRF5LJ26wVW/drgxMS9VWvPHjAOe/VWerT+kkK+th4hI8lUuo/6NGFHkafnn/sUMEgn8Etwj2LeOWNA5Hj+b0Fi2jXBa1gGVwg7Zow12RF9qZhknrAK6yu2ECEwLtM462TVSsvdkjx/UkJ1hexKKcbTKf/b47Yejsox9AfRrVk0MA==;31:BPcuCWLV3xYDb2Xd2QXtWsQMhtm+t9k39SMrsunbR8nGLTkmGgYkpbH4rTlY04CCaq9VfpfFwW5Ig9qCEN8wg0L2D0ytxK7ZswEKJg6i3LhA8ss5ZpInOQVTLQiJsRaEAnFCZntn85R6QWu0pJeRfJEYcPiPCfMzNWsSIWLjhHPihiovCJ1Kd2oD05KiKyrNtcdstzp10K6bz2cPY8snfDq3lJX/n6zCBln51XSRxuo=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:So/f9Y8QeY1ukeqicEPocMcz7QxWnlFcMhb1fnT0uxlhvnJ7KN594c19+fSD3NZNaTit+7/k4ANrn7G45DJq06n1E9+5y1ov3Z25Hn7C+kgFdd4dyBw+MpTLJG6gLVbZLRIAxQDoeCTuLKmnRv3dFciX9YbZPQhKRLymR2mtyYVBtxuOeoqmCrvwFNHl5niUg+LcZTryg92ynBqgp5+hqK5DgIVqU5B5M+PNy/pyiYr3NTZcdehe+xOhb14SXZHdJw4uz7Y2Fgo0JAtPaZEx0HR2XV/2qR1PIuzXup9N/kpfB3ulOeCuZ187au7qsN7+MX+GLhSXVWPlFD+DMupGAf9q7hC5QnaG6FmtH+w3qh/AyGXklQHJv6qUvMt4HVOcJwV7Gxc8DxZQz6NyQn6feCC3dJ4vKqH6TNERvLPizkfGa/iDzhp0Nvhh06taEe6ojX61pmOL2OMaIMxrDRFXjaRNSBoRxIaXoW7fPTi8j79CR9OQC4+DsDB5rhp8YR1z;4:z6Nsf3nZ7FtDEICAqP0obT0QVhUFJceKr4Ifrcy0WbsGL8s3oHeSZhH2B/vy396jQ2/cmukzWsg/oQUfq/L6BVRXeMtfKEKBIRdBTNK8FmlB2h+vdxHkge1hTTQzno+z7PTiWn/8uKfXECP+nlXsYdilJNrCsIO0ZgibsdOAR7FpPDeJbVKkmdpdHTu7V8M0+S/SJV6dHMyWpYbPDIs7S/uXt2qQmOl8sgwkNjHiKWcu3H/wuqfASrf7/xdbP7855osVnM7DijGN3c9jNxY+nqTX5OkqGIMwQ3ZevcxZJm0JmsaKgNmccwhpYPuVxjNx
X-Microsoft-Antispam-PRVS: <CY1PR15MB017179D474639A07055243F2BE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(5024004)(86362001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:J2uOsE0RvSVe1HSJqyIUsVPCwdvia0QiGRKggIdPf?=
 =?us-ascii?Q?inr3H8BK+2RWROKfIJaJsYXZTGGlI1PWq30+mBQtvkrYVKqHK4c+hTTEpHTN?=
 =?us-ascii?Q?oHN3qEaZMxZjEx9DFfoWdig3RK5r6pgGnYcXJcIR5mSC8JHjMDdoLoE+oGC+?=
 =?us-ascii?Q?nBpsBBbmkXH5Fmuu4jY1Wvx2MP4XZr9SFtT6b/QKVX877RnqHJrQdPMTZQ/P?=
 =?us-ascii?Q?7Xa+t5COt6Re5DCLIfL+PWDul/MtvdoPEXfZyMIUTBVXDN9J2ZSMzQNR4m29?=
 =?us-ascii?Q?NNV5neo7azC3zqkWr9CK/CkTmGwqN0HqtSPdlfl410ZDLM+bxmsx8LGk5GBX?=
 =?us-ascii?Q?W5vRNB/4jV1HpIkR1wIfbBKA8YBm6U4k+u8ZmOK1/q2WyYlYyGMxCFZh8rT1?=
 =?us-ascii?Q?qvdcj20F9i3QZ/NzOe745AqBoiZhgih+KUyq05y7UE8YLEPXhpT17lLu4c+w?=
 =?us-ascii?Q?G3PtKD0i7fl/c2V3xKOTR0UprVuJkcUAxZEUtd+/JiqI/zRDlGgj4wsaPUD8?=
 =?us-ascii?Q?goomlggNCYsEkqjhiAliteh66GbHzIRIT48KH/O0JbOyqOHLZlv48bV8sTGP?=
 =?us-ascii?Q?kVnOnntCIv4NMB5WneY0R1wqKpFAxIMwdvEq56UCgby+EKyZPKtdtj1eqsYJ?=
 =?us-ascii?Q?mmmuI0w0DuzSZSzSEMCWRyxSSeU8jY5gxUlViNxSVa7IMrFr7Jt3OIbcZ0sN?=
 =?us-ascii?Q?sXKx2/WCF4sUbm7DhsJTa2RPc0z2Sg5pOarFxQt8Aw35cZhZ4W8yseGh+A0X?=
 =?us-ascii?Q?nVfz4+EZ4sxaN1W+fo7CbL9RtEVp8009/0berTQXRo8cxljzTvdcZF0jT4ka?=
 =?us-ascii?Q?KZj26RuSuVvoclNkorlNaGNuC7tr3Zcb9Zv3tjKD+deEardkg4wTTd8AwAmv?=
 =?us-ascii?Q?KcngNdgxNr4rU092fBQRxL26XUu41MlQyIXLEz+ZNLS7+kHLMbepCBiwWlqx?=
 =?us-ascii?Q?KqhtHm5ptitPvtmG4xeY1pc9LmL9UQxDqaXUK8GIqbv+0Sn8szNxQu1z5aDC?=
 =?us-ascii?Q?a0OKm07YLleK/scUKZG2pZgEjLuvnNPEz8VgpwMSWJA+H4I72kYX/vUyRLlT?=
 =?us-ascii?Q?bOMPYM6VVSc6pOGN+iuUHzf9xE2ZNEyobh5UPgYNsPtuhBnoQmMqbtf8htjC?=
 =?us-ascii?Q?imAWRSisHPZmGxXYy+G3m+fz3e8TUWroiNDjHFu30AZc4srXgAcchuc1dZv9?=
 =?us-ascii?Q?VDOSXaRlHFbxXIH98/qFQBTg8dHqQO2Mno/OJ9bTNUtAJNdvK69pNE8aU4lP?=
 =?us-ascii?Q?yBavl5txYspN6sY1DZqjSzOtA+J2aLYPi8NkqGIKmZT2J3hG+GEXNqUMQM+f?=
 =?us-ascii?Q?LMSaM1q9YUhXhkl2P03N84=3D?=
X-Microsoft-Antispam-Message-Info: moCTTDeYQXWKjkN1sWI5Z4i5dftpiClc1hgkQBr3uXURlR+KezDDOh2SxX94YxxniN0ldPzwsrPtqlWFCqAn0iIDyxnUNaNsFyaMk5Z8fyE590iK2skX8TFo6RATd3MBnY04GBQsxHNOnZzIy9Jt8Y3y9nxmG5FPWs5Z1tJSwFp60u/eka/p+jqffTKe9mSC71gpG9XEpF6kbND4w7W9SKad/MFaOHsXwmY7FvWDmPaVNcEu9O3o+smVrQ/nwlejmtEau2HueWij26maeOInu5sFs+1AgYNyaqWAyaRDBsSiQEoGFqmARs61zAL2wHJlgpy4CNfqbuwpdHspzHDbs2Rdd+bBuGU444EC1sJBYac=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:xopxs2i668CmVusXNQf1625b9O3JEPUZqvGAfSK1uW9lbtRMctFdOIPK90eEthD1WiYyOh149ehK0WtsE291N4ghK22brUECPxqqpYZzKFlI75FQh1j9z0b+DKIkEapBkQ+45CcFyUMSAruurnTVZjLPTVWvKz7DX2G6dp1b3y3VtATKY2X112i9zHvNB+X4PjYoC4/AonDVyCN7dO2CPB8KGRdMVwjYVlUQkWb4g9NOlK1RM6vSZE/8d+iG4pdcmQNitQP8tNlgznB0Q3PklD4QNev0bC76BUzWc+33D3Jko0U4/DmnygBpUVQFAkTYkkuo0OpzTCaIepuOsTVwP4IlVdV6GqvUEo38U/69K7Txdh2GnC9iPZtHcyTrOIQvn29JhJFrF07ppV8KJx0pLlQGkuVJ9zBtFIULI/CXuna2w4RLIGpIhYOsSPZPYaJgpDVvSP4ZQ3V1TOpkDOHkWQ==;5:n2N23YdPlurfEy4Gacly9y4+ekU9EV81PORgIwKEMcmbACv+szuv2jDMvX5BsPPL14/Vc49ZgYbnfwPBiLCs/HmYaWJQ+damO8RYfLIXuhbhObbQuvfLgTUv8sfQFze0zbKchosjzlX2b9ubGVZ/kOBHL90vwY9Q5OUxlVNLAcI=;7:OdIs9100p3bqxtBcKM8BnM0TFSSCNy/5F/loPaRfDQ8xcj9tMZu9WUxt+oP0tdZEPCPpFyp1N7u8t9VmHj0p3Z8zYe6xt/vv+9RFPfjtNsyy/bwO8KwW0pdICvVEV13fZlwZVaGkY77uuTH1q/9n3R4pqhYHW/+Z2xfeW97Oax6CTpj1bn36l4jT5cITpED042ZDmeRlJzQ7gpSxKxsmPgVTPFPxiW9LC80Xm0X3BxLsJGOsc8HeidbCUdkeuDFA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:342TvEaeHRPF3rHEMi300Q289E4nNmLFE9ZiBrBCy9FjqMoxu3BB4x8JFmQQ6kF72mKv0z9ytVnZwIcvoYgN0yGxKJOZkhRB5ZR//zzQQvtbdo6vYCaMumbyWonX+gjGhiDTvTVqs0TP7mxjh38Lm4/ZSkQE8qUmEqrRg5wIvP4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:09.2434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5baa641-7961-4b90-db27-08d5f40b57c0
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

