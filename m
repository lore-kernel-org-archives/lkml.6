Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B386C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E634F252AC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Q+cFMIYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E634F252AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeFXQ6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:58:19 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:55840
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750997AbeFXQ6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 12:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8IpiQncfUvGCl6f90lUdJdBoE6wG6BD2MJrSmuaZ9w=;
 b=Q+cFMIYp+68gTbOETKYcRTpJcCQWgbJ2UET4ErzbuLL6i8vBtGS9ZB5o0H0K/+jy5AhqkDwEbYxL0BrwQse6runt025sXrhZnhdaQejQ8Bjwu0ONWyFBdml4uz7F6wdE/P4QdjHCu7+RMm3nsAsnDP1anvY52Gs7MnyVkyguF8U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost.localdomain (2601:647:4100:4687:76db:7cfe:65a3:6aea)
 by DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.21; Sun, 24 Jun
 2018 16:58:13 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Add ksig argument to rseq_{signal_deliver,handle_notify_resume}
Date:   Sun, 24 Jun 2018 09:58:00 -0700
Message-Id: <20180624165800.2732-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
X-ClientProxiedBy: BYAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::26) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 101d02b3-d7a6-4cd0-8800-08d5d9f3accf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:AmgT0JRUugGXWl/nu2hCMaTP/yIO2jMkfWCh1D+BNznA2HR9kAP1rJpQu1wsAHQUTcMHTzF0TKciTtAfIzolkIjWBUfAcY/YLGfHPrfzfVSVMaEiNE5POICTgxmbKRAulZKUzuMIGwHjaLmOeqYgQiq6USR3DmM8sCbUR9H0wo7BnEyY5U1Jcn6ic/F1PfQTxCMlTPSHPob/lo+34iuBkVYsxsXKMH4xc74hsJ/pnhROk7swB/7x/qhBx9dzZ+8O;25:3ra73aLUNEsV2OpDWtQ6A2k8YCK8Leiwna5ogvDc8TE29l4lswrbur8WdGVcdYzswXTVnDBkXXFkEBlkHy1Hk6IUmTgp7mvoxVpqOLjgkmSqZ7Spk0ppmxR+L7RuIAaJQY72U/Y2u/at8Ex1sMG+s8LR+w1967vTk2ljmjm1SS0CVwOrFhXqxImYXzKxATwajXFa1qczO8Riw/XG6BQUz9Wcw9/9AYx20juJACtO3VPRFHMmsBjY2hLCHvX/x/SaWFJUR7+NuPijdejLG5x6eWOhDmmN2N20esVppvKxQvTU6LaZQGU0B08LgvmEUBGrfvMz9SikGF7t9impM6wS6w==;31:GyAfjuWrLkPtvifMRECPgdH/t78qQ2yeljGWKIrHk5hlfGT/PY0oz6F1GvYNV4IQiy8D+tX+YUuG3OeifszYQKXVO1UAjy3vMUs9tCu/2edHYiuEdNytusj32QUQN1zrffoPPZ0cZsy8XGx/WsCV48CleY6uMUIWXcH3B527Re1wE9t6JhJMleJCXmKyfWNjOVVCOMU7vuK6/CWi3/aotYRdbi/tRfkVM+Oh02NBncU=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:gGhrdlRxMEKNAaUx9BGyrnV6dDihfUpPHPGAoQzSqKPu/9eYmn6Te9o/+uyDIsbEud+5ho91K8yQmqPA884ySgnRlVRPjxrdl27ZFJC/i0mS1UiQg3ck2X3K0Gfrq58ljINNT99qoIT+VxmjhJ8EMPl3JVWWjyCIfAwO8gA4IR+A2/Z8jT+86C+4CH8UqGhGAjD3fo0xREMOU5w0iyrh6MV8OCCO25m/JEMgXYtfjANN65Qr8UxohGw3dYr4wD6m;4:7HDrAZnqpqFHyuXaovcL9uKNBM/34swZC1a6BLQiwZ6Hd0+x3Q9abRr2UZwkU/edE9qTkoZSYg+cMWiAkqrJpC/W/mj6/mPqyh3dv0BRPFRtfj3OGhqN4MRkF3xpKkuThZYcBJRIFZl856xqaNJ9fBbLwbX7uOUsxC4FiGGbh9NUndAhwdI6w32JAcJ3U06ihDOX1YRNpsDMrYVkLn1VUM+Dl/pyF8jMAkDcx/r8Ro0Y0z6WxrG27BtVS4p1dlTN/4WxytSjN6Wf1wJcAq+lSu2EP0QbfFNDN9V3sVBlEzHvuBP345v/iajBb4mqnkvuzAFUGg8Yi+MKdSDbQ7PFk1rT2SpYwYUU5DhqBB5Po5cxNNN6d7cWIPLmvYKbeYdKwUVyLfm5tKN1NtvAdx+SliDSWyGLpysmmtiC1eJLMKQ=
X-Microsoft-Antispam-PRVS: <DM6PR08MB4939E9D32F023EC6385ECA8AC14B0@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(9452136761055)(85827821059158)(104084551191319);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 0713BC207F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(396003)(39830400003)(376002)(346002)(39380400002)(189003)(199004)(16586007)(97736004)(2351001)(316002)(105586002)(2906002)(50466002)(25786009)(48376002)(54906003)(478600001)(81156014)(8676002)(1076002)(2361001)(6116002)(6512007)(106356001)(8936002)(81166006)(7736002)(36756003)(305945005)(44832011)(16526019)(186003)(50226002)(486006)(6506007)(386003)(53936002)(42882007)(46003)(2616005)(1857600001)(476003)(6916009)(68736007)(6666003)(5660300001)(6486002)(4326008)(39060400002)(47776003)(51416003)(52116002)(52396003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:GdFJajz6Ka0AvWWpg5MZhPE8UiJodCXFE+kGcyeJO?=
 =?us-ascii?Q?BvwO+cRGxwH9+eJyKJORIuFFVXYmy2jwx3uithhR2hPnG2nxcVGF/4Tcf3f6?=
 =?us-ascii?Q?dUWubiqMf5rKR5tjC5NIakI8Kz0CBpZElH/IIH+mBA1QNANr0cPeq3lJvbam?=
 =?us-ascii?Q?7F9elDy5yxSdZItVtcCHqEGmGHVlWmLQsygQ+Z7Ctdjy1IjDqeD7rYQrsWMX?=
 =?us-ascii?Q?PvUBINAPrT6FLNTUOCovkLSsohhFkxEcks+zrCr3QQUm6mXRFGEJJmcvRnGc?=
 =?us-ascii?Q?dXuWJJTm5ktf5v3iE5VFnztIJIqJV6+6Q3OajZmuUrOnFeC5yLZjRgV5GCG9?=
 =?us-ascii?Q?kOn7pCKKM+s+uAdPPiUHUDDAPJkea50atAaFma5w/pyJ1d6F+rMBM0R22xyN?=
 =?us-ascii?Q?skMb9SElkHcr21dfh5UdGxu+Y57a2gHg/af3QXMxtoKkjIuAafPldsSk6Omr?=
 =?us-ascii?Q?zyzhNTV3TbTH1rDObPgfERl5LBjHlPWCAhBCo+/BOj7sKEJyY2hrUkh+qcmY?=
 =?us-ascii?Q?SkzPqW1vB6CUIHhVArahqvkZ/6lC3+78vWqnxX+E8VnWql4ilTWLgOPwXUjG?=
 =?us-ascii?Q?HB3V6o2ZFOF9Uf4G3zXOfa+tRgBQNr6BV13cOMvJcukU/fYjApvBoYCBjZ1L?=
 =?us-ascii?Q?113u8ClofkYgIyaZvVgzpgQyzOQgXD+g1JXHDhpX+q/zsyD9RON1uxWNMLPU?=
 =?us-ascii?Q?2WzFLW8mVC2izHHNOrnA7vh2m8grPG4xxWS5jTHfAK469p0J/lcX8OlC03dz?=
 =?us-ascii?Q?g4XHuDyhjp3MP/dItTL/sUy6fCcW+Y6DG3jVxd1jmfqI//W0YxiarN2QscTO?=
 =?us-ascii?Q?lCvMEYf+/fjdFgel74WvcHZuGbF0FZEESVQQXdN2ex467E6Yipq4kT9NtlNg?=
 =?us-ascii?Q?3vwJyNhO74t/3Q0eZpri9yu+Zf2BcjVnFUKmvpdr9FJU1tPbKwL2ORtz61pF?=
 =?us-ascii?Q?xjBW0Cn3kQryIu6XwhI+mHIHzHQ9/pUm2NcziexTC6D9G+gOIRIcu6/K9zuB?=
 =?us-ascii?Q?X2ayQFya+3F9NtkaEuZtiN0+Nz/HZvoGg4wbWfrGWACI9O2umbwc2f0G3toB?=
 =?us-ascii?Q?5jcEuvYqjVruORd+VoRIIcmdhulPOsDWLfQmESlJPRjPWxQZe9+PqLhv+5zV?=
 =?us-ascii?Q?xH1VQ8rmtNeVGXtOETNRkNEDGj0dYAUIqIrUswftTYnwdMWgk59ajc1SHpS3?=
 =?us-ascii?Q?hGBeTKDXbs6Ew6iSfiUBbgwz//K7NiWpkbJSCTXhT3RSkt1WccV65OIso0PN?=
 =?us-ascii?Q?ESwLA+yob7gQG0Rtv0=3D?=
X-Microsoft-Antispam-Message-Info: KepIOvV3anCi/dlZJPj6rM4xJf8/CC/pdntR4pMgTlF046odFjg/6fGuXjVSsy9en2vXglCRVVrBP3F1qzEVMF0jPjPn6+KyaFYZcbsFSmOcu6nhnhiRt+eGhAZaWNm2sQJF/7V9al4d4dR/fY71MJbDdOxnnqvNxiR4vPGL+vuEE5cUdcjAKsfAHuuvgbm8B2V9X42wG2qS1Z6BVEQ4cUgUClx5cfiI4eTWk8MLQdJghZJEDdwPY+HZWOjZStLJcrB565smYyqXv2FSiVdu9549OHF5rYt1ufJLm8EOqCH/+5DbPVez5sBrdTX6/KS4tQnUsHgEPk9RkcD34Dp5wyINUd3DuFj+5kgwqCGGU/c=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:WDP4C6ZwJlRRzUu8ZHvKe6cjLpy+fVU5YCYWnfPQTq5yu9mtdDBbI5Zj2yxLnedK1SsD6EbrfbpLlRK6KeSjSRgAe9rVw1yrL1RQHqot5CRPjIZSFprz8L10lXCRrTsjMpo0HUOtxkvnnZBom/f8q3PSBe5QE1GQGYJ27vsw28y8UaQ5+ZPWWkvdpfLehmZvgVw8TpXez4dkGjmPn9j4FeRSRzEND7oJ+y0M1Vgz/h2GjdS+DXrRG3D4jC4v+yPZmpqRdnJce1W3BfOR7zE+MFEtoWdENY4vCrTVpBkGtudj5R1GkWTXlZYoi86sOEOJe2vFvnFQq/IkJASaIPHzfAGRzVMGy+YLn2JUm1mGu3CiLE69YTXsfHtyuuN9QcyrUUAEbGjiSbriIf8Te5e5P6lDasGl61DQWFMKguT7e4U5R3ISKd/anALKoKiWOpHwb5dWq7HvkJWShxnnxhSKGw==;5:c0ZBnTe6TbajmmTAq/SQLOPoElasOAc8e1sJmvCC1sv323zIH+HpC4z9UE0ArWL/YAKpziNuV6OHLcQKLsHSR5/6ZP4RaWusDWV4adcRJlDcDyBdKpa187m1HkIasTtOJiIkcK+vWkA8Vg7uf+A3feZRUlAmhLvo663BqSw7PQo=;24:YoTY+CrCbXhI5ICWqEMnkHJfH5hYj7ZxR5jIQ4lkce7VaoNBAoxYNiBQ+StjTaUWhSOTIHj+WOmVgXdGjvP28KMMAU9tv8c0AL/t7oBjsnw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;7:8QSCvlRRUj32H/0ZzYgLPWPbf4cnYPTnp5rmPnohUrSD4VMXc2p8VA2qhgiu0y6B2DQEbxZF1pgCFxYi5oFV9n9+zp+AK5nsZJEZ8M9a0rT1OXopUk4oTybHP8iwTuYEFqzg+sYt0xN+7Rt2fB6cfgPRVuc4NYy0IlVQb7foaWUkzUTMQvE0+LTJl1e0GDvITb8nebpT+SpLJ3XKMOq+c1e7iYeKHgNn7aCu4E9wegx+7WsYeYkwcqsa/nixVMky
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2018 16:58:13.5949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 101d02b3-d7a6-4cd0-8800-08d5d9f3accf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 784e0300fe9f ("rseq: Avoid infinite recursion when delivering
SIGSEGV") added a new ksig argument to the rseq_signal_deliver() &
rseq_handle_notify_resume() functions, and was merged in v4.18-rc2.
Meanwhile MIPS support for restartable sequences was also merged in
v4.18-rc2 with commit 9ea141ad5471 ("MIPS: Add support for restartable
sequences"), and therefore didn't get updated for the API change.

This results in build failures like the following:

    CC      arch/mips/kernel/signal.o
  arch/mips/kernel/signal.c: In function 'handle_signal':
  arch/mips/kernel/signal.c:804:22: error: passing argument 1 of
    'rseq_signal_deliver' from incompatible pointer type
    [-Werror=incompatible-pointer-types]
    rseq_signal_deliver(regs);
                        ^~~~
  In file included from ./include/linux/context_tracking.h:5,
                   from arch/mips/kernel/signal.c:12:
  ./include/linux/sched.h:1811:56: note: expected 'struct ksignal *' but
    argument is of type 'struct pt_regs *'
    static inline void rseq_signal_deliver(struct ksignal *ksig,
                                           ~~~~~~~~~~~~~~~~^~~~
  arch/mips/kernel/signal.c:804:2: error: too few arguments to function
    'rseq_signal_deliver'
    rseq_signal_deliver(regs);
    ^~~~~~~~~~~~~~~~~~~

Fix this by adding the ksig argument as was done for other architectures
in commit 784e0300fe9f ("rseq: Avoid infinite recursion when delivering
SIGSEGV").

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---

 arch/mips/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 00f2535d2226..0a9cfe7a0372 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -801,7 +801,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		regs->regs[0] = 0;		/* Don't deal with this again.	*/
 	}
 
-	rseq_signal_deliver(regs);
+	rseq_signal_deliver(ksig, regs);
 
 	if (sig_uses_siginfo(&ksig->ka, abi))
 		ret = abi->setup_rt_frame(vdso + abi->vdso->off_rt_sigreturn,
@@ -870,7 +870,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
-		rseq_handle_notify_resume(regs);
+		rseq_handle_notify_resume(NULL, regs);
 	}
 
 	user_enter();
-- 
2.17.1

