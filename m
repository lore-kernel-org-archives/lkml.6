Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoM8n3+GUYcxOwnvzDX3eXhgXup2T7n2yNHtXbcugm73t/U7+Gjj+rFdi4V5CBdJY5F9u/o
ARC-Seal: i=1; a=rsa-sha256; t=1525116402; cv=none;
        d=google.com; s=arc-20160816;
        b=fa6A/1gPltAETFJ2XeuNx6qzxvJCQaQkOEUIOXCFHseTxnfnFebfoo71PWu/a5tM+S
         e9zf5lOppJa2KQErDgU5DrK9COAcQYGe1uYaDRi+8h096BYCaXPIcJS0Y09TEqjFLgbd
         cTWldwuMk4PzqQMeqsUnk11vuwpxNwETIXQv638D5ptrFB+mJ0w7WTzjBNd0yX3Fxo49
         7FkLHzFj7Iwkk0Xw/R8YQvUhljfYVHmSKOmMm0rmt5Gn8BmNgYRjVQOs4pOgIWWruOHg
         /+VGLQNXgtxn8MYpwbjlSYcP0Moj+hEO8Vt6sbXh/N4nrWs1p3aAY9F/Ok5ekEIHU4X9
         puqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=JIDOR6CT3XAYOm9hrKyjZChpH60GbP1OE7r+y7fZ6Gw=;
        b=OLpj0U7gWKo2q3lrplLk7KXsUG/DABE6S8ZKmgIU1lndMJr69GpRfS/cipcJqE3JaC
         jgB1wjBMqvYD/XH7/TNV6NONQHziC8nVk4NtrvhSYbC+oy9vh7wqEqGyW+gW8WpJM+Ut
         GIP1+xVjvpcgmpOy0JavXioppfMYIPjWdIXg8/vEuOvsU+VVJ/DNyZklPhhED+yR+Lyy
         k/Gztz+JBjRIhdDTmBGo7ArDvIiQNehWkSu/nYoWinrJwiJv6HW+w84vqxnzDPK4r26i
         CmbjZRKMx6jkg+YMSt7qr11BDr/+lfzktIrkSB5b/RuT+2b5A5Ok3cAdchXGqimSiOXz
         h9HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E99622DC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 4.9 51/61] libceph: validate con->state at the top of try_write()
Date: Mon, 30 Apr 2018 12:24:54 -0700
Message-Id: <20180430183955.640988377@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200287508150200?=
X-GMAIL-MSGID: =?utf-8?q?1599200456227477598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 9c55ad1c214d9f8c4594ac2c3fa392c1c32431a7 upstream.

ceph_con_workfn() validates con->state before calling try_read() and
then try_write().  However, try_read() temporarily releases con->mutex,
notably in process_message() and ceph_con_in_msg_alloc(), opening the
window for ceph_con_close() to sneak in, close the connection and
release con->sock.  When try_write() is called on the assumption that
con->state is still valid (i.e. not STANDBY or CLOSED), a NULL sock
gets passed to the networking stack:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000020
  IP: selinux_socket_sendmsg+0x5/0x20

Make sure con->state is valid at the top of try_write() and add an
explicit BUG_ON for this, similar to try_read().

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/23706
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Jason Dillaman <dillaman@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ceph/messenger.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2512,6 +2512,11 @@ static int try_write(struct ceph_connect
 	int ret = 1;
 
 	dout("try_write start %p state %lu\n", con, con->state);
+	if (con->state != CON_STATE_PREOPEN &&
+	    con->state != CON_STATE_CONNECTING &&
+	    con->state != CON_STATE_NEGOTIATING &&
+	    con->state != CON_STATE_OPEN)
+		return 0;
 
 more:
 	dout("try_write out_kvec_bytes %d\n", con->out_kvec_bytes);
@@ -2537,6 +2542,8 @@ more:
 	}
 
 more_kvec:
+	BUG_ON(!con->sock);
+
 	/* kvec data queued? */
 	if (con->out_kvec_left) {
 		ret = write_partial_kvec(con);
