Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898CEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253E7219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="i4JOhWuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253E7219E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeHFL0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:35 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:36172 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729667AbeHFL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:33 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BFsg000413;
        Mon, 6 Aug 2018 04:17:43 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp0016.outbound.protection.outlook.com [216.32.180.16])
        by mx0b-00010702.pphosted.com with ESMTP id 2kn9y5kk7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XMAg5Uui6qqyo1uvaxG8BIUGR2iwMI9fk8c3PmwrMk=;
 b=i4JOhWuD3ngC0Il4cpGAYXDqV+eQL0aEeWMEP8pU7X1xWk7JDrgpWqx5N4SC9fguMT7rEOuoabGVvcbw58TUGIJiR+rALeue4wbNyhfwtiSK9m05MWVutfJ8V5K9POnsCnJutm9N1ckzfa00gfFsaEDP93D6hI2d5Mv/JqgypeE=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 BN6PR04MB0963.namprd04.prod.outlook.com (2603:10b6:405:43::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Mon, 6 Aug 2018 09:17:41 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id C1765302D69; Mon,  6 Aug 2018 04:17:38 -0500 (CDT)
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
        Darren Hart <dvhart@infradead.org>, stable@vger.kernel.org
Subject: [PATCH RT 03/22] futex: Avoid violating the 10th rule of futex
Date:   Mon,  6 Aug 2018 04:17:19 -0500
Message-Id: <ac8090850cdddb1c7a88cb4ec7c730f2bb77365a.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: DM5PR19CA0043.namprd19.prod.outlook.com
 (2603:10b6:3:9a::29) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5681d19-0fa1-40f5-79bd-08d5fb7d7600
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0963;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;3:muqM1OrfanV1f29Rf8FS5Rpn8fSWFm7kkw4ag/uKAXYfur7QUX4n7V0wrRYQ8yUGVnqeKvLFL8jIKSjaVN6P6UHK5FgW5+DZn/xqnIp6awnksenMtA+U1PgalN6NOCbrBnN2MBZMac9l1vbPBNsCavDPdOytTDUiCJrLvgoWAMw59LBsO1fNRmKPEZTmS/uoMfLsKdkOEA4g4oVN/1KLnLwDQ4+1Kvk2Gtg/BAtKUJ/SGM4Y3sdJqdVl4gahMkFq;25:1Opw3z7sdVc4sy71psbi1HucmmaWdL9GOyScOm7287ze3M7Pzn4PtSKauuYDhv3cPt74iC+qcN0yZ2xoOPHj2vBP0XhTpGzJVT82/wIaxvQADlauEE7ATHTlWFTdLXTWvRoBK6xvaQf2d9dp+8ByO5AUXwg44h20mqXvtT1mUIhLDGRmjRulX7m68aUc/H2rk05emAJtjZHFmtSD8xmZSUk/81uCt7ZPNXtOI54NB1r2Fm+K5rS/dXJSu8BMWe/ZngYAzBL2W011Sco63NcAcBywaQ3JN/MdRzV0c+FJIGZ8ArsJh45YFx43GlyfldEFLrDnHXJnGf1BLqRhKDEKMw==;31:jkxLsjnxq7i0TcDlLUve1uwdvpvWltotqq5Vujqa91IXEqizdXSebpfG3/o05bRPs3VW6i5D6djXPL+NiveyWAx6OM3rgVEmA7OpWOaihqZVA5us3xWVwuV1KaxDhJF57nnRnwmyx3ssz/Hpq3cF+U+dfk7pECVwZo6uEN28ReGyMZ43nRpsnxyIo7/Iz6Dkuivp6IqPKzOT83+xrBhv2PMv/aoM7sjMzADl5JVyyGA=
X-MS-TrafficTypeDiagnostic: BN6PR04MB0963:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;20:p8hY77ggWJeTGptdrQnNE57TCJyIso7T/nWIv7lCW5ycOrQcmdV2MX2bQHvm4caG2DeuprLFEbK3r9SWr55k/+pWJvHj6KAOQzQU4YSsd7wz8iEABtF6iklQwYYyZbHVA7py+hJnJzAaDnDmoFZnRQKcObAEThalKdWyCW5PhVcEL4Oyq1Ouz2HW57h1saR5Qp0uEoc17d5HfpF4i1Amw73qr+pu+olR9XAPkmdhfxqL4tMa2g1DDADsgOBrElr2Dx7wxtCdkKRX3kAf1YCc5vUhQnfQH2LjT7cg+QYd86kVvQ0PYTI0eUGDnPGamg37QeHJ41/b3iTeaMJo9L6BABR4unaYlwSO8vGQXT924w3hO5QMsO4TN9Gh0Fb9f1B5iyLJqnmoG7Xn4tn6tE7k2jkqPBJM481+k1viubXHVCPpz5AiXxqgui5aaGc2Y1HTUnYgPS0xzUDo3J2YVnc+bVitmOp/VnqnQ+s8bHxGLyEHDvUsyDlDF8bR9l49U67z4+Gp7I5CAbDVWNF7tw0US1BMXbDjKA8oC9ICL3t5LJoHdqE9EursDLARhBb+9rTn77RqgqHYTatqGhtGF4vnix1mLMhkgXm0GTe0E6fhHA8=
X-Microsoft-Antispam-PRVS: <BN6PR04MB0963BF9E9FB37972E31B28DEF4200@BN6PR04MB0963.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(788757137089)(42068640409301)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR04MB0963;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB0963;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;4:kX47RKFYmYTs+R6YflphR0o1TDWEbgzR0xooScVMIFkSbRPbrnjv7z5uZoeGETBc7k/2514z/914snj14f9awT/dTtBvkbRaJMHX9dqbQTk4URZIcwPIBKVQjFnsycbxuqf2BPoohRNgBj4KneT+ZmWddqWs3CTCDVnS8M7pu4SaLCHntKeJ0MwZnrwbtlGP8MzEZ9lmW37RN4/O4BaJq2YLaqSIOut/OEnTcl/BVPXQTNB/bQZV5kYqtMMMHLMTTBPpR4IjpOoCehyrNJ8uRsAMCwpcwRBcWJm8vHy3DnAa4mWnOiejYK23hjnSch4X+HH/fEP1UxrYbUqELH1ZOJwVfI4soU7ZHkYRszudmssoa0MgM8C3Skrk/El2448X1E3z0ZOA1X/0w0mtT/MU48WVFBV5vO/Sl6fQvbA0+8w=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39850400004)(396003)(199004)(189003)(305945005)(6116002)(76176011)(2906002)(186003)(97736004)(7736002)(50466002)(48376002)(52116002)(51416003)(81166006)(26005)(478600001)(36756003)(8676002)(81156014)(122856001)(966005)(3846002)(316002)(106356001)(53936002)(16586007)(105586002)(6666003)(42186006)(52956003)(7416002)(68736007)(66066001)(47776003)(6266002)(14444005)(575784001)(118296001)(11346002)(5660300001)(4326008)(50226002)(446003)(2616005)(386003)(476003)(486006)(8936002)(90966002)(6306002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0963;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR04MB0963;23:3SQ4ph9QHIDKLGKL7X0K/LB3CgIqtRlqedXACGOYp?=
 =?us-ascii?Q?Gqdi5DkYKMgW7ON5KlzSUTTmOM9c3SX35RTMkEfsBLBUZVZ7Wk0LgbLoHQCb?=
 =?us-ascii?Q?MbLp+xuJTSqjLjxJOrRj/oih7GAjI/CXztECldVbdj2ZhSOJi2NreqFyL1ZQ?=
 =?us-ascii?Q?q3Sea94OwfQIFwIcKU5soUNvLsQQa3wcse9Dsaqxh4gfLRkCTqx6GNbr4w5R?=
 =?us-ascii?Q?/xiDkxpb0chhTr/sR7nG8zlbQY9mx90Tslb9/LpWfBmGee42xaYNM1Ttglon?=
 =?us-ascii?Q?yNuaTEQSUGULpNuMvgWG366JLdPPypgHVDJ92UQqFr7MKZpOE3XUsSkA/PP4?=
 =?us-ascii?Q?Pwp35S3lJxIAlnluxQ7jBDocNs1Cl2fKIZpnG6+dqNOvJGtjotkq1tY1PQ32?=
 =?us-ascii?Q?BsiCV66gxI8J/SYxzak/RGzYOKo2z9mN9fi8qyWnmjqTdtqV7G+Sf/zORH3A?=
 =?us-ascii?Q?WO7k8dUBeeQfqXqocT4zcNAxiayb9W2CxUKK5edh5IjxbzTjNrGgdwE6uswq?=
 =?us-ascii?Q?vUn937q5vn7XiXSJserVcUbwlfey/KcrF8ILu7mnsOozFLjPsCCfVJe9rlF5?=
 =?us-ascii?Q?B1OPYDrOcIHqMu910ESaYPClhUTwVxGOSLVyQkRhMXqSLwuy47P78Xy/6WPw?=
 =?us-ascii?Q?wtS49wjpwE3P+W2ME7+2pzWrqnLLN8Vu5/vfKGGN0HQjP5JPEZFDjcwywqGs?=
 =?us-ascii?Q?AaAhueKRPVGfP/wKCMuivTev2aH0U2c3FeguIyWb2k8CZ/bU+gfz1mynl58t?=
 =?us-ascii?Q?L+/leWQTz1INxHMzA5fhfa/GpA4TXU42SiGGdM9tNQBxg1wNp0yKJ3VLk7d0?=
 =?us-ascii?Q?32Y909pEdQ1mluXKwdKw+KXPe2UPB6CXBZeH/RdaKWPiVrYRjk+Ga3aEcvLu?=
 =?us-ascii?Q?6B78Fo7qnMQbBCpfZ7U8Bhi3xe3tglkJo6zc8vnq6oeJVHNDFwLLfeQOn53t?=
 =?us-ascii?Q?+W/leFnCCE2Bc0shVj3aAF7ljddy/HRB6qxBrVkAlVjjW9kx2rf6Vv/m5yN2?=
 =?us-ascii?Q?GHVaSAvGdzSvqbQbX5h3z7RDTWbGgnCx/UzCheq3XiyykqvQVOTIONdPNzQr?=
 =?us-ascii?Q?PWqNEFgwojggAldlWJSk5RJ4xEkKxqAPa7PCMjG5cl8OKrYs6OU6N29nEkvA?=
 =?us-ascii?Q?ZVlag+XI1WQVu/ZQeeoAbCYQp3N5DEGChdEedEceBGsfc19z7nxymQJe0X+t?=
 =?us-ascii?Q?E/E+ovy//E2fNRGPe1MfgAyd6EDFj2Nxh5mxcZuIocJYorlrpIhc0seR4HLy?=
 =?us-ascii?Q?3P8URzHsIifvuFysFY=3D?=
X-Microsoft-Antispam-Message-Info: U7OJ+TdR1nuwmmyhpAImaeBZuSIscnv7BiE8WlL2uF7IOVL5VZ6vdGtWouqpUWr2L1aZD52kmjQ9W2laOJW1LbKBHpV2KW41Gf+RNSXilV8t0WV7bWhVOn6tCDSmNtqfJNYW/XvV+BxLCOvv+LmUCdtLEQV8GsDYstcQiBqqGFiYLEEnYYndTSwx4hEiZb92vYI0UdWsizmxdt8W547bVlEwomn4UBm4krCd68ug1UAAUQp6eEzY+lL/nJjlyFQiM5NhPjBlWnJpR13lAHM5VOe1eoXY9sibkxl7SQwC2rVdrla78KFl64sBTjRTnvp5hOTfO6PpENXrJDW0aUNrcauu92pR7I+i6SmpbdlFJeA=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0963;6:IYA2+UviOkcP8VjoCVaTyCGtW43kUO8TLDzCm3Kou+RNT+8ZcLeNXLSFTMp38QI81BYanX3ACj1IJfyJ3s1dI83AdoEUCIaZzkYrpTtTDlXgJw31FM8gOrq8o8XUtBTMrECq0XNxqvHHB84mMMwtOAYm3ZMAwnCiCP4jE2CLwI/Bt6rEmYzM0Bkjo9iifJQ2a/+ZRtx2nvtd2GOGKjxYpFeHgsiq1c113Wu4GKjNJu03tDch0gp9f4wrLpmHlaAY2QEg9f9tFI1xJYt0RoqttBC9R37B4cLWHrNB8sv07E5GhW6/AO7D2M2lrm69fGZhhuJx9sa96GPKIUO6pyGRvamMKzuQoyn1Jp7/oxaGP7ngfacfJOPIv7K6b+D45SsrJlnqT7hXfrd7mIY2GFcvWyKztJFDWfyjxAkUMbCuF1tb3b/I1giwe31qAMT33XYpa19V7XwFK11Q8TbdXWMw+w==;5:XHROW4X3+McRFKgVqEwfkWEAU4y9U2Qek4ZxNEFtJus45RswYIT8ZBmdOpma86Hksa3fuzvgMqpMKPvL7dLQnnhrw7sidt1+8qQTXiVQbPRN521R3+elPv88KkYbonxqNSWM/HQWJFI46K2d+hu7HhjisZE19uKV8DrPOHSXKUk=;7:1kmuLfWAqbMziE9lEZzw1uLRDDDcXEQfT71PhTSm+HhRGCGqE/6lNjlgkQlUjWw0tuIALnkN0/ehL7YD3JPlf9RS6oIqVtpNicK9m2OFo8C/y/+inJcXOOkaMY2di4YGx0FqiXWhgvob3MNp8JqOloLNogEOuVU9nY8HMSlhGLBvmThL6e6wSeGnrYwsuAlnN6QV1OoL+jgACeQYQC+iM8i9fkMOGT3pWGtDCF/oSn1OiOfiX47rxHqEc/tSnwCb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:41.1394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5681d19-0fa1-40f5-79bd-08d5fb7d7600
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0963
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

From: Peter Zijlstra <peterz@infradead.org>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
[ Upstream commit c1e2f0eaf015fb7076d51a339011f2383e6dd389 ]

Julia reported futex state corruption in the following scenario:

   waiter                                  waker                                            stealer (prio > waiter)

   futex(WAIT_REQUEUE_PI, uaddr, uaddr2,
         timeout=[N ms])
      futex_wait_requeue_pi()
         futex_wait_queue_me()
            freezable_schedule()
            <scheduled out>
                                           futex(LOCK_PI, uaddr2)
                                           futex(CMP_REQUEUE_PI, uaddr,
                                                 uaddr2, 1, 0)
                                              /* requeues waiter to uaddr2 */
                                           futex(UNLOCK_PI, uaddr2)
                                                 wake_futex_pi()
                                                    cmp_futex_value_locked(uaddr2, waiter)
                                                    wake_up_q()
           <woken by waker>
           <hrtimer_wakeup() fires,
            clears sleeper->task>
                                                                                           futex(LOCK_PI, uaddr2)
                                                                                              __rt_mutex_start_proxy_lock()
                                                                                                 try_to_take_rt_mutex() /* steals lock */
                                                                                                    rt_mutex_set_owner(lock, stealer)
                                                                                              <preempted>
         <scheduled in>
         rt_mutex_wait_proxy_lock()
            __rt_mutex_slowlock()
               try_to_take_rt_mutex() /* fails, lock held by stealer */
               if (timeout && !timeout->task)
                  return -ETIMEDOUT;
            fixup_owner()
               /* lock wasn't acquired, so,
                  fixup_pi_state_owner skipped */

   return -ETIMEDOUT;

   /* At this point, we've returned -ETIMEDOUT to userspace, but the
    * futex word shows waiter to be the owner, and the pi_mutex has
    * stealer as the owner */

   futex_lock(LOCK_PI, uaddr2)
     -> bails with EDEADLK, futex word says we're owner.

And suggested that what commit:

  73d786bd043e ("futex: Rework inconsistent rt_mutex/futex_q state")

removes from fixup_owner() looks to be just what is needed. And indeed
it is -- I completely missed that requeue_pi could also result in this
case. So we need to restore that, except that subsequent patches, like
commit:

  16ffa12d7425 ("futex: Pull rt_mutex_futex_unlock() out from under hb->lock")

changed all the locking rules. Even without that, the sequence:

-               if (rt_mutex_futex_trylock(&q->pi_state->pi_mutex)) {
-                       locked = 1;
-                       goto out;
-               }

-               raw_spin_lock_irq(&q->pi_state->pi_mutex.wait_lock);
-               owner = rt_mutex_owner(&q->pi_state->pi_mutex);
-               if (!owner)
-                       owner = rt_mutex_next_owner(&q->pi_state->pi_mutex);
-               raw_spin_unlock_irq(&q->pi_state->pi_mutex.wait_lock);
-               ret = fixup_pi_state_owner(uaddr, q, owner);

already suggests there were races; otherwise we'd never have to look
at next_owner.

So instead of doing 3 consecutive wait_lock sections with who knows
what races, we do it all in a single section. Additionally, the usage
of pi_state->owner in fixup_owner() was only safe because only the
rt_mutex owner would modify it, which this additional case wrecks.

Luckily the values can only change away and not to the value we're
testing, this means we can do a speculative test and double check once
we have the wait_lock.

Fixes: 73d786bd043e ("futex: Rework inconsistent rt_mutex/futex_q state")
Reported-by: Julia Cartwright <julia@ni.com>
Reported-by: Gratian Crisan <gratian.crisan@ni.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Julia Cartwright <julia@ni.com>
Tested-by: Gratian Crisan <gratian.crisan@ni.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20171208124939.7livp7no2ov65rrc@hirez.programming.kicks-ass.net
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/futex.c                  | 83 ++++++++++++++++++++++++++-------
 kernel/locking/rtmutex.c        | 26 ++++++++---
 kernel/locking/rtmutex_common.h |  1 +
 3 files changed, 87 insertions(+), 23 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 270148be5647..cdd68ba6e3a6 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2287,21 +2287,17 @@ static void unqueue_me_pi(struct futex_q *q)
 	spin_unlock(q->lock_ptr);
 }
 
