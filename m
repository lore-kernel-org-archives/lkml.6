Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226hfFzvB+hfFF0WLJ8+d4ygleUFvlu7wPjJHoNeOAQ1JRH5kTaA2JqFt+wXJ8njznYaLVu0
ARC-Seal: i=1; a=rsa-sha256; t=1518709003; cv=none;
        d=google.com; s=arc-20160816;
        b=Q1bGDQT67V9REWE63kCu/gRr7RPovBoNgEBZr4/LOKs0/QwRMSujye0PUrcjIceL2m
         5neYH6Fqz3xbla1nXfIGOnT8vlBsjf3zv4eZRVQGyiWxGk5jjaZgo87G0i1I7pcT4QfM
         5wQc+4Sbo8/zITyJnosxfFc+rn6qHg+z8Cfx3O4i67qrKhor960hvZaE/bhuT7/ctxiN
         uZvBhOplj7Yx6sIJmLVdgpqCmVkNxMP8VZm71iqwIt9GWK9R4nwFLGwqQMUEm3dJ3ivc
         cGLoyS/TvJEIcQV/zZeG05GSHo8hQAiqiG5AoIhACCtW8s19Lk3a/1iRdxl80YfTZA30
         YUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=okN+QU98medkO+7ihdt6c7Nu/+mp9r2jZybRO2E0Kzc=;
        b=bi5uzlKj9LhdcZiY37qmdT6MDawih8AiYnA5A6WMHieI6IUgBBZ5pY448pACXGXVrt
         k0QjfwsHnlRA0F49Qmci/es+JCNFXvtPihOeuNeZk+ao0tWPl8aNqQseBKvYcaBjzuNF
         kCVvdQpXP0AuNIc1GfUz5w6ZfvYDbvHyOtYjpszCGbKB5QKkDcByn+tITpmt+0Zxc4LR
         A3BKIEcIBz+ZLF/mxpRm5+GSxzUbkIyj6+2YTdaaOIr7q2MyQsFKxRiZm5ww26ZHWbfW
         e2y4big27SEkxQnfHwzq3NY84yrQCD+yRImsTGwCqZY3k7NuT+D0xUVdrham4/HZtiDo
         6viw==
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
Subject: [PATCH 4.14 155/195] pipe: actually allow root to exceed the pipe buffer limits
Date: Thu, 15 Feb 2018 16:17:26 +0100
Message-Id: <20180215151713.664934489@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481368765676021?=
X-GMAIL-MSGID: =?utf-8?q?1592481811721513949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -618,6 +618,11 @@ static bool too_many_pipe_buffers_hard(u
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
@@ -634,12 +639,12 @@ struct pipe_inode_info *alloc_pipe_info(
 
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
