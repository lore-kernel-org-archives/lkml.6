Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/wDMJOih2jnU7fkMx7saWxzro6QE1GBVw728HMdKGq/9SMeSBTwto0UVbFOJKq/TuiiMA+
ARC-Seal: i=1; a=rsa-sha256; t=1524405334; cv=none;
        d=google.com; s=arc-20160816;
        b=szIROOV/2PYQfF7Zf/FlTlcSioTOPGPSgFkfMjAowx6dTGheRJRdGChSY/MlGEuOZG
         FWnDPthIeS9SF8N+C+a9Ihgh65qWQnsSc1uooPFdpwbZIIttRtqGSAEE5mxVsdU3Uryk
         EmqWmvt4l8JhcAr+dTg/jh82VkE7l8IGUM13FvOWevAQvq9iBv87wSiCbw6Jl6Zqb8pD
         edFadtpenxbH1Y5cDSbvCSBw914K8Z4wAdirJXb3xGsXyIbDy4mUD7psndayyn72c8lM
         6ic4rvOl7cRoEmVwUt6vvzDCyKEytLGmovGOdzkoEX9HLfljIKLvTDt9qIsvt+biPA9V
         rGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A5YpgiGzMFTrcHNQ07lOFbSk8oB5LNOHs2swNqlmlNI=;
        b=HBlHuvL+wPBxKN11Kcx6ZYqiuboPG/2N2i5vBGVbcx25Rx1HiBhRHOfBJfnm7PtPt9
         rRIUe6MSas9t6Y+iShcKdoOhEquEVT2Y2bvPhCQiPAuMI0doJe4fZsUT020UdHFCdTZV
         vQETnZE1/z91H3iNABqGNlQoDKHGuN6AX86x/WHsEodcnN9uUKUdMPGkWFxwZKK5eTz5
         VuTE3TssofuUPujLdpJ6GU++kIc8vqj88+wfvmBh+CR0kqrw6nT2JZknE+DebLfJrWkZ
         DlalDBB1B52aBdGhDHZWPZVUi5z3iReT6IGtk8RUiBo+FxR7trAbAPb4JJ/YgFWlbEOe
         6PpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.16 028/196] spi: Fix scatterlist elements size in spi_map_buf
Date: Sun, 22 Apr 2018 15:50:48 +0200
Message-Id: <20180422135105.580069686@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454848086177539?=
X-GMAIL-MSGID: =?utf-8?q?1598454848086177539?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

commit ce99319a182fe766be67f96338386f3ec73e321c upstream.

When SPI transfers can be offloaded using DMA, the SPI core need to
build a scatterlist to make sure that the buffer to be transferred is
dma-able.

This patch fixes the scatterlist entry size computation in the case
where the maximum acceptable scatterlist entry supported by the DMA
controller is less than PAGE_SIZE, when the buffer is vmalloced.

For each entry, the actual size is given by the minimum between the
desc_len (which is the max buffer size supported by the DMA controller)
and the remaining buffer length until we cross a page boundary.

Fixes: 65598c13fd66 ("spi: Fix per-page mapping of unaligned vmalloc-ed buffer")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -779,8 +779,14 @@ static int spi_map_buf(struct spi_contro
 	for (i = 0; i < sgs; i++) {
 
 		if (vmalloced_buf || kmap_buf) {
-			min = min_t(size_t,
-				    len, desc_len - offset_in_page(buf));
+			/*
+			 * Next scatterlist entry size is the minimum between
+			 * the desc_len and the remaining buffer length that
+			 * fits in a page.
+			 */
+			min = min_t(size_t, desc_len,
+				    min_t(size_t, len,
+					  PAGE_SIZE - offset_in_page(buf)));
 			if (vmalloced_buf)
 				vm_page = vmalloc_to_page(buf);
 			else
