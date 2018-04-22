Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49dUuAY+HKlOkUY0SHcmZLz8mEW9p1Y6w0jhUNXGOAtBI/nIKzOlasIYyfH5Izc7OFEDwO4
ARC-Seal: i=1; a=rsa-sha256; t=1524406930; cv=none;
        d=google.com; s=arc-20160816;
        b=v0ki7cwU66SCTAn3neVv8HaGxocBn3kmZFwfcgr6FX+dtAqOw5EGM2FCzBlOI59oV5
         aFe0Qh3eYzhR6NcwL9LmPaCkrnGwBhKgkdzBOct7u0zqIt54EYIfRj6SPZpoh0odUSu0
         ItLy554JgUmgJGTeOxtqiEx6qVw8vUUqZ7Rd5iG5blycxTCegkQfpzIaz1XEwJ3fYfz0
         Hqn9h0+gGCuxfK76An8PBz59Ah4YefU9uXUWH1XQ9+3WvRoDotza360T8mtLbKOSwMay
         3gVcB0b+hQ22wTR9kVhavGV7+GKMjENR5Cu4wx+QCKpiMeu5Uo5WeKegawbPctaioaxN
         TbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nCuFeWJBF0laPcvG64yDeZKXytajFkatZ6ZjEiUnrW8=;
        b=mUjxsXl4//e36/aJikgJQ7XYPKEo3MErDekfqMtZIWVs7yiU30YkhCtA2/cD4J1YMK
         xWQMJYal2KR0I05QtFzN09IeQpX0RJlgJdzLcuHvo1GolWvbubGYjTpKvx3dom14x+Lk
         mBXQv+XxuR/KWP6PK+N+ho9ixVFQj3L96XhM8qSRm4C6hI5kj79irHw4+7ocmlHaKDqp
         0bnLaUoi9o4aEV5QOdm1ebZb09aRmE/9EyoqKWuBHgsRI5aGB9hL/ZTuLOdCJwiTe/ok
         61XQALcGfI3vanUrz3IfQg1aR8twZhwugPGbxgLXkpuZb8NIUkctSTGTLhGTfIe5z6w6
         Lfbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 3.18 25/52] jbd2: if the journal is aborted then dont allow update of the log tail
Date: Sun, 22 Apr 2018 15:53:58 +0200
Message-Id: <20180422135316.591595948@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455083413047816?=
X-GMAIL-MSGID: =?utf-8?q?1598456520972553604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 85e0c4e89c1b864e763c4e3bb15d0b6d501ad5d9 upstream.

This updates the jbd2 superblock unnecessarily, and on an abort we
shouldn't truncate the log.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jbd2/journal.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -923,7 +923,7 @@ out:
 }
 
 /*
- * This is a variaon of __jbd2_update_log_tail which checks for validity of
+ * This is a variation of __jbd2_update_log_tail which checks for validity of
  * provided log tail and locks j_checkpoint_mutex. So it is safe against races
  * with other threads updating log tail.
  */
@@ -1399,6 +1399,9 @@ int jbd2_journal_update_sb_log_tail(jour
 	journal_superblock_t *sb = journal->j_superblock;
 	int ret;
 
+	if (is_journal_aborted(journal))
+		return -EIO;
+
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
 	jbd_debug(1, "JBD2: updating superblock (start %lu, seq %u)\n",
 		  tail_block, tail_tid);
