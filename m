Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+twjNQFXt18a4dQbNAAy6TE+Cqt2NWv85kI6sDL/Vruyi9OU7IhOoz3tM69F4J3ONXGRry
ARC-Seal: i=1; a=rsa-sha256; t=1522168595; cv=none;
        d=google.com; s=arc-20160816;
        b=qR+RzHgQGEozupwfvvhc7rKI3Bl1BrPTYDoJzgIL/GruD5/FHhu9Ij9+rP6oi5jlVy
         n8obuSMbnimikHqBEMMhXOrRnIDjgI9+nTU9AFzOh8eVP7N5IZjHZRoIlhISLZP2xS03
         /FoIGwXLW34hlEOjori0ZK9K7fhgEToN9RKIuF8tLF8NGC0kO/9eDZbKE2LC4Qjvrmvz
         Z/SMF29a2xu6ojyxz8PJ0PSIT/ayS+3R0Y/GTyvv+r7U7+/iAqOs89r/KTgEiQGMIZk9
         NOMFNByqS8PD8q3b5AGarMCPm7TfSFakm+pGe7APQ2wAMjiTDdM7hgfzDpJtsm93hHRA
         CXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qFtYFxcKZDbK/zauvn1BtMyl1xx7u1OM+1434IrLGWU=;
        b=GrWOZ7us62Adl1aryyw47GNX92/8Q23mJSD3A9R+M0xP3eRB0417zHxyFGPx+MHRip
         EQhio5Rm1JiKhQRMeKA0tvOQcfKsl5rtdYtAYJxx3KGxInNCZ71mlMA5exdT1NhbPVMD
         JUkF3K+Y69dkASyyXjNCH608qYMdgcQWjbuSYz37oW93dV7SViYHxHtWUPUZDoPubAJM
         xpy562ZfjXKzPmFidbUV7HljFKSUJmX1STgpRLJPRPJx0Jb06iR/SdB0Qf0quWOdfp73
         ZVu4Pa7DpbYMsPuZ5HrCbiYf4/rrcdT/Guek79x/++4U7z1XNiUXXs4/wFeTPej4SLKs
         bUIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Kelley <mhkelley@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4.14 029/101] Drivers: hv: vmbus: Fix ring buffer signaling
Date: Tue, 27 Mar 2018 18:27:01 +0200
Message-Id: <20180327162751.771629248@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109457683723677?=
X-GMAIL-MSGID: =?utf-8?q?1596109457683723677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mhkelley@outlook.com>

commit 655296c8bbeffcf020558c4455305d597a73bde1 upstream.

Fix bugs in signaling the Hyper-V host when freeing space in the
host->guest ring buffer:

1. The interrupt_mask must not be used to determine whether to signal
   on the host->guest ring buffer
2. The ring buffer write_index must be read (via hv_get_bytes_to_write)
   *after* pending_send_sz is read in order to avoid a race condition
3. Comparisons with pending_send_sz must treat the "equals" case as
   not-enough-space
4. Don't signal if the pending_send_sz feature is not present. Older
   versions of Hyper-V that don't implement this feature will poll.

Fixes: 03bad714a161 ("vmbus: more host signalling avoidance")

Cc: Stable <stable@vger.kernel.org> # 4.14 and above
Signed-off-by: Michael Kelley <mhkelley@outlook.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/ring_buffer.c |   54 +++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 18 deletions(-)

--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -394,13 +394,24 @@ __hv_pkt_iter_next(struct vmbus_channel
 }
 EXPORT_SYMBOL_GPL(__hv_pkt_iter_next);
 
+/* How many bytes were read in this iterator cycle */
+static u32 hv_pkt_iter_bytes_read(const struct hv_ring_buffer_info *rbi,
+					u32 start_read_index)
+{
+	if (rbi->priv_read_index >= start_read_index)
+		return rbi->priv_read_index - start_read_index;
+	else
+		return rbi->ring_datasize - start_read_index +
+			rbi->priv_read_index;
+}
+
 /*
  * Update host ring buffer after iterating over packets.
  */
 void hv_pkt_iter_close(struct vmbus_channel *channel)
 {
 	struct hv_ring_buffer_info *rbi = &channel->inbound;
-	u32 orig_write_sz = hv_get_bytes_to_write(rbi);
+	u32 curr_write_sz, pending_sz, bytes_read, start_read_index;
 
 	/*
 	 * Make sure all reads are done before we update the read index since
@@ -408,8 +419,12 @@ void hv_pkt_iter_close(struct vmbus_chan
 	 * is updated.
 	 */
 	virt_rmb();
+	start_read_index = rbi->ring_buffer->read_index;
 	rbi->ring_buffer->read_index = rbi->priv_read_index;
 
+	if (!rbi->ring_buffer->feature_bits.feat_pending_send_sz)
+		return;
+
 	/*
 	 * Issue a full memory barrier before making the signaling decision.
 	 * Here is the reason for having this barrier:
@@ -423,26 +438,29 @@ void hv_pkt_iter_close(struct vmbus_chan
 	 */
 	virt_mb();
 
-	/* If host has disabled notifications then skip */
-	if (rbi->ring_buffer->interrupt_mask)
+	pending_sz = READ_ONCE(rbi->ring_buffer->pending_send_sz);
+	if (!pending_sz)
 		return;
 
-	if (rbi->ring_buffer->feature_bits.feat_pending_send_sz) {
-		u32 pending_sz = READ_ONCE(rbi->ring_buffer->pending_send_sz);
+	/*
+	 * Ensure the read of write_index in hv_get_bytes_to_write()
+	 * happens after the read of pending_send_sz.
+	 */
+	virt_rmb();
+	curr_write_sz = hv_get_bytes_to_write(rbi);
+	bytes_read = hv_pkt_iter_bytes_read(rbi, start_read_index);
+
+	/*
+	 * If there was space before we began iteration,
+	 * then host was not blocked.
+	 */
 
-		/*
-		 * If there was space before we began iteration,
-		 * then host was not blocked. Also handles case where
-		 * pending_sz is zero then host has nothing pending
-		 * and does not need to be signaled.
-		 */
-		if (orig_write_sz > pending_sz)
-			return;
-
-		/* If pending write will not fit, don't give false hope. */
-		if (hv_get_bytes_to_write(rbi) < pending_sz)
-			return;
-	}
+	if (curr_write_sz - bytes_read > pending_sz)
+		return;
+
+	/* If pending write will not fit, don't give false hope. */
+	if (curr_write_sz <= pending_sz)
+		return;
 
 	vmbus_setevent(channel);
 }
