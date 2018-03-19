Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsbM5wgM4rP/435eBO87PWudY9y/eudlk3SHFVXfaZeNOnATGLy+rM8sfZ8vuq5u0uBoQ+o
ARC-Seal: i=1; a=rsa-sha256; t=1521483755; cv=none;
        d=google.com; s=arc-20160816;
        b=JtsiwZLX1eO+4ZTF3ML4iQacEpUjwQASMUM743C8SRX7ec3t+KClfXYJb4xug7X9x1
         GaIRVl3Sc9YPJ+xcW/ysP3lG5wXR1IRjKTQ+u8FT0FaKpHJuWmgCmU1aQ5/jfM3B2n1e
         bQFuyXrnJuB38xnFEdilqK/lgaWKvjAQPxx3BLD6HqGSXwASFn+PPrsc6IIfTANEg9Q5
         lXrwQwZ5y8wHVs33Gm21Ww+YrYf5VV5y56+Unkm3502u8R2lrYONxm1ZGUxFyc0/SLR1
         l6VnQUP6XQSi6O1sKtBD5eOAKrApn+MC4AuhD67R6dlYp7v+gkmFsx/xMOHZ6Hch3FOw
         Fg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1zo7KIejlorsEtEYd70+2WqXFQiZqX1Ct23SS6OJydA=;
        b=RDUnzUGeTDdrE6m2iCzkw5mmRUGr0lhF/UTuwK7MPTF+LqyygbNryErno5lpzjHQUu
         8VawpeN8YWVDFSDN3ntuQngFCxP4ybsx02Mpyvbq9ggZAOLRdKQo/nbtnz8KqOcq6j7Q
         oh+2mq5rzAn3AgljRsTz0V97uzHKy94Su5bvnxNJHhV9oVHqJoenYalhA0d/cwDbDpAZ
         x1jZ81+BvdBXKQG2vKLu4ePcOwnBnlGHqTmoNEzx0Uq4it8JeIxL/Bql8BseWWRCrFOu
         sKr7iGBwsV7rA6YNaw167YUsXjmMfT2XYyPgSbp6gELAetxoUE3XVzZRRaYKowNEtHs0
         B3qA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 070/241] i40e/i40evf: Fix use after free in Rx cleanup path
Date: Mon, 19 Mar 2018 19:05:35 +0100
Message-Id: <20180319180754.100136355@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391350597402179?=
X-GMAIL-MSGID: =?utf-8?q?1595391350597402179?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Duyck <alexander.h.duyck@intel.com>


[ Upstream commit 741b8b832a57402380be79d7d11a59eaf57fff3b ]

We need to reset skb back to NULL when we have freed it in the Rx cleanup
path.  I found one spot where this wasn't occurring so this patch fixes it.

Change-ID: Iaca68934200732cd4a63eb0bd83b539c95f8c4dd
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |    1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1820,6 +1820,7 @@ static int i40e_clean_rx_irq(struct i40e
 		 */
 		if (unlikely(i40e_test_staterr(rx_desc, BIT(I40E_RXD_QW1_ERROR_SHIFT)))) {
 			dev_kfree_skb_any(skb);
+			skb = NULL;
 			continue;
 		}
 
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1262,6 +1262,7 @@ static int i40e_clean_rx_irq(struct i40e
 		 */
 		if (unlikely(i40e_test_staterr(rx_desc, BIT(I40E_RXD_QW1_ERROR_SHIFT)))) {
 			dev_kfree_skb_any(skb);
+			skb = NULL;
 			continue;
 		}
 
