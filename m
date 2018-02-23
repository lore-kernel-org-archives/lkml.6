Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415609-2-9334886040475505833
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
    t=1519415608; b=CNzd/qUkExDAffPVSXw15bmTSXqsKjojlY+jQGT0TYnmvSU
    Jljbj9pLjT9uomonyCg2mlu3A7WfRJLZTcP+srsVcAtjR6QSImT13NXZ7EQGMljS
    8VnF/OTgvUt9SzGOBU5dlpXzdjFWljKCW5sfzduz5g27b7KTzsboRgNT6ctdt3Cg
    nUPBONXKMZTz//eIm7MXocMOfRuW/JJgeg2zDQf0S9MNNluS+Zb75+9yRSmbubh/
    sox0zxO67WxkfjuAxkSfHkDLgt0+PuOdKDuOt8zt623qhVfSCmjWEYA+yHd9lk+G
    K0HI2pm960/DY7cQdpPiIgIAeIRfqY+fW3wJ8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415608; bh=JLXbvi7t6d5bgDj1FrYsdjC6S5
    Mj4y0E3JEcPjsPDAc=; b=rvq2RbBIVFVosq6hugrcV4laNqYgGwGiqtddLQT0UY
    BXOkDI8EDpVPy2SnfiCzLmPuD0Dgmc0bWb5rGJE5CtZE9jCvTnWup8XkC8+/CLx/
    Wga9kOc5CI7BkCrfrZzNUG0fujbN3CSR/4mcAuKqbv9AUWuqnItEdjOO94L+2jHw
    AxRXPOl66jcr0FNiD8o6ASKFELHXaRdRXg63nAQr/MY9e/Ulru8nsEM2aZFdCHfQ
    z6ihbpajAzMmge/TY94TD8ceGM1YNKMBgWdiJc/ubMycU9YRCl2w1sPF6Vvmi0n8
    0qah/Pyk4NT7aIrxFMO1gpNTro/zSI3ToSFnFG79DSsg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeBWTxZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:53:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933796AbeBWSp1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:45:27 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 072/145] dmaengine: ioat: Fix error handling path
Date: Fri, 23 Feb 2018 19:26:18 +0100
Message-Id: <20180223170734.005131583@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 5c9afbda911ce20b3f2181d1e440a0222e1027dd ]

If the last test in 'ioat_dma_self_test()' fails, we must release all
the allocated resources and not just part of them.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/ioat/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -388,7 +388,7 @@ static int ioat_dma_self_test(struct ioa
 	if (memcmp(src, dest, IOAT_TEST_SIZE)) {
 		dev_err(dev, "Self-test copy failed compare, disabling\n");
 		err = -ENODEV;
-		goto free_resources;
+		goto unmap_dma;
 	}
 
 unmap_dma:
