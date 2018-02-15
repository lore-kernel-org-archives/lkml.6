Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227fUSt2vknC/RkJTRBfWb1lfza9Cer3IqAJGv7ck44s4JN2ZnuvR546po+Aa+q33FiBdvKE
ARC-Seal: i=1; a=rsa-sha256; t=1518708999; cv=none;
        d=google.com; s=arc-20160816;
        b=laasF3PIxykSfTn695EXq6Qdto17zJxxbHFVB46+dHh9mzUneTyTmhFA9rCvNBEllv
         nUSobPzNTnocEUR1jeSR4JW1bUH5DVGmUVn20HRcM/5tLkBIEk94Up+iwQ3tfuW/Jdpg
         vgjvKY++dLkq2/Z4EW0UXzLaLdTeRayUMHCcMPlItHWpLwcpA8dqh1N/7R9mNMj/J1S9
         ve/g18SZNrNjuPXzySf0JkL0Tnc4KuU3A+mjO/Z9J50NoKp3M2eedMbbcgvrs2pV2dvN
         LODgef4bX9yynCdx47Q2HQRtwGM9R5VM9rN1F1h9p9cbudbFWx3qAW1dn+tdRRDVQr78
         +KAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=49U26Y0H5A3Aos0hHMMf1H1ml7B7Ukusu5Tf4HHDGVo=;
        b=WKXgt/iyoj+RUTskpviJ9JfXtlCqg3qxAy7XVnH8LbtXj9e9SoAMHcV4tO4qF4sq8n
         g1gJqETMJRntZZvbUS5JERL9omsHXdBgZktEZmQTnfQs7jdHq7defuo9LsRvS4h1AEwA
         mVJ1tIc4nlJ4GfogpQqrTR4JUIXmZGFTOC76ZeZZe/1Ex/vt9i8hpIDc+ABSDyw1Aq7t
         RX9/sqykQQ5VvcWjIKMy4vaqV0En0cE7wSNRC/42ZfqO5YC3iBqMB0D+0KdKMoKmrOFf
         Ecy63e90QRAjVjuYWVYSLo/Q56K6sqbb/86zOfhqthZ9xSn5TYVgQqbzmUfmhYWm4DYW
         5qLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 152/195] fs/proc/kcore.c: use probe_kernel_read() instead of memcpy()
Date: Thu, 15 Feb 2018 16:17:23 +0100
Message-Id: <20180215151713.480540866@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481359907139719?=
X-GMAIL-MSGID: =?utf-8?q?1592481807263596235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit d0290bc20d4739b7a900ae37eb5d4cc3be2b393f upstream.

Commit df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext
data") added a bounce buffer to avoid hardened usercopy checks.  Copying
to the bounce buffer was implemented with a simple memcpy() assuming
that it is always valid to read from kernel memory iff the
kern_addr_valid() check passed.

A simple, but pointless, test case like "dd if=/proc/kcore of=/dev/null"
now can easily crash the kernel, since the former execption handling on
invalid kernel addresses now doesn't work anymore.

Also adding a kern_addr_valid() implementation wouldn't help here.  Most
architectures simply return 1 here, while a couple implemented a page
table walk to figure out if something is mapped at the address in
question.

With DEBUG_PAGEALLOC active mappings are established and removed all the
time, so that relying on the result of kern_addr_valid() before
executing the memcpy() also doesn't work.

Therefore simply use probe_kernel_read() to copy to the bounce buffer.
This also allows to simplify read_kcore().

At least on s390 this fixes the observed crashes and doesn't introduce
warnings that were removed with df04abfd181a ("fs/proc/kcore.c: Add
bounce buffer for ktext data"), even though the generic
probe_kernel_read() implementation uses uaccess functions.

While looking into this I'm also wondering if kern_addr_valid() could be
completely removed...(?)

Link: http://lkml.kernel.org/r/20171202132739.99971-1-heiko.carstens@de.ibm.com
Fixes: df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext data")
Fixes: f5509cc18daa ("mm: Hardened usercopy")
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/kcore.c |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -512,23 +512,15 @@ read_kcore(struct file *file, char __use
 				return -EFAULT;
 		} else {
 			if (kern_addr_valid(start)) {
-				unsigned long n;
-
 				/*
 				 * Using bounce buffer to bypass the
 				 * hardened user copy kernel text checks.
 				 */
-				memcpy(buf, (char *) start, tsz);
-				n = copy_to_user(buffer, buf, tsz);
-				/*
-				 * We cannot distinguish between fault on source
-				 * and fault on destination. When this happens
-				 * we clear too and hope it will trigger the
-				 * EFAULT again.
-				 */
-				if (n) { 
-					if (clear_user(buffer + tsz - n,
-								n))
+				if (probe_kernel_read(buf, (void *) start, tsz)) {
+					if (clear_user(buffer, tsz))
+						return -EFAULT;
+				} else {
+					if (copy_to_user(buffer, buf, tsz))
 						return -EFAULT;
 				}
 			} else {
