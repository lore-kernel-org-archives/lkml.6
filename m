Return-Path: <kernel-hardening-return-12733-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/W7KM9KO5Zh0zwfqmm3oU5IPUyzj8HBSyjrqw10ssMiOqAiS6tRLUUyPf0OktlgA6roqzp
ARC-Seal: i=1; a=rsa-sha256; t=1522065845; cv=none;
        d=google.com; s=arc-20160816;
        b=QduT8KEUgDDwPdgAbTKC4PfOmXjfUYcVv9S9l7agXX7Tb952T9/r5focp6tHGQjIu9
         KBy2Q76dKYGcf8uKJ6punanlpion6upxMZ23J44pSYjuEQcsL82j1hNJi/AzoMRNJ1ID
         DZl80LyNH1w9BBlcanM6zYhzFwKWatR1uAmjWhnlo903gsUV4RT3SM+neFBxibwKqhzX
         mnNeqAz5yLjrp6BagTWJRRcPtVsfOWD/OjRa44qTBBDTFaJG+ovPGk5vlYo8OY6wk7dj
         YLNktmy6cgb8UEfkqdqTG6sVInCC/snDn/jVn+ZoZi86vyVd+4kr1o02d3mrvFVMd9NY
         bITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=+GDMUFAlQagOXvSmtV8VMElUcNLGA3s2f9E00sE9WKk=;
        b=VjUxsZ1EPiRxPhkhG5RWfvnzO3nXFm2edDyUIKjuf8HFEztu0uU9+liBmc/vsRqIob
         xYiiPKNYsH9CSqUEsn7+99QbYVKs4YQjV32fGuZ5n9IB+L9x1Z+d2Pl42R6TdyZULYpz
         8jNuOJLPQpD8q3E0TKXhFAGmY8QCMA02bTKb+tZt3i++risjwRqIbSCwuV6SvMQzicxe
         i0S5nmhUDtlrCVSLH5ewXPeV3je+r3OI3xJNDt/d2PINWpP2e1utvTwnfdpnlrNkLasf
         GaLNhwJ+IHjOQvHQjw5vIkvQCFwbmhYTaAOl71uEv5gHFznNfC+x8syhMK9Mg+7kcJdE
         hXQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=uIzcNMbC;
       spf=pass (google.com: domain of kernel-hardening-return-12733-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12733-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=uIzcNMbC;
       spf=pass (google.com: domain of kernel-hardening-return-12733-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12733-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 26 Mar 2018 14:03:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/4] task_struct: Allow randomized layout
Message-ID: <20180326120321.GD4129@hirez.programming.kicks-ass.net>
References: <1497905801-69164-1-git-send-email-keescook@chromium.org>
 <1497905801-69164-2-git-send-email-keescook@chromium.org>
 <20180326115246.GA4147@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326115246.GA4147@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1570668160952610935?=
X-GMAIL-MSGID: =?utf-8?q?1596001715676980406?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 01:52:46PM +0200, Peter Zijlstra wrote:

> That now looks like:
> 
> struct task_struct {
>         struct thread_info         thread_info;          /*     0    16 */
>         volatile long int          state;                /*    16     8 */
> 
>         /* XXX 40 bytes hole, try to pack */
> 
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         struct {
>                 void *             stack;                /*    64     8 */
>                 atomic_t           usage;                /*    72     4 */
>                 unsigned int       flags;                /*    76     4 */
>                 unsigned int       ptrace;               /*    80     4 */
>                 struct llist_node  wake_entry;           /*    88     8 */
> 
> 
> Can we please undo this crap?

The below gets rid of that nonsense.

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e2c7f4369eff..767cf74d61f7 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -242,6 +242,15 @@
 #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
 #define __randomize_layout __attribute__((randomize_layout))
 #define __no_randomize_layout __attribute__((no_randomize_layout))
+/*
+ * RANDSTRUCT_PLUGIN wants to use an anonymous struct, but it is only
+ * possible since GCC 4.6. To provide as much build testing coverage
+ * as possible, this is used for all GCC 4.6+ builds, and not just on
+ * RANDSTRUCT_PLUGIN builds.
+ */
+#define randomized_struct_fields_start	struct {
+#define randomized_struct_fields_end	} __randomize_layout;
+
 #endif
 
 #endif /* GCC_VERSION >= 40500 */
@@ -256,15 +265,6 @@
  */
 #define __visible	__attribute__((externally_visible))
 
-/*
- * RANDSTRUCT_PLUGIN wants to use an anonymous struct, but it is only
- * possible since GCC 4.6. To provide as much build testing coverage
- * as possible, this is used for all GCC 4.6+ builds, and not just on
- * RANDSTRUCT_PLUGIN builds.
- */
-#define randomized_struct_fields_start	struct {
-#define randomized_struct_fields_end	} __randomize_layout;
-
 #endif /* GCC_VERSION >= 40600 */
 
 
