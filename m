Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsQtZgDKuEFjW8tfqUtjcsW72yTvx9bspwlfX1sT0cR0eLoMEg6/cgkEf37w9z4Lc+hdHT5
ARC-Seal: i=1; a=rsa-sha256; t=1519981186; cv=none;
        d=google.com; s=arc-20160816;
        b=kAL6vwRV0jPl5O5CXpcbIfUhwxHuthsA+hMgfQzhXVHjQvY5NaVZ9WjNXnKvJ9eXSw
         b5PQVdp7MrOIPEtex1EoKXwa+6LTcV+MJXsP0K22yQRgok4h8LCE81aGXpbkN1BX6JQh
         8GRJSirc1bYMKTKZ4eh46iHFez2dusXyS2vRgNbp8FVlOf52rLVOQmCXzN+imOPWHepP
         5qj1mh6b2HOo0bdlj8yEkFGVCcN/eKZrfrgsodqe8YbCGWW3YhleVaXeaxtMJuRIZG+x
         gMJphjP14awLiIQGEuPmdX16urJRJvF91yZcnRe04kc7kL4yQrmL4zeTx0uWzMz7Ic0Q
         4UCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tJnECDdI1wtjPRzmgYa5+z2a2CEwzZO6duFoWP1xIGw=;
        b=MpgMiCKG1qa91+GfWNdxMEmcbfAb/MRYsqIArx9uaRcPoMCDtC6M3Ku7ueEhqIVIb1
         T4KIe2+ayghcaI4iUgXmloodIkYyI7rTfplE0cADuOOyDJO9oOa8hzxmgqelfAIqwsT1
         pq0YYsIMGsmWaxJjbaWAojYuYRHqJfv5KmTZaTBfTCG2sx73h8h/pEEljEqsubA3nMww
         Vlxlox2E0uci2P8GhDEwrjbZq/29kvoy1ojELvTpSeYqqRUhza3HuiH5u9BhXwA1CkCb
         q5B0nqAOLAAyQre9mAGCxsMzHivwdcQT4xrAazKoO+k6WlATeBfFnfPwe1NkJ5l38wot
         4o3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 019/115] sget(): handle failures of register_shrinker()
Date: Fri,  2 Mar 2018 09:50:22 +0100
Message-Id: <20180302084504.647859947@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815419622660679?=
X-GMAIL-MSGID: =?utf-8?q?1593815793147133829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>


[ Upstream commit 9ee332d99e4d5a97548943b81c54668450ce641b ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/super.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/super.c
+++ b/fs/super.c
@@ -522,7 +522,11 @@ retry:
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
 