-/*
- * Fixup the pi_state owner with the new owner.
- *
- * Must be called with hash bucket lock held and mm->sem held for non
- * private futexes.
- */
 static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
-				struct task_struct *newowner)
+				struct task_struct *argowner)
 {
-	u32 newtid = task_pid_vnr(newowner) | FUTEX_WAITERS;
 	struct futex_pi_state *pi_state = q->pi_state;
 	u32 uval, uninitialized_var(curval), newval;
-	struct task_struct *oldowner;
+	struct task_struct *oldowner, *newowner;
+	u32 newtid;
 	int ret;
 
+	lockdep_assert_held(q->lock_ptr);
+
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 
 	oldowner = pi_state->owner;
@@ -2310,11 +2306,17 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 		newtid |= FUTEX_OWNER_DIED;
 
 	/*
-	 * We are here either because we stole the rtmutex from the
-	 * previous highest priority waiter or we are the highest priority
-	 * waiter but have failed to get the rtmutex the first time.
+	 * We are here because either:
+	 *
+	 *  - we stole the lock and pi_state->owner needs updating to reflect
+	 *    that (@argowner == current),
 	 *
-	 * We have to replace the newowner TID in the user space variable.
+	 * or:
+	 *
+	 *  - someone stole our lock and we need to fix things to point to the
+	 *    new owner (@argowner == NULL).
+	 *
+	 * Either way, we have to replace the TID in the user space variable.
 	 * This must be atomic as we have to preserve the owner died bit here.
 	 *
 	 * Note: We write the user space value _before_ changing the pi_state
@@ -2327,6 +2329,42 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	 * in the PID check in lookup_pi_state.
 	 */
 retry:
+	if (!argowner) {
+		if (oldowner != current) {
+			/*
+			 * We raced against a concurrent self; things are
+			 * already fixed up. Nothing to do.
+			 */
+			ret = 0;
+			goto out_unlock;
+		}
+
+		if (__rt_mutex_futex_trylock(&pi_state->pi_mutex)) {
+			/* We got the lock after all, nothing to fix. */
+			ret = 0;
+			goto out_unlock;
+		}
+
+		/*
+		 * Since we just failed the trylock; there must be an owner.
+		 */
+		newowner = rt_mutex_owner(&pi_state->pi_mutex);
+		BUG_ON(!newowner);
+	} else {
+		WARN_ON_ONCE(argowner != current);
+		if (oldowner == current) {
+			/*
+			 * We raced against a concurrent self; things are
+			 * already fixed up. Nothing to do.
+			 */
+			ret = 0;
+			goto out_unlock;
+		}
+		newowner = argowner;
+	}
+
+	newtid = task_pid_vnr(newowner) | FUTEX_WAITERS;
+
 	if (get_futex_value_locked(&uval, uaddr))
 		goto handle_fault;
 
@@ -2427,15 +2465,28 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 		 * Got the lock. We might not be the anticipated owner if we
 		 * did a lock-steal - fix up the PI-state in that case:
 		 *
-		 * We can safely read pi_state->owner without holding wait_lock
-		 * because we now own the rt_mutex, only the owner will attempt
-		 * to change it.
+		 * Speculative pi_state->owner read (we don't hold wait_lock);
+		 * since we own the lock pi_state->owner == current is the
+		 * stable state, anything else needs more attention.
 		 */
 		if (q->pi_state->owner != current)
 			ret = fixup_pi_state_owner(uaddr, q, current);
 		goto out;
 	}
 
+	/*
+	 * If we didn't get the lock; check if anybody stole it from us. In
+	 * that case, we need to fix up the uval to point to them instead of
+	 * us, otherwise bad things happen. [10]
+	 *
+	 * Another speculative read; pi_state->owner == current is unstable
+	 * but needs our attention.
+	 */
+	if (q->pi_state->owner == current) {
+		ret = fixup_pi_state_owner(uaddr, q, NULL);
+		goto out;
+	}
+
 	/*
 	 * Paranoia check. If we did not take the lock, then we should not be
 	 * the owner of the rt_mutex.
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 3a8b5d44aaf8..57361d631749 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1849,6 +1849,19 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	return ret;
 }
 
+static inline int __rt_mutex_slowtrylock(struct rt_mutex *lock)
+{
+	int ret = try_to_take_rt_mutex(lock, current, NULL);
+
+	/*
+	 * try_to_take_rt_mutex() sets the lock waiters bit
+	 * unconditionally. Clean this up.
+	 */
+	fixup_rt_mutex_waiters(lock);
+
+	return ret;
+}
+
 /*
  * Slow path try-lock function:
  */
@@ -1871,13 +1884,7 @@ static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 	 */
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
-	ret = try_to_take_rt_mutex(lock, current, NULL);
-
-	/*
-	 * try_to_take_rt_mutex() sets the lock waiters bit
-	 * unconditionally. Clean this up.
-	 */
-	fixup_rt_mutex_waiters(lock);
+	ret = __rt_mutex_slowtrylock(lock);
 
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
@@ -2102,6 +2109,11 @@ int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
 	return rt_mutex_slowtrylock(lock);
 }
 
+int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
+{
+	return __rt_mutex_slowtrylock(lock);
+}
+
 /**
  * rt_mutex_timed_lock - lock a rt_mutex interruptible
  *			the timeout structure is provided
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 64d89d780059..50c0a1043556 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -122,6 +122,7 @@ extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
 				 struct rt_mutex_waiter *waiter);
 
 extern int rt_mutex_futex_trylock(struct rt_mutex *l);
+extern int __rt_mutex_futex_trylock(struct rt_mutex *l);
 
 extern void rt_mutex_futex_unlock(struct rt_mutex *lock);
 extern bool __rt_mutex_futex_unlock(struct rt_mutex *lock,
-- 
2.18.0

