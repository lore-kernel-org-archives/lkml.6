Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8F7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862AA20651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865600;
	bh=TzGvQU4GoNZXZpXUtiabjaWeezqaFjVcGgLE1gw8yh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=piVFBY+jc1Hi6+L5/HHYswdl39w3MTLFtYTU/xT7unISE772yCw62tUfkQBc9w4nN
	 ZBESouTn8HYT88ObO7d4XZl+Pqdk3obRPd5IlKKyjSF8cfleTa5nwwiq0H0V1T0j+C
	 ArEujTniSp0YJp67bEtNnuZiFcyXXMK87GbFG0XQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfAGMxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:53:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfAGMwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:52:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22BA920651;
        Mon,  7 Jan 2019 12:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865563;
        bh=TzGvQU4GoNZXZpXUtiabjaWeezqaFjVcGgLE1gw8yh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HdobDr6u6Op5lChj4bWEUzDLtlsaoFvEy7u+1MfmekGZrmFc3eqbqM4GsTfFFW/Ga
         DkOOTeZKeILrVe+CRqBRjKQLXcTPB+F6ilenI5z4kZtIxjB4ZzDR+Us3ruvslvtClc
         lJC9xs7dOYvfwAnqnpqK/wzvO40ciGxQy36w8Dyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 094/170] KVM: nVMX: Free the VMREAD/VMWRITE bitmaps if alloc_kvm_area() fails
Date:   Mon,  7 Jan 2019 13:32:01 +0100
Message-Id: <20190107104504.138937127@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -8011,13 +8011,16 @@ static __init int hardware_setup(void)
 
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


