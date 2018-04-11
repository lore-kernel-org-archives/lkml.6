Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49jIDqaWJmMOtl3wC7ky2HYDWnSH/jUbUq8daUI9X3d+Lf/D/S7HMoP8XHOugKey1Flc+VC
ARC-Seal: i=1; a=rsa-sha256; t=1523473392; cv=none;
        d=google.com; s=arc-20160816;
        b=B8R5WwmdHEIVNu3SJT5IltBcTrjpZ5FdIwfWh4sgAKBdJMU6aMWvYL9Cltck76nPar
         bxcIz8c4SeviL06J3Z4CV8mVnGXSy9aNb5xjFAbvTd8sPtkaRh+8eHJ4B383mUtzG3dP
         CRetr31Ql+nePTruBZpfTGIFesVX5/x24YFKDbWkcjGmXhlqEzlEXFqyoOFeWGGV3qCW
         viAQdPjVbviU5kpo+dbuMxwmz6HBd+JBTMBESBtoY8kFaRluWjb9lWMvmg2JtoDKXFdV
         iSyeCzH2w8QvNem+vfH83NC1JGIxIsPVjYX4JtfNlL4+4Jd010suulY351WLHRVieI4l
         NbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q60n4lQFH+u7bVozwoDxDmqPOoUf5VxAwfn1z64Rm6I=;
        b=ndmxC90drFJJdrkOqEJI/YWahuNrWh+a6SWSmztrJqhg0tparAivYUBjfH1zFspnLQ
         b+wlRjAIu9wGzSQgAxMM/GrVvIyjtnOv/6f3g03ksRdVDrO6OTDymyO8LJZLCUjx4PqM
         833Gta7FPyelDD1mGBQcqox52mdTASsc5AaCDWGrQ4TIbsH+8uk9bKGcKX8ibz3LrZJA
         EhgrptvVYE9tDIJfrfOgMmcqgw5bvlPcs1FdkOura2mFxWZp6/qJZ0IYP5me4Cnacs/M
         bDVhjb2q27qrBdWVxsE2NPOifCq38PrW+RD/lduEIRC0A/Q007Gije7DUMBHsPejsL2X
         xBig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 231/310] coresight: tmc: Configure DMA mask appropriately
Date: Wed, 11 Apr 2018 20:36:10 +0200
Message-Id: <20180411183632.445949814@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477636117481569?=
X-GMAIL-MSGID: =?utf-8?q?1597477636117481569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>


[ Upstream commit a3959c50b02f57df4c4e4f14f632220f1c0b1f79 ]

Before making any DMA API calls, the ETR driver should really be setting
its masks to ensure that DMA is possible. Especially since it can
address more than the 32-bit default mask set by the AMBA bus code.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -362,6 +362,13 @@ static int tmc_probe(struct amba_device
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.ops = &tmc_etr_cs_ops;
+		/*
+		 * ETR configuration uses a 40-bit AXI master in place of
+		 * the embedded SRAM of ETB/ETF.
+		 */
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+		if (ret)
+			goto out;
 	} else {
 		desc.type = CORESIGHT_DEV_TYPE_LINKSINK;
 		desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
