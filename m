Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu59ZH/57r+iSsOKH/6u+oNPSYqiBOtw1jy0DTDclSzmkpyVQPne6TqFb/D74/9DTWN6y4a
ARC-Seal: i=1; a=rsa-sha256; t=1521800369; cv=none;
        d=google.com; s=arc-20160816;
        b=Cqc5mD4n7qOUT29Y3aK4JQhKAo8ERk/Fe/F7fV5Dxo1BDL+7zPdnbeLS9DoP0PYKHQ
         ZJDKn/QfkUew09f1sf/K5iBFByUVzC5vbhwdVaSKHV/e8CZZclQBaUI774LGVIJZEZhf
         MwEu6u8u+/GvKIjxe4tD2dcLrDcJm5Ui+oVk5Jx4ZVXbDCDO7o45GEW9p4Nq9WGmVtIo
         UopclqBSFBebPWU4UOlvkCnkojnnX8HU5/W4duYEx1EIHD3vRVQraG5JyEgz3914EtP6
         oaaL2z5b8ISk8vfQu8ebLmEkWjMkyaeqZx6WEm3HmTRKynLFOm7r7NP3JqndU62Kjb5H
         u92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RUft/AX6oBv8yIog+OZQnfU+yOz9RPEn22QI8wFJRWc=;
        b=IzIu9NDWd+2fUQE0d4H0FMmhV37SmCzhuZdOmGGcx5DKuO+KPVredpkkToGuwNkBum
         mWLzizHA7OAL0Cr5pIatbl4yjrBTjlRLcvmqB6iZEBzBVPI3XrigjLa19N08y4fQwigF
         lFk9wJ6zpjjrEfu75WCcOp+EuT+IoF0KfGVBBIOJHcuYcN+MxjA6xTXejqv2DVp2+YL8
         WeKZO4H7uUkPhfnJ9YBXkygVheBwpBqKCx6mFKpsb2WPuKdZ8X+TnNIhZn8ni0iEXWrD
         tMjjV9UKQjcUSz914R6AcHosmsif6BJDsk1VO+fb2i5QOQs74SzxwsuBCnJJbGtU1xQY
         Xi2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Sebastian Reichel <sre@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 18/47] HSI: ssi_protocol: double free in ssip_pn_xmit()
Date: Fri, 23 Mar 2018 10:55:09 +0100
Message-Id: <20180323094248.911903421@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722535115066459?=
X-GMAIL-MSGID: =?utf-8?q?1595723343660320023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 3026050179a3a9a6f5c892c414b5e36ecf092081 ]

If skb_pad() fails then it frees skb and we don't need to free it again
at the end of the function.

Fixes: dc7bf5d7 ("HSI: Introduce driver for SSI Protocol")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hsi/clients/ssi_protocol.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -976,7 +976,7 @@ static int ssip_pn_xmit(struct sk_buff *
 		goto drop;
 	/* Pad to 32-bits - FIXME: Revisit*/
 	if ((skb->len & 3) && skb_pad(skb, 4 - (skb->len & 3)))
-		goto drop;
+		goto inc_dropped;
 
 	/*
 	 * Modem sends Phonet messages over SSI with its own endianess...
@@ -1028,8 +1028,9 @@ static int ssip_pn_xmit(struct sk_buff *
 drop2:
 	hsi_free_msg(msg);
 drop:
-	dev->stats.tx_dropped++;
 	dev_kfree_skb(skb);
+inc_dropped:
+	dev->stats.tx_dropped++;
 
 	return 0;
 }
