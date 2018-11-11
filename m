Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBC6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E018D223AE
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mToKzI7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E018D223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbeKLIRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730704AbeKLIRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:22 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C69421722;
        Sun, 11 Nov 2018 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975247;
        bh=QBQcP4/n5qSIQTjF5iALs+nYc0r1ICaMnizaYIQ4y9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mToKzI7+3X0bDGIpQIJyvlkyWw71+WSNgwX7HIN3deqFL4XhYqEG4tsS3XY2oLdCQ
         B9ZGRaEajdGHRfhaspkvjjfnAul3Yqved4xCPTW2AZxOHjZNKlYUPeu1uisOi8SvIC
         SBJh3eaxMo6nTOwhw8NlmNoaY+CCQ/0Jlt4NRwDE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Peddell <klightspeed@killerwolves.net>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/361] bcache: Populate writeback_rate_minimum attribute
Date:   Sun, 11 Nov 2018 14:16:56 -0800
Message-Id: <20181111221629.702604471@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Peddell <klightspeed@killerwolves.net>

[ Upstream commit 7567c2a2ad9e80a2ce977eef535e64b61899633e ]

Forgot to include the maintainers with my first email.

Somewhere between Michael Lyle's original
"bcache: PI controller for writeback rate V2" patch dated 07 Sep 2017
and 1d316e6 bcache: implement PI controller for writeback rate,
the mapping of the writeback_rate_minimum attribute was dropped.

Re-add the missing sysfs writeback_rate_minimum attribute mapping to
"allow the user to specify a minimum rate at which dirty blocks are
retired."

Fixes: 1d316e6 ("bcache: implement PI controller for writeback rate")
Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/sysfs.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -285,6 +285,7 @@ STORE(__cached_dev)
 			    1, WRITEBACK_RATE_UPDATE_SECS_MAX);
 	d_strtoul(writeback_rate_i_term_inverse);
 	d_strtoul_nonzero(writeback_rate_p_term_inverse);
+	d_strtoul_nonzero(writeback_rate_minimum);
 
 	sysfs_strtoul_clamp(io_error_limit, dc->error_limit, 0, INT_MAX);
 
@@ -412,6 +413,7 @@ static struct attribute *bch_cached_dev_
 	&sysfs_writeback_rate_update_seconds,
 	&sysfs_writeback_rate_i_term_inverse,
 	&sysfs_writeback_rate_p_term_inverse,
+	&sysfs_writeback_rate_minimum,
 	&sysfs_writeback_rate_debug,
 	&sysfs_errors,
 	&sysfs_io_error_limit,


