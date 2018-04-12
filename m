Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AIpwx48NFWgE6rToPh2YfZhPIXxRd0RjMozWOFd7+2hdDszQH8t5nekoL4gkoMvERuDuW0s1WZQh
ARC-Seal: i=1; a=rsa-sha256; t=1523550235; cv=none;
        d=google.com; s=arc-20160816;
        b=SVEMmbU2/zj6/kTNOObfdElcE29VgF6H6UDemuEthFpZAITTUi3mJQUdGwHpUWymHi
         z3scvC5/mVGGOnG9dxt0tIxdcLfWYi6YRutZIxnHtIsUqNW5+6wiayUzhh6U5llmaJxl
         Oaa+I7EmX4L5RoA7IqZNc3LWn9av2BfghL9IfC1tiGsDi+9QdgaW6dM2cLEkFs1cPuAm
         ZaBrcaXejf640QsfwD8Mz/ZwjJc4vAIcT8RU38mFcZJF4CxMq4IndfDrYp0FQBAFj5Va
         toRrRVUCjGLnDPdCy/aMHgOtGYUAy+ZlBtiYINr6eED/ok7Cpip/zZcnh32S6DozVQss
         Bu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=u5jWAiFCAYjK5Cm6O97WvameGdlF2G3TE9Qeh5GBucc=;
        b=kXogGWNVcAL8B+O8y7WV33cKvue2qInJ7hsANEx4m4fM/YJMoLJbNAEk5C37b6/7nZ
         g640HUR2SBkTSrCEEm6CRWGIotiDTFvQyEEAnLz+/VX29jCE+3ge4QaKZDkcvX0hXVW1
         44yQP7TH5MoDYLA5EG06nstIIDy6u/j97vMKCuiQakjtq80y7kyt0czT5lvssktGzfEm
         UYMLOtN02FQmfWUVt/4SonLqqSv1zHcTgE2Lvw8NeKf295g0J34CxZlmgiUrb92SQlgo
         r1/ul5SVP406H5ozBW9xuDmL9RoK+qNXib2Z1fDdrGBtyUf3mwNzUybCArn7qcT9E8Py
         s6WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.45.133 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.45.133 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Date: Thu, 12 Apr 2018 11:23:51 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v3] staging: ks7010_sdio: fix NULL pointer dereference and
 memory leak
Message-ID: <20180412162351.GA6043@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f6f0q-002Qkb-SR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:60386
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597551056271378214?=
X-GMAIL-MSGID: =?utf-8?q?1597558211598966957?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

priv is being explicitly dereferenced when it is still null, when
jumping to goto label err_free_netdev, before it is properly
updated with a valid memory address.

Also, when this happens, memory allocated for netdev at line 854:
netdev = alloc_etherdev(sizeof(*priv)) is not being free'd before
return, hence there is a memory leak.

The current code looks a bit too complicated and can be replaced
by just directly freeing netdev before return.

Notice that card->priv = NULL isn't required because the next thing
we do to card is kfree(card).

Addresses-Coverity-ID: 1467844 ("Explicit null dereferenced")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v3:
 - Update subject and improve changelog.
 - Add Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>

Changes in v2:
 - Update subject and commit changelog.
 - Just directly free netdev. Thanks to Dan Carpenter for the feedback.

 drivers/staging/ks7010/ks7010_sdio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index b8f55a1..2c9b92c 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -932,8 +932,7 @@ static int ks7010_sdio_probe(struct sdio_func *func,
 	return 0;
 
  err_free_netdev:
-	free_netdev(priv->net_dev);
-	card->priv = NULL;
+	free_netdev(netdev);
  err_release_irq:
 	sdio_claim_host(func);
 	sdio_release_irq(func);
-- 
2.7.4
