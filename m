Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvnsZvgc3APBxcxVve9jdZaSM6ohBq8GCiS4ryAmEZQCuzeZZ0MfB7Nh0193LJ5gipuRUwR
ARC-Seal: i=1; a=rsa-sha256; t=1519981030; cv=none;
        d=google.com; s=arc-20160816;
        b=BjTaqwkgio/ps9S9hjBzV4ypMqedJzzSdP5QzN+a+Zs0GQdq3uAiYwvcy12plq5TYQ
         FJ4yuTJkwl293uXCPWdGQ9Hs4Q1ezEKJl3uG1Dq+pdnZzly276SjcRz9qyFOk+JuXhnd
         hIZG7sV8odVjyXF/WHPphM27HLtZSQqMan6nBbI3A7zijkarXwWv/Ns9iVYUMo30h6pw
         K3g54XOnNRqIRNBWry8Svokp8fmkTEJmVFiPXGy/mve/yck/bog2XPUo2RIu6uQRTji7
         1AqJqCyTh7GJS8GJ+t2U0eUcYhbcQVp1kn3r4bsVXsAN8+/H73gbjyuh/WK4KF/yH38o
         wxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h6ADNPx6/wgXmYvfgOYYpd1gqwiAfx7EhuC0hqulNXw=;
        b=dkc1Kx0VuulyOdIQXfWd6ubSanWqXoV6fQyEo0pdBjd4+63uINz4+/2ITdiXIMZBBi
         Y/I9oz1Tcgq6K8jUSGgH1FDuL6OxQl5F2g3c30uFLHLkiqgObwo3w1Ne7eQSrmc9M+9m
         QwtR75fPQBCnwPrxs1Oj703O/DeDte9nYDybYaFK77m1j2QtSrbMLeXbaS2r3+VgGeut
         cIyhFWgNGfHh+AwHB+O+umR3cI2ZfsPF7my2kdWx0lj86Oy4mw0CS9aUTAK7U+9L30Yv
         JBmzkK+lllvo14/+q3qixXb/kxXWrWlRT99P561ufMkB0uIWmOdumEZfRDbkFbDZtqHc
         DHjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 12/56] sget(): handle failures of register_shrinker()
Date: Fri,  2 Mar 2018 09:50:58 +0100
Message-Id: <20180302084450.241048687@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815419622660679?=
X-GMAIL-MSGID: =?utf-8?q?1593815629173071986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>


[ Upstream commit 9ee332d99e4d5a97548943b81c54668450ce641b ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/super.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/super.c
+++ b/fs/super.c
@@ -519,7 +519,11 @@ retry:
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
-	register_shrinker(&s->s_shrink);
+	err = register_shrinker(&s->s_shrink);
+	if (err) {
+		deactivate_locked_super(s);
+		s = ERR_PTR(err);
+	}
 	return s;
 }
 
