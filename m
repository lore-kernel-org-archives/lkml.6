Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5815C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F851206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5tYkQYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfANUjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:39:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44083 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfANUjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:39:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so409872wrt.11;
        Mon, 14 Jan 2019 12:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vskZecaLZ3Ce4nmVjqV884dirkDxuHp6UAD0akN6aAI=;
        b=f5tYkQYFRUOTV8pl/0id4s9HyzXzddWso5ICwSVIcotgtoSsmE+ZlUYhJVtaEY7xoS
         4wetRt6Yhprx+EDRfP7jtyARork8O9MV8y7xsAXd/8OWbgvpfhLthQfsqtDm89nmJePR
         foDBzZHCuvhQMjq8CbfIZjpMvlQnnPZV2bE0+ubirHWzSMhv/JWmPPs8yH8Qqm/GPCIp
         /gdyL36HFVgZpsklvzEmASUeTVRUJqiNh3rDbKQoWKIcw5UvC0PwBUuCFOzkDnpxWKvv
         0P08Wfwb9FsDbqNb7ui2FSQxB83f323RBTBbeCT4wlXSDrNeNM2eKdAz+OUxA/aqeSwf
         CTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vskZecaLZ3Ce4nmVjqV884dirkDxuHp6UAD0akN6aAI=;
        b=eWrvVdFGR216v8jSeWw4z414tTSqR82+hgPcSQbnqethXNsMFh+oNQbreSJTAqSNEu
         1GkqcnXwIUwfv6d/V5gg35ew4VBQXbCDhN9gDX4X/IMBT1hlMxcLlnVkvjao9IAI5y0W
         Qd0gBPjOyDeRBSYQi+7dytMrAmdVmKQO8vWVQ8cjQP84XubFUQBuFulB2r/zZpxDAEms
         jAeVgDVr88rP0iBk8zCmymdunVwpeSM251skWcHmDAPrvpWQ7rnWHZTtaYR4BXxv3VdY
         RDQhaP90H8Tc/1jT5nNAIacdWQFX9M5PCNdF+JMb4dmpt/YsllAH8AgY16Aygn2jbje2
         WifA==
X-Gm-Message-State: AJcUukdyPhlsY8928WMJ5epTj0QZjEE55X9Km6ALa+MrdXndjERzPycl
        hZ3Af8nU9/gd4JsPjur+to4=
X-Google-Smtp-Source: ALg8bN4QiSy3xc6IISod1GH1WRrv3E3Sjt6eBisxCh0vI8HAzOj3JdMEU1GPLJajgUMkVhaOC91+NA==
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr212961wrr.285.1547498346714;
        Mon, 14 Jan 2019 12:39:06 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id 207sm15595578wmb.12.2019.01.14.12.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:39:06 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 0B30011422D0; Mon, 14 Jan 2019 21:39:05 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] fs: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:38:57 +0100
Message-Id: <20190114203859.19875-2-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114203859.19875-1-malat@debian.org>
References: <20190114203859.19875-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

In this particular case remove a ‘:’ so as to match the regular
expression expected by GCC.

This commit remove the following warning:

  fs/locks.c:1473:16: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index ff6af2c32601..d958c3863b4b 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1471,7 +1471,7 @@ static void lease_clear_pending(struct file_lock *fl, int arg)
 	switch (arg) {
 	case F_UNLCK:
 		fl->fl_flags &= ~FL_UNLOCK_PENDING;
-		/* fall through: */
+		/* fall through */
 	case F_RDLCK:
 		fl->fl_flags &= ~FL_DOWNGRADE_PENDING;
 	}
-- 
2.19.2

