Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DD1C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557402172B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="VhM1zlIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557402172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbeHFL1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:27:25 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:36288 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727451AbeHFL1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:27:24 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BbkZ000812;
        Mon, 6 Aug 2018 04:17:45 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp0020.outbound.protection.outlook.com [216.32.180.20])
        by mx0b-00010702.pphosted.com with ESMTP id 2kn9y5kk7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWBHa4zw0JpJgxzH841a0G7zMj00+WrRkmRlWIH+D78=;
 b=VhM1zlIsWA/fQlRD7pNCz6JXX/1ejf+FEOwjeePWO0E0LHV2083iJhK3dt2z+U0W/4mhjuFday2V2WTg2cpQkjkhfSzQm3weD7eETF+KLG7j6BJozh3u2EAk2CTpL31de0l1zcBTbpoeLL9Nw7sDqtx61zis5KiQWRJMdWcsKdc=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 BN6PR04MB0965.namprd04.prod.outlook.com (2603:10b6:405:43::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Mon, 6 Aug 2018 09:17:41 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id B50B8302CAB; Mon,  6 Aug 2018 04:17:38 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        dvhart@infradead.org, stable@vger.kernel.org
Subject: [PATCH RT 01/22] futex: Fix pi_state->owner serialization
Date:   Mon,  6 Aug 2018 04:17:17 -0500
Message-Id: <43d23e5c64e32c64e18559ef810157700bf3eac4.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: DM5PR10CA0006.namprd10.prod.outlook.com (2603:10b6:4:2::16)
 To BN6PR04MB0965.namprd04.prod.outlook.com (2603:10b6:405:43::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7ee002a-3289-4c56-b221-08d5fb7d7682
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0965;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0965;3:smClniS2vtc1hUVzanLq5YC6K6HREGcvaDEpjMm6IG15dqZqWZQx9HXjO/HGd4YbWOZOV9iw1YAipwbdfwpIesX5FanRvYwlb+ADm6IRDAGDpGJqFBFvPjVIpZYReFkKkdqzUSDb2sRpSXSfMlPMgn9xQyGz0aC0H69Ne7+4rA8M8rs808qtmXC8eW2leebvngSEMSQaPDB2vI2eOK4Ud/Ov6D84mXt8ryBQM5fCBTSUm0C4M0qFwyRsHtkjd7gD;25:N0DUA1s+DPKQtRZBJXnsXLP+ZqVonuYyimV0cxJHpL8PmB2QDQwnEnLoCl4CNbi7rRRwctX0spxSUJCgtnuXU3aKrL29k/2MFiSwYFEF/i6YD1Gh92tujlgTVas4g685EtpwHpmEawpflGZDy8pvylxjrYMEkIOxN5qDYgveB06k+3piZj6XR1VKlLz+xqQY6MVtFKihLenBfB5Ra1X7SPIkiTsuaAWb1Ij9yBwT5JcHvKLPAbi/5JyzWHM+gGwUY/bRcQhrSQbGUBiLoj0Nyx8sY4rqPMOx4oZxI0FXSNmysla7fOc7bAD1YXh9agXAyT3VxaQqmjn711Tj7zDhBg==;31:O9bhPjPratt+sVdCfV3Gqs9j1A9XGMljtwaZUBqa4cry66VYKdz++7cpjuViLtnEUUYuhmSb8HbVFXMJbWW2bhnPNua+wvY/+bw7wLmKf5rVQFsYhZM6zswQoFSg5ZI7zMFRdJvN0jV0uQaYW+NpTPz1C65LrRtG+/FJlZG0wwfnMUOiiko65wicrbRe7GTKJvA/g3VO+zDhFL8HRGIHwaeV1C0cutrF9cn8+DUcEPo=
X-MS-TrafficTypeDiagnostic: BN6PR04MB0965:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0965;20:RnPeQM4+wH4OyNwkOg6hwyTXM1edg6Hzt7St1VZ5nmsr7NUXiJjyuQR0NkmcWyHHsO1t0HFGC2YWq6V+cWMkzE02wApP8ma0msB40ZXL4e1jB1vktxtRO7p53qDfgK6t4E0OFfpHZooqSDG1QnBvdE30jyEJ48vT5MU31hmfNmYds1cf1K7VRenzstZuwlkJxpaJszQw+Snetg5Zz4beLVlrED1dl6yyV6TXi10o/Ss6vmSxdpnIcSnD8SxteHb/7jMxAU9gACJXmUkeZjht43JtYk7+ToDoMqpImAMWhvwKoBY6hdTBmIRerSY3/FIYw0Wn0gF7jSUeDBa/puTnQHAR05FPBs8w8pOnAyg/EdcG+HrVVhDvv8xT1MnlK6Q2MoTtZTCusYUklvElpqXdsQN+E1vRzifv2moaVmqidlMma56ZIDjy/gke1fmNisBjKVDVLlOgUiCqirTrldtTge00l5tbLEAfdio4dyURisHmk3XpS+n37VwQoQA+Ehdo+NX92akuASvIcjE30rJkrWkfo7hYSg/Cm37oxFF84nT/S/hGYI69xwr+QQJ8rmJF4wIE4yuCxiamv9vkJjmMwejxBUMIwlOB6PZ/6QiRE6I=
X-Microsoft-Antispam-PRVS: <BN6PR04MB0965A9012973336E7C0F2DC5F4200@BN6PR04MB0965.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(42068640409301)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR04MB0965;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB0965;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0965;4:eAc2dRhjxwXQ7hUiThAIB24jOxI9kB+DZBtcoE2H9oAlm/O54KyT48EJs4gq2Uji/l8AJTRE4rWlYu9qbavHXA76FqXJU/K+91qN5mNPnK6S6W6qgHLCubFJzdLCNxMePjkfMgiWErb/EMWTJtr/N9J+uHI3g2MJhPH28ILq5dGRSjaQv9YeiosfHsfmg2q/i8unX03IRStyLKsD0MLW1T0IA8+cORgCmgp95gw5Q5LpL1Ej0BPu8xBrqF9He55NTE3/GRXaALxcJI38uOFIkSdwFEflHOE3MuGnOQQUh8tWEpFEY1gtGxCmw9zFsDSi4A73/1y8oO/tCCuuUhh9AwfDbcNS9O+JYQt+dsS3cITz8LEAQlhmUNsEKzeR7kTk
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(346002)(136003)(376002)(189003)(199004)(76176011)(5660300001)(54906003)(14444005)(8936002)(66066001)(50226002)(575784001)(5024004)(386003)(118296001)(50466002)(97736004)(51416003)(476003)(7416002)(16586007)(186003)(42186006)(316002)(26005)(52116002)(90966002)(446003)(486006)(11346002)(52956003)(2616005)(6116002)(81156014)(7736002)(305945005)(3846002)(48376002)(478600001)(81166006)(8676002)(47776003)(105586002)(106356001)(122856001)(6666003)(68736007)(6306002)(4326008)(36756003)(6266002)(2906002)(53936002)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0965;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR04MB0965;23:RaZ0woQX+8j2kd9EhLMSWJbPOEyITOXgPWzKkOyUC?=
 =?us-ascii?Q?zrIAJTR4xMJL4cYzt2SAYCGk2PD42BL5qlM0DIDS6E3V3YmGoT6ICXz7wJE1?=
 =?us-ascii?Q?/7/buMdPhPwomst4aOtpW5G9WNHljrr49zTU6t00xIRE847I48DG5/jJSuqo?=
 =?us-ascii?Q?Kr8dr5YzoMtCaXMLHqPMC1TJWxUznWt9FOPtOWyuZ4TMGwQ7qzzSATKeokYj?=
 =?us-ascii?Q?k7cTzlbdi/RX7ijKCScB8wQOncRliUmSD1Q9FMOFI3kfKai+qLUs2hlZDtrU?=
 =?us-ascii?Q?weTtrBnCtbuf015chY3+DgRnwV1+kvH5UyOOcpxlbE6VM7cSTOJw+uwBwGGW?=
 =?us-ascii?Q?FdeSPN1x9ZhmKeBVcdILSGZzsLcfDxNr98Lb3+obfcNizOH0vWaT4cHMxiPx?=
 =?us-ascii?Q?zmTFXVWALe6wM3SWGGsBBzTyFrYCR2RRvMHcdNV6RHv+IOxjd3b2mSNG4Bm6?=
 =?us-ascii?Q?Y0gkCsQbubZeWpcggM6meNKS8KwjL7hEbsTXw9V5JN+2em0/wX3gYBILW8Sc?=
 =?us-ascii?Q?AkcMLG3pO4fZz972df65kXTcMFh6jUTugHmFZ5gvXTx/qoIJMYaymndtZXr/?=
 =?us-ascii?Q?SFeT4anH8u/w7Ba0tMHtXvBJiwRrm2KcpI8iuopX21wad6DUz3PgYXFsXbNT?=
 =?us-ascii?Q?lcOVfC/Vmm/mRJu2DAfBb/kqRG0Ted+Bcun/h+LXqQf+mjp9Zrto5871UaVJ?=
 =?us-ascii?Q?WzBrxUS/iIL2n9ufAX+ALY0d7dIPxPugo5itly2X/Aay3KQAb8ubqOAGDpLG?=
 =?us-ascii?Q?FU7NsMYoRLo+oByg5BRzgmkag1wDxp13xCgkYHGnHbJpgh3v2U6baN7HQ19i?=
 =?us-ascii?Q?EMyAnuJ3SuM1kcbp8dOj/zIV6E7gtrJzEW1SPgFohK2WGjfNpPVjmUbGeWoC?=
 =?us-ascii?Q?sKncqaBJ66i1SV28nNiWrUYWwsavwbpnB/YaX4pwYzvJ+eZcZS+sfHLcUZt8?=
 =?us-ascii?Q?qY+bfjfIGiIVOzlc0ruHNBarglmf49prETjcgWfcEcurqLgVWxr6TizLnMY/?=
 =?us-ascii?Q?yhOj+wLbgeYMa7DulBYG3s0MoO7Ldlb9878z+zJ7kw/CksJdSDNWQTuZwfUI?=
 =?us-ascii?Q?Xnn1smerV9MPumFVip/NBS3MqEi/i9nVlfDM82mQ4dg9utki2Ope/QkR7LTD?=
 =?us-ascii?Q?U21+rMOAIRUz/5t/NXGpcFNtrRzEk+CNWES5tvDgGU3MwhsnJVvkcxxRy5JW?=
 =?us-ascii?Q?EdfOFFrklKAR67lC6Yv54Hj3AYbjuf1LR5TxNO7xGX/t7DRex7C+3ow5LKtG?=
 =?us-ascii?Q?q+UIpEWWOX4WRIzStlKmx9pWr+Sp/MeuB59AoKF?=
X-Microsoft-Antispam-Message-Info: HiGPIAuu1GT3dn4nj6Rv5jh+MpfD8e1Tq32CQqyNRmoASB/mrK7zpLiwg+leDDw/qfu9IEtuPKQa4tNRPp9XHInrd8B3cBKFV+P4/nLu4fa3Nwq+x9sdXVKe/bj+JXoY0Eyc2vX90FySvSfNDjyGPYdu3s5S1iGDwr+7A6OKF8KmWdVv0mjtuYuS40cpGPmjUyIUSA4f4BLFhx/3OSLuy8CyoddUblBtfzzimKQeh+t9bN8kZFJM1nad0Il+my0anKmJ9IYXQXlADzG8vwHmBWVD7R07eO8hQm0heCiw4tE6cGE6SSGlp79XrCdOm3+FWQnvWmdBt92oAuF33WYCNYeiMPeRrwVpdTZ1gJwZo8c=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0965;6:KgAAo1pvWN4Pi8Xh2eCBV0kEJA5NuuVc9DkfhPPIwShM2pvcbkoNOG4a2ptw7Ko3bPzUcoqmnVBNpW9TtRx0hc5ryMZ/m7AYR6yvT+u0ye6uPJC6gLDite8zbbIaHTXa+0IAW1SkwFu5GigIaOpXvEX+/lJHfjj5vG31r1XHPrpuOiS0/eJ5tyWqYQcfowftbc6PRvRpt/zPcIlqcrl60ZC9wQf7WS2+7ft0meOG+F1vSCUzz36NRDUmOpzDPSALFMLx/jtBSMO0d/yf6eP+gixEw7zGpuOdSuyIljfhZ3xvMzKG6Zmx+JGUTaru4nwHwSGAnqBI2W8yDwQxfLu/u8FuQ1ftbFVHxpd4/rpyxhiBZlvWrkGWVVNnZ11+JLKOl4vLM0sdBJNbXKu6B8EIbf3YHNQVS5VRqkPerOWaHL1s/N9afn6dtWfD7vqybfe0XFf5o7ZuoZ4Ep1/XBoKOsQ==;5:uhG6pGD3o2EG9Zj2dH3M6A3WT6x/7JA7HpW/E9/nG/WJUQlEUzmqhGwJfUdxORbkOr8FUflTNrEJkZRJzUdUabMQ9lfvupQEX9vnFLlD1CitkdUpH7mNa8MJmF7/SN1spOnuOEAMf0RmNhE2nd5zgY7yRtlSZ6mOr3T1yJAMBP4=;7:zvmNRB7QgDFZxWs+GtxrCCLnuRmp4ei6dzG2YwzerEbAa0GHawQ2DVpgmvF1TrPbCQlIoBtZnjvhEkEYFHgF5zeLoqiuqPpLOKVqafLn4U82P3jNLwMaySc2qGKth6E5kXywW5G1g2GJx54DN4zLKS6hWdGJ5xerSQGrvlQ+6hUCdFahW09VHVn8hNg8b7E/EWs/OqNIxW70QqHJpz3+y0Hrb0ohbTfXtMfhsvStUQOyXXHlXRWIrz9lzGuSFWpm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:41.9928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ee002a-3289-4c56-b221-08d5fb7d7682
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0965
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
[ Upstream commit c74aef2d06a9f59cece89093eecc552933cba72a ]

There was a reported suspicion about a race between exit_pi_state_list()
and put_pi_state(). The same report mentioned the comment with
put_pi_state() said it should be called with hb->lock held, and it no
longer is in all places.

As it turns out, the pi_state->owner serialization is indeed broken. As per
the new rules:

  734009e96d19 ("futex: Change locking rules")

pi_state->owner should be serialized by pi_state->pi_mutex.wait_lock.
For the sites setting pi_state->owner we already hold wait_lock (where
required) but exit_pi_state_list() and put_pi_state() were not and
raced on clearing it.

Fixes: 734009e96d19 ("futex: Change locking rules")
Reported-by: Gratian Crisan <gratian.crisan@ni.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dvhart@infradead.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20170922154806.jd3ffltfk24m4o4y@hirez.programming.kicks-ass.net
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/futex.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 8ab0ddd4cf8f..47e42faad6c5 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -819,8 +819,6 @@ static void get_pi_state(struct futex_pi_state *pi_state)
 /*
  * Drops a reference to the pi_state object and frees or caches it
  * when the last reference is gone.
- *
- * Must be called with the hb lock held.
  */
 static void put_pi_state(struct futex_pi_state *pi_state)
 {
@@ -835,16 +833,22 @@ static void put_pi_state(struct futex_pi_state *pi_state)
 	 * and has cleaned up the pi_state already
 	 */
 	if (pi_state->owner) {
-		raw_spin_lock_irq(&pi_state->owner->pi_lock);
-		list_del_init(&pi_state->list);
-		raw_spin_unlock_irq(&pi_state->owner->pi_lock);
+		struct task_struct *owner;
 
-		rt_mutex_proxy_unlock(&pi_state->pi_mutex, pi_state->owner);
+		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+		owner = pi_state->owner;
+		if (owner) {
+			raw_spin_lock(&owner->pi_lock);
+			list_del_init(&pi_state->list);
+			raw_spin_unlock(&owner->pi_lock);
+		}
+		rt_mutex_proxy_unlock(&pi_state->pi_mutex, owner);
+		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	}
 
-	if (current->pi_state_cache)
+	if (current->pi_state_cache) {
 		kfree(pi_state);
-	else {
+	} else {
 		/*
 		 * pi_state->list is already empty.
 		 * clear pi_state->owner.
@@ -903,14 +907,15 @@ void exit_pi_state_list(struct task_struct *curr)
 		raw_spin_unlock_irq(&curr->pi_lock);
 
 		spin_lock(&hb->lock);
-
-		raw_spin_lock_irq(&curr->pi_lock);
+		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+		raw_spin_lock(&curr->pi_lock);
 		/*
 		 * We dropped the pi-lock, so re-check whether this
 		 * task still owns the PI-state:
 		 */
 		if (head->next != next) {
-			raw_spin_unlock_irq(&curr->pi_lock);
+			raw_spin_unlock(&curr->pi_lock);
+			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 			spin_unlock(&hb->lock);
 			raw_spin_lock_irq(&curr->pi_lock);
 			continue;
@@ -920,9 +925,10 @@ void exit_pi_state_list(struct task_struct *curr)
 		WARN_ON(list_empty(&pi_state->list));
 		list_del_init(&pi_state->list);
 		pi_state->owner = NULL;
-		raw_spin_unlock_irq(&curr->pi_lock);
+		raw_spin_unlock(&curr->pi_lock);
 
 		get_pi_state(pi_state);
+		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 		spin_unlock(&hb->lock);
 
 		rt_mutex_futex_unlock(&pi_state->pi_mutex);
@@ -1204,6 +1210,10 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
 
 	WARN_ON(!list_empty(&pi_state->list));
 	list_add(&pi_state->list, &p->pi_state_list);
+	/*
+	 * Assignment without holding pi_state->pi_mutex.wait_lock is safe
+	 * because there is no concurrency as the object is not published yet.
+	 */
 	pi_state->owner = p;
 	raw_spin_unlock_irq(&p->pi_lock);
 
-- 
2.18.0

