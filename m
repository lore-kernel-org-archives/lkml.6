Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A219C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B25208DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B25208DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966255AbeFORrz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:47:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41926 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966093AbeFORry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:47:54 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so4203856ply.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 10:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vBWqmGCnEdW8q+xVN4WPLsyDC4Nb9xk+5V5d4+S151A=;
        b=eBVGz+oyStkHUNa0E+B4rzFKgiy7XLtm/1blGIAGPPTOGXU07gdzCipx4H2T3JDflP
         xPdJGutf3XUSpzQV8aHyr7foZMu+whp6oPtIxHaMlEvNa0ER2saLExVzytOBV/xogccY
         yt+2sZ8u9UYndSBMe8JqVrHo2J68zDhcdIhv6Y0AG9BGeCEZUIl2jOsp8siHgF5xIn7M
         cDyXOAW5eXY5gn/9cN0CC/vZC2OpvFWo6cEIaLXRcxNExUBXTrBzw0h/vXJEPumScPOH
         nSZMptp5atCCQT/N7RXDd1dHfcddYdVBDAJzbATElHbdRpE6r1A2swZiyUnkTXEp/VIa
         JKog==
X-Gm-Message-State: APt69E3+uCMWb8AaVzyl8nqy9wAoW4GF3la3OzEikfcc+2BIi2BdYTu+
        Teak3oKCl1qDTX/M3fwy5w0gCQ==
X-Google-Smtp-Source: ADUXVKI+oAfyILZb8tLuT5dG3ijamZZYb+XTCdGDMCXilIZZqyOruwYvbkoeRCqneCuzNN2FvCI6iQ==
X-Received: by 2002:a17:902:a610:: with SMTP id u16-v6mr3091081plq.195.1529084873292;
        Fri, 15 Jun 2018 10:47:53 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id v15-v6sm5492174pff.120.2018.06.15.10.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 10:47:52 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in update_permission_bitmask()
Date:   Fri, 15 Jun 2018 10:47:31 -0700
Message-Id: <20180615174731.47588-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_permission_bitmask() negates u8 bitmask values and assigns them
to variables of type u8. Since the MSB is set in the bitmask values the
compiler expands the negated values to int, which then are assigned to
u8 variables. Cast the negated values back to u8.

This fixes several warnings like this when building with clang:

arch/x86/kvm/mmu.c:4266:39: error: implicit conversion from 'int' to 'u8'
  (aka 'unsigned char') changes value from -205 to 51 [-Werror,
  -Wconstant-conversion]
    u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
       ~~                               ^~

(gcc also raises a warning (see https://godbolt.org/g/6JWfWk), however it
doesn't seem to be universally enabled)

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/x86/kvm/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d634f0332c0f..a83817fdbd87 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4275,11 +4275,11 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
 		 */
 
 		/* Faults from writes to non-writable pages */
-		u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
+		u8 wf = (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
 		/* Faults from user mode accesses to supervisor pages */
-		u8 uf = (pfec & PFERR_USER_MASK) ? ~u : 0;
+		u8 uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
 		/* Faults from fetches of non-executable pages*/
-		u8 ff = (pfec & PFERR_FETCH_MASK) ? ~x : 0;
+		u8 ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
 		/* Faults from kernel mode fetches of user pages */
 		u8 smepf = 0;
 		/* Faults from kernel mode accesses of user pages */
-- 
2.18.0.rc1.244.gcf134e6275-goog

