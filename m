Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D596C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D810221736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867407;
	bh=z+cFBFHBTw2glASDKwfje9WVAjidzTEnKtSjrbdcAN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BBHRSovfzWnBpGVtCjSePYJ4olXaby9ccdWvXFQxrZbaiagHSbmmw+OnWpLjIbxz8
	 cmJL1s/Zpl31SIbp1gWD0d1dzPbMCAtHxU81ZSO/rdp2MoClTe/kIt/eosNPILbou5
	 7qzvrHuCuMZj0zLMk+aiyVlFRueWvELgKzwzk1mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfAGNX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfAGMlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:41:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAFD921855;
        Mon,  7 Jan 2019 12:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864898;
        bh=z+cFBFHBTw2glASDKwfje9WVAjidzTEnKtSjrbdcAN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xhsnd++ATli5TMwq524qMkREjvFLRt0fSBZoxM45/FY7PPpKJI6js4syXNagAD8GN
         HDHzFF8CkzU7chZZc+75DnP+CMCiF1yWu3yf47QZLXx0zRgdFxUJbKPn+FwIbWt5L2
         OXVy84LAjPvzD22Y9HwqjmblmGhKqQ2yUppmoLd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.20 059/145] KVM: nVMX: Free the VMREAD/VMWRITE bitmaps if alloc_kvm_area() fails
Date:   Mon,  7 Jan 2019 13:31:36 +0100
Message-Id: <20190107104445.004786721@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -8031,13 +8031,16 @@ static __init int hardware_setup(void)
 
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


