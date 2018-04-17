Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48PCEUE5KN1yNtXpQj+wudSOK7Cs2j9oieOBIPatH7x+LlezcU+7Pd/N8UpJ0G3jSuRvRjk
ARC-Seal: i=1; a=rsa-sha256; t=1523981269; cv=none;
        d=google.com; s=arc-20160816;
        b=qj5izZV4gO38XxC/qielnS0M5SDtdw9XZVpaZhC2oaRYkmOm7XlsV8+T/yVWPZT6TJ
         BLtmNogn3mXW88+wDsVhP1deOoa9p8bzdSmtWITfHN6DsbZLZq0JLOvF4ysCP0UA/mbd
         uhyXPavbF6TaN8RV6I24Y0YFemnZDVAyG+PYy/HUHWetDBJW4mtF/qhb4DWu7soPmkqT
         C/egV8AlHaFa2CiXC3cgseAYmDlEo0uI9/8YBL8gP9YJCq5VHeZrZ5f6w7MX7lKwIVYs
         gslCrARGzBofCYdn6kgicjeLpOwLpwWU8fHOeGvAzB2ILOWzrwkMguV7K3Sn7mggcUvI
         Pv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/sy6HVfNXUNmEhGR7yCqI6/+BBeDqVG5o946hVgnbXg=;
        b=TmmspzwlcZ8ez1AtciG4oKBUz7OQrE5ebhJMkz3d4+wn41YPqiJcLeddJYWPiUWEiR
         HaJQqcaXuWgUsYt29ltT5o+xzSnwLnIFdxAZtHHWmAvprIEYpdY6kW63IixBg/4uaLwT
         vxiZCoU8QVHyFEFwKLhPoLpy5iE6kEIULobtr2c3hS5ebfA5nrjnMxoTR+1g0w5v2Luu
         Cjz2eJpdM+/tINw+slx7z2Cg1xs/2evEiRBDb1GLnnKQA3wtNIs2357Bd5fFg51ZlMv3
         HsrN6/43cKRjtF4bc7NFRw548uiMlm4DnOmJkRfxwxR6cz0RYenJJKZbhzBIvRHRbiy8
         qHwg==
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
Subject: [PATCH 4.14 31/49] get_user_pages_fast(): return -EFAULT on access_ok failure
Date: Tue, 17 Apr 2018 17:59:10 +0200
Message-Id: <20180417155716.507362957@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009890881181716?=
X-GMAIL-MSGID: =?utf-8?q?1598010183568664301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
