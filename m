Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15A9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EA321841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217218;
	bh=yUaub11QHYhPmz5chVvkaZDQ1OVh6Ce+RL12oQWuIMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2EoUQzN+8JrJ4bY1FldlkplRFhQoHzAhFtaY7KWdj1UUHfsYHb4P9ikgqnJE5ctZi
	 3nJnUi1QtRaDde7yny5TqmIUZmiI85Ix7Y/WbdR0Mz2Q/Ja1YFrXvOTtvKqE9UeX8b
	 CiKNRrZuqrbAfbg0d99q4+RgGf7jNg/coFK4i0XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389691AbfAKOdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389641AbfAKOde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:33:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A522133F;
        Fri, 11 Jan 2019 14:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217213;
        bh=yUaub11QHYhPmz5chVvkaZDQ1OVh6Ce+RL12oQWuIMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jehXyESPsQU6BU9rISossdT2WsMhgj8TLAfQu8jV4NYcU5mq88RrwowPNkvo0XKFd
         DbKp3M6PAH5CQuXTrcnQV+kKrvQFY4BeWVFQo4ozxbOblsQuuJzaahZNqD25gAGuEk
         u+UNwBswT6p5ufcBhERJ8AneaowQCfIXmsckFWok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 4.14 084/105] dlm: fixed memory leaks after failed ls_remove_names allocation
Date:   Fri, 11 Jan 2019 15:14:55 +0100
Message-Id: <20190111131110.007932844@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit b982896cdb6e6a6b89d86dfb39df489d9df51e14 upstream.

If allocation fails on last elements of array need to free already
allocated elements.

v2: just move existing out_rsbtbl label to right place

Fixes 789924ba635f ("dlm: fix race between remove and lookup")
Cc: stable@kernel.org # 3.6

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dlm/lockspace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -680,11 +680,11 @@ static int new_lockspace(const char *nam
 	kfree(ls->ls_recover_buf);
  out_lkbidr:
 	idr_destroy(&ls->ls_lkbidr);
+ out_rsbtbl:
 	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++) {
 		if (ls->ls_remove_names[i])
 			kfree(ls->ls_remove_names[i]);
 	}
- out_rsbtbl:
 	vfree(ls->ls_rsbtbl);
  out_lsfree:
 	if (do_unreg)


