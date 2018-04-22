Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48HLDu3C7i5+ltkNxYsxJ7vmud49oIvOl8ZvxW8fDQb4nXUeqJ8kuRrip6QsrOz+ji+dmCK
ARC-Seal: i=1; a=rsa-sha256; t=1524405580; cv=none;
        d=google.com; s=arc-20160816;
        b=Q6Z4HAYKHF44GjiMQWxDFjUAZhnZbPQK15TVSClu+1JLzuWrJMixG0Prcpe3DZ9Yeb
         j0cQO97O4ppsrIqtUFit4Ng446I6lhctpRup6oCVcfmpjVA328DKqghLeYD8bVqVBnMU
         zPwlYpfN/UGspKeRAuPUsqNLouyVizkYLTErcVQ/IXsbaFzSa2noJ3iCz/kPRxfFPhHu
         NYXYHTxLlO1GQbCFo5sXJRwOTl/bqNWwQSjsudDTNQYejV6jd3N9ufj2e59Uj7OZ332k
         WqDG5Oe8nKzOY9ILHOkFuDUeyW52sP/uuJMKp9Jnj/jGO1B5WEmvErPgotl7B0PVvtOC
         XiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bAYEbdYHNYkitnewWG8HRRVOktfikV8ahWqqku6kpaQ=;
        b=OTtCBwKDO/X43Vx0FHkADmb5Hu4U4Hm/rryk1VorJXbqNT60V3HmB9r99Gkcq9fo1h
         W3tz2ynnNW1W31WXCpHj+csWbaKHp4olkthUyuGVa5KJQWeWKmHw+7FB5Pu1KYL43VYR
         MjjGuWRH1fGh6iwpTABL7gaJwRp2AKHn+KJARvb2HAf/kctw04tLawxd765mDpuMldjb
         U/bkuUSVAL/gqBbyydRiWm2r49ri7Q8QoScFPVVeVWwqObvPe+XQ2DwPL+YEu5q2NCyj
         rfF/YcVB1iHJ1WZaATuXJFxoGGnXP4UPFf1fRYOHxR179X5xUftm0GjNHjko9zf8vMbC
         fj7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 085/196] ext4: shutdown should not prevent get_write_access
Date: Sun, 22 Apr 2018 15:51:45 +0200
Message-Id: <20180422135108.697946198@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455105865825935?=
X-GMAIL-MSGID: =?utf-8?q?1598455105865825935?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 576d18ed60f5465110087c5e0eb1010de13e374d upstream.

The ext4 forced shutdown flag needs to prevent new handles from being
started, but it needs to allow existing handles to complete.  So the
forced shutdown flag should not force ext4_journal_get_write_access to
fail.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ext4_jbd2.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -166,13 +166,6 @@ int __ext4_journal_get_write_access(cons
 	might_sleep();
 
 	if (ext4_handle_valid(handle)) {
-		struct super_block *sb;
-
-		sb = handle->h_transaction->t_journal->j_private;
-		if (unlikely(ext4_forced_shutdown(EXT4_SB(sb)))) {
-			jbd2_journal_abort_handle(handle);
-			return -EIO;
-		}
 		err = jbd2_journal_get_write_access(handle, bh);
 		if (err)
 			ext4_journal_abort_handle(where, line, __func__, bh,
