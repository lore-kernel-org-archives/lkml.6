Return-Path: <kernel-hardening-return-12732-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvqiU9477wfaQWKY0gO9+4TE/r4FseEHwfhkqpuVzHAibWDsBERjSX5AH2ZqDGKsgGzoe+X
ARC-Seal: i=1; a=rsa-sha256; t=1522065191; cv=none;
        d=google.com; s=arc-20160816;
        b=CneCVD+1FlziZGjJzygSQBs6RN9+GMiqUET8iTybIY2US5vTqH6KTkE8TuExxTHAh2
         35qdF57WqxKqlV70WEWWKI7JMGwahd/OQ9kks+9JRD+WzTCJCjxFJ7nl1qa/orfamU4F
         bxK672UQJMli/qlIA3s4B3Z7NhjH/wwSBqRQMowpzUdEH6cjc0+hFDxWwWr9FRg0rk71
         DIeJMyz9/QPVH1v7KPBvJv4I5HlqGL4TVl/KqhaIblIcKtChRAa7b3BM0qF7y04QD8Fg
         EdCrpc/Iu5vOsIXSgR9z8CD135RXDlTQKsrMu1ry/sk/1sSmG/qAfZwxPdH1PFmBpSy4
         4etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=4lPSFbQ5SaLy+02/+Sc2jlcMhmUcTK8PMKnE9esQpEc=;
        b=za6SX3d4NhWNOTnj3J7nr3buwT/3q50eqUoAGqKqOSDhyuIimw4rqxBF9I1mA/eEIh
         8RpbGF2RLgm0cH0uMVCrN0ZLbWdFFp4yWK1X6/a/0C0hOxRt9rJV0cu4OmrVfUWiGMPv
         CLbW+DFG8Cy+eb8uShajDZxBKrBOJyFPlgE3iiAgy/iAtdlh8GK1YzJUliHuBA4Uyj3s
         LfXvHZQb44OqRsI/PmKyLF5e2xlGflnwLzxI/FQ7gCv0lv1PfmLWdUtModrDwVLj5RKP
         5daSKmyl41/qP3QmfOMnhukxxocRSGUjanQDOc3FbZTKxAZq+A0dMMhc8OtR6w2astZp
         e6Bw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=mkH/pVcv;
       spf=pass (google.com: domain of kernel-hardening-return-12732-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12732-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=mkH/pVcv;
       spf=pass (google.com: domain of kernel-hardening-return-12732-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12732-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 26 Mar 2018 13:52:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] task_struct: Allow randomized layout
Message-ID: <20180326115246.GA4147@hirez.programming.kicks-ass.net>
References: <1497905801-69164-1-git-send-email-keescook@chromium.org>
 <1497905801-69164-2-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497905801-69164-2-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1570668160952610935?=
X-GMAIL-MSGID: =?utf-8?q?1596001030456512314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jun 19, 2017 at 01:56:38PM -0700, Kees Cook wrote:
> This marks most of the layout of task_struct as randomizable, but leaves
> thread_info and scheduler state untouched at the start, and thread_struct
> untouched at the end.
> 
> Other parts of the kernel use unnamed structures, but the 0-day builder
> using gcc-4.4 blows up on static initializers. Officially, it's documented
> as only working on gcc 4.6 and later, which further confuses me:
> 	https://gcc.gnu.org/wiki/C11Status
> The structure layout randomization already requires gcc 4.7, but instead
> of depending on the plugin being enabled, just check the gcc versions
> for wider build testing. At Linus's suggestion, the marking is hidden
> in a macro to reduce how ugly it looks. Additionally, indenting is left
> unchanged since it would make things harder to read.
> 
> Randomization of task_struct is modified from Brad Spengler/PaX Team's
> code in the last public patch of grsecurity/PaX based on my understanding
> of the code. Changes or omissions from the original code are mine and
> don't reflect the original grsecurity/PaX code.
> 
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for the Cc :/

> +#define randomized_struct_fields_start	struct {
> +#define randomized_struct_fields_end	} __randomize_layout;

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f833254fce00..e2ad3531e7fe 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -490,6 +490,13 @@ struct task_struct {
>  #endif
>  	/* -1 unrunnable, 0 runnable, >0 stopped: */
>  	volatile long			state;
> +
> +	/*
> +	 * This begins the randomizable portion of task_struct. Only
> +	 * scheduling-critical items should be added above here.
> +	 */
> +	randomized_struct_fields_start
> +
>  	void				*stack;
>  	atomic_t			usage;
>  	/* Per task flags (PF_*), defined further below: */


That now looks like:

struct task_struct {
        struct thread_info         thread_info;          /*     0    16 */
        volatile long int          state;                /*    16     8 */

        /* XXX 40 bytes hole, try to pack */

        /* --- cacheline 1 boundary (64 bytes) --- */
        struct {
                void *             stack;                /*    64     8 */
                atomic_t           usage;                /*    72     4 */
                unsigned int       flags;                /*    76     4 */
                unsigned int       ptrace;               /*    80     4 */
                struct llist_node  wake_entry;           /*    88     8 */


Can we please undo this crap?
