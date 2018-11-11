Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32D1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8966920818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpvWBUoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8966920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbeKLJ2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:28:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730015AbeKLITv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:51 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE7E722360;
        Sun, 11 Nov 2018 22:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975395;
        bh=qCj6gan9hzBAV6KrmKnmek6xbJSbPkJvAVNbZ7IPzeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpvWBUoC+cRR9ylBpXVGa9XHEYpSHHdwygETpT4iZOTbyIBCVkRJ0YaboZpGdzckv
         OunlCTIG2LJ7D/VlNDTrS/VlPtDy9N2vaWCBByiIlzwgLzt2nlZNSxGqFBCtM2C/Wm
         X/RAbgUdVsmrXReQMCp6vE9fG2VLysix1LUu23iE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Peddell <klightspeed@killerwolves.net>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 082/350] bcache: Populate writeback_rate_minimum attribute
Date:   Sun, 11 Nov 2018 14:19:06 -0800
Message-Id: <20181111221710.552278055@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -263,6 +263,7 @@ STORE(__cached_dev)
 			    1, WRITEBACK_RATE_UPDATE_SECS_MAX);
 	d_strtoul(writeback_rate_i_term_inverse);
 	d_strtoul_nonzero(writeback_rate_p_term_inverse);
+	d_strtoul_nonzero(writeback_rate_minimum);
 
 	sysfs_strtoul_clamp(io_error_limit, dc->error_limit, 0, INT_MAX);
 
@@ -389,6 +390,7 @@ static struct attribute *bch_cached_dev_
 	&sysfs_writeback_rate_update_seconds,
 	&sysfs_writeback_rate_i_term_inverse,
 	&sysfs_writeback_rate_p_term_inverse,
+	&sysfs_writeback_rate_minimum,
 	&sysfs_writeback_rate_debug,
 	&sysfs_errors,
 	&sysfs_io_error_limit,


