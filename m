Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3BEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7CB2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217593;
	bh=nzcEWKz4CehlkJDPVr40/V5BbqukNSPnuxB8ylJbVG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k3gxh4ysx5oBdDL3j9a8JtT9xdMcm2EnxJALrWKo1+iBhfXoc71+RHy2pH0dWwBtB
	 2yffPKlj1cf+JdJMafXgPeKUlVLwv0H9CR+26LAEUEirIVO+UjCIPnV2wo87egG6wh
	 8jyAF1/c5E1vO7sFH5hhbYouEE4eHh3ESBbk2/8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391112AbfAKOjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391098AbfAKOjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A7C21841;
        Fri, 11 Jan 2019 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217584;
        bh=nzcEWKz4CehlkJDPVr40/V5BbqukNSPnuxB8ylJbVG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qd20znpI+7F6IfYgUo2Q2tTCchLA3g5KRztmvEb9hj299p4zfAfXV7V0hNrU381R3
         DP/tIz1/14LP4t75k9U++at4GypLj6/W37x2dgmpDiHsb7dWQMYfC9TFZG6BM64b6G
         8folmjBOVBr+VSTQrc+IOfDLZNxUSXCCQU2y/8TA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 4.19 116/148] dlm: lost put_lkb on error path in receive_convert() and receive_unlock()
Date:   Fri, 11 Jan 2019 15:14:54 +0100
Message-Id: <20190111131118.892957020@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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
@@ -4180,6 +4180,7 @@ static int receive_convert(struct dlm_ls
 			  (unsigned long long)lkb->lkb_recover_seq,
 			  ms->m_header.h_nodeid, ms->m_lkid);
 		error = -ENOENT;
+		dlm_put_lkb(lkb);
 		goto fail;
 	}
 
@@ -4233,6 +4234,7 @@ static int receive_unlock(struct dlm_ls
 			  lkb->lkb_id, lkb->lkb_remid,
 			  ms->m_header.h_nodeid, ms->m_lkid);
 		error = -ENOENT;
+		dlm_put_lkb(lkb);
 		goto fail;
 	}
 


