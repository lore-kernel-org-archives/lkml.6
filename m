Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZohLtYyFy7rRq0tvKLNdO5/ivS/AE4yogyid2Z6nsQOZpVZdbOae8GGKUWPwaEhe0eQ5+Ru
ARC-Seal: i=1; a=rsa-sha256; t=1525116456; cv=none;
        d=google.com; s=arc-20160816;
        b=nUG4wvJqkOWosj7oWIhOu0hD5r1kGiuiZCpyAjZRhdc2miYUj1umVV4RfuWVMKH7R/
         Qaug+GjPhG1Fo7y4Y1i3TXGx0D1F0gjG9mSnpDjyziXqiBTIHN0PdaqM4NpEtERYaw5b
         nNvT+8tj+FDk0oEPVmx0+oWsPJPb9cihZYBAcHT9Y9PsFYN7/IipYBHSLuuwEroGoC6h
         tg0q1OBYpg52bDmOtGhVu4/QnPP48PcJLgPU+cdlEX94Vkfo7LRaCauts6KvWvBmY7rG
         7t5b4+SQYDiXq+RjOMWI1KEQBsskLWbq/olgRU2pbh3Af/ZKOBaczCFQ/o0NqB5erFUQ
         OtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=I8819N/Gr086P398h+4fzE67zuzHrcqS21+FwLXmiDc=;
        b=t8njpiuzge+fG7+i1Pscxw4MGTLNviC5vhVpWsv2raqs6SGMBje3oiI70IKrhYiJc2
         UQPgIJHj3F/S+uj2OW24K94XSohBtr7gPizou9m+eIEAmlKWX+IfJAFNps98T/6Sxwqw
         bKsryjruhrZqjd/Yg/OL/bD8KN2BRX6ymPi43dZL9FEqlZ69HL2+DYLFnfcl+vyHspFY
         mlfqmGdp6U6mh3psOGm/flM4OOvlVUelPlyGGQHnh09Qm9DqRURXQrD+mvFjyO6Bqzbe
         YGUEEsoYsBiD3opahZkYctJilvMI+wdKjHM0x/vgPmrC88hd5yOPTJDUaYPk0CIH0szB
         V3fg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0410322E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 4.14 75/91] libceph: validate con->state at the top of try_write()
Date: Mon, 30 Apr 2018 12:24:57 -0700
Message-Id: <20180430184008.182097707@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200287508150200?=
X-GMAIL-MSGID: =?utf-8?q?1599200513700747692?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2530,6 +2530,11 @@ static int try_write(struct ceph_connect
 	int ret = 1;
 
 	dout("try_write start %p state %lu\n", con, con->state);
+	if (con->state != CON_STATE_PREOPEN &&
+	    con->state != CON_STATE_CONNECTING &&
+	    con->state != CON_STATE_NEGOTIATING &&
+	    con->state != CON_STATE_OPEN)
+		return 0;
 
 more:
 	dout("try_write out_kvec_bytes %d\n", con->out_kvec_bytes);
@@ -2555,6 +2560,8 @@ more:
 	}
 
 more_kvec:
+	BUG_ON(!con->sock);
+
 	/* kvec data queued? */
 	if (con->out_kvec_left) {
 		ret = write_partial_kvec(con);
