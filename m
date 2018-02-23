Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvh0tezxpyp10eKKYUx07jHUkSrDDCnpxlNL+h22x5zColWp74rIxsAJL9vZEVfnlCSRC0/
ARC-Seal: i=1; a=rsa-sha256; t=1519410895; cv=none;
        d=google.com; s=arc-20160816;
        b=bEEQmLHMq4p6TquKrFgwmHuJ4vaNYgweXmTDB+Fw1Mkz8se+bo+9psEp1qFA9rBzuX
         GIVu3MfpEmX7yvh2Z8I5NlwDFQ1lzOMc3ua0W2QwF2BG0H3jnsA4reqN1z4OGDRyUDM3
         lpjl+WNm9QtQoFKgVGP/ijRkE+aMJ7xUbkpyH95iHYVjcn/NvyrfOCp5vwREpnuKpzz6
         1JaMzXDM/060r+OilTggJgq9YGez5BIpXHGa+SW9VqYCsfQvOP4M7vg29HxwiMyNwMRj
         C7akPh7TkJYSUEx5+fzBfbkk4UTpHamif7broJ7xfhdL2xA8AqOW5dcHVkK+VXuSq1EP
         AcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jh0U38cCoQjJu2IZncDFmTKoFM0+2W9vroPhz6vGAos=;
        b=Dgr/ALgPqJi+X53rsAynyk8FrMATRbuIfhMHd2S96PuF2SBiYs2Jl034B7sDkqW40D
         5ZSZ73OuZNaPoZght7YrFYbhPRsltcGMl4sX5NUqv4ROZyx2ZLfcK63MTVzei+v8Uzvj
         werXjDgkeEWB/UGCb4CjcTMacd+ejmnP3g5KDLIGxxMZEWW9uRcPu98jzrcHeUab5mrR
         /f+ARdXX7bQ8AaWQNURQ2QOEPny6wG0Cxvi9oBL+n3UrKvPgWguO388eq8fzVPyeGcfK
         hBeyqu35FUxlgqr/hQiu4Gy4NdeiLhYLHluRJQXY3WsxvEY02M3tVUWPTQOo9anZrp7h
         NDVQ==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 051/193] dmaengine: at_hdmac: fix potential NULL pointer dereference in atc_prep_dma_interleaved
Date: Fri, 23 Feb 2018 19:24:44 +0100
Message-Id: <20180223170334.016821770@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217798955458934?=
X-GMAIL-MSGID: =?utf-8?q?1593217798955458934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/at_hdmac.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -716,7 +716,7 @@ atc_prep_dma_interleaved(struct dma_chan
 			 unsigned long flags)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
-	struct data_chunk	*first = xt->sgl;
+	struct data_chunk	*first;
 	struct at_desc		*desc = NULL;
 	size_t			xfer_count;
 	unsigned int		dwidth;
@@ -728,6 +728,8 @@ atc_prep_dma_interleaved(struct dma_chan
 	if (unlikely(!xt || xt->numf != 1 || !xt->frame_size))
 		return NULL;
 
+	first = xt->sgl;
+
 	dev_info(chan2dev(chan),
 		 "%s: src=%pad, dest=%pad, numf=%d, frame_size=%d, flags=0x%lx\n",
 		__func__, &xt->src_start, &xt->dst_start, xt->numf,
