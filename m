Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpbSII0IP2JJg3wl8HLCOi61jwgVdTcxYaGmdlBI3bwV0/TOD2vVjLf0KpU6uzuvFI9p7Ub
ARC-Seal: i=1; a=rsa-sha256; t=1527156169; cv=none;
        d=google.com; s=arc-20160816;
        b=mrB5UctJb3DrfUbx4NP7oKpM5cpJYeOEJhwGSXq4D70GIYZTOJNp9BXHb6lcyGVGjK
         c1hed6hmDymPsk+bS0TawNOOhDVKST79JvDXLBR4o7LuyUUhbLZtMmWhy3mL/0mEwD5y
         K/UTgipvhH4l51VlBdNhhB6Kmx118yDMCM9Jxbhi7H8LYRL+QvAAG9ojKwbbUdh14HKM
         SQzIuKL0CeFnYxIgI7sa5KCBhrytQXHNeCt4ZCf+HYbVOAJ2TuOP6F8gp353lUqenY6f
         t9E7bfAEXu7/NiF9eebzNPM/RJKMfSeWX/+QDNHdVJtLhgY8rzTyss7AwpFtVa6YLDbK
         9FDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=carjZJkaWhlEN5gkxTkpJJ/CvIYqNQGP1cRFXeg/Foo=;
        b=Geu2/dkHzeVqb9AacCW+DR5XtyNcZ+LlcdjkzWfFBn0jYzXa3XAN4fFmeE5cSqr410
         beXXHaqn33yEnwcaTLzwP82daPoxI7eVCERy2jU+WQ3qwAVBqTQmz3IF1aQ6lzy18J94
         nXsKWlILelHDK/lPnWX0ty2GLOTNm8twkD/V/whoVJl0tITLE3YHn1FMP3C+Li77LuW4
         Gk5O4hnQAmqg2sM+QlJrLXzuBH/TWysbQkLI7IIKlFcpP4fjay4BvfL4xNqmg2SETVnz
         f1ppKLvdfzUtiAhJasY2v3awchctIlllubQ195wqmxenZUnAQ0sKli8lszmtMWVtHDCM
         ba1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZweO5Ou8;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZweO5Ou8;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+4f2e5f086147d543ab03@syzkaller.appspotmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	David Howells <dhowells@redhat.com>,
	"Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>,
	Vyacheslav Dubeyko <slava@dubeyko.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 088/161] hfsplus: stop workqueue when fill_super() failed
Date: Thu, 24 May 2018 11:38:33 +0200
Message-Id: <20180524093028.992571455@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338024196822374?=
X-GMAIL-MSGID: =?utf-8?q?1601339306973202630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 66072c29328717072fd84aaff3e070e3f008ba77 upstream.

syzbot is reporting ODEBUG messages at hfsplus_fill_super() [1].  This
is because hfsplus_fill_super() forgot to call cancel_delayed_work_sync().

As far as I can see, it is hfsplus_mark_mdb_dirty() from
hfsplus_new_inode() in hfsplus_fill_super() that calls
queue_delayed_work().  Therefore, I assume that hfsplus_new_inode() does
not fail if queue_delayed_work() was called, and the out_put_hidden_dir
label is the appropriate location to call cancel_delayed_work_sync().

[1] https://syzkaller.appspot.com/bug?id=a66f45e96fdbeb76b796bf46eb25ea878c42a6c9

Link: http://lkml.kernel.org/r/964a8b27-cd69-357c-fe78-76b066056201@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+4f2e5f086147d543ab03@syzkaller.appspotmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Cc: Ernesto A. Fernandez <ernesto.mnd.fernandez@gmail.com>
Cc: Vyacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/hfsplus/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -588,6 +588,7 @@ static int hfsplus_fill_super(struct sup
 	return 0;
 
 out_put_hidden_dir:
+	cancel_delayed_work_sync(&sbi->sync_work);
 	iput(sbi->hidden_dir);
 out_put_root:
 	dput(sb->s_root);
