Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AG47ELvdw3GVQxc9qlCVYKID0Xrpayzqk0YQh9WRKTgDkLn/HMzv4w3WuC9eQN4J+VHMUum4uK5H
ARC-Seal: i=1; a=rsa-sha256; t=1521654905; cv=none;
        d=google.com; s=arc-20160816;
        b=rP/1BYvx7gtyCxzmaaTyNGiLdHVvuQrR7rKW1pPiC8+1u8iJFGbEZSlCFuGEKy9Df4
         0QJ/mRZ3gK+sZNOqxWmqyGSje0QsXmn4PhTSIZRUdm8okc1kXqLiSaZ2XGV7KyaWWNPE
         C6MwWP9zej5hujj+MzNqT/980L5LWEmLLVCd6bnAau5wncccl/JdQdW0fC0BW4NSCP3R
         44XDR+ZYfwk5xWJt4hVs1eTpo1E7AwkLM8OC7JGN0YSe9A2QjN9ar7JNyXn+HRgyONag
         6r2VD5z8oGRqAUMFvQgwe2c7MxP8pJ0rKNQfpT0YVhy5StmhQCiVguIalwfb8Eub9MGw
         rPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=pc/5JQD75Srbm5b9w0NUfLDZBc/5J20egPrTFpg/SOM=;
        b=y474SCCN4V12itSvrjtk3AgB7G1TIpjJCugFKSsNcYwQSJfSBdEd60T2F3FyGPDUqh
         JDfm8gAoGH/MbvJzp+YgZIfKCg9vgQUWjkj9J4Grj7xTOiJxXYBPqG+MC/eHtzKOZmW6
         o56Wp1+8QBqjF6wO4aqif/fEO7muiTvbuXHIytQMBjZNe6D7GWOX+GkGpAI69YkI4AIE
         2xPm8nCPN8qY/Q02eEGJFPccBKN/FLG+t9NlKP1Jz784FBx1KsIbbv7ZNknk57ER9uW3
         s6sQCAKhE2G4a65bmoVdUyLCwZXyDKW1zYBfnimgIDQv8dOKLXRErp58W8170lMLvBCd
         5FsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=O7QuZlAQ;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=O7QuZlAQ;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Wed, 21 Mar 2018 10:54:53 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
	vdavydov.dev@gmail.com, akpm@linux-foundation.org,
	tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
	gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
	mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
	chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
	hillf.zj@alibaba-inc.com, ying.huang@intel.com,
	mgorman@techsingularity.net, shakeelb@google.com, jbacik@fb.com,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 03/10] mm: Assign memcg-aware shrinkers bitmap to memcg
Message-ID: <20180321175453.GG4780@bombadil.infradead.org>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
 <20180321145625.GA4780@bombadil.infradead.org>
 <eda62454-5788-4f65-c2b5-719d4a98cb2a@virtuozzo.com>
 <20180321152647.GB4780@bombadil.infradead.org>
 <638887a1-35f8-a71d-6e45-4e779eb62dc4@virtuozzo.com>
 <20180321162039.GC4780@bombadil.infradead.org>
 <d738c32f-78fd-7e95-803d-2c48594d14e2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d738c32f-78fd-7e95-803d-2c48594d14e2@virtuozzo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1595570814352583495?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 07:42:38PM +0300, Kirill Tkhai wrote:
> On 21.03.2018 19:20, Matthew Wilcox wrote:
> >> Sound great, thanks for explaining this. The big problem I see is
> >> that IDA/IDR add primitives allocate memory, while they will be used
> >> in the places, where they mustn't fail. There is list_lru_add(), and
> >> it's called unconditionally in current kernel code. The patchset makes
> >> the bitmap be populated in this function. So, we can't use IDR there.
> > 
> > Maybe we can use GFP_NOFAIL here.  They're small allocations, so we're
> > only asking for single-page allocations to not fail, which shouldn't
> > put too much strain on the VM.
>  
> Oh. I'm not sure about this. Even if each allocation is small, there is
> theoretically possible a situation, when many lists will want to add first
> element. list_lru_add() is called from iput() for example.

I see.  Maybe we could solve this with an IDA_NO_SHRINK flag and an
ida_resize(ida, max); call.

You'll also want something like this:


diff --git a/include/linux/idr.h b/include/linux/idr.h
index 0f650b90ced0..ee7185354fb2 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -273,6 +273,22 @@ static inline void ida_init(struct ida *ida)
 			ida_alloc_range(ida, start, (end) - 1, gfp)
 #define ida_simple_remove(ida, id)	ida_free(ida, id)
 
