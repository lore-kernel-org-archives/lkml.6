Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225mi2IhQQzx4j13afnMWH+K5tf5//eU+cO66cts4VPMn6t62wCZ1lbnhodJrAXgc7TiFo+Z
ARC-Seal: i=1; a=rsa-sha256; t=1519411670; cv=none;
        d=google.com; s=arc-20160816;
        b=WKhcBW+6KP3ILjGOO/W2BMKh2G3dUsN5YcTie6ZEOo1zdANWtVzDWJQt51cniwaI+d
         pHQTDri07UfB/BWiLDayfh64Z1GBd8jJF413wZ48fGyZd95+PMeZybeg5l1FbHGwL+uB
         qay5UILTo+HLMCFA2UTtEr76pOdYMJeZNliSRL3oLpaGsMVrxsl3wCRgWBad74TK8a3n
         V14+pvVGrh/Uu9NkxQWyCX1TK22E92XNCRRv+HmD4bY7wBQK1P/rR0Q/f+0+qEijOMrh
         wF4XLLwKmnmhISNdtNJOUJYDO1T3XABPw6NNUZsHmPoz627AlgQs5WW50qb6LLAdTvLM
         qwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MHj6CcmN3VbpnUtEIUtMUlWwVwQl8uZbKViNlZ3xrZ4=;
        b=uNfa/DsLdOsCZw80a7ltUisGDqfMex+nJNjvy6/GxnvDiG0lnUmEpTFgG7RxB0BvAh
         Xru7oPZ7ot83eRbX+Kl8+5Vp6iq1V3Wh2NHkTR1CSykk7qbf2TD4MGi0MrJzPf5xuDO+
         y5fXQoupyUMTHzVcsGSDRz/jJ9z9qeDlUasNnYonRJLGFLxNR+oVKv0Nc7zg/MEy/i3v
         f7R7f8EmLePAFGZ/iaAZS4W0vSGNY7w39V+MTdLqzOR+BD7TEp0iQDW3IKaptDfoE9E0
         hamGvbAt5vyhYIzIP4NdmZOhAjmLur6Dh3ZWoTnsj7ASbiffzKKwRQQXCiWWt/u8Lg4M
         A1Cg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@163.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 086/145] hippi: Fix a Fix a possible sleep-in-atomic bug in rr_close
Date: Fri, 23 Feb 2018 19:26:32 +0100
Message-Id: <20180223170735.866387677@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217634600506830?=
X-GMAIL-MSGID: =?utf-8?q?1593218611423615847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@163.com>


[ Upstream commit 6e266610eb6553cfb7e7eb5d11914bd01509c406 ]

The driver may sleep under a spinlock.
The function call path is:
rr_close (acquire the spinlock)
  free_irq --> may sleep

To fix it, free_irq is moved to the place without holding the spinlock.

This bug is found by my static analysis tool(DSAC) and checked by my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hippi/rrunner.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -1381,8 +1381,8 @@ static int rr_close(struct net_device *d
 			    rrpriv->info_dma);
 	rrpriv->info = NULL;
 
-	free_irq(pdev->irq, dev);
 	spin_unlock_irqrestore(&rrpriv->lock, flags);
+	free_irq(pdev->irq, dev);
 
 	return 0;
 }
