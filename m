Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+nFd9qOwDO1hxT2xnSORBCuN0RNzI/z1sLRd5xhlnuNMb33BCFshKSZBKImLIDHFtzViHb
ARC-Seal: i=1; a=rsa-sha256; t=1524406086; cv=none;
        d=google.com; s=arc-20160816;
        b=uYj2auGAiEQqM/TtR/6YsuldoJF/OQmiQUKHJd8N6RW7Kp/iO2vIqL7qSkskrepveF
         Ht7JKCvCP89r4ytYi/tMmLdRCRivBLTSB/Makt1x4ZcQumtmlZhC+DhMwOUWdU/qoS2c
         GPITCS3Phrp40MTA/w3By4Af1pagMm47xIV6VFEf2SseHspz5z9s04whyZaM3q24EmHb
         JPQx8l7rZO2gFpOcy4N9H4enJI3s8+lh1A0R2HIvNuGEmdKLL7VBtOGlh5D4mpJyk8oL
         /uSJck4InJFaiw7kLiSjE0lrgCQIKKuPEfIcFzT9oyxeAKLqXBftpnE3TCQga0Hm/M2P
         +e9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Plak0zsBM+mPAPVwnQ93MLp4SRdUNIJiHVLJ5dDgbzo=;
        b=HfoHr8gSHT7AVjVzWvAeogfF72BbI0cy8K1WYqod78gvncXk9BJuz/IbcTbZDlKaZ8
         Zs8S1Jfa9a2nEjQ6/6fX93MCuxHt/7/sLIrnJQmY8Vt4K0qS28WFTovTqOyt/y4JucW8
         Btdki9UDY6PhfVmYxjghTSuIXEWzHHag7YzK6WFRWEMu8Z3efHqRxahE51+ETXQDympv
         Z1uzrS79+VZ4Uoy1eD/SuCyUT3XaYAicsirrJSyyxNN+gGoPGL3ltNCoDEbVeopabqIc
         ESOxfcpSS1u1VIH69hAqp5qDZkAysOwqmd3pGobT1mRI/iyQtqawFfc8J3P0sR/TIC4C
         V67A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 072/164] ext4: shutdown should not prevent get_write_access
Date: Sun, 22 Apr 2018 15:52:19 +0200
Message-Id: <20180422135138.410913890@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455105865825935?=
X-GMAIL-MSGID: =?utf-8?q?1598455635985165453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
