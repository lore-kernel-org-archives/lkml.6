Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3C5C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B7C219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="J3oTuhcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B7C219E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbeHFL0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:31 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47362 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729667AbeHFL03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:29 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BFX4013915;
        Mon, 6 Aug 2018 04:17:50 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp0024.outbound.protection.outlook.com [216.32.180.24])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn9nruyu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwggKnlZhXN5uBKc/NH3KEHXHh0g7z8Gh4VDVGdSsUs=;
 b=J3oTuhcTutcRQlAl6qQ98QxXF02LMBUMnBGzTkQe433cCHW5BECh0Pi48Py8Wn1YzfRZGMI/ctK2uS6W9p2Q9OOLysIlNrugPTLxLfJp7zV92HuXWkzcjeJLNYkvN1GbB98rLC780ebsM5z5EE9i6LiIljRIMVe+FwZJdRaXRDU=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 BN6PR04MB0963.namprd04.prod.outlook.com (2603:10b6:405:43::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Mon, 6 Aug 2018 09:17:48 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id 38A98302F66; Mon,  6 Aug 2018 04:17:39 -0500 (CDT)
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
Subject: [PATCH RT 20/22] squashfs: make use of local lock in multi_cpu decompressor
Date:   Mon,  6 Aug 2018 04:17:36 -0500
Message-Id: <9198fbac982eef67bad736f7ac8943a75ddafd33.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: BN7PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:406:bc::43) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6db8256a-61fd-4aa6-72c6-08d5fb7d7a25
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0963;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;3:z8k1EBTKZw6hKSJe0h8Vq6v2sb/0KISMco/okRZI1yvuWCpnjvdKXs0H7nryyVwAyHk+8/u06koXOsV9TdUi/BK9guFLJfw2FMCjeQwbpe6vghAMvILQTf01iR4f+FtehpYaSt3veph1tDccPCvP9lsGEXDRWvmkL0fvQrjATFkY9JTs65BWDN2Hmzax5PLQ1jl1RMzuOI2M2P05xpa+bYBnyS9m9cvqx7oGbsiX8G3cHA33zhuq/yNVSBRHU94e;25:CLJw2EG5sNgqvUnXTbFjRPOT08xkwaMsZpAFg9rNvSO3VZn54xL5KGJL2r1XpLx1ELPItWVxtCJowFpSzOy+OaE31mSICMJ7971Nd3oLQNCEFevD4MoAbMe7UoLcPiICPvUUGv9vKw8IB1K/HGtv+WvZC8K7/qbp0RcXt8O8DDk682OhTi2p3DzdNEfkuI60fnajzkY8TX9+MOkUHZ0DcF8usPF4MbtfnvaH2fB4McOYhMwbqhbe1HnL84OkSsSHDPJTsL4FHgloeChxh2GfkSEzq3K7QuVsdNRBXY7gPFHjmuVAJPYhuHjIIXTm7xZfF28nl1qAxjWVsXElyr2iag==;31:wTPcfvJivQrJNzH+O/4oTOSbKolQJEnNsK7yEwVp2phJMGKOqzHzVkSv237P1HQnxxRotw/XAaEdhFCqOn7RRmBedUQIfngGG+V72IkCFnd2rL9w2SluPq9FlkIlZcZw+0NSNosMKoLLkftwbOuQ/Jr6CJJXBObpZLq27wbMIfZQi7Cj5J1ckjTAT7KqfOisENoIxArj890CDk3bkE0mpQcsioyqkAeX8McG5GE5JsM=
X-MS-TrafficTypeDiagnostic: BN6PR04MB0963:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;20:ywe7Gv3Srcg7wxY7K+tjosF0e8MlFWOIZxjn3A3ADkE6KOkr7dlSkE5mQ4O++BUxX/y8+oOLn6iRZpI8Nhlio8dIub8sfWEVNW73b3mZcBVL9e1OK0yJO1hnvUYlz4GBvNulNMdNUqBmtx7ug186zNyFiu4eXyW/QlX7THngsUD2l844bp+M6n8xMj3/QRh0a/1aH12ScJQ7b2ixtzFomBUC5v9liOKISRdy0SMX72YzYgHsIo/ik4NebvajoWwynV2VO/3Gin6UKGJgs8ItXDPhy3keo8wcHT+diaZnrnjbnIRhSb9aOf0/H2gR1u8BtUjWy1rNbCuE5owfPrBlfJcxMwnrMnt3j/AEr09sWhaGqZ7SbvNE27CyAvXscsepGt1lU1OgGiVMZaxD3QJNz3aZVdRhhMUnHi6JQo+bQTfgDr0hPM6T9fnfzK9GMHPKnqDlJJ5XgFBLQ9fb0V7N3kPP+CO+tw/mwPKF8uFhToyUkY6NevtUI3G3x1F9NvAqm2oH0IeWcV6JWkqP5qaZxk43/xFSOdms8p3mhtRudduyxufkS08n+vBxEJVtTBq/v1aEJEV6AOja3PJyR0djgfBggXj0ERcVgmeSGvVuyng=
X-Microsoft-Antispam-PRVS: <BN6PR04MB0963082691942824D473242FF4200@BN6PR04MB0963.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443)(9452136761055)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR04MB0963;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB0963;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;4:dzNoAb7iR+EpsVI7IiefIhPuTQEfGZ9p60yhspGvdy3dXF/URYczuArwdGU48quKspRpQFaDXRA2eSL+RXN0t1DM7Mn5sxDcB+aYbofrx0CArmfU4aBGLJth6UE2Q8t/bhQcdrxVIFFbzzrXqdOacaV5QmyRFqsqPV+H2u0cqv6Vz9gaTehexi8wjR1U8reLv1nKjACl5EJ/hu9jzcIxFvB3nhYNGdCU6AsU3CKa8Qs+uiLx0ZaEowJf+v8eYCnsrhbh6B9qn9lfZSF7vQYvEHMxs06KxsR8v3ZrtS372F+a0mUbB+o0VNWOqk0L6exYvgaAgcLbrABzwcmh7+xQtEpPlf3+G5AIaCvLMx6eRs8L8nFtEWrsbJPJEKu+3b5t
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39850400004)(396003)(199004)(189003)(305945005)(6116002)(76176011)(2906002)(186003)(97736004)(7736002)(50466002)(48376002)(52116002)(51416003)(81166006)(26005)(478600001)(36756003)(8676002)(81156014)(122856001)(3846002)(316002)(106356001)(53936002)(16586007)(105586002)(6666003)(42186006)(52956003)(7416002)(68736007)(66066001)(47776003)(6266002)(14444005)(118296001)(11346002)(5660300001)(4326008)(50226002)(446003)(2616005)(386003)(476003)(486006)(8936002)(90966002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0963;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR04MB0963;23:iFHIImWtOwOtJ3krmzkLvlp7Ngo5hdYx2pDa8xCKX?=
 =?us-ascii?Q?61tGrKjfiN/4ZupCN85Y3E2fjWU7Rb68v+HF5kkMHK7yxGDUQqBUOJJ6JJ64?=
 =?us-ascii?Q?xVlT9e26TfGp4vk5ZVC2k09CydGqcqExJvZ76//KhNJXvJ18lbsJPUpIqNhr?=
 =?us-ascii?Q?cS2aSE9W1L/1Yo2c35r7S6R/yxpCKRvLOWVeN43rcekqzYIAy8FPtqCvXZQJ?=
 =?us-ascii?Q?eDFRlgXulfajhL2lIB8LORIExx5c1mSBCSRWhQphr2ypsr5uorfXs7dyq+HM?=
 =?us-ascii?Q?1sPjgCqxqhtcLoYbs08AfnbBJzLP/XkFfslRRKrVQ6uvDUpGcxE85eQ53Ybh?=
 =?us-ascii?Q?8cVPR5Zh539bHNZA2V7/YSZHA54Fo4vnLz+xTKQUPI+CsuNCsJPQJbtvp2Fs?=
 =?us-ascii?Q?XiG7QzHOqZaiBKdegrlgPA5ALvD2SW79ljqeAc9sQX+bb/kGhU47ReveE3zW?=
 =?us-ascii?Q?Hm/1rFlHTzjqWmTRHq2yib5Rb1/UN8qHF0DRDLOfTWkgF1VqWmNTxLGUnILG?=
 =?us-ascii?Q?tlp3VmqQGWs5WtkgRzMWJbOACkgj5knp1mdOW3BO3PwH0fhISbnjxbiDD3YQ?=
 =?us-ascii?Q?H1WDsWRQkVDH5tbazxF7dOxz+zJ5NQbWhJZHjhWYKmgoqgILD+hYfpngP9nv?=
 =?us-ascii?Q?xtvBbhT1n3MF6nkQAVMC7uS6KBzqiYnitOvjJkPQluhzECt1zq2LtKL7hbTT?=
 =?us-ascii?Q?k7RL33NQcs3PYgTxcKf/HhdvHhAS9/4GaXUg+L0JQScYa3nUn/aS4PFxPSRV?=
 =?us-ascii?Q?kOwJOW9uIRd6tpXuaucbDxR0ioeTJ3Kfaq9iEM76e6TM37HRa67SM0a8R2tW?=
 =?us-ascii?Q?XNUtIKW9cx24qpT4aFU6+E91mdu0ocGfMCvPIh7WY0OYZpZel9BUL1p2GOJ1?=
 =?us-ascii?Q?0hG5S6v/pT8TEvxTod5lLwhkvjw5n5AXGP/XNhWW8YAF15gDcsQgUH0rSn0Q?=
 =?us-ascii?Q?LZ/VUVdtYOStS7tUU8Du2mEh53svWFmZHaGrBOE53HuS947MOS7gV9nIsE+J?=
 =?us-ascii?Q?EH2opRCJajy/7En8rOqjWeLDEHLdV9jfe73McEQUdh4L3k2qC7NCDmVJf16I?=
 =?us-ascii?Q?PahwQDh/G6awkgl5WURoia91Cstn+C/tQ25+gE+8ZELmgYBLeXSYpQPJhkXp?=
 =?us-ascii?Q?FQMymgPP0J2JVIHEL/qWmMq7MwMLupoJlXlirslSJuCoZyTahhA8Ug7GPYGb?=
 =?us-ascii?Q?/RdsCNnVSyIqbbQm5/vr2qfvHEstIewvt+u?=
X-Microsoft-Antispam-Message-Info: Fyl0cBHrqVn1viCfwKOcTIDNFZVb1bgSFydTfv9t2DV9nJ6DMcFOCMHCS8Hj3Nqa87ekmVvUOdWAbNdfKnGB3MWBd35ZH0v17fwH6t2UbFW2W/otYOu+GKmHaMu//oeX6pTADLsoN5T4tdizbi47tUf+idn91As89cG7kzGAGxyOM5a42R1HFS0Oow1GG7DDXymFdzK94JI/0vf941uE1wKOjT/tqW+SEKizZWnLL0oGezLtuZtvIZMa8ok4KdLvYz8J0tEDtFBkrMDoj3dsGXkKQ2EFN9a+hQR4PTTyjfRGTTG32ziv79AB059qRtkHexW179SlYcBuLyLvOIKOClLIPil3QhptMWyKNloBVeE=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;6:ajhErVvLnvVEkAn3DXmAHe0VYMg1fMB1gQlOAkRBrDVoyG5FPg+FLA1hpnZuqenOsb/+XmyXQ5gIkiuRGoJF7HQa8mFlHDANzPsdRqHpayRQY6Zdr6g4r628s+R2DUf2tRGf3WQ1GW9+s4BGOZmXTy0MAkao8+TLxYkJDzEoig4L11No39dJ8jPMQJgWgVJNycPGaxqvm3Zjg2EwecMRz8ZEhCc32n+I3vvcu1cGp1FQZgoMqlbw50UOWFHHZosD8sPehPs2JdajREEZYBfOiogYHv2LYZHg8LkVnhXc+R9VeGXNVi64ODqFYQzTJbCC1dhhWFicM8YALXT/iEUGOdHyZzBIy+pQ9hvGfUbRXq0FkvfveutWTlTMBEM2yYtXtYFoBcQTb/ueW9V3VR4/S4dg7xATNJ7sq2YDfs3e1pgGPRzQk3QxKll4k+6nZjbtpUrLeITi60TCNUlg9WwNzA==;5:9ZHbOv+oYVBSw2e506qtxYWbsgNlTHRsL3RSza1GARB5QlZtrF47Yn37euIFq4B9NpK9wL36TQSmP+xoM87yXJs6+c86gXzTt2DtzzXoqGdXo94i6xNr0oveBEKhbG+BLGiKRE0yIHsrLXTDKKqwq3pLSZcjkYHwWt4NSyZxRug=;7:AHgvIQR36arBl+zHJzp5AzQJvo8+MXn/iv/JxRlfIfeRHPWE8Cpg8CFt3Q7RhfUOhyl4wiNKFwFLZuR+SKL+cuKrtlwhQkbXar/eC77G7Y5OZ8/3ihZuO4+PA8J98HvmXMDLUpqXH5uwBhgvnngeOIaPkx4FFSYYDfOmPkew90vPzVqBrwIJhv9cZMQKmKzpi//gZOuZIu2eWhvTAk4l5L7tl+MSClGcTxigv6Ns3plUgf00/HVH9GJzstbK4jt4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:48.1082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db8256a-61fd-4aa6-72c6-08d5fb7d7a25
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

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
Currently, the squashfs multi_cpu decompressor makes use of
get_cpu_ptr()/put_cpu_ptr(), which unconditionally disable preemption
during decompression.

Because the workload is distributed across CPUs, all CPUs can observe a
very high wakeup latency, which has been seen to be as much as 8000us.

Convert this decompressor to make use of a local lock, which will allow
execution of the decompressor with preemption-enabled, but also ensure
concurrent accesses to the percpu compressor data on the local CPU will
be serialized.

Cc: stable-rt@vger.kernel.org
Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit c160736542d7b3d67da32848d2f028b8e35730e5)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 fs/squashfs/decompressor_multi_percpu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index 23a9c28ad8ea..6a73c4fa88e7 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/percpu.h>
 #include <linux/buffer_head.h>
+#include <linux/locallock.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -25,6 +26,8 @@ struct squashfs_stream {
 	void		*stream;
 };
 
+static DEFINE_LOCAL_IRQ_LOCK(stream_lock);
+
 void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
@@ -79,10 +82,15 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
 {
 	struct squashfs_stream __percpu *percpu =
 			(struct squashfs_stream __percpu *) msblk->stream;
-	struct squashfs_stream *stream = get_cpu_ptr(percpu);
-	int res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
-		offset, length, output);
-	put_cpu_ptr(stream);
+	struct squashfs_stream *stream;
+	int res;
+
+	stream = get_locked_ptr(stream_lock, percpu);
+
+	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
+			offset, length, output);
+
+	put_locked_ptr(stream_lock, stream);
 
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
-- 
2.18.0

