Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoywricB15ROZKB8L47vxuNTu3T2EhtqAB75qbQdV5m+2Bw8law2wY0uF1Dk2r//GlA1GhC
ARC-Seal: i=1; a=rsa-sha256; t=1526937524; cv=none;
        d=google.com; s=arc-20160816;
        b=0RQqA654eF7h8tugr4oeStqK31Y3NkGYunfTYscDaeGfYlLmJ26gl5hwdhkDRF1mY+
         /4U1Cf0/1G9P1hGC9ao6+oMpquEdKkgsNK+LXOj1SuzhrFIpEJ75Vs206r3drzn1DoWP
         WgkmJYIOp3NQIJKmXUhWol3gCNtpj2dWWihanGwmLXA/D3F8LdZidgsDeyLArok0Vr1r
         8VMXWRLNISHiyGvdmHRe2iFb7M+sKvyVhMOw4hTOBVjZBEp34xZCxYi4k8a+H1mR1iMG
         ux/6l+eQrCmAf0Q+bnIsbl2RUa+IT8mozYKyJLj8W9ppkzhsPAi5TJdEgYeQtCNuHGou
         RlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=doBjWK2ZRNC6ZIEKjCxZOwAX8nOjOI6R/gAGHovyiKQ=;
        b=q1WVNWUOzZZmpKAIobBv236Ij9alT934sXmUlaRN+CablHNaFpgojwimJy50yRjgAZ
         TCNVvmzXettfnDOErQbcp7L19zIElQ6lcZA8QaKImptIcRyTRMygi75cvzEh/hV/ECIz
         USfaXray0RI2LopRXE4DS5S16ZYyKVm5N6QbzF5hgvmVTMfYkK55y0pfma/cxiq4hjlH
         VzqPKI8mysV05tPN0mP7SEtmyHMpdTLnIZ3WZUSFOLlWaiqAuQj15pRpowwWymOf2bax
         VWo3teTcFyV97dgA0LjiMXdNhZLzzeUjYKM8A2LU+edc+YnvNidcmF9V3hDvwfGjHXSb
         ozFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pmp9qBpN;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pmp9qBpN;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	"CR, Sapthagirish" <sapthagirish.cr@intel.com>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 25/95] radix tree: fix multi-order iteration race
Date: Mon, 21 May 2018 23:11:15 +0200
Message-Id: <20180521210453.552574505@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110042369790052?=
X-GMAIL-MSGID: =?utf-8?q?1601110042369790052?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Zwisler <ross.zwisler@linux.intel.com>

commit 9f418224e8114156d995b98fa4e0f4fd21f685fe upstream.

Fix a race in the multi-order iteration code which causes the kernel to
hit a GP fault.  This was first seen with a production v4.15 based
kernel (4.15.6-300.fc27.x86_64) utilizing a DAX workload which used
order 9 PMD DAX entries.

The race has to do with how we tear down multi-order sibling entries
when we are removing an item from the tree.  Remember for example that
an order 2 entry looks like this:

  struct radix_tree_node.slots[] = [entry][sibling][sibling][sibling]

where 'entry' is in some slot in the struct radix_tree_node, and the
three slots following 'entry' contain sibling pointers which point back
to 'entry.'

When we delete 'entry' from the tree, we call :

  radix_tree_delete()
    radix_tree_delete_item()
      __radix_tree_delete()
        replace_slot()

replace_slot() first removes the siblings in order from the first to the
last, then at then replaces 'entry' with NULL.  This means that for a
brief period of time we end up with one or more of the siblings removed,
so:

  struct radix_tree_node.slots[] = [entry][NULL][sibling][sibling]

This causes an issue if you have a reader iterating over the slots in
the tree via radix_tree_for_each_slot() while only under
rcu_read_lock()/rcu_read_unlock() protection.  This is a common case in
mm/filemap.c.

The issue is that when __radix_tree_next_slot() => skip_siblings() tries
to skip over the sibling entries in the slots, it currently does so with
an exact match on the slot directly preceding our current slot.
Normally this works:

                                      V preceding slot
  struct radix_tree_node.slots[] = [entry][sibling][sibling][sibling]
                                              ^ current slot

This lets you find the first sibling, and you skip them all in order.

But in the case where one of the siblings is NULL, that slot is skipped
and then our sibling detection is interrupted:

                                             V preceding slot
  struct radix_tree_node.slots[] = [entry][NULL][sibling][sibling]
                                                    ^ current slot

This means that the sibling pointers aren't recognized since they point
all the way back to 'entry', so we think that they are normal internal
radix tree pointers.  This causes us to think we need to walk down to a
struct radix_tree_node starting at the address of 'entry'.

In a real running kernel this will crash the thread with a GP fault when
you try and dereference the slots in your broken node starting at
'entry'.

We fix this race by fixing the way that skip_siblings() detects sibling
nodes.  Instead of testing against the preceding slot we instead look
for siblings via is_sibling_entry() which compares against the position
of the struct radix_tree_node.slots[] array.  This ensures that sibling
entries are properly identified, even if they are no longer contiguous
with the 'entry' they point to.

Link: http://lkml.kernel.org/r/20180503192430.7582-6-ross.zwisler@linux.intel.com
Fixes: 148deab223b2 ("radix-tree: improve multiorder iterators")
Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Reported-by: CR, Sapthagirish <sapthagirish.cr@intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/radix-tree.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1613,11 +1613,9 @@ static void set_iter_tags(struct radix_t
 static void __rcu **skip_siblings(struct radix_tree_node **nodep,
 			void __rcu **slot, struct radix_tree_iter *iter)
 {
-	void *sib = node_to_entry(slot - 1);
-
 	while (iter->index < iter->next_index) {
 		*nodep = rcu_dereference_raw(*slot);
-		if (*nodep && *nodep != sib)
+		if (*nodep && !is_sibling_entry(iter->node, *nodep))
 			return slot;
 		slot++;
 		iter->index = __radix_tree_iter_add(iter, 1);
@@ -1632,7 +1630,7 @@ void __rcu **__radix_tree_next_slot(void
 				struct radix_tree_iter *iter, unsigned flags)
 {
 	unsigned tag = flags & RADIX_TREE_ITER_TAG_MASK;
-	struct radix_tree_node *node = rcu_dereference_raw(*slot);
+	struct radix_tree_node *node;
 
 	slot = skip_siblings(&node, slot, iter);
 
