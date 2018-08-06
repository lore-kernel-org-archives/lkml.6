Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E24C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E6F219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="hn8WOu1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E6F219E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeHFL00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:26 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:36418 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729714AbeHFL0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:25 -0400
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BFKu008035;
        Mon, 6 Aug 2018 04:17:49 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0177.outbound.protection.outlook.com [216.32.181.177])
        by mx0b-00010702.pphosted.com with ESMTP id 2kn93xbp4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVaFIRI6Ebg0Rvw7eeIip/wDFRo/4TItQXs57Cxc8v4=;
 b=hn8WOu1YjJNt2xPDSK68/qugJP4DBfsN7c801Y+DHHsfFztbfWo5GZWXq8c3pGGzsJItSFP/xCbS/or4Dze3FRGh2YaAawsVtp8QsHF9MtsZ/x8ryKTlaAeMqs7ci6UPFUkgeq4Fnppq+2iR+czFOqxQGZrq/wMQ0Dm1WGdj2x4=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 CY4PR04MB0966.namprd04.prod.outlook.com (2603:10b6:910:54::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Mon, 6 Aug 2018 09:17:47 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id 1E443302F62; Mon,  6 Aug 2018 04:17:39 -0500 (CDT)
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
Subject: [PATCH RT 16/22] block: blk-mq: move blk_queue_usage_counter_release() into process context
Date:   Mon,  6 Aug 2018 04:17:32 -0500
Message-Id: <9dd9d390ebdb534a766887b11bb1666bf87d8ca3.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: CY4PR1701CA0006.namprd17.prod.outlook.com
 (2603:10b6:910:5e::16) To CY4PR04MB0966.namprd04.prod.outlook.com
 (2603:10b6:910:54::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6bc97f0-c91f-4000-c25b-08d5fb7d79e2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB0966;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;3:achpg8slcT3bul2D1v3sh05qT+KX6dA5xPuNxaONr1QMT3428wS78PBdyG2gor8mYTkzVSgZoIPj1BAoretbbMgtm3v7W2kktM93eIsRl7/REwI5s8R5sWpXM6d5JOA5YMmqmq7CGYusbA45+y19pjEI8rxdWjXmRQONW1URsn3JoSAr7cPoSDDtFYOQrRuF7jL1EIhAEJ+wix/aQzjwQjukwqFV+3srbFeB/8AGzlrbZ4HJo+QjntzLqmku9sTJ;25:Hxnhq3N8cMF33toAa69zVAntxz72k814yFVdVzbQB4lLKOp6rqi//WJVzhWfpNeEpKdaQgABjAH2Il63Cyp4t8HRPxwVBuBlARXJWW9F7bdZGKqaCo4WS0PoR1ElRQKFxq69IivbHFTTJ7wgTSpPb09XLRHaEKbucjGJKDJmgT38mWPokL8NwkPc4FYyLIPP1ICB+x5PI+q/wuafpRczvJyFtj+U2w1dMBY5tAmKyghAmX/FBtP56Bx4A9OdA27DSAihXunL8kIJmJRi8ZTi+GI5rdA0r8yKqvKZ3io5oIhwD9dAj8AIDpbxxKfWrMql/fbMFq3jn9sCL53T02hZ4Q==;31:zyPW/UlhQTC7o4NjRJvg9iXGXaVv9vAewrjCQDk1oLwQmYO6754l5H3g2VpnHZHI0WO9lhajlrAbsVdrKIP5ZrK3fZ9QdjL024U28p7boVSkqN1NX58UOSFZZ4r/gm90eTqQYZl/ZP6pwmPj1RDcm8FU5hE4dT0JrFuGEEpg9VvZ8sE+N7Z4wsQ9oIg61MJNrYz+rlAVBfJUwV37+Tr2QD8wc7lzklVJLYonaCQIo5w=
X-MS-TrafficTypeDiagnostic: CY4PR04MB0966:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;20:APDX0MHtaHdi+KzaaJxGHNvmVOh2veLHjvhXyQ0/34nvNW7AkCKfQTcixJK4r7r6EfNTqZfW3ibAVJJsZi7Lz318uoz2p2PZyX5K0b8l3/UzCLklU7rYjdSJNt7LZ8WZOTPeMnpWelvJ47lgbnmdNjeRaxqTnWJLZsElEfU88DgqggpRdOSeZed2K23ERzxjnJ19E49oKJUijT1FqKsDQgwv6ASIKP7cgYN17rT1cqQJ30/3WnOo1US9lOFc1tdfn8Hao+aeYIyfOYWbf0hxnrzPYPJqZ06MREBc/iVSWU8PgpOhjwmh/j1O4rgdyJUZaA3ZWerkneogc5GazAxPO0pIjhR4yhM0ibrkgkJASKPz69GsNQrt9KLz07eewfeqJWNqGxFhBKHQxT6sZE1B8bGaYZMX7LlmyL8LTM/IvczUcX+/FnrT/B+uIF0QegEUEkKaBp2rK9CQazPSN84OELVMegHUvX4jO3gTqEGvvvQccRYWfHRk5XHVszPmOiWwZOEWEef2beMpjXPb91rDhNQ3Senx5QOUkS+o/77V0qdQVPjqtwMRbUquUnPT0iqzcTrxKSq6OKktxMDFY4ZqHKrUY6MMzJLMCH0vgVMHs4w=
X-Microsoft-Antispam-PRVS: <CY4PR04MB09668A414B8F64FD1D352DC4F4200@CY4PR04MB0966.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR04MB0966;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB0966;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;4:4kUKadX8C/auktqVL7aNJQ/GfTvfsjqiYkjoq/6gPzN44nMrayZ5vx0kdUmTLLvvsohC1yZpptfyYXr3J4iWmwEMBU4Y8Ffagu74ui2PkaaVy0xmn1ZPlo5wGRwnJtuGu02kHpnopo3Zu4BSgSyWFjzAnB7DcjjJl3PHUwFlvYKwhi2DcAyJX6VKs8VP7oH2B8sZSv5qBEfZ0vfEg6IbFO7aX+HCLcWC24Nf8OooGmBaFEppOjupGifsuhsJxBvk5FrZXEoYpJoh7F5SG1FdElbGk+JcO9zGhJSUwI1zvfL5AuS9caJ4QNe9YwVjlR/Bj6hw3si2+LTKNsJl3Sruy+UhqEtidjl0dPX9Tr+zRZw=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39850400004)(376002)(366004)(51234002)(189003)(199004)(42186006)(51416003)(52116002)(316002)(53936002)(122856001)(76176011)(8676002)(2906002)(81156014)(105586002)(81166006)(106356001)(4326008)(16586007)(478600001)(54906003)(48376002)(5660300001)(50466002)(66066001)(6666003)(118296001)(52956003)(446003)(50226002)(7416002)(90966002)(6266002)(68736007)(8936002)(47776003)(2616005)(26005)(186003)(11346002)(486006)(476003)(386003)(14444005)(3846002)(97736004)(36756003)(7736002)(6116002)(305945005)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0966;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR04MB0966;23:cJFKdKwqF3w5Zn8HokkxYL7NytO1BDWQzQj2F6CCS?=
 =?us-ascii?Q?zc3zRWhrtFTw1pgj+V8W2YrKNPKukr0dP4+U4b4KfBoOOBWQlCl0fG5vuAVv?=
 =?us-ascii?Q?U/DDmOdzS1pjMW7MSlOo34Wfs44l3047LnTDDC0Rpfj3ZqjfX5/1JEtdi7IG?=
 =?us-ascii?Q?v0l776JwKVTXf8mzI4UwxwAySX6cqawSdcXMnmyYSGtogoKUnsL+PSI/dXBl?=
 =?us-ascii?Q?6UVc/wiuOS5R8r5PbTO0LHSG1d+UaIydoYEX7CMLDyyl81F4oQj2S0Oct2hZ?=
 =?us-ascii?Q?NpXytDEIIBhne+2KQaAAQM+9SOcy4Ri0eJ6n3GtZ6k39tUPTIx4bIi+sd3Eh?=
 =?us-ascii?Q?ercUfjsLr80rf9rrh6l/m2uy39fROsYbYAOlAy3eYRUb8aDFoxLLR6taOUiR?=
 =?us-ascii?Q?L8qzhQy2aFhLqJdMb2LGB/dY0QU4RDR0gT86pkrGselxiWvBxhAErWgT0tIz?=
 =?us-ascii?Q?BP0QeYCBI6mr/fd9opo2q43fXguijlCNV3wlCWDU01vLKcS2mB3W/+PyjfzW?=
 =?us-ascii?Q?GBwRIHcU8rwkb6jPWRnG2Buz9gFp8Imxz1gAOrY7MmjZ3JuVGsHtwmvjewHK?=
 =?us-ascii?Q?qGA4aXmzi/fIeoP/TK5XsS2Vmts20uwK3qUVlddlCQefYSoPdtUqAg2d3+6L?=
 =?us-ascii?Q?nJv8NafODEAHfwd5xND7k9u2LYkqgWzeI6aJyCWmxTsSmplcJmH77f7bsl8G?=
 =?us-ascii?Q?Nz/ChAV8qGw2YN9uZAwc833pmEk3fsxp0A88K+RRPpodw5MmI/LzhjWm6AsA?=
 =?us-ascii?Q?NjwTtMvfhoOTgSeV0ixQ8Bk4s+Os5ExTWTgxZxLIRbe7yvAOxPdsmGCdRvF6?=
 =?us-ascii?Q?e6hpuXV4gQNBIgPImk2OwfGL2nHbdYDhb2mgRO+Rzi3K57FLm8GC3cxIGMUr?=
 =?us-ascii?Q?QXd9mDE95tucBcJA2iYY0S/x3Fp16PfwzCa+eHKVRpvDmipeZJQ6kCwcpfb1?=
 =?us-ascii?Q?IroJ+ZEjhNXV2cNSR0XPEGg5EBWf7hpUz2bPziWXEVL0dRWdkQUxJrsBRqIZ?=
 =?us-ascii?Q?qQx3lRMof4AI4aOtBmgLTT9pyr96kIwLC+DgxTqgO4Gek3Oz3SiQizNazaAN?=
 =?us-ascii?Q?tDtHNzZCRNUiDBGTUl8vjr+HONlXiWueNcZwsUDCR2MdR8qq7McjwX2ouSgO?=
 =?us-ascii?Q?rsyCUyPpmqo0NeHggFheVFtf4FFDxybDaVmDQvBKg29egEvL12YtSKlNHvlF?=
 =?us-ascii?Q?hpGKJS/7G80ct4qES51h8AD2nCi0B1qMUqjS3LyZe4VYn3LbXiXEcezE9B1w?=
 =?us-ascii?Q?vDvUacLCwyuc+HNxw4=3D?=
X-Microsoft-Antispam-Message-Info: JJCqyYbgTD0IKq/P1EHQd9iSGn/crmHYZCVTXACCdZFmGA+v6aZAkxNyna0xAuoxDPOc0WAbgMrmUVBGnbx61gHn2BHC5SzLJYNUrOz+EkcTTI0//O5O0oZVosYWKdFtPD9+ikICqKccx4v9RE3lbvMpqjhqieRmhfLNHizzB3ivaXdcUIYJury36KzTkOFYwUJRqk5Gk6EeS7+jhGYFKKXTre10gVUgMngEF6EsLXSKvtQXXZbEuvop4AwGZ1axVWI7tkwXPes9r2I7RJ/Gn8+wRXITQhkBVUvMXOZc1iVoh0nplGz3WN8dnC4Vh0kQP+dSpNOspBop72qBd/jK1cES036SLSkdepiXV1FF0wk=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;6:egkKOPc76vX49k/B2nwh/7jSEgRmrRzKS/kpeVN3+Qa5fQTy1WPVGiCTKJAPiteroyONou3ZuPIX2lZ5iF+QsZ3oK6Bkzp3Q0SBz7yWYUuMSO68qsXCJFeAWxGPGF+Usy/Br0Ablslu6TKWLAJ0Wo9agPd4FhXGqoLsuOHJK02k6q9OJxAdDlMA6xMTtujRoLhKr05YL3nMSxr/bIrBm5CzQgeBYPSG5qOzmzX2wVAPskvX8NLua4bEBLVvLHC47AigomDfJtX9fQ9IA70O6A/0nogOHbUn/9g01Y4g3UA1BGp0YaO/MRhFeGqZ49Rz0/kiy5QNNXnufuqg4v7nugCNC2h06YTcI4/FRtZZcH7O8Ny95XjT9dRwKlXC5a6nn3mgUhzWLHs/0U94ASN7diKo8VnTXObp/W33LivU5QHu+kyyY4dX8DsdCYEN3mjzmX5M1iuLTmPg3I7crik8FBQ==;5:0M2rt0w3jnjg1XmUlqv7PNzcGFjwd9QOy1r2fb6YisRA8V1Qbx/8S10n2xLjZmFOY1hui6m6bTzawV+QyZ7KOJyxfufwhlIyDGlHi7ws2vEn+PiU9MbQZvX0P0N4IbJjfBzS0SdOzjkxPdgADGfgq4PTB9Y6LsT0AH42eWzUn4I=;7:TIKwJY2uvBEbrN4lvPZxn0qA11Orzdjo87tpAjBVEQIB0O4Gr8ezy2gYdRtagHW5Ysf/ObhXGJ8wFWQ3+At9aEFdcLg3V6sXs/I2ouNj/o5NboLfcTLs3yTXmZh3bympOCY0gmykX6IUR9MicjhHQKZBjjcjczKMbhOTC0fRg1Gf126MyS81buID2ILx0VeYQoGv6tM98qYE/fOxlAZLkNkq97rkZ+dL7TPgGDTQheK0kg5TJDIx7K3atW8YQ+H1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:47.6830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bc97f0-c91f-4000-c25b-08d5fb7d79e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0966
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
| BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:914
| in_atomic(): 1, irqs_disabled(): 0, pid: 255, name: kworker/u257:6
| 5 locks held by kworker/u257:6/255:
|  #0:  ("events_unbound"){.+.+.+}, at: [<ffffffff8108edf1>] process_one_work+0x171/0x5e0
|  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108edf1>] process_one_work+0x171/0x5e0
|  #2:  (&shost->scan_mutex){+.+.+.}, at: [<ffffffffa000faa3>] __scsi_add_device+0xa3/0x130 [scsi_mod]
|  #3:  (&set->tag_list_lock){+.+...}, at: [<ffffffff812f09fa>] blk_mq_init_queue+0x96a/0xa50
|  #4:  (rcu_read_lock_sched){......}, at: [<ffffffff8132887d>] percpu_ref_kill_and_confirm+0x1d/0x120
| Preemption disabled at:[<ffffffff812eff76>] blk_mq_freeze_queue_start+0x56/0x70
|
| CPU: 2 PID: 255 Comm: kworker/u257:6 Not tainted 3.18.7-rt0+ #1
| Workqueue: events_unbound async_run_entry_fn
|  0000000000000003 ffff8800bc29f998 ffffffff815b3a12 0000000000000000
|  0000000000000000 ffff8800bc29f9b8 ffffffff8109aa16 ffff8800bc29fa28
|  ffff8800bc5d1bc8 ffff8800bc29f9e8 ffffffff815b8dd4 ffff880000000000
| Call Trace:
|  [<ffffffff815b3a12>] dump_stack+0x4f/0x7c
|  [<ffffffff8109aa16>] __might_sleep+0x116/0x190
|  [<ffffffff815b8dd4>] rt_spin_lock+0x24/0x60
|  [<ffffffff810b6089>] __wake_up+0x29/0x60
|  [<ffffffff812ee06e>] blk_mq_usage_counter_release+0x1e/0x20
|  [<ffffffff81328966>] percpu_ref_kill_and_confirm+0x106/0x120
|  [<ffffffff812eff76>] blk_mq_freeze_queue_start+0x56/0x70
|  [<ffffffff812f0000>] blk_mq_update_tag_set_depth+0x40/0xd0
|  [<ffffffff812f0a1c>] blk_mq_init_queue+0x98c/0xa50
|  [<ffffffffa000dcf0>] scsi_mq_alloc_queue+0x20/0x60 [scsi_mod]
|  [<ffffffffa000ea35>] scsi_alloc_sdev+0x2f5/0x370 [scsi_mod]
|  [<ffffffffa000f494>] scsi_probe_and_add_lun+0x9e4/0xdd0 [scsi_mod]
|  [<ffffffffa000fb26>] __scsi_add_device+0x126/0x130 [scsi_mod]
|  [<ffffffffa013033f>] ata_scsi_scan_host+0xaf/0x200 [libata]
|  [<ffffffffa012b5b6>] async_port_probe+0x46/0x60 [libata]
|  [<ffffffff810978fb>] async_run_entry_fn+0x3b/0xf0
|  [<ffffffff8108ee81>] process_one_work+0x201/0x5e0

