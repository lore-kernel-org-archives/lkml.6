Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E835DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1279208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4P8FTEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1279208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbeKTDE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:04:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731909AbeKTDEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:04:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D81620831;
        Mon, 19 Nov 2018 16:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645645;
        bh=36G27+kEpB4xKVGp4KXw8hsEOAnyUnirIxDaDAAroYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4P8FTEfTcX/iDE/EkfBvgGqGSHLYTtmbOaxJqMtVBpVBRhYdKiwJT3UbBUBZbpmd
         E/mUKHesWOKY3vVQWb+7iSYLHqb/pajPwqRjHQCCGtr+FisQPiLEAWNrEwNXPEtO53
         fAFGgW2RQ3UkfMqUnkB/382a1r5kIbaceTyw1L0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        syzbot+d4252148d198410b864f@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 034/171] 9p: clear dangling pointers in p9stat_free
Date:   Mon, 19 Nov 2018 17:27:10 +0100
Message-Id: <20181119162625.325875946@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

From: Dominique Martinet <dominique.martinet@cea.fr>

[ Upstream commit 62e3941776fea8678bb8120607039410b1b61a65 ]

p9stat_free is more of a cleanup function than a 'free' function as it
only frees the content of the struct; there are chances of use-after-free
if it is improperly used (e.g. p9stat_free called twice as it used to be
possible to)

Clearing dangling pointers makes the function idempotent and safer to use.

Link: http://lkml.kernel.org/r/1535410108-20650-2-git-send-email-asmadeus@codewreck.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Reported-by: syzbot+d4252148d198410b864f@syzkaller.appspotmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/9p/protocol.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/9p/protocol.c
+++ b/net/9p/protocol.c
@@ -46,10 +46,15 @@ p9pdu_writef(struct p9_fcall *pdu, int p
 void p9stat_free(struct p9_wstat *stbuf)
 {
 	kfree(stbuf->name);
+	stbuf->name = NULL;
 	kfree(stbuf->uid);
+	stbuf->uid = NULL;
 	kfree(stbuf->gid);
+	stbuf->gid = NULL;
 	kfree(stbuf->muid);
+	stbuf->muid = NULL;
 	kfree(stbuf->extension);
+	stbuf->extension = NULL;
 }
 EXPORT_SYMBOL(p9stat_free);
 


