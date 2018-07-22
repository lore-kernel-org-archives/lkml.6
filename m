Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F30C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37602086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucFB66MV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37602086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbeGVXJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44460 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387791AbeGVXJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so16001147wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wxFmfzPEg58NdXawAgrX1Q1Cd/J7Osp01XkIo2ReziY=;
        b=ucFB66MV4dcgaCDbsVfM/RNtBf4sK6orTOuUcyvoeaWXmIl7yPKjhJ9hhTGGO+qJKG
         vQSw1eL+Xr+d7uCZg42qZsIW1cGwTHmuSS0FsKafKHgYrCynYXwObxE+m+DyopMIH0MG
         qzrZWq/Uvb2IN4qrvJq4QPx36s+w8xr5OgN5auVY4qIhn5NnmL1rEll9QCFtJ+PRaehp
         Xhd++S2TpfwIVQhrasgXFYHG618Df32mSJcE7HUGFiwhZWq8NaGvcrEUINV45ykpq27J
         jo4fSFjvIpbU7jwz545geKMWORZrJvpoBve51IPAB7eKBQCyVp7s5uvJB4QkMInrl2GX
         W0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wxFmfzPEg58NdXawAgrX1Q1Cd/J7Osp01XkIo2ReziY=;
        b=HdnCg3DKOjwhSKDDsXExFlEvSQhUcKi6eIMs6Hb7prcqW8x3oomff6nwqdI17FaQZz
         LJV2h3fWxQ3FKVQ7HO9EIzi+ZAllIrISC4x1AI3Vd2AlpmBh0S71z9tLn9VsSAil5uWW
         wHVMrsTEipYuhUpOgq9QePzord7DguFdIzp0u/qwfxzhKK7UgB+vOUnMea3oWo7RF7nx
         0zQ9RadH85VjzadYIVK+mUnkK9GkXdRY3YeqGtMfUkMFcSr4VpyiDIUwroE9OWxfSzfP
         X063js69VzetTXtQD5Rc/ET0WzCUw2wPBwQ3WqX7OMG+zAAsnPiEV1hTi7C1VVDFefWH
         b2pA==
X-Gm-Message-State: AOUpUlFJTysColsIsaiIDKnAl2V+RC2NwQKiSEGH7hUC2/fVl3VH5Mlx
        eCDebB7DSJrliL2MAu/3yNX03jE3E6E=
X-Google-Smtp-Source: AAOMgpdQ+4wEUgYNXa3TBDjY5TW0MUehLCk1eOVRl7V09ZO5/3EfRPZPXSHHYb5u9/vPyVXh/k1MLA==
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr6872590wrf.206.1532297465309;
        Sun, 22 Jul 2018 15:11:05 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:11:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/20] staging:rtl8192u: Remove unused page-8 Bit Mask definitions - Style
Date:   Sun, 22 Jul 2018 23:10:26 +0100
Message-Id: <20180722221035.14453-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused 'page-8' Bit Mask definitions. These definitions fail the
checkpatch CamelCase naming test, since they are unused in code they have
simply been removed from code, rather then renamed. This is a coding
style change which should not impact runtime code execution.
 * page-8
 */

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 114 -----------------------
 1 file changed, 114 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index fb0b388f6759..211f34359e43 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -108,131 +108,17 @@
  * page-8
  */
 #define bRFMOD						0x1
-#define bJapanMode				0x2
-#define bCCKTxSC					0x30
 #define bCCKEn						0x1000000
 #define bOFDMEn						0x2000000
-#define bOFDMRxADCPhase				0x10000
-#define bOFDMTxDACPhase				0x40000
-#define bXATxAGC					0x3f
 #define bXBTxAGC					0xf00
 #define bXCTxAGC					0xf000
-#define bXDTxAGC					0xf0000
-#define bPAStart					0xf0000000
-#define bTRStart					0x00f00000
-#define bRFStart					0x0000f000
-#define bBBStart					0x000000f0
-#define bBBCCKStart				0x0000000f
-#define bPAEnd						0xf     /* Reg0x814 */
-#define bTREnd						0x0f000000
-#define bRFEnd						0x000f0000
-#define bCCAMask					0x000000f0   /* T2R */
-#define bR2RCCAMask				0x00000f00
-#define bHSSI_R2TDelay				0xf8000000
-#define bHSSI_T2RDelay				0xf80000
-#define bContTxHSSI				0x400     /* chane gain at continue Tx */
-#define bIGFromCCK				0x200
-#define bAGCAddress				0x3f
-#define bRxHPTx						0x7000
-#define bRxHPT2R					0x38000
-#define bRxHPCCKIni				0xc0000
-#define bAGCTxCode				0xc00000
-#define bAGCRxCode				0x300000
 #define b3WireDataLength			0x800
 #define b3WireAddressLength			0x400