percpu_ref_kill_and_confirm() invokes blk_mq_usage_counter_release() in
a rcu-sched region. swait based wake queue can't be used due to
wake_up_all() usage and disabled interrupts in !RT configs (as reported
by Corey Minyard).
The wq_has_sleeper() check has been suggested by Peter Zijlstra.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 2d701058d614554cce412a787f00568b9fdffade)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 block/blk-core.c       | 14 +++++++++++++-
 include/linux/blkdev.h |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 87d3e0a503e5..346d5bba3948 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -675,12 +675,21 @@ void blk_queue_exit(struct request_queue *q)
 	percpu_ref_put(&q->q_usage_counter);
 }
 
+static void blk_queue_usage_counter_release_swork(struct swork_event *sev)
+{
+	struct request_queue *q =
+		container_of(sev, struct request_queue, mq_pcpu_wake);
+
+	wake_up_all(&q->mq_freeze_wq);
+}
+
 static void blk_queue_usage_counter_release(struct percpu_ref *ref)
 {
 	struct request_queue *q =
 		container_of(ref, struct request_queue, q_usage_counter);
 
-	wake_up_all(&q->mq_freeze_wq);
+	if (wq_has_sleeper(&q->mq_freeze_wq))
+		swork_queue(&q->mq_pcpu_wake);
 }
 
 static void blk_rq_timed_out_timer(unsigned long data)
@@ -751,6 +760,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	__set_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
+	INIT_SWORK(&q->mq_pcpu_wake, blk_queue_usage_counter_release_swork);
 
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
@@ -3556,6 +3566,8 @@ int __init blk_dev_init(void)
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
 
+	BUG_ON(swork_get());
+
 	request_cachep = kmem_cache_create("blkdev_requests",
 			sizeof(struct request), 0, SLAB_PANIC, NULL);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fdb449fe3ff7..ab039211ab9f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -24,6 +24,7 @@
 #include <linux/rcupdate.h>
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
+#include <linux/swork.h>
 
 struct module;
 struct scsi_ioctl_command;
@@ -469,6 +470,7 @@ struct request_queue {
 #endif
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
+	struct swork_event	mq_pcpu_wake;
 	struct percpu_ref	q_usage_counter;
 	struct list_head	all_q_node;
 
-- 
2.18.0

