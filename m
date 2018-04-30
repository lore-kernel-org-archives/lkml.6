Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpFAbA6K/CTe/dS6f/iUBTGK85kZ9nSLhjRTCZ3NUbkZ3iQQK61WiUiKpUsaimuhAoC7PQO
ARC-Seal: i=1; a=rsa-sha256; t=1525116242; cv=none;
        d=google.com; s=arc-20160816;
        b=yXW78bx9iNbVtsbCbUqBVlLCfwjDV/AkKgjJf1KTZjDz14ULZir5ZS01LyPKQbgRxQ
         pSHoww+8EDVBMQlVg88JK4s11CHIdnoCqQ+xXzNthoWbcopZ48GO2AUvyBzvxCvTbcCY
         74MSVD+vfTK6yYF1v7LjgSDUwMxyVsSuFsv8zxl81DkKoggqF/hSb/4js/J2hmUOKsC3
         D0Tede+LqFDa9Hesv8NlKy3IM/OBiihcctBhlRaDppmHMQtgfrnWZAEmsVf983VObNuJ
         iPH6GPylymkEEJqILdUSRm47c4rgdC2tiJdn5M8Hj0yaHIHGsy5nskEjH2tEbdcT25bh
         sl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=T9E3KdLKjKlLC5y4KbkbrVCUhFs+P0Ku5ke9+XUuSQU=;
        b=A7pc6vuTRaR5ItHnDVYBwoI7Klv/pK1VYWUjUqjJWp1nqeYAYJ7lDOxt2EEjJB5i7u
         gti++1jYo15R2BNdoAy09ErOdw/ZQy21p6FyaHvvlQ3HKmw+uh5fPoEOzwimyMjNF7Dh
         QX5SALeOvPDH644qF/O39/5QDjWv6NYcobZMGiJKBq0yGU1iaXkiPyMeW3NbUQ4rZ97W
         yHmAwyBK9O2ULiXgpC95LgqZzByJbChlUNK4zYZaX7fG2z7P4iwjDMEtlC3HhGNtZt8L
         +gYBJo5/SvenP86ZqN78M6bG1v5RjrjSbIF5rGc4RXtt5iSzkcMSSWWLpfGr2mfBHYtZ
         a7CQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FAF22DA3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 3.18 24/25] libceph: validate con->state at the top of try_write()
Date: Mon, 30 Apr 2018 12:23:31 -0700
Message-Id: <20180430183911.816796265@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200287508150200?=
X-GMAIL-MSGID: =?utf-8?q?1599200287508150200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2449,6 +2449,11 @@ static int try_write(struct ceph_connect
 	int ret = 1;
 
 	dout("try_write start %p state %lu\n", con, con->state);
+	if (con->state != CON_STATE_PREOPEN &&
+	    con->state != CON_STATE_CONNECTING &&
+	    con->state != CON_STATE_NEGOTIATING &&
+	    con->state != CON_STATE_OPEN)
+		return 0;
 
 more:
 	dout("try_write out_kvec_bytes %d\n", con->out_kvec_bytes);
@@ -2474,6 +2479,8 @@ more:
 	}
 
 more_kvec:
+	BUG_ON(!con->sock);
+
 	/* kvec data queued? */
 	if (con->out_skip) {
 		ret = write_partial_skip(con);
