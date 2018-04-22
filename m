Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48orb6BhHv15f831+IiNsLPJp56I1rbd3ZvmU0VTqVEUqy6I1VzdHGPG1Ly8mCAIHJM7na7
ARC-Seal: i=1; a=rsa-sha256; t=1524405868; cv=none;
        d=google.com; s=arc-20160816;
        b=bC0w/to+w8AubifC4x6QDO3Q04GrPKU1HMPP7iDDae3O7tCz8auT8LqkjS+eLUJAaN
         yfKF/yIjZsbr0qOdXah3NdjJiQem1mzG72tauNxg/MVjAIgGdP2npwwRKz/wgo4R4v7D
         WzPHsE+EGYIv6r92i59QdRz2juLJ5NQsWxoExO7yKkZtU2siX5aDzQ4kKszKywLTTgA2
         PcAOURGj+6f0lv7kKV85nlqkzc03xPmHTccEmzxYpP3LuMmVWXmMxjmnGLoa1cDACP04
         IF0f/VsSrpCVb8ZOH9djLF6DpV1DBgSfEaW3sB2YUnQgl1kzcvFoTzuz5MVgMrnpD7hS
         BiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9fCnPzrZx4V/TU7MwbH6LJFpR9yNY304mXZ/6X0RDtw=;
        b=LvS1P7SRI4tk9wjB8PNxXTfYOADu1MWxX09VW0k95UCAGwPyTg7JdvXiZ0uuKl3gjR
         GtANnMyocriU6olUHkYRqKKkHx3m8SQ2iXLaOS2UthrPDw/iIBYEUERt6tnK/UxBFElB
         1zPlNqabU/jAqUA65MDPWifBhAfr2UMIudirY9J8iYuboUdQpxIdp7ClIbpmcPzBch/C
         vV6rqPzFDPjxKU/jueDtKE5UisJT3zCcYIeJ7/XpitJoHTlg88gGmRA/8XMbPJoh+RCE
         WTE5zBGwZIln00k0JVRB5LQkPmcj7VJxHvTBIWb19usCM2VmtSVss/a6ZW0FQt+IlAE0
         owKg==
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
Subject: [PATCH 4.14 027/164] spi: Fix scatterlist elements size in spi_map_buf
Date: Sun, 22 Apr 2018 15:51:34 +0200
Message-Id: <20180422135136.517911377@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454848086177539?=
X-GMAIL-MSGID: =?utf-8?q?1598455407542348531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
