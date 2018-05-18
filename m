Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpUa3GCGcnsiaWWjdV/FiBT8W9WAYcifsx+trxnOgWQ2NkXhliuXqdcQL+PLV7a04aIevES
ARC-Seal: i=1; a=rsa-sha256; t=1526631743; cv=none;
        d=google.com; s=arc-20160816;
        b=EFr1shGnI8ml5Jrf+6t8upB5n6YPyNUcXD2LyVwKsXm0zSEKeQEKB0RoVfFyY9sgq6
         fRYb9Wh53tv6YS9uzqnXFifIko5q3eOCf4uWWKIg+WX38meK67Tqh0VniKnpvem5FK5O
         IvdAJXqawVeoa45iuXN+U8AU4MYtSuugZdd4uTB/KXwqxcbJZcynaZdqu6wIXJEhz4Dp
         LyfCqW/k7gztdjfYce37RCDE6fDx3Ha1UEgB+yY/4CUBvGkwz6yBxae/54oCEiuSIEjd
         Nq0S6Dc3lknkQyG/cMYJqNw50LFA63wsYJ+Cl5/opQ7hTXXoCBck1BtWGkJJbt+mL77u
         m85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=1JsUP3bYCvegSqgGiymZbRVZNwRNqDkkF+9BSalYP5A=;
        b=BydBLcotsYQ8wSh7CIojxVv+pIbeHejTLJxTXwanGNmq9nlh+9M7UbhSc/A5R5A7Hp
         U1oe/r3CkIEIpUNj2UvFFbHT13573qh6LIWbze0PoKxifNb03XX367PIIZJ7Vr6ayesH
         7a1TO+V+RgXrevh9enG3r8MxXRpaNZ25CCCcSBYy1HGI5YnZtqvHkaQImd/LbbhMJzM+
         +88sZwm/Hpys5ybzIs18MVIe1Whf9iNJgpWfc/2DWmGHH2+4Kq0I2D1UieMtFLyBeRi0
         AyVoueoTJlOJGb0ESSieKXA+lxhN/h0MKpGR4Tk6KluGDH6VCZm+csUJuyc6o2jt2viX
         k53g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RTSWnxv6;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RTSWnxv6;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Qualys Security Advisory <qsa@qualys.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Oleg Nesterov <oleg@redhat.com>,
	Willy Tarreau <w@1wt.eu>
Subject: [PATCH 4.9 33/33] proc: do not access cmdline nor environ from file-backed areas
Date: Fri, 18 May 2018 10:16:12 +0200
Message-Id: <20180518081536.447142602@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789207110759992?=
X-GMAIL-MSGID: =?utf-8?q?1600789407401190452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willy Tarreau <w@1wt.eu>

commit 7f7ccc2ccc2e70c6054685f5e3522efa81556830 upstream.

proc_pid_cmdline_read() and environ_read() directly access the target
process' VM to retrieve the command line and environment. If this
process remaps these areas onto a file via mmap(), the requesting
process may experience various issues such as extra delays if the
underlying device is slow to respond.

Let's simply refuse to access file-backed areas in these functions.
For this we add a new FOLL_ANON gup flag that is passed to all calls
to access_remote_vm(). The code already takes care of such failures
(including unmapped areas). Accesses via /proc/pid/mem were not
changed though.

This was assigned CVE-2018-1120.

Note for stable backports: the patch may apply to kernels prior to 4.11
but silently miss one location; it must be checked that no call to
access_remote_vm() keeps zero as the last argument.

Reported-by: Qualys Security Advisory <qsa@qualys.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/base.c     |   10 +++++-----
 include/linux/mm.h |    1 +
 mm/gup.c           |    3 +++
 3 files changed, 9 insertions(+), 5 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -252,7 +252,7 @@ static ssize_t proc_pid_cmdline_read(str
 	 * Inherently racy -- command line shares address space
 	 * with code and data.
 	 */
-	rv = access_remote_vm(mm, arg_end - 1, &c, 1, 0);
+	rv = access_remote_vm(mm, arg_end - 1, &c, 1, FOLL_ANON);
 	if (rv <= 0)
 		goto out_free_page;
 
@@ -270,7 +270,7 @@ static ssize_t proc_pid_cmdline_read(str
 			int nr_read;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count, FOLL_ANON);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -305,7 +305,7 @@ static ssize_t proc_pid_cmdline_read(str
 			bool final;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count, FOLL_ANON);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -354,7 +354,7 @@ skip_argv:
 			bool final;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count, FOLL_ANON);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -970,7 +970,7 @@ static ssize_t environ_read(struct file
 		max_len = min_t(size_t, PAGE_SIZE, count);
 		this_len = min(max_len, this_len);
 
-		retval = access_remote_vm(mm, (env_start + src), page, this_len, 0);
+		retval = access_remote_vm(mm, (env_start + src), page, this_len, FOLL_ANON);
 
 		if (retval <= 0) {
 			ret = retval;
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2246,6 +2246,7 @@ static inline struct page *follow_page(s
 #define FOLL_MLOCK	0x1000	/* lock present pages */
 #define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
 #define FOLL_COW	0x4000	/* internal GUP flag */
+#define FOLL_ANON	0x8000	/* don't do file mappings */
 
 typedef int (*pte_fn_t)(pte_t *pte, pgtable_t token, unsigned long addr,
 			void *data);
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -430,6 +430,9 @@ static int check_vma_flags(struct vm_are
 	if (vm_flags & (VM_IO | VM_PFNMAP))
 		return -EFAULT;
 
+	if (gup_flags & FOLL_ANON && !vma_is_anonymous(vma))
+		return -EFAULT;
+
 	if (write) {
 		if (!(vm_flags & VM_WRITE)) {
 			if (!(gup_flags & FOLL_FORCE))
