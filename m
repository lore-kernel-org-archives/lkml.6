Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A39C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566AC217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691012;
	bh=7/e54cZZc5BwcCOdXCHdAzgPoH2kv33q7BaBU+NbVWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rq/67hcTQ2B11n5Yb8bthEI5KxZ0n1X2wlbup0hHYj+pAUQpuxe9Xrm3rBTse9Q/W
	 Tj+b3ZkcDeaUSMEhzG91QN6WzlzpqN+mPzN1hltIwHgEOPImizd07cOKSl8pH/esHQ
	 U9XDCxF01MqKnT1OJxe+OgAUyx/cXgBTOtj0nBNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfA1P4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfA1P4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:56:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36AE42175B;
        Mon, 28 Jan 2019 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691007;
        bh=7/e54cZZc5BwcCOdXCHdAzgPoH2kv33q7BaBU+NbVWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xpp6ktUEF8ke/F/m1POtteeVeOQIeDaoV/nSW3aHY6SlrGrZcD3gz06vlkxMhUb/U
         HO5POKf/r+kAoXAgyCerpXBcU5Wfhy+5Uy2gNLIXMgkbmRWuNojIMAJSCl70IO6PK5
         792u2VqdHouWbYk8kGHvfFfTwodPMBM6Ybc8DE1g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 259/304] selftests: kvm: report failed stage when exit reason is unexpected
Date:   Mon, 28 Jan 2019 10:42:56 -0500
Message-Id: <20190128154341.47195-259-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

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

