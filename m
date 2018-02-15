Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2249PNcQkCwQHafNmFH09xmuED6a0rOZ+G2Jz8Z3Hki54oqgMVidLmejJWu1qntwsYYUrY8j
ARC-Seal: i=1; a=rsa-sha256; t=1518708583; cv=none;
        d=google.com; s=arc-20160816;
        b=ZkR7P7fLqzWSYB6cJ3O8WJOnedHhyK2OIMemnqE9JB6Wf3yDjJZWFGy1kT+9mD7Q9v
         LNUHKgNtPsXwoiigd3BI3xMP4mdtM8kVVGUWvahZya7W3vi5cAmwDAtbBQCbEbnRi0b6
         Jfo+QBddSsfTg93fwxXi5qM7FlWCk2jzHEcJMtauJmXnCcbt+ADSXzcZG9KMZNSek9nZ
         8xldYFjCn/SwzujSxmoRQXboogdoRKkDoWDUhdD2rokadUAtalKJcW/PaqOXNymcjhVz
         gt/FJIruMO9uaerTBwcFRR12HNY0LMQcSK0pLPqJMJy/R7KgNo/+JlZn0/+1hbVzInqG
         JLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tQ0W/mqevM1M1xHr6mU0x+7wctwz782Ewwy8aOjeJ80=;
        b=Wp9gWzWk6VBtHkiqTek32s2XRjiMQXGe8gAk3s9W79CJod8hFg9DRUBfs7m9J4QN98
         o/hfcbnAFsUoc2hXSh1Z5/KFT2FvU8RJTuzEIk83khv70cVFpQSphMCz26iC/Ze3jPzx
         pN+9xidwyeizrBUB6sFYeehCDQA24l74aRrKRyiGtWWIQLU9fNQ/IHLxQAzSbBsyYZz2
         2pKWwvjypI3R+D8c4VChsQigtUXWAmVZqIzfrw39Jt7emA60DDC1SuIyua+9yI03E7/7
         Z+ZNpZeyIKBUJgiiSivINr8qpvJ/PLkSPRhAcn8lPMGKTLerIlgF/bQuR8Sgk7xBTnrQ
         V2cA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Willy Tarreau <w@1wt.eu>,
	Kees Cook <keescook@chromium.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 65/88] pipe: fix off-by-one error when checking buffer limits
Date: Thu, 15 Feb 2018 16:17:32 +0100
Message-Id: <20180215151231.611934500@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481371299527010?=
X-GMAIL-MSGID: =?utf-8?q?1592481371299527010?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 9903a91c763ecdae333a04a9d89d79d2b8966503 upstream.

With pipe-user-pages-hard set to 'N', users were actually only allowed up
to 'N - 1' buffers; and likewise for pipe-user-pages-soft.

Fix this to allow up to 'N' buffers, as would be expected.

Link: http://lkml.kernel.org/r/20180111052902.14409-5-ebiggers3@gmail.com
Fixes: b0b91d18e2e9 ("pipe: fix limit checking in pipe_set_size()")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Willy Tarreau <w@1wt.eu>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/pipe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -609,12 +609,12 @@ static unsigned long account_pipe_buffer
 
 static bool too_many_pipe_buffers_soft(unsigned long user_bufs)
 {
-	return pipe_user_pages_soft && user_bufs >= pipe_user_pages_soft;
+	return pipe_user_pages_soft && user_bufs > pipe_user_pages_soft;
 }
 
 static bool too_many_pipe_buffers_hard(unsigned long user_bufs)
 {
-	return pipe_user_pages_hard && user_bufs >= pipe_user_pages_hard;
+	return pipe_user_pages_hard && user_bufs > pipe_user_pages_hard;
 }
 
 static bool is_unprivileged_user(void)
