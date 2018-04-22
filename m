Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48OLdvPOKee0Z3EqsKCeMdZaQYhGFu1+WDB3qC89RWNaR3yUTxGz8Sl6C/houZxPW/dNLQB
ARC-Seal: i=1; a=rsa-sha256; t=1524406083; cv=none;
        d=google.com; s=arc-20160816;
        b=1FLKO4NQUsRtTyfAKBVSoInoy1QYNQvAND/+CxhUzP992NkECSY6SfGNd5bUSW4S8Z
         WJtjPWFukiHDZZASn92HsR4bSh7f5kh/LPgJm5Hd+JYlMfpQsPC+WcufYHojV+MNdl8b
         HixaT7W2gx7G3sOWPUvaFgBo8CHg6K5NkNy6pblBVW2DA3eJCwt+12ub3735inERuEoe
         K6dcWHFTBWcG51Yi8n9qgP0Yu67esf04avGkPFEC3k+6oLF7l4mNQTrmEK1506FrrpId
         qyg/L79KSePhXdE3gVdbo1qn+ku7UyOj37T6k5vdSgWQnYr9Cqnw2d3Uhg59tWReXa52
         19ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vIoYKdZCP0sNzuAzcklGfEST9GZojgJLJoZZqQs+KgU=;
        b=xNsnwsMIuJ1m1cPRqLB8Wui5et7yq5+gF67qi6t14tA3eKcP2kxKeari0pDjtKj/6A
         a1jNA2/YJ0IHadbR8qkNLoasumdNNcL6e9sqwkoX4hDjnCR6+9WHAED5Up0qKW2dBN03
         1nrHDnOPcxfu5mtwPw87FdXOvigHGAkyFobSXRi0UO/nHaNaVdB2NHmmBXm79VGovshg
         FZvFkWJPcTSAqXefT1i6wlgUmOSILdxBkyJekORzL4yT9p9QdxHLGNSpu13Mc5Ik0Db9
         st1N7k/7YXVGVYY60DPqAqJtuvn/JDCqjo2KGy1wtwT6Xct1YoUkD4sHARW5ZuzMa3uf
         40wg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 071/164] jbd2: if the journal is aborted then dont allow update of the log tail
Date: Sun, 22 Apr 2018 15:52:18 +0200
Message-Id: <20180422135138.366488372@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455083413047816?=
X-GMAIL-MSGID: =?utf-8?q?1598455632976372517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -961,7 +961,7 @@ out:
 }
 
 /*
- * This is a variaon of __jbd2_update_log_tail which checks for validity of
+ * This is a variation of __jbd2_update_log_tail which checks for validity of
  * provided log tail and locks j_checkpoint_mutex. So it is safe against races
  * with other threads updating log tail.
  */
@@ -1404,6 +1404,9 @@ int jbd2_journal_update_sb_log_tail(jour
 	journal_superblock_t *sb = journal->j_superblock;
 	int ret;
 
+	if (is_journal_aborted(journal))
+		return -EIO;
+
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
 	jbd_debug(1, "JBD2: updating superblock (start %lu, seq %u)\n",
 		  tail_block, tail_tid);
