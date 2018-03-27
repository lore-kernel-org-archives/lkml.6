Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48S2065AzLfU9WUidq+AnoS6ZezEEmayEac7mabDIw0DxH68FQErsIzMdpHmB3iFY8Sojb8
ARC-Seal: i=1; a=rsa-sha256; t=1522168780; cv=none;
        d=google.com; s=arc-20160816;
        b=FChf6Pw9Pi3O25TQFXNu5FVb2mzxNerRvsowGdRJO0N5rOh8hDsyLnAkX3vCjc1dYQ
         IPvIvRdV/s1IKNFuQIkx6TRWAnMh6GMiiluwEIO6qB1iru9Tg/5ydTenyzYiPxusAZ69
         ccfnPrc8Hz/iO9q6eRcTdjFGb3jMV0wU4WilQFNsF3WGfFVIsHOxdQcXJQbl3QwJURe9
         qEdrZE3CeMtKKUz4cUX5SYyUdUImhObspmoRUf84MLmThqVoVtxhaqTGCzZGqrUcDvZZ
         NkNKHjfjPlIMML/w2aKZby//Z2n4ORxh0+5+SA4XewjUJE0E7ov4lwlvRF63kDTVQCa0
         29Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VDCEyCWiheo23NCUClZtQ02hZ8Ip/tj4PWsy+2EMrFk=;
        b=WzjDJJftQvQ4F4tnzpw8u+Yk2kmIaSZ1QNIaJPH9xw8U6+1htNb0peauovsJmeN5+a
         Npez6tLX8UpBmjfJ3uE0hFfjnUXA7XM7R7KeU2p64isMNJlMwq53dIDF83B0Tj3OzH9K
         X5qu9rG6/Z83MnYEYQhTMAnlrGGTZy/+lCCsbrZ7LI7vxmzgRGq/YrV2NAH+WD3BVfkS
         eBKYNopUXWfB0yONMJ2GibXAt5DnKXT3V+dTxEKw+y6YYTrWvFj3zlMgdmTgMNst31BU
         TaGGvezKO3cboP2TXD3bnS/gbHnKfZhhceuB+kY/RamgCnqcTL6W2b4RSVHZMxySAH7N
         3ZYA==
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
Subject: [PATCH 4.15 029/105] Drivers: hv: vmbus: Fix ring buffer signaling
Date: Tue, 27 Mar 2018 18:27:09 +0200
Message-Id: <20180327162759.139951217@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109457683723677?=
X-GMAIL-MSGID: =?utf-8?q?1596109651941780566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
