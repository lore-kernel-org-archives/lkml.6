Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A33C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4519219EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="VpUpDw1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4519219EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeHFL1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:27:46 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47322 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729478AbeHFL00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:26 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BFX0013915;
        Mon, 6 Aug 2018 04:17:48 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp0017.outbound.protection.outlook.com [216.32.180.17])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn9nruyu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAJOFNTl37MB32dDMVE0+vWISHBccvnkdNjPfa0ueD0=;
 b=VpUpDw1GgHxbdpZmI9tmspya6CTPR90D+i2YCu9pvwaTm7baS/ryFFEGBaOCJRFC4OVoEyt7BM3TbdocfPz3qDi5rxQ4JDXiX81SixZq0kP/VswWNMctzXheU+uhdDHnM5LkwWrgC4zOh/v7X/jBBLLTIs2Vuhm/Vt+Ek2jmL6k=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 BN6PR04MB0965.namprd04.prod.outlook.com (2603:10b6:405:43::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Mon, 6 Aug 2018 09:17:45 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id DB63A302D76; Mon,  6 Aug 2018 04:17:38 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RT 07/22] rcu: Suppress lockdep false-positive ->boost_mtx complaints
Date:   Mon,  6 Aug 2018 04:17:23 -0500
Message-Id: <fa640586f03981ed83a1b260742b4cc600342e4a.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: SN4PR0201CA0005.namprd02.prod.outlook.com
 (2603:10b6:803:2b::15) To BN6PR04MB0965.namprd04.prod.outlook.com
 (2603:10b6:405:43::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93f36627-1dec-4cc2-75a1-08d5fb7d784c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0965;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0965;3:Xrd5gfQj4aLN0LHdjipBirXdW5kgjMaKgNgEhyOamzNvepx4vmSzwE0InhYkpaVF2TOmklc+nhb/PUrM6qNZWHVH7AVpRENQXZWU6SLoP7QPIhYjXXCJOcpxYVJPpfLwsSUQIRWqvP5c1QFvjGOGoV61Aw8gWzjipv952lw8ye+Pi3h2G+kQjr0cl5Nat/kDeklDPVcUdSXtFLZFFYj3NwsuvgbO8nuAzoyoyirjtz3baxZsBf41AHuW4zPLu7Ci;25:EZRWAeevPyJggQJwWu/xkjyNeKmI27u6mzVtqpFEIrU85+0HM1Uw9Eb9IPMT0DhkPUw96TSJnYLfVHTgb49/bm+w9FRAAA1a9tn13KZy2BoHumowPscKIm+7gSYyLN4Gm1q4fKcA+Q4cYjdTbhZDB3fwfTJK4Q04pvBCLEmL1Kh/eptb9m0yKxbC4VDb8Ngw2f6Kq1S3o4Yf2MrA6PjKuvWofyW+sMmE+Az+01weDG5ROSbxqOjNDbFb8yDie8K3Zd9Kvur6ruq0PZ1vYaLW+NJ3tMt0FOH/xxOuZjTFbdnGdiY6Qz459dK6WsjMIXropQQEaG7YXcjFrVbwr9qR8Q==;31:78cCt5KSmsGfXFraGjhES1/s/29aT9zbnIDabZiKmdJdJLXVJ5lHoH9q7Y86f9A12NvozQysImMbeRIUDvlSiI9n3Uud3juJlDk1gKwreNHSKuyWyESixa13VMj8jKEF9PCKUvvWxgWCczfP4/nk1rO9x8hM5IW3+t2oP0FvpcjTEWJBtNlk8k80RSHW7Dn+3qYkawadAYubmu8mGACFre63xx5EOwLbp8wai/xWF6k=
X-MS-TrafficTypeDiagnostic: BN6PR04MB0965:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0965;20:pnVogC5VpUiZx8CGT0j8Yaab07KvFqA8AQjjEcrZiv9Jsfyor41yQZs+V5mgd67hJ/1QUL6f2GWDwImg/Pa0hVf9epBNJ7P8/9FWL1po08ZMx9VOUppdl1TLC1RzOepR519N2STgrm/l3rkwRdkQPATeRDkwDDalsFOIwCb/6jmhQZxuynbTB3TP8QyOvy7T1RdmEDgqsEokXOlz1mCJym8zKL6dihNnM87DOtmF98DrfaqgdPANFgi2ZW73pAvKr5dsB85x7WzXMSrBZyaYzhvmPyOYILzOO35Jqxp/X7Fg6GNUUeBlb35ZKi9PFUF6xHBhCnSAltHMtyTp3mMUJmpp0aqMPhMN882jAJQlHUeELrvbGOl8NG0jTMvqyGewJQaOzwHOPB88ROemC0c2QNZFLVMeo73ZWW5uhFe0SIgzxvNe2RvYRaWF5BiNPxljeDKDxizaFD4pnDaAOtW1aLQ31mhqlvmGjtRoO3foO/9gVT9xM9mm3qAqbzLq0UcW831Th2gQBrkuRlEMt5K5nSWt2td/AHGb1aj1kMhFesWfQqMEKimjwexg1uStPH9VJIbP26Rt4q3S9OPDD8C7jbdHD3Uof/tdLggk5QVzzPY=
X-Microsoft-Antispam-PRVS: <BN6PR04MB09655D323D0CBC35C4AD9C7EF4200@BN6PR04MB0965.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR04MB0965;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB0965;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0965;4:r9Wodl5VleaZK8oco+dsOb+fK1qzqdGLOsHyRRFaiIj4hZLmsm/8Pa7s6T/EzULWSgjMoNhhJTdB7vDwkmTiraSogH3PYV2rpOiN/1Aj/8BKmS+OPFdHA2YaaAFIBibDEc3fMs1qrbag0iokTpbxJ9tv5B/7EojODZFeMO28K/vWlBqItXz9VWprsOHHquCMi3J5IROD3UzE1tGVUD037VfAN2z+qDaJiUzwgGEdxLsERB9hlG8CBYSeGO0t7Bi1g8kJ9Ah3gLiDV12EB18rYa/7zLL9nra06Uj1eU4b4nUBtICf0BAp3UQuWxoHf33piG3pqU7+pYeYT4oyZouPlG5lumnRbkdyEkgqnea+fF8=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(346002)(136003)(376002)(189003)(199004)(76176011)(5660300001)(54906003)(14444005)(8936002)(66066001)(50226002)(386003)(118296001)(50466002)(97736004)(51416003)(476003)(7416002)(16586007)(186003)(42186006)(316002)(26005)(52116002)(90966002)(446003)(486006)(11346002)(52956003)(2616005)(6116002)(81156014)(7736002)(305945005)(3846002)(48376002)(478600001)(81166006)(8676002)(47776003)(105586002)(106356001)(122856001)(6666003)(68736007)(4326008)(36756003)(6266002)(2906002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0965;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR04MB0965;23:piAq1gqUoQ/tXyfGOSlEL+PLexm0PtE3eLe2cXzC6?=
 =?us-ascii?Q?/CHyAqLXFP5Um7XgwlN9Uym3Pv4dYaYrWMVLBWPPBCwrAItk1Ahd5TzIt13D?=
 =?us-ascii?Q?lldu5ALVJ47HoeFPcNBX5qsXXIu20czjPiqvjzsPJ1SbnmCB6m7EBfNX0TA/?=
 =?us-ascii?Q?AGobi9dN/aH5RoyLQD8Sgh6R4Ni9VS7D/wOSp7EirPQn/fAiRAAkRhUZqtoo?=
 =?us-ascii?Q?Xr7nz453bwl2oS4jloT06LRdRDBUAdkrJdmj3r9FYQumRsdhKL1I1fmrp+qn?=
 =?us-ascii?Q?0Q+4l1vkc+rHssIUeIbbWgDaJGC68ouRQbV+t5vdNc1b5vV/fhg0bdZ3eQqv?=
 =?us-ascii?Q?3O6SVTu9BTQC2Iv35a4587cgKnux+G3RMJCF7Y8oGPDN5eTUGBdppAYiGtIe?=
 =?us-ascii?Q?3THCH7fJKiJb32mq8dGy95HDSzHEdq8QmAAq6AYMHKPriAhtm8kAgbRfX6Nz?=
 =?us-ascii?Q?fnys5BuWXA8FhKBiyB8gz6lW+VYsT//PW5cyiMBZYK7pv2iVn4JEDdtHDxSw?=
 =?us-ascii?Q?SlAUclkacXHK7eGqhk+FNlusAo4lK7pLMh5gOuPqdDa6eRL69rZLhBJkwTpV?=
 =?us-ascii?Q?CsrCAKF5cmNm4L813KgttS85OvXRMX8i3d15f8i2mWWcm2UpvaV0tO43rTXR?=
 =?us-ascii?Q?ZTt/mXcJKI+mbxe2gg1B5rZd7t134iTcfbGsdxe2DkhUtHWDsMeWaFhsdz6Z?=
 =?us-ascii?Q?wQxYs/BOzWJut2Ctpkqj6oJRw84iK4+NsxgkLQ9hSs6GuGwOaxurVuQVi+Bo?=
 =?us-ascii?Q?owOsmg3CxkJikQm0gy+3XYdgCa2FGhm8eAh2Y/QtH3fDiD+0sU23oiQxxEZP?=
 =?us-ascii?Q?oTyGeoocUZoEZCYhVq+Mugo9Wvga1l3igk4GvC1SsXAvw2SXA5BjlVbI9lvs?=
 =?us-ascii?Q?ncGGZMEBL5oVVTWxnU1WFWyfffAAh3NdPKC+YJOXxR0fo5DlSd7F/smdxp5y?=
 =?us-ascii?Q?zpLzjzdCNuA0QaD4gueRjPLn54G1C5Ee0uUDfREe37U+EdO1HmlX4oOsHGVE?=
 =?us-ascii?Q?wGGZ2dRA5rTgOwECMJ7174VSXixc1vwAVYkxG2xgQ0AfZs9O2MbZ3bglNGQ9?=
 =?us-ascii?Q?f81HvuhSEeDWDXCZ0g131YVjpzKgRIc8Ug7MuLWAHdnT0t3CwayhRgwpWm9m?=
 =?us-ascii?Q?4/UxM+wVHit9zk6ZY6ki5L3UeoLKn7gik68Lx+xMTCgDv7uVv5oMot/5IPD3?=
 =?us-ascii?Q?pX733ISO77NDhs2j054RgIzRdvAhMSCrYJo?=
X-Microsoft-Antispam-Message-Info: pt+J/dVBlWA9PIIGWEvFT0NG6ITwvWfBzZuxVQ7aB2kvGohz5NHmCdNdh2NMRmCBYm4P4NajaK4/yRA3J+1dvnQuMHSrPwstbmsvZoujBW4rO6cXrXofDy0xV+zkMW4y51KkfxjcS/Cs/OklLSQGx4jnOhfWelBsBG8AhTNK9x74BRYr5fOvghNeFf7RF4NntD0PhzqtU1a3VXhaFeINAWx9+WRi7ceJSr+A+TJyIWqNb71WJW76MYsIurBuzwL+qLdWHBGgWYcqXh0QVs7JS8XRB32BxqhZvzGAzhYyjL6HdrH4vlk2Vr4wAwYunEDnsK/zyo+zp/JDKm4k3cC5uuqbF9h193yf9TCBRYFSn+8=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0965;6:tPntTRKM45cxj/ljeyWVuK1yn5h+ArFGVkxTEQKvAwZqmyKlX1oZG5NjluxVJh6KOZAPo0g+eZtY0Xq8k5snDufpVgkUYKRGgSsJZW1AyyRYX74X5+WUJJ5NYAddv27uMPBk2zQGBNZTDUi9AACDauq5+wJQq0JxjoKaicS4b0TDaV05e/3iiazRqpIeuz0uaYWPziS7Nas/CY4ZzzfAbDtIDfEZiiAqYgbLbB/R9t5HKMRT6riDebKASH/0PHHZRr0uXjpwTwlMrICIo+eZ516UTDTvTyX0+WMiuHTLMSpEeW1w7c/5zm9cc/of80qhtuwXlurAEuArelcbb1Gbgt7Zy7An+iY5b4X2l8tOMREMOW4L8dmsr0stNU1GrWskEmLL1z69Ufk5dhzoN8AlPAQDFGmyX7NdLwPf/ZMb1t2V5oLYtup9AqipNhjYU3VAeKj4fMzXtWoxuHQIz/8Lqw==;5:GfYW/WjNA3SaCzzyvUI3gvSpsBvOd+h2tMhj+1ucftSoWMJTm5QHq+9g3tSs/TVaMkS5OtOCDW8BUYKw2C8+NPtVpD55J/SR8yiitCLVZNabMmCqcQ+FN9je64r71Z1ntsCXwnSww1Lu2nS9P914mHMlt1risLnWjXpz9uZrSMA=;7:c/UVtZEjxuFtkmJGQ898dbzeIPhc5Ey53lBOHtoBU6MKJZ4uhdBgSerudZaTwlU6lz9VMAubQOdob4O8Gs39Sd9vf5/lTj5gCqXcrRsASqA3I04QqbacWSj3WIKsBX0F3EOsTNOFkomTBwioT2ZDmh2B62pwncBogY5O+4bmp5GOr05Jsc60+rMQoLpaezK8s4W3VNcfIK9SBEpOwqN0GUr7CB4/ROZfYaUYJEUaYhstszbeT7665khDlYAfhlsP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:45.0085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f36627-1dec-4cc2-75a1-08d5fb7d784c
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

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
[ Upstream commit 02a7c234e54052101164368ff981bd72f7acdd65 ]

RCU priority boosting uses rt_mutex_init_proxy_locked() to initialize an
rt_mutex structure in locked state held by some other task.  When that
other task releases it, lockdep complains (quite accurately, but a bit
uselessly) that the other task never acquired it.  This complaint can
suppress other, more helpful, lockdep complaints, and in any case it is
a false positive.

This commit therefore switches from rt_mutex_unlock() to
rt_mutex_futex_unlock(), thereby avoiding the lockdep annotations.
Of course, if lockdep ever learns about rt_mutex_init_proxy_locked(),
addtional adjustments will be required.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3d18d08e8382..510de72ad8a3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -486,7 +486,7 @@ void rcu_read_unlock_special(struct task_struct *t)
 
 		/* Unboost if we were boosted. */
 		if (IS_ENABLED(CONFIG_RCU_BOOST) && drop_boost_mutex)
-			rt_mutex_unlock(&rnp->boost_mtx);
+			rt_mutex_futex_unlock(&rnp->boost_mtx);
 
 		/*
 		 * If this was the last task on the expedited lists,
-- 
2.18.0

