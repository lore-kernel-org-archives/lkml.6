Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521215198-2-10546637287383391908
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
    t=1521215198; b=kBhtkzj1F6hHcStaHy/vVyy76kpOEH3cOAoLAao5ietoacS
    Lacxk5pWls6J2AbibfyUznwJbyykRhnns3YFL++6hNTznVoBmopqiE4/8h7NrJ/P
    FKQGxIY22gbmIHGtcNy2eGnyBZvPU0Dw3LG8a6JlCSmsiykUc1gRoc7htLlHghoJ
    HiEAaAr2t7CSy1SOpi+slrJAGeDoTaKkXCqnQz0j2c/lGUP3YGCy6AMQDLPjbm2N
    2xzNwOXjyzEctyjof2o7StlTRceVY0gzqNNvb8i+atADweJrbRLKkmFOk0EQgrzO
    PSffUOoE4j9CkYvM08siQ9fxYWgjahRG4ubTJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215198; bh=ECk3nVpFIPQEzm6NrpTOnbR4FU
    C7JRjUcITFEb2xo98=; b=Lg1cPv2ChfD4kJpgi2Ps4Y61GmUal6J+ZTcGjH1ZJP
    UBXEpiN0D99biNhdrv1NYzf1Ayp35Afn+nXmu3QTFYiI7Ap7ruhkEf5UAzOYyCQQ
    7FCPA+os8BN/7y353n83eGxQJiKQIaMn3EpdcJDEBTrSlPF10AdYdzT3Q+w0eAuM
    Um7xpcupl2i0Q/cIQSjdYpWJuJQS0vSJB8i7kak72mdEkQbySg1+dMZVP0cBJKcI
    lnYyEKdRJfEwoG6oON8uufOyTYIrKbEqd9HRuLf1hecEFzQ33mP5+pWUb40UCH2e
    PP3mBURhYa5hb5DWX5+6fINAEQ+8CqNm4DoawlRyVsNg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S934430AbeCPPqZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:46:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933389AbeCPPpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:45:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 120/128] mmc: mmc_test: Ensure command queue is disabled for testing
Date: Fri, 16 Mar 2018 16:24:21 +0100
Message-Id: <20180316152342.427291611@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
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

From: Adrian Hunter <adrian.hunter@intel.com>


[ Upstream commit 23a185254ace8e63dc4ca36e0315aed9440ae749 ]

mmc_test disables the command queue because none of the tests use the
command queue. However the Reset Test will re-enable it, so disable it in
that case too.

Fixes: 9d4579a85c84 ("mmc: mmc_test: Disable Command Queue while mmc_test is used")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/mmc_test.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -2328,10 +2328,17 @@ static int mmc_test_reset(struct mmc_tes
 	int err;
 
 	err = mmc_hw_reset(host);
-	if (!err)
+	if (!err) {
+		/*
+		 * Reset will re-enable the card's command queue, but tests
+		 * expect it to be disabled.
+		 */
+		if (card->ext_csd.cmdq_en)
+			mmc_cmdq_disable(card);
 		return RESULT_OK;
-	else if (err == -EOPNOTSUPP)
+	} else if (err == -EOPNOTSUPP) {
 		return RESULT_UNSUP_HOST;
+	}
 
 	return RESULT_FAIL;
 }
