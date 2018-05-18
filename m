Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrIlWEq32bcfKhZBbYECcssfc4vs0+6i5wBIHj1NjE0gwbUFotOG1qQK3Wn2fUchCcGvIb2
ARC-Seal: i=1; a=rsa-sha256; t=1526631432; cv=none;
        d=google.com; s=arc-20160816;
        b=Pbgg0hAtD73YHH7ExEE/VqBMVNABmsQ6YsHNvXVqJKNQAIaNJcyyc2Vq8EXJUHr53c
         hS5DsJvKVYolBd3IOn9/wUv+esDn6mVo22hkZIfA39+mIkYLw8ZNkF2PMjBBZOVlX9WM
         0fcM5wLXBmwEquLUz/tx/bQ7VaTsglXHvBgG0V6yVFxagvZoM923WzDWbPMOL7acBKyw
         XJJPjvNngMrspPDs0zFFlEJoY/ppp59sxsxT9Fe2fOhXatH1J52VF/PofApOuuhC6wLI
         QZO84YQGEqhFsntBM9KoiEWy/7r+s5+lCTM1vp8tFW77f5b6K9uUduV7pwLjl5bu6Nza
         8q8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=fRCE7k95KbYE0yqUZ2irr0usY2SXze/e+UWVyh5MYAs=;
        b=Ud4yHTA531uk24SdOvecn0OeqJxDyqTMgsN9xExkrj4x+s76nBd+dYkULDG6AwxHsQ
         ++cRb8wRHq5hSTorSAVI2ITlBN1nDCnSK40+gtbHLat/eABcOmt8C2D3fk2sKsO5wdU7
         oV0KbUM/04Ipe974hcV1kMb2mCJRSTt7FLeNGDkgrmg7ifDlRiovUzv1+K6OrUOQGsdB
         bjwXjB96SBsH2szA4jFp2Dqo5bCHdYwcFtMAy/ckp6sOVPp3LmMJiEH3oYScZNt7ayVC
         +2E2YqGQijTPYl6TYTTEM2wiFyGQV9WwzkNPqBdzqbsQOrzG7m5lW87+K3p92DFxZAG6
         yNNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0HpeI5ci;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0HpeI5ci;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rob Taglang <rob@taglang.io>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 07/55] net: ethernet: sun: niu set correct packet size in skb
Date: Fri, 18 May 2018 10:15:03 +0200
Message-Id: <20180518081457.724870892@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789080586007484?=
X-GMAIL-MSGID: =?utf-8?q?1600789080586007484?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Taglang <rob@taglang.io>

[ Upstream commit 14224923c3600bae2ac4dcae3bf0c3d4dc2812be ]

Currently, skb->len and skb->data_len are set to the page size, not
the packet size. This causes the frame check sequence to not be
located at the "end" of the packet resulting in ethernet frame check
errors. The driver does work currently, but stricter kernel facing
networking solutions like OpenVSwitch will drop these packets as
invalid.

These changes set the packet size correctly so that these errors no
longer occur. The length does not include the frame check sequence, so
that subtraction was removed.

Tested on Oracle/SUN Multithreaded 10-Gigabit Ethernet Network
Controller [108e:abcd] and validated in wireshark.

Signed-off-by: Rob Taglang <rob@taglang.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/sun/niu.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3443,7 +3443,7 @@ static int niu_process_rx_pkt(struct nap
 
 		len = (val & RCR_ENTRY_L2_LEN) >>
 			RCR_ENTRY_L2_LEN_SHIFT;
-		len -= ETH_FCS_LEN;
+		append_size = len + ETH_HLEN + ETH_FCS_LEN;
 
 		addr = (val & RCR_ENTRY_PKT_BUF_ADDR) <<
 			RCR_ENTRY_PKT_BUF_ADDR_SHIFT;
@@ -3453,7 +3453,6 @@ static int niu_process_rx_pkt(struct nap
 					 RCR_ENTRY_PKTBUFSZ_SHIFT];
 
 		off = addr & ~PAGE_MASK;
-		append_size = rcr_size;
 		if (num_rcr == 1) {
 			int ptype;
 
@@ -3466,7 +3465,7 @@ static int niu_process_rx_pkt(struct nap
 			else
 				skb_checksum_none_assert(skb);
 		} else if (!(val & RCR_ENTRY_MULTI))
-			append_size = len - skb->len;
+			append_size = append_size - skb->len;
 
 		niu_rx_skb_append(skb, page, off, append_size, rcr_size);
 		if ((page->index + rp->rbr_block_size) - rcr_size == addr) {
