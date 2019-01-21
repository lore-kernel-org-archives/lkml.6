Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525D3C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D2820989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079442;
	bh=j5TUYuMAxUwgwysHUcHNI22cICAIxBgOktklSF7C2NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D4hZXx74bvo/TY9m34J976bjk8fkSixcmHB2xZ6D5pJDePFrhNxB0MdkyPyvokIQH
	 ZGi0bBYLWdc5Wfk//eN4yvqGGKJakFeG91nXt0iIKDIlTwAQS/9L9Jf6XIpfYz22FN
	 jlkBYmBYFt4qImWGbQ4eMpFptAC6NKsiL8U69dDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbfAUOCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:02:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731860AbfAUOCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A7C2089F;
        Mon, 21 Jan 2019 14:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079354;
        bh=j5TUYuMAxUwgwysHUcHNI22cICAIxBgOktklSF7C2NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQP256p9R9xml+2WPEV+0LXVJ+MiX4e+xQYIQ5YQ+3+k6F/88Q2ahGiwydzra1KBR
         P8jqb+pLpNIWzJMvySz8ohM57av6ebdXlrEr6U0EaCOcjEn16gnSOOy1l1+8QrF70Y
         0rheemdSENVUe2M+PpnfZjPQWMpdaHtsi91s/cPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 96/99] loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()
Date:   Mon, 21 Jan 2019 14:49:28 +0100
Message-Id: <20190121134919.830966841@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 628bd85947091830a8c4872adfd5ed1d515a9cf2 upstream.

Commit 0a42e99b58a20883 ("loop: Get rid of loop_index_mutex") forgot to
remove mutex_unlock(&loop_ctl_mutex) from loop_control_ioctl() when
replacing loop_index_mutex with loop_ctl_mutex.

Fixes: 0a42e99b58a20883 ("loop: Get rid of loop_index_mutex")
Reported-by: syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2075,12 +2075,10 @@ static long loop_control_ioctl(struct fi
 			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
-			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		if (atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
-			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		lo->lo_disk->private_data = NULL;


