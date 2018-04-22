Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/SQphMOhjVtaPLFpAWQ9mzZi+TkaUtSXTmoRHhNVkfcwlxdzcgDHiSKymyhnBP2zaHq6pI
ARC-Seal: i=1; a=rsa-sha256; t=1524405489; cv=none;
        d=google.com; s=arc-20160816;
        b=PrH1AOdaZvywrpci7ggAhmqs6znSNl0f1aj5Vx+1h8kYp/UYEFw7yI3ciS7+AhzAyX
         1BxePjA2lATfcMB3cb7bj6jpGPvoAcFiaOEHhknAAq84jJyw/EMdcDpxbaOtx9pYSnLM
         J5Ejo+mPYS8YlUo/cg+ngQMzFMLfF/69oyczgico1vjKqpSOtpXNXQoF+oCr8f6kD4oK
         QlXnJK1zbaFLOFjE5I7qqT+7itY9Ys2bvFpCftnEIekTyHwOM5FLljUjpWdwXZmujwBf
         uTTiyRaXwgq6K/zsETtGrJAP/dh7vvVWKdGOI4QA2zZscgs+u4C+PCPZNmffG3GlLbj5
         tcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xpxrdswoTy0wpAa3RT6LnmWy7O3EqSrhMNkRNYzfJ3k=;
        b=tYz3QY06vZ/nPtaEEo5NrwWYVnaELZUeZZ5FkIssN2c7HEOSW3f3r/lJKarY3KjrzA
         EFnvcm4kD0sDt3qm6xJj/JbxCK9+JD3tiOpLv6LA8vN2glDyE4jIEsnSxXLGwHOo4yA+
         JXYbfZ32UDMXdaHrGHTuzNM86YtJY38DkB+urKYB75NG8KiDQhS7QKYVFERysKEpNlHg
         qaE9SbIY54s6OGPC0h6WCRfvhcv0/X/nx3ZBHu2lpmmeBLaBTBUJHdvHVuzN0GcuJCrW
         77UfCc4X8Wg44KWiEQ68mgA6Kg6FXQ0KLXMoKq4viH5WA2Wt571nKWQfgwBca5KRjD9K
         dXnA==
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
Subject: [PATCH 4.16 049/196] cifs: smbd: disconnect transport on RDMA errors
Date: Sun, 22 Apr 2018 15:51:09 +0200
Message-Id: <20180422135106.622685140@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455010715845650?=
X-GMAIL-MSGID: =?utf-8?q?1598455010715845650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

commit 21a4e14aaedbc85f203d37e56cb26235b22b43f6 upstream.

On RDMA errors, transport should disconnect the RDMA CM connection. This
will notify the upper layer, and it will attempt transport reconnect.

Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smbdirect.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -862,6 +862,8 @@ static int smbd_post_send_negotiate_req(
 	ib_dma_unmap_single(info->id->device, request->sge[0].addr,
 		request->sge[0].length, DMA_TO_DEVICE);
 
+	smbd_disconnect_rdma_connection(info);
+
 dma_mapping_failed:
 	mempool_free(request, info->request_mempool);
 	return rc;
@@ -1061,6 +1063,7 @@ static int smbd_post_send(struct smbd_co
 			if (atomic_dec_and_test(&info->send_pending))
 				wake_up(&info->wait_send_pending);
 		}
+		smbd_disconnect_rdma_connection(info);
 	} else
 		/* Reset timer for idle connection after packet is sent */
 		mod_delayed_work(info->workqueue, &info->idle_timer_work,
@@ -1202,7 +1205,7 @@ static int smbd_post_recv(
 	if (rc) {
 		ib_dma_unmap_single(info->id->device, response->sge.addr,
 				    response->sge.length, DMA_FROM_DEVICE);
-
+		smbd_disconnect_rdma_connection(info);
 		log_rdma_recv(ERR, "ib_post_recv failed rc=%d\n", rc);
 	}
 
@@ -2546,6 +2549,8 @@ dma_map_error:
 	if (atomic_dec_and_test(&info->mr_used_count))
 		wake_up(&info->wait_for_mr_cleanup);
 
+	smbd_disconnect_rdma_connection(info);
+
 	return NULL;
 }
 
