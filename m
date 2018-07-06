Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC49C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6DB2400A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CJ/Y6Rd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6DB2400A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbeGFNhe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:37:34 -0400
Received: from mail-eopbgr20097.outbound.protection.outlook.com ([40.107.2.97]:10448
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932824AbeGFNha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqtSFFjrwvFmssYslMqEHYnJxzmEMh+Bz45xl/STlBo=;
 b=CJ/Y6Rd1uDvwLqJZ+cw+VKlLq54TeRSeel+pElBFTbJdEY8MrSJiXWQkUn3QVce2yjGE1teWoWJLCo91YIQ6oqZ35CZ7MCgAz9Q8iMEX/M4qJJMyKt65fNbP4XFEZ3FGPVP2wioedikLtC3jTpbhcDEoAfk3sP+2zIVA58FfaFM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 VI1PR08MB3264.eurprd08.prod.outlook.com (2603:10a6:803:3d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Fri, 6 Jul 2018 13:37:26 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] nf_conntrack: Fix possible possible crash on module loading.
Date:   Fri,  6 Jul 2018 16:38:53 +0300
Message-Id: <20180706133853.15326-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR02CA0018.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::31) To VI1PR08MB3264.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d8ac91b-f532-42f5-f22d-08d5e3459d04
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3264;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;3:bcqSjY2aVHtAysVRlbVxdTsTUgJ9E/gjj30qYkPjix5WbUHRu9rs3oS0U5Zz06CFcsOf5N87tAJQLfMVgj3yCwIJZLxZ/63HI+XQzky8RxN52UxqS7cg6R5l+ExUMnk78T83XUzvFPf7SlmiT8wg94ztbD3bY0w9qhPNJIMw1WiZcUerZYS7kmsTRLz7DBqqJwb7NfcutUtD0XQPq1tPXrSABgHzaKOm57iAV+Dvy2BNQ+wIV50cpuYD8p5S/IyF;25:aeP+V1O426N01fr0qZyYghNGbYqq01mj9kbienVHthCbWtFEecsNf5sb9rpsPVcJzxH4azMelbQzwsZPg7+X2B1jwafkl7kV1Bu/LjFc0xgej+4Q7Wt1KXMWrLb/fLusIy9zoYyFP4pG9WfFjYuRXC/diwk4G8nU5gFplFSQgX8yERY17oo3ok0ZgAF+C8/SPMzS0RKbzH5JQTIY0YKj1j8PMmmOlAzV3F78e54AfdXWcPTguiGiidftvLZou13mbga0nt3v9H9q7rjCtW0UFODSZCKYAkBAt2OhebYDzF50CyQdXirrvp5NdjAegCqF+Q6FYdKdhua+dEJdDgwJyw==;31:msRdZwURrpXW84XuSmbF6coVXU68FknwqrQ48FExpq+xgQ+l50DZ4rqbxfIybg5nghTh97U2uqrWwkbX73hnX2zX/xOIIG9f4aSrwCJPxJ5K1HNOpF6LZq39NQMmVbOhjfDyhglv5FzIMHuh7Wco1yKq3tODRJHxy5qZKJ/It1b+lLF1s5x7Cpc45DkJfpOWM9NV0/gQ7tgAcD/hPRR49+UbTorCyT4cmJSzclcD2FI=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3264:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:JN/HPX+E7luiqlKpLzrnXJ/nYNgLPLnQRTm8b2EDC0WIdC7bC2UhxnGkoXCTbvaCYwSPMqkq6bsT+O3oDiNGrRkbBMKLenCGe50wnllcde3bGROBlP5MS6Lq28uIcUu+buKcZGtBmA42kjKuqhcCd2ub1ntPUcxk0Yi+qKVASEzUlmNiU4bqlvizOB+O8BXiacmZ23xdTB1xZYNbgHTmOzgbkcMMQDRKnJO/Tdh5JGH9M1SzGP+GW3QS4SlBgZkYudHGE6DldCdc+TV6I9dEeGwyNBCn8ibGe1uaPSR31aOBSZrB1KhVkDREgdgYnA76Koet5LoC4NNI1J7P8Sxao7ndtCVjL0Dhg396o/O/7kXgxzo7rbfy5BzHWUq61VySQbx6cR/fqjcJ06Lb2yTH1tUnhgJxpl2/FFOdzjMZMMtBtofcba8Jl2fZ1wvCm7m3nSbQ4ZZXtpRYYBkyZ1k9QypxG/sasYWIi5ra9cyWET64gAFdGYPD3sCZ+++zcKx0;4:gDamImEhpjzG51vXp1DSxpwPy2lWD5Bo309AHOeKUaQ8uyV6CKJAlvzrZ9hcFhpe+WQPPtMhGc/+bih/Uae8kLd1IaD/fGNhPPDkiZjmr3d+eFE3Jov3ZHqRZDn4ASPcuwR88kW5p+MRhzM9tOAXxx9nmBELGUw+Vxyrf6aEfyj1O+1ImDHiD1g7YPsSmaVaq74XCQHUwekhc3fynD6UXqKIVXFSs5FH/hOBKXxJn2W0xEnByJfZXbAQYutduc8iaWtQrYYJzUD1yQU3dknVtA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3264359D2DAB8D2A64D0989FB0470@VI1PR08MB3264.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231291)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3264;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3264;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(136003)(366004)(396003)(376002)(199004)(189003)(26005)(386003)(575784001)(6666003)(6506007)(51416003)(50466002)(1076002)(105586002)(110136005)(47776003)(478600001)(97736004)(16586007)(476003)(52116002)(4326008)(54906003)(25786009)(7736002)(305945005)(107886003)(316002)(5660300001)(68736007)(486006)(53416004)(186003)(6486002)(8936002)(53936002)(36756003)(50226002)(14444005)(956004)(2906002)(66066001)(16526019)(1857600001)(6512007)(3846002)(48376002)(81166006)(106356001)(86362001)(2616005)(8676002)(6116002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3264;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3264;23:psTxLCzcyY6yP6zxO9BxpfOkNQwK66tPbrdn73mqK?=
 =?us-ascii?Q?04WLtUHiHyw8DJF0VGyVn8H4/45jbW4EttuZNOiW0FztlXZhPR0VFEjZZzhr?=
 =?us-ascii?Q?ik0Mhe0fzE4nkHWs7PLiuoNteiQxXajKwofxiY1qGi8+OqGnDOYwb91+ymrm?=
 =?us-ascii?Q?rwhc1Ggvwz5ysMhQDrW83RVJvlqXcIKaYKoTeqQsDtSI9hcime8WksKhXfGF?=
 =?us-ascii?Q?piviSt5heyv7w7/2PDAYeffIos+EHLvtomtTrjWL8d3+paccvUn+rSgpTQiJ?=
 =?us-ascii?Q?QtIOwnA/nF25VMDffBDPSFscXiJ9tFhSGzY2Qklep3D69Uy2B1nogCEe6Slr?=
 =?us-ascii?Q?WEcyJYeAF1xV8E3w+Povn1aBvoHRM1huNPpc1fEFs68cnXMEnmuoi0A0CYhm?=
 =?us-ascii?Q?G63uEiLRtTk8kMZ6cxbBquOFatmnBe+qslrobfFO3Q4NOzol10GQjMjQ7yLS?=
 =?us-ascii?Q?LLHkC7e1isLyfq0r1aLhMwNVxD3km3y98zb+vIAzEUq2LbbM2pdRa8as16HO?=
 =?us-ascii?Q?eLl023jyvjtONW37jh/zxv15WtrlHZxL5gy/upsrQQG2x5Vk++spR7SsYsZZ?=
 =?us-ascii?Q?KKVrp06oc6KepJtTLg4PPkt2rgkvU2s76yZKfAG3OthxlWT78ULiDeLT8CAy?=
 =?us-ascii?Q?j0EGeuskGftWkvSWPJ4/Kg+IfiXsApgCirYRnZGe1TkPYBPBJVN0s/j45gu6?=
 =?us-ascii?Q?BYBF2zFHAfXfgc3dzSxlXJ+Oam+Hw/MQGUvgyJVjmccFP3LagMX6TCD6Ln7W?=
 =?us-ascii?Q?UE8g8InQkraC0+ei4D/q9iCeJHESAQ3p3ylyqizhNEng+3WgmRf7VnRpk7Be?=
 =?us-ascii?Q?8O+yzqEvHGKPOO3hLYjUetgyeGfSkazSiL9p1hjcVcM0l6k+uKsBu3pYA4Ug?=
 =?us-ascii?Q?c9vN+7n8vfFYRD8Gt16sIeIqO0uK6UgqNfoXv4rdIk/TwQ3t39KC/xCx7S6Q?=
 =?us-ascii?Q?VYpVy5qPKK+uDHJilVqCHdMYiYO9/gByefFAoShaVaeu/uf6bU+ofMXfL10D?=
 =?us-ascii?Q?d0PoOWE/CRklI0Va+KeYr3ik1gep4rHYgZLkb82Hvy8DEWYQYT+Fv+qrX/PP?=
 =?us-ascii?Q?UqYA83hfpiXzfEwl/GbXDgKPMksFSIwOD72gYklgWvotMVmvBbGuA2yGcD1j?=
 =?us-ascii?Q?A7lxTJ3xCsXjDIBg6kU5l90s5Xmp0biFiluT0dXvylHfHXyu5cxLhdTR8e2P?=
 =?us-ascii?Q?M5YX3aGUgUESM82jwC2f/CpBJh6/Muwf/Jb2IthMOUFPaWT+c4IAoq1xJoD4?=
 =?us-ascii?Q?wPjz3XfNs2nx1gs2/G9HC7aMHXLx1W/bD5GV96Z?=
X-Microsoft-Antispam-Message-Info: j8fYiO7smCc6gxrQrpbXkdeCYPu8E0XVw0Hps9MXBa4KKSY89gtVDyOYlo8ghC+RM2cQPLqGYAVzFg4wP3HjhkXXJvbYgOPT/Cc8Msy/B4qUzOZzDEAILIxRrcQHjabkW73NZGC/zn1qTc/a/3falJqLZ4S1Tf0knt4otniCcrauDUJ/+KRWfp5ux7tXRHtDjaUimgQhh8HNMi0HyLoRhivAo7XXBng1qkDSKvjxByczhjG/8MTefkTnl/4/t6i6yFuJIKc72doYdAUaCcE6AckEvd2KtKMZTbLxtODY25b4qrvI6TK4YfIy5LVOW9UTdOXTLrONjXuTUnLuTFAqjnD7Ke4yijdQRNZ1irXDvhY=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;6:LT/xecujQQxVoe8BEK1SAVKJHlfMtSStd361KFbXAMAnjudC8iYMKnfnSocQEHLD8/DoUUseagEcPv2Q02d3W0hN4RKPLNVmeY7Z8SKHF3N5YNpQFyJqAnmWAEuhahQbshd8KuAqyFoooFux3cafSY8OlsI+jgCRB5KYZBV8kP5BqwCCUYxw778bs50YxOdeU18DPm6Aw/PQmSRksSecoU6DNpvMnu1Ogieq46umlYrfWMu6XPh08XPVl9BM1Nc7TiLE2K1qETcQVbnzZwMkr8Faq5JLPAcLHZWh2axU/vCk3w9vKTQ9TURvq8TsTVULIgI/7MURWQjF3nndaysvkKo++2glxp9LB/7OjS+sDmtX9JLy/x5KPu+/We3bQJFuvlYHMbT0IVIaVqPaUhWcVNGk6W+wul2H+affSR3LP65EI+wmx03e/QDKT4XVJZjWBiF0mLH+zEXH8HZwZddPRg==;5:cebaSokgTJazPcqo7RZIM2uUdGlmek5IVTptMYd67mBnufH7osI/9Dd6GZwe/jQCKC72QHKprXEX/VO+j5hInKLNvZxAwf44t7J/B7Quuv4Cp9PVk8cLFJmU8RU636tPZst/fnMO4Q2hn/TwUaqfWnLviZMa5WtzwEkLFpSYkkQ=;24:3iKyCp/Vk2817qIz6J5H5TASgcWH04kk1426teCGRnx5byIWJ1Fv/PNs8RRfnAvzj96JrctKDc0Kl7h/A0jSpcC/E+NCoJqCJ7Za046RMIM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;7:Vy3Z4H0hkAKNT/Z0JnqL7EvDxVDhN8pOj3H1fO33u+nA6j61N9/d8TcWojy/1OK15ky2Dvat3FcpFIoHWJC6xncwunzFq4s7ULwVSoyHdYoAsM1SpU1/OVZB0q4O3hrzM84VdWzv/MolntzaJC2IAny/bwYMIzjP+McG2RfFXgbqa9T/ZKw5NL+apcB+Fz+Ep8U2OB8UufnNx8oLIqPb55wTW3tqVA5lU9j/GnhsbOdA5ur/ivR8a8LpIFLpDZvt;20:qVThC1H/dJABodjh32/Ri0RBgy+XcJrjcrFIqHokn6ZfYc9ltqBtg0LIVK2/miSViau/Oq2q0pkT9V9Vzq112GmQStMi/f+iqfqzGj2uZQBhV4M4SiNJKMPlLJsLLxJv6ok0c8kVQZGwd+daiogwa3b1bEdtxejkn7fWQI5V55c=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 13:37:26.0682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8ac91b-f532-42f5-f22d-08d5e3459d04
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loading the nf_conntrack module with doubled hashsize parameter, i.e.
	  modprobe nf_conntrack hashsize=12345 hashsize=12345
causes NULL-ptr deref.

If 'hashsize' specified twice, the nf_conntrack_set_hashsize() function
will be called also twice.
The first nf_conntrack_set_hashsize() call will set the
'nf_conntrack_htable_size' variable:

	nf_conntrack_set_hashsize()
		...
		/* On boot, we can set this without any fancy locking. */
		if (!nf_conntrack_htable_size)
			return param_set_uint(val, kp);

But on the second invocation, the nf_conntrack_htable_size is already set,
so the nf_conntrack_set_hashsize() will take a different path and call
the nf_conntrack_hash_resize() function. Which will crash on the attempt
to dereference 'nf_conntrack_hash' pointer:

	BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
	RIP: 0010:nf_conntrack_hash_resize+0x255/0x490 [nf_conntrack]
	Call Trace:
	 nf_conntrack_set_hashsize+0xcd/0x100 [nf_conntrack]
	 parse_args+0x1f9/0x5a0
	 load_module+0x1281/0x1a50
	 __se_sys_finit_module+0xbe/0xf0
	 do_syscall_64+0x7c/0x390
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fix this, by checking !nf_conntrack_hash instead of
!nf_conntrack_htable_size. nf_conntrack_hash will be initialized only
after the module loaded, so the second invocation of the
nf_conntrack_set_hashsize() won't crash, it will just reinitialize
nf_conntrack_htable_size again.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 net/netfilter/nf_conntrack_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 6c2d22d63f48..9f52f0e1478b 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2151,7 +2151,7 @@ int nf_conntrack_set_hashsize(const char *val, const struct kernel_param *kp)
 		return -EOPNOTSUPP;
 
 	/* On boot, we can set this without any fancy locking. */
-	if (!nf_conntrack_htable_size)
+	if (!nf_conntrack_hash)
 		return param_set_uint(val, kp);
 
 	rc = kstrtouint(val, 0, &hashsize);
-- 
2.16.4

