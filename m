Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvRN3Lkz0GAWJqY66UZPjwTY1X+r7XJ2XG+g6VFU2Dtio35LURVUqisD9rXX7zaXQ0PdNq5
ARC-Seal: i=1; a=rsa-sha256; t=1521483669; cv=none;
        d=google.com; s=arc-20160816;
        b=e6fIO7RAuDOsE8yGeknn/Q6lL73srxx1NjBPWYErJbbrYTQP6lVHo+GzCSDGRbvzzz
         gICyee1+Xuy59+VrMRyQu0YcZ4a6tho33tGoglsp12G8C4uocKIgp17TN+K9qP0mY+Lv
         npLQ9GFXv/WP1HHQozcKLEWhO0zXbEMZlDbwwhCULpFpGpCrRkxQNEw8xsfXCX3Ogjcf
         R9kQ89Hn2EMKPm2jl4LNm0dC5qCtsFHXKKgv1IP2fdztBfFJR+FOYT7AjKTK7HDC3loy
         y7C5iCJQMhmWUqi8GKcuK8fxwkV3cr/FDuuslGgdKw4l2OyLroOz2xhlJGt2KbOrm8hV
         cSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ClribQ9HpJ4xyD4NKlH805/sCH4NzgF3l/7Xx63xebc=;
        b=tXUsi+sFZXIXOzbnKX5OlPyKGW0qfbcVy+bp0L6ZBQvcjPitG7dBPfQEoqxdIr9sI6
         hugnRWKu1JzJ5vYTrsUy215/wjU521/jADIqp5ZO5z19UNwmIVzjIHJZt4KD/4b18uPf
         T2HoIa+mx2txnHpvVg49hO55v4z4HdOxf65vVt480OvFA0FuUVW4iMB5pZgEl41wahdd
         Cf1K7sc64vXNNBTAOUdLduXxqrtiPFO5kgjvHVNNv3QWuZ2rj1vMtx9EFd+ZjggTbLjz
         ZXX5Gu2SPW/qtK90xqRI4GRAHMG7bZukhgKy+HLxuC47+SgcAhu65rLy8AEPkpJdrx1I
         Xxcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fengguang Wu <fengguang.wu@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	LKP <lkp@01.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mm@kvack.org,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 074/241] mm: Fix false-positive VM_BUG_ON() in page_cache_{get,add}_speculative()
Date: Mon, 19 Mar 2018 19:05:39 +0100
Message-Id: <20180319180754.269544891@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390529302865915?=
X-GMAIL-MSGID: =?utf-8?q?1595391260108862211?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>


[ Upstream commit 591a3d7c09fa08baff48ad86c2347dbd28a52753 ]

0day testing by Fengguang Wu triggered this crash while running Trinity:

  kernel BUG at include/linux/pagemap.h:151!
  ...
  CPU: 0 PID: 458 Comm: trinity-c0 Not tainted 4.11.0-rc2-00251-g2947ba0 #1
  ...
  Call Trace:
   __get_user_pages_fast()
   get_user_pages_fast()
   get_futex_key()
   futex_requeue()
   do_futex()
   SyS_futex()
   do_syscall_64()
   entry_SYSCALL64_slow_path()

It' VM_BUG_ON() due to false-negative in_atomic(). We call
page_cache_get_speculative() with disabled local interrupts.
It should be atomic enough.

So let's check for disabled interrupts in the VM_BUG_ON() condition
too, to resolve this.

( This got triggered by the conversion of the x86 GUP code to the
  generic GUP code. )

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: LKP <lkp@01.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20170324114709.pcytvyb3d6ajux33@black.fi.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/pagemap.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -148,7 +148,7 @@ static inline int page_cache_get_specula
 
 #ifdef CONFIG_TINY_RCU
 # ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic());
+	VM_BUG_ON(!in_atomic() && !irqs_disabled());
 # endif
 	/*
 	 * Preempt must be disabled here - we rely on rcu_read_lock doing
@@ -186,7 +186,7 @@ static inline int page_cache_add_specula
 
 #if !defined(CONFIG_SMP) && defined(CONFIG_TREE_RCU)
 # ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic());
+	VM_BUG_ON(!in_atomic() && !irqs_disabled());
 # endif
 	VM_BUG_ON_PAGE(page_count(page) == 0, page);
 	page_ref_add(page, count);
