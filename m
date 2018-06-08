Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UHZsMGSSGluacAAAmS7hNA
	; Fri, 08 Jun 2018 14:27:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A8FD1607E4; Fri,  8 Jun 2018 14:27:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ISVi5RUb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0F83B60590;
	Fri,  8 Jun 2018 14:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F83B60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeFHO1p (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:27:45 -0400
Received: from mail-ve1eur01on0127.outbound.protection.outlook.com ([104.47.1.127]:3680
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751523AbeFHO1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijVt3ObzcJNZs1C3pOKoCqpAh5UEWTcKUeUj/GbA/Ik=;
 b=ISVi5RUbzDYm24ME61EJz0B0qMhAARlrRIWaV0cGlikOv38+vxXDGqIRvCZfmDXlfp6t/zQSrv+mRD/GKs6CqddC+2awZy0rgHYvjrNQXy4q29Cg9eoB6ne/FwaViBTbvjuqKaZ4UeFr7a2i7+b9mz+k9Ey0VJSp9MNN8dM+Lqo=
Received: from finist_ce7.work (195.214.232.6) by
 VI1PR08MB3117.eurprd08.prod.outlook.com (2603:10a6:803:46::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Fri, 8 Jun 2018 14:27:34 +0000
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: Kirill Gorkunov <kgorkunov@virtuozzo.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fs/lock: show locks taken by processes from another pidns
Date: Fri,  8 Jun 2018 17:27:12 +0300
Message-Id: <20180608142712.32460-3-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180608142712.32460-1-khorenko@virtuozzo.com>
References: <20180608142712.32460-1-khorenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0233.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::33) To VI1PR08MB3117.eurprd08.prod.outlook.com
 (2603:10a6:803:46::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3117;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3117;3:9DCVyB/YqBY7LPMZgZn0cnlZbTAW1D5XfWQW06ElEB+wUnN/ngYtcwcpluqfWlo5tRh1tO3ANfbJqfHBchL6FogSk0l7nPUjYrg95COBLw6XgIlwQscuL88/0er65QkoX+sbx9UQLHWGvsJAoTbqTppb4nqBLwesAKjzor0lgurvyMc7oyc5SjHQ2jab+NJJ4uGM6IlsW5qzlvhZ29nKBqIvuJgMIGSi9Q+kEXO+jLoElbQtw+BPyiUyhWcidYxz;25:50Hy73MBY/hMQ25SyhL6/oWK7dTlh09pFdSKCg9UF7WlAnBqAvPUUmdceA/POM5wGHyojsU4OlBGpLlAd5GnqtvD60kiqEDsheUOFgqOckHsPiYsoGe8uoWTYlJtkmdCXsMyLODHOqplcElbLaHnnauWaFMZEmAKHpV43mXbgakX+aNNd6pXXphn6XS2TVQoGY249XJzwR6QA3pNK7E52kPJA35k95PfDV0gQBNKi12fil34IP+ydkV+R5wGJpwL62QKk4+4wTsuWy+KZSu0oFWWJvaKvekgA5BG3MgKitnF1BcAyMh48GBGcvUW0YcRHu8p4nQKzk+7H3kJWFLPSQ==;31:BLvoV5P/BBeNVk2lebPNG3/Dccu7/VcGq4fjqgfzJYT9I1hlbAhfbsEwFLmCYNekL6S03F5sNllnDtDjvW0IvOvC8dTJiAvP1n/Tjb1vIJO8TjUTSb9N2EDW+rPdmhhc8rCNN7fPkM3y5+qfZHCTq5eYDboTxf0ziHlVzwTmC6bYIpATZLoqFe3bKh8+Ye4WClGjNfoNOYoQmv8AfsRvdHiZX+BXXjHoHOcJ58P8pTg=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3117:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=khorenko@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3117;20:YitkzLYnmrI+2CggdFPgPjPhrdsodkwplTS3BAG5JW56lxTFztFzAeJ5Qt1W2izpNocKOzydfDUyshP+QBRLL58Zed2NZ3gt6ixPF0+CpxfEAVDSCGocqUyVK/Bw89EiTGPZ3EleHRyiURKe2kmi3ZskTZjmOeRugUmFpu20K9yPB4Ro6srGo3TphF3fqNUJRCbvfxpaVovPELtkcxKKbf9rIFPdmg1MRGMkljpby2bPoRO9ZsFjez+bFkqJ+kh1h7cjeM+hOe48x+9EqdX3LOnPnfF70badFnEXquDZaEJMyulbs6sNyh+onFSfxKwYOjyt+xQUHYxvq2iQWMqAPd53nBBiw7o0WHwY4PmEO/hmbs059m3nJPVE/Urv3iOxE4r3fFlbsBPjAAJqPINo5G5cAsv+yQH/HYA4iDoqCFPtf5SVhu6QHnqfwqo7dNHpC7+sKqX3GO7rXCa0GgDNkiwSwcXb1C4VN6p26k/9OJcfdKLl6MoJPHkutXgt/x/M;4:QAG89qngoEHNxmBYQmib8p2BO4nUG+ck8fdjGy5M52D1MqUOqEHZkXtRg5y5G6eS4J8AzEcXbtXJzetrRfts1Jmtm4ISYwXS1qFlTYajme6OIXaFHVLRa5YROby/rw+gyoqkorzNa8doamW0Ii5e4dehD8IIaTkb/U+GUhmywQssNA5jFTKw8LocfMuaBWc4aom3CB+zZeC77bDNm40133+ENUaDbkLvfQAllPJeSuF6CuAFRk8QWSyzChnzDGhoT30ffur4nld/QUP8kFekPA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB31172FF45DB8FEFEDB2241B6C87B0@VI1PR08MB3117.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3117;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3117;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39850400004)(346002)(376002)(199004)(189003)(16526019)(52116002)(51416003)(3846002)(478600001)(1076002)(6116002)(69596002)(386003)(6506007)(66066001)(5660300001)(6512007)(25786009)(47776003)(36756003)(305945005)(8936002)(50226002)(956004)(76176011)(81156014)(8676002)(446003)(81166006)(59450400001)(476003)(48376002)(7736002)(2906002)(53936002)(11346002)(2616005)(68736007)(486006)(106356001)(86362001)(21086003)(6486002)(105586002)(50466002)(316002)(16586007)(26005)(4326008)(110136005)(54906003)(97736004)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3117;H:finist_ce7.work;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3117;23:Dibp5YHioOq6WTDYgWmaKag0BJLDw+C6NJ1ShSFrE?=
 =?us-ascii?Q?fxNta1A326PhK/i/7mse+KqDZbKMEt9AKr/mwXVqj32bP1VXv+3GiaHnaMH3?=
 =?us-ascii?Q?LFjt/dwuK8rxU+2shGQzmQeiNhWm+SdpJfioxJaiPEafza3YfYSRNqdTW7Ww?=
 =?us-ascii?Q?yXG8Jx7evuZCl9NhyVImR4HgFcBU0/z2IPEZjpJhxq3QW22p3NMHO8itqYQU?=
 =?us-ascii?Q?QiZaNBSbIWc3mBU86liNkh32GkmCXNzNfGGf6gADBmbYGHk6andaudR/AWk5?=
 =?us-ascii?Q?WI1Ya2s+b4ZF+DbPEksW3rHkCByJGMl/GCgB+pkE4gfKlSPtcrjY8zRnJaER?=
 =?us-ascii?Q?elRR08z0zMEKiTHxO4Sdnsx2PV4NmcdXfagSRY+stheeOHLSwaluLdx4Os1n?=
 =?us-ascii?Q?nnFHFVu6TsyRzLPE6Vg1IZvHKlMyUOVnSnp0PAy8GM/Rj5rSDBfHkV0yvxVW?=
 =?us-ascii?Q?rDw6x4dgfphK0dQ2bPG/ZsvNwhd0lEDFmWmjkJhFZf3hEfQmwP9FdKuH71/s?=
 =?us-ascii?Q?qTCoJ01ROxwoe7yBMlkMeeMxvHFXiipKZ0oEozmh2i9ikBVDO0Y/7bPH3nEV?=
 =?us-ascii?Q?iTFtD+DvShmJpOMre/QmnE0Zpy+/+tO8PDmuqXcfDd/8l6oGN8VPaA/lIINz?=
 =?us-ascii?Q?qsJvpdgVSvWGmhQnKnCylADR3qY2kaQNwOZmn1sLCHnyv5e1PMVRNl8KN0x4?=
 =?us-ascii?Q?w4VBhQJ97MEoNyKzA5I+Yv7LaITi0NkwyHp+o8eVw37sp2D2dwGgglPyWZJ9?=
 =?us-ascii?Q?A2WFqQ652uajjpDKgxUIptiREpoDlfa1Zasmn0hwPGgpy/tyzF7whOWu5jaC?=
 =?us-ascii?Q?lR5t0CMA79qcq5/+NsjNUUwIyXwdilT9ZotCxECLMCrcspGhw0X/kRYAMO9A?=
 =?us-ascii?Q?yKeo9uZ2TFSbtuxuRLcOWz90e25qlnUbUQ6Xo7Ul98yypiJYSra9xxSNumH1?=
 =?us-ascii?Q?zy6+2/abwABq90iIZH4vMYAbCTqRm9qxU2Sb4UCHojxiv2eRUji+ohoIqNKB?=
 =?us-ascii?Q?5/1yO7EMOXdB4xjV3coxJpx78QJP3ZB4R2Q5c/bEkhIO1DLsVptrd7WAwmXX?=
 =?us-ascii?Q?3fZWFkrX8trFCWh2949HJQh8jc0CQ4O4VtX/Y3HCK8ZA5GH0xJ/DcG5/5BlU?=
 =?us-ascii?Q?ePmG59N8+OmG4jP9mNylp3UbSJ1i2t81ztISfYSinUb4bOnvfdIV+1pwQ9EB?=
 =?us-ascii?Q?jnc3g0v5CqJqqubIU9PsvFG3yNMrIFRO9Ezpjz1PoxEhb5EtlUteNRoO+ahW?=
 =?us-ascii?Q?h2+w0lpmWKFn0PEO+9DWdFM5lkChUx7nqTqqCnI?=
X-Microsoft-Antispam-Message-Info: SUjJtmfdTYrXEshZl8i5twDuRHVQSyXFMcRi4wOjNXHhX92mA+XKFjq28Au9w+Qn8X/34WjUuICxKX7H+fJlUDiENfTLC+HlfF8Z1SnBGEHrqh7SuB16e+q8DhgyyNGPLpdgQxVry2dt7ASiVOOSsgCcPZo1JsGSefiY/D/YLUmB8+UxvZlFgm9OUhuo1/BK
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3117;6:YqEEiTVeyxwwXKWjKs+OUnsZAorpXn/rGpe16av0QRekn4xzpt1XNxxSCHCrbdgCjS4kRoI1K+d47jvMQT8nxT/goMHYrS7uG/F7ZZu0Jni3teF4MkmP1QWl0z2DVT47taHWqcBnpxRcVWuorDKnDIopaLXf+K6jMhkG5De7k/qyov3ApLOdkQvun8nSsuN7N9Q9Gj3v7YFReLnIQnC+YfPOtw0Vz7nPuy7p5CKp/ErVjrf5DDVtnOuAEkn76qjFvm6D4QeefKwLI/ptTUybIKbcmtx5AMDmkNUJ3/LMNNR3mAQL2unJAXff2xRPB+AsGHNxLSjTRi5w2yfFBuTNZluSYXH6F46Eho2Fu7IqM+R/hQ+Evs7sxnZhN/qreCZmyzkWrNuJYnQB0ubwhWfEckniPKoY4LAcw77CYZygqJZSOCXCcuXkoMCZfRrUYZji5ubyHYaNtDbZ7hdFnrhj3g==;5:8Dm6YjsP/ZaQidRirsCpekJYAZ2Nnf6Z8Nd5YV1K/8qrSR06MW4n/3DxrCsLuFXA3pSYmXFz/9GsSOTRcQ5ZVjUh3Ajv6SNLlZC92zKvja9eMXdFbqPwJieV+q43IuTq6KBpYy0OVOwH4zWrP7Q6AaBP3m2iyYhIDJJLNHA7DYM=;24:1IWs8xFRhZzwVmAmxaXFibquq0hO06w+bepqyp7a7KFVl69WmuZ5XdbXGhdAxZDMpIPGupfscTs3iZYqWXzFwQmFAiVavk7XaR72nx3JmOU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3117;7:sOHFMul4j2+rjNb/6YGc2QqEIrjwavVDVRhtsYuZMnWsIFjek7Fy8nEGrCZJWwsbPMVkLQs5gz7TyiQO+1obqyNWid1NpSjoqkQttz7NzxTwWMba8w9ROmWKHXKCZNdACHLWFGsbLIBOCpDcAqGo9MA2JzE4al7TpjGGjXVmQNb7SKEuppNMeLRZlhkNH3qSEwFAGd1uQKtzjRjINp9RVRZwotpcLNwhVO/m4NUrix8D9NNPJRxN7BzSKOYRle5Q;20:a/xE31H1BtFEPyKS0zkvyP63uMufXiBGxjTGnjVaBZm/z1wlTOTPLUbOpAo8Nf9xayZGFB2zPwL/6xFu/7UWhOXbXODNvEeVomx3oFu/i7zSPepI2fWHkbR1DtDkYW92cVP9ZFZxVub7ds7iXtDKVEQAxUm+d/SNfF5kMA3A97I=
X-MS-Office365-Filtering-Correlation-Id: b71fe761-1f82-4054-ffec-08d5cd4bfac4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 14:27:34.7782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b71fe761-1f82-4054-ffec-08d5cd4bfac4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if we face a lock taken by a process invisible in the current
pidns we skip the lock completely, but this

1) makes the output not that nice
    (root@vz7)/: cat /proc/${PID_A2}/fdinfo/3
    pos:    4
    flags:  02100002
    mnt_id: 257
    lock:   (root@vz7)/:

2) makes it more difficult to debug issues with leaked flocks
   if you get error on lock, but don't see any locks in /proc/$id/fdinfo/$file

Let's show information about such locks again as previously, but
show zero in the owner pid field.

After the patch:
===============
(root@vz7)/:cat /proc/${PID_A2}/fdinfo/3
pos:    4
flags:  02100002
mnt_id: 295
lock:   1: FLOCK  ADVISORY  WRITE 0 b6:f8a61:529946 0 EOF

Fixes: 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid for remote locks")
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 fs/locks.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index bfee5b7f2862..e533623e2e99 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2633,12 +2633,10 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 
 	fl_pid = locks_translate_pid(fl, proc_pidns);
 	/*
-	 * If there isn't a fl_pid don't display who is waiting on
-	 * the lock if we are called from locks_show, or if we are
-	 * called from __show_fd_info - skip lock entirely
+	 * If lock owner is dead (and pid is freed) or not visible in current
+	 * pidns, zero is shown as a pid value. Check lock info from
+	 * init_pid_ns to get saved lock pid value.
 	 */
-	if (fl_pid == 0)
-		return;
 
 	if (fl->fl_file != NULL)
 		inode = locks_inode(fl->fl_file);
-- 
2.15.1
