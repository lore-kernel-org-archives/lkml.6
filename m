Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591553-2-3448135378053888944
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
    t=1517591552; b=wzBXLbAvFS60mCtbSHmc0E2A7XNDzLqJ5nsIHVkARuuXU6r
    Ipt/m5vRQdotMdiwNTraRIKp9c5VE7TDM3P9B/sBtrd5aP2qVfdq4aeIYoPpcloD
    mQ51FxaM3AZtjBXUfncSa8uqQsDwSJA3f6onzeSnz4w8d0dPxj+H5QdaDOv3+ve0
    9Kt6+CmhNXcF2d5g7/YMcHTHW69nSQ8hNuzfuHtj+oRh4glMo3iyZDK2oRBD0XTr
    i5jKsm7acT/tRGYIt/rBGiUnYuUHIoxsyf/LQjuBYXLxCgezCmkDH4IaVPkqyBAw
    qqMKRqrw/QrEtozlx4QiNAv6ARHnIMxaQj4WrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591552; bh=PHzkQX7pwHRpD4uTBq2uwOsgQa
    kG/vCChretdpV8+r4=; b=UO8M0vVkOEL8SGvVfRMYDavbqB6ctAVVnuEtS9R4In
    eYl+zF55bKLESYh6we7pLqxsjLcySGWpepOU6oIA+BfQyc4QlzUbTuqDfEKhj5ZI
    Twq5oRaHnMvkPKrma/9MRL64hHEpsSlxzikZ2tgtqheW3jTAKcXHHY5yTTb7PK+I
    1YkGfoDNKm2sp75GuWGDSn+ZESeA7jjcNP+BPVDAwfrnK+yHSoZd3grZFtHpx8JQ
    FD0vGECY+qK2gFPHUtk92O0xc3bw3uj7wHHLXrkCFpZq6svdi2F9828a2IN8p4Na
    Lqfgy4XfxRLL1cec4gGm+ZQ0ZBoZ9DMGYU9D6SSx0Ltg==
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
        id S1752671AbeBBRM3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:12:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753467AbeBBRM0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:12:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Raghava Aditya Renukunta
        <RaghavaAditya.Renukunta@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 117/156] scsi: aacraid: Prevent crash in case of free interrupt during scsi EH path
Date: Fri,  2 Feb 2018 17:58:18 +0100
Message-Id: <20180202140845.475716367@linuxfoundation.org>
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

From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>


[ Upstream commit e4717292ddebcfe231651b5aff9fa19ca158d178 ]

As part of the scsi EH path, aacraid performs a reinitialization of the
adapter, which encompass freeing resources and IRQs, NULLifying lots of
pointers, and then initialize it all over again.  We've identified a
problem during the free IRQ portion of this path if CONFIG_DEBUG_SHIRQ
is enabled on kernel config file.

Happens that, in case this flag was set, right after free_irq()
effectively clears the interrupt, it checks if it was requested as
IRQF_SHARED. In positive case, it performs another call to the IRQ
handler on driver. Problem is: since aacraid currently free some
resources *before* freeing the IRQ, once free_irq() path calls the
handler again (due to CONFIG_DEBUG_SHIRQ), aacraid crashes due to NULL
pointer dereference with the following trace:

  aac_src_intr_message+0xf8/0x740 [aacraid]
  __free_irq+0x33c/0x4a0
  free_irq+0x78/0xb0
  aac_free_irq+0x13c/0x150 [aacraid]
  aac_reset_adapter+0x2e8/0x970 [aacraid]
  aac_eh_reset+0x3a8/0x5d0 [aacraid]
  scsi_try_host_reset+0x74/0x180
  scsi_eh_ready_devs+0xc70/0x1510
  scsi_error_handler+0x624/0xa20

This patch prevents the crash by changing the order of the
deinitialization in this path of aacraid: first we clear the IRQ, then
we free other resources. No functional change intended.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Reviewed-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/aacraid/commsup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1583,6 +1583,7 @@ static int _aac_reset_adapter(struct aac
 	 * will ensure that i/o is queisced and the card is flushed in that
 	 * case.
 	 */
+	aac_free_irq(aac);
 	aac_fib_map_free(aac);
 	dma_free_coherent(&aac->pdev->dev, aac->comm_size, aac->comm_addr,
 			  aac->comm_phys);
@@ -1590,7 +1591,6 @@ static int _aac_reset_adapter(struct aac
 	aac->comm_phys = 0;
 	kfree(aac->queues);
 	aac->queues = NULL;
-	aac_free_irq(aac);
 	kfree(aac->fsa_dev);
 	aac->fsa_dev = NULL;
 
