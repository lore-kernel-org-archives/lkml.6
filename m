Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA623C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE2B21A58
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYCjr4k3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE2B21A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeHQVji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:39:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41272 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbeHQVjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:39:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so7855785wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xQnkocKeccUlQ9YwtVh0jiCORT9iS18K2anh9FW5jUE=;
        b=lYCjr4k38GJV81UzRtQLs+gEyawfvBxMG2kWKmcqSUidDMNpDokBQ6p9Rzd/M3Rh0+
         5qP3skrpqivr6wf1vGPDvFBT+Zugloil6LdyaAECxxaNfBOkE1ZyzxH7EihiPpYz83V8
         h20dVUua109bbOJr0N5RxAECSgU0NsOljzLBF1IpPC17mmM17yr7NjM+l82P/anocOzq
         DAyb+PZrJGclulqT4B4CSwk8uxCz7I28bH1plORMp0MBsk/VNpK0mSOnRrhPIwtKK40K
         9KqFwLZxV6D4RwRbxlaN09cipeGmzrfNP0TeSprjfzexHTilBFR26mXRNlnZyjnFfZMw
         k6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xQnkocKeccUlQ9YwtVh0jiCORT9iS18K2anh9FW5jUE=;
        b=YyMg4wKiIimwDwYsUsn41WT513T+6jiMaK383/OaCdmsdo9aPRBkDVedFolNB1XYsM
         IA8LygDioPoEfWL2USxkaWhYLJl4SxjTFe6VWnxM9HChpgMfY60ZvDQT6T9f5GkM19yX
         rc5Vq58ZWgOsvFwxL9FXY1PkLM4KCFykB3hwq7jVKjDSfbJvxAtm2QeMVelRfpEXjXzR
         nQ/JB0f1LgjJVC/C9I5HTev+3rPknz7pI9cbYGqEB8hlVAxWOYLkwoSZCtQXpjq28rT1
         E66o5bgBtfqlOOpRNJawUUTBtT+eeVLesprx4sfxiG0E69c5bwLrrQHqOKlI0jvgoUIj
         8/fw==
X-Gm-Message-State: APzg51AS2PBVuVMS2HXL+ygeoxPwJq3OkOSAhPyu8wiYh/Dr7lrm3aEr
        5llQILF3Ys6tm6iSwHPupxZ+Uq+ldFY=
X-Google-Smtp-Source: ANB0VdbisiWtS+RHbH/K+ny3uBS6I1SRMpKBmtJSTwnYr8hz9oqq1N9iaocjkg+hFPTWMM16a71tdA==
X-Received: by 2002:adf:ee01:: with SMTP id y1-v6mr1462663wrn.63.1534530909239;
        Fri, 17 Aug 2018 11:35:09 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id z141-v6sm5399291wmc.3.2018.08.17.11.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 11:35:08 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/10] staging:rtl8192u: Removed commented out structure - Style
Date:   Fri, 17 Aug 2018 19:34:45 +0100
Message-Id: <20180817183447.15993-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817183447.15993-1-johnfwhitmore@gmail.com>
References: <20180817183447.15993-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two unions HT_CAPABILITY and HT_CAPABILITY_MACPARA have previously been
commented out of code. Since they are obviously not used in code and
the commented out unions add nothing to the code they have been removed.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   | 34 -------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 831a85bdbd2e..f63c028b900a 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -44,40 +44,6 @@ typedef enum _CHNLOP {
 	CHNLOP_SWCHNL = 3, // Software Channel switching in progress
 } CHNLOP, *PCHNLOP;
 
-/*
-typedef	union _HT_CAPABILITY{
-	u16	ShortData;
-	u8	CharData[2];
-	struct
-	{
-		u16	AdvCoding:1;
-		u16	ChlWidth:1;
-		u16	MimoPwrSave:2;
-		u16	GreenField:1;
-		u16	ShortGI20Mhz:1;
-		u16	ShortGI40Mhz:1;
-		u16	STBC:1;
-		u16	BeamForm:1;
-		u16	DelayBA:1;
-		u16	MaxAMSDUSize:1;
-		u16	DssCCk:1;
-		u16	PSMP:1;
-		u16	Rsvd:3;
-	}Field;
-}HT_CAPABILITY, *PHT_CAPABILITY;
-
-typedef	union _HT_CAPABILITY_MACPARA{
-	u8	ShortData;
-	u8	CharData[1];
-	struct
-	{
-		u8	MaxRxAMPDU:2;
-		u8	MPDUDensity:2;
-		u8	Rsvd:4;
-	}Field;
-}HT_CAPABILITY_MACPARA, *PHT_CAPABILITY_MACPARA;
-*/
-
 typedef	struct _HT_CAPABILITY_ELE {
 	//HT capability info
 	u8	AdvCoding:1;
-- 
2.18.0

