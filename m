Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqKYK2VLKy83cDiByY2dpN0LhPXTgQArmOfApOmohjusNCCqZvf2dibReQ5yGbCb7naS97S
ARC-Seal: i=1; a=rsa-sha256; t=1524837680; cv=none;
        d=google.com; s=arc-20160816;
        b=xZMxM7e1HBqFQU6VRN5hY2+Lc9oTZmmk3fjVy6ge6P1/RifrhNwWWn9EoYer+ZbkG5
         kBL36g3Pg7zE8/18o/RrSO7d503eAlNQAaEP7dgYXtJeXmQSBx1PJ2He3Y5+zCjpFZTR
         MdFnqZJpgPvAXWCPBBKn9pXVRFoJ4n+UsAK54xkNStv2EdcV9AuwIdWanAFKgnFRyAsd
         cvyKIqnkNpTaiwmiogtHJTpt2O2ACJScWFNtSs85zuXXLVqDHLFy2lTPQqwMTmOJf2xw
         LeOw9ufhz00YwlpBqnnhhpmZuaO2u+ciBqK0BdOsU7/sNtO1hDjGjvMigJDybRP7xOTY
         Sq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=JRW4E0IpULUTD6C0+La0K3rMFD7VD3iNgJcmDmZMRrY=;
        b=Wdf9VZwdiWyhHrRmIpIEbVtkBg6oGg3o+bVhWOGY3yIiD5AWniPj0eIQdI7ohhHL8D
         bR3waNzzMdZ2we1B10gzKKn8q4cRObGcI/H83TKWpVG/dUPppVRjDCS3U7d2YvAJmvgA
         CvIFK0OE23cJPAPMXFzih+NjRl/AqVRjrSUPBtrm1ckVwSvMqmpMN/+kQ81wLVQooH6f
         bhglEXU1Iu9U5PdMiYUk6VkjZBJxLdlum0GoypoZyLk/a4mY9VDlRtwjwveiLes+NveO
         h87HRRlbbE+HUaKNRRrm81r4Rrq97DpitO/YuJhBsrnMYwmgg7uU9UAp0C6HPO1lObMw
         kJXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BA1218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sahitya Tummala <stummala@codeaurora.org>,
	Theodore Tso <tytso@mit.edu>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 08/50] jbd2: fix use after free in kjournald2()
Date: Fri, 27 Apr 2018 15:58:10 +0200
Message-Id: <20180427135656.135152291@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908143233351701?=
X-GMAIL-MSGID: =?utf-8?q?1598908194867671652?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
