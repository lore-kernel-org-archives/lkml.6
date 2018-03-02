Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtRXApKXUp+6hp0QjI79Ulf6fSIapeJWiOKYoLHshYZrN9A+7sqWYAQE7/Ot5s1YIBe7FiG
ARC-Seal: i=1; a=rsa-sha256; t=1519980925; cv=none;
        d=google.com; s=arc-20160816;
        b=bnI+w0A4qGJ6J1hxPjuoo+ISS5JYj4zElgMVzFgFqbXYm0QYYKwrpP1iZdeHOxUUy1
         LVfJHftIzXcb0uT4YVLNl8qo7JSxTXXLNMF6VgSJo8D9eLZtflZ+AgnDNtMZAI58ffeI
         CnEDJS0bbf5vkXOhcGhlAjXXnTIufSdjw34hi1BQbAmiblTdofGB3KsoNKySC4ly26nV
         b7S6d/ywLLypmue1z9IfSnebRixDCtIsJuKQTie+Hspp6DMvef5HOKuSzKINwPHqA7RW
         sXB9xtPX9o1AtSbdef29COAjOILzdswf6ty6DuvzuFbe7V+OUfYsm5yWZt3cK+hsB6j6
         BOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/KUj+8pFowdtcdRq/FYjjQYXyHJvvg/Vwh3bntlV0jM=;
        b=SaFiCr72Xyj+eE2t/p9eQprSXSZSQ1kx4bWgeN4YDMA+nGYoweRlivy/zHV8GXxyMu
         wEZ2s4bettRgd9c/fV+tWvVWS+6K7xIxc+v1jkgYQRPoZj9rGs6ENRAZPVaALPNvDTjn
         A6U8b1UIPRdoQAEKOw6yHfRHiMfSEQh5Y3oWeAEmOs0yNRdD1o9VGCDrdLOMYL5RNCzW
         qRXvNxUGzGmz8Szsv7cKb0rWqdriUj7GZHvPGFHmHuUeLsaxA+m0gyLXrQhsQt3hwpWZ
         EndWwwTcR8a5bywnU0ueywzfdJf2WRu6a+Yg+6WDvo6CjMxZKhrt7xVryRqKaxYU8LPy
         /HjQ==
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
Subject: [PATCH 4.4 06/34] sget(): handle failures of register_shrinker()
Date: Fri,  2 Mar 2018 09:51:02 +0100
Message-Id: <20180302084436.414587775@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815419622660679?=
X-GMAIL-MSGID: =?utf-8?q?1593815519344385763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -497,7 +497,11 @@ retry:
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
 
