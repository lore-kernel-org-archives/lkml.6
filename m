Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521807158-2-7476640150798530277
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
    t=1521807158; b=w7uOoq+1AYhF00bz0v3YX3/6Ud7GhUfiV+UaT2MEmW2r1km
    x4DfSTc7Yv/nuLpR0qIb2urpNh6FrbMDQKhGIQspoc6TsKPgG87TgpjwOBXQORzL
    MVvsbIbzq/Kiook5tdLph1VzgLPK6snOmFOoGDGGNLoBIocMr/pcTFhMHISuwCRE
    LorsyX96JcvfU3nukIq5xTWcQ/4hHvf3n+gLRu3+4S8A+VcUYDPs//+tbTLv6WTe
    ZZ5IgCcsbqs+upGLdfU0nWqD12xklWoO+NEBLQT4voYYb49NMuMg7Ld9Kq+sLsZt
    VqvrFNctHiHaHXS0bURWK0kQUK8iQJ75Qj/oUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807158; bh=wYL34wBzbivIOukQdP2Wt2aJeG
    ainaKgpaOeywcgFv4=; b=f/eRls+0+kA+koxPV0B3Wur+r1CsG52k/a297VgOYD
    Mh/Kvo+/bTThBSkq77+hGjK8wGrnD8Bby5BrvDkmC1EEibqGB2yV6a01+GheEdY2
    By4LUEfTdSP8BRNPYBOQ92QCFCwv6mPk7Rd+OBiRzcsFrqgjez6wUq4wK6aq7afR
    oox0DaQXFc3dYLyGyNqVCZ7Ijy7sxBDg9kpCJUvJPrbLc4wdOme7mMNyq3gGVqL2
    EK3YgfslW2sj9j27tnW//CtufiFo67oqFkV1odB+kJHQBbWzEwLAN1Arag5NFt2E
    teUmvL8Jl/ScmsuDTht+cDbaKdvX301sEawTIofR1+fQ==
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
        id S1752878AbeCWJ5c (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:57:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34964 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbeCWJ5a (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Changcheng <changcheng.liu@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 32/84] mmc: block: fix logical error to avoid memory leak
Date: Fri, 23 Mar 2018 10:53:46 +0100
Message-Id: <20180323095416.741312213@linuxfoundation.org>
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

From: "Liu, Changcheng" <changcheng.liu@intel.com>


[ Upstream commit 0be55579a127916ebe39db2a74d906a2dfceed42 ]

If the MMC_DRV_OP_GET_EXT_CSD request completes successfully, then
ext_csd must be freed, but in one case it was not. Fix that.

Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/block.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2623,6 +2623,7 @@ static int mmc_ext_csd_open(struct inode
 
 	if (n != EXT_CSD_STR_LEN) {
 		err = -EINVAL;
+		kfree(ext_csd);
 		goto out_free;
 	}
 
