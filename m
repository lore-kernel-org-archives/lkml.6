Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964926AbeEXXAg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:00:36 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34174 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935346AbeEXXAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:00:35 -0400
X-Google-Smtp-Source: AB8JxZoRZpJjZHxxgaCHrvD7w7VrtXxyzmJieWZPIn4vHRiYIMS7x5np1PfMro/hUeo6HEcE2T+tEg==
Date: Thu, 24 May 2018 16:00:23 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Andrew Morton <akpm@linux-foundation.org>
cc: Andrei Vagin <avagin@openvz.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] proc: fix smaps and meminfo alignment
Message-ID: <alpine.LSU.2.11.1805241554210.1326@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 4.17-rc /proc/meminfo and /proc/<pid>/smaps look ugly: single-digit
numbers (commonly 0) are misaligned. Remove seq_put_decimal_ull_width()'s
leftover optimization for single digits: it's wrong now that num_to_str()
takes care of the width.

Fixes: d1be35cb6f96 ("proc: add seq_put_decimal_ull_width to speed up /proc/pid/smaps")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 fs/seq_file.c |    5 -----
 1 file changed, 5 deletions(-)

--- 4.17-rc6/fs/seq_file.c	2018-04-15 21:45:06.740885410 -0700
+++ linux/fs/seq_file.c	2018-05-24 14:41:21.508491794 -0700
@@ -709,11 +709,6 @@ void seq_put_decimal_ull_width(struct se
 	if (m->count + width >= m->size)
 		goto overflow;
 
-	if (num < 10) {
-		m->buf[m->count++] = num + '0';
-		return;
-	}
-
 	len = num_to_str(m->buf + m->count, m->size - m->count, num, width);
 	if (!len)
 		goto overflow;
