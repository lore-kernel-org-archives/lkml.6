Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Z27GVccuVSD5x7r2I6+RcvjLaynaL26wajKz7zHDRBa3KYumWtqB4dUsMm3pobsoZQdrQ
ARC-Seal: i=1; a=rsa-sha256; t=1519410930; cv=none;
        d=google.com; s=arc-20160816;
        b=TlUJicGWBg/VAxYRhOmwBz4WXTTUZy9lRwhhjyp82zB0DQEr68NIkJYNaIYCA/9HTu
         Sgqb+WfCXwYnTeMywOp8hXx15dg3V87E1RBjWHJsL9PUOeNvG07wfyK+4xKoLRVAfDrv
         zb2E7z9vQqIqw1C8t55h5wesMFr4Si59ezjUSyhmbxUzlustLYcM8L7N1KEMZd4F3V4F
         NjszCYbpD8d92zJ0Gvu8G88E2kcKqe8vdtUsKfouDi22ZRd1ANQZNETwLUnotruijugH
         r/Js2N8cO3KHB4+TNPxSCTyWMxWfEAysEjKZ9hVTtiif/qClp0zkASwj7/0Xq8A9icLD
         drng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CsIW/rsj305XNcIknOIQ3kdqPwKvRlQiSsg2rMNWFpc=;
        b=PwAmsFaD9/gJ4AO8W6/vkl8sg7n+2FWIUyjKmOc0jJg89w8sieD60fLqWpkN1nTwgP
         et4yUAR+j4Qp9szigFA7lwIfJ9GjBzxi58fC6cK1LY7a+t4czBhHUS7PcOA+FmrAWqgr
         +aWiD7u1TFPIsNwtAhyZmWry+4MbfY+IHNwRAHBpSNjDhpVQn5l8Qdhp0Cafv3tG9DdK
         D4dqUbCsk3iqj8ae5XGe8BY6PztL9rjHCTkonZsQPdD77GsOEto+HlB0d61OIJY//Hzr
         8btJ/fXXZYc9DWNC6JzF9NQJT5bl6jHrz2FCCc00XIlW4sdIRO8i680ZYs/rZOvJCt4k
         Tt/A==
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
Subject: [PATCH 4.4 061/193] hippi: Fix a Fix a possible sleep-in-atomic bug in rr_close
Date: Fri, 23 Feb 2018 19:24:54 +0100
Message-Id: <20180223170335.529445145@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217634600506830?=
X-GMAIL-MSGID: =?utf-8?q?1593217835529655574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
