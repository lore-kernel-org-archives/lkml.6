Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433A1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DB1217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498232;
	bh=IzIpPy8RkSNryIQH95SsymwWH9D9WVUdW5iaVpBxxYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qxawxYylp/+vlDyUmo/5exD9SAM2n87YdO2c93t9k46Cwv2sagLGOyDRPu8VDYp4Y
	 RRbFeyS1jGeWpKLNRAxYvBFO+YalT5Xew8zJoG0BEjpCRxJ5B1WInWp+KyZSmriBCC
	 /HV/9/6MbmfzsqmFTWV0FdWq4lKPRSKhug8a7xvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbfBRN5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbfBRN5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:57:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBE34217D9;
        Mon, 18 Feb 2019 13:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498223;
        bh=IzIpPy8RkSNryIQH95SsymwWH9D9WVUdW5iaVpBxxYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KGQMULmSi7CFe9WrVON6KVkiqO4LFKwoBJasBmXp6UKKIgT7ovGEhQcsi/rwirarX
         PLPT0gZlRug+7N5Z313nTlWbeBC4S+fcVHe8r+PjtWhzzDSxA6YrlHj3f8ZaoZu3Wu
         F5jvn7ROZ+d+1Qvki8KXAzvi+//+ORXqVWrC2QWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 46/62] kvm: vmx: Fix entry number check for add_atomic_switch_msr()
Date:   Mon, 18 Feb 2019 14:43:52 +0100
Message-Id: <20190218133509.786715997@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

From: Xiaoyao Li <xiaoyao.li@linux.intel.com>

commit 98ae70cc476e833332a2c6bb72f941a25f0de226 upstream.

Commit ca83b4a7f2d068da79a0 ("x86/KVM/VMX: Add find_msr() helper function")
introduces the helper function find_msr(), which returns -ENOENT when
not find the msr in vmx->msr_autoload.guest/host. Correct checking contion
of no more available entry in vmx->msr_autoload.

Fixes: ca83b4a7f2d0 ("x86/KVM/VMX: Add find_msr() helper function")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2230,7 +2230,8 @@ static void add_atomic_switch_msr(struct
 	if (!entry_only)
 		j = find_msr(&m->host, msr);
 
-	if (i == NR_AUTOLOAD_MSRS || j == NR_AUTOLOAD_MSRS) {
+	if ((i < 0 && m->guest.nr == NR_AUTOLOAD_MSRS) ||
+		(j < 0 &&  m->host.nr == NR_AUTOLOAD_MSRS)) {
 		printk_once(KERN_WARNING "Not enough msr switch entries. "
 				"Can't add msr %x\n", msr);
 		return;


