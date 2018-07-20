Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6C9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38AC206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38AC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbeGTNNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:13:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34614 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeGTNNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:13:18 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 03FFCBBF;
        Fri, 20 Jul 2018 12:25:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+ae590932da6e45d6564d@syzkaller.appspotmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 3.18 10/29] PM / hibernate: Fix oops at snapshot_write()
Date:   Fri, 20 Jul 2018 14:11:05 +0200
Message-Id: <20180720115159.349020328@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720115158.974693829@linuxfoundation.org>
References: <20180720115158.974693829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit fc14eebfc20854a38fd9f1d93a42b1783dad4d17 upstream.

syzbot is reporting NULL pointer dereference at snapshot_write() [1].
This is because data->handle is zero-cleared by ioctl(SNAPSHOT_FREE).
Fix this by checking data_of(data->handle) != NULL before using it.

[1] https://syzkaller.appspot.com/bug?id=828a3c71bd344a6de8b6a31233d51a72099f27fd

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+ae590932da6e45d6564d@syzkaller.appspotmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/power/user.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -184,6 +184,11 @@ static ssize_t snapshot_write(struct fil
 		res = PAGE_SIZE - pg_offp;
 	}
 
+	if (!data_of(data->handle)) {
+		res = -EINVAL;
+		goto unlock;
+	}
+
 	res = simple_write_to_buffer(data_of(data->handle), res, &pg_offp,
 			buf, count);
 	if (res > 0)


