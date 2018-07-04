Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D537DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6A9208E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="LCL76wmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6A9208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=concurrent-rt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbeGDRf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:35:28 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:13760
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752950AbeGDRfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector1-concurrentrt-com02e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWbbXUOGQcvWHLjLkqhuB5dgwIyboeokdxdRofgI5D0=;
 b=LCL76wmRLhiyPk9UvR3phYj5AkQNYbZfIYGdHyuVqtKQ0FP3pY0+g7S8NNr70CAhbAuTuT171K3ThzOss0GHW4FfHVcvfZtP+mR15jGdZRK1MvD5QBOWr627O3zxLcLcXcO50xXMi0Wh/ounIxQRVg/TTERr96lig1sW07qeVi4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joe.Korty@concurrent-rt.com; 
Received: from zipoli.concurrent-rt.com (12.220.59.2) by
 DM6PR11MB2570.namprd11.prod.outlook.com (2603:10b6:5:c6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Wed, 4 Jul 2018 17:35:22 +0000
Date:   Wed, 4 Jul 2018 13:35:19 -0400
From:   joe.korty@concurrent-rt.com
To:     Julia Cartwright <julia@ni.com>
Cc:     tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RT] sample fix for splat in futex_[un]lock_pi for !rt
Message-ID: <20180704173519.GA24614@zipoli.concurrent-rt.com>
Reply-To: "Joe Korty" <joe.korty@concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Originating-IP: [12.220.59.2]
X-ClientProxiedBy: BN6PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:404:5f::19) To DM6PR11MB2570.namprd11.prod.outlook.com
 (2603:10b6:5:c6::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb2ce6e-5ce1-4f6a-317c-08d5e1d485ac
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB2570;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;3:nCm+NXQiQ2DGqoADOYioqDW8+1FHzCbLk2PodF1OjAZYljDlYDMGnzHMoHiJWEwGb8/vyS5CMziMeUxa4CTqAdcRYnN/rEbXE9k0cJh6Wc8Md/ns2EF2WzAZluZFEm/1r996ej3umgF/PXEUzfPk10o5Y3cCbUNeIf+43GQ/hwA2nuWDLJfsPQuBCYcFG4mao19gasP1qW/s4uqQQdNc7R99oWESKocz1GzUtD9s0B3aw98JlGTWqoGYtLL8v9oO;25:GCOTKjQG1B86dflGdRZBr+FWgZ5O11MBrdYerAN7yhfxVd+sdZpI0GG/ilYBxHlwimvLypREAfD3eIejNLTC99GZVNKDorYXpuQO36fCOC/qkhov/H3YlSE0JsMTnRGe/fBuH05A0MD2JLw0dbEzQTRvj/nuDstpzwskzT04X9Ka749a8JB4xAiGlhl4eibk3G1GtuZXaKyZRiF0kc8WdEERzjnuhtngMcjEGDEx267kQBR/YiUpZkRNESclDvTfsv4ydVv7VpHuYi80szVUYj2FoN46npIF5dM8nZ24rrMOBwBMXyMzBqrupWGsk+dEPwbybbfPoECBXpdQ6PUHTQ==;31:RiryrScHROERQ1MJpKLKeBsaB9V1e7fGz8EmcEKekL/S8sJv0JrjnDZCTRIT2fLOKpP+5ktQXC9Hf5JrOWVfkGdr6Dr5HxacWgUO0Wdi4uHsdccJ/VNc5s7nRYunfInldwmun/KLqMdzUuj8zYJybQbjUrhy1Z3tKEz8p2rloeAE5m4usdf/emkGrjhxwvdMF3Pdy3aT7bo8xU+u5agrbZxMttsGaRE4jrLfsjLT/YM=
X-MS-TrafficTypeDiagnostic: DM6PR11MB2570:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;20:1IAjArZyd7NmrojJOI2J1ZhIUWCluTfuvpGwgYTzafIJMBHeOYAQ7h11BL78sMFNdf7J+6+RFhFn7wQtlwbMg3+PFb/1Vbuq5CFP8sqoqZR/3goMiv+51mKNim6Eahj/k9MxhuYuH/H/wXxvQiKnI7d9j/EKxd2oz0jBpAniNi8IWXFxGiRJPTqeHiDbg82CuIDSPGdRAeLk6XcvYyuYBLn9M1chJfXtPNa5jkUKU+WABXasE7fLm9zBPn/H23dKZCVTgZxVLNE7Vcf2MYPJkVTVqHkIO4oUVLf8XysbWPerSINxiah/F+A21S99O+0fA5/nAoPqgT1p34usflhTaNeHUGKXaSWU8Ed+Kr8qdgTW1Q4dsxhEVcVI/+bYNE3eJ/0NtNwX6z6pHDY7YnMHv9VkZMQ9Ym3f3bKYVH6SCso=;4:7rLDXGmD+wECMxHTDYer4IoztWAy+1HnYwKvrCEhSj2TiG6XTy/ZimvnpXzpE6q+pXzu2iplxd6GTt09qwGpTTrGjCcApZ9owu4VQhQAW8uRDExfgHmNumhlmVJiEOhAN+RBKdFZWpqaQfBtsBhz1hy8ej4JS1yWyT7u7S8DzjWOrRJ67QCD9UutMvh4BmdYMhX/hzIilujNuSfp1iV3As5gQYa2b9bpfhp/7AmvuOrWGJJMbuyxHlsBfbwKSP+ukX2uZ9mHGmNlm8+RLuNXfQ==
X-Microsoft-Antispam-PRVS: <DM6PR11MB2570F8D45C39C60358125B81A0410@DM6PR11MB2570.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR11MB2570;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB2570;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(486006)(6916009)(8936002)(47776003)(16586007)(97736004)(68736007)(50466002)(58126008)(6666003)(33656002)(316002)(5660300001)(7736002)(305945005)(81156014)(81166006)(4326008)(69596002)(25786009)(8676002)(52116002)(7696005)(66066001)(2906002)(386003)(3846002)(26005)(1076002)(6116002)(16526019)(55016002)(186003)(14444005)(9686003)(23726003)(956004)(43066004)(476003)(53416004)(85782001)(478600001)(106356001)(72206003)(105586002)(86362001)(53936002)(18370500001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2570;H:zipoli.concurrent-rt.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR11MB2570;23:0YEdPaOxkUplGK9Sq/83F31lUU0CNjADjqRgPIcJ2?=
 =?us-ascii?Q?8mBXOIkACNPRlP2KfHi6wLpKTAAb9Z14roS5dKQYUR1P/lcWFb2ThtVGLmaT?=
 =?us-ascii?Q?fQa/YeXcP4S9LFKT+UibJj81Ztdu6wl8PqUsDbtwNpl0XOTb0LWNNtqY0EVM?=
 =?us-ascii?Q?g+yMVw9AacJyW/oeKJp/yZNTwvlhxHOplDcujZmVk9obm9EszgD38/UWVemO?=
 =?us-ascii?Q?MLid5jeshGX/2Bi97OGhgBr4PSFtUlEXmZiKCoZu+uFh2HkFX0Z1Tsnz1x9G?=
 =?us-ascii?Q?cj67iKZru83fgg/WyO39aVSOdpqDhkz29c9xeB4ZwVMrW6T3vwv7N9cbmcRi?=
 =?us-ascii?Q?6zfXy3QNQ4/La6qHCFAlSB7EFDI29SSH05z/iH9mEYv2Ek8GTf9XUTukAu0v?=
 =?us-ascii?Q?c04ujItZxiMyUQLwxOduLRbNgl9KRskjkaDcN5fkWYuGTYORD2tCpIErubr4?=
 =?us-ascii?Q?HQ54eVnBBOjLr9wBG2cXaCjnY4VFyUH+y8nFHYPAM2YKdXIqVe2AV2eYi1Fp?=
 =?us-ascii?Q?46yImFow5b9bioCf0r/amz0eOTgfZW+6Elq195ugfdryNrcc2nGhYqs66oAM?=
 =?us-ascii?Q?La1TIp2dxSPrqhrN3WZNyZBkTSKsseRNw6rqHuKcdHt5K4WsXO4igkGchV76?=
 =?us-ascii?Q?+ymu0LoIkwjO1LX7Q0IlLlvfSyHve4msHLjkSm5+eq5hdXdh5rDEuB3DlJ4c?=
 =?us-ascii?Q?fj5rPss1MQtg8LiDeW7DOIs2QCqMLqO7DMswDbQ7DXZprKhTNi7iTRkPlu42?=
 =?us-ascii?Q?kfYyyNj7qndfWNYQ8VxtDOPt7YOwYbPssMX6KshuDOtjlh76D1HRce//DkHJ?=
 =?us-ascii?Q?NfAS2kLLuODgz+R/RJiHXrJEYrJtp/hGlA8zcJ/IKf/E25sXnrShi7WpOVNo?=
 =?us-ascii?Q?OL5DjA+hfSxZ0ahH2t0po2CrYR2vPO8JeRjUOyQJwmErOz25Y+BHTgTGEf4W?=
 =?us-ascii?Q?1B22eXFqyUYU9fpj2M0X7j/h5gYcmmDqCwVJmE+ScX+w5IFkQZs4CPwYSks7?=
 =?us-ascii?Q?ILqAmP69bDj8vWcmbkgYlDJkbx2bZ9PlhoH/eejv+x1/4trfLNDE9T3FeNvh?=
 =?us-ascii?Q?A5lUDCM0fqOuvsn19l7WH7WTBXNdoE8t6Qv2WZ0zV+ryDlHrLLWln8OoF+GW?=
 =?us-ascii?Q?uqBt09eDgcEP9siJwfUrBC6fl7DcQn6kw7k6QRflhqv2EDqECRigASOvEvK+?=
 =?us-ascii?Q?Fglf0NbiUhjf24D+YTPnIUuxucy5vyI0B2fHGR3pzjSgJm5l8MItnYMa7g5+?=
 =?us-ascii?Q?DDo/9HseuPCX9VZnyAQKZb1eXAhslMjMcNrmake?=
X-Microsoft-Antispam-Message-Info: VmjugJFxXp0HaVZDecz29UsFI0nKTAYnxAFdFfc+WwLuP9CyMPYXad9BbGeDKwXxXvXVa+Ni2lk+ORcIVoLGOceuZTU9JqR8kJdrS7jmuv407vW/4SA/GE56PqZo3HeaE9FgjEYIyTbqieGonr8MeF7viyrl3T9zGOAknhmbcB/uoHeCix2AtzqefKnGpsmZ2G7u7Piy8PN9oGxUnkR/zFzHHMmKA75eWE3WEzxW48rA4Ixez1+Oag83T+8INCzmYe3M9WHIc9Kycd0jvty00H8bOmmtmk3mrwUIrP5HM4kzVl/kvTC90wvl+0o1I6tRbwFOtNMlG4oI55KdRRmmyx6LYrI9tO+sVb7pcs2/trs=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;6:mHeR4Nqi5Q14rUYYrNFfuz9PyfhkrZUjun24XBsIxcX2JmjYvHCHorTpzmC5g6lJdKSCY+EGp7ocpbxgdo48Sq1xQSapJ0v7hi4q/RIzUieeARIbTlzbA8qPE+8atxkUuxchDILiwWc6Uz9/RFN0K1HA15GJ+I2N0SeEqkUZEhRheVJuyj3HXzXGyxnJn7FdDsHd/YKMtZXdq3+Dv/gfwkoDGWyu/2vqKEwZNVjO3TmRwq8Jr4QBmX+mu9jc6vqxwXwOrEj2u5DlFaRCdnsIjidYCz8x62da6xS8WGI/5ZazSAhZblIw/+TBRD6edkXXuidt8VbidzGzNAKVTX4BNn+5AhanOnoZypEA0TiYuNhcvFbw2b/E01qgkFzc+5WBYVV06Mx2oqUQ1VF8HLPVJqRb8pjBngr0Sl6gnfLtWpHd9Kl2BEAY77/svusGm1We+b1kkhpyA8t9TflBPwPQww==;5:9R67hqbiVM/dAHFauiNHRQqm2+0gfJPYLnr316C4B3UGtSHOPySF4Wf9alFmU2X4xHL1WVRpBdrvGDmfjSexLIxFFsu7DwO2z4geLXae2KtFiRVu/vKu+XHgxDdYarKwIgSg/f7gFiwhrxCocgdfbutmZvYEYBtN+vEqV9PPgt4=;24:BWx65AGAZ8qGTR/omzkaaytOChPdWBdiNA2ogDd7blUOFn1E0EUELXppx9hL4b34YrT9wOYEhyBZBynj6WKZtSzpg0GGkIS7x0ZAyh3NVeA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;7:Cvsa1bnzQ2Xt84bFJ7Ul+E+0t9oYnSimnr4YBfJ6YeXZEtn0qqdqPZxSk2E9lXvJF8dtGzn963NZqdsM2iut8UUUKfB22Nxi1KUyaQdeOLwnFss7sOHOFD16wNeSt3sUM/LzZkI4sTe6wQzu2WpGhRzCfnKYUdzTAFd4F9R5oWb5B0LJiCmD1SFKSL9Y5fJGWssynZGb34h77I8Ioo7CH74VGLNdsUmTD3gARlntG2ZOIZu5I1LtUrpFRCORaYv7
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 17:35:22.9470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb2ce6e-5ce1-4f6a-317c-08d5e1d485ac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2570
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balance atomic/!atomic migrate_enable calls in futex_[un]lock_pi.

The clever use of migrate_disable/enable in rt patch

  "futex: workaround migrate_disable/enable in different"

has balanced atomic/!atomic context only for the rt kernel.
This workaround makes it balanced for both rt and !rt.

The 'solution' presented here is for reference only.
A better solution might be for !rt to go back to using
migrate_enable/disable == preempt_enable/disable.
This patch passes the futex selftests for rt and !rt.

Sample kernel splat, edited for brevity.  This happens
near the end of boot on a CentOS 7 installation.

   WARNING: CPU: 1 PID: 5966 at kernel/sched/core.c:6994 migrate_enable+0x24e/0x2f0
   CPU: 1 PID: 5966 Comm: threaded-ml Not tainted 4.14.40-rt31 #1
   Hardware name: Supermicro X9DRL-3F/iF/X9DRL-3F/iF, BIOS 3.2 09/22/2015
   task: ffff88046b67a6c0 task.stack: ffffc900053a0000
   RIP: 0010:migrate_enable+0x24e/0x2f0
   RSP: 0018:ffffc900053a3df8 EFLAGS: 00010246

   Call Trace:
    futex_unlock_pi+0x134/0x210
    do_futex+0x13f/0x190
    SyS_futex+0x6e/0x150
    do_syscall_64+0x6f/0x190
    entry_SYSCALL_64_after_hwframe+0x42/0xb7


   WARNING: CPU: 1 PID: 5966 at kernel/sched/core.c:6998 migrate_enable+0x75/0x2f0
   CPU: 1 PID: 5966 Comm: threaded-ml Tainted: G        W       4.14.40-rt31 #1
   Hardware name: Supermicro X9DRL-3F/iF/X9DRL-3F/iF, BIOS 3.2 09/22/2015
   task: ffff88046b67a6c0 task.stack: ffffc900053a0000
   RIP: 0010:migrate_enable+0x75/0x2f0
   RSP: 0018:ffffc900053a3df8 EFLAGS: 00010246

   Call Trace:
    futex_unlock_pi+0x134/0x210
    do_futex+0x13f/0x190
    SyS_futex+0x6e/0x150
    do_syscall_64+0x6f/0x190
    entry_SYSCALL_64_after_hwframe+0x42/0xb7

This patch was developed against 4.14.40-rt31.  Should be
applicatible to all rt releases in which migrate_enable !=
preempt_enable for !rt kernels.

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>

Index: b/kernel/futex.c
===================================================================
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2838,7 +2838,14 @@ retry_private:
 	spin_unlock(q.lock_ptr);
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
+#ifdef CONFIG_PREEMPT_RT_FULL
 	migrate_enable();
+#else
+	/* !rt has to force balanced atomic/!atomic migrate_enable/disable uses */
+	preempt_disable();
+	migrate_enable();
+	preempt_enable();
+#endif
 
 	if (ret) {
 		if (ret == 1)
@@ -2998,7 +3005,14 @@ retry:
 		/* drops pi_state->pi_mutex.wait_lock */
 		ret = wake_futex_pi(uaddr, uval, pi_state);
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+		migrate_enable();
+#else
+		/* !rt has to force balanced atomic/!atomic uses */
+		preempt_disable();
 		migrate_enable();
+		preempt_enable();
+#endif
 
 		put_pi_state(pi_state);
 

