Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B6F20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B6F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeIHCJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:09:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeIHCJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:09:41 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2AB3BF07;
        Fri,  7 Sep 2018 21:26:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 30/89] dm thin: stop no_space_timeout worker when switching to write-mode
Date:   Fri,  7 Sep 2018 23:09:24 +0200
Message-Id: <20180907210856.072136200@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

commit 75294442d896f2767be34f75aca7cc2b0d01301f upstream.

Now both check_for_space() and do_no_space_timeout() will read & write
pool->pf.error_if_no_space.  If these functions run concurrently, as
shown in the following case, the default setting of "queue_if_no_space"
can get lost.

precondition:
    * error_if_no_space = false (aka "queue_if_no_space")
    * pool is in Out-of-Data-Space (OODS) mode
    * no_space_timeout worker has been queued

CPU 0:                          CPU 1:
// delete a thin device
process_delete_mesg()
// check_for_space() invoked by commit()
set_pool_mode(pool, PM_WRITE)
    pool->pf.error_if_no_space = \
     pt->requested_pf.error_if_no_space

				// timeout, pool is still in OODS mode
				do_no_space_timeout
				    // "queue_if_no_space" config is lost
				    pool->pf.error_if_no_space = true
    pool->pf.mode = new_mode

Fix it by stopping no_space_timeout worker when switching to write mode.

Fixes: bcc696fac11f ("dm thin: stay in out-of-data-space mode once no_space_timeout expires")
Cc: stable@vger.kernel.org
Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-thin.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2514,6 +2514,8 @@ static void set_pool_mode(struct pool *p
 	case PM_WRITE:
 		if (old_mode != new_mode)
 			notify_of_pool_mode_change(pool, "write");
+		if (old_mode == PM_OUT_OF_DATA_SPACE)
+			cancel_delayed_work_sync(&pool->no_space_timeout);
 		pool->out_of_data_space = false;
 		pool->pf.error_if_no_space = pt->requested_pf.error_if_no_space;
 		dm_pool_metadata_read_write(pool->pmd);


