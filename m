Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1387311-1523019821-2-17452615798461417042
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15'
X-Attached: 0013-ring-buffer-Check-if-memory-is-available-before-allo.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523019820; b=N9kAjgoGm1YwkZHoLo6FzIhx9lJikPQH44wgkOHQ150IgiDItJ
    Djv/V4R6Grj1w5n9GJpNAyzNvA71uPH9lSQ/OK2wFSFsxvszu/En0VfimZkfgAQ4
    YCxNZnUIV0kHnO9pgcj8uaTMQF/2UuDT3+s3gOO6qgp2o23bxY+mbm0M+T5Qohdh
    ECpYjM/9qsx+T+QT6uf9OQzw2OQ5x5K9A6RuhE9XE3y6Oi2cb/1TEnsNbRxzXBEd
    3x83mHXt+G/IAI4Xgf9ZLbxxW43KKGYYRjTaG4YBRzFdOeGy+7ocr/XaxTJr7PrN
    f5zsLddE0enzHKBLOJVdznaX8JAgll2Jz72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:mime-version:content-type:sender:list-id; s=fm2; t=
    1523019820; bh=kMxqMMLR972mYGYun2ldBMm1D5r1xMBSW1jU72zU6Zw=; b=E
    2QhAIGQBduO/F6OajPJigOYSj43LH0bfsYFnM5N/1nku0SgAPLHEGHIbvIu6Ty6X
    b97y7zeBKv2FXmzsLyW0zhbTqQgQbvkm8bkMI+Xiz2SSgDuXvgMGZ23oJ6Dn/4KJ
    JWRgxTJWTP+JvKw68D82is7lCpoPgTF87tBXk0kr5cnNvsqJ0LOIt7iXp38Ef/10
    4Ywo7hbkLtcJGvwIl6eUmReBRRYsSSJRYKbIoDL0UqH2lagvLnFOEmxFb7HZ7/F5
    5Ib2/m+q4JZsHY7vGbq9mh+ZJCAbJgkqTSOFWIZOH1D7Ax+5PrZxJ5gyk1gFjPCV
    J/f85kVKLHdV6tsq+Pa3w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBfanN8wdZ6HgpUDls7ZlHqQXv4ZskLR16+dhiYQHEsb5hraVUfRrLGhKkA/+qIMMKhvrmDdeWOnunaGL+L7kchKu6c6Z04gtSxJOdZcoflDzyAZc4TD
    getzLulkKyvwFAG4voN1vUCBoHS8ndCLFxgk43lW5G4+55wpSUZU0vtSnTPW3cA0HXG86j/8iWRoGneZ8IscLNT5C5aCDP7YCAkSXsV2PWVnjyEH7ZqL/ZTP
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Q9fys5e9bTEA:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=oQLfJTBTAAAA:8 a=37rDS-QxAAAA:8
    a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=CMs9CivKKxHkvO-iVasA:9 a=PUjeQqilurYA:10
    a=HUqATDVKn4QA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
    a=RgvzH8KC66dk9vUkDcCj:22 a=k1Nq6YrhK2t884LQW06G:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752928AbeDFNCY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752765AbeDFNBP (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CA22183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130113.687518198@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, linux-mm@kvack.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: [for-next][PATCH 13/18] ring-buffer: Check if memory is available before allocation
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0013-ring-buffer-Check-if-memory-is-available-before-allo.patch
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

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
---
 kernel/trace/ring_buffer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 515be03e3009..966128f02121 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1164,6 +1164,11 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
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
-- 
2.15.1
