Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpbIG0Rpk6qZ0GYlVn6OsFtRjyq3ksanEzacBzfWC9Ps6615BqQoJjFN9y1ZwXBxEunNK5Y
ARC-Seal: i=1; a=rsa-sha256; t=1526631646; cv=none;
        d=google.com; s=arc-20160816;
        b=V5lRqSPXjrlGmxgG+ZXTT/4ZkTWO6xZWjBrjglc85mJcPOpvMNfxzcMZx50RRQiJQ5
         Xew8CQEPOXhsY+ulJf1AY9Hob19hx5dh/2GUQltPBS8rds4jpo6XGnlVuKqundFO93rM
         vAC3QimQCTKzjB2ro9QZr6WXpfcB6zeea2N3l8slr4FiWLbI7lUG1K3awfmwc5H8a7i4
         IR5suztnDCIlFSYQbRqk/c4sn5cPY0p4LAJeAGiL0lAW9lK8GTWv9A7UgmDuiQJGxl4j
         xqIZS0LPKvfmXLAgFTY2p/GxyBLT3gx/v4kbadZEXzzNGFYPrWRwaFfmYqV4r5t74DeF
         aEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mBUDAK4x1xQ8Z3DqX3xtrjdlWxYYGGy5XBf+P+qHr0A=;
        b=YK5tTQr9FbH9OM5v6Tb1oz4Qq94/yhjI7rHJq8pI+O+ezHRvwyXB/6kldsDxyIbZOl
         gRCkD4V7E2gNE+RgO4+bCj5VOM0GJsnNrGw8buiw5R1RVpLxu9aG/cPLnKHrGtJTiTxn
         lQ+i6kTZCBJ6rJq9z7Vn1YYF7Ntl35mHUwqlnd1AL5Kunsl6Kgi67M1IYBSc80xTkmyq
         woYhdj3rifPpszkOpQy7hB/JoWGy8P4OE/xCRSWjonnaf+TpZ7XYze4ee7qi2IHpS1rr
         tTsjC7jgtC7N8IDXIs9LG/PKMvClPC1o/FAfSS8HPKx1ND99INh5heeTZTcyIobHrg66
         f8Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=DPJT5/V6;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=DPJT5/V6;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Alistair Strachan <astrachan@google.com>
Subject: [PATCH 4.14 41/45] xfrm: Use __skb_queue_tail in xfrm_trans_queue
Date: Fri, 18 May 2018 10:15:58 +0200
Message-Id: <20180518081532.463671114@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789305167374817?=
X-GMAIL-MSGID: =?utf-8?q?1600789305167374817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit d16b46e4fd8bc6063624605f25b8c0835bb1fbe3 upstream.

We do not need locking in xfrm_trans_queue because it is designed
to use per-CPU buffers.  However, the original code incorrectly
used skb_queue_tail which takes the lock.  This patch switches
it to __skb_queue_tail instead.

Reported-and-tested-by: Artem Savkov <asavkov@redhat.com>
Fixes: acf568ee859f ("xfrm: Reinject transport-mode packets...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Alistair Strachan <astrachan@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_input.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -518,7 +518,7 @@ int xfrm_trans_queue(struct sk_buff *skb
 		return -ENOBUFS;
 
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
-	skb_queue_tail(&trans->queue, skb);
+	__skb_queue_tail(&trans->queue, skb);
 	tasklet_schedule(&trans->tasklet);
 	return 0;
 }
