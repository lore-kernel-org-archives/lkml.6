Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqcAb0zb6tKDfbWzkYZYZdJhKwCUgAPwudh+K3eXHxJAOTzK3x2jwB48tT7Oa3KG+zwXuEG
ARC-Seal: i=1; a=rsa-sha256; t=1526631741; cv=none;
        d=google.com; s=arc-20160816;
        b=Ht1JnfuuHHgh/b+NJkQwjbWLIbBQ3ZwOa99FvdHDm8lWSeqWkHS5ytrHQV+kIr5+1L
         PIoOtwt0n7hKnekpr1t8DdamUmK+zeoc3X6obd2ir6XoT4bFUdxRHqfT7/byahQ8ZX4I
         r8/jnJt8Xy+S7QuHX/cxB42Kvr4bFQyxnmeYBxRsDyjVx06IIJiRzz53eyDGWQGWzTIR
         ku0VIACmCK1tToOTmQt2C++CahseqxioqXzmK0KpfXuXuczX6xT+0QUe3P3W12hlNWf8
         vCNe+yJkdJTUAHn/NzA2OzuMFmjt//67KBUYNXf3l+b/YBhwxlqVwxEKH9r9xsx7ATMl
         OrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=P6iEPdSOo2Lb8vOLl18jIk4vOuKhbQR5nFzYuTVuhBE=;
        b=RzLhB2YPyEglMqbbsQSHRvBfyqNR5jkxgcwKAWLOi6umEUiKJUa2dceym/hE6ysGRp
         /bLDZOMV9MaChgN48bfamFrMD6ci9j3jP0mf0l5DbeyxeDZwVNuZPa/ruwwiVVPQi7lP
         TPbkqegL93Bg/Z5kHGSntI2uNAzjt/f5Mo+nlpSUoDwEHUZU0X52D7VEvtVwb0lM0LHL
         oaq4F4/8Lb06loazxsnMenRNWe+BS6/6XO7PY/A0v4qXB/p8Rp6InMdK73cDFXut0N+n
         mokMZjbkureghXL1dCdvR8qqeYpA/eBIJFM1v/WAPjcmw0DUXUZZxwxrZ5cdWkyN51YF
         rNAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=O/sRWa/t;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=O/sRWa/t;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jakub Kicinski <jakub.kicinski@netronome.com>,
	Simon Horman <simon.horman@netronome.com>,
	"David S. Miller" <davem@davemloft.net>,
	Willy Tarreau <w@1wt.eu>
Subject: [PATCH 4.9 32/33] nfp: TX time stamp packets before HW doorbell is rung
Date: Fri, 18 May 2018 10:16:11 +0200
Message-Id: <20180518081536.408990662@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789404758011740?=
X-GMAIL-MSGID: =?utf-8?q?1600789404758011740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <jakub.kicinski@netronome.com>

commit 46f1c52e66dbc0d7a99f7c2a3c9debb497fe7b7b upstream.

TX completion may happen any time after HW queue was kicked.
We can't access the skb afterwards.  Move the time stamping
before ringing the doorbell.

Fixes: 4c3523623dc0 ("net: add driver for Netronome NFP4000/NFP6000 NIC VFs")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -854,6 +854,8 @@ static int nfp_net_tx(struct sk_buff *sk
 
 	netdev_tx_sent_queue(nd_q, txbuf->real_len);
 
+	skb_tx_timestamp(skb);
+
 	tx_ring->wr_p += nr_frags + 1;
 	if (nfp_net_tx_ring_should_stop(tx_ring))
 		nfp_net_tx_ring_stop(nd_q, tx_ring);
@@ -866,8 +868,6 @@ static int nfp_net_tx(struct sk_buff *sk
 		tx_ring->wr_ptr_add = 0;
 	}
 
-	skb_tx_timestamp(skb);
-
 	return NETDEV_TX_OK;
 
 err_unmap:
