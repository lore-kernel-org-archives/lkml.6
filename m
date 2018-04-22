Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49eq2YizfFG6qXMhBNbZae9rRYzpFh1JW+fzDr47E4/uPCWd3aL5PK6xeyC1bdUYvdrKz77
ARC-Seal: i=1; a=rsa-sha256; t=1524406840; cv=none;
        d=google.com; s=arc-20160816;
        b=xT+VqTveyT5K+0d8cRRKU+78VohGlL+rHSlprA4KGBuE0aycpfD9nW7gBd7wuDdCIt
         ruFwqvJBJyTd6CXoFmZN8csoVUoxKMWRRQ6auhgWiJDIdxG17vXnJW/JIWTHF8LCJF9B
         xoahzybli1a5sDyENHBxECdWU2JoyzA0kjXeFZ06HQOGfE0IEOT5nj7Ng5rnPwompB14
         KqYwEhBVVTwUxLF2WWveWF0/qgV4+x5nSlNWjhKRl+ieeXFRkZNJbaK8g5b4e3ASGG+G
         5FhQmUiPkXG3mtz7LHf0JqYf/CrKXosPGqvJ/Y0CN2uFJdAkCGV+FtAbSSg+2z3FISQq
         c/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D84Wsv/qOzKnbFRsGxD24AyxHxEmQe3042KSzU5/mrg=;
        b=PnaaXUynLTRBvjuJoaV+NW2wD7wzsZbL7cSc+LTXrGTnfEtkUcUK0W8WhwF9LZVdn4
         4GiDMx1ykRc2uthvlYAJmaDRrGvjAAIbs4vMBsc/fgrwvneEW99aGHYs4fJJWuNI0lDo
         l/EMjRIfQDvC61lCDbweb6TWbC73+S2NkxfptBdS20g/pk8ScLBUgJhABocmmh6KKAPU
         Y+gUjgjGO/d0quyBfiFX1JMv/rtdKJe8PHyi0EdaP/5RxlqX+Mic1WGrlF6hwhY+FTAV
         h/SPjcbrZcPwKBG4WVixTjgPhkSnQGufDYhNoXp2sY3uHISdo1m3Yq/6WyIu2aaiDzRX
         qjEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 3.18 07/52] ubifs: Check ubifs_wbuf_sync() return code
Date: Sun, 22 Apr 2018 15:53:40 +0200
Message-Id: <20180422135315.576107733@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454799330179437?=
X-GMAIL-MSGID: =?utf-8?q?1598456426503471552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit aac17948a7ce01fb60b9ee6cf902967a47b3ce26 upstream.

If ubifs_wbuf_sync() fails we must not write a master node with the
dirty marker cleared.
Otherwise it is possible that in case of an IO error while syncing we
mark the filesystem as clean and UBIFS refuses to recover upon next
mount.

Cc: <stable@vger.kernel.org>
Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ubifs/super.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1726,8 +1726,11 @@ static void ubifs_remount_ro(struct ubif
 
 	dbg_save_space_info(c);
 
-	for (i = 0; i < c->jhead_cnt; i++)
-		ubifs_wbuf_sync(&c->jheads[i].wbuf);
+	for (i = 0; i < c->jhead_cnt; i++) {
+		err = ubifs_wbuf_sync(&c->jheads[i].wbuf);
+		if (err)
+			ubifs_ro_mode(c, err);
+	}
 
 	c->mst_node->flags &= ~cpu_to_le32(UBIFS_MST_DIRTY);
 	c->mst_node->flags |= cpu_to_le32(UBIFS_MST_NO_ORPHS);
@@ -1794,8 +1797,11 @@ static void ubifs_put_super(struct super
 			int err;
 
 			/* Synchronize write-buffers */
-			for (i = 0; i < c->jhead_cnt; i++)
-				ubifs_wbuf_sync(&c->jheads[i].wbuf);
+			for (i = 0; i < c->jhead_cnt; i++) {
+				err = ubifs_wbuf_sync(&c->jheads[i].wbuf);
+				if (err)
+					ubifs_ro_mode(c, err);
+			}
 
 			/*
 			 * We are being cleanly unmounted which means the
