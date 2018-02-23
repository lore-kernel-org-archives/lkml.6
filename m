Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519411547-2-12621528173223752339
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411547; b=HA0uJlqjDEtGO6DU+HaQU5X+102NNjOxN+FGJRc/fomRFEY
    YMZkmGgpgfoowQG6p3lNJayQCYxXoRX/fdzjIsbdcTEThNw+RhZllNbYNK+VUq6d
    sho0Pusnk6cyP3UP9tdhE35Z4nvhoOkmN837A6h0iVY1ukChSo2CbW6nbiLny6ij
    acGKMGkgi2I4DhSUkB/Tm01Z6NSoEgJIIFBUwiUavdGBatdIYgu+PobPVNsuMErA
    IDCmstAQqYHf5gydRziXmd4/LlypWY9+5EQiBuS/jyFeY8kX7iS+z/HR4kGCmqpe
    X2I2D0a1ew/dUMb3+j7t/Nx7vbRadngF7ZU4oQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411547; bh=vtjNE0slaih/W6IYUn/yOTcbt0
    WC9a/z2yBHDkTgWww=; b=u5UQ+JnNHuNBGfnXOItNRHqTO5fAGPXiGpur3I2qnD
    ewie4tmRDXC7PGLfhseE8ItUBDOi6f2acAznrYyp7x+xyvXuJqvmix0avN/cqq8A
    ZHNqvx/FfmCFzBP6+GkzswE2SBGrocBWDto78FIhQn8beGxVmM3UBumR8U8L5t70
    wAhC2/K8rseTE7wfR6S/53J4rp+Qfp/fFp+sO7fi2obRumMPf6FzG1hviP5xWDF2
    IVUGPlaTzfJi15fBUegQWsDVjLMQCwcQWFK0QcGthC8qOioFQOWp/FSeJq3IKAVt
    C5gGeHgmibzaGo0FRS5lIdCEaJ2A/2Sj4t4K5NQ2sGVA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933857AbeBWSpn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:45:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43428 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933550AbeBWSpl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:41 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 077/145] xfrm: Fix stack-out-of-bounds with misconfigured transport mode policies.
Date: Fri, 23 Feb 2018 19:26:23 +0100
Message-Id: <20180223170734.699697306@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>


[ Upstream commit 732706afe1cc46ef48493b3d2b69c98f36314ae4 ]

On policies with a transport mode template, we pass the addresses
from the flowi to xfrm_state_find(), assuming that the IP addresses
(and address family) don't change during transformation.

Unfortunately our policy template validation is not strict enough.
It is possible to configure policies with transport mode template
where the address family of the template does not match the selectors
address family. This lead to stack-out-of-bound reads because
we compare arddesses of the wrong family. Fix this by refusing
such a configuration, address family can not change on transport
mode.

We use the assumption that, on transport mode, the first templates
address family must match the address family of the policy selector.
Subsequent transport mode templates must mach the address family of
the previous template.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_user.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1380,11 +1380,14 @@ static void copy_templates(struct xfrm_p
 
 static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family)
 {
+	u16 prev_family;
 	int i;
 
 	if (nr > XFRM_MAX_DEPTH)
 		return -EINVAL;
 
+	prev_family = family;
+
 	for (i = 0; i < nr; i++) {
 		/* We never validated the ut->family value, so many
 		 * applications simply leave it at zero.  The check was
@@ -1396,6 +1399,12 @@ static int validate_tmpl(int nr, struct
 		if (!ut[i].family)
 			ut[i].family = family;
 
+		if ((ut[i].mode == XFRM_MODE_TRANSPORT) &&
+		    (ut[i].family != prev_family))
+			return -EINVAL;
+
+		prev_family = ut[i].family;
+
 		switch (ut[i].family) {
 		case AF_INET:
 			break;
