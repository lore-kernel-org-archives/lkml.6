Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBE6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5141321B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900601;
	bh=azl55dmhvZDrCwpk01h1diQ57+nzg6+5PwBNS8L+mfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YJ0S2tcb7nfn/pxGsjdrONS3GTop2XCWI2vSzW8fJMd1w+SmatGPATAHFLPSY7WSJ
	 XJKN2uCwvDmy+OIWSAGejnzVccU8L65NpMe/J3P8PZHcsMTuGxuV/gPBGWgNv8Mwhg
	 tv2YpTbE+vvVXxtMVAmhb5fn5RIpP3puik0vB17s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfBKOeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:34:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730793AbfBKOeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:34:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3A521B18;
        Mon, 11 Feb 2019 14:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895652;
        bh=azl55dmhvZDrCwpk01h1diQ57+nzg6+5PwBNS8L+mfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0LtCrmAs5339co04I38cSsyLsFSbz2saDysull+MUc18qdjosZTLGV98TbwpvrdgY
         RJF8/wpyGd0/oz6tVA6/8bEJtXD9NB44g5vJTaepMSzZSe+azOC9klCp5jw6Rp0o/V
         U2/S6xexNS2S6jrdfK7u2Nr39XpmRN+G9+2ZwUCc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 247/352] selftests: kvm: report failed stage when exit reason is unexpected
Date:   Mon, 11 Feb 2019 15:17:54 +0100
Message-Id: <20190211141902.841744391@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit b85c32dd27495075380350fcd5d614a6b45311b8 ]

When we get a report like

==== Test Assertion Failure ====
  x86_64/state_test.c:157: run->exit_reason == KVM_EXIT_IO
  pid=955 tid=955 - Success
     1	0x0000000000401350: main at state_test.c:154
     2	0x00007fc31c9e9412: ?? ??:0
     3	0x000000000040159d: _start at ??:?
  Unexpected exit reason: 8 (SHUTDOWN),

it is not obvious which particular stage failed. Add the info.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/x86_64/evmcs_test.c | 4 ++--
 tools/testing/selftests/kvm/x86_64/state_test.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index 92c2cfd1b182..ea3c73e8f4f6 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -113,8 +113,8 @@ int main(int argc, char *argv[])
 	for (stage = 1;; stage++) {
 		_vcpu_run(vm, VCPU_ID);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
-			    "Unexpected exit reason: %u (%s),\n",
-			    run->exit_reason,
+			    "Stage %d: unexpected exit reason: %u (%s),\n",
+			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
 		memset(&regs1, 0, sizeof(regs1));
diff --git a/tools/testing/selftests/kvm/x86_64/state_test.c b/tools/testing/selftests/kvm/x86_64/state_test.c
index 03da41f0f736..4b3f556265f1 100644
--- a/tools/testing/selftests/kvm/x86_64/state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/state_test.c
@@ -152,8 +152,8 @@ int main(int argc, char *argv[])
 	for (stage = 1;; stage++) {
 		_vcpu_run(vm, VCPU_ID);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
-			    "Unexpected exit reason: %u (%s),\n",
-			    run->exit_reason,
+			    "Stage %d: unexpected exit reason: %u (%s),\n",
+			    stage, run->exit_reason,
 			    exit_reason_str(run->exit_reason));
 
 		memset(&regs1, 0, sizeof(regs1));
-- 
2.19.1



