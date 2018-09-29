Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A99C64E93
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 09:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DED2064E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 09:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DED2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeI2PfG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 11:35:06 -0400
Received: from mx01.hxt-semitech.com ([223.203.96.7]:34268 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727638AbeI2PfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 11:35:06 -0400
X-ASG-Debug-ID: 1538212037-093b7e38d1258f40001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id pWpL17WtIcRhbTG7 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 29 Sep 2018 17:07:17 +0800 (CST)
X-Barracuda-Envelope-From: yanjiang.jin@hxt-semitech.com
Received: from controller.hxtcorp.net (10.5.21.105) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 29 Sep 2018 17:07:07 +0800
From:   Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
To:     <jinyanjiang@gmail.com>, <linus.walleij@linaro.org>
CC:     <yanjiang.jin@hxt-semitech.com>, <yu.zheng@hxt-semitech.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] pinctrl: core: make sure strcmp() doesn't get a null parameter
Date:   Sat, 29 Sep 2018 17:06:55 +0800
X-ASG-Orig-Subj: [PATCH] pinctrl: core: make sure strcmp() doesn't get a null parameter
Message-ID: <1538212015-10374-2-git-send-email-yanjiang.jin@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1538212015-10374-1-git-send-email-yanjiang.jin@hxt-semitech.com>
References: <1538212015-10374-1-git-send-email-yanjiang.jin@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.105]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
Content-Transfer-Encoding: 8BIT
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1538212037
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.58608
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers, for example, QCOM's qdf2xxx, set groups[gpio].name only
when gpio is valid, and leave invalid gpio names as null.
If we want to access the sys node "pinconf-groups",
pinctrl_get_group_selector() -> get_group_name() may return a null
pointer if group_selector is invalid, then the below Kernel panic
would happen since strcmp() uses this null pointer to do comparison.

 Unable to handle kernel NULL pointer dereference at ss 00000000
el:Internal error: Oops: 9600000[ 143.080279]
SMP
 CPU: 19 PID: 2493 Comm: read_all Tainted: G O
.aarch64 #1
 Hardware name: HXT Semiconductor HXT REP-2 System
 PC is at strcmp+0x18/0x154
 LR is at pinctrl_get_group_selector+0x6c/0xe8
 Process read_all (pid: 2493, stack limit =
 Call trace:
 Exception stack
  strcmp+0x18/0x154
  pin_config_group_get+0x64/0xd8
  pinconf_generic_dump_one+0xd8/0x1c0
  pinconf_generic_dump_pins+0x94/0xc8
  pinconf_groups_show+0xb4/0x104
  seq_read+0x178/0x464
  full_proxy_read+0x6c/0xac
  __vfs_read+0x58/0x178
  vfs_read+0x94/0x164
  SyS_read+0x60/0xc0
  __sys_trace_return+0x0/0x4
 --[ end trace]--
 Kernel panic - not syncing: Fatal exception

Signed-off-by: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
---
 drivers/pinctrl/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index a3dd777..c6ff4d5 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -627,7 +627,7 @@ static int pinctrl_generic_group_name_to_selector(struct pinctrl_dev *pctldev,
        while (selector < ngroups) {
                const char *gname = ops->get_group_name(pctldev, selector);

-               if (!strcmp(function, gname))
+               if (gname && !strcmp(function, gname))
                        return selector;

                selector++;
@@ -743,7 +743,7 @@ int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
        while (group_selector < ngroups) {
                const char *gname = pctlops->get_group_name(pctldev,
                                                            group_selector);
-               if (!strcmp(gname, pin_group)) {
+               if (gname && !strcmp(gname, pin_group)) {
                        dev_dbg(pctldev->dev,
                                "found group selector %u for %s\n",
                                group_selector,
--
1.8.3.1




This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.


