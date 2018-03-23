Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521807127-2-2081515065390827853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807126; b=ijdD9w4dSlEdZyazG8OaQlnWHBSJET2G7Hj+dkvQ+HkoUTv
    Snh2aUiuGx+024i+ZqhV/RkMs4umsYhlqn5QX1ZdLoejHCMzEd4fbpta+vGzpnYA
    6lvbx/Y9/+qAGpAPlNbK3NcP2V5WDnmYBNsNlRtxXA+Nia8BcefiE+CpY9fm/eZq
    KqSihq9fG034TiYnyf6SdudV/4slqThKUjI0FUNRPgDO5edJQS05aRE9TOAE+qiM
    SF/WXMeOQCoc5HLeF9jWBdQ+y//no5PTD1MCod3fc4Q3N8Zzf61I7qHlRnWr/q04
    okRxNMpk03W3jCs030K+j1dy6mTvPze9HXdhoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807126; bh=+lnFpsG09Yb+gKL7Ub970N/SVB
    mR3lS42oO6b7OmNZk=; b=nQ/UyewJc/0LvaWmMXLhCp47nVbR1EYlxbQxQ3I7OI
    iXsQmEYV12NVFn2JRRK0LLV7N7L7fs4lSHC98zwhBF85gW0SHnZD5CeuXEiL4FIt
    6hDfFB65sR6DxGfVwgk6bylZ/mPrdEb/2BX4x6PIilZKl2Unhy+MbPqv411wL+1K
    0n4ytd8unu0G30tKkKRNUeTF3i9f0U5m74rZtOUNhiYP5aOMs1vnfvzxW7gC34v9
    +8oVxHBBcOSqTAisQOQ2s2G0P/TZTIGu41CWob2/IjwR/JstvOTXmSQxd4i0cCMH
    OCOmkWyszPKWcn23vkc0CaBWFkU1DsmPtR970tURaQlw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeCWMLw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:11:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35228 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbeCWJ5j (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 43/84] bpf/cgroup: fix a verification error for a CGROUP_DEVICE type prog
Date: Fri, 23 Mar 2018 10:53:57 +0100
Message-Id: <20180323095418.440265398@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonghong Song <yhs@fb.com>


[ Upstream commit 06ef0ccb5a36e1feba9b413ff59a04ecc4407c1c ]

The tools/testing/selftests/bpf test program
test_dev_cgroup fails with the following error
when compiled with llvm 6.0. (I did not try
with earlier versions.)

  libbpf: load bpf program failed: Permission denied
  libbpf: -- BEGIN DUMP LOG ---
  libbpf:
  0: (61) r2 = *(u32 *)(r1 +4)
  1: (b7) r0 = 0
  2: (55) if r2 != 0x1 goto pc+8
   R0=inv0 R1=ctx(id=0,off=0,imm=0) R2=inv1 R10=fp0
  3: (69) r2 = *(u16 *)(r1 +0)
  invalid bpf_context access off=0 size=2
  ...

The culprit is the following statement in dev_cgroup.c:
  short type = ctx->access_type & 0xFFFF;
This code is typical as the ctx->access_type is assigned
as below in kernel/bpf/cgroup.c:
  struct bpf_cgroup_dev_ctx ctx = {
        .access_type = (access << 16) | dev_type,
        .major = major,
        .minor = minor,
  };

The compiler converts it to u16 access while
the verifier cgroup_dev_is_valid_access rejects
any non u32 access.

This patch permits the field access_type to be accessible
with type u16 and u8 as well.

Signed-off-by: Yonghong Song <yhs@fb.com>
Tested-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/bpf.h |    3 ++-
 kernel/bpf/cgroup.c      |   15 +++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -995,7 +995,8 @@ struct bpf_perf_event_value {
 #define BPF_DEVCG_DEV_CHAR	(1ULL << 1)
 
 struct bpf_cgroup_dev_ctx {
-	__u32 access_type; /* (access << 16) | type */
+	/* access_type encoded as (BPF_DEVCG_ACC_* << 16) | BPF_DEVCG_DEV_* */
+	__u32 access_type;
 	__u32 major;
 	__u32 minor;
 };
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -568,6 +568,8 @@ static bool cgroup_dev_is_valid_access(i
 				       enum bpf_access_type type,
 				       struct bpf_insn_access_aux *info)
 {
+	const int size_default = sizeof(__u32);
+
 	if (type == BPF_WRITE)
 		return false;
 
@@ -576,8 +578,17 @@ static bool cgroup_dev_is_valid_access(i
 	/* The verifier guarantees that size > 0. */
 	if (off % size != 0)
 		return false;
-	if (size != sizeof(__u32))
-		return false;
+
+	switch (off) {
+	case bpf_ctx_range(struct bpf_cgroup_dev_ctx, access_type):
+		bpf_ctx_record_field_size(info, size_default);
+		if (!bpf_ctx_narrow_access_ok(off, size, size_default))
+			return false;
+		break;
+	default:
+		if (size != size_default)
+			return false;
+	}
 
 	return true;
 }
