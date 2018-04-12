Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AIpwx48Iyg+ASnPbCuOxVOYIkOka1eiTOR/pg7NA6EXjJNR1gWm0uQC5laOg76g5fm9jty6m9vFZ
ARC-Seal: i=1; a=rsa-sha256; t=1523546624; cv=none;
        d=google.com; s=arc-20160816;
        b=cKWkgsoUU58bthCPF2kUDU6t2URWHoEAvCO9w/SJc4fdWYdCKwh8P6sfsajELcTjEa
         /2AgCxJS/8TMOphKevP21WSXXiUlGznLfp3dNvJFlxBeGIiv0iFG+uh0JsviBcEkRCer
         KGjwLc4r8CCgwUX6VHXR9h6u8uGJ9B77UGRWeCeyYahLvysmJ4mKIozlsGSRhSc/+N1o
         8CxpODrK2ARCfTv6jjng0cfg93tnKfTe7tk+4oexkWSJCowyhgNEey6igdYuD+QGW2g0
         1zUkY+1jThFr+KUaRuF2R73QPDfTkFHSF39JZOMgMsSNREbWVCk+s9FpZNkMy0M1BWD7
         9iEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=IAPIPb/sEZFV6LlUuSVoJnCl5GQTnJJTmuaYg7HNwBI=;
        b=xIDh/TYXydB0+BrlNQNXEFy5G7lu6BMyqMjJHvxYIU3yVh1DSA81Hm7NixqhwpEFj5
         GkgrEIaTcnnKmA/HGo3MnvrKO99DsSqffdryXLuDdkVYz0RGi1fzBzYd6C69BF7+iBSj
         Zn9K0r1AI0tsHk4f7FltwxpnNjwRO9zSlo+FYyzRLpF4fMOO2aMLygSaJxBLq2eWBaJQ
         OEM3Jr25KStEmH8ZPCtDQW0sA/Jv1ZRzxdhqVasg0oIUZq4O1lZNlEDzNT3Q91VOMBjk
         oZvT6czF7FjpIolbs5fc7Ijp+v1GrY+rcVt9O4OucAw7ZdXX4um6pdzpjQtJ2cwbOszw
         CG/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.46.156 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.46.156 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Date: Thu, 12 Apr 2018 10:23:42 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	Colin King <colin.king@canonical.com>
Subject: [PATCH v2] staging: ks7010_sdio: fix memory leak
Message-ID: <20180412152342.GA4040@embeddedor.com>
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
X-Exim-ID: 1f6e4d-001c5D-VV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:59608
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597554425756746355?=
X-GMAIL-MSGID: =?utf-8?q?1597554425756746355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Memory allocated for netdev at line 854:
netdev = alloc_etherdev(sizeof(*priv));
is not being free'd before return, hence
there is a memory leak.

Fix this by freeing netdev before return.

Addresses-Coverity-ID: 1467844
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
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
