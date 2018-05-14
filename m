Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZogqh5fT8+WQahTy2YXj/4Ycc3c/DsL5szvLtVl4ihwMEt9uTyvBkpw1kXeVpKK+CZcBZbM
ARC-Seal: i=1; a=rsa-sha256; t=1526281117; cv=none;
        d=google.com; s=arc-20160816;
        b=DahJ9o26FnZYFJmHEs2Ku34u6Byahk6NiKXxKbeR14V91gvqvKTfb/LN8u+Isgz37v
         C93jW3Tpy7AGUZt1smXH4Ozda1F22vvOOrIT+hTeX8rCaOHRe/Mvhc5JGMchZPQTsgXd
         rPqU5HuLgNh4BQ52GVdwSyUckkNOjWPivSeN+x6ltozxyOCCrGamAyU6iyZrOnpQBoKO
         niQLkHNNUvS8BOqMtmbjT1vitCffEk+ks/UcRoHfFfmph1gZecqUKHRcH/OM6yxoHt3V
         oxh5oCQMS2FTleZ+lYP4mDWONvqtVbk/yDtfv4GSFYqZmEGF3p7E7TKrr5jhoTS6A79f
         0KWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=peD5+3zO36XKIyF4FZBLjiBqRHqvOZQEujctBlN6Y+M=;
        b=KwXH5sV7NM/xIHcJ5aqbZqnM2IWXPt4TkvzKNoLyKjr+jBVAMk8+sOR+tzYfdUVI61
         K7rYSQiF7i4HUSHvtc+FscLVN1EaX4gyg6piV5exgL/rUk9GVqDOVOw2Yk9n9QiG0yI0
         NfrGXMjgOQna8XWXgYugLni7ljXDRugh3NAPIQ/VMn/oo0qpILLyZsewBiWfXYt/SCAb
         JceglTONmMz+SMp8wFZwrrqkh8rMFf8afZpiXQgK/csAOkiIlZvGYuwNyVhCLbq8JqMZ
         Nx+4nbV0cvxrx5UwfRMQU19vcSi3SwBwHLjqKAQMXzgiUqyyVK5Vh3yf1ahpb1vJoAUv
         0w2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xq7NHKjs;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xq7NHKjs;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Kees Cook <keescook@chromium.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 23/72] compat: fix 4-byte infoleak via uninitialized struct field
Date: Mon, 14 May 2018 08:48:40 +0200
Message-Id: <20180514064824.013866096@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421570040873746?=
X-GMAIL-MSGID: =?utf-8?q?1600421748541696227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 0a0b98734479aa5b3c671d5190e86273372cab95 upstream.

Commit 3a4d44b61625 ("ntp: Move adjtimex related compat syscalls to
native counterparts") removed the memset() in compat_get_timex().  Since
then, the compat adjtimex syscall can invoke do_adjtimex() with an
uninitialized ->tai.

If do_adjtimex() doesn't write to ->tai (e.g.  because the arguments are
invalid), compat_put_timex() then copies the uninitialized ->tai field
to userspace.

Fix it by adding the memset() back.

Fixes: 3a4d44b61625 ("ntp: Move adjtimex related compat syscalls to native counterparts")
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/compat.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -34,6 +34,7 @@ int compat_get_timex(struct timex *txc,
 {
 	struct compat_timex tx32;
 
+	memset(txc, 0, sizeof(struct timex));
 	if (copy_from_user(&tx32, utp, sizeof(struct compat_timex)))
 		return -EFAULT;
 
