Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577B6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283822089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864554;
	bh=RS8tg+uAKCeeByEsxj7tfJ6uRATizb0Pp4yl8uDWtOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fufiio31phfNenp/uVjMrzXHikcN2ViQlRcTUV6BzY/Wvyghl/TSrssgo/2EA/OLK
	 xsDPN9E/znq2d8PmsUpg0jhxQv3PsMty5PgnO7RAgeHIVu2OVn6QDCMbsB3GR5CCfA
	 FtDOSROFS+A+4EW81CrZNiZL+TvE7OvEP65KVQ6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfAGMfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:35:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfAGMfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:35:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A7F920859;
        Mon,  7 Jan 2019 12:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864547;
        bh=RS8tg+uAKCeeByEsxj7tfJ6uRATizb0Pp4yl8uDWtOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSxpYG9lkEdJ6yGWwlyPJJHk1UzIiZfMKwymsPiG9i1DTI8+meUEBGyogpZe39Mtk
         rNDvk6cpvQV0eAsEsQIcb0m6KFVSzJr+GbI+Q5P8iuWpBlJI3YxsoKONa3ey3/dMzH
         vwa/BVkuK+Oo93lf+aGvB5U99IeNVh2wxRVVJUBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@kernel.org
Subject: [PATCH 4.20 046/145] i915: fix missing user_access_end() in page fault exception case
Date:   Mon,  7 Jan 2019 13:31:23 +0100
Message-Id: <20190107104443.433267336@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 0b2c8f8b6b0c7530e2866c95862546d0da2057b0 upstream.

When commit fddcd00a49e9 ("drm/i915: Force the slow path after a
user-write error") unified the error handling for various user access
problems, it didn't do the user_access_end() that is needed for the
unsafe_put_user() case.

It's not a huge deal: a missed user_access_end() will only mean that
SMAP protection isn't active afterwards, and for the error case we'll be
returning to user mode soon enough anyway.  But it's wrong, and adding
the proper user_access_end() is trivial enough (and doing it for the
other error cases where it isn't needed doesn't hurt).

I noticed it while doing the same prep-work for changing
user_access_begin() that precipitated the access_ok() changes in commit
96d4f267e40f ("Remove 'type' argument from access_ok() function").

Fixes: fddcd00a49e9 ("drm/i915: Force the slow path after a user-write error")
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: stable@kernel.org # v4.20
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -1605,6 +1605,7 @@ static int eb_copy_relocations(const str
 					     (char __user *)urelocs + copied,
 					     len)) {
 end_user:
+				user_access_end();
 				kvfree(relocs);
 				err = -EFAULT;
 				goto err;


