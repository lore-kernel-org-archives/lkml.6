Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415481-2-9631928197272643442
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
    t=1519415481; b=HZQVDSDU9o4dS5xCRJE0SaoRAQgzQvUjj8OBwTxomHsYtNF
    orvFjIZn9SwUYdSwEwt6iQLhjdVZO3m5lsYDHv4u24rLxqFVXBRzQT+L8hsu6NU9
    p3pQQO7jmp17+uGQm7Dz/0QvCDAfm6wQEgPQurmAHRGKPrAn7rd0YjrNhInRkQXy
    FXMk1iE/nWG7mgiOrX8T5VPYFvJOxrcsuH/N4m7bE3BfrVjGWBuyQLReWjHBRwhQ
    xHkbUGiXy7Vf+mdXSSUsYhCoEj0l1zVBxk8VQGD+iyr6Yz8q44reSSVT+fUka3rP
    dLzonxWApFg77sZduxOPzW4Z6ukLtsdO4DRvIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415481; bh=YI5LyagHJzo9fRL8Spm2F7zMA0
    z617/CUeS4uk/+eMk=; b=b4YYrWoe4UbM4OldbpBorC2gg04u4/9aI963iQrehS
    LOargQZVigEaBNPLGxLNVOfRAOxxC1dg5xxA+lCatn4Q7l6TjoOQooZY5sfdEI4M
    scuPjrI+V/K748nwOyhmLp2V8jZlN0/iVkbiq+Tj43hSoPavPyEMbz/aB2CmqDhA
    7cOxDttmTzW+q3x4DOP8KkK5UpqOCCP5O7FwSFfic0Y0wtXZKqID44IMYn9FQzHg
    +dAqlq1ipcCkIKfjxeE8Dx0DIHX7fm5myuQoaoPD0JxEewp7Z7B50v6k9bzet1//
    iJa4Zfl1rSBTA9tU/9ndK77Jou2f+zeGvyck7cVrbgLg==
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
        id S933578AbeBWSp6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:45:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43510 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933587AbeBWSp4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:56 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andreas Platschek <andreas.platschek@opentech.at>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 081/145] usb: dwc3: of-simple: fix missing clk_disable_unprepare
Date: Fri, 23 Feb 2018 19:26:27 +0100
Message-Id: <20180223170735.219699098@linuxfoundation.org>
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

From: Andreas Platschek <andreas.platschek@opentech.at>


[ Upstream commit ded600ea9fb51a495d2fcd21e90351df876488e8 ]

If of_clk_get() fails, the clean-up of already initialized clocks should be
the same as when clk_prepare_enable() fails. Thus a clk_disable_unprepare()
for each clock should be called before the clk_put().

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 16adc674d0d6 ("usb: dwc3: ep0: fix setup_packet_pending initialization")

Signed-off-by: Andreas Platschek <andreas.platschek@opentech.at>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-of-simple.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -58,8 +58,10 @@ static int dwc3_of_simple_clk_init(struc
 
 		clk = of_clk_get(np, i);
 		if (IS_ERR(clk)) {
-			while (--i >= 0)
+			while (--i >= 0) {
+				clk_disable_unprepare(simple->clks[i]);
 				clk_put(simple->clks[i]);
+			}
 			return PTR_ERR(clk);
 		}
 
