Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/jKCnrJA/AnT3RInDzS6M5sQ+XaRgA5uwuKBREru3pkTgXVe4VTzM7XrYE+bVyJ3+eK/Iz
ARC-Seal: i=1; a=rsa-sha256; t=1524406067; cv=none;
        d=google.com; s=arc-20160816;
        b=vwlmuz9fC9tOKSMYCuDcrbw6yH0uCt4d4d3JZVs8j6E6PuNE4wnC7E6F3laKsMOfZ0
         qpCUgsDmQ8r58FA2X8FoPEGcYFi7oLAyRVgiZxK0u46cIqgYJb9QfZcKbxtJiTH1yQBQ
         gwbta1XLlN4VgSyq3mH1kPSF2vS4FHpmkatOqFFIPtcOVWBVDVwmEr4Puv4gxZumlIow
         BlMDgSiVIbXh5wYg++vkmbq3RB9i53KTIMV0XKWFOm0Hpy8mx75AKYvca52xU7vQNEph
         vDcYUsyMeyazWs+80QyUIJsSfQ18fER364UP4+HSkwfzw+TcRNs4cb5MEECdCouxdgQI
         JsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2L1StyLann3SluPFm3KRknW6a9zAxu5fC6Qsvq9OehI=;
        b=CmZxyjtS4iRAiE7dgmGzHqV3iUkeijjs5zorUHhZ5iLz1OGc+3yw3Z55aNBC4RVdHw
         xHs0RTS5sgP+8mi9R0ufL1aR72ntpQY08LGZUzEoJ0Q7NvfCsHEWWSjl595NTNe9ICvi
         0RKkBcUNfDbnwMAJQWYj0sTSRbVcYkD8JbYZ/PZ3/Aqcr9ge/ebobXpwGYIX94csXGMl
         kQQvZtuv1YOmNS/AN7tcp+FhHeIsaSScNjVz7k2PbUTRxtJ9ewWyBs08/FFes6UDDJZu
         5FZyNiNnnRLVjFwu8Mhk+P2vNaejLSW5sJJo2E6bUwx4OJIWg5p0fm2zbNSdLoa7l2i3
         OaQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>,
	Joel Fernandes <joelaf@google.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 099/164] ring-buffer: Check if memory is available before allocation
Date: Sun, 22 Apr 2018 15:52:46 +0200
Message-Id: <20180422135139.460623818@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455231474733078?=
X-GMAIL-MSGID: =?utf-8?q?1598455615981612991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 2a872fa4e9c8adc79c830e4009e1cc0c013a9d8a upstream.

The ring buffer is made up of a link list of pages. When making the ring
buffer bigger, it will allocate all the pages it needs before adding to the
ring buffer, and if it fails, it frees them and returns an error. This makes
increasing the ring buffer size an all or nothing action. When this was
first created, the pages were allocated with "NORETRY". This was to not
cause any Out-Of-Memory (OOM) actions from allocating the ring buffer. But
NORETRY was too strict, as the ring buffer would fail to expand even when
there's memory available, but was taken up in the page cache.

Commit 848618857d253 ("tracing/ring_buffer: Try harder to allocate") changed
the allocating from NORETRY to RETRY_MAYFAIL. The RETRY_MAYFAIL would
allocate from the page cache, but if there was no memory available, it would
simple fail the allocation and not trigger an OOM.

This worked fine, but had one problem. As the ring buffer would allocate one
page at a time, it could take up all memory in the system before it failed
to allocate and free that memory. If the allocation is happening and the
ring buffer allocates all memory and then tries to take more than available,
its allocation will not trigger an OOM, but if there's any allocation that
happens someplace else, that could trigger an OOM, even though once the ring
buffer's allocation fails, it would free up all the previous memory it tried
to allocate, and allow other memory allocations to succeed.

Commit d02bd27bd33dd ("mm/page_alloc.c: calculate 'available' memory in a
separate function") separated out si_mem_availble() as a separate function
that could be used to see how much memory is available in the system. Using
this function to make sure that the ring buffer could be allocated before it
tries to allocate pages we can avoid allocating all memory in the system and
making it vulnerable to OOMs if other allocations are taking place.

Link: http://lkml.kernel.org/r/1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com

CC: stable@vger.kernel.org
Cc: linux-mm@kvack.org
Fixes: 848618857d253 ("tracing/ring_buffer: Try harder to allocate")
Requires: d02bd27bd33dd ("mm/page_alloc.c: calculate 'available' memory in a separate function")
Reported-by: Zhaoyang Huang <huangzhaoyang@gmail.com>
Tested-by: Joel Fernandes <joelaf@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ring_buffer.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1136,6 +1136,11 @@ static int __rb_allocate_pages(long nr_p
 	struct buffer_page *bpage, *tmp;
 	long i;
 
+	/* Check if the available memory is there first */
+	i = si_mem_available();
+	if (i < nr_pages)
+		return -ENOMEM;
+
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
 		/*
