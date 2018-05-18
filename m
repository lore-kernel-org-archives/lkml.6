Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq+q2caL4yy49Vwz+EZUibYKOG2kRZTEDNdcqm2SXydJsv9TZqi0CiNQV+SJMviyKxNAs/W
ARC-Seal: i=1; a=rsa-sha256; t=1526631552; cv=none;
        d=google.com; s=arc-20160816;
        b=fti2Nl1FW9HUrU2IwBHlXvuzHqrxYrLSA+KDiwUN1FzXQmKcgL7sG9wj2ZD83YTvEe
         sR6/RIipqDHjjOmRZ+iCLaM4NnHSxOygN81sTNLt2G8x6IR6vouJeWe6fQGA5sBrL+H7
         qgu7UOt8WCVvX/SFd5uGKu0QK69lnOSO1shhqdi0hAAXT1oInHbd3E/6yYL+yRoBayOP
         5bSbVO+LcHvqObwHjZ4J53yf124vRhIT13FxKr8id9MHDF/oGG8BOvh0E8qNd5omnrvM
         Co9Mx8zlv6F/DRhCsdO/VSPKV3ZS70asvM8W/hPrsbejuqsqr4LRk9w2ZYpDTEEl0sjz
         DMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ed4r2mVrQSflaRcQBKZZSO4EAgv1DDK23ZWECronqh4=;
        b=LXGd0ocUWF3l02l2f1jqy/zKw8BD+BQLb9GJXMOKfqri9uGj8uaxM71N0k3BGIYpdV
         sQglQQAOhDJX1WbKkHjP0hW+ttThrvOVZhfdIwnyS0gqnOePNLayoJFI2lrKW8BSk4Yv
         s3ZRWpGnG8E8lV8VcyKYE6uo7u52CemDpn06u8jvqv8Bk5YDq3kvSFA5iuSvGbXUojeK
         sL27CQYYCYma4QCR4shuQkOdWTmapFtQIiTx8NYx4xI4cKpR8C0oznQXmSJWlwX2NF/Y
         HSDcWNZi9dyz/RKyXrzMPyJ34t/nw3wUkcVZQuKwDB31s+g5RurN7gh4mgzxTq5x1KRf
         wyRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tSEvrWdy;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=tSEvrWdy;
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
Subject: [PATCH 4.16 55/55] proc: do not access cmdline nor environ from file-backed areas
Date: Fri, 18 May 2018 10:15:51 +0200
Message-Id: <20180518081459.936065670@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789207110759992?=
X-GMAIL-MSGID: =?utf-8?q?1600789207110759992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 fs/proc/base.c     |    8 ++++----
 include/linux/mm.h |    1 +
 mm/gup.c           |    3 +++
 3 files changed, 8 insertions(+), 4 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -264,7 +264,7 @@ static ssize_t proc_pid_cmdline_read(str
 	 * Inherently racy -- command line shares address space
 	 * with code and data.
 	 */
-	rv = access_remote_vm(mm, arg_end - 1, &c, 1, 0);
+	rv = access_remote_vm(mm, arg_end - 1, &c, 1, FOLL_ANON);
 	if (rv <= 0)
 		goto out_free_page;
 
@@ -282,7 +282,7 @@ static ssize_t proc_pid_cmdline_read(str
 			int nr_read;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count, FOLL_ANON);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -328,7 +328,7 @@ static ssize_t proc_pid_cmdline_read(str
 				bool final;
 
 				_count = min3(count, len, PAGE_SIZE);
-				nr_read = access_remote_vm(mm, p, page, _count, 0);
+				nr_read = access_remote_vm(mm, p, page, _count, FOLL_ANON);
 				if (nr_read < 0)
 					rv = nr_read;
 				if (nr_read <= 0)
@@ -946,7 +946,7 @@ static ssize_t environ_read(struct file
 		max_len = min_t(size_t, PAGE_SIZE, count);
 		this_len = min(max_len, this_len);
 
-		retval = access_remote_vm(mm, (env_start + src), page, this_len, 0);
+		retval = access_remote_vm(mm, (env_start + src), page, this_len, FOLL_ANON);
 
 		if (retval <= 0) {
 			ret = retval;
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2441,6 +2441,7 @@ static inline struct page *follow_page(s
 #define FOLL_MLOCK	0x1000	/* lock present pages */
 #define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
 #define FOLL_COW	0x4000	/* internal GUP flag */
+#define FOLL_ANON	0x8000	/* don't do file mappings */
 
 static inline int vm_fault_to_errno(int vm_fault, int foll_flags)
 {
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -544,6 +544,9 @@ static int check_vma_flags(struct vm_are
 	if (vm_flags & (VM_IO | VM_PFNMAP))
 		return -EFAULT;
 
+	if (gup_flags & FOLL_ANON && !vma_is_anonymous(vma))
+		return -EFAULT;
+
 	if (write) {
 		if (!(vm_flags & VM_WRITE)) {
 			if (!(gup_flags & FOLL_FORCE))
