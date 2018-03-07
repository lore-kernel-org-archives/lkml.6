Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvmSVC37kq2ACDe8DTE+gnvxk4fM/JGTVFXhk9JlFm6fCAnTc8tZFP5L5vh+Kj1pztFV32S
ARC-Seal: i=1; a=rsa-sha256; t=1520451875; cv=none;
        d=google.com; s=arc-20160816;
        b=cdMO3AqoeeKKIGCa+m4+CnsaSmMYDDOYG0QOvpzc6LgH/f7gqMURSWKvYeAKQwGJZN
         w74YObhUDGpr7kJ6rtb1C2xRqCZLWjkgR3/jm2TkjOB/6tv+XHnoqGRz1IrO6ugJ/06l
         bGQLory46aP3yz/B3/aUEmaIpNEiHI11q15ci7zzBJhM4OdISzZ5NFwh4RZvyHJyZlzj
         0w3hE9RXIMBasjNYkawMdJ3VxfaQzsgAmlOk5FoNMFcsA1ayHJf89N1ePd7vwVNnPkB7
         nS8gey4L1TuFtI+N6IANWzkGL2Qp1IIx3dxaMjgBx6H9D2ajd7ufa/h+EETPU7rh2f30
         DuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=I4TPmzd4p1zqFkLpPQXf/+slIbiwZvbqSnBkLnAWleg=;
        b=v7Ox435f9tO0HFt96uHqRq/76Y226jwrgrYoeC6GDY6jG7L/gbQ8TqhUPojU5An9SX
         Ely0AOIOPI4FbsT3gQu8QrFw32ZBA30XhxfrMuOfU43xRLUVZeU/MIg3CiU485OOrlbj
         cysViFq8M0STQR3ntF8mXzQJmXa2yfwkpM5XeM8lDb1bIuPzm8cR/VgJDeoxkfzUIGXR
         CSBhklK/BlOJJcX4rgBAnMFDwFJ5XDmi2jfdOz9oRfSHED3jNHpF11fxMNJEPu6U4eIu
         UsAjozagBMWp1RlM+FXQnBiEwKnwOi7Uo5smouLuZhJKO3YrivqA1cuTGG2hc/LVNfpb
         T4zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ambarish Soman <asoman@redhat.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 002/110] ixgbe: fix crash in build_skb Rx code path
Date: Wed,  7 Mar 2018 11:37:45 -0800
Message-Id: <20180307191040.105461857@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309106047487634?=
X-GMAIL-MSGID: =?utf-8?q?1594309346461408449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emil Tantilov <emil.s.tantilov@intel.com>

commit 0c5661ecc5dd7ce296870a3eb7b62b1b280a5e89 upstream.

Add check for build_skb enabled ring in ixgbe_dma_sync_frag().
In that case &skb_shinfo(skb)->frags[0] may not always be set which
can lead to a crash. Instead we derive the page offset from skb->data.

Fixes: 42073d91a214 ("ixgbe: Have the CPU take ownership of the buffers sooner")
CC: stable <stable@vger.kernel.org>
Reported-by: Ambarish Soman <asoman@redhat.com>
Suggested-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1877,6 +1877,14 @@ static void ixgbe_dma_sync_frag(struct i
 				     ixgbe_rx_pg_size(rx_ring),
 				     DMA_FROM_DEVICE,
 				     IXGBE_RX_DMA_ATTR);
+	} else if (ring_uses_build_skb(rx_ring)) {
+		unsigned long offset = (unsigned long)(skb->data) & ~PAGE_MASK;
+
+		dma_sync_single_range_for_cpu(rx_ring->dev,
+					      IXGBE_CB(skb)->dma,
+					      offset,
+					      skb_headlen(skb),
+					      DMA_FROM_DEVICE);
 	} else {
 		struct skb_frag_struct *frag = &skb_shinfo(skb)->frags[0];
 
