Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqRCfAs3AH/av70/8I0jTuvO/kwTWWsCPdba0rQpT582uzqtTm2KZaBt3jcndddrhHmBBSq
ARC-Seal: i=1; a=rsa-sha256; t=1524837879; cv=none;
        d=google.com; s=arc-20160816;
        b=rvzqZixLKsEfkKwNzhIQ4I7E3pQLji6/F4KFQtqOVS39NHYt9LdDGvjeTb46v8shJh
         6nWdKUIf0hhZgfIFlbkbPfE06/7TT6Zv1rs7PlNjgeOxmoAVb1A56my6xSR/aAEgaB9b
         u2EE9938oF6T9J+HnBkUFvi+QSafa9CSvDO87PKGxIYJbds8PMevgTdcHkL2h4akNaGu
         kJLMe1HHaKBwSKnoloe0tu4bYYwAbmJnLkJ0nJaCQYEtD7lhfyNZuffzhYt1aS3ZXVx8
         YhKOb71Tm+nWY0HBcAcuv8siribiaPgIatKtHPerhvjrLUduBMQ7SHBg2VI4yW5INkg7
         I9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=EEue0m76upYZ6907Fu+N4ScTwbuJBRln68CRF/jRY9g=;
        b=f+hrgiRDf2n2pWop5YA0qs9+CC+flI+w8sBIb32SvgfsHsQ9vhzpjkVaH2WAYdq6UL
         VceqO6lqFe0JdQjKLsyvfpgDpAMrBo06smjal7k/krWCj7ARUsGaOxfFLLojdBeZfqlI
         zwz4Sf6TzTLcYnZwl8RTkP1K74a1sKqgiTG5NG2eOJGaVHDp2w6N+2lNto1uG/WKh7w2
         m5qwNf8Q75XKcBhChmLoGS36cdjio0M9gzn4Abjio5C11X/Q11wKcDJzu8z6ku39mtsc
         M6rtLEA4Edy0P7kBYGrin9Qdlf2gqlQzJI1zF7xGhgCbiJlVX0rTRrO8Fsp5SKgcFFB8
         1F7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7081421890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sahitya Tummala <stummala@codeaurora.org>,
	Theodore Tso <tytso@mit.edu>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 17/74] jbd2: fix use after free in kjournald2()
Date: Fri, 27 Apr 2018 15:58:07 +0200
Message-Id: <20180427135710.616430102@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908143233351701?=
X-GMAIL-MSGID: =?utf-8?q?1598908404143544165?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sahitya Tummala <stummala@codeaurora.org>

commit dbfcef6b0f4012c57bc0b6e0e660d5ed12a5eaed upstream.

Below is the synchronization issue between unmount and kjournald2
contexts, which results into use after free issue in kjournald2().
Fix this issue by using journal->j_state_lock to synchronize the
wait_event() done in journal_kill_thread() and the wake_up() done
in kjournald2().

TASK 1:
umount cmd:
   |--jbd2_journal_destroy() {
       |--journal_kill_thread() {
            write_lock(&journal->j_state_lock);
	    journal->j_flags |= JBD2_UNMOUNT;
	    ...
	    write_unlock(&journal->j_state_lock);
	    wake_up(&journal->j_wait_commit);	   TASK 2 wakes up here:
	    					   kjournald2() {
						     ...
						     checks JBD2_UNMOUNT flag and calls goto end-loop;
						     ...
						     end_loop:
						       write_unlock(&journal->j_state_lock);
						       journal->j_task = NULL; --> If this thread gets
						       pre-empted here, then TASK 1 wait_event will
						       exit even before this thread is completely
						       done.
	    wait_event(journal->j_wait_done_commit, journal->j_task == NULL);
	    ...
	    write_lock(&journal->j_state_lock);
	    write_unlock(&journal->j_state_lock);
	  }
       |--kfree(journal);
     }
}
						       wake_up(&journal->j_wait_done_commit); --> this step
						       now results into use after free issue.
						   }

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jbd2/journal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -276,11 +276,11 @@ loop:
 	goto loop;
 
 end_loop:
-	write_unlock(&journal->j_state_lock);
 	del_timer_sync(&journal->j_commit_timer);
 	journal->j_task = NULL;
 	wake_up(&journal->j_wait_done_commit);
 	jbd_debug(1, "Journal thread exiting.\n");
+	write_unlock(&journal->j_state_lock);
 	return 0;
 }
 
