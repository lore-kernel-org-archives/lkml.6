Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2848808-1517590783-2-3607205088622521692
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517590783; b=PXPUzUPndSoh0bQHJgbXLS/XPol5fDjt49cYopi4FfCeu+4
    2zlYa4+liX6Tl7wOBEyw+riHCGGKBbHO+RJeNxwmdzwQQjBW4XLKZ6CzML6tKWyU
    odCuEbcCxOPvWBwgNQ1VzHE3Vttn77i3WjZfReS7VQflCnG0nMPFuuAyEgUCTP8g
    VvXq3yNy5cJtGqCRL1fYn1HnK4467T4uVsfq1qDi0rkmLIOYGRhn/FIPbMLs1e3H
    Qr77M08cWIFIZn2HcYl/fattxIzEtGWfxvcceMI1yYtK+LmkPHFi6gQPFxsTPT66
    FuF1hXliC4a9fNOvG/lBJtoZZEC55eedCZTZ4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590783; bh=75MuXyPI9RyJBIpm0lFf5ttmP4
    F5QyoszXSZVDYW2cg=; b=rXU+h27dcBUSBW4HI2XlxSt+yLpCOoivj8QoS4aJsb
    C7OlI+gViJV0texClIbn2fg+1xDittRQOMadv2NL8d81eMfzMJ1ry2fevQOfik4a
    VR4tEhwsKDhIvXBqDIOEMvkoWuyd+QU95V0Kj++fcbFvuCgKM8L0abXMwW3dLiL9
    Uq6tUCB+S80wfXuJAExQ86e4p+y9PYlVlHC/+jjohfHoKSIbP1BMaLTTKbgT8Sjg
    od38///sGOZ8cWEjw165GB2h6wxCx4luiE/DQ7fuO7fi8/g2icrSxMYaNGYDCeC8
    9qBtbI/7rM9F62B5m9UXIKCjrn3uJN6+xvoVILgLbkeg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeBBQ7k (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 11:59:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34436 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbeBBQ7g (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 11:59:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.4 10/67] bpf: reject stores into ctx via st and xadd
Date: Fri,  2 Feb 2018 17:57:39 +0100
Message-Id: <20180202140816.368433911@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ upstream commit f37a8cb84cce18762e8f86a70bd6a49a66ab964c ]

Alexei found that verifier does not reject stores into context
via BPF_ST instead of BPF_STX. And while looking at it, we
also should not allow XADD variant of BPF_STX.

The context rewriter is only assuming either BPF_LDX_MEM- or
BPF_STX_MEM-type operations, thus reject anything other than
that so that assumptions in the rewriter properly hold. Add
test cases as well for BPF selftests.

Fixes: d691f9e8d440 ("bpf: allow programs to write to certain skb fields")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -683,6 +683,13 @@ static bool is_pointer_value(struct veri
 	}
 }
 
+static bool is_ctx_reg(struct verifier_env *env, int regno)
+{
+	const struct reg_state *reg = &env->cur_state.regs[regno];
+
+	return reg->type == PTR_TO_CTX;
+}
+
 /* check whether memory at (regno + off) is accessible for t = (read | write)
  * if t==write, value_regno is a register which value is stored into memory
  * if t==read, value_regno is a register which will receive the value from memory
@@ -779,6 +786,12 @@ static int check_xadd(struct verifier_en
 		return -EACCES;
 	}
 
+	if (is_ctx_reg(env, insn->dst_reg)) {
+		verbose("BPF_XADD stores into R%d context is not allowed\n",
+			insn->dst_reg);
+		return -EACCES;
+	}
+
 	/* check whether atomic_add can read the memory */
 	err = check_mem_access(env, insn->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_READ, -1);
@@ -1909,6 +1922,12 @@ static int do_check(struct verifier_env
 			if (err)
 				return err;
 
+			if (is_ctx_reg(env, insn->dst_reg)) {
+				verbose("BPF_ST stores into R%d context is not allowed\n",
+					insn->dst_reg);
+				return -EACCES;
+			}
+
 			/* check that memory (dst_reg + off) is writeable */
 			err = check_mem_access(env, insn->dst_reg, insn->off,
 					       BPF_SIZE(insn->code), BPF_WRITE,
