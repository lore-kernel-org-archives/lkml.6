Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3E7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D63F21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216155;
	bh=b2JXNkohC+ogAg4l104Pv3UEF+VVpbogIVkfcvDBr2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZGuLQ6pO0EZCytGoMWjPbmwn7n3MLvdjVZY65eVXLcHDOLZpGNsCZcHCDDeLsP7qz
	 SQA9d56gQW8v1EgFgyKaI9u6PUDx1t1Qdezxqa7oRlkTr6i5/jI8X0lgMoOFg3kP2J
	 kJGoftUeLO3BowZ6oZn9QaJiYPdlifVvInNrw7uM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbfAKOPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:15:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387481AbfAKOPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:15:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2841D2177B;
        Fri, 11 Jan 2019 14:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216149;
        bh=b2JXNkohC+ogAg4l104Pv3UEF+VVpbogIVkfcvDBr2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xtl6vNww46HIHknhnhnt+dEICIcnq5ZLXcJuNsYbHv44fyVB/XVHzqLphb09cGKur
         doLSD30i4glqoSRBXHa5wKh1cOPKIuoI9LwKe+CfHmF13VnXmZtekkabggbFoW4voK
         q/MDskyuZ6eGA/NpwlDCwcQIY8x+zGzdoUBJ8NEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 3.18 40/47] dlm: lost put_lkb on error path in receive_convert() and receive_unlock()
Date:   Fri, 11 Jan 2019 15:08:25 +0100
Message-Id: <20190111131001.290868287@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit c0174726c3976e67da8649ac62cae43220ae173a upstream.

Fixes 6d40c4a708e0 ("dlm: improve error and debug messages")
Cc: stable@kernel.org # 3.5

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dlm/lock.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -4178,6 +4178,7 @@ static int receive_convert(struct dlm_ls
 			  (unsigned long long)lkb->lkb_recover_seq,
 			  ms->m_header.h_nodeid, ms->m_lkid);
 		error = -ENOENT;
+		dlm_put_lkb(lkb);
 		goto fail;
 	}
 
@@ -4231,6 +4232,7 @@ static int receive_unlock(struct dlm_ls
 			  lkb->lkb_id, lkb->lkb_remid,
 			  ms->m_header.h_nodeid, ms->m_lkid);
 		error = -ENOENT;
+		dlm_put_lkb(lkb);
 		goto fail;
 	}
 


