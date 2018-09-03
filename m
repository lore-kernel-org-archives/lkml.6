Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8B5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAF220645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAF220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbeIDBHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:07:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44262 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbeIDBHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:07:21 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fwviw-0004y2-Ls; Mon, 03 Sep 2018 14:45:26 -0600
Received: from [105.225.206.69] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fwviv-0008G7-Kh; Mon, 03 Sep 2018 14:45:26 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Sep 2018 22:44:25 +0200
Message-Id: <20180903204430.25473-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87musyl3fa.fsf@xmission.com>
References: <87musyl3fa.fsf@xmission.com>
X-XM-SPF: eid=1fwviv-0008G7-Kh;;;mid=<20180903204430.25473-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.225.206.69;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+R4kB7DDxxkwY0WFKRCr7gKz1lcTF6gJI=
X-SA-Exim-Connect-IP: 105.225.206.69
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 05/10] signal: send_sig_all no longer needs SEND_SIG_FORCED
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that send_signal always delivers SEND_SIG_PRIV signals to a pid
namespace init it is no longer necessary to use SEND_SIG_FORCED when
calling do_send_sig_info to ensure that pid namespace inits are
signaled and possibly killed.  Using SEND_SIG_PRIV is sufficient.

So use SEND_SIG_PRIV so that userspace when it receives a SIGTERM can
tell that the kernel sent the signal and not some random userspace
application.

Fixes: b82c32872db2 ("sysrq: use SEND_SIG_FORCED instead of force_sig()")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/tty/sysrq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 06ed20dd01ba..ad1ee5d01b53 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -348,7 +348,7 @@ static void send_sig_all(int sig)
 		if (is_global_init(p))
 			continue;
 
-		do_send_sig_info(sig, SEND_SIG_FORCED, p, PIDTYPE_MAX);
+		do_send_sig_info(sig, SEND_SIG_PRIV, p, PIDTYPE_MAX);
 	}
 	read_unlock(&tasklist_lock);
 }
-- 
2.17.1

