Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/9zPwztsR8Dozk/Vj7JX42kFxh+XZW4mxUF6WKA4mkJ4f7zkNMzJ9rd+kMbdz2JsTDFt3g
ARC-Seal: i=1; a=rsa-sha256; t=1523980990; cv=none;
        d=google.com; s=arc-20160816;
        b=NCJsJ8pf1Vyc0urlRAT4iHXJbwh+rsoNXBdKkHRNXTJmGWC444TNCOKQam+Y/8H+aM
         bFR/AaQ8I69h0nvCuMT0WCf0ejCryBRAg6tnGSN1H5O5JOja0JQUkoJGWK419XDAWvdU
         KkQkieywRfkyYdqgCjte03EY6e/pZbPe4BAoax11fum3vpg+/r8Jd3KlgpINbOV06gWy
         NfW9neH/lZMqbd+S1dQUlz2fmCRwrfb9YQ5u08ulV0ogZUSnyU7T2y9hQ/j//eHuad7i
         n0kwzf1xX8X3SO4Ed8reYuzCtmAxHViattnjq+vk66JfLr3oM3RwjpcAR0ysHHQexPtQ
         K4SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q9xWZ13k8KV1saQSF/ariIjAfcCqAoeU+Q0NOVSDTv8=;
        b=hV/irr4H4X7u7/oPVu5Mwgj6MaJfTKvsa8e0T5O5m3lnyFIkHprHAVoFE1BrBuu9d7
         BLfB2QWAOY11NXGuV/3cgZ4/1O7bcSGflNNzdXw/JClM7l43a6qtWs8gRj0y74cc6N4W
         tUt+LKbEOTSP4r1fIYkcuqg0rZfeH6pcUqWQQWBlaajtKrFFCxtS+x90RybxCtXerjKw
         H60aKgnXKF8TzYfVkvFkAT7aOq3R7OlR0NwYTIaTFD3tUqniWH8Y2A8Ia0hdbRKVTeIQ
         f/yjuJw/+jTXSxHIWraVmj9loQfa0GYRPaJOhszgfKnNvN+LjBL9C09Ds+A42IK8bYz9
         Srtg==
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
Subject: [PATCH 4.16 63/68] get_user_pages_fast(): return -EFAULT on access_ok failure
Date: Tue, 17 Apr 2018 17:58:16 +0200
Message-Id: <20180417155751.897116079@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009890881181716?=
X-GMAIL-MSGID: =?utf-8?q?1598009890881181716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1806,9 +1806,12 @@ int get_user_pages_fast(unsigned long st
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
