Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/6ImaU5ecch0fVw1A7GBj++szSb2IjDrv1+aiMqYOx3SekSCSGGusZlZacV6s0Ch/VtRai
ARC-Seal: i=1; a=rsa-sha256; t=1523473017; cv=none;
        d=google.com; s=arc-20160816;
        b=DoGB9PYYz36hrhF66RYwbhCbtGwsDPkCMZEuK0O1h+VGyS4n7X/pc3AE0eHqn4o7Ml
         fzd+zTg3F24rfC4ncavJVKJCiToFqYs4juK1C7gkQ9U3Rv6Ru3+3BEP9R3qTLI5aFuzv
         GMovJ7L/MTm3j0ihNSlcsaDydcR2zBAwCzdfvU6jPEqKlZIHNycSPoJanyTsMTHcwJOO
         LPEN1C42a9oN54oCryYpiADLxeCnCuAkDq2vnpXy4V3VjhheW8CUvHmNB8FAAwSayKl8
         j3nyuHD9QpvdQ0rLq6QIjvassHfmtDWmLav2vM3W9pDT5DtGbDd4NqPnftoLke/2IKNc
         jI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fKzUr8M3DqIbyIiaZbd3nLqDUCvRsMxJUCox5Je25C8=;
        b=gZCI5gQQ0bjqLveMsymPoRxZZRpT18lm2kOErBkE8XkexAeOA0lvZoooRR8lXJOKZL
         3k5lrbjNUcAn/Ch9BmMvf3R6No+I5lT0r439xuxwEP15kwn0l9vlvEIl2cQ8wMl09xhc
         0sZ/tG5NDXx/UIVXLv7XWl3SmBc6Y+zd12WOKs7eeU76v1B7L0jl45TQLvgB3MQvKMlS
         0IKxbIVWdWCtUT9sDht8J2tczkQMM9ITqMTbs5UHHvQ4oaeh2K4aYHTCy8mXDHKiWsfB
         shwSOktXD1w7aki0emblwWGqd5o+RQTB6t2NSXDQ5GT+bcdkjhx13m5W5jJqJ0yPeCt1
         RnvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 098/310] mlx5: fix bug reading rss_hash_type from CQE
Date: Wed, 11 Apr 2018 20:33:57 +0200
Message-Id: <20180411183626.439983579@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476675657679322?=
X-GMAIL-MSGID: =?utf-8?q?1597477242402701511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesper Dangaard Brouer <brouer@redhat.com>


[ Upstream commit 12e8b570e732eaa5eae3a2895ba3fbcf91bde2b4 ]

Masks for extracting part of the Completion Queue Entry (CQE)
field rss_hash_type was swapped, namely CQE_RSS_HTYPE_IP and
CQE_RSS_HTYPE_L4.

The bug resulted in setting skb->l4_hash, even-though the
rss_hash_type indicated that hash was NOT computed over the
L4 (UDP or TCP) part of the packet.

Added comments from the datasheet, to make it more clear what
these masks are selecting.

Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mlx5/device.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -750,8 +750,14 @@ enum {
 };
 
 enum {
-	CQE_RSS_HTYPE_IP	= 0x3 << 6,
-	CQE_RSS_HTYPE_L4	= 0x3 << 2,
+	CQE_RSS_HTYPE_IP	= 0x3 << 2,
+	/* cqe->rss_hash_type[3:2] - IP destination selected for hash
+	 * (00 = none,  01 = IPv4, 10 = IPv6, 11 = Reserved)
+	 */
+	CQE_RSS_HTYPE_L4	= 0x3 << 6,
+	/* cqe->rss_hash_type[7:6] - L4 destination selected for hash
+	 * (00 = none, 01 = TCP. 10 = UDP, 11 = IPSEC.SPI
+	 */
 };
 
 enum {
