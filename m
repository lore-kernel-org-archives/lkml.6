Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48PhVtAFYajmI/9lFlTxdS9iatrS+qgsgPEWPeddI2kM2HXInULdYyIywChd9phWgIa/+Hs
ARC-Seal: i=1; a=rsa-sha256; t=1524406577; cv=none;
        d=google.com; s=arc-20160816;
        b=Le/B60jzujxbhW4ASejrtzzNW6qDH7joBKe1AcmFI6pvrswxnAQxOn1eNw8cXQgs78
         znbJ7mRS+s2ydQzl6iIBSuKBRpZjjaSRc8GnG5n8lVmr6NwxFcp/NLvEyd6SQFshgN5L
         nKmHssJpr+AzLRJ5HpnoP3EXxltDvVPXxK74v+PVnkI++BlbX1mcp3ogdiJQXDvuXncb
         3qZJVl9b1SL4e3u8JNfK4CePTsigkIUrBRU8AEaydUj0QZyhnGpI98Zyn6UyJVHxfR7j
         jYE7WAcDEEtLEJaOon8dU0dFFHq8BSmYcWfzCJlzVLnzVC4yBa7nzRsBqK0ni8bYrpll
         aBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UnHAu07qYem37YxfX0+1wCI/TknblgRnXFkmStIA/lc=;
        b=Coir10/A5Hid9zkZEzc7ahQeERx+FquJSRlgZvbglS3PBPz/5RF4rGnXDEsmvc+I8l
         PRpQMhEHnRkl3Aeb6iUtVXAj3PSW+z89rDo5Iyd902keoJHLRJZBdbKEW5u3t5HZmquR
         /fZHJmNIn/VFdsJV2KKmU/4jQ/p6XVOMY/o/MXk/XmmJvGyj3rwxKkYrdTlPA1zmO3NR
         OBHq5RkLdhTduY4ZG/Iax9t3ggO8WhMNPFlIyeYGouJVQIcITvxc+fny3vo8umIjI0XI
         8ZJ/5teImGHwhYd8EJJ5baKfWS2xqE21zrkSeaoAkcoVFbwibM4BI5K3IZjLGvSnhupf
         7Ibw==
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
Subject: [PATCH 4.4 26/97] fs/reiserfs/journal.c: add missing resierfs_warning() arg
Date: Sun, 22 Apr 2018 15:53:04 +0200
Message-Id: <20180422135306.500192204@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454902575626953?=
X-GMAIL-MSGID: =?utf-8?q?1598456150749704210?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
