Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41ABC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D4121736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866145;
	bh=okWfYbLYUC6pUQfgpuKvuGrQ6JqtLaCvEhrvQvDj8DQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JYaVIHv9JuRUtXjZHeHz7LUihgR6IppT+M1/pXzNSNVl0cfZXYLsfihA9I1unilJr
	 Zc6sR6uoU21Ep/RP8OSl+9BuJAB5WbOBFOn6K+NRCUw1rOGtjshTjgewdSfzDqzWLE
	 2o9t8VDbamTGXImkbnQ3sFvogxqIOviGeH4JizB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfAGNCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbfAGNCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:02:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5AAB2089F;
        Mon,  7 Jan 2019 13:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866141;
        bh=okWfYbLYUC6pUQfgpuKvuGrQ6JqtLaCvEhrvQvDj8DQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OLRxZ+SuBzCbZmWQlCi7IvqoBTv/seMSw6nSyZWf4XE5jefP3CEiwIbGRXNWTD+I/
         U20p4T814h4K7RCOm3E2J44JL017ycn+jKZatB3xKGC0TkDMf3TSP/ke242xb9Z+pg
         lRgo46dEHGDcWLuoukao54yZVwhdkG0Ux6SeTeJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 059/101] KVM: nVMX: Free the VMREAD/VMWRITE bitmaps if alloc_kvm_area() fails
Date:   Mon,  7 Jan 2019 13:32:47 +0100
Message-Id: <20190107105336.146126782@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 1b3ab5ad1b8ad99bae76ec583809c5f5a31c707c upstream.

Fixes: 34a1cd60d17f ("kvm: x86: vmx: move some vmx setting from vmx_init() to hardware_setup()")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7275,13 +7275,16 @@ static __init int hardware_setup(void)
 
 	kvm_mce_cap_supported |= MCG_LMCE_P;
 
-	return alloc_kvm_area();
+	r = alloc_kvm_area();
+	if (r)
+		goto out;
+	return 0;
 
 out:
 	for (i = 0; i < VMX_BITMAP_NR; i++)
 		free_page((unsigned long)vmx_bitmap[i]);
 
-    return r;
+	return r;
 }
 
 static __exit void hardware_unsetup(void)


