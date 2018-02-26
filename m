Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3025739-1519655667-2-3539415382956012325
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519655666; b=WLExMCqWtK9hTxdzCFTQYABazr8ao7qkOs+LaySr2zwxYkp
    yU6TH/hxq9SDG9yH3+lRCpj3bm1uyrKbs9ARXKMLGUOV6BwbbqWo8ukwAosylyQT
    aoVv/4DbOjVmPRQRQvc8P/SPkQUQjkcisRxLDKA5SL7scWJ0qbpweKwH3PFkNPgZ
    ES20AqT0JComacll9UgmPKgCfxHIr0Fvzc8hR5VZacyZnf7dnmbcFBvpdPB5IsrX
    /sCIeCr8YsTBKZRLuT2wjreDeRMsiahsHQs8LGHB2cwSkG4hSfeRphRzJ2T0rM/T
    mwhmBVbUK9flkvWPg0lT6k+E16gt05cpQ4RuWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519655666; bh=iDBIRUDpKmh8dMmead54G44vrh
    PxLQcd2utBhT+GJ1I=; b=hgi4QGPuo8+OeAcaNKg+flTJ3fE+EwDXXYIdmAGyeh
    pKNUx3M9mF1WIcR11C2CfPEzICIMcxybswML13NjbzkfXr4n0Rf6jHXDtNVzYvWM
    CeaG5IAaWHOA1NbBcxP5E+PhuT4itzxIItZbjiRnyGm4tpcne058kyIF14oW+3gr
    MM47EtYVBkQspsidFij7oXdrIAdq/RUn6q1vuhI+TVr8jIm381nhRYz7FeDb73so
    hvjg+Y4J9e8VFIs1rMc92lbLfXeuro7txdPPMCQ1nkYt0RQmAfxPBIsCuh71dp8Q
    JeSr9pvjsiKC5ldIqq/BKL+095AjR+wW2VSdaw0W7SRQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeBZOeX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 09:34:23 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:34148 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753298AbeBZOeW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 09:34:22 -0500
From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
To: linux-mmc@vger.kernel.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        stable@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 0/2 v3] mmc: dw_mmc: Fix DTO/STO timeout overflow calculation
Date: Mon, 26 Feb 2018 17:34:11 +0300
Message-Id: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
X-Mailer: git-send-email 2.11.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For some 32-bit architectures calculation of DTO and STO timeout can be incorrect
due to multiply overflow. Lets prevent this by casting multiply and result to u64.

Suggested by Jisheng Zhang.
Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL is not reasonable
because overflow happens on multiply and DIV_ROUND_UP_ULL helps
with sum overflow.

---
Changes since v2:
-add fix for cto_ms

Evgeniy Didin (2):
  mmc: dw_mmc: Fix the DTO timeout overflow calculation for 32-bit
    systems
  mmc: dw_mmc: Fix the CTO overflow calculation for 32-bit systems

 drivers/mmc/host/dw_mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.11.0
