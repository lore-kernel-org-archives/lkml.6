Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D39CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F55B21723
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="e/ecsWNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F55B21723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbeHFL0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:49 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47470 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728147AbeHFL0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:48 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BFX2013915;
        Mon, 6 Aug 2018 04:17:49 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp0113.outbound.protection.outlook.com [207.46.163.113])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn9nruyu1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzrUmLDyu0lSKXWGJNhm/WSYoNV/oLlcEgePFY4JOts=;
 b=e/ecsWNvfr7x+BzEI9yII7jn/trjtR/SD4TunI4tjK9TipDFtotQuSxrAuQwboX003TayN3QCI1GLCoKWoFZOfuuYN5CoE9RE1HXcjpPCXHpC/iL5JZ2R7mgaVnbPa/oD4i5jRwoYkxSoTq/9JipqfI0acvmmZAver9GsiwATeA=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 MWHPR04MB0974.namprd04.prod.outlook.com (2603:10b6:301:43::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:45 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id CE7F7302D74; Mon,  6 Aug 2018 04:17:38 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RT 05/22] rtmutex: Make rt_mutex_futex_unlock() safe for irq-off callsites
Date:   Mon,  6 Aug 2018 04:17:21 -0500
Message-Id: <bd21741bb5e918e5ed254b9fa869b5523a469b55.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: BN6PR2001CA0023.namprd20.prod.outlook.com
 (2603:10b6:404:b4::33) To MWHPR04MB0974.namprd04.prod.outlook.com
 (2603:10b6:301:43::35)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fffe1a03-37df-497c-c1f2-08d5fb7d7872
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0974;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0974;3:eLHz6ScckugbSN0bEeDhwHX+M2gAs42eqbTsyL/0OmAY2WY3WzG8LkyjXCKZ/xyQCa/MTsLmA50mTUIcatTatY2rc2ncT8q4iRk7ZhE4XhEZUg+pgG7/kYrvTSndXgu0oVX44/X0oh6D49/z3nOb1HDrHivlbyRPsP02vO03vJ7ucSMRKRyd9Ldp56evJEKw492zq4/H2CUJ7qXD/G7J89O23LNLjA0slIF8gu0LCahy8WuoiVtYWW7+1fCAZALY;25:LanW48YuPynzolNFDxWylPp5VRWu1vl3iO61yTqZzxgWjcLmRgOvvE4FhkvJm4CdZbLxlZc1czUdRYd8nhta0gYQ32akIGAWvUBOI4nUGSLmJOaWWY98BtIiOiEvg7hfGY0Vhma3hoKupqMQz782pN2+PgKcQNMVfFB/bixakyNQ90CRJGzKWVCu/zJOmco47S2XJ4cyvGe7+OBuafokOP2e5/SpaIkf/bitas+3LKWETduapoIkoRPJ3DbrCPmCtP+LQz/hRe7LyG++Dv6RQRYmvN82v6MZiZ4N0K3PMEPiCmhIlZPD0hfv7iRgXoWN/PIlMCSFp5BjJkB/EHMX+A==;31:0DLMtWwxmAsyJQIeAYrE5aovtxD6l95EwDFC2RrTTZZXJtk2FcKjUQrbUsKOrSw5XfvN0BDawaLBrwjWkRlQjs6iQDgIquTR1tfIRW5WFB0+SKqF1i75thkFfXvp0lwKI72ldBN2MSqx8uYDbbQMMxgsVMpgtoe5emD0XQGbd7VsqzOvuOFrjorbulxy4jPUTOLxO4pVvnyuBC1hWWSEpCUJ02byhTe2Ph/L/BUUrB8=
X-MS-TrafficTypeDiagnostic: MWHPR04MB0974:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0974;20:XV3dE01efLZnUYXoMAz/qTAETUu1IVHnskuu28dk9gQO6EuN0G87i5pgxBjl48jKKyj5Oi4Bey0XzDhcTlsguJ1tSJMyVdT6byk+H4zP9G7bKyd8EA62ie8dYd74Nwwo9CEaX0aHZYPSDY73kd7oa+D2RcyHS4NJwQwYPtFR0PIuWDboMT/2hMqWGzhPFHqcbD7lU1SW7rr4vGcdgXiFNhmXDd6YP8ORoFlNWX2TcPoDf1fjrVJEvZwr0JqdgPmZwV9efBb161aCMNQT9NhRoVeLitvqEFteTAnrq7brnXRXiRGXFLKY3SwPfYLhr786fDIMk15LN8/9QIDcTPORj5ZswueshePt3I4kNPKzMGLiPI+gqJ5Im8OfvImXct/nN26B+8kQTcT7gaI+6gokDQAsh0pB2VSiJSuaKND40LvR66fb9HNMeZ3XgipKnxLtKZ9/mJo3ii3SUY/xsCuVKEnw1frmlPp7HgaHNdF8mpXuD06C7zKASRHybCC49rgUPP48qeXUMtzg0ALFkyvUaW8nQueATDEeho7cq1LhFNGvWnZF/6mD0ATuWMoEUk7JQooIJ/+MWbB3gv9gAWwJdZzEurvSrtVuQwKCl4F42qE=
X-Microsoft-Antispam-PRVS: <MWHPR04MB0974DE6A7B5DA37CDC05049EF4200@MWHPR04MB0974.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(85827821059158)(788757137089)(42068640409301)(104084551191319)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0974;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0974;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0974;4:W0tvgamT54d8jwlrJdjjHk6GrHQ67kvtEglOWy2ve2JSuiiJEjS4QbqViZAUOI6wySk9Be0TXdM5YUl61WJbHCKEuGUH0g5cfMn0TpDEwhr/geaqJjEYmHHAOP+stxNQ4fWUH1MlcGl0g+/as5XlNXZNad0lin5gR46TC6Fy/LCa7gD20ThFfexoyxkW5/om0LYUC1zQEiTwzjlw5Qo3NsPwCN9TQq9IfPT54DT09ZKToFjTRAJli99rn7YCqUVT2OCfYFE3coYi/3r/e0OIqXgowg/2RVDZ8YsOFWoE2MwqVfs23IJQYe+X6WJ6QiOgBhCSspdJxT7mp2QkbbpgIVm7JVSpiR55J0aJ7eMwYt/D8Ag2R+mdmEjxS35B9sKnT/0RBduQ6jCMyb4anhlT8OlZu7/IX6L8CMJbjjHbTeaCt5yUCldv6QSmb1X3CJ/K3yfvWMN0sjYZO0xb8bZFmdBxGbtdlW7JKXC0abCHHRs=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39850400004)(346002)(366004)(189003)(199004)(305945005)(7736002)(386003)(51416003)(118296001)(36756003)(53936002)(48376002)(68736007)(76176011)(6306002)(2906002)(16586007)(316002)(54906003)(52116002)(47776003)(42186006)(50466002)(50226002)(81166006)(8676002)(81156014)(8936002)(122856001)(39060400002)(4326008)(14444005)(106356001)(105586002)(478600001)(11346002)(966005)(446003)(66066001)(486006)(6266002)(476003)(3846002)(5660300001)(2616005)(6116002)(90966002)(7416002)(186003)(26005)(575784001)(6666003)(52956003)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0974;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR04MB0974;23:++uZyHERYwXrP/4/BFvP3IOSMtu/GesQHEreZAYRr?=
 =?us-ascii?Q?Sj3L2fFuaT8jMYlkh++8II8CRBCZO420RjnRL16AwFpTjarYmqmzjrA6i+he?=
 =?us-ascii?Q?pqnXG5ZnBycVH/RZJxYE1dpFqAO40zEV8SKqTBLmWQ9dOOrlrZr8vqlA0HXZ?=
 =?us-ascii?Q?qgSn7NH+LS2P0VDiNdTDF4K9v4C2Vv2aOmp6K+jmNlrKnYV0AN2++Bf81nWA?=
 =?us-ascii?Q?p5WPv3WTNXenkkRoIOndzKb5aKnq0ByNK+DZSmvsL/YszHbOrUX05yhZMT2t?=
 =?us-ascii?Q?EUNJLjk/6WbGJ3I61YbVQRDwG6gP/p3osH4D7xjbgwVrfaD+tsYxR3gbdPWq?=
 =?us-ascii?Q?I8ETY0gE/Rnm+O54zBOf6BhLzGn0Bc/HlcY5UXm36yv4UWI+hBJQf+s9hw5r?=
 =?us-ascii?Q?CnVxef0UtbaTscrFyPgE0kwDS4r5cBbOThf5YS/HRUb8PBSREjz6sm5KIVCw?=
 =?us-ascii?Q?CLaQfcEvH9bkSbPm8rW0HY/OnKDHHxtKFt0mrtBe28bRjVHBdczF2yC7CqPZ?=
 =?us-ascii?Q?i/yS67D0aZt9JJzDQGAhOSwS+jNQ45iPzi8gOHOtf0KNSOpz8Ez674hEaZR6?=
 =?us-ascii?Q?SNcxBBEkZVL6fspTUM370M8VDlDVTL4GUCLvp20eUh4aI6YG1xGk23Mc3f6j?=
 =?us-ascii?Q?x221VDdkVlFt41UywwEa3V8ieBKOjeCKGTVtH5p4nqLLUb6SmwHpWvruSgca?=
 =?us-ascii?Q?nXK4EQkTpd7ZoIw4qw8ZBncO/DHuhxDMK5jGfBpkN5fn/O9kxyX7uZNHlUhs?=
 =?us-ascii?Q?z68T/TVQBM8AitNTDlIAdxuBYfB6YTWnw5CA4dQGheRHTwXm2kfKW8gWWz95?=
 =?us-ascii?Q?1QJkNC00Gwti8trBtsqjKbrsQms4QffT0EsIDFCmKqiuHZKYRwTnDKLd0oCi?=
 =?us-ascii?Q?/u8le23st8Pxj7cRF4Wv4xxgTVN94aBtqvRC7iz6UNVE+BHB9s9BkIuokiJB?=
 =?us-ascii?Q?bUEbfHO+TYQm/0SObguu7U2IiniMUaQnwgRvFGV6HPksz/lFMLwTFSX1Lkws?=
 =?us-ascii?Q?HOxN39gonw5VdDGCCHt5iy5jbqiC7fMtn1pNA7jmOOdOokYaYtl865LcDE6P?=
 =?us-ascii?Q?BQEsyzpU9ewN9KNu+OPqQkUSIgBI4KCx01fgXWDcSb8k+0RlgU7eNYRkBiFU?=
 =?us-ascii?Q?q42+iU8Lw4dU9FYyGUIVpcYEEjn/fZVvA3fca2Xum2UZVp21HWtG/iDQ093z?=
 =?us-ascii?Q?Sxc6Ne91B8X2fGoZAROxi5EYd8slTIsLTIOjX2oNDdzzDa5cP+WW44mVPPUq?=
 =?us-ascii?Q?wQXgNkkmpaPpp0aiV5jGoZxTiMRXs9E5xSkC/97OSlBbztn5lzrj+/6HDXJ3?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: 5tji+VtoZdDYM3K+Hsi6FhHB/OrdK4r4QwCptkz+KrRTuxiScX6lIcsFz9ipUixLKrKEGt6pxjWIXDBkre8+YjR4eKWfNz5QZwVqlULOHZRdbDEdkyi/v4Ou6bO1cC4hCHn5cj1PzUKRagsFvqTBdOBBpZMWBN2r8nRDU1ETOA1Wknf8UpYqFGPatqDGOtSLk6Q1l4Kg3bV+6nQDyjX1vBx0iu/49uFwU5Vt/PbQqMRiC6B+hHH2Pfd3QWoYR0/iPdzv+zSj1umUhyuINHL5rI+XP3bgoVuINtdVaPUI5nOq0mzoGQYxyIYhfyEPpv6Vbl90Vv4p66XqEzOXx9VBdh0RPzJVRZanpgypl2it/K0=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0974;6:25iZa63WAgqZRUlSjbs/fQQoJK9Kg1nzrKwEUGE7KjsgMheZQLyJtmc1J24EQ0IqFmt81rORhRJQQbb/djLWqzaPEeR1b5xwMOk6H8N5gblpNGCbCY7oDtoo3SvK+IID2tysQCp8W5TGr4lH1e+8Hj/S+nT7JzWFFPRngT6GIzu0Uldr3TYefWH0D9mBiTxtK6M9sQgp6Xg0jF7xBqwNH2p2O8fcpLeLG6w0D0b83dQWCK/ULDYUwRZWAX/BLFj6GussAhcfiwDKYdKO7PyscSwWey9tx5Aw2zYn75BJxSlsnyK4qq7ITwOXuhFEbVrnnppuw9bz1RLVKWA5Nc4mBFbldCHfc4RK6jkTMsl5WsAKK6vmeGEPEYt6BRs67uinSETUJFC1RXYrfkNZqwUT1PEaFwYh24CkDN2aLjUfwSsZoevv/szi2GXfGKFBK64CFBkcnSekE3mIzg8T96rNqQ==;5:Q6WI65YM/4NqshEakCcNM+to9rvZcLHwwJlDsJxKWI2qiinRI67DUJAx22cRK2IrxQ0FUTKL7ucxbMU8s/KkO3DMzLXES8HnLPCU9TShCUQe2b53fHDmwkaIo3OP+rdi4KihFkU8IdMtf7OxEq1DXAPYvjUEcIbeH8pSZybUF0I=;7:OD5dlAV7ldb2ZmKDfWPeAxBKjssjrtTBErrtfyI7R0sIuhbK+i5t+rABndnv++Gnbjxn+ldkKHn+pbz9e+ikEZFeg/HhefnIehQGbW5Ma4X+f8n5h2oDEg9SkP4iQi4OEajNkLF3hf/dkolXSf9K87C3E12vPf7UBcg9UngveCc9Ia2J3GMF7C4RBi76yM43suff7jVKH9OUZpDNx6g6+omF5ATc6Jj+lL0iUgTr848wI/kBVCgNiwa5A2kzkphb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:45.1912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fffe1a03-37df-497c-c1f2-08d5fb7d7872
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0974
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
[ Upstream commit 6b0ef92fee2a3189eba6d6b827b247cb4f6da7e9 ]

