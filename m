Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225oQtl0d8BVCbfltXTOa48KrWuxiw41iufbxTWM5bQZazmMe/RoD8L0+IGDAE3F/9hBX3cK
ARC-Seal: i=1; a=rsa-sha256; t=1518709004; cv=none;
        d=google.com; s=arc-20160816;
        b=WB9fG65TWlaJ9IYLRTTVL/bdTescY5SbfVTYmIzbF8IDNgeppTptEC9dfNuY457mwM
         CpalFWyInQhIeEqCFVxmVcURyUEJXm2XwnKLm3DbsDmY9GDKSvYLtjhmsYFGf09Y6Yv3
         ZbOzyklQaw7X5j/BihFgf9FxxYIJCqy4zV32gOcknvgQ8qitxrDVJUm9dF2diq4o4jiv
         y6+Kjw+ZsHA/Nv565+dhMbdbQ0E0PUGxbtTn1+hfowAKogX5U55qWpuD0t1d5ZVLPB6z
         RTfeSPGOmB6FLYEMVaOk5/Z+xV/ka9MZANLsjlx82EASmPp3AzC2nMYBiY7YP0JcMFfm
         muoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vGD6cKEx6DsH9kxWs3ryGeEHhanbgZoCNcwveZgqq8M=;
        b=gAMC2YVyybYTAiwzDxjHQDQQrt7HAbyDWQ+HcI1Mz7kiTzUlfVXKgx5eTE8Ra6/U/D
         FPEEvwSQQ8FBuA8yqCJha5UkFpeKmpRBGGt1pRekMcL9TSFtNorf9QzBehSCLVHddPen
         npeBb+jrci9BT4we+b4FJFP/Sqz8WzY6NCH3cxp5xMAAVhgPz9LkCgTXhmLQ0NW7zmaR
         Fe1HCbzNgi4xdSKZ7CNvzY+psRvz+ehcWqjKEDr4c+ywpFjo2rnz8aKVOvsep5G88gf+
         4GEG3Z+RSPrBCV2TEW5I9IUEjf0/zYVlJSgq+RLdrBouVUD1ivLN7J1m26KSVvh2Z3Qn
         dOyA==
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
Subject: [PATCH 4.14 156/195] pipe: fix off-by-one error when checking buffer limits
Date: Thu, 15 Feb 2018 16:17:27 +0100
Message-Id: <20180215151713.710184015@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481371299527010?=
X-GMAIL-MSGID: =?utf-8?q?1592481813315973229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -610,12 +610,12 @@ static unsigned long account_pipe_buffer
 
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