-#define b3WireRFPowerDown			0x1
-/* #define bHWSISelect				0x8 */
-#define b5GPAPEPolarity				0x40000000
-#define b2GPAPEPolarity				0x80000000
-#define bRFSW_TxDefaultAnt			0x3
-#define bRFSW_TxOptionAnt			0x30
-#define bRFSW_RxDefaultAnt			0x300
-#define bRFSW_RxOptionAnt			0x3000
-#define bRFSI_3WireData				0x1
-#define bRFSI_3WireClock			0x2
-#define bRFSI_3WireLoad				0x4
-#define bRFSI_3WireRW				0x8
-#define bRFSI_3Wire					0xf  /* 3-wire total control */
 #define bRFSI_RFENV				0x10
-#define bRFSI_TRSW				0x20
-#define bRFSI_TRSWB				0x40
-#define bRFSI_ANTSW				0x100
-#define bRFSI_ANTSWB				0x200
-#define bRFSI_PAPE					0x400
-#define bRFSI_PAPE5G				0x800
-#define bBandSelect					0x1
-#define bHTSIG2_GI					0x80
-#define bHTSIG2_Smoothing			0x01
-#define bHTSIG2_Sounding			0x02
-#define bHTSIG2_Aggreaton			0x08
-#define bHTSIG2_STBC				0x30
-#define bHTSIG2_AdvCoding			0x40
-#define bHTSIG2_NumOfHTLTF		0x300
-#define bHTSIG2_CRC8				0x3fc
-#define bHTSIG1_MCS				0x7f
-#define bHTSIG1_BandWidth			0x80
-#define bHTSIG1_HTLength			0xffff
-#define bLSIG_Rate					0xf
-#define bLSIG_Reserved				0x10
-#define bLSIG_Length				0x1fffe
-#define bLSIG_Parity					0x20
-#define bCCKRxPhase				0x4
 #define bLSSIReadAddress			0x3f000000   /* LSSI "Read" Address */
 #define bLSSIReadEdge				0x80000000   /* LSSI "Read" edge signal */
 #define bLSSIReadBackData			0xfff
-#define bLSSIReadOKFlag				0x1000
-#define bCCKSampleRate				0x8	/* 0: 44MHz, 1:88MHz */
-#define bRegulator0Standby			0x1
-#define bRegulatorPLLStandby			0x2
-#define bRegulator1Standby			0x4
-#define bPLLPowerUp				0x8
-#define bDPLLPowerUp				0x10
-#define bDA10PowerUp				0x20
-#define bAD7PowerUp				0x200
-#define bDA6PowerUp				0x2000
-#define bXtalPowerUp				0x4000
-#define b40MDClkPowerUP				0x8000
-#define bDA6DebugMode				0x20000
-#define bDA6Swing					0x380000
-#define bADClkPhase				0x4000000
-#define b80MClkDelay				0x18000000
-#define bAFEWatchDogEnable			0x20000000
 #define bXtalCap					0x0f000000
-#define bIntDifClkEnable			0x400
-#define bExtSigClkEnable			0x800
-#define bBandgapMbiasPowerUp		0x10000
-#define bAD11SHGain				0xc0000
-#define bAD11InputRange				0x700000
-#define bAD11OPCurrent				0x3800000
-#define bIPathLoopback				0x4000000
-#define bQPathLoopback				0x8000000
-#define bAFELoopback				0x10000000
-#define bDA10Swing				0x7e0
-#define bDA10Reverse				0x800
-#define bDAClkSource				0x1000
-#define bAD7InputRange				0x6000
-#define bAD7Gain					0x38000
-#define bAD7OutputCMMode			0x40000
-#define bAD7InputCMMode				0x380000
-#define bAD7Current					0xc00000
-#define bRegulatorAdjust			0x7000000
-#define bAD11PowerUpAtTx			0x1
-#define bDA10PSAtTx				0x10
-#define bAD11PowerUpAtRx			0x100
-#define bDA10PSAtRx				0x1000
-
-#define bCCKRxAGCFormat				0x200
-
-#define bPSDFFTSamplepPoint			0xc000
-#define bPSDAverageNum				0x3000
-#define bIQPathControl				0xc00
-#define bPSDFreq					0x3ff
-#define bPSDAntennaPath				0x30
-#define bPSDIQSwitch				0x40
-#define bPSDRxTrigger				0x400000
-#define bPSDTxTrigger				0x80000000
-#define bPSDSineToneScale			0x7f000000
-#define bPSDReport					0xffff
 
 /* page-9 */
 #define bOFDMTxSC				0x30000000
-- 
2.18.0

