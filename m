Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18394EB1DCF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FCD213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="RqLUR2Wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FCD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeGLSaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:30:30 -0400
Received: from mail-bn3nam01on0065.outbound.protection.outlook.com ([104.47.33.65]:58436
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbeGLSaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qub23aHgFHOEI+Qmo5pB424R7TJskDDV3Z4JWEhiTjU=;
 b=RqLUR2Wq8G0A+w0ue3VvGX6WSKWaKHPk/TbcY7aY+kJRyXVsYjxmWclJ5YOeHHnHQOG6PisAcju5+b0VGRqQJUWjI13j8qe2wgSRnRawbzGUiamcfupK2TecnlQkBOnq2V222sQQSrx6Cu0nk124jirBBra93VtXr6vGx4tX0LE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (50.233.148.155) by
 BN7PR07MB4369.namprd07.prod.outlook.com (2603:10b6:406:b4::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 18:19:42 +0000
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Yury Norov <ynorov@caviumnetworks.com>,
        "Goutham, Sunil" <Sunil.Goutham@cavium.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nohz: don't kick non-idle CPUs in tick_nohz_full_kick_cpu()
Date:   Thu, 12 Jul 2018 21:19:22 +0300
Message-Id: <20180712181922.23073-1-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.155]
X-ClientProxiedBy: AM4PR0101CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::29) To BN7PR07MB4369.namprd07.prod.outlook.com
 (2603:10b6:406:b4::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 046592d2-21a1-4751-c488-08d5e8240abb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4369;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4369;3:9kx30iQeS7KRBdPy0Dl9BCYYGX/bNCTiUhWRfkRUnSf+bBjb5XBFYNSzo15rw0bFALQ+7vmNqM2YrkR1mp9kCP+vOnnjoPTDlh+eoRdLGXJInwckj1JCNx5kAw+mdXQcJnc/s7O4LiHDF2EGR7l4OJwkeZoFmPiUDZ5MW03y8iwtw6VUPvO3+gNl43UsafckFglXCrZMmAYdJ0nuRKYyNgeP+UVoAbF5MsyZ79KypkFfalrYFAW+hmL+SfzOmuFv;25:fivKplDMI3vvWCAkvZrdmiBPPFOeS6lHOTZkWDq/uH/NOl4rxaL2P7AATeqBR/jgZjW3WI997jaSscxrNrKOL/06V54NtSZx9Zd9kg2d/A077CCH40HWJ6+Gko+mTqUxoYgbnAKea8QaRBrB+zCFGWbIj1wEQlU9So7lYv0Oe0JmlK3r+haRbVYBNQ6ZYA4uH7Wmzn/8fe8YLtfeydjo8Wjj230ce9Ffgt+/lJb+eo5de2/svOS8mX5h6iYBLpl3z+MKjIIebGt8IU2JdsOZZVC8BM7ySW9CuJC/Oz4LfdftaUN1xpXRgHlauXdlv4jDxzZS/AWWrKDt5BM7/2TXkg==;31:ITn/tA2V5l/BmkTCFiZZbypDK7J7sudfHGHj2e56VbuEU9njMI2BrAmf8rny225aJs7NPmRFuOV482JaqeyTVRs1aoLHBUvB9z3lTt67FMenHmgSOJhzXe1u/XerfZY+kXm2jbUi4sULDHdwb0Aw+HtSERWs8ZUfbFuo0Xq6PtxSXs1BW+cKHP/YyBS9krih7KxTCz6UR5Ps8RimdwjIv6xzZ4fzbh7RC4rOkPGxWNM=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4369:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4369;20:Ieb1NBnoSSuf6AL3RkDGNeuDPduQfBf5kDJgpyAVGZ7JlqEpjaTYaOeNAeISIw+xA74v9rvx1qcHDhv+71OIEJ2x/gb3YKsXLPbA9LM4b2I//wVQHphpj1/+sONFFOfT80nBzxc5R8wC2mhIOPteyoxtn0wogAicMpb4zcklODTZCRI+h4lcitqPSNHTNaPvWRZyyauAfR6m9+WKiQSaQYty3BsO1cAKRizIE0T8Mml8AUwtXu4gXuKFhdtAEi0FWUgcv4VbEwe03iKl4qOtWyq64ZsgC4I3RVN/TR/rIuVpqYzQJcAwsxOTQWNLmqmU5xC7XTY/zo1f76/dDQr6YwVae5zj/K9+zOxzUx0uN33zRLJos6JS+aR7+LKbnYP14BWs9Zhv5GQGJ0JiCzfIFV5EkJiG0RUFzSURBM2gZhXYGNefypOKFA8lLqWHD4yKsIkfGo+eiWWtEHDrzCTi3Vl2VUI/bxXe17JyJ6x5n5OlVAfM3ogyPPCxFEW+72WwA1W1C+FG6dhDDdut7Pd60IPda9lEf4qid2XSt5O4X4f4u+4p8Cdwv0jkzhEa8cS2w5/iGOae2yyYLbtSI7HIgsExEaLfIc5zKYLlXJGYqrs=;4:mPvGuSGWO+tURnk9heeeoe+Xz7UxXzQLLLXIMJgSp6veNdR9eG1M+UTVJ8DzpasmleECxkNgcVNuYjnCc1dwkzpXMf/lXYKppZBZydjp7+JAZDW7gufkoDMhI1fcX1cPJwQI4aIozDPG+PrPhbknMRIwR5vp8c81qS8nhvD1pGi0061RC0e7NtSDHfw8uKrLUS9/ydMzoh6BBm8Xi1gFsyQoYM8QScIp5z5flsLWQwHdxDyx1Bp29QNdLghTM7KVCz/AMZjmFXWXjBZembZrgCdn7aH+/mcd4bkOTQXFvw4p0tkcsoaeik2XwMVOSEpp
X-Microsoft-Antispam-PRVS: <BN7PR07MB43695509EAB24276C28847C2E3590@BN7PR07MB4369.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4369;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4369;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(6486002)(51416003)(2906002)(39060400002)(6496006)(3846002)(305945005)(52116002)(106356001)(53936002)(14444005)(42882007)(386003)(26005)(110136005)(316002)(186003)(54906003)(7736002)(4326008)(68736007)(8936002)(105586002)(1857600001)(81156014)(956004)(476003)(2616005)(81166006)(8676002)(50226002)(16526019)(6666003)(47776003)(5660300001)(1076002)(6116002)(966005)(486006)(16586007)(66066001)(72206003)(478600001)(76506005)(25786009)(48376002)(36756003)(50466002)(97736004)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4369;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4369;23:QPrQ5IFUmOsu7W3E82NqKHP0h8RoMqvzlKaMQ5nQF?=
 =?us-ascii?Q?mxEEwbCXw5tf1NijsHLAslIBgmkXTpwoqWUEHZk9MuKz+ku29Y0RJnjAAobZ?=
 =?us-ascii?Q?3BhXmQSxHwsVDtTrTJ75p58vbCBr34q5zjlnVqVIrRQHYeD16iHKQHEUwIJc?=
 =?us-ascii?Q?vRSYCPwcWBi6vWd1vvNYIDWtjm7J2D5Gzf0JUO/HrIZTFTOps1xy7NyVPkk1?=
 =?us-ascii?Q?73vDYdtCDNIuGz6YKPJfRSw/iT2h2nN9eCojpCDsq9H3CYceFXuHts2Oh4DJ?=
 =?us-ascii?Q?wQgERn0MKNkZlbi/IfnCsKSfMLjPkQonZP7ZpKgOih+dbJFP5MpbgZE1qrVT?=
 =?us-ascii?Q?Krjlt60e3e9J15lU1vjemt0IBW8mb1faUTUh2xV4iVl0y3smUR7pwQ/I1V/E?=
 =?us-ascii?Q?/zvo61t1296dx+lM6U3V+5Pi1LSmbt05uqTutub9mBRumd+vOLPLYNC8I4uz?=
 =?us-ascii?Q?ySXnjVO5uy0xOfcP3zFPUnuIDNEUPSZ0GeQC+aa/eP8DyBEGbJ+01/y5uD3i?=
 =?us-ascii?Q?C25EJfDvpcPUPJOfTGuI1/i/8AREgfQW3oPbl26wO+/7s6pLTSCNxESkOy8A?=
 =?us-ascii?Q?62yP+UutXZl9a2RLYnBro+vJbtXW7Fr9bNUT99geOb6H1BgOQFfnlvzUlPb8?=
 =?us-ascii?Q?A4pi9Io1ocq3FiMRi2DHeClOqDutOTDWKdy2yq/3a42elQZVRNH57sBGqLXG?=
 =?us-ascii?Q?8/2RFlvIxhWI5A71Or1RwnJWvW2Z8WDE/YHy8u9hdIdimgM5NnRap35/8f4R?=
 =?us-ascii?Q?YCObLS+s0m7hbIN3Mmxo++W1K5FL+brQJgckTBFIo5kwRRYl6+u8zyZoBb2P?=
 =?us-ascii?Q?RFCBxmM4Z6KQ7jb0QZSB1dYW2CQ2d8LpVuTY87dHnUONXykDfa84XicolX49?=
 =?us-ascii?Q?Q4TaTYHEM2ku/oWhNazeNW7b2nqijzDBB5HPDC1zWFi/hAt1EabUwbeFC4VH?=
 =?us-ascii?Q?ArRCgqJLsrwwH5I24yGGKej0HiSxxbvlLdFdVSW6GHeM7D7o3uZ/2+xadGj6?=
 =?us-ascii?Q?gv6nNeODT3yJATT2+GdA0lQMNgjGewvyatOYvhni+ixqa+WppkRr/ceAID90?=
 =?us-ascii?Q?PvGoS0LzjNV92dbL4G1Zoy8xvmWKnWXueJDNB3iPUdqAgUFEczJAGyJn1usk?=
 =?us-ascii?Q?xRNpAgdvPomqckaK4yVp7DytBNzkgd4ns+V/x7gofAEI2QRM957QgyJqExbI?=
 =?us-ascii?Q?xt1XruQ6Ogqc6++SMj4kcgcBBtk5Le/NKoz8+EwnUvQuI7nexe3+x/Bv0EiY?=
 =?us-ascii?Q?F7oojB4n11YPHPyu+O7KFUFI+k+X28ZEWaAhae4BtYBktOeN3l4KfOVE7/2y?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: w04gADlDowMO+0VJoAkHJn7NNELbe1KB/+EC/csZH8x1Kuus70d5HgebmPAazZnoZFp5DdkLbaiEhXRUxDZhbZdu9PKA5DzwEEmk8D9Brvjbgc8YXN6sSA7g9Q5MJ/HhfQ56aTlJfU/TIPvYDdmVecvLh7Ulmpp1DsdAuivluJEGGTvjILCQ5Y8liDRz/tJVUAlpp0VwwmyrB6DvDiZvhrGw6D6O0JIXN5/EdaEKppwUG9lN9iIU6JVh8UUZsU53BVen9JlFhR7QB7QvLhvIVYibtK2bT19hIlaESVgxqdbucbtyyn063jh9xT6GdMi78lHa+3jFrXKF7ZR4JWP6I40e8KkJnY48RaOCWq5cBdA=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4369;6:W7DixuDYqUUOFxSmkZBhG5h/qLyPWdCiqylF0+nP5NTx21tDBM8AG9p+3jmC/j0Ad60SsY+xo7drx8dXTvOCR1yCnSsW88UDxp8vx2WvsC4e1pUPf3CqgDc/Adjic/rLGUzLxVVdJ2IEEHXNMVca6hIfqO6sPIy5yovsBrrLd8BeFzdIr6eN0G/4dlde9wlM1tN5kh6PMlODjIcWpDVULriuyGhj2x+PWmuerHSbw0Hn7yb8dv0HDTOkIxU5kiLB8FZolcutVwLtE786WBUEvQRVQfjJAMwnaq/1j8YAioyehCWml9OOMiJPhglG8PX46c1ndOey4I0sQd57D5KH8ylh5rK/oBO9DKWWqarVbQzLVWs55S++YQgw/siy93KxBvK20SErzYcy1jm+v4jxr5eoib764cBAX2wrxzR8uvdUecXD/KEma+Yz9FtaQrfOejzy9GddfGo5oRJ9XFik3w==;5:8302Ke4jsEHhXueUjEVH28mxL/gKz1dQ172/gTnzLjpBS2f6Hqb2J5JXxTncXLfNysXNB7pECEYmTfUI6wcoJ9g+MKHSz67L8Z3RDmPfAuv8/aAyNX3d/m8EKXI5Edq2PgoHKeZJA5mWZswCQ+M+rDMcNoFt4tmaqrzylXBsmRw=;24:oPwJIKoGPR15d6gvo/DU78r2zeHxu1wJ9P0dhzkHS5NO5PhGMEGzfej5ggX9LQZUksIg1vJsUCci6UOjdH40Jbiy6YVKF/2yDdmDnxE9YR8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4369;7:Xny+qmLxkFMo25Eo51/D3UTz/Xc4HX9tbOiXumLqp/FX0WTgvPCEOGAUKKh+cI+DL+ZynjJX2S8dk29xnemYG1Jl1wT2KasuuOHPJoOmf8ykGrqy0mtrL4oD99oLOxikKO5Zx4e89goCQg1Y0JPE4A0gSp7dXqT9RnXtidapB2RBO6FDomvx1sSymaZszp5sAri3ld9vbj89d0yEP57Mnl0pN7rX1xGwJZcBDJAWrcxGgtJ8NCc5iOABxya0wPaK
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 18:19:42.7778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 046592d2-21a1-4751-c488-08d5e8240abb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4369
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IIUC, tick_nohz_full_kick_cpu() is intended to wakeup idle CPUs
that will not be poked by scheduler because they are actually
nohz_full.

But in fact this function kicks all CPUs listed in tick_nohz_full_mask,
namely:
 - idle CPUs;
 - CPUs runnung normal tasks;
 - CPUs running isolated tasks [1];

For normal tasks it introduces unneeded latency, and for isolated tasks
it's fatal because isolation gets broken and task receives SIGKILL.

The patch below makes tick_nohz_full_kick_cpu() kicking only idle CPUs.
Non-idle nohz_full CPUs will observe changed system settings just like
non-idle normal (i.e. not nohz_full) CPUs, at next reschedule.

[1] https://lkml.org/lkml/2017/11/3/589

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c026145eba2f..1c24c700e75a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -247,7 +247,7 @@ static void tick_nohz_full_kick(void)
  */
 void tick_nohz_full_kick_cpu(int cpu)
 {
-	if (!tick_nohz_full_cpu(cpu))
+	if (!(tick_nohz_full_cpu(cpu) && idle_cpu(cpu)))
 		return;
 
 	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
-- 
2.17.1

