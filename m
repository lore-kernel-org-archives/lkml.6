Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+zzTTkxQODxgYZMW3zovlduM/Bd+5/CctdhRq0F/nmbnxziTMZr0iRQ4S5NDwxl9VscD2G
ARC-Seal: i=1; a=rsa-sha256; t=1523021458; cv=none;
        d=google.com; s=arc-20160816;
        b=h0Jd9zchw9WqUbzrd+6v91jQT/jA1/bwaGggARNrnSplPuXMBD+/6hYA4MYmGqgJAv
         ayOVLrtWnRkFB9MAtxgLCNPswFPiefNYMX/Adz1+unrEz3Z5qDFto8ZVQfESblm6Y/r3
         nEQReKy+QzATON9Dca1apr/wlTsfwn6uPK52EZIyjgQ0E3dTEA9WOT3PgEIdQMDXEpgn
         zkMYN+0jROM+8e9wZSB5Ju91HNjHWmV8aYjKSkFFpI6M+1tCAjyqZ4TaWoCZhiIDz11Z
         wp1KB6y1nsQSTg70RQKkijOAqt+18s4XnsYvxQKCH51D7SUxIA99Y5Yv5lNbR7zNjsJq
         oM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RaUitviGQM8jZQK/2qXdASisZMpi/xy7ZSSG4S25g4M=;
        b=HsJZdEH9URfWDcBL3MpYQHw7dAWAs65Mvh+acNkugLXZGSQ9Cj1OFIyQaigg+f4HOv
         POq1Bwvkj+GEZkwF8iuagYN7TF7ve/yzRioXciND12uNoxg8jvph7BuspcMJfyh2fco4
         +WpbAJT+7P8fH26u7DYCKCyss1CsSL4TNvRhS1Y8tyRifRhwTjw/SEd2IYMs1nPPGVLO
         VIrYMM3CG+8ND4XgA04/Baif4/OD1HtSSvA54ULpnY6Z+7n2yrGiRlCE14ij3dVJT7BQ
         DY0FJjsSgXnwLTXXVXwvQT4xwPCtuJ7vlm24H6T7quZjZFR+8KY5DtCUNW9/RAEeWcmq
         L80Q==
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
Subject: [PATCH 4.4 42/72] llist: clang: introduce member_address_is_nonnull()
Date: Fri,  6 Apr 2018 15:23:43 +0200
Message-Id: <20180406084308.659254226@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003748394981081?=
X-GMAIL-MSGID: =?utf-8?q?1597003748394981081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
