Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591553-2-6465656983417395695
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
    t=1517591552; b=CBPyMvzkMJ3v4CpMt/KJHWm28fYWYLDxrL7nhSXKmKWpsXG
    olJ5b+bRcnLnGBCBvWO7N8HvCRtucJ8VOfryhbQV1ntE/IEWbA+4rLzfj//YwxZG
    9+RtsG0FODj0it23LicQVWhAJ9GfmGdKuoSiLn+et/p8f9R0HglDhXklo7slZJZf
    vZB7aQecyAfHqTxt6s9wBbyR+5JxaKKRQGBwTWRY2ZLT9M2V8MnH8pwBWzrMEdh1
    aaL+nLgoBqiohvuVj6wcWfbxZbvtcvh5A1dY8PiqQ4JewC/o0L/NBJcC256Xzs//
    Zn+PN2Ev0wZM/8z3kea1Nt9q78r9C0KO2WACvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591552; bh=epReIyLiXyI7k2IlkRoLeslHd/
    axOrMKMxQdp5x3JwM=; b=qL84PMPJIqakQ2ZIPf0KcgvsBdqxgS7EO7KuWad4xg
    hhD3NDajVF6ESjuvoJ4pAczbUKjnc0ocdzeX39HbPfk+hWT4lrSDM6/5rlqdMq17
    hsb+KGK0Ld1T+QBVoB2XJAbNTVwuCN3DCGXNu2ioMEjFzSA1m2QaSRjb/oUAEDdq
    /kSYSR7SgT84G38xTqnpM+hLJv+qq/NmYC8RusW1jX+hkE3Q3fy6WNsjPL3LfLNH
    1goV/P1JFVpYaIOQhWeojmH9Vr/fV1mi2BiZlR1TmzLGoErwSMWF5KJ0Mp6S4bDW
    R8thIcEBCg8bEyWBN3F2aUsDDON28Tu7pApO7ou4qNVg==
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
        id S1752540AbeBBRMa (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:12:30 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbeBBRM2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:12:28 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 118/156] scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_config_vreg
Date: Fri,  2 Feb 2018 17:58:19 +0100
Message-Id: <20180202140845.524006441@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit 727535903bea924c4f73abb202c4b3e85fff0ca4 ]

_vreg_ is being dereferenced before it is null checked, hence there is a
potential null pointer dereference.

Fix this by moving the pointer dereference after _vreg_ has been null
checked.

This issue was detected with the help of Coccinelle.

Fixes: aa4976130934 ("ufs: Add regulator enable support")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufshcd.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6555,12 +6555,15 @@ static int ufshcd_config_vreg(struct dev
 		struct ufs_vreg *vreg, bool on)
 {
 	int ret = 0;
-	struct regulator *reg = vreg->reg;
-	const char *name = vreg->name;
+	struct regulator *reg;
+	const char *name;
 	int min_uV, uA_load;
 
 	BUG_ON(!vreg);
 
+	reg = vreg->reg;
+	name = vreg->name;
+
 	if (regulator_count_voltages(reg) > 0) {
 		min_uV = on ? vreg->min_uV : 0;
 		ret = regulator_set_voltage(reg, min_uV, vreg->max_uV);
