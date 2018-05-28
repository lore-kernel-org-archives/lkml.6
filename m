Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937473AbeE1KmZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937431AbeE1KmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:42:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 027/496] kasan: fix memory hotplug during boot
Date: Mon, 28 May 2018 11:56:52 +0200
Message-Id: <20180528100320.730128376@linuxfoundation.org>
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

commit 3f1959721558a976aaf9c2024d5bc884e6411bf7 upstream.

Using module_init() is wrong.  E.g.  ACPI adds and onlines memory before
our memory notifier gets registered.

This makes sure that ACPI memory detected during boot up will not result
in a kernel crash.

Easily reproducible with QEMU, just specify a DIMM when starting up.

Link: http://lkml.kernel.org/r/20180522100756.18478-3-david@redhat.com
Fixes: 786a8959912e ("kasan: disable memory hotplug")
Signed-off-by: David Hildenbrand <david@redhat.com>
Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/kasan/kasan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -843,5 +843,5 @@ static int __init kasan_memhotplug_init(
 	return 0;
 }
 
-module_init(kasan_memhotplug_init);
+core_initcall(kasan_memhotplug_init);
 #endif
