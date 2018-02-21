Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225DExwyXbjypbpBUed/Yo3i63Dqr+YfzgbZK3eaFlrpTFR/nAzmQgc2DHAYZ1rby6kcqOQ6
ARC-Seal: i=1; a=rsa-sha256; t=1519218652; cv=none;
        d=google.com; s=arc-20160816;
        b=bFiHq+grcigYFZtObqD04vJ/A+ZuFu1bsl47QbN8M7i/bjm00NgIa3s30Pxr/EkeqC
         vcYNQYVoanDkghhzLG3pyn7eEcu6fid9lLK5sA5m/ElIy2KmDyMTOtpHl7cUAKDQWqrM
         aqtLLqCgyNNmiXJnBwoS+vqK2uCg+vyqlB9ALg2FO3PZTobT8U6i+EOL7LHVt9vnOJFE
         sQgZorw+1ufVNAAkh1VO+LCygWZp61bkqguzAT9AHRtn1Xw0YcUy0F9QlEnr0BiYeclt
         eX4hTis00fM2F0eT+cU96Hq2YYZV5B+uX16m09GY3WcczsrM77yUZq69IAfBEIzFeo/t
         WiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pkSTOv4v5dvgDcqaROUmtPX69ZlYm9nDywCi40ZCp28=;
        b=QwtMMV3wQebb/4ziujIFD0Qr0rBPYZFkCtws+mkkcBDLYbuGAUabyEFCFnUC9WTpBl
         fIFIYZJmDieOGO1oluL02kluS7+UBkkfB/QT7jhbDs4UFYu953fGN0awbgHNFzUrrZlr
         Rnqg/fRrUN/9t85OlxcoRSjV/JqUNPXtSwJ8cXbm6JKyfZGHrIH0OHSDUyl0jj7F2oc6
         MeesEaLf/BvR346C7DlG98uyMkyRVvSfmkQyWInG/cFRTj6pu1eGtUoHyfkpUIAOBLtr
         eX807H/dE4fCsm2FOU+TATwYNVK4/dTlAI2wh5aQF5XSiJGYXxGqYs+/M8o0wugCYGte
         lE9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Harshad Shirwadkar <harshads@google.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.15 107/163] ext4: fix a race in the ext4 shutdown path
Date: Wed, 21 Feb 2018 13:48:56 +0100
Message-Id: <20180221124536.148656418@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015222152228057?=
X-GMAIL-MSGID: =?utf-8?q?1593016218300777939?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harshad Shirwadkar <harshads@google.com>

commit abbc3f9395c76d554a9ed27d4b1ebfb5d9b0e4ca upstream.

This patch fixes a race between the shutdown path and bio completion
handling. In the ext4 direct io path with async io, after submitting a
bio to the block layer, if journal starting fails,
ext4_direct_IO_write() would bail out pretending that the IO
failed. The caller would have had no way of knowing whether or not the
IO was successfully submitted. So instead, we return -EIOCBQUEUED in
this case. Now, the caller knows that the IO was submitted.  The bio
completion handler takes care of the error.

Tested: Ran the shutdown xfstest test 461 in loop for over 2 hours across
4 machines resulting in over 400 runs. Verified that the race didn't
occur. Usually the race was seen in about 20-30 iterations.

Signed-off-by: Harshad Shirwadkar <harshads@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3767,10 +3767,18 @@ static ssize_t ext4_direct_IO_write(stru
 		/* Credits for sb + inode write */
 		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 		if (IS_ERR(handle)) {
-			/* This is really bad luck. We've written the data
-			 * but cannot extend i_size. Bail out and pretend
-			 * the write failed... */
-			ret = PTR_ERR(handle);
+			/*
+			 * We wrote the data but cannot extend
+			 * i_size. Bail out. In async io case, we do
+			 * not return error here because we have
+			 * already submmitted the corresponding
+			 * bio. Returning error here makes the caller
+			 * think that this IO is done and failed
+			 * resulting in race with bio's completion
+			 * handler.
+			 */
+			if (!ret)
+				ret = PTR_ERR(handle);
 			if (inode->i_nlink)
 				ext4_orphan_del(NULL, inode);
 
