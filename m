Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4++0kWaVgzzWgSsi+SrUwCHH1/pJi0oFosd8QIBwMuirPBeOluh1tFTATM+ohlAhlTS3C+u
ARC-Seal: i=1; a=rsa-sha256; t=1524405586; cv=none;
        d=google.com; s=arc-20160816;
        b=i2G5ObtbKH8HVd2/gHKRxA5eqxgPkWZ53HmGHO4j/6m8iqMTDbOcoNSqzjtwh6D/la
         /XZ4pa1ELDxjeS5onaAVlfcnnX+ogAO6Bait4vdrrL7wpto8of/mkf9R9MM0RcSeGdBx
         jiuOJZkJ64Y+8JoLCc7qpnTxUfUBmsr2zG+oRMHlZQigqwpVoExtMdFrAJyr+IG6BMAy
         zIvjtu9zO3Ap+X7VS5DP9KsbZeZDM/CogPTNyKekRgJJZDf6VtD1LLaOZF9+ygpklpnO
         oooL7JSw44P7d70AuD3tIvrQGO1tkFDUEe3ZaWwRrSaqT1CtLosfX21Y2onMNjYY9wrX
         /a0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OgLnToqJiVTVqIU7BtDmWY7Gs5W+Gs9vJDS5E8PdEzE=;
        b=BxLiVNIFnIE+GB4Pn/jjsHrs8THXmNxHuc39gcJveVBKBkbgVX7KfqvUdEi8Lfh3D3
         09UgeatkXJbUvSFNiW4FLFKghFAFioXuE7z7A3BydjniXgXHocD3tyY5KHF0IOzuAKhB
         F5C5wdqtZBcy5o2dsVYT5Lzf6aj6xv7KroU7wq/GjkrD3c6BgTVb3a1Zjr09Uf8jvPKe
         O0onB3MEmYFcDg+5kOMHjF2KR5NlF8ngpYcpaRWkMX53vl30DduxXNUjolv51oj/khv9
         hu9XSIC5bNzsaiZiY0rPMrNEkBK7OLBDPdBMz1mcdBnTUakh7e5foUi9CRTgA+QB0f2X
         0W7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 087/196] ext4: pass -ESHUTDOWN code to jbd2 layer
Date: Sun, 22 Apr 2018 15:51:47 +0200
Message-Id: <20180422135108.795592768@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455112345101489?=
X-GMAIL-MSGID: =?utf-8?q?1598455112345101489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit fb7c02445c497943e7296cd3deee04422b63acb8 upstream.

Previously the jbd2 layer assumed that a file system check would be
required after a journal abort.  In the case of the deliberate file
system shutdown, this should not be necessary.  Allow the jbd2 layer
to distinguish between these two cases by using the ESHUTDOWN errno.

Also add proper locking to __journal_abort_soft().

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ioctl.c   |    4 ++--
 fs/jbd2/journal.c |   25 +++++++++++++++++++------
 2 files changed, 21 insertions(+), 8 deletions(-)

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -492,13 +492,13 @@ static int ext4_shutdown(struct super_bl
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
 		if (sbi->s_journal && !is_journal_aborted(sbi->s_journal)) {
 			(void) ext4_force_commit(sb);
-			jbd2_journal_abort(sbi->s_journal, 0);
+			jbd2_journal_abort(sbi->s_journal, -ESHUTDOWN);
 		}
 		break;
 	case EXT4_GOING_FLAGS_NOLOGFLUSH:
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
 		if (sbi->s_journal && !is_journal_aborted(sbi->s_journal))
-			jbd2_journal_abort(sbi->s_journal, 0);
+			jbd2_journal_abort(sbi->s_journal, -ESHUTDOWN);
 		break;
 	default:
 		return -EINVAL;
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1486,12 +1486,15 @@ static void jbd2_mark_journal_empty(jour
 void jbd2_journal_update_sb_errno(journal_t *journal)
 {
 	journal_superblock_t *sb = journal->j_superblock;
+	int errcode;
 
 	read_lock(&journal->j_state_lock);
-	jbd_debug(1, "JBD2: updating superblock error (errno %d)\n",
-		  journal->j_errno);
-	sb->s_errno    = cpu_to_be32(journal->j_errno);
+	errcode = journal->j_errno;
 	read_unlock(&journal->j_state_lock);
+	if (errcode == -ESHUTDOWN)
+		errcode = 0;
+	jbd_debug(1, "JBD2: updating superblock error (errno %d)\n", errcode);
+	sb->s_errno    = cpu_to_be32(errcode);
 
 	jbd2_write_superblock(journal, REQ_SYNC | REQ_FUA);
 }
@@ -2108,12 +2111,22 @@ void __jbd2_journal_abort_hard(journal_t
  * but don't do any other IO. */
 static void __journal_abort_soft (journal_t *journal, int errno)
 {
-	if (journal->j_flags & JBD2_ABORT)
-		return;
+	int old_errno;
 
-	if (!journal->j_errno)
+	write_lock(&journal->j_state_lock);
+	old_errno = journal->j_errno;
+	if (!journal->j_errno || errno == -ESHUTDOWN)
 		journal->j_errno = errno;
 
+	if (journal->j_flags & JBD2_ABORT) {
+		write_unlock(&journal->j_state_lock);
+		if (!old_errno && old_errno != -ESHUTDOWN &&
+		    errno == -ESHUTDOWN)
+			jbd2_journal_update_sb_errno(journal);
+		return;
+	}
+	write_unlock(&journal->j_state_lock);
+
 	__jbd2_journal_abort_hard(journal);
 
 	if (errno) {
