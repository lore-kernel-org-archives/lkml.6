Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641510-2-11225763635172278295
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
    t=1520641510; b=vLc2X5HUfVhYugZvA8DYk+PW5sA2IqD3bCgoDto9mc6L6i2
    vDrZT5RnLddtWk4Pwz1rcR70Y3bNgHKqU1GuqaUqmPdriA0x0dnQElwNrxN9yFUB
    oKrCXOs+ZRDKBP1JXhlsDp1jYnTpXuiH2+IHNFWUnF4UI41xQnFy23FOR//W82AZ
    sQ3HOMVXqiGCQvYiuXvK+JEfwOLbHpWDJOeXsNbwcnEH2nhzEMoitYzEgHSQpePO
    p94UlhDQQxf+BMqipmGXd8ZRnlpOWqAqNUM3fzt1L4AOS5yJArsQENJwQFDM2AVT
    UdtSieyEAp5/SFY8HUT4QLtC/ieC7QrTPAaJ46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641510; bh=JG8dZfJUNDrFQlRUqY0OOAuYLT
    8SpC6oKtrHSEjLaaQ=; b=kGn5mExd5KulXsUHPf9lgehIKvomIbfrsVbjFsSXzg
    45D/CzYxdt/CLRgSWJ+Fj6pKM5YICpufVamKl+nhRwiLIyjj2ji8hMRO6fUbh8NX
    frZoHB/+ArfrV/3SW2E9whh3hXvkFd2XhYvnCd3E7kPOalntWNIVSkLNX240rtBS
    9fxjQs4rxS8oGytmGyOp3IOWXLLScOsiJ/IgmK1H8yWfbJ8XyYNvrJUvRL2Berd2
    vkXi3uHHm8qwsJi3sN0zC223sYRvZKPR1NlNoioYNFqQQ2Fvn1s8fd7zFvVpRxF+
    OP7sGP9C4wn0KlHlJSpAnBffgJ6pOTLXk0f4S83DXfqw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932953AbeCJAYg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:24:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933593AbeCJAXy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.15 08/11] bpf, ppc64: fix out of bounds access in tail call
Date: Fri,  9 Mar 2018 16:19:22 -0800
Message-Id: <20180310001835.001671203@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001834.560857664@linuxfoundation.org>
References: <20180310001834.560857664@linuxfoundation.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

[ upstream commit d269176e766c71c998cb75b4ea8cbc321cc0019d ]

While working on 16338a9b3ac3 ("bpf, arm64: fix out of bounds access in
tail call") I noticed that ppc64 JIT is partially affected as well. While
the bound checking is correctly performed as unsigned comparison, the
register with the index value however, is never truncated into 32 bit
space, so e.g. a index value of 0x100000000ULL with a map of 1 element
would pass with PPC_CMPLW() whereas we later on continue with the full
64 bit register value. Therefore, as we do in interpreter and other JITs
truncate the value to 32 bit initially in order to fix access.

Fixes: ce0761419fae ("powerpc/bpf: Implement support for tail calls")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/net/bpf_jit_comp64.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -242,6 +242,7 @@ static void bpf_jit_emit_tail_call(u32 *
 	 *   goto out;
 	 */
 	PPC_LWZ(b2p[TMP_REG_1], b2p_bpf_array, offsetof(struct bpf_array, map.max_entries));
+	PPC_RLWINM(b2p_index, b2p_index, 0, 0, 31);
 	PPC_CMPLW(b2p_index, b2p[TMP_REG_1]);
 	PPC_BCC(COND_GE, out);
 
