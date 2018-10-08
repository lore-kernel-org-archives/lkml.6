Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4D6C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FF52087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbWp3Soe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FF52087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbeJICFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732099AbeJICFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:04 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED87A2087D;
        Mon,  8 Oct 2018 18:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024716;
        bh=g4EHOwaHPfqBFHJI5i9AB1PZvDWmnbg/QZwdfy/YhAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbWp3SoeCmlZjR9S6c8qKlF3SxJ4OBZIS8ZGDGLK5mcrXIDPZqviclHbs5HWGVxm2
         bVn20IMCc7BrglbdmRhk1DRQHdLWxzkn2DySElKUv3Af1zzaEIN6Hzt5/rdHIIEeZX
         lO1/1ICmLGGtC7aqra2N/fsIihc+u6ZQz4ODXB5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 113/168] dm raid: fix stripe adding reshape deadlock
Date:   Mon,  8 Oct 2018 20:31:33 +0200
Message-Id: <20181008175624.344860454@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit 644e2537fdc77baeeefc829524937bca64329f82 ]

When initiating a stripe adding reshape, a deadlock between
md_stop_writes() waiting for the sync thread to stop and the running
sync thread waiting for inactive stripes occurs (this frequently happens
on single-core but rarely on multi-core systems).

Fix this deadlock by setting MD_RECOVERY_WAIT to have the main MD
resynchronization thread worker (md_do_sync()) bail out when initiating
the reshape via constructor arguments.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-raid.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3869,14 +3869,13 @@ static int rs_start_reshape(struct raid_
 	struct mddev *mddev = &rs->md;
 	struct md_personality *pers = mddev->pers;
 
+	/* Don't allow the sync thread to work until the table gets reloaded. */
+	set_bit(MD_RECOVERY_WAIT, &mddev->recovery);
+
 	r = rs_setup_reshape(rs);
 	if (r)
 		return r;
 
-	/* Need to be resumed to be able to start reshape, recovery is frozen until raid_resume() though */
-	if (test_and_clear_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
-		mddev_resume(mddev);
-
 	/*
 	 * Check any reshape constraints enforced by the personalility
 	 *
@@ -3900,10 +3899,6 @@ static int rs_start_reshape(struct raid_
 		}
 	}
 
-	/* Suspend because a resume will happen in raid_resume() */
-	set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags);
-	mddev_suspend(mddev);
-
 	/*
 	 * Now reshape got set up, update superblocks to
 	 * reflect the fact so that a table reload will


