Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3025739-1519655681-2-15815399594736443450
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
    t=1519655680; b=DWEYD6Ato0rmLsxYzuCgggU8jEiid78iWrROTFbSPswhaxf
    ofW95oAvL66zwL4Evtmepemt9yCOvswXy2pQkbIyjGudlK2UhEJNQpMXV81P1wUp
    /fJIF1ZY0LG8HI1JAq8L+6hcGJjYAn+geKatA+m733oZuKcqfP2wFwFE5A035fQy
    iCb1FLEt2kGE97fVwto7smMF8dnwVavJ5CngfD7Lampt0LBquNQgWIrD5t7Bwa1A
    ce/4Aaf74Z7VysXlSMZcboKYZyTFukS3f+Se5A/t6vqdadR2Wa+GQ/we8pXmnR/q
    9KDc67Jr6v8RZOvbbcIJXW8UlLiaYGxerp3sK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519655680;
    bh=zeUC+6sd/lyRML+UU5XGs/neV0Dzfnk74yR/ipvqvjU=; b=OFeRNoeCazLE
    366U0fB5HxvSNtFqJqP/3b4Hu2vkwHbAnKj9TEzsUOZYoFRGDGoi++pe5JEfT6NB
    AUXy5qn+wRBiASUEBP5SmDQYX6pWNfffSXMqD0Zm+yEJCprWgs8zh+GovM6rm0+C
    V/pyiii4H2JVzD5rx6eJrFBVl3A0VHo/RIctTrGGLujISJY1JZva6ZkItapF9vm9
    c3aNBTJEFPsZyF9W0gfqTFrsif/PBhom7OasrPK984dUtbZaQjPrzNhZvNDe12K5
    sCDz5MRdcj7Kt8yA/7qw1W6F5GiSGqFtV5BUOEnescj2xkVJ7KPsruL6MZsKNvRl
    LepkLFh1Ug==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753869AbeBZOeg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 09:34:36 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:46905 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753866AbeBZOee (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 09:34:34 -0500
From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
To: linux-mmc@vger.kernel.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        stable@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 2/2 v3] mmc: dw_mmc: Fix the CTO overflow calculation for 32-bit systems
Date: Mon, 26 Feb 2018 17:34:13 +0300
Message-Id: <20180226143413.44134-3-Evgeniy.Didin@synopsys.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
have been made changes which can cause multiply overflow for 32-bit systems.
The value of cto_ms is lower the drto_ms, but nevertheless overflow can occur.
Lets cast this multiply to u64 type which prevents overflow.

Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>

CC: Alexey Brodkin <abrodkin@synopsys.com>
CC: Eugeniy Paltsev <paltsev@synopsys.com>
CC: Douglas Anderson <dianders@chromium.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-kernel@vger.kernel.org
CC: linux-snps-arc@lists.infradead.org
Cc: <stable@vger.kernel.org> #  4c2357f57dd5 mmc: dw_mmc: Fix the CTO timeout calculation
---
 drivers/mmc/host/dw_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 194159219b32..775fb3ae1443 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -409,7 +409,8 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
 	cto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
 	if (cto_div == 0)
 		cto_div = 1;
-	cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
+
+	cto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
 
 	/* add a bit spare time */
 	cto_ms += 10;
-- 
2.11.0
