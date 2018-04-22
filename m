Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/IlTCVXgT6MCzHmXNxMlAX1XwIahISGDCsSLa+dVHo03/Vix0LJh7X1NcXryQEqhB19UPa
ARC-Seal: i=1; a=rsa-sha256; t=1524406091; cv=none;
        d=google.com; s=arc-20160816;
        b=wWtUT415RaHWskH80UFLmNelEuhCnVKnkYLGcZKqriOBAIhYX4roGvUGyjM/qbAX2J
         XbYd3A2WxLwcze6e86AufeMWhFcoRzzuNRt6FInKE3Eg1Iwl8oHi971IkKXqBxFyMo17
         M18h1at0MVeLdj6S4PRqfEJkx/YunF4DToVDS9/I2DiarXcby3S9ri3ayM0fz33lhT1r
         qaNwYN1tzs3htOSlXTaqbdMJFRu7qrT3YVnLSzmer2hbNXgDu/LYXGfiU2J/saURn0kL
         Tm8xfuu6qBJW1xrxprfELQ/An+5LWUJs9Urs7YDVs1WIa14p5KxRMwhguc6KBLh02sZQ
         ByNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=omgeQW4wODL9XGh2uKmx6ROrin7HhXNO2P5m8lnctTc=;
        b=hiUFIey/dKRTMnZS+sUWuROND0JZ66ZT2VLoyyEH2NqIOZsfTE6BF36x82gkgiTTfN
         GOcfNdR7lGjU8aZvFDQvZH78pXcGtTLl8VJRTB8O32MC0jJ93zjscdWCpP8TRl2gcHvJ
         yf2hGFcroMeIpYbvKys4fmwCsAiwqf0cEE8YgffIu42h1jSAqVQtKyGzbaqf7xXDfVhv
         CQYiV18XFTMNga1SNUFnwHDHGPX+rSu1E9ThHBpVKCqo3momzNJhR3SG1Hs7WbD5W8yT
         0Q1Rtgr//1wZ0zcrdKsUltkDUFe9IynSG24rxhwNWNKt/chug8iuoYZX1rE5xDkLcQHQ
         Yy+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 074/164] ext4: pass -ESHUTDOWN code to jbd2 layer
Date: Sun, 22 Apr 2018 15:52:21 +0200
Message-Id: <20180422135138.488586539@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455112345101489?=
X-GMAIL-MSGID: =?utf-8?q?1598455642036319900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -493,13 +493,13 @@ static int ext4_shutdown(struct super_bl
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
@@ -1473,12 +1473,15 @@ static void jbd2_mark_journal_empty(jour
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
@@ -2095,12 +2098,22 @@ void __jbd2_journal_abort_hard(journal_t
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
