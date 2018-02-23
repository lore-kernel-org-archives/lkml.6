Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227bdiDQTTc1buPGQ+hkTnY0UfhqJmSu0CO3Zq3PXId2puAh7lrLgX0yIqY9jfyeXQQZOtEY
ARC-Seal: i=1; a=rsa-sha256; t=1519412121; cv=none;
        d=google.com; s=arc-20160816;
        b=xzNuUvABtHprRIPHgoAO7wW7iKP0E4hpikKtHLDBQWcakKeUo9DXQASdaRB4XYEn8D
         XBczkTx9mXw3i1MTM3tTTi9r0PH3g36yiNUvjz0DqriaAY4JPORHwcaq5CEtrR6Vkmni
         GCtArmFxINGPc2Hvv9iVCQ1jFjS9+VhXZLwmHeuRVyQgBbsSdQTH3RYVru1LNXCBdwgu
         LNzSoa1jCtYdh6qknWN0w6TbAvs6URAphdTwkYgTs7naZ1V5BmmjIzQ75h28lML6Buy8
         /KrTphjuHAx2agg3dfF9cEQcx6Es+Jf+ns52de77aQGj1iw2Y6NuToKZaUg441VcFnp/
         fAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ktNh1WzeZLWYNDXdQETSzWmShxv6gflzzE1SWI5vUIY=;
        b=hLI1Q/6ZHyCRYg7X1QzFRyNa8FoeqC2rASLNZUqFaNz4dxVisxMJrytFw9WZPP/U0u
         +MC434RQXoRNfyS6QaK3FGswtSrQzne7o/Ct8TNKiblq7TYCyDFYkZlNj65Og5OWdgQ0
         0peyO3qj8Gy+TUGEpC/f32E0tSJ3FtfFT5SjIgdTHLTzQO3ClxzCRY9wxMsfa6KMYQze
         tQ3GVJGrLBnKs0tyuKc2ExZQ9kcGlmn9gmamz/L5OqFDHbAPnzQF+rOQweU+b4yXIfxd
         oSZAZVyI/oFTs9OJPAp0gt5kI/8x9kTB0YcjaRAvFKe5EmaH/+fursjoDIIHG15dCVRT
         cMVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 132/159] dmaengine: at_hdmac: fix potential NULL pointer dereference in atc_prep_dma_interleaved
Date: Fri, 23 Feb 2018 19:27:20 +0100
Message-Id: <20180223170759.079898794@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217798955458934?=
X-GMAIL-MSGID: =?utf-8?q?1593219085140624391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit 62a277d43d47e74972de44d33bd3763e31992414 ]

_xt_ is being dereferenced before it is null checked, hence there is a
potential null pointer dereference.

Fix this by moving the pointer dereference after _xt_ has been null
checked.

This issue was detected with the help of Coccinelle.

Fixes: 4483320e241c ("dmaengine: Use Pointer xt after NULL check.")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/at_hdmac.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -708,7 +708,7 @@ atc_prep_dma_interleaved(struct dma_chan
 			 unsigned long flags)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
-	struct data_chunk	*first = xt->sgl;
+	struct data_chunk	*first;
 	struct at_desc		*desc = NULL;
 	size_t			xfer_count;
 	unsigned int		dwidth;
@@ -720,6 +720,8 @@ atc_prep_dma_interleaved(struct dma_chan
 	if (unlikely(!xt || xt->numf != 1 || !xt->frame_size))
 		return NULL;
 
+	first = xt->sgl;
+
 	dev_info(chan2dev(chan),
 		 "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
 		__func__, &xt->src_start, &xt->dst_start, xt->numf,