When running rcutorture with TREE03 config, CONFIG_PROVE_LOCKING=y, and
kernel cmdline argument "rcutorture.gp_exp=1", lockdep reports a
HARDIRQ-safe->HARDIRQ-unsafe deadlock:

 =============================== WARNING: inconsistent lock state
 4.16.0-rc4+ #1 Not tainted
 --------------------------------
 inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
 takes:
 __schedule+0xbe/0xaf0
 {IN-HARDIRQ-W} state was registered at:
   _raw_spin_lock+0x2a/0x40
   scheduler_tick+0x47/0xf0
...
 other info that might help us debug this:
  Possible unsafe locking scenario:
        CPU0
        ----
   lock(&rq->lock);
   <Interrupt>
     lock(&rq->lock);
  *** DEADLOCK ***
 1 lock held by rcu_torture_rea/724:
 rcu_torture_read_lock+0x0/0x70
 stack backtrace:
 CPU: 2 PID: 724 Comm: rcu_torture_rea Not tainted 4.16.0-rc4+ #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
 Call Trace:
  lock_acquire+0x90/0x200
  ? __schedule+0xbe/0xaf0
  _raw_spin_lock+0x2a/0x40
  ? __schedule+0xbe/0xaf0
  __schedule+0xbe/0xaf0
  preempt_schedule_irq+0x2f/0x60
  retint_kernel+0x1b/0x2d
 RIP: 0010:rcu_read_unlock_special+0x0/0x680
  ? rcu_torture_read_unlock+0x60/0x60
  __rcu_read_unlock+0x64/0x70
  rcu_torture_read_unlock+0x17/0x60
  rcu_torture_reader+0x275/0x450
  ? rcutorture_booster_init+0x110/0x110
  ? rcu_torture_stall+0x230/0x230
  ? kthread+0x10e/0x130
  kthread+0x10e/0x130
  ? kthread_create_worker_on_cpu+0x70/0x70
  ? call_usermodehelper_exec_async+0x11a/0x150
  ret_from_fork+0x3a/0x50

