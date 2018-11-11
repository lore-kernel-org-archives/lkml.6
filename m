Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FF6C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4CD20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHrvbBh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4CD20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390642AbeKLIxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:53:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390539AbeKLIWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:23 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 473742245E;
        Sun, 11 Nov 2018 22:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975546;
        bh=x/zG+zGuSf1eZ1lOzst+O7I7F33beXHVPK4UhnJHOqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHrvbBh56+l27/7CTbq7CzMLYvMwLK63ZRCzg9DKcUkejTMHa3EkDUUx7+8WxtS38
         1kYqDC7CziUeQHyIbzRUa/Lq3SeWIBg1j1Gv5QuwEm/L2gPccZ69bTTyaYpA8zrDNf
         DMKc+wTzWvrSkcQZLYLwYZrjAlig38YdZ/yAG4xI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 079/222] KVM: nVMX: Clear reserved bits of #DB exit qualification
Date:   Sun, 11 Nov 2018 14:22:56 -0800
Message-Id: <20181111221655.133959342@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

[ Upstream commit cfb634fe3052aefc4e1360fa322018c9a0b49755 ]

According to volume 3 of the SDM, bits 63:15 and 12:4 of the exit
qualification field for debug exceptions are reserved (cleared to
0). However, the SDM is incorrect about bit 16 (corresponding to
DR6.RTM). This bit should be set if a debug exception (#DB) or a
breakpoint exception (#BP) occurred inside an RTM region while
advanced debugging of RTM transactional regions was enabled. Note that
this is the opposite of DR6.RTM, which "indicates (when clear) that a
debug exception (#DB) or breakpoint exception (#BP) occurred inside an
RTM region while advanced debugging of RTM transactional regions was
enabled."

There is still an issue with stale DR6 bits potentially being
misreported for the current debug exception.  DR6 should not have been
modified before vectoring the #DB exception, and the "new DR6 bits"
should be available somewhere, but it was and they aren't.

Fixes: b96fb439774e1 ("KVM: nVMX: fixes to nested virt interrupt injection")
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kvm_host.h |    1 +
 arch/x86/kvm/vmx.c              |    7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -174,6 +174,7 @@ enum {
 
 #define DR6_BD		(1 << 13)
 #define DR6_BS		(1 << 14)
+#define DR6_BT		(1 << 15)
 #define DR6_RTM		(1 << 16)
 #define DR6_FIXED_1	0xfffe0ff0
 #define DR6_INIT	0xffff0ff0
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2733,10 +2733,13 @@ static int nested_vmx_check_exception(st
 		}
 	} else {
 		if (vmcs12->exception_bitmap & (1u << nr)) {
-			if (nr == DB_VECTOR)
+			if (nr == DB_VECTOR) {
 				*exit_qual = vcpu->arch.dr6;
-			else
+				*exit_qual &= ~(DR6_FIXED_1 | DR6_BT);
+				*exit_qual ^= DR6_RTM;
+			} else {
 				*exit_qual = 0;
+			}
 			return 1;
 		}
 	}


