Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226XB95aZSV+sbiLy7lO8Vktwqyuvlu3empyCr5XESbbUr2Sn0Huu9J31uSlgJ6PEGOx1aQK
ARC-Seal: i=1; a=rsa-sha256; t=1517590783; cv=none;
        d=google.com; s=arc-20160816;
        b=jbm2dn6ElxrqY4GmD+nXGUNLLUyLxV+fFSifaSQGZQkbywYMmM1jQNkWvTO1I5HMgc
         V3CZ3BTginCWuTocU0z9iK9ZpeWGrqAoNyI538Tu24YbBruax69+tYHEvBEU0aq6wlXu
         2FoqclXBiWvE45+EmindR8zuI9iKyi8Cn7UOfawzJ/YKfcM5xGlA0vp5/lBdkWgOQ15h
         P+Y6BRMbokRU1T1kYwviBh4Oo5z5sPdmyqpp3FKl5eLj19wG6J4IqRJuwcO/rCIa4BcN
         3HrKfh84XDGUEUJKVxvSsD4ltGoWP5sVUSkMsuvGARE7+nQU9yUyW11O/yZPAhVRw1FT
         RHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ew4hySqiHGLkd0a74ZjTg0FQISZ8YmroUkOUxuIa8HI=;
        b=mS6/oMJneQ2NjmrZL4AIRah4L4ApPcxIe7pYCiNgtAekP+oMZyZkOTnqYQgmQESY/n
         DHqCX7nVD9JA487GDrLH9qzE0wjEtVq60DU5PbXv9xXIX6c9seIoU1hFNX8B47J6vrh6
         Lngs8Bqtz5Kx0W4zzI1ONZJvvdHPAcWQ+5XZHusH5cl+ZquaE8HAnimNVrXoObTwAXg/
         Vc0fmD1e24xbZinzBnHEfIQZ5SSa+QZ7HewOMpqJfOxbl8HRb4NSMcRzfFO25ktdRlQW
         bid35vZagYzNp6gVZr3RHXmbNm5q7DojqjsSiSekA7kJkz1an35PemD8qMoiU2DC9cXu
         5bnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vince Weaver <vincent.weaver@maine.edu>,
	=?UTF-8?q?Robert=20=C5=9Awi=C4=99cki?= <robert@swiecki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vince Weaver <vince@deater.net>,
	Jiri Kosina <jkosina@suze.cz>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH 4.4 12/67] kaiser: fix intel_bts perf crashes
Date: Fri,  2 Feb 2018 17:57:41 +0100
Message-Id: <20180202140816.605663601@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309273634786204?=
X-GMAIL-MSGID: =?utf-8?q?1591309273634786204?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugh Dickins <hughd@google.com>

Vince reported perf_fuzzer quickly locks up on 4.15-rc7 with PTI;
Robert reported Bad RIP with KPTI and Intel BTS also on 4.15-rc7:
honggfuzz -f /tmp/somedirectorywithatleastonefile \
          --linux_perf_bts_edge -s -- /bin/true
(honggfuzz from https://github.com/google/honggfuzz) crashed with
BUG: unable to handle kernel paging request at ffff9d3215100000
(then narrowed it down to
perf record --per-thread -e intel_bts//u -- /bin/ls).

The intel_bts driver does not use the 'normal' BTS buffer which is
exposed through kaiser_add_mapping(), but instead uses the memory
allocated for the perf AUX buffer.

This obviously comes apart when using PTI, because then the kernel
mapping, which includes that AUX buffer memory, disappears while
switched to user page tables.

Easily fixed in old-Kaiser backports, by applying kaiser_add_mapping()
to those pages; perhaps not so easy for upstream, where 4.15-rc8 commit
99a9dc98ba52 ("x86,perf: Disable intel_bts when PTI") disables for now.

Slightly reorganized surrounding code in bts_buffer_setup_aux(),
so it can better match bts_buffer_free_aux(): free_aux with an #ifdef
to avoid the loop when PTI is off, but setup_aux needs to loop anyway
(and kaiser_add_mapping() is cheap when PTI config is off or "pti=off").

Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Reported-by: Robert Święcki <robert@swiecki.net>
Analyzed-by: Peter Zijlstra <peterz@infradead.org>
Analyzed-by: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vince Weaver <vince@deater.net>
Cc: stable@vger.kernel.org
Cc: Jiri Kosina <jkosina@suze.cz>
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/perf_event_intel_bts.c |   44 +++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/cpu/perf_event_intel_bts.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_bts.c
@@ -22,6 +22,7 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/coredump.h>
+#include <linux/kaiser.h>
 
 #include <asm-generic/sizes.h>
 #include <asm/perf_event.h>
@@ -67,6 +68,23 @@ static size_t buf_size(struct page *page
 	return 1 << (PAGE_SHIFT + page_private(page));
 }
 
+static void bts_buffer_free_aux(void *data)
+{
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	struct bts_buffer *buf = data;
+	int nbuf;
+
+	for (nbuf = 0; nbuf < buf->nr_bufs; nbuf++) {
+		struct page *page = buf->buf[nbuf].page;
+		void *kaddr = page_address(page);
+		size_t page_size = buf_size(page);
+
+		kaiser_remove_mapping((unsigned long)kaddr, page_size);
+	}
+#endif
+	kfree(data);
+}
+
 static void *
 bts_buffer_setup_aux(int cpu, void **pages, int nr_pages, bool overwrite)
 {
@@ -103,29 +121,33 @@ bts_buffer_setup_aux(int cpu, void **pag
 	buf->real_size = size - size % BTS_RECORD_SIZE;
 
 	for (pg = 0, nbuf = 0, offset = 0, pad = 0; nbuf < buf->nr_bufs; nbuf++) {
-		unsigned int __nr_pages;
+		void *kaddr = pages[pg];
+		size_t page_size;
+
+		page = virt_to_page(kaddr);
+		page_size = buf_size(page);
+
+		if (kaiser_add_mapping((unsigned long)kaddr,
+					page_size, __PAGE_KERNEL) < 0) {
+			buf->nr_bufs = nbuf;
+			bts_buffer_free_aux(buf);
+			return NULL;
+		}
 
-		page = virt_to_page(pages[pg]);
-		__nr_pages = PagePrivate(page) ? 1 << page_private(page) : 1;
 		buf->buf[nbuf].page = page;
 		buf->buf[nbuf].offset = offset;
 		buf->buf[nbuf].displacement = (pad ? BTS_RECORD_SIZE - pad : 0);
-		buf->buf[nbuf].size = buf_size(page) - buf->buf[nbuf].displacement;
+		buf->buf[nbuf].size = page_size - buf->buf[nbuf].displacement;
 		pad = buf->buf[nbuf].size % BTS_RECORD_SIZE;
 		buf->buf[nbuf].size -= pad;
 
-		pg += __nr_pages;
-		offset += __nr_pages << PAGE_SHIFT;
+		pg += page_size >> PAGE_SHIFT;
+		offset += page_size;
 	}
 
 	return buf;
 }
 
-static void bts_buffer_free_aux(void *data)
-{
-	kfree(data);
-}
-
 static unsigned long bts_buffer_offset(struct bts_buffer *buf, unsigned int idx)
 {
 	return buf->buf[idx].offset + buf->buf[idx].displacement;
