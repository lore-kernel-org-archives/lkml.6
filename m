Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZovIYUvTA6W/jc5Cp/GaiOyauf7GeFWl5Wyv8sP8l7d8THPX6B1C1PYUvsmf4ujhLuewBgG
ARC-Seal: i=1; a=rsa-sha256; t=1525116364; cv=none;
        d=google.com; s=arc-20160816;
        b=AmIh6OAZWMsJG9/+YqF4cworcseU2oSQ5ve/GCYY3SLUE20WbEO4BaY15eEbUbg5Rr
         ozE0Jtvn7zeHaWy42Pmargj+/RIPixAiA6eU06xQfqch9iBn01oYfDeLIfsz5UX1QV6d
         ZCF2iPgdn+Be68h/nnK4kaCIiyvTDWl87MPjGBm1hg3HtjdhF5sVVsb4gMLul9/CDA0n
         vZe7nZqWtq2yBvMTuAfQIMzoqf89mKkLY6197ywIXZ9J1wcbTVNvhjpCRSWxK0QSj+pW
         11H0dbm77NYjlyv1lKeR4kKBERIz9+DrD3bZ7bAMz6yy0D8OMALZr30ejCjGZD/ylQ58
         R85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=gS7jFwxLjE8Ya63X/lEQTLoKfEFD49qYA9BZMEhPMNY=;
        b=1C2yMZJGRj7GJfEmfm2a61XgaKSgQUTOJdrwTLP4jYdUtLHpkdjz1zx0AdLBFzntia
         auKK3N3Eiv9me5RVeIFjAbvmOVjBEBtCYwPQtdBGgDGnUwaMpH/mh45TrluQvUbCJMCq
         oP8oWdkk3spZbokC93ubCrLRLnCVYc3u14t/8FCmd0L7uxNePboJG0GkGM+jZb6D/kYk
         HdTAUCrtitC+DQh97fYKojPGPhgWNRPqzYW9wJvg5WgfAk3OvvO1+wxcLAJeXVb7hZdq
         3FkMMt9+G6IWi/y0LYVqtcsPV0hdgP9OgNoUFtNVTU5PPQZ5uTWYXoipLH0OQsNGwVeo
         +Tfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F3A22E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 4.4 39/44] libceph: validate con->state at the top of try_write()
Date: Mon, 30 Apr 2018 12:24:50 -0700
Message-Id: <20180430190947.889032341@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200287508150200?=
X-GMAIL-MSGID: =?utf-8?q?1599200417385396480?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
