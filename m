Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C550AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9FA2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbQysCTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfANUZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:25:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35281 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfANUZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:25:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so428069wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOsnqfkleB4RTKhg+gQetUXWhBq1z79rEfuESUt9/Ls=;
        b=YbQysCTKZVHJQnN6+QojnrtCPMq71qfGKzfL/uXzRuEd/YWqObg85PEKo7hERSqoZW
         ZdOxbNNTCZb0dS2clSxvGS1B5hd2/IYLv2wTQtufUeg75ykIp6J6YCeP68q3CCdGLD0k
         gxO6/HXevWeTJGPM6+1yIq7Ad7Hn8SAh1hu1I8PueJQs74GaVzpB7qJ+bWxzY08mLb/K
         wQt9l8uPYhN+hBVd8m9xxy58jqIY45tfDprEjgu5zuVQDSxRmnKINxCpYVvIsQExZhRm
         d8zeB6MgpE0CspYb6ys9OtjYrdiH4K9GeSXiR6/TvkkoKRNCeAsKWtjGIbAjivHZNsNN
         DBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=kOsnqfkleB4RTKhg+gQetUXWhBq1z79rEfuESUt9/Ls=;
        b=BelSsDibX3LNS2vl+MzTEhnL+FthOR9a7WyzlbXYhY7v5caYpwYa1qcM2D8BFtO1OX
         +6iZgUPj08atCfGxVV4bn3FxH7LP2xU0JcCX2rloYXVS7mDaKTN+8pMPKKsOqG6pvi/D
         YJoBb60E855pT0vX+pQLBYCqz6mTtP2WmJkcYew6zbzz3C9/2XWnvIgG0fblwc75OB81
         2gcbfNvcIKQdjWokOpp360Ub/h3v3fm8USDWd1oV/EgdHheeLM4cBegW/vW+v7sL8Fy4
         Di32GlLTuKdYbym1VVxV+5ltCJtceTCeu9EwxvPRStLxopVqq7wVYY8ShEKR+p6VmPBb
         j0pQ==
X-Gm-Message-State: AJcUukdI2rU68EdAR86IblDfDBk1+UrooBjpijayayeja9xt623htOi5
        v2MoiobjrpT6r/LBT5Z8duo=
X-Google-Smtp-Source: ALg8bN730ZQhpJEEvgOfbzGyod01J8p9GEi5y7frSY7hcFsfPdEYAXPx23ZmRCpx7LFE/WAdGyYovw==
X-Received: by 2002:adf:9484:: with SMTP id 4mr185663wrr.98.1547497500696;
        Mon, 14 Jan 2019 12:25:00 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id a132sm35694882wmh.5.2019.01.14.12.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:24:59 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id D2AEF11422AD; Mon, 14 Jan 2019 21:24:58 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/assoc_array: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:24:54 +0100
Message-Id: <20190114202454.14551-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  lib/assoc_array.c:1110:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 lib/assoc_array.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index c6659cb37033..0b61d3b77e5c 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -1115,6 +1115,7 @@ struct assoc_array_edit *assoc_array_delete(struct assoc_array *array,
 						index_key))
 				goto found_leaf;
 		}
+		/* fall through */
 	case assoc_array_walk_tree_empty:
 	case assoc_array_walk_found_wrong_shortcut:
 	default:
-- 
2.19.2

