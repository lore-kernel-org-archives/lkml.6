Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224VuFk+2P26J9xQjnThyNKCo8crfkw7fvMrgZyr8E671vXwCu+hlRXjySS+/JpPXF65WzQo
ARC-Seal: i=1; a=rsa-sha256; t=1518708580; cv=none;
        d=google.com; s=arc-20160816;
        b=tWwC5P+AkSOFJZtH+gQ+qotAp1LuLNlCdKAX6n2CQ3vHiGj4U1lob0RsmtbwRiybC7
         PEavt3E08Py1go84rxX1GW9navllBNQoMkxxiq4mU9T2/FXMRJoM+ooNIuF7klrx/b3S
         emoC4f9TVFV+Hv7w+P33O/DHEt9h23JyYX9mBG1SA3RBe7wUg9P4koi8MQ4TDKLVdmoc
         7AO/wViichiMwcH4hVlzNsKWv31iiYqg7sGlAyDSQh0UFlQtsarCGJmSECxURBMCMC6c
         affkfBd0B+SJlw7+1k9zOAcenR5F2F167GVPvCMlnFhNL4BlY+KlknCehDOUspIii5+/
         7pCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QqeVpjnlbK0CL6Ekz9yFMGBPSn9wThlVkz7YNCEV8IA=;
        b=K7ukksqJmZnmaOUaqK7pUICsu73FUyNpfswur+HXMYCmE7WT1BF482a3lVS6xeis1Z
         TdCcpHKlTxWEYg6OUHV/rTTrqoObBgy5xkGGCWtGYHkchtWXWWf64nJTp8FLCWjx+a69
         MLZxXQ0q2YEEEC8p42Kmhl0qI18FvbAr4wotBPuZYoff80H8Jg7051cRDPyXa2/F7cTq
         tZLCDHy5jTkd8mYr7k+VdxVdcG/UxhN2QRUF4iJ1YvCZ4N60awJ1FYPp1mtoBQUkjqLU
         pCMYiLlHEMn6EeR++/NLADlxs7VbkgYILlDZbt/B1FsjiHgC76pIiXFhFjY+DtotA1UO
         +cvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Kees Cook <keescook@chromium.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Willy Tarreau <w@1wt.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 64/88] pipe: actually allow root to exceed the pipe buffer limits
Date: Thu, 15 Feb 2018 16:17:31 +0100
Message-Id: <20180215151231.467940696@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481368765676021?=
X-GMAIL-MSGID: =?utf-8?q?1592481368765676021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 85c2dd5473b2718b4b63e74bfeb1ca876868e11f upstream.

pipe-user-pages-hard and pipe-user-pages-soft are only supposed to apply
to unprivileged users, as documented in both Documentation/sysctl/fs.txt
and the pipe(7) man page.

However, the capabilities are actually only checked when increasing a
pipe's size using F_SETPIPE_SZ, not when creating a new pipe.  Therefore,
if pipe-user-pages-hard has been set, the root user can run into it and be
unable to create pipes.  Similarly, if pipe-user-pages-soft has been set,
the root user can run into it and have their pipes limited to 1 page each.

Fix this by allowing the privileged override in both cases.

Link: http://lkml.kernel.org/r/20180111052902.14409-4-ebiggers3@gmail.com
Fixes: 759c01142a5d ("pipe: limit the per-user amount of pages allocated in pipes")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/pipe.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -617,6 +617,11 @@ static bool too_many_pipe_buffers_hard(u
 	return pipe_user_pages_hard && user_bufs >= pipe_user_pages_hard;
 }
 
+static bool is_unprivileged_user(void)
+{
+	return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
+}
+
 struct pipe_inode_info *alloc_pipe_info(void)
 {
 	struct pipe_inode_info *pipe;
@@ -633,12 +638,12 @@ struct pipe_inode_info *alloc_pipe_info(
 
 	user_bufs = account_pipe_buffers(user, 0, pipe_bufs);
 
-	if (too_many_pipe_buffers_soft(user_bufs)) {
+	if (too_many_pipe_buffers_soft(user_bufs) && is_unprivileged_user()) {
 		user_bufs = account_pipe_buffers(user, pipe_bufs, 1);
 		pipe_bufs = 1;
 	}
 
-	if (too_many_pipe_buffers_hard(user_bufs))
+	if (too_many_pipe_buffers_hard(user_bufs) && is_unprivileged_user())
 		goto out_revert_acct;
 
 	pipe->bufs = kcalloc(pipe_bufs, sizeof(struct pipe_buffer),
@@ -1069,7 +1074,7 @@ static long pipe_set_size(struct pipe_in
 	if (nr_pages > pipe->buffers &&
 			(too_many_pipe_buffers_hard(user_bufs) ||
 			 too_many_pipe_buffers_soft(user_bufs)) &&
-			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN)) {
+			is_unprivileged_user()) {
 		ret = -EPERM;
 		goto out_revert_acct;
 	}
