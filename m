Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68406C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149E620645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149E620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeIHCGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:06:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbeIHCGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:06:02 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ECAD5EF6;
        Fri,  7 Sep 2018 21:23:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 097/145] block, bfq: return nbytes and not zero from struct cftype .write() method
Date:   Fri,  7 Sep 2018 23:09:23 +0200
Message-Id: <20180907210911.911477386@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

commit fc8ebd01deeb12728c83381f6ec923e4a192ffd3 upstream.

The value that struct cftype .write() method returns is then directly
returned to userspace as the value returned by write() syscall, so it
should be the number of bytes actually written (or consumed) and not zero.

Returning zero from write() syscall makes programs like /bin/echo or bash
spin.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: e21b7a0b9887 ("block, bfq: add full hierarchical scheduling and cgroups support")
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bfq-cgroup.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -913,7 +913,8 @@ static ssize_t bfq_io_set_weight(struct
 	if (ret)
 		return ret;
 
-	return bfq_io_set_weight_legacy(of_css(of), NULL, weight);
+	ret = bfq_io_set_weight_legacy(of_css(of), NULL, weight);
+	return ret ?: nbytes;
 }
 
 #ifdef CONFIG_DEBUG_BLK_CGROUP


