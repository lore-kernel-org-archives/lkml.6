Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/3EXxQ2GtC982pV6T9a2iyyOx0kQ0sEGbuJ37w/Imq4elBP8ds6kLmTckvLbJZQVVW720v
ARC-Seal: i=1; a=rsa-sha256; t=1523021665; cv=none;
        d=google.com; s=arc-20160816;
        b=f4z5UQqWej2AKqAvvMEZwXPmOp3FWLsX/cFeh9iJirx3yDvZPAgcIbVkOIHX5ltT/r
         63bBSQFJISNfX6OxigNtz3z4jD3Tw6lHXXqi7+grfVRpGn1FvxkT1KrDX96hR3fzEsZY
         eZqG02MFCNPnjAqaeJZNIDcUjrs+Y7XDGCuXMax/YmRgmZX5MkdWSzoGgjbfv8IN1OGL
         ZLvjUZt5AzzY5RkRWweNfwJMfUSscAkiMKh1C49LMQV5a6Btdk9iFShECE71IWup70xy
         syKospXT9nMT8R/mmBnJWt60yLGlNi+7iJvJRP+qzcXejon8d9cwlo+MlmG3z/a0NOiE
         PutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Z0fSiGuNtO7VL71JN5K5o+93B0iOdNz7qOFW+3eXBY8=;
        b=DWgdsVWOdR1iJPS04xazZNMQ/Jlf+YMqsgRjD9P+qtE0zBTk2y9WiK85fFOWFpCgzs
         NwFmyw1bf0DBqFbuHvlVZ7xx5HOdk7uaGjZFC7LAlLdMuFYMP4tqN6l9bjCS3sxV9JHd
         OFdEAvqNxzq1nwn63fxcgYVqFlDRlxL/6p/HmCHArxK4GNy/5ExVpWipJWovLktIGfTK
         Qbht9gaVc55vmB0oJcVHt3cIe971fKhTeNxHfV5VxWdT37qSitt4J4zK2LQmh+z3CHvJ
         m8wHDiiWuhBYd4X5wsuw6PxZ5dXwGQHhlA6U3SXOQHiXO6RCeY9WZY9cg8kjaQKI9Sa6
         2atw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Sodagudi Prasad <psodagud@codeaurora.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 047/102] llist: clang: introduce member_address_is_nonnull()
Date: Fri,  6 Apr 2018 15:23:28 +0200
Message-Id: <20180406084338.255456847@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003748394981081?=
X-GMAIL-MSGID: =?utf-8?q?1597003966747022977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Potapenko <glider@google.com>

commit beaec533fc2701a28a4d667f67c9f59c6e4e0d13 upstream.

Currently llist_for_each_entry() and llist_for_each_entry_safe() iterate
until &pos->member != NULL.  But when building the kernel with Clang,
the compiler assumes &pos->member cannot be NULL if the member's offset
is greater than 0 (which would be equivalent to the object being
non-contiguous in memory).  Therefore the loop condition is always true,
and the loops become infinite.

To work around this, introduce the member_address_is_nonnull() macro,
which casts object pointer to uintptr_t, thus letting the member pointer
to be NULL.

Signed-off-by: Alexander Potapenko <glider@google.com>
Tested-by: Sodagudi Prasad <psodagud@codeaurora.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/llist.h |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -88,6 +88,23 @@ static inline void init_llist_head(struc
 	container_of(ptr, type, member)
 
 /**
+ * member_address_is_nonnull - check whether the member address is not NULL
+ * @ptr:	the object pointer (struct type * that contains the llist_node)
+ * @member:	the name of the llist_node within the struct.
+ *
+ * This macro is conceptually the same as
+ *	&ptr->member != NULL
+ * but it works around the fact that compilers can decide that taking a member
+ * address is never a NULL pointer.
+ *
+ * Real objects that start at a high address and have a member at NULL are
+ * unlikely to exist, but such pointers may be returned e.g. by the
+ * container_of() macro.
+ */
+#define member_address_is_nonnull(ptr, member)	\
+	((uintptr_t)(ptr) + offsetof(typeof(*(ptr)), member) != 0)
+
+/**
  * llist_for_each - iterate over some deleted entries of a lock-less list
  * @pos:	the &struct llist_node to use as a loop cursor
  * @node:	the first entry of deleted list entries
@@ -121,7 +138,7 @@ static inline void init_llist_head(struc
  */
 #define llist_for_each_entry(pos, node, member)				\
 	for ((pos) = llist_entry((node), typeof(*(pos)), member);	\
-	     &(pos)->member != NULL;					\
+	     member_address_is_nonnull(pos, member);			\
 	     (pos) = llist_entry((pos)->member.next, typeof(*(pos)), member))
 
 /**
@@ -143,7 +160,7 @@ static inline void init_llist_head(struc
  */
 #define llist_for_each_entry_safe(pos, n, node, member)			       \
 	for (pos = llist_entry((node), typeof(*pos), member);		       \
-	     &pos->member != NULL &&					       \
+	     member_address_is_nonnull(pos, member) &&			       \
 	        (n = llist_entry(pos->member.next, typeof(*n), member), true); \
 	     pos = n)
 
