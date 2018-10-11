Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50965C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1853B2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDFngBzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1853B2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbeJKXGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:43 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9393E2087A;
        Thu, 11 Oct 2018 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272340;
        bh=5PM8j9KID4Uzwl0H9+BnEvyDcd5aqJ0WIdg5S5bx5Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDFngBzmmUV+0SxeykoyneZq7hDZhT23dP4ULIaCF8ENYIlKw5U9WOY0LAIESE1Z4
         EwNieJNLrmDkG+nMHZTLGFVTSbEO/OEu6zIFWwTg+R3DesKNIsImEN32w0o/q5ALHj
         EaV1dpmE0SesDfyZF92sbIBWCs/Uhf/rDQcuBrhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiao Ni <xni@redhat.com>,
        Neil Brown <neilb@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 075/120] RAID10 BUG_ON in raise_barrier when force is true and conf->barrier is 0
Date:   Thu, 11 Oct 2018 17:34:16 +0200
Message-Id: <20181011152552.905621547@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiao Ni <xni@redhat.com>

[ Upstream commit 1d0ffd264204eba1861865560f1f7f7a92919384 ]

In raid10 reshape_request it gets max_sectors in read_balance. If the underlayer disks
have bad blocks, the max_sectors is less than last. It will call goto read_more many
times. It calls raise_barrier(conf, sectors_done != 0) every time. In this condition
sectors_done is not 0. So the value passed to the argument force of raise_barrier is
true.

In raise_barrier it checks conf->barrier when force is true. If force is true and
conf->barrier is 0, it panic. In this case reshape_request submits bio to under layer
disks. And in the callback function of the bio it calls lower_barrier. If the bio
finishes before calling raise_barrier again, it can trigger the BUG_ON.

Add one pair of raise_barrier/lower_barrier to fix this bug.

Signed-off-by: Xiao Ni <xni@redhat.com>
Suggested-by: Neil Brown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid10.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4423,11 +4423,12 @@ static sector_t reshape_request(struct m
 		allow_barrier(conf);
 	}
 
+	raise_barrier(conf, 0);
 read_more:
 	/* Now schedule reads for blocks from sector_nr to last */
 	r10_bio = mempool_alloc(conf->r10buf_pool, GFP_NOIO);
 	r10_bio->state = 0;
-	raise_barrier(conf, sectors_done != 0);
+	raise_barrier(conf, 1);
 	atomic_set(&r10_bio->remaining, 0);
 	r10_bio->mddev = mddev;
 	r10_bio->sector = sector_nr;
@@ -4532,6 +4533,8 @@ bio_full:
 	if (sector_nr <= last)
 		goto read_more;
 
+	lower_barrier(conf);
+
 	/* Now that we have done the whole section we can
 	 * update reshape_progress
 	 */


