Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B2FECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB1E20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IFYBHeJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB1E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeJVRsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:48:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38016 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeJVRsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:48:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id f29-v6so19620450pff.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=To+WyIIzyyRIFrMQmM5CMsM2mkFborbgY0/EuHOt5aU=;
        b=IFYBHeJ/h367/QmpioEtjjzUJ23OEJNDNNuqdnvAXrw0jACHqfFtIy1BlJRx7Tuo4K
         W/uv5g9BjVM7j1E3MJFOogKNnVEuECKluegWXEoec/TzdJp4oBcGFenrnqkh2zpV3x3l
         uECDzYiELVS/sbueHqEKKiup86p988hhpSOzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=To+WyIIzyyRIFrMQmM5CMsM2mkFborbgY0/EuHOt5aU=;
        b=U00+L0QnyXiRur8gKJ9x4Q1gfjwXGoadqPAzxxRtoDddiRWSl4OioYbLlp8NH6oGYF
         KyLiRt0gizSt9Bj6F3hOlZBLVRJWNJyAZ1w3ByaaBSwP/dcU7VvLMsJUIE4fTQATyLXM
         PJVPmFGKlnIZD4+3dkicE96w2+9T5Pu9FVZ3KLWKAZZbN1Y8MsJIM8NV3hiXILLxRlc0
         BehQ2tdmB2F+unzqGa/Ra+vwKGzk8EOIXblb56cKW5H2Y70V9ff3IXel/1hWZYhYCsTz
         ofcUnxM3RliDgWovAs7e+tNaHUiRYtUups5XWKfSkGU7D7sQAGQ59RyBiOT1r+yXLzDE
         l7yw==
X-Gm-Message-State: ABuFfoiDmEVATKbjV/x/2P/EjDbew5gPQZtKSlNFeRTKLJs/HU5NgYHS
        YG1yj4mivT/Dz1iTwnSFyfui3w==
X-Google-Smtp-Source: ACcGV60GG6xF+kQyVodSmag2kEUxmqKsh5ysnPWIEG6sDg8B/1CNOWtzfaAhsdYkQxHmP8qsvNdlVg==
X-Received: by 2002:a63:9409:: with SMTP id m9-v6mr40841018pge.93.1540200626907;
        Mon, 22 Oct 2018 02:30:26 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id l129-v6sm42968121pfc.155.2018.10.22.02.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 02:30:25 -0700 (PDT)
Date:   Mon, 22 Oct 2018 02:30:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     William Cohen <wcohen@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: kprobes: Fix false positive with FORTIFY_SOURCE
Message-ID: <20181022093023.GA8920@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm compiler internally interprets an inline assembly label
as an unsigned long value, not a pointer. As a result, under
CONFIG_FORTIFY_SOURCE, the size of the array pointed to by an address
of a label is 4 bytes, which was tripping the runtime checks. Instead,
we can just cast the label (as done with the size calculations earlier)
to avoid the problem.

Reported-by: William Cohen <wcohen@redhat.com>
Fixes: 6974f0c4555e ("include/linux/string.h: add the option of fortified string.h functions")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/probes/kprobes/opt-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index b2aa9b32bff2..2c118a6ab358 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
 	}
 
 	/* Copy arch-dep-instance from template. */
-	memcpy(code, &optprobe_template_entry,
+	memcpy(code, (unsigned char *)optprobe_template_entry,
 			TMPL_END_IDX * sizeof(kprobe_opcode_t));
 
 	/* Adjust buffer according to instruction. */
-- 
2.17.1


-- 
Kees Cook
Pixel Security
