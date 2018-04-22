Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/XIxzT1HcDxf3CiChuYAj+xl3FnzG+QCoCPewjs6A4zkwNcp5kTUXcg73T4e4ROLboRB2m
ARC-Seal: i=1; a=rsa-sha256; t=1524406800; cv=none;
        d=google.com; s=arc-20160816;
        b=wpbcG4nxiy4VTD+RH/2adirt8uFQFkyjhkLOxrCRVwvc0wl5yxPVTZn1B9oFFlrSTm
         lXaJco3Lq6/JA54cmPLjO65JEiDfW8vlfcZi+2PAx4LvA7p1OTAwJTWvu+90ljj+ep/w
         4Vdtzg48YCuGSdDUACV+MP/FdqTNq2KxC6/G1UBMc26W5RmvJ6uNBr2uA40mkIq47YqN
         IXJpZRocRGvgHaTjO+oTgdc5S/8nkTiT1BzNJKOOPmdLJX7XnpfCeyBQxOGOohbisiin
         Trr1dYcqJeS6xFi39qicbYDFIYK/fj5LAqe49azeaZRPKGrDKXRya23PBlK6vG3XdaWl
         mmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Wu/KWASBze8MMPXxSL4q919MlZL0R4g7klP9zZqTI+Y=;
        b=0x6PC9gHzm9yjoQkiPLH2C0sOtyRTErCSp6pyLekSPBpex53wRv8jwFkoMnakruYij
         H993deKH3G/ro5uAKHsGb8VvGvDRfyuDRKX0rHvGl6fUtG0FljXDtqM1o/JLpQy2gUUY
         bhneiFGn5wVwxqQpcvRP373ixEp8yMMD9L9HXH8FjY5rBGd4PdRbYRdH4iae2yBisjJ8
         clVKc3dQCNWdjAmFp7bO5w9LOQWA+0+zWjqv8oITyK81fEJsiPdmFh0Q4y0DPJHA2gVp
         Pt4CzIh0Rq5+sAdV8y5Zg9YrMzTfpL30ML/zOyCfc3w3LUG3h2KlNqNvSpC8nk2n52Ox
         syCQ==
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
Subject: [PATCH 3.18 10/52] fs/reiserfs/journal.c: add missing resierfs_warning() arg
Date: Sun, 22 Apr 2018 15:53:43 +0200
Message-Id: <20180422135315.725489913@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454902575626953?=
X-GMAIL-MSGID: =?utf-8?q?1598456385059390093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
