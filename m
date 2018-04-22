Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Gf73MMNfdbSKbxTI6Ll/ZJsVMSppjukhLp94KjF71pWBTRARtUuDbZ5UxNi/1PscQ8Z0W
ARC-Seal: i=1; a=rsa-sha256; t=1524405386; cv=none;
        d=google.com; s=arc-20160816;
        b=x0RUavPAEbIYBSW5oHjUPLF+JfAgZ/v6FHK1ijjXmd7P6dkas+2W2i1YwSuw59mBKY
         aCQrAPhDiG2LFctzAmzyGRluTL0hzqjxZs4ZMTrDk/2Z6KUSP9d3j/EuyuJDwd8w517c
         FSMqZYV0mX1bPS6b4u6sxgvyob7W10Q4lN6VVoXN/oqasDFiGwnKYcrsUyIXKhLJ6Qdu
         2SEXvFCOx+eX/q1VTc6Duq4Bo/G7kJdl2zmQJZEjP0IXnjXRoMHu2bb9+nEQd8POHXqb
         kSWaIlyUiO/H/bOO8JEqw6+RbovMbFYMaiVcON9K5jS4LihGqmip47rjUd8uRmikigl5
         d3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dS9dRL7gVXyGge9BcvnKf0Dfg/+/qxbtvD2OQou6NX0=;
        b=SBab8Ptw6f7EiZtSTwjaFFjBv6YmbxGJTs1wNg4EPsrLN9Ndi69sHZ0CMOgA0RQK3E
         hXwZmDZIaJloz4x70KIoPNesB8iOhrc+t9UaKN86dzM5nv7frP4pjC9rrizQHo/nSvTk
         CM3DVYEpD00qHZ2jIRRYqEoLDg+0P4i1XcwEd/gFidJGafGAJ5IYxvO4qtdAu02tHsY4
         5wj1pNf6m/ZAtSevCvjPSvaflRM662R2BRWzGyMZsgxSW6mvkyFUPNyHAL+fFcBkAZOJ
         SnKh9ehyMofYLyUba6ZgBu8ZBOHH+zi8c4SnB3TF6+QuyIzw77JWk9r2J5toEX/vKFzt
         BflQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com,
	Jeff Mahoney <jeffm@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 013/196] fs/reiserfs/journal.c: add missing resierfs_warning() arg
Date: Sun, 22 Apr 2018 15:50:33 +0200
Message-Id: <20180422135104.846884906@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454902575626953?=
X-GMAIL-MSGID: =?utf-8?q?1598454902575626953?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Morton <akpm@linux-foundation.org>

commit 9ad553abe66f8be3f4755e9fa0a6ba137ce76341 upstream.

One use of the reiserfs_warning() macro in journal_init_dev() is missing
a parameter, causing the following warning:

  REISERFS warning (device loop0): journal_init_dev: Cannot open '%s': %i journal_init_dev:

This also causes a WARN_ONCE() warning in the vsprintf code, and then a
panic if panic_on_warn is set.

  Please remove unsupported %/ in format string
  WARNING: CPU: 1 PID: 4480 at lib/vsprintf.c:2138 format_decode+0x77f/0x830 lib/vsprintf.c:2138
  Kernel panic - not syncing: panic_on_warn set ...

Just add another string argument to the macro invocation.

Addresses https://syzkaller.appspot.com/bug?id=0627d4551fdc39bf1ef5d82cd9eef587047f7718

Link: http://lkml.kernel.org/r/d678ebe1-6f54-8090-df4c-b9affad62293@infradead.org
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: <syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Jeff Mahoney <jeffm@suse.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/reiserfs/journal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2643,7 +2643,7 @@ static int journal_init_dev(struct super
 	if (IS_ERR(journal->j_dev_bd)) {
 		result = PTR_ERR(journal->j_dev_bd);
 		journal->j_dev_bd = NULL;
-		reiserfs_warning(super,
+		reiserfs_warning(super, "sh-457",
 				 "journal_init_dev: Cannot open '%s': %i",
 				 jdev_name, result);
 		return result;
