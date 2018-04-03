Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753666AbeDCVq4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:46:56 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.109]:22762 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753478AbeDCVqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:46:54 -0400
Date: Tue, 3 Apr 2018 16:46:52 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Atul Gupta <atul.gupta@chelsio.com>, Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [crypto-chtls] Supicious code in chtls_io
Message-ID: <20180403214652.GA31283@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f3TlV-000xS4-Q0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:54006
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While doing some static analysis I came across the following piece of code at drivers/crypto/chelsio/chtls/chtls_io.c:1203:

1203                 if (!size)
1204                         break;
1205 
1206                 if (unlikely(ULP_SKB_CB(skb)->flags & ULPCB_FLAG_NO_APPEND))
1207                         push_frames_if_head(sk);
1208                 continue;
1209 
1210                 set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
1211         }


The issue is that in the code above, set_bit is never reached due to the 'continue' statement at line 1208.

I wonder if the actual intention of the code was something like this:

diff --git a/drivers/crypto/chelsio/chtls/chtls_io.c b/drivers/crypto/chelsio/chtls/chtls_io.c
index 5a75be4..a949a6c 100644
--- a/drivers/crypto/chelsio/chtls/chtls_io.c
+++ b/drivers/crypto/chelsio/chtls/chtls_io.c
@@ -1203,9 +1203,10 @@ int chtls_sendpage(struct sock *sk, struct page *page,
                if (!size)
                        break;
 
-               if (unlikely(ULP_SKB_CB(skb)->flags & ULPCB_FLAG_NO_APPEND))
+               if (unlikely(ULP_SKB_CB(skb)->flags & ULPCB_FLAG_NO_APPEND)) {
                        push_frames_if_head(sk);
-               continue;
+                       continue;
+               }
 
                set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
        }


What do you think?

I can send a proper patch for this.

Thanks
--
Gustavo
