Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F27C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD063218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbeLTRvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:51:31 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:33998 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbeLTRvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:51:31 -0500
Received: by mail-pf1-f174.google.com with SMTP id h3so1281346pfg.1;
        Thu, 20 Dec 2018 09:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uuZUD8DKf9wMw7kKzDsb3tEKoZbWwbGFPv7d8THyQXA=;
        b=Q+ho4aaCtKsE5+NK9+XZpyMp/+3/4q0XPbNxnK0Tb6jybgMaf9V/NrQ8XO+hGqnDw6
         3M51xCis+khBpWzO+6j1ctwEyRHQmeqfjP9abTdmompeI2NtPW7NNEayTEPvMD2s0xor
         2vqTygICGrKWDoxj6ox4RMfbTF57W0oQn0QaVixgI0pSbYenN1Xf6jpmZSIeullKzzDB
         IRK84kUT5cVvT520UeNEss11CBYo5lhqSNyymyw/F4aDHkkScCnelGHCoRVYVaSelk9l
         WdKgAdzHp3TJetWxOuhTG7kJLrrP6jcg8ECOxW7E2UWCePbw/31xA1d2IXhvhTgENRIZ
         RGvw==
X-Gm-Message-State: AA+aEWZJsJV9kwfg8FspKgD07RvUtBucWMudpORUFl1ai+NogYgD+sfY
        ElgLEUKC/8puhqiiuAS3TjQscY9FPKU=
X-Google-Smtp-Source: AFSGD/UYGwP1iNpBZNF2oB6k/swxj4kf6pmMmrznjUDo3EYx+r1/NwdcB6QzAUru4OilYOuxDIDSdg==
X-Received: by 2002:a63:990a:: with SMTP id d10mr24106044pge.279.1545328289570;
        Thu, 20 Dec 2018 09:51:29 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id e9sm27449393pff.5.2018.12.20.09.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:51:28 -0800 (PST)
Message-ID: <1545328287.185366.501.camel@acm.org>
Subject: Re: [PATCH] lib/rhashtable: Fix work initialization in
 rhashtable_init()
From:   Bart Van Assche <bvanassche@acm.org>
To:     David Miller <davem@davemloft.net>
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Dec 2018 09:51:27 -0800
In-Reply-To: <20181218.213257.1251094090416839024.davem@davemloft.net>
References: <20181217214058.76811-1-bvanassche@acm.org>
         <20181218.213257.1251094090416839024.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 21:32 -0800, David Miller wrote:
+AD4 From: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 Date: Mon, 17 Dec 2018 13:40:58 -0800
+AD4 
+AD4 +AD4 The test+AF8-insert+AF8-dup() function from lib/test+AF8-rhashtable.c passes a
+AD4 +AD4 pointer to a stack object to rhltable+AF8-init(). Avoid that the following
+AD4 +AD4 is reported with object debugging enabled while running the selftest
+AD4 +AD4 from lib/test+AF8-rhashtable.c:
+AD4  ...
+AD4 +AD4 Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 
+AD4 Please just fix the test to use the global object created for this purpose
+AD4 instead of an unnecessary on-stack instance.

Hi Dave,

I will do that. Thanks for the feedback.

Bart.
