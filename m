Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6A6C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314CE2172B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="J7IkKvSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314CE2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbeHFL1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:27:13 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:36580 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727451AbeHFL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:27:12 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BFKt008035;
        Mon, 6 Aug 2018 04:17:47 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp0020.outbound.protection.outlook.com [216.32.180.20])
        by mx0b-00010702.pphosted.com with ESMTP id 2kn93xbp4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxrucYTxbB2PY8+gsCWLHBwoZET2kgZGL9xzmXHVing=;
 b=J7IkKvSU1xrEmG2XMugL+sLg7PRl119QMvuT4vc5C/vzg5cyqa4/gOeGlZuffzNF1U+vAV3d/ZplzxRXvmqDz/vRCOId6mfK6kW6uNxLTAy8HebIlW3HjmU3RPqP2FcOqMr+uWHNiWeW+NBrpbJ9Q7IIlvclpssuGXkjMKvJIq4=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 BN6PR04MB0963.namprd04.prod.outlook.com (2603:10b6:405:43::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Mon, 6 Aug 2018 09:17:46 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id 0CAB3302F5F; Mon,  6 Aug 2018 04:17:39 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
Subject: [PATCH RT 13/22] net: use task_struct instead of CPU number as the queue owner on -RT
Date:   Mon,  6 Aug 2018 04:17:29 -0500
Message-Id: <3e1cac93740464869248669c4f10a68773844243.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: CY4PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:910:4f::20) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b7970d7-2aa4-4255-57e6-08d5fb7d7907
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0963;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;3:ILj17mMxegoWsmcjfj3OtlzvQevYgyUYAsk56sZBZiMEsvo6pHek4LJPaqp05qCNJC+c/w42+NLIjZ8WYvYEQb0BdGAnooIM6krY7X6jezWAB8SBpa0vrwyi1OYIAZnrCmzIzwiFzsflw5sGgwcauhiZtSXJoDS5+0WvijZKfIvNmEsUrCUvUWydbEqWYaUVd9QeaVi5hy4jcZ5IbvuBN5z2DwDikUMXLcGZWrpEWWY+btogog70oG3RIwUEEZzh;25:/2byzTSDriN7p+2zgIIHmcJfHKeDpXkbJ+afaf3xNUxwbnxSBemg8MC9ITxxoAMtd9qEYmnLhokG/kZ+m89KUadppg0rZbXTDOoJvVsTJFgp+Ge0f4jbHUMc3sZjTiage5PvtVALtL/Hmnglmc/K/pp1O/B3QY7ZQpuiThkzZpMIDAjZonifuM8pK8g5CrRCUvJhwGbjcHJ/IsgNCH+KBILuVv1eJNY3bYe8RWDTYJjgwJNDNrCcDYx7aAMW4tihyXhMbZ09YHx4ldYPgOq5Ug6Ez6SXHBzfh1937WTsA+f98JreCh3nX27X5eA6ty4mZ7k+rHZ1Tr4bSy9wIIr+5w==;31:RUxB/XIpHOuBdD7X+HgLVcQOD3QvAklN70NG9ImQwH4acwMqIPndHDAsfS9uP5oN/M9WIGUooA33GXMXsRluAkYNpcv+XxxQ9ST3CMIxclx/1q5Ghy4oRnabORT0CTzE1DDCf3HG1Xg3TW1hEYgmIs85X3USYUxR3cllBKDzY4b+bsW06s+e0RhHKMaHWkhwT04XOgiLLNDNdhSIPHtrGOQMlZo5vaoZSFcLhik9+ro=
X-MS-TrafficTypeDiagnostic: BN6PR04MB0963:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;20:VRG4Wyri+0wDGlbaA/NqV5YLA8m7dcRgXHMEEGv5j74fBl3xe7Ycjp1ku/7mBBx3jkAW5VybO8pIQT23FHTBRdQHsQUv6Rqb6MVVLDSPFyzWajdrn6oTXNowMhtZ9i8QAuRqiJpJJLtLtG6oiE69VPbM3CkCL1S1+JPy4oRV8Od16/Yf82GSQczha/oZAzpFQpPd9OYwH6qmpP03pdRIRzDVRF1YVy3OFl/HHFo69+9pBcBDsYjB6Tit4wDOikrUqoEtQeAc/Iwd2Ypc/bJKlp233nKDURbFBnuBquKVhgjQdFtMr+O8LrJnd6QyRjKMmQa4lzP9PVkKaITjahl3243nEN1wT0BObTiM2b0elc2mUrBnX/hVGE9ALt7gctcvw/4nvJhS49FSvT9LcRMW8tW9ltWk+lTg38gWBqnhudWchxoqPc+ZtBjo1nEKrv5GkGvccRr7zvkI9cVQWwmFb+GFpZjQNqfxQMmPZeCIuSG5ETXwJ4srW/33zlcQlg/gVs4qTcrzx3KOzs/A+rElGcDrtmOQhsGfFk8HIAdaEowVB4iETgk9Tqf9wFXjDzZoQeL5jYUA75deD1FsV8a8NkrcCGJaRLgBSU6LlZ38mMQ=
X-Microsoft-Antispam-PRVS: <BN6PR04MB096332FE3E59865B253DBA36F4200@BN6PR04MB0963.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR04MB0963;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB0963;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;4:kKUAsxjHHCBy0MN5soMv/zxhv5GQUyVeWHTUD9Zl6uTkCR8xvk10iYXuIiOZJVjoQKLYxDCQzJVd5TRBEJUK7ZJn775aCvDpAhTfmt0vVDm2oNb3RmmsJLLB/jypbLpOkNdt5fI5l+N1xlthDFNuNwF+kabEVQgs6uyFbyi8A0GbFP3aSWXKJyXPR6qkqqyXRr1Q3XMGJ6PKqeJI5FzKflPf+h3LmU2RBOY85Y922BSEEu5ia7ITVpmg8CkbryGKy9FB0IW2afbDY18Er6Whp7U6R907Nh6rkv4Dwhm1pHABObMNB9KbWQ3FQiRdVZaFBxrFcIP17y2cc/MNT22rd2p2T6JWxyPP2rsnGsLVS6w=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39850400004)(396003)(199004)(189003)(305945005)(6116002)(76176011)(2906002)(186003)(97736004)(7736002)(50466002)(48376002)(52116002)(51416003)(81166006)(26005)(478600001)(36756003)(8676002)(81156014)(122856001)(3846002)(316002)(106356001)(53936002)(16586007)(105586002)(6666003)(42186006)(52956003)(7416002)(68736007)(66066001)(47776003)(6266002)(14444005)(118296001)(11346002)(5660300001)(4326008)(50226002)(446003)(2616005)(386003)(476003)(486006)(8936002)(90966002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0963;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR04MB0963;23:Nnx0sQldbi/eH0zsoK+k2llsTWJqNvvdmm5RgL4ab?=
 =?us-ascii?Q?eEnLYKAzoQ+bw03Evis5mYpzbrF9+LhsgeEoifDfitSNysgzKHpgdW34z6+e?=
 =?us-ascii?Q?SJNSI52nhlN8Per83cAl4QhzZARY3FQ/l+RRICHfsiLxcGplOduLk1ysFWMT?=
 =?us-ascii?Q?x4ULyurQ95q7l7DQ0ysW6RnmzqiuvXK+H14WQnbmTT7hcVlpvpAI0x4uOlAZ?=
 =?us-ascii?Q?x84LIEsSm7k6uEeMHSTcYr7syKio69MendvORUE6ShCEgHLSl6j6UYMBQmjU?=
 =?us-ascii?Q?+n3PTBry4SrQwWPeiUE7ZaSZpk9NLQnhYql2zRvo1KWVUM6iQABaSdFhi2Zu?=
 =?us-ascii?Q?RzqIJ3cUKsrGW3Yaa/bcgncX5+CYLvmMjJaFSZHg3srrM0L9eFQuVhJj38Fm?=
 =?us-ascii?Q?oQlTTqoZFvYzNMBOKh0GmifiLHV/H3vqiU43yhyiK5vWQcIJnGBrQdwfEX2s?=
 =?us-ascii?Q?tzWQVW3jFL78KY8Uhog3HdZPZ7XaOHmYjQBrTiRhVxoSle/Wwi56fCUIyLqg?=
 =?us-ascii?Q?2JxkF4fghffxq9XIpHd2vciyybTaU3CcHXR1COwWHT6mB/U0GwMjCK2Tc9Uj?=
 =?us-ascii?Q?vHBcMA/AcGplayxH0HJRThHwNYq3Lcjpuw3nCC36cL5DntPdI4PWeNyCPWnv?=
 =?us-ascii?Q?CiK1B+bP1wtoCWx3N8KIfLIMA/LsGy28t9BZutCGa9mpqRuaY42dHT8pbguN?=
 =?us-ascii?Q?L3shljsNteyAQw0ygecAbMy2s89zZBKAeXPuL0knxYsN7IDnTNmaWnFWOyeH?=
 =?us-ascii?Q?rFw8ku7ndqH6OqxPkE/QtWLeuqS0OG5KnLpHpTuUH40eaCfXIg5er/B+BWvv?=
 =?us-ascii?Q?k3W8vKaRq6ll86sIOQxDaOOwzmCdJOLexp67wx2RmsKtIDyBY+1nuwFAUXzX?=
 =?us-ascii?Q?sStqm2kMdE0LoBaWpl+tKCcVvKe9QGJ7iyP+/OMd4O/IlQETrpJiYjRB4+hH?=
 =?us-ascii?Q?fH2J1x1HlLhPEr7FGcG1TScTpp+YCtObThh2+OIeV4OO6vpv1KE+dhzDN/av?=
 =?us-ascii?Q?T6AeFWeW89fvi5aGP0s3wdXh/fWRiDKCMxyzMI/1YVbgpIcwW84cBmVhh2Iz?=
 =?us-ascii?Q?tUTYaFwBAu1bX7PksIWrKPlFeDUigz3pxWTsDh6jEHGFZNLnDJjbu/VfpyBX?=
 =?us-ascii?Q?KOLchQA1BU0ZMSI3j6LElPQBAXCdwkALFbZgQkcz2rN2coUKT1lMvKi2i+GF?=
 =?us-ascii?Q?uvKCWgxmXI4d2iYs8/8st5zg931psEXMCDz?=
X-Microsoft-Antispam-Message-Info: dVkmnT9WfR8YDrSPvWAxp8TS6ggfxHIzLGVCXhYUj0ZJ+WugC3nX1k3Pckyx0OscEFcomIJPAwKuOYszxuAIb3xpqCRsQ8veHe2j0O82196aJ7x8ElBgUluS1/9xXXMq0Usty8tYBa7axvaH27YINN53HdNFPjzXfdnC8pRmDtWVikgBi2MElYDZXCCfisw6SFkaBruyTlsiTyXaMsEVuE1thi+4KNurd2CIGGAX1UAT92JnuRw0puTKW9MJHKQnq306uNXXSKUSoXYLTzeT8x5Ya7VyszT4h8AMkXYUWY5BGkeyVjL4jN4uI5NOyVkWbPKFGkLDT1PUdMV4lTtVuZHq4cvW9ehQa4epn9o9NtA=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;6:Ed2aIMBt06o5cBZFIgieAnH/jv7Ac7zuv9qBiK7yqStON53C1kTKcHidi8Zsvl8oSfQArHs4R51j12xNXkHwOXW+dKahqaEN1bZZmYegR4Zk8i5uh5K7ODCOBZv79SPaHOPXY9BsBYUbMHqBoBxY1UzTVhGsSzWXdoYbqt4eMgr6MasBeIRK8/WdS9CfInxTinAn7y4RXLnbE3kMOPAEmYcqI7q1thuuxg/nDC2I7yHDRugCtTzTa+r/9z/si3hEnX6yOH/C39gG7GSD5bdPeg9kOAXjW08Sw6pPLpChWZEdYxyvqlLRyVVJPqrl1zyap/rk0BJW+2AGVyPMRm4BCpH8DmqowE4m//rgdCoXJSKl/4DRgVArYlIJZ91sz0SnIn5AthdCTU0KDaeFQy/+P5SWdlEi0B59syva/Zzmok1tY1cDgoVfT+Nz+pE82NDL3KMph38KeU620uvXrOiUjA==;5:07laGhzfzUCKO9x2r3w6/MUOmGpiAIB+R0tPh0jL9M5Ih9wSYV7ntvr3WH986JqEDepT8PdFHtRfmihhMRxVjlp3AJMhWusA2D+9VDEtnOOVUq57SUfsQhdog65ana8J80HGAHtIjWm20fyEGg2A1QLG5TSSfuvPB+ujn9J3A/A=;7:GMAuyX38/qSz1CSnOcNPi4eTwshc3PhgIc6FlFIviV/nKJnHfZUpmW26BZkAmfJcaHcVlr+UBtphxR+SfKn3/6eLX2TZ6YjXLoUUpeR1gB4EXRGBySqaeSgipj6CzBG+vP0eiyWqNLoKg2t5D9QEEwNhTiaxA8zvjjREu3jWCPRatvl7PmkoyjEJHUapZUPCAGj4WRMe5vdYiZMuo3S56aNW5zB+Fq/OYr3FFvfAyDV7irYsS3hnek0x0iD7Xly4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:46.2020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7970d7-2aa4-4255-57e6-08d5fb7d7907
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0963
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
In commit ("net: move xmit_recursion to per-task variable on -RT") the
recursion level was changed to be per-task since we can get preempted in
BH on -RT. The lock owner should consequently be recorded as the task
that holds the lock and not the CPU. Otherwise we trigger the "Dead loop
on virtual device" warning on SMP systems.

Cc: stable-rt@vger.kernel.org
Reported-by: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Tested-by: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit d3a66ffd1c4f0253076069b10a8223e7b6e80e38)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/netdevice.h | 54 ++++++++++++++++++++++++++++++++++-----
 net/core/dev.c            |  6 ++++-
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 85fc72b8a92b..6f1a3f286c4b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -594,7 +594,11 @@ struct netdev_queue {
  * write-mostly part
  */
 	spinlock_t		_xmit_lock ____cacheline_aligned_in_smp;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	struct task_struct	*xmit_lock_owner;
+#else
 	int			xmit_lock_owner;
+#endif
 	/*
 	 * Time (in jiffies) of last Tx
 	 */
@@ -3610,41 +3614,79 @@ static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 	return (1 << debug_value) - 1;
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static inline void netdev_queue_set_owner(struct netdev_queue *txq, int cpu)
+{
+	txq->xmit_lock_owner = current;
+}
+
+static inline void netdev_queue_clear_owner(struct netdev_queue *txq)
+{
+	txq->xmit_lock_owner = NULL;
+}
+
+static inline bool netdev_queue_has_owner(struct netdev_queue *txq)
+{
+	if (txq->xmit_lock_owner != NULL)
+		return true;
+	return false;
+}
+
+#else
+
+static inline void netdev_queue_set_owner(struct netdev_queue *txq, int cpu)
+{
+	txq->xmit_lock_owner = cpu;
+}
+
+static inline void netdev_queue_clear_owner(struct netdev_queue *txq)
+{
+	txq->xmit_lock_owner = -1;
+}
+
+static inline bool netdev_queue_has_owner(struct netdev_queue *txq)
+{
+	if (txq->xmit_lock_owner != -1)
+		return true;
+	return false;
+}
+#endif
+
 static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
 {
 	spin_lock(&txq->_xmit_lock);
-	txq->xmit_lock_owner = cpu;
+	netdev_queue_set_owner(txq, cpu);
 }
 
 static inline void __netif_tx_lock_bh(struct netdev_queue *txq)
 {
 	spin_lock_bh(&txq->_xmit_lock);
-	txq->xmit_lock_owner = smp_processor_id();
+	netdev_queue_set_owner(txq, smp_processor_id());
 }
 
 static inline bool __netif_tx_trylock(struct netdev_queue *txq)
 {
 	bool ok = spin_trylock(&txq->_xmit_lock);
 	if (likely(ok))
-		txq->xmit_lock_owner = smp_processor_id();
+		netdev_queue_set_owner(txq, smp_processor_id());
 	return ok;
 }
 
 static inline void __netif_tx_unlock(struct netdev_queue *txq)
 {
-	txq->xmit_lock_owner = -1;
+	netdev_queue_clear_owner(txq);
 	spin_unlock(&txq->_xmit_lock);
 }
 
 static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)
 {
-	txq->xmit_lock_owner = -1;
+	netdev_queue_clear_owner(txq);
 	spin_unlock_bh(&txq->_xmit_lock);
 }
 
 static inline void txq_trans_update(struct netdev_queue *txq)
 {
-	if (txq->xmit_lock_owner != -1)
+	if (netdev_queue_has_owner(txq))
 		txq->trans_start = jiffies;
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 93995575d23a..e7dc4700e463 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3449,7 +3449,11 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
 	if (dev->flags & IFF_UP) {
 		int cpu = smp_processor_id(); /* ok because BHs are off */
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+		if (txq->xmit_lock_owner != current) {
+#else
 		if (txq->xmit_lock_owner != cpu) {
+#endif
 			if (unlikely(xmit_rec_read() > XMIT_RECURSION_LIMIT))
 				goto recursion_alert;
 
@@ -7168,7 +7172,7 @@ static void netdev_init_one_queue(struct net_device *dev,
 	/* Initialize queue lock */
 	spin_lock_init(&queue->_xmit_lock);
 	netdev_set_xmit_lockdep_class(&queue->_xmit_lock, dev->type);
-	queue->xmit_lock_owner = -1;
+	netdev_queue_clear_owner(queue);
 	netdev_queue_numa_node_write(queue, NUMA_NO_NODE);
 	queue->dev = dev;
 #ifdef CONFIG_BQL
-- 
2.18.0

