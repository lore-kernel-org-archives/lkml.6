Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Li63y4PVEGRyxS8XfJDRFEDdozLn9Kd8QlhI+iBtAkjlA/QSvgG6WP8zi/Sn9JoyPjvyj
ARC-Seal: i=1; a=rsa-sha256; t=1524406297; cv=none;
        d=google.com; s=arc-20160816;
        b=TqF2N2PcYCgQ9LM92+BfSOEDIA5FONma5kINHJwc6p87QLvKvA1ZJbOHvHpUFllvCi
         2lysLSwi6Fw97R4IRfxKjaAB28D/IkzxuUx381lZx8lZrWaB21KNPvtMVugN+WKx+2ne
         qUNghFWBV6uN2Wl5qkfLoDHGBsw3LlrNry69ezOJX722QHJW/9t8u0k78/rmn+EYO9C0
         jccALKLs2n6/hMX2TnH0K3V2QzuoUiwwUTOAMuMJFnsceFOREaMzHp6MYEJkhqMj6F4S
         3x8VfnjUwy6BwFkdTxjWaytQJqY0jHmTzSIjNUglLiq7AwJ0BceTeZYc0zXSuF/ekwZM
         vjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ga5nb4czOgGcogKvQxNDmoRaY5uqUCJLEmf4u4b/x0I=;
        b=n0VQbftBIFXfcRXNwK/s05kafprydkRse5JvtyHxgPWTWnZCDN806CbnJfU0lAY1dr
         SQc47m4oKw4t2ZqIaaw4htSPdZVkxielD5wejy+gcOVXy5gQwrGKPNAFT7qEN8epgTdi
         5XzfaxlIFJZ98gXvstXgZEOAt+MgYCRUD5N0EoYitsi4GKO1QRDFrgJDkyiyMNwu9r3c
         +9fxPpSqSL0HOBSZH7JosmMVbwQaiyUBLv7Mzzg7Mdc4n8nrH2Cj4T89M5N788i+Qrah
         T8E5e+t3Ss13i6z2hAo1No5sql3QIPkEBFHli0VHjQz3mSfJB1OM9rRffMsD9EkR8cqw
         JUQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.9 02/95] ubifs: Check ubifs_wbuf_sync() return code
Date: Sun, 22 Apr 2018 15:52:31 +0200
Message-Id: <20180422135210.535012308@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454799330179437?=
X-GMAIL-MSGID: =?utf-8?q?1598455858217402571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1728,8 +1728,11 @@ static void ubifs_remount_ro(struct ubif
 
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
@@ -1795,8 +1798,11 @@ static void ubifs_put_super(struct super
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
