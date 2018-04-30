Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZquRvgE18+TgzNHUvX5wNY95w6czxBYY4a7zOiXHDw1JMvGHiWWqb/cUEJYe3ScuRhdLlZv
ARC-Seal: i=1; a=rsa-sha256; t=1525116521; cv=none;
        d=google.com; s=arc-20160816;
        b=UtOP1zCT6XSbM91uSYpqJfR6OAELXOxIA4cH1dfrUUhlP7UudVB9f9DmJGM2UJPpR/
         mH0egiHGVF71ZAtiWmU70upoleYnjKSZ9q0jiFdO+9ssZWQWQa3RYxXtN68o1zWGW+Ww
         i+4aOtMd3Ql80V2UUMTtMnHrWcK3cJVA1Q/Du5eoe6RjH1w8Q6cGoNocPARHAfBbCjay
         qtyS6+dWemK7csnENpS0TT1wxQIR/cgYba+RvvxMhdxoxSmkq+Q2bqKpgMKcrsROoL79
         +bZ3zwb6WGG4ILn2Ya/j1Y8vrBvpp8qwham7o/ACXm5wv08JUadwGB89DBMEGPeyegyL
         gJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=zbC4IGvYmgwKkH/ngQP8PZl8nBt1Y9ac1DYr/6RgArk=;
        b=x+1FIFxq7fW/vb+S6sKOi09xtZnAMy+uSLJ3ytHz2TvRvIyZFig80p0IdNzPxjhFNz
         x0lcMB4xmN/ij41qv912gUuAG944egQDxQqt/uhSNxb5MS/NH789saagbApG8m0dkjRG
         qAeFVdH8K/SoH/nm2/eEHAnKVyfWM0M0BgR5Nn3PEd//IkF0YRlqQo9g2C1vXGY8LGCh
         A4pMLy6ST9km+i1rR/i08URMDmHKMmwyOumeIoWebHaODGPjinBMzVDhl0Us0AX9o69l
         Nq2wVB6MwYJGyu+FDzprWWGHXLaboW74A5XRe52sQ0U+Kyg3h+cSblSj23mMibpzhUM7
         VrUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D9222DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 4.16 088/113] libceph: validate con->state at the top of try_write()
Date: Mon, 30 Apr 2018 12:24:59 -0700
Message-Id: <20180430184018.914737228@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200287508150200?=
X-GMAIL-MSGID: =?utf-8?q?1599200581777486378?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2531,6 +2531,11 @@ static int try_write(struct ceph_connect
 	int ret = 1;
 
 	dout("try_write start %p state %lu\n", con, con->state);
+	if (con->state != CON_STATE_PREOPEN &&
+	    con->state != CON_STATE_CONNECTING &&
+	    con->state != CON_STATE_NEGOTIATING &&
+	    con->state != CON_STATE_OPEN)
+		return 0;
 
 more:
 	dout("try_write out_kvec_bytes %d\n", con->out_kvec_bytes);
@@ -2556,6 +2561,8 @@ more:
 	}
 
 more_kvec:
+	BUG_ON(!con->sock);
+
 	/* kvec data queued? */
 	if (con->out_kvec_left) {
 		ret = write_partial_kvec(con);