This happens with the following even sequence:

	preempt_schedule_irq();
	  local_irq_enable();
	  __schedule():
	    local_irq_disable(); // irq off
	    ...
	    rcu_note_context_switch():
	      rcu_note_preempt_context_switch():
	        rcu_read_unlock_special():
	          local_irq_save(flags);
	          ...
		  raw_spin_unlock_irqrestore(...,flags); // irq remains off
	          rt_mutex_futex_unlock():
	            raw_spin_lock_irq();
	            ...
	            raw_spin_unlock_irq(); // accidentally set irq on

	    <return to __schedule()>
	    rq_lock():
	      raw_spin_lock(); // acquiring rq->lock with irq on

which means rq->lock becomes a HARDIRQ-unsafe lock, which can cause
deadlocks in scheduler code.

This problem was introduced by commit 02a7c234e540 ("rcu: Suppress
lockdep false-positive ->boost_mtx complaints"). That brought the user
of rt_mutex_futex_unlock() with irq off.

To fix this, replace the *lock_irq() in rt_mutex_futex_unlock() with
*lock_irq{save,restore}() to make it safe to call rt_mutex_futex_unlock()
with irq off.

Fixes: 02a7c234e540 ("rcu: Suppress lockdep false-positive ->boost_mtx complaints")
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/r/20180309065630.8283-1-boqun.feng@gmail.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/locking/rtmutex.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 57361d631749..5e15f5c73637 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2213,11 +2213,12 @@ void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
 {
 	WAKE_Q(wake_q);
 	WAKE_Q(wake_sleeper_q);
+	unsigned long flags;
 	bool postunlock;
 
-	raw_spin_lock_irq(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	postunlock = __rt_mutex_futex_unlock(lock, &wake_q, &wake_sleeper_q);
-	raw_spin_unlock_irq(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	if (postunlock)
 		rt_mutex_postunlock(&wake_q, &wake_sleeper_q);
-- 
2.18.0

