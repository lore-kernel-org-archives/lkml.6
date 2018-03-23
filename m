Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuJOLT2hR48GD9Nc+8YmAnliyiAiGO7kzkwCYP2QHDMktIlj6KdvriLTW0lONBjq46hKkU4
ARC-Seal: i=1; a=rsa-sha256; t=1521800237; cv=none;
        d=google.com; s=arc-20160816;
        b=mLCppugU+XE7bk3HTqDS7HZCJZ9+Mwo9eaFt2Rwrh3pmuNSUta6XUGyeT8Pk7DoH0D
         jjPCc60aTl572BEhPiENSV9c14if290/TTCsev6iQsyeruTuy2k//qXoYEU/9kE8NoY5
         umnblZ1Ao6cP8IN5pAe5s1mQ6MMvs0+qUnTw5eyT9Qjyto2cTz04lxaRWatcfGtBJ2sM
         +6S2Fk/mW6XToPXBFMV81Kyc28VKnmj5+aAEbRRdc9X8PFO5P91+0bAIBu5yd2QnUt6b
         jflc5VofMjc3ws6aGIGR0T9WEurjTo5gFQy43Hd0cjnv5VcRN54eid6HcAKvctU47osw
         KNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KF/TP/iSL3stfNQaaU2NGhHia4Bh4Vn6rVFPMrcXB/Q=;
        b=HFXbFfup55BojGjAvu0MVJkL3WcoNJhBb1lgpP4znNGD3g9QhrNV9q00MiQ0lcSzAL
         QU1I3Cm6sNM9cfqDMiqX8xSY/Vyk3iBUZb/AE7EUV2k5cBpiGII9UfVFX8QFMu+TI4Fa
         MGBuWi5ikYIcOZQ111nByfRCchqF7Sd3ATE54K6V5m8pVkUtRVO16Q/lFPq6wpXqNI9L
         ZdldmM4kSS9jbkp4dCmsoRHorb1IMV+zcu3V6NKCXpu5lsHhmkBLWBcJUdyztZftRBEf
         KOcJQ4SGWW03Sp1AAnSVaxpD3kdjZJAPlUBuZE4kmom7RPDFuB6qKWnGun99m55saPHg
         ZP2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vignesh R <vigneshr@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 96/97] dmaengine: ti-dma-crossbar: Fix event mapping for TPCC_EVT_MUX_60_63
Date: Fri, 23 Mar 2018 10:55:23 +0100
Message-Id: <20180323094202.830273372@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722074932352667?=
X-GMAIL-MSGID: =?utf-8?q?1595723205726982660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh R <vigneshr@ti.com>


[ Upstream commit d087f15786021a9605b20f4c678312510be4cac1 ]

Register layout of a typical TPCC_EVT_MUX_M_N register is such that the
lowest numbered event is at the lowest byte address and highest numbered
event at highest byte address. But TPCC_EVT_MUX_60_63 register layout is
different,  in that the lowest numbered event is at the highest address
and highest numbered event is at the lowest address. Therefore, modify
ti_am335x_xbar_write() to handle TPCC_EVT_MUX_60_63 register
accordingly.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/ti-dma-crossbar.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -51,7 +51,15 @@ struct ti_am335x_xbar_map {
 
 static inline void ti_am335x_xbar_write(void __iomem *iomem, int event, u8 val)
 {
-	writeb_relaxed(val, iomem + event);
+	/*
+	 * TPCC_EVT_MUX_60_63 register layout is different than the
+	 * rest, in the sense, that event 63 is mapped to lowest byte
+	 * and event 60 is mapped to highest, handle it separately.
+	 */
+	if (event >= 60 && event <= 63)
+		writeb_relaxed(val, iomem + (63 - event % 4));
+	else
+		writeb_relaxed(val, iomem + event);
 }
 
 static void ti_am335x_xbar_free(struct device *dev, void *route_data)
