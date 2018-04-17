Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48p4TSz8v+OPtSHYJCfI63/keYSVunaTRMAOH/EBhb09FHcQtf/qrnxcrzpFmkpTvMSFxoA
ARC-Seal: i=1; a=rsa-sha256; t=1523981133; cv=none;
        d=google.com; s=arc-20160816;
        b=qlXZ7H1SPTqv1EZVZs7Mt33m4vvLJdL91la3WgAf94ANuK3Zo/boIdTyY4eeWucfi4
         Ser+gyVm4IGmUiIU+OezXFFtX2P3xd+/tW34tSrJWcKFRIDrztae41ZGCQyzwBmoa9Px
         z17lFT5V+amRrHXZ9YJMh0vf45AvBSJwQgBHiLewCD5leDuZ2egwg5XmZwCZJ+cN2XqS
         ip4NMXMhSf+nwenp439/+C49mtL/AlEb9PXHsaHGPxih3YBYhJqKMdPxp0QI5hsgui1i
         8LvCLBp6fzk7zSrmCFd+WdWpAcLmaoFoJGBPxfDqzHqZe24i6npnVIBIQFvVmL8NSjxy
         ZX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QU95Cag0VF+yPrwu+s5y87iJtp5K4MC8b484xtYOHRM=;
        b=EacRRQfFuPdS5rwDvieXyS+fT/nzjgR1TMK++SFbN6yq6TR9A8Ym+RB2lCmAPkOFAT
         +YUDIYVAqFu5CQdnzennwspWg4QhdoPnbjvwRLsiE9MjutxC6y3mF73uHqbXIv/zTvnK
         EGvw/yPBUOWpGWvitYaKt8FfrJXz0c88JpVaO/A9cje6nJ9JGNItQkZi5xjNOmJWE/Fl
         m1a7sVFTbF2aJpiIYm1ngm9LaAnL+GcV5wA8Tdq21yXJtxBuvck1bkyVcuHwBEPKsfHV
         FGy7Y4Ti6XU4gdd7/p+Nb0WubZtsWdwkcYScntiCqPbA9mbiksS1a0BQ8PvGSzgP56wr
         pEGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 47/53] get_user_pages_fast(): return -EFAULT on access_ok failure
Date: Tue, 17 Apr 2018 17:59:12 +0200
Message-Id: <20180417155725.369805968@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009890881181716?=
X-GMAIL-MSGID: =?utf-8?q?1598010040493326589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit c61611f70958d86f659bca25c02ae69413747a8d upstream.

get_user_pages_fast is supposed to be a faster drop-in equivalent of
get_user_pages.  As such, callers expect it to return a negative return
code when passed an invalid address, and never expect it to return 0
when passed a positive number of pages, since its documentation says:

 * Returns number of pages pinned. This may be fewer than the number
 * requested. If nr_pages is 0 or negative, returns 0. If no pages
 * were pinned, returns -errno.

When get_user_pages_fast fall back on get_user_pages this is exactly
what happens.  Unfortunately the implementation is inconsistent: it
returns 0 if passed a kernel address, confusing callers: for example,
the following is pretty common but does not appear to do the right thing
with a kernel address:

        ret = get_user_pages_fast(addr, 1, writeable, &page);
        if (ret < 0)
                return ret;

Change get_user_pages_fast to return -EFAULT when supplied a kernel
address to make it match expectations.

All callers have been audited for consistency with the documented
semantics.

Link: http://lkml.kernel.org/r/1522962072-182137-4-git-send-email-mst@redhat.com
Fixes: 5b65c4677a57 ("mm, x86/mm: Fix performance regression in get_user_pages_fast()")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reported-by: syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/gup.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1816,9 +1816,12 @@ int get_user_pages_fast(unsigned long st
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
 
+	if (nr_pages <= 0)
+		return 0;
+
 	if (unlikely(!access_ok(write ? VERIFY_WRITE : VERIFY_READ,
 					(void __user *)start, len)))
-		return 0;
+		return -EFAULT;
 
 	if (gup_fast_permitted(start, nr_pages, write)) {
 		local_irq_disable();
