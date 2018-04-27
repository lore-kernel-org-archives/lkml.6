Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpbu07vvgHBXy9+IZUJd/Vuz7xntGpovW02sKEVb3rBx0BKKZTkc0ewLpEBfacpFFRVMb+Z
ARC-Seal: i=1; a=rsa-sha256; t=1524837630; cv=none;
        d=google.com; s=arc-20160816;
        b=FNRZeYGFzgZgKFo6lDBhhoQO5T9WTLIdA7j2OlytD0MjKp1+ahuqwHnEhsYvN6Qu0X
         tNpkTqrvopckl2S0vEHKu3Yd+K3OX4Cg5URBoQjGhK2D3PP84quTffEDS2uSwOsJRFNn
         e9VkWqDah7oBVnU3EK26z34eoYXtS24GEYDlnG6aJDtDGTBHOtxX8/FBSrN7quds3L9Z
         CpVOa8yHaum9hXof25iX3s2YwCaezToYTIllPTrbvHNHOzhpY1FcTI5cCfJokXJF4oYZ
         SUuoOANxFvV9Y/dT8XbnSpV97CGg0BfwC5EaFYRDL0w8f24cyj+ZIXSTqz5hrtnPfJvl
         GTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=SHfZa0x6rPVzbNmIfdwqxK87gt7FarzSdCHyq/xVrQM=;
        b=OnsKW6YHDDMG+MRxqhV6Dr2XdM/doiDZhPYAHOzAcoG74/eMJ+1kjEoB7iAE0+I0pW
         eVvZBKtToPrc6n6yzn3u+U8w66Gabk7T7t1FNqesYl27u0EfLEWUsd0Hje+JNQ8tm0Q7
         CEJFPNtKHZmSQhuEYic65s982ghFQWfRj1MliPtDlGQQg4Jj5qdcb91sT+dXgIrxQLsK
         rQ4+DhxEqI+PoTJSkARZRSIIV3sAyM21rObBh0cOR8VYs/GDFYTOcytoKpQ3GqCdOECx
         lZUm+Fh2im30dp9qkHB6foMh68/6hWTeQJE3C3cMl8BwbKc4pmPhcuTlDTKesMjhM9H3
         pr2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4162189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sahitya Tummala <stummala@codeaurora.org>,
	Theodore Tso <tytso@mit.edu>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 3.18 08/24] jbd2: fix use after free in kjournald2()
Date: Fri, 27 Apr 2018 15:57:43 +0200
Message-Id: <20180427135631.927496107@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908143233351701?=
X-GMAIL-MSGID: =?utf-8?q?1598908143233351701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -275,11 +275,11 @@ loop:
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
 
