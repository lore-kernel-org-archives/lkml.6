Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225VivsRKcKgFgWyIp2E3wjeCrz8VBF+2pchvwMGfgw9RJ3NQHBHDECwlKuC37+0nACGrqQ6
ARC-Seal: i=1; a=rsa-sha256; t=1519218228; cv=none;
        d=google.com; s=arc-20160816;
        b=rprE1iRZ8270hFPfo2/2K7ts7TXRBBXZ0K91cq+y51/KOqMvComBoQQ0su/iMWSpUj
         HRpN+bA9y1f0J+O49dZ1VMZVItrtAYAJev2lTYCWariN6GHXnkky0+FoDp1f6Jue0aqa
         Z/VSG6pBijgKixTy8y891QUyohegCC3P135KZ23s1B+lkdRyasI3Ej8UERMxEWhXjNcA
         CWcZb7pb7hGLANTudOw+UtClgN2ipgyZeX0H6ETFsutNCR0NXslSh5EZvlNXyMkUhcLq
         H7l95tmbXtCd3fg3zWfQgmeSs+A8TRPGbXA7tlGmc7bcdRtTnL3bf+0VQVpn3pTxfUye
         ontg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u40FOINwXRLKCPj9Rd7fSZskqCGwuuxQOt2p9jGzVaI=;
        b=WNa2xdapSo66y+u7JeBMtv/yIKVQuICuw+88fFW0T+gi4QeR5UbijNrVisNiN/p8eR
         riphyvuAo7/+ZkquyWX479PWhsgSHsCoiqv6Mky2E/o9aptAPrJWrs+WjAkMvevkovuI
         Wr8mA91aHRKuhCd+MFh/JBLz/YWnhd6Pco/JwVuHfxfwcGTqIsSl7JoiibtS9T8P5vRS
         Bkh4t2uLFi+m46VwrIDK5WCz0tQIGvc3uuYbSQx6RZmBq+x4SSHO1UwueL1HhOsoYsbM
         GeU6Wo/bT1RqN1kqOpXrg8YRH95rCradebKycv/EagGK4TO9Fv7bCv0vS0VZIMiH7Lc+
         ZjEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Christie <mchristi@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Subject: [PATCH 4.14 132/167] iscsi-target: make sure to wake up sleeping login worker
Date: Wed, 21 Feb 2018 13:49:03 +0100
Message-Id: <20180221124531.859644775@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015773402705325?=
X-GMAIL-MSGID: =?utf-8?q?1593015773402705325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 1c130ae00b769a2e2df41bad3d6051ee8234b636 upstream.

Mike Christie reports:
  Starting in 4.14 iscsi logins will fail around 50% of the time.

Problem appears to be that iscsi_target_sk_data_ready() callback may
return without doing anything in case it finds the login work queue
is still blocked in sock_recvmsg().

Nicholas Bellinger says:
  It would indicate users providing their own ->sk_data_ready() callback
  must be responsible for waking up a kthread context blocked on
  sock_recvmsg(..., MSG_WAITALL), when a second ->sk_data_ready() is
  received before the first sock_recvmsg(..., MSG_WAITALL) completes.

So, do this and invoke the original data_ready() callback -- in
case of tcp sockets this takes care of waking the thread.

Disclaimer: I do not understand why this problem did not show up before
tcp prequeue removal.

(Drop WARN_ON usage - nab)

Reported-by: Mike Christie <mchristi@redhat.com>
Bisected-by: Mike Christie <mchristi@redhat.com>
Tested-by: Mike Christie <mchristi@redhat.com>
Diagnosed-by: Nicholas Bellinger <nab@linux-iscsi.org>
Fixes: e7942d0633c4 ("tcp: remove prequeue support")
Signed-off-by: Florian Westphal <fw@strlen.de>
Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/iscsi/iscsi_target_nego.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -432,6 +432,9 @@ static void iscsi_target_sk_data_ready(s
 	if (test_and_set_bit(LOGIN_FLAGS_READ_ACTIVE, &conn->login_flags)) {
 		write_unlock_bh(&sk->sk_callback_lock);
 		pr_debug("Got LOGIN_FLAGS_READ_ACTIVE=1, conn: %p >>>>\n", conn);
+		if (iscsi_target_sk_data_ready == conn->orig_data_ready)
+			return;
+		conn->orig_data_ready(sk);
 		return;
 	}
 
