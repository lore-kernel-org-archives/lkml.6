Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DB6C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BA4208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7OUud1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BA4208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933442AbeGHVFp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:05:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44734 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933292AbeGHVFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so12135775pfh.11;
        Sun, 08 Jul 2018 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cvNLBNOgZzxso6QsTCq3k+4dbKwBwkNaOeyRI4TEBpc=;
        b=d7OUud1k6/iJTRGgGsGYket8X3YiYVSeVu35xUBDzhiMUYyKqR4khwg7okj5NaVG6g
         a+S1R6Ji6Y3ho/eXyx+I5oBTrgCxvRAsugzX4RJHv2oZI9I79DOBU9M10ask7KEtRddR
         7oE4oTcBkl5txoX2FPrW2Sd42VGOngZp11mSiOH4Bgs4r1UHi50cO0sPeTI9oYeC7kHc
         HCbp5567BzP/N2v59CCECUuzYCr4cSYejm7BzggZ7RfKBK9HM2Q8h1YcnCB6AdkGTBix
         CxoMuwvydAuOSQ/M1TNoHgIE9MgknObhWZ6hhFSZWJAMFuaRNEXpYMWXcaly/v32Gqjt
         xVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cvNLBNOgZzxso6QsTCq3k+4dbKwBwkNaOeyRI4TEBpc=;
        b=pQ/9a35GSSN6bdA9NcXsn9N5ZA+/cW2ENbCmcf0mlyZW2R5g1cKfhGWc6s7WIaak4l
         sLhIN2uolAo3IyVQI8dkJq3Ue99D5Hiqc6x9IGI9Qutnbg+9o6/vVaHmQ1jSAKfU9bpT
         tmhnQ2YSFRiOkQ8hHz3+6HQMEF/nNJMqBhR7YMc+B9SN22pCTc9itT/MlyraIqgSEfn8
         BvtW247KKN9Tv1H0ke5/XGhKgGyXHgIYsJq/JZOt/HX8bRpMQTLJNbKeA7By+R1jMVz0
         NuYPDAQrQ82ADCXf8FyF8PxGT4SCP7tXLFWemldmzZfwsFWmOQ3vmJoPEn6wix1Htq/V
         KT7A==
X-Gm-Message-State: APt69E2gsSje+eZky24or+1KlRK9S/ob35oH23xC3nV6wZIIfH8RhLPn
        GL1tEGNRtw6aQZzORy6EoBs=
X-Google-Smtp-Source: AAOMgpdJFr3EuZfnfYy0b33hAUJ7+6/haki0jxSv2wrpW0Z8jVkj5zq1JzwORLQuudXo5VArgjikHw==
X-Received: by 2002:a62:850d:: with SMTP id u13-v6mr18788471pfd.131.1531083938770;
        Sun, 08 Jul 2018 14:05:38 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:38 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 07/18] fs_context: fix double free of legacy_fs_context data
Date:   Sun,  8 Jul 2018 14:01:43 -0700
Message-Id: <20180708210154.10423-8-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

sys_fsmount() calls fc->ops->free() to free the data, zeroes
->fs_private, then proceeds to reuse the context.  But legacy_fs_context
doesn't use ->fs_private, so we need to handle zeroing it too; otherwise
there's a double free of legacy_fs_context::{legacy_data,secdata}.

Fixes: 8a2e54b8af88 ("vfs: Implement a filesystem superblock creation/configuration context")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fs_context.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 7a8d1ed34ae71..206256be9777e 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -504,6 +504,9 @@ static void legacy_fs_context_free(struct fs_context *fc)
 		kfree(ctx->legacy_data);
 		break;
 	}
+	/* This doesn't use fs_private, so need to manually zero for fsmount */
+	BUILD_BUG_ON(offsetof(struct legacy_fs_context, fc) != 0);
+	memset(fc + 1, 0, sizeof(*ctx) - sizeof(*fc));
 }
 
 /*
-- 
2.18.0

