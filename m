Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46352C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAE820835
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Nng9FFdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAE820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933335AbeGIQZT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:25:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33993 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932770AbeGIQZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:25:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id d3-v6so14417750edi.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+fbqYqPvkeNQn/GeP/TLNQC6r5DJ3br/mflYTWDsAbw=;
        b=Nng9FFdGyGViJ8cgd79/orpbzKuVGmwUXJf4atqY2h114pBGvoAREAu9vAT0J4zZO5
         w4lEFY/wE5doRrPvHltThc/8zmdKKtJAqE2jJJbL8UROycNE5j1r7x954GHh5ZAhxwjS
         fiBqWQ8oJhj7L6GSi2M4j6DDRzQABcHHOXylM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+fbqYqPvkeNQn/GeP/TLNQC6r5DJ3br/mflYTWDsAbw=;
        b=XnVGkzfrqIHTL0T3B33oxYJL+rgt9PHUhUIS4B+SYCi4E5CVYuvBGtFfUYkpdvkhkw
         iazEcUzotwzmR6sNQMSz1y91msOBpUNnRQ9TnmF79TayUhIELk/7UEIyAxE+MjhGxuVU
         RIXYnw92VYsqP/SqkRn3nfFb4LZ3z/5Snt2xOGqkUL9j69pUzeCNXND8EaHs17iWW7mA
         E3KB1B4J0mXWJ/VlcU+kQBhhLzL69zl66zvy3X+E8S9hNVHHM2RmHtqGtuDMURSgvQWX
         ZT2uWuHlW7BFZVvrsxOGWhOAK0r18mwQE7zRJfuSuyJvBTCLxtvPHuHxf0QEiY5FMW4g
         u3TQ==
X-Gm-Message-State: APt69E3cTViE7/sA61Jcw3Gn4mKH91lol6w6LnfnNRFPdbfw5yQxhyzy
        TAYM5UP+2+op+MXPIBoSmYAmFvlf
X-Google-Smtp-Source: AAOMgpdu3uIJO5A3ZMH//9TI76An6wwZXlcam+EGPtvg8eA+oLA3POOMoOCgKYoK9Rq9uixHrxOFTw==
X-Received: by 2002:a50:a4f1:: with SMTP id x46-v6mr22349768edb.247.1531153515752;
        Mon, 09 Jul 2018 09:25:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id z3-v6sm7578905edh.56.2018.07.09.09.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 09:25:14 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neilb@suse.com>, Wei Wang <wvw@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] kernel.h: Add for_each_if()
Date:   Mon,  9 Jul 2018 18:25:09 +0200
Message-Id: <20180709162509.29343-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid compilers complainig about ambigious else blocks when putting
an if condition into a for_each macro one needs to invert the
condition and add a dummy else. We have a nice little convenience
macro for that in drm headers, let's move it out. Subsequent patches
will roll it out to other places.

The issue the compilers complain about are nested if with an else
block and no {} to disambiguate which if the else belongs to. The C
standard is clear, but in practice people forget:

if (foo)
	if (bar)
		/* something */
	else
		/* something else

The same can happen in a for_each macro when it also contains an if
condition at the end, except the compiler message is now really
confusing since there's only 1 if:

for_each_something()
	if (bar)
		/* something */
	else
		/* something else

The for_each_if() macro, by inverting the condition and adding an
else, avoids the compiler warning.

Motivated by a discussion with Andy and Yisheng, who want to add
another for_each_macro which would benefit from for_each_if() instead
of hand-rolling it.

Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: NeilBrown <neilb@suse.com>
Cc: Wei Wang <wvw@google.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
--
v2: Explain a bit better what this is good for, after the discussion
with Peter Z.
---
 include/drm/drmP.h     | 3 ---
 include/linux/kernel.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index f7a19c2a7a80..05350424a4d3 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -110,7 +110,4 @@ static inline bool drm_can_sleep(void)
 	return true;
 }
 
-/* helper for handling conditionals in various for_each macros */
-#define for_each_if(condition) if (!(condition)) {} else
-
 #endif
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 941dc0a5a877..4cb95ab9a5bc 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -71,6 +71,9 @@
  */
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
+/* helper for handling conditionals in various for_each macros */
+#define for_each_if(condition) if (!(condition)) {} else
+
 #define u64_to_user_ptr(x) (		\
 {					\
 	typecheck(u64, x);		\
-- 
2.18.0

