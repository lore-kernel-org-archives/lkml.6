Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227yxnWMpDiENsCoy4d9wGnNkxQtawMVTdkVDT4ZYBiUvAndAb+qSAD60nSJpYcZxmkCNUzL
ARC-Seal: i=1; a=rsa-sha256; t=1518708572; cv=none;
        d=google.com; s=arc-20160816;
        b=uyOsojTyLB7XOEHylhNGOeiB/BhKmzUypfaWlp/iO+frsw8WtGmKX4TucTIUntCeub
         dJpjU/vGT+p3Hwq7Du7CbMA8oSkU4x0Y90YCmnJlxIejAUgLFu9kcF7EZHkCbodcyPJv
         jel6UezEIEzvKKxJ3rdsGzOgZWXxzauSdwM4ikCy5Z3EdrkfKBk0h8S5cX/l5TWldtuN
         HFuACpq9Twe0f+b17QEo3w6CvGq4pmiM++EROkECs9l1YEvpgBH9U+/xdw3ij2+kkTBW
         /TwDVf/zS/UDLcskx9ZZ5XUdcxMqYp6SL9+wWQqM99/xgzmPM6fk8+Ac4WLMPAGVhFIx
         0fpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1g088M/YuyaKb3LiEL0dvgbg0f8gCA23Z9mF8CEZCGw=;
        b=eyPRAFxUENdS/5XYMcBp+0jYt29CV8pkHigK07pUiS4VYKm/HMViF+W+WS6hudBCcu
         tKzrQ5LU5rGJeOEqBkuyJw+Idrve22jS52XLHfkMuWCYhrh1RDmFxdwpSIVxl0dk/hzo
         9gQIRSeqfB9bL1OQA2eOCxOD8S1eLXMqI01/OFpI3mx/kPHYyw5of13bjJinuhzYRMYa
         zzQ1393nfSlo0zulkUxxyPmzzCaybAN5v910LnOZnwoVttd3PX1fArquZD4L1s/mm//Q
         uB+qRIIgPQ1+VZBdiHPvYKzjnw3XYdsg5I44h8G971IDvPGfsl5xhFXgsf2OueEuX5xb
         X2zw==
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
Subject: [PATCH 4.9 61/88] fs/proc/kcore.c: use probe_kernel_read() instead of memcpy()
Date: Thu, 15 Feb 2018 16:17:28 +0100
Message-Id: <20180215151231.108665950@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481359907139719?=
X-GMAIL-MSGID: =?utf-8?q?1592481359907139719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -507,23 +507,15 @@ read_kcore(struct file *file, char __use
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
