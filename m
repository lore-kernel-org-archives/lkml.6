Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv/p62ZEH1AQojmW7KpzqrKDzhaOUPFwvPSoFr+2F7UKiqGv1MpJVd3aqwmZx2lmlSxScOK
ARC-Seal: i=1; a=rsa-sha256; t=1519411826; cv=none;
        d=google.com; s=arc-20160816;
        b=D86gd2LXcVZ44acKXIKpVeNMpYaqS9zJ8zGFE3wSliA7pKNRXRdrw4TQ3TqhrDlX0w
         UuYFNy0QnNjPRbBwCSlpMFK+kx21GoTC6fs51CHbT+o2aACWq3bHufGOpgj7Zvf7RJpo
         15RBzefGxFunlqLlS8rlnCasyXkwR4YO8pWbCn2dPdUMQK3lZzNgPYHNWgndwYm4RB5C
         JJTJwvJ+7vsGUDy6IwPpONi3K3Xvv4OaFnJy4d240xEj2+CgehtUuERIVAnYDtT1duuw
         kSTRznWbRWDH+Skgzund6PABFFVr2SyjZsB2K7g9OyeC5LmNbe7gPcRd0/7LED0ToZjw
         7gPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c1mtNUK2cfuldYUwjqEFOSqmLNB6wiNROOupBYxXYgg=;
        b=u6TzgcO70Uj6pWAFwqJptHYuVENMmXFxqf8hNv8FMXdZpqwbzAKAcEdI6/qsOvTFrP
         mRbRfMy8QysaGF9/QIJ7njaRsYcIHtRoTWF1BCNLJfH98T90gdnJLPkdy5EAB+NLb9Ax
         pveN8uQhLHsbHprGbPlbWzTSNEx9F/Gx4CzRaa3UhlbAnOHeJ4F//zd7SzmfqFL/5GWN
         ibR42Qe0yLugjOnD8Vd/CUzudDfmiQFb0RQxtmmBM1f7QYeex2R11/uup/SauX+ehj3I
         uz8tIm901kp9/8IwWPyO6BSuRlgYcPkjgb41QxHOdf8IGyiDPGXtV1Eo7WXbwMCPeFXz
         d3JA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+114b15f2be420a8886c3@syzkaller.appspotmail.com,
	Tom Herbert <tom@quantonium.net>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 003/159] kcm: Check if sk_user_data already set in kcm_attach
Date: Fri, 23 Feb 2018 19:25:11 +0100
Message-Id: <20180223170743.496615531@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218387524448381?=
X-GMAIL-MSGID: =?utf-8?q?1593218775770517556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Herbert <tom@quantonium.net>

commit e5571240236c5652f3e079b1d5866716a7ad819c upstream.

This is needed to prevent sk_user_data being overwritten.
The check is done under the callback lock. This should prevent
a socket from being attached twice to a KCM mux. It also prevents
a socket from being attached for other use cases of sk_user_data
as long as the other cases set sk_user_data under the lock.
Followup work is needed to unify all the use cases of sk_user_data
to use the same locking.

Reported-by: syzbot+114b15f2be420a8886c3@syzkaller.appspotmail.com
Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Tom Herbert <tom@quantonium.net>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/kcm/kcmsock.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1405,9 +1405,18 @@ static int kcm_attach(struct socket *soc
 		return err;
 	}
 
-	sock_hold(csk);
-
 	write_lock_bh(&csk->sk_callback_lock);
+
+	/* Check if sk_user_data is aready by KCM or someone else.
+	 * Must be done under lock to prevent race conditions.
+	 */
+	if (csk->sk_user_data) {
+		write_unlock_bh(&csk->sk_callback_lock);
+		strp_done(&psock->strp);
+		kmem_cache_free(kcm_psockp, psock);
+		return -EALREADY;
+	}
+
 	psock->save_data_ready = csk->sk_data_ready;
 	psock->save_write_space = csk->sk_write_space;
 	psock->save_state_change = csk->sk_state_change;
@@ -1415,8 +1424,11 @@ static int kcm_attach(struct socket *soc
 	csk->sk_data_ready = psock_data_ready;
 	csk->sk_write_space = psock_write_space;
 	csk->sk_state_change = psock_state_change;
+
 	write_unlock_bh(&csk->sk_callback_lock);
 
+	sock_hold(csk);
+
 	/* Finished initialization, now add the psock to the MUX. */
 	spin_lock_bh(&mux->lock);
 	head = &mux->psocks;
