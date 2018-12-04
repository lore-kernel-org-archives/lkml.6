Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD6CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148242087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MabgDMNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148242087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeLDLQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbeLDLFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:05:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F0FD214E0;
        Tue,  4 Dec 2018 11:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921538;
        bh=LIBC66iDQHR77HG0ru530u6BIFiCnIQh8gWtTzi+Xow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MabgDMNlu08UF0MpnD3ITqZSQIDwP+6tTlqgCsDKD7YhgYtfE8q6YAUn9/cBjGgiU
         M2yBS1MkVRdk1llVZk/crruwjz95+fyIdAWYKwqmvDXNDD1sNTY2IMWzO2I3QiH9AN
         18dKBpqJdrPB6w2B12Sgq6rT3ZkbNTBKsO5AwJX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a8ef68d71211ba264f56@syzkaller.appspotmail.com,
        Mark Kanda <mark.kanda@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 111/146] KVM: x86: Fix kernel info-leak in KVM_HC_CLOCK_PAIRING hypercall
Date:   Tue,  4 Dec 2018 11:49:57 +0100
Message-Id: <20181204103731.291249187@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

From: Liran Alon <liran.alon@oracle.com>

commit bcbfbd8ec21096027f1ee13ce6c185e8175166f6 upstream.

kvm_pv_clock_pairing() allocates local var
"struct kvm_clock_pairing clock_pairing" on stack and initializes
all it's fields besides padding (clock_pairing.pad[]).

Because clock_pairing var is written completely (including padding)
to guest memory, failure to init struct padding results in kernel
info-leak.

Fix the issue by making sure to also init the padding with zeroes.

Fixes: 55dd00a73a51 ("KVM: x86: add KVM_HC_CLOCK_PAIRING hypercall")
Reported-by: syzbot+a8ef68d71211ba264f56@syzkaller.appspotmail.com
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6378,6 +6378,7 @@ static int kvm_pv_clock_pairing(struct k
 	clock_pairing.nsec = ts.tv_nsec;
 	clock_pairing.tsc = kvm_read_l1_tsc(vcpu, cycle);
 	clock_pairing.flags = 0;
+	memset(&clock_pairing.pad, 0, sizeof(clock_pairing.pad));
 
 	ret = 0;
 	if (kvm_write_guest(vcpu->kvm, paddr, &clock_pairing,