+int ida_find(struct ida *, unsigned int id);
+
+/**
+ * ida_for_each() - Iterate over all allocated IDs.
+ * @ida: IDA handle.
+ * @id: Loop cursor.
+ *
+ * For each iteration of this loop, @id will be set to an allocated ID.
+ * No locks are held across the body of the loop, so you can call ida_free()
+ * if you want or adjust @id to skip IDs or re-process earlier IDs.
+ *
+ * On successful loop exit, @id will be less than 0.
+ */
+#define ida_for_each(ida, i)			\
+	for (i = ida_find(ida, 0); i >= 0; i = ida_find(ida, i + 1))
+
 /**
  * ida_get_new - allocate new ID
  * @ida:	idr handle
diff --git a/lib/idr.c b/lib/idr.c
index fab3763e8c2a..ba9fae7eb2f5 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -612,3 +612,54 @@ void ida_free(struct ida *ida, unsigned int id)
 	spin_unlock_irqrestore(&simple_ida_lock, flags);
 }
 EXPORT_SYMBOL(ida_free);
+
+/**
+ * ida_find() - Find an allocated ID.
+ * @ida: IDA handle.
+ * @id: Minimum ID to return.
+ *
+ * Context: Any context.
+ * Return: An ID which is at least as large as @id or %-ENOSPC if @id is
+ * higher than any allocated ID.
+ */
+int ida_find(struct ida *ida, unsigned int id)
+{
+	unsigned long flags;
+	unsigned long index = id / IDA_BITMAP_BITS;
+	unsigned bit = id % IDA_BITMAP_BITS;
+	struct ida_bitmap *bitmap;
+	struct radix_tree_iter iter;
+	void __rcu **slot;
+	int ret = -ENOSPC;
+
+	spin_lock_irqsave(&simple_ida_lock, flags);
+advance:
+	slot = radix_tree_iter_find(&ida->ida_rt, &iter, index);
+	if (!slot)
+		goto unlock;
+	bitmap = rcu_dereference_raw(*slot);
+	if (radix_tree_exception(bitmap)) {
+		if (bit < (BITS_PER_LONG - RADIX_TREE_EXCEPTIONAL_SHIFT)) {
+			unsigned long bits = (unsigned long)bitmap;
+
+			bits >>= bit + RADIX_TREE_EXCEPTIONAL_SHIFT;
+			if (bits) {
+				bit += __ffs(bits);
+				goto found;
+			}
+		}
+	} else {
+		bit = find_next_bit(bitmap->bitmap, IDA_BITMAP_BITS, bit);
+		if (bit < IDA_BITMAP_BITS)
+			goto found;
+	}
+	bit = 0;
+	index++;
+	goto advance;
+found:
+	ret = iter.index * IDA_BITMAP_BITS + bit;
+unlock:
+	spin_unlock_irqrestore(&simple_ida_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(ida_find);
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 6c645eb77d42..a9b5a33a4ef3 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -358,8 +358,12 @@ void ida_check_conv(void)
 		assert(ida_pre_get(&ida, GFP_KERNEL));
 		assert(!ida_get_new_above(&ida, i + 1, &id));
 		assert(id == i + 1);
+		ida_for_each(&ida, id)
+			BUG_ON(id != (i + 1));
 		assert(!ida_get_new_above(&ida, i + BITS_PER_LONG, &id));
 		assert(id == i + BITS_PER_LONG);
+		ida_for_each(&ida, id)
+			BUG_ON((id != (i + 1)) && (id != (i + BITS_PER_LONG)));
 		ida_remove(&ida, i + 1);
 		ida_remove(&ida, i + BITS_PER_LONG);
 		assert(ida_is_empty(&ida));
@@ -484,7 +488,7 @@ void ida_simple_get_remove_test(void)
 void ida_checks(void)
 {
 	DEFINE_IDA(ida);
-	int id;
+	int id, id2;
 	unsigned long i;
 
 	radix_tree_cpu_dead(1);
@@ -496,8 +500,22 @@ void ida_checks(void)
 		assert(id == i);
 	}
 
+	id2 = 0;
+	ida_for_each(&ida, id) {
+		BUG_ON(id != id2++);
+	}
+	BUG_ON(id >= 0);
+	BUG_ON(id2 != 10000);
+
 	ida_remove(&ida, 20);
 	ida_remove(&ida, 21);
+	id2 = 0;
+	ida_for_each(&ida, id) {
+		if (id != id2++) {
+			BUG_ON(id != 22 || id2 != 21);
+			id2 = 23;
+		}
+	}
 	for (i = 0; i < 3; i++) {
 		assert(ida_pre_get(&ida, GFP_KERNEL));
 		assert(!ida_get_new(&ida, &id));
