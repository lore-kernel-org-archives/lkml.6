Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48/FqQA/d7mz5gaH70tzKTgFCLlrnlOitrCPSJAGTli8Amk5HHHuPvpDIkvnspJGOJ3ZTj5
ARC-Seal: i=1; a=rsa-sha256; t=1524406284; cv=none;
        d=google.com; s=arc-20160816;
        b=OcUYGYRobMtW6wprjFuAdlMPr8ibYTXZjpY/03psXjtPjcABZZxnqkOcfvjRtoJNkc
         LEYHcBrECLO6RZcid9j4yfw0l0aaUwbIuOx3D33SI0+WGUEkRV9zwmwTNOoLikumZ6KB
         f3r7POXE3Njv6hkfcesPo7+UZ6ThJLSJLpmE6yGfPBNOaXKuL4AIVryErwjwxGsHQ0gZ
         KTmKiczyWcsFCalDmi66pFVGaE3ODDPWPNOEeQ3TF6o1M/PzcNnwn0nl+ZSSyNOOuEVB
         weu6X8pIc/VczFh1EMpIFbh05NiZxOdJuTzb2isQgNbhDc10OrEamNgKlfpQDSA1Q+N0
         JiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=my4zcBbOpg0uKROexVc7tfCFsxN9Ayk0eAv0jIcAtgU=;
        b=c9Fk6TT+b4BcG0QTjDg6N0L0vftKRnnGK8Ts5RFKZopwkrkzMZhYtnQCwPsvGxBcSj
         8FQb1qDuFTcP3gCz7UAIQ+LK6czaEvwfOeWx24GTe1OOGr1HH2It2/OH25zDmIRbOoSw
         +XirJ3Ah0xTfIyiG79ticYpNTzbVX6YGFlurH3/fFAVBbsxXsqdKE12fU59G1CpUglRv
         aRShLun8nSvkWKwj2ypDZN6bGQVtHyntaKHXSaiJnCKJ0nd9r2XQ0MXunQjYshvo1Xo1
         ba3iGcdlrYxWtrXkbt0gWHuYMbV4X6hJ7qjgZPSD0m5UC8u2IT0kdhpLcKZZbJkep0Ic
         VlkQ==
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
Subject: [PATCH 4.9 15/95] spi: Fix scatterlist elements size in spi_map_buf
Date: Sun, 22 Apr 2018 15:52:44 +0200
Message-Id: <20180422135211.060960284@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454848086177539?=
X-GMAIL-MSGID: =?utf-8?q?1598455844131340111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -743,8 +743,14 @@ static int spi_map_buf(struct spi_master
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
