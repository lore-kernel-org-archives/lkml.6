Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtWs+OazkvZGnSu7FleKUX5TU0eknmR3LqRbnn5j5bR0agrRzVkHRRzXGjNP9ZSZ/NC2C0a
ARC-Seal: i=1; a=rsa-sha256; t=1520451646; cv=none;
        d=google.com; s=arc-20160816;
        b=PfoO7LZB8BUwAtInv/1R2cNzyKE3n+gaNJ4ZAXuEtKHlk2O0r8f8EXUJzfOdwFFMfF
         cxLUrm+m4GMWVb573BvfXGIlpx9WBw38J67ydkPzc8LuNYhmc9UbvOsWH+rO0D5/ncYI
         7rlPyiivZ4KbiLRPH1TYRCrwanhE+iZm7Y72T1JOgdJIlYGwQObDg/UF5H7bFtlHGAvl
         9LYy4ONpn+YKa5N6VHmkY2PZ+GoRdcO+B9w07yX7Uk1W4FWko/6Jvb2/HjKAx1KIxzd1
         pBkOqKFqfvnqNvExRUKf9NdFazpTXKgCUjEYMmTlKdRSXLSxCTFkwxpUgIQwG6k0y4Qt
         oTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UEe9EzbdcU3MGnTGP9KrMTvFwHWHbU1FNdeb9vtvMr4=;
        b=mS/c792T/qTFQAW0XBoQFaKccqgIwGQvzo9T9Cmv4VM/QpYO/PfLA3Y9/FgieHxEfV
         e46mmDLYBnr/4vwJeUZftWrA/swMgNqnQ9IXvuCZQ8FnX6nGQzMSTOHnqR+rYATxi4FS
         RkycedZDGbTCAbAPexE2eSAUwF5o/GtKT7K7Oe52N25wotL7GfRO8Rvrs+NIvn13NQgo
         M4uVOiBvxx3bslzyEsHJmvp6rYGrfK7Vbp0AZ/+TEBzUTqUqq+yBbWdEQ1mGyDEPR+yn
         Q4lHxOuWtAxCtnJXCnDtyO7CLXe5rGhAHWoZZgzi5wx6fvWI+aRQpkTgn0J2IA8H8PLM
         QVkg==
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
Subject: [PATCH 4.15 007/122] ixgbe: fix crash in build_skb Rx code path
Date: Wed,  7 Mar 2018 11:36:59 -0800
Message-Id: <20180307191730.367590552@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309106047487634?=
X-GMAIL-MSGID: =?utf-8?q?1594309106047487634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1878,6 +1878,14 @@ static void ixgbe_dma_sync_frag(struct i
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
 
