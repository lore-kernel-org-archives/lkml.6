Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937458AbeE1KmU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937426AbeE1KmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:42:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 026/496] kasan: free allocated shadow memory on MEM_CANCEL_ONLINE
Date: Mon, 28 May 2018 11:56:51 +0200
Message-Id: <20180528100320.692311717@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit ed1596f9ab958dd156a66c9ff1029d3761c1786a upstream.

We have to free memory again when we cancel onlining, otherwise a later
onlining attempt will fail.

Link: http://lkml.kernel.org/r/20180522100756.18478-2-david@redhat.com
Fixes: fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
Signed-off-by: David Hildenbrand <david@redhat.com>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/kasan/kasan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -811,6 +811,7 @@ static int __meminit kasan_mem_notifier(
 		kmemleak_ignore(ret);
 		return NOTIFY_OK;
 	}
+	case MEM_CANCEL_ONLINE:
 	case MEM_OFFLINE: {
 		struct vm_struct *vm;
 
