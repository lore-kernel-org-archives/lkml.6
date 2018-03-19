Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvR/mveJIUHHDpSFjuAwb23Flv4VmXSG3gGHNh036/cMy1wTcZ5UgzC4vHR0111WFOjBOA4
ARC-Seal: i=1; a=rsa-sha256; t=1521483892; cv=none;
        d=google.com; s=arc-20160816;
        b=f7VPcOJFwksOhyDEt0WBFUBjwdhTphdaxsWxlRuM7rGiP4tG8FX+Dd9ag2RX74jDtr
         UViYYUFOgZatO2llBuvmws0XZa4pcp3P1xqpQZlE+FuqdvoT+JNv+4qswhHKEU8sBIzS
         X0NkvT+RwCiGIsj2jnTVoDmAouJnazk1KpyJNlSpkmokstWc6gm65IHv2atYeyfkhP2Z
         2SmIirrNxsLdNXy0ZBMSnqAUn8WCvz0Iw7sPdBEk2JCUzygwIBZyaT5fu+COpZwIFezD
         zGGZIcCACZ1tleL82oNqHnmcur2PmHDQpZ+Onu0jbpFaoCH80dsahDF89l2KPRVqyqW/
         mEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zLMGdmJjjffiniJQ4ndbhQwX8bB/9dhlEzZaaJEJS6s=;
        b=TAefOBmOZGYnkCq6Y38iXTfGpvJzGPBBhMW7nQ0NpRLhF3sLmGEhJZEwcLnsqtXamP
         5NQ/aNvjHs8/dpAPvupGwXNKK0ocRL0nwwSMGGiHH/Dqb4dll4tTXj/iVPND97blFvFp
         ZeT2BaTA4PDDoDTPzsQqLZ1pEr+F1xqW7wKmFx73cSDv5m4uu2lbUwli0O9ZVZpygeja
         FPbwO7H6S1HVnqAmcIPJB0HjQtlAibrLaeXhk1lHG1ZYuulDYfXHTEKDk4+zuM9clKY/
         +ZjOeLTmSNRLSJImo8NTjztwxm/wq9/RYvaHKSWaXXl98s3oeh8XthdUGev3fRVng1OR
         43Qw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dean Jenkins <Dean_Jenkins@mentor.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 156/241] Bluetooth: Avoid bt_accept_unlink() double unlinking
Date: Mon, 19 Mar 2018 19:07:01 +0100
Message-Id: <20180319180757.629475999@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391494156839406?=
X-GMAIL-MSGID: =?utf-8?q?1595391494156839406?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dean Jenkins <Dean_Jenkins@mentor.com>


[ Upstream commit 27bfbc21a0c0f711fa5382de026c7c0700c9ea28 ]

There is a race condition between a thread calling bt_accept_dequeue()
and a different thread calling bt_accept_unlink(). Protection against
concurrency is implemented using sk locking. However, sk locking causes
serialisation of the bt_accept_dequeue() and bt_accept_unlink() threads.
This serialisation can cause bt_accept_dequeue() to obtain the sk from the
parent list but becomes blocked waiting for the sk lock held by the
bt_accept_unlink() thread. bt_accept_unlink() unlinks sk and this thread
releases the sk lock unblocking bt_accept_dequeue() which potentially runs
bt_accept_unlink() again on the same sk causing a crash. The attempt to
double unlink the same sk from the parent list can cause a NULL pointer
dereference crash due to bt_sk(sk)->parent becoming NULL on the first
unlink, followed by the second unlink trying to execute
bt_sk(sk)->parent->sk_ack_backlog-- in bt_accept_unlink() which crashes.

When sk is in the parent list, bt_sk(sk)->parent will be not be NULL.
When sk is removed from the parent list, bt_sk(sk)->parent is set to
NULL. Therefore, add a defensive check for bt_sk(sk)->parent not being
NULL to ensure that sk is still in the parent list after the sk lock has
been taken in bt_accept_dequeue(). If bt_sk(sk)->parent is detected as
being NULL then restart the loop so that the loop variables are refreshed
to use the latest values. This is necessary as list_for_each_entry_safe()
is not thread safe so causing a risk of an infinite loop occurring as sk
could point to itself.

In addition, in bt_accept_dequeue() increase the sk reference count to
protect against early freeing of sk. Early freeing can be possible if the
bt_accept_unlink() thread calls l2cap_sock_kill() or rfcomm_sock_kill()
functions before bt_accept_dequeue() gets the sk lock.

For test purposes, the probability of failure can be increased by putting
a msleep of 1 second in bt_accept_dequeue() between getting the sk and
waiting for the sk lock. This exposes the fact that the loop
list_for_each_entry_safe(p, n, &bt_sk(parent)->accept_q) is not safe from
threads that unlink sk from the list in parallel with the loop which can
cause sk to become stale within the loop.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/af_bluetooth.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -163,6 +163,9 @@ void bt_accept_enqueue(struct sock *pare
 }
 EXPORT_SYMBOL(bt_accept_enqueue);
 
+/* Calling function must hold the sk lock.
+ * bt_sk(sk)->parent must be non-NULL meaning sk is in the parent list.
+ */
 void bt_accept_unlink(struct sock *sk)
 {
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
@@ -181,11 +184,32 @@ struct sock *bt_accept_dequeue(struct so
 
 	BT_DBG("parent %p", parent);
 
+restart:
 	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
 		sk = (struct sock *)s;
 
+		/* Prevent early freeing of sk due to unlink and sock_kill */
+		sock_hold(sk);
 		lock_sock(sk);
 
+		/* Check sk has not already been unlinked via
+		 * bt_accept_unlink() due to serialisation caused by sk locking
+		 */
+		if (!bt_sk(sk)->parent) {
+			BT_DBG("sk %p, already unlinked", sk);
+			release_sock(sk);
+			sock_put(sk);
+
+			/* Restart the loop as sk is no longer in the list
+			 * and also avoid a potential infinite loop because
+			 * list_for_each_entry_safe() is not thread safe.
+			 */
+			goto restart;
+		}
+
+		/* sk is safely in the parent list so reduce reference count */
+		sock_put(sk);
+
 		/* FIXME: Is this check still needed */
 		if (sk->sk_state == BT_CLOSED) {
 			bt_accept_unlink(sk);
