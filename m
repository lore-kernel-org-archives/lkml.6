Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0F5C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A22C20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PffPLp0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A22C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbeGVXI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:08:58 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:40352 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbeGVXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:08:58 -0400
Received: by mail-wr1-f51.google.com with SMTP id t6-v6so16014718wrn.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2SaBC5n84Kb+Yv41u5Z/BYWHxhN3T2tp3vfgPQ5GLwc=;
        b=PffPLp0yxRHeYOZi5/0DYrapke6oj5pJOwGDkuVQYNELzQpyTCZi9JX+tq22x1f3qM
         af3tXUqvbVAhioaImO9TYQv/8+mGo2MkxGpvmQ+3JsPonjoy1XXmbDQGsCXsaERWZjAf
         bKYu0LIsr99jRHkNZkifbIAkKpzYhc4JcVUKXrVBlHl5p9kLvxNSc1GX2LgcMkhIvhsB
         0I70YN4iBAbDG7HbAr2xw9ZJzuMfriUD7F98mV9qopJ84yrYrVSiFDvzy4MAuI08lXUl
         yh1bqasehTCnGeKHSUFuoE01em+Ti6S2WEN/Rp9tPoN4/YxoBxggMfJxuNVUs1ut19qj
         f9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2SaBC5n84Kb+Yv41u5Z/BYWHxhN3T2tp3vfgPQ5GLwc=;
        b=GWBwoJmiYDYuh/W3fVKaCfpk+qmt9yJrhEcm+iDuF9KPfoYUuBUDaK4S1z2Wu7g2/m
         P5hMp/tGOkbM7R8IkICG5GfWyeDK4jyKlgeRTUyDJu6T321G315c7ZaFJbujNsje3TO8
         O1XuJEcBrgKUVm1fMOIcl/+wx/KYhKLMt00NDCTX+BQDXtXcn5liBr9ZPaizepVoINss
         4H2raiGGXP8r2ibIMFBBv9bZx4efUt6l73OpDAPpBVcxwG/w19kTYJLaqex2rijVALcN
         DCA+GpWuqqgpc3fe2eLVaRCxoDjRekEh0yS4pct1hBfIxhyqJbYTEGuA6f2r+IXKFu8e
         NQZA==
X-Gm-Message-State: AOUpUlHGMYWiOrC59teVRWRenE7u10wAU9WjOJ3nX7o+2+2L/0cdSLu/
        eP3aSDbRUhRe6ByiJXsc6lEqTp0oLbw=
X-Google-Smtp-Source: AAOMgpcEXy92noeDLadZGzELtNmyN6eNDFw34mb55ZkILCwkxsvyHDruU/E20bzKUFGS3z76Sl0BdA==
X-Received: by 2002:adf:e749:: with SMTP id c9-v6mr6807985wrn.143.1532297446669;
        Sun, 22 Jul 2018 15:10:46 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:10:45 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/20] staging:rtl8192u: Remove unused definitions - Style
Date:   Sun, 22 Jul 2018 23:10:15 +0100
Message-Id: <20180722221035.14453-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I went through this header file removing unused definitions, rather then
renaming them all. I know somebody went to the effort of entering these
definitions in the code, and it might be viewed as lazy simply to
removed the definitions rather then renaming them all, as they fail
the checkpatch CamelCase naming tests.

I'm afraid that this series has exploded to 20 separate patch files.
I was tempted to include all changes in a single patch file, as all
the changes are pretty much exactly the same, removal of unused
definitions, but that would have been one very long patch file
rather then 20 smaller patch files.

John Whitmore (20):
  staging:rtl8192u: Remove unused page 1 definitions - Style
  staging:rtl8192u: Remove unused page 8 definitions - Style
  staging:rtl8192u: Remove unused page 9 definitions - Style
  staging:rtl8192u: Remove unused page a definitions - Style
  staging:rtl8192u: Remove unused page c definitions - Style
  staging:rtl8192u: Removed unused page d definitions - Style
  staging:rtl8192u: Remove unused Zebra1 definitions - Style
  staging:rtl8192u: Remove unused Zebra4 definitions - Style
  staging:rtl8192u: Remove unused RTL8258 definitions - Style
  staging:rtl8192u: Remove unused page-1 Bit Masks - Style
  staging:rtl8192u: Remove unused page-8 Bit Mask definitions - Style
  staging:rtl8192u: Remove unused page-9 Bit Mask definitions - Style
  staging:rtl8192u: Remove unused page-a Bit Mask definitions - Style
  staging:rtl8192u: Remove unused page c Bit Mask definitions - Style
  staging:rtl8192u: Remove unused page d Bit Mask definitions - Style
  staging:rtl8192u: Remove unused page e Bit Mask definitions - Style
  staging:rtl8192u: Remove unused Rx Pseduo noise Bit Mask defs - Style
  staging:rtl8192u: Remove unused RF Zebra1 Bit Mask definitions - Style
  staging:rtl8192u: Remove unused Zebra4 bit mask definitions - Style
  staging:rtl8192u: Remove unused RTL8258 bit mask definitions - Style

 drivers/staging/rtl8192u/r819xU_phyreg.h | 735 +----------------------
 1 file changed, 1 insertion(+), 734 deletions(-)

-- 
2.18.0

