Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+N8wE111IjS78Lbw/SOa/arvyTdSeJ5nzk+/l/RYpwjszDsSgVvLsttfz4u4qDIf1VUOXN
ARC-Seal: i=1; a=rsa-sha256; t=1524405486; cv=none;
        d=google.com; s=arc-20160816;
        b=rkB5gBo0R7T3qqJk/IYBD0Le9t5hN+UTUFAHmdUJvbf9PNvl81LHtfIuDB204JFD32
         9Ez3iTvorL9lx4Ow07FWR2Kx8sB7Y8Fm+V3tqewRz15A93Tk25rm1FDy3MQrVrydBhdK
         mmCyZCCrwdkSTfwvK6sIm1gHWWodB5HIST0yJeHp5OWDcgfMq/gImrsIXMA4DvFlbQVa
         R20aJ2tbrrVJHKuwGuiJtZMmGA+XLwzwujyowtJ8XMYPIPo1ukxAp4Pt3KQaAo6Y3Dro
         Bixn4DCCegGyoXIFTeHIjOf4nGRNSLcRXjqi6abNFvejTRkwZxLoOT+J+PcnfCPwTOfI
         ruLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iPhYAjQHvwI5dnsSPFFmfiO/kEMS9oadGxAWh5YIlbQ=;
        b=hLpi7yNNfIRLZAyINTryCS4rppjoXNvppmXSUwOxhw6+AXjBO+Qq/YQoFsBc3qyd/T
         c5NUoa2clVc/wLZOMIfCi/qbIR3D9c7InVJPSyvXdmM5091/QFGxKjbL27OvObux7QWK
         gzfM8VBLaIAOi9kbSCKiUxHz7e8/k6pH0Zeqpx1Lqt4QLDbYze70W9xZ4j8TGJoXhjIg
         tNtzRYuLJQq9izEzFrnvT1WOHBv9Bj/oC/6NOJu5oKqv8/5Rzgc2doZqnulwesneQvts
         Sixa1ortC83XtoRKYe7KzQAjNCwH3WsPBF8ZcHl+CaywmCt/znxtbYLl1HvFJvcTZQtW
         ioLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Steve French <smfrench@gmail.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.16 048/196] cifs: smbd: avoid reconnect lockup
Date: Sun, 22 Apr 2018 15:51:08 +0200
Message-Id: <20180422135106.570822475@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455007640247372?=
X-GMAIL-MSGID: =?utf-8?q?1598455007640247372?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

commit 48f238a79f668f8ff013024d83010de551833d7f upstream.

During transport reconnect, other processes may have registered memory
and blocked on transport. This creates a deadlock situation because the
transport resources can't be freed, and reconnect is blocked.

Fix this by returning to upper layer on timeout. Before returning,
transport status is set to reconnecting so other processes will release
memory registration resources.

Upper layer will retry the reconnect. This is not in fast I/O path so
setting the timeout to 5 seconds.

Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smbdirect.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1498,8 +1498,8 @@ int smbd_reconnect(struct TCP_Server_Inf
 	log_rdma_event(INFO, "reconnecting rdma session\n");
 
 	if (!server->smbd_conn) {
-		log_rdma_event(ERR, "rdma session already destroyed\n");
-		return -EINVAL;
+		log_rdma_event(INFO, "rdma session already destroyed\n");
+		goto create_conn;
 	}
 
 	/*
@@ -1512,15 +1512,19 @@ int smbd_reconnect(struct TCP_Server_Inf
 	}
 
 	/* wait until the transport is destroyed */
-	wait_event(server->smbd_conn->wait_destroy,
-		server->smbd_conn->transport_status == SMBD_DESTROYED);
+	if (!wait_event_timeout(server->smbd_conn->wait_destroy,
+		server->smbd_conn->transport_status == SMBD_DESTROYED, 5*HZ))
+		return -EAGAIN;
 
 	destroy_workqueue(server->smbd_conn->workqueue);
 	kfree(server->smbd_conn);
 
+create_conn:
 	log_rdma_event(INFO, "creating rdma session\n");
 	server->smbd_conn = smbd_get_connection(
 		server, (struct sockaddr *) &server->dstaddr);
+	log_rdma_event(INFO, "created rdma session info=%p\n",
+		server->smbd_conn);
 
 	return server->smbd_conn ? 0 : -ENOENT;
 }
