Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399D9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB01620880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euZp39BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB01620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbeGWVxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:53:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50453 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388158AbeGWVxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:53:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so430577wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yxAJ3ABdSeq6i7uH13bkzcddYmODSSYSeZW1w5ak9/c=;
        b=euZp39BXiGAjj3QkGwlyGYWSvFkzkIvVj2NiRyTRqc3wJa2nYW5arGpcXREnVj+Ql2
         0IcxgnUZtFUxQ3g9fgnNbQRvhPNZBmiZt2KfIjnRXkdlJxJqugN9p2JRrmmlKHnqTv7H
         cVBrKmzz4TFOk2nTs4jYPYRRemRs8ALz7SYct/gvDj2T5eMg8Uo6Ip8pV3BcQ168fW31
         N07t8EPAUxHRzQURwvgGL6li6Dk8teiXr8snR1UJoZmXl0rt6nlvW2G0IyGm4TqdQ+xM
         X+raGRNz0j+pybU8IF/SYjqC9AF/xmigbujWl7S2iSl3IwnhLlAVJkH0FhnN5p6tyLFZ
         q3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yxAJ3ABdSeq6i7uH13bkzcddYmODSSYSeZW1w5ak9/c=;
        b=c96dVZ77IsP2gbXp2EFlQS1Fak/D9G0PKGOtAZ3OtM2OxvrVI/paaxYBjJjLLpPyu5
         DhSbQApJxtwEKM2eI9zWqrBZjT266W2eVfk2ePz1x3Xvp+YfmzmUiyzshJPqMSn5jdeo
         wLWRjTO+lwus9sjRlyFQisH3uM/bpH5m5aQ/AiivF3OZxUF1UuDmsTd2sq8hV77gbDgA
         OAAn6enkcMtapmW47/y1ma1Lh+bp+IvPGfiVAvdrfQe8UAFGrDsuWGd+8y14BSX+G6/3
         n9+b4+qDQWbk0UnDoW2rDzA3ZCVyYmGVAuKxwmlvuPO2fIvxgohI2qUZONBqpW7YHOc7
         b37A==
X-Gm-Message-State: AOUpUlGFiEqiPpOxqPwNtlSw+4MB28nDB3VomhtKure+iPK+tBeG3zFA
        B/1WroUUA2A3NYZNZZq3r7i4Yfwc
X-Google-Smtp-Source: AAOMgpda6OdL3sGgnsXN0wDvyFJktcCNtk9Rbdyv6QpOPF5B/wjDxb0JXQJs5z2dU7q3j57HLRFpnQ==
X-Received: by 2002:a1c:f017:: with SMTP id a23-v6mr312259wmb.160.1532379049976;
        Mon, 23 Jul 2018 13:50:49 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:50:49 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/15] staging:rtl8192u: Removed unused structure BSS_QOS - Style
Date:   Mon, 23 Jul 2018 21:50:20 +0100
Message-Id: <20180723205031.19816-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure BSS_QOS is not used in code so has simply been removed. The
change is a coding style change and should not impact runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index a83abaf3a2ea..d202244b8cac 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -468,25 +468,6 @@ typedef struct _STA_QOS {
 
 } STA_QOS, *PSTA_QOS;
 
-//
-// BSS QOS data.
-// Ref: BssDscr in 8185 code. [def. in BssDscr.h]
-//
-typedef struct _BSS_QOS {
-	u32		        bdQoSMode;    // QOS_MODE
-
-	u8			bdWMMIEBuf[MAX_WMMELE_LENGTH];
-	u8		*bdWMMIE;
-
-	QOS_ELE_SUBTYPE		EleSubType;
-
-	u8			*pWMMInfoEle;
-	u8			*pWMMParamEle;
-
-	QOS_INFO_FIELD		QosInfoField;
-	AC_PARAM		AcParameter[4];
-} BSS_QOS, *PBSS_QOS;
-
 //
 // Ref: sQoSCtlLng and QoSCtl definition in 8185 QoS code.
 //#define QoSCtl   ((	(Adapter->bRegQoS) && (Adapter->dot11QoS.QoSMode &(QOS_EDCA|QOS_HCCA))	  )  ?sQoSCtlLng:0)
-- 
2.18.0

