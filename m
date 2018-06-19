Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04814C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24952083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24952083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030462AbeFSTZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:25:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39794 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966793AbeFSTZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:25:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id w12-v6so311885pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FCS2sIzrpsDNNSxRcrVascnvFJLXigE83OhC1SIq34o=;
        b=SyWtz7gMJdAyRyec9FXBwZvdUdcbbP1vLYjSVCKd8XMoUfEs5koImravSc7KJlrD9j
         9fO8aaw2sOKgvTvljMvH9Y4fG94egThUDwiYlpJzMFM5E+1YYUslJ01SWGPS/1I4JQJE
         aC2l6TjmGRUu6N3qXwdpqclZZ//l5xj4Ii7uSxvclhrgbBHRMMLXzJWZ6IZ9jig4feMA
         DBQAmvoRzhEqprSyeOj58eZSaFSBwgOq9MRvDpTv8S+7NdDpJqeq1CBKigRbUUAuu2M8
         5hXJw7mCBy6jNojy7CwVn9rEfPTB/IiE1Pq5yBmtF/apJ/HiqMoJkn79qV1fHKmJ66T9
         FWYA==
X-Gm-Message-State: APt69E0fyb/0MsxURVqM1OtBWzU4kdMCLiMbXmjblMia9KpNvhzLucJi
        vLarR0CKVR9D0kBeaC0iaI3vsA==
X-Google-Smtp-Source: ADUXVKK8DzcznDpHqhxCzUSeKQ/7Re0FtkVAa3cQATq5FTdUtyVmrCqnA1VEOpzwPio7/9hZ1vy7qA==
X-Received: by 2002:a62:f615:: with SMTP id x21-v6mr19372474pfh.43.1529436322810;
        Tue, 19 Jun 2018 12:25:22 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id h124-v6sm540205pfc.100.2018.06.19.12.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:25:21 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] kvm: x86: mmu: Add cast to negated bitmasks in update_permission_bitmask()
Date:   Tue, 19 Jun 2018 12:25:04 -0700
Message-Id: <20180619192504.180479-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_permission_bitmask() negates u8 bitmask values and assigns them
to variables of type u8. Since the MSB is set in the bitmask values the
compiler expands the negated values to int, which then is assigned to
an u8 variable. Cast the negated value back to u8.

This fixes several warnings like this when building with clang:

arch/x86/kvm/mmu.c:4266:39: error: implicit conversion from 'int' to 'u8'
  (aka 'unsigned char') changes value from -205 to 51 [-Werror,
  -Wconstant-conversion]
    u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
       ~~                               ^~

(gcc also raises a warning (see https://godbolt.org/g/6JWfWk), however it
doesn't seem to be universally enabled)

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- negate the bitmask at initialization and rename variables to not_X

 arch/x86/kvm/mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d634f0332c0f..ad0a8c35f27b 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4258,8 +4258,9 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
 {
 	unsigned byte;
 
-	const u8 x = BYTE_MASK(ACC_EXEC_MASK);
-	const u8 w = BYTE_MASK(ACC_WRITE_MASK);
+	const u8 not_x = (u8)~BYTE_MASK(ACC_EXEC_MASK);
+	const u8 not_w = (u8)~BYTE_MASK(ACC_WRITE_MASK);
+	const u8 not_u = (u8)~BYTE_MASK(ACC_USER_MASK);
 	const u8 u = BYTE_MASK(ACC_USER_MASK);
 
 	bool cr4_smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP) != 0;
@@ -4275,11 +4276,11 @@ static void update_permission_bitmask(struct kvm_vcpu *vcpu,
 		 */
 
 		/* Faults from writes to non-writable pages */
-		u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
+		u8 wf = (pfec & PFERR_WRITE_MASK) ? not_w : 0;
 		/* Faults from user mode accesses to supervisor pages */
-		u8 uf = (pfec & PFERR_USER_MASK) ? ~u : 0;
+		u8 uf = (pfec & PFERR_USER_MASK) ? not_u : 0;
 		/* Faults from fetches of non-executable pages*/
-		u8 ff = (pfec & PFERR_FETCH_MASK) ? ~x : 0;
+		u8 ff = (pfec & PFERR_FETCH_MASK) ? not_x : 0;
 		/* Faults from kernel mode fetches of user pages */
 		u8 smepf = 0;
 		/* Faults from kernel mode accesses of user pages */
-- 
2.18.0.rc2.346.g013aa6912e-goog

