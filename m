Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AIpwx499OU4SwlFSN+fLgvrK+4FDmf5OtUtJruvBax6X5TxjEC4+3hDAA8F/J07FhsB60O4LYlqm
ARC-Seal: i=1; a=rsa-sha256; t=1523543411; cv=none;
        d=google.com; s=arc-20160816;
        b=jCL+FNIk5na8ANnkTIuGb7mED8CZskgAXWG5E7YQhOuRzwXngvxxdCfCVl4biK3gEL
         ONXmrH+Rmr6nfne8Qak1oL9yta6RxnUXgAT6t0bi0KLjmmXBn6tw7o0yOo7j/HtJxRhq
         2jZMoT5A5/nOaKJsYvhOJWLP6UsBoSw3N7HuxQh48vJ3CLDfElovi5XCHbIeEiLynEJC
         zRE7kT3KqWDJ9fJR53sdc/5oiaN5xXXgRc487E8LXdmdTxv75fW7uYcp2fnls0AIe6HD
         0OG9LRqTE3heSuWqSgILNafWa58KLoNUWLG9JEgUqxr5bok+GSqkQKF5jC5GL8t/ADdW
         XILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=Qp6X1snKzOtdleC9TPtbNfEXTTBTzIgbsqAgcdVWkOg=;
        b=sRA11UU70uND8TDdgkfT9KPwOL9h8l7VvSBAarjsacWPHe5X9upgO6Gy42hwF5PAnr
         U8loXuJn9rkl9pqhxZ+tJn+0ztiIk4LdogI2sLZFd3HXtwBsCA8fdIyjXO7aTdY3qnqO
         /NpgwjgEtzEuiSsaSLvhuD0MAvtPDacXID0yh0p44vvxpbElGEBVVVU2HNKiDvJbFLE7
         62W5uvYfBygb/+eqOV/vwVzamnpmy3a5Vrq26H1Iaj4G/tGYvSEHUdoyTLA1Yi2HbZI+
         +7huH8SDb7jA2QEp7UX9uRu/rWN5xVlKH6fepzxHpjCnB7pfV6wMuN0BrUzIR833GLkh
         JVPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.45.2 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.45.2 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Date: Thu, 12 Apr 2018 09:30:09 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] staging: ks7010_sdio: fix NULL pointer dereference and
 memory leak
Message-ID: <20180412143009.GA31998@embeddedor.com>
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
X-Exim-ID: 1f6dEo-000rdJ-NA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:59098
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597551056271378214?=
X-GMAIL-MSGID: =?utf-8?q?1597551056271378214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

priv is being dereferenced when it is still null, hence there is an
explicit null pointer dereference at line 935: free_netdev(priv->net_dev)

Also, memory allocated for netdev at line 854:
netdev = alloc_etherdev(sizeof(*priv));
is not being free'd, hence there is a memory leak.

Fix this by null checking priv before dererefencing it and free netdev
before return.

Addresses-Coverity-ID: 1467844 ("Explicit null dereferenced")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/staging/ks7010/ks7010_sdio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index b8f55a1..f5d4c62 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -932,8 +932,12 @@ static int ks7010_sdio_probe(struct sdio_func *func,
 	return 0;
 
  err_free_netdev:
-	free_netdev(priv->net_dev);
-	card->priv = NULL;
+	if (priv) {
+		free_netdev(priv->net_dev);
+		card->priv = NULL;
+	} else {
+		free_netdev(netdev);
+	}
  err_release_irq:
 	sdio_claim_host(func);
 	sdio_release_irq(func);
-- 
2.7.4
