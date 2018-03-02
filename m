Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1414047-1519989460-2-3289713529936838442
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989459; b=vmxlE5AbPBs5Dqap59gGQwYTo42XR4Z4GpBN42ZFOz9oPtl
    Y7k8UK1SfepVIWxEWyJybrZqIqoaECgs/JG8/1WzH/PLIC7yv5S5nyE3vsHwWA+9
    rv627BQDVSIzwu/H6QQTKWNxprlXh7ksWeg4Uig8tZnRmkZgQdVzpy4OSxpV8cx/
    vJkrhouTUFow8vcRcFH/GcjS5mqARxlU/WjH/zZ3EDwZw7VJ/XJjF1tfAA5MFQDy
    EUHEA5kzwfgCVCj3xZpqJO5me2IfmRHRPuGRGNQ4BjV0g9VXvJ47A5mIJp+NPxKd
    OWNRLCd4Vpgd0Ya11rBrNZZjkFLr7pfq/0Tfgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989459; bh=RD9BKGjtCQPzCTYQF3uoRCO77b
    whw6nfKtYEeH2aEW8=; b=B7s/fzlfLs8OWm34EkcSkQ8N+icEvjM5tJ4kiEzJL8
    ZymzxsPJi6QNtR6zRrQDCtuyIDg/Cuv37tNXQImetQXn8vAryCt9FW+zQwRZln35
    PGldOMGbiHetgqtK51w7DJGTbdQ2UaHVdMCyc587QTX9ccEbSYZ2diw4C5eHG0NB
    LT3wWXL2fLrVykPPWDDmxv4DzyELxw3rnzYblGT9e+jBQYhxbnznwUV9RGswJaYR
    Bx5vtlmTwtcUBBxgOYrl4PRgAZnYOn4DIHr3CP/vugw+r+akWhLO1HVetDRYyUMG
    w+8yyeyxdUnzCNPJjxjzzJI0yBYcI9v7FZwpf5GYHcrw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423433AbeCBLQy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:16:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423353AbeCBIxj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:53:39 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 24/24] net: gianfar_ptp: move set_fipers() to spinlock protecting area
Date: Fri,  2 Mar 2018 09:51:21 +0100
Message-Id: <20180302084240.311289329@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yangbo Lu <yangbo.lu@nxp.com>


[ Upstream commit 11d827a993a969c3c6ec56758ff63a44ba19b466 ]

set_fipers() calling should be protected by spinlock in
case that any interrupt breaks related registers setting
and the function we expect. This patch is to move set_fipers()
to spinlock protecting area in ptp_gianfar_adjtime().

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/gianfar_ptp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/ethernet/freescale/gianfar_ptp.c
+++ b/drivers/net/ethernet/freescale/gianfar_ptp.c
@@ -314,11 +314,10 @@ static int ptp_gianfar_adjtime(struct pt
 	now = tmr_cnt_read(etsects);
 	now += delta;
 	tmr_cnt_write(etsects, now);
+	set_fipers(etsects);
 
 	spin_unlock_irqrestore(&etsects->lock, flags);
 
-	set_fipers(etsects);
-
 	return 0;
 }
 
