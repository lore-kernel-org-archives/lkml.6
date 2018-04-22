Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/1klEu80ikxMk3EqdD51JRYp03eHaBjI0Wv/NaKNP9JgdP3QT/ekw+E4MsoyP2hG60W/dK
ARC-Seal: i=1; a=rsa-sha256; t=1524405876; cv=none;
        d=google.com; s=arc-20160816;
        b=FFNPplXrWiK4MY9nOn2LKTHATA6fCczNvDi61pCt3glhFPzJK+bENDvc2R5ux4qfgI
         li6rop2AvjeCIZT3JFCyTFJGjWd1wPFY0A/Q+Icy1/eFCRSL8RJt//puT2hVSBP+Bwqn
         Ow0yM0PlENVzpgi4zN/HNc1bQgh7DNebRSqawU5p6d+ekQZ37pK/7uo9wmWKwQ5wVXj/
         ug+7dh8e8UZpLW026qamAI7kCJf5qn5oJWojijWb5H+NcWpMwi5/WJCWWLJhe2Cc+7ru
         UVAoGYYGJyAiCNvafm+rqKT4sXZvPwZpZ0+eOz0womYaCmtugyBLBCfMSoZ9Cv5dVs6+
         iIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u0AfD9J4u9FWVGJZeGgp6OQ2Joq77wh6cRqa8AgliyQ=;
        b=yqgW46mLRbXJKC8/bDQ5Hr/5jrFXTjriHKk7rgPi4A5IPna+pB2qW3NaqtKEgip+Zv
         3bw8JKlCoHtRad3H+PEKSHsMZtjmPCcjKsyITOntUPBOUbCQzvLJVvEXhZk2XmWiDJMZ
         hrBEQq6x6N15zo6Z/Bz8a8jI78fms2fQVyrKhzggQ8O+VFnNaMC9PuMd8YJyia3JgIRM
         GvZB2vCvW0LNt6UKGSEmtTJub8hxoRHVNZh+D48iJpN6QuQ79maNy1rQkKswA2pUIo34
         HA/IRoICfAMfkTslP6MYt/OG1i9peU7oPOwsSQ8zRfhANtcrGM8rVLPkJO71XL9lQw56
         qvkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.14 003/164] ubifs: Check ubifs_wbuf_sync() return code
Date: Sun, 22 Apr 2018 15:51:10 +0200
Message-Id: <20180422135135.546914165@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454799330179437?=
X-GMAIL-MSGID: =?utf-8?q?1598455415607675390?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1739,8 +1739,11 @@ static void ubifs_remount_ro(struct ubif
 
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
@@ -1806,8 +1809,11 @@ static void ubifs_put_super(struct super
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
