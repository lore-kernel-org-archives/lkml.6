Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517591139-2-17718128308733953448
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
    t=1517591139; b=MwcRXXolk+sMmQVR0u7vWNFH91fvE0wdtXxuEkqTOajWati
    zEyQA340811l5hfR/B1FaaYjP40G/7/nrCj/n7aMzzszAzztIOSMAxrY4BvU6eEy
    WQjOLuHDJIWDWHjJJtaDTRuy6KCA/B3gsTpVlof0al4Rz3YXSQfvsqAb6wvkNGf7
    MQtSApoRkNYzzNUQOwb4m7TPYLvj+B3FeCxcM9hPynuGV/8QSIUpD/WYFYm0S2pN
    XPLN7uXM8zmj335lPXrKyBQlQdvSxs2qubpeQYoSWcmIhIm0O7gAhsO++5ZA5D/U
    mH5mJSGndGDnYQcnIwLaHg5kIJYJkNKFQyA14OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591139; bh=hxqnZuCTBL5G3tKo7ZAJf/NfPT
    ao8wUcXY4gH+0ODqM=; b=hCnezONwuSWkfb7Jr3EQ9nqOi7hnwe7rRd2X7+LFlS
    cMuIWnjO2uBBJzo+/Tk94EScsoefCkzOAIbqmxSp42ULqIEP7HhLplPPOUrePEFe
    6CmmfQoSnzMqsY+iwqKjLHhFuVKPwsBUQHpNYWFOhG9EQ8VIKjjIKr1F/vMi25Uv
    X4wHDDHP+76LLFF/o71dqEldu/9ebbPzaqa/DcjK1of8ZarqXQOlUWO7vMXSkDlJ
    sTZ8PgGlBer1bP1ow4tnWF/fmJhjSXbkY1zSLytdnCW3masaI3FEIt33pnA+gdUe
    2sphG2OwrxCMNQfjAElmZzDWQnPsHSvfwZthYRA+WJtA==
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
        id S1752791AbeBBRFe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:05:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36506 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752755AbeBBRFa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:05:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Raghava Aditya Renukunta
        <RaghavaAditya.Renukunta@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 63/86] scsi: aacraid: Prevent crash in case of free interrupt during scsi EH path
Date: Fri,  2 Feb 2018 17:58:23 +0100
Message-Id: <20180202140828.405707791@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/aacraid/commsup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1416,13 +1416,13 @@ static int _aac_reset_adapter(struct aac
 	 * will ensure that i/o is queisced and the card is flushed in that
 	 * case.
 	 */
+	aac_free_irq(aac);
 	aac_fib_map_free(aac);
 	pci_free_consistent(aac->pdev, aac->comm_size, aac->comm_addr, aac->comm_phys);
 	aac->comm_addr = NULL;
 	aac->comm_phys = 0;
 	kfree(aac->queues);
 	aac->queues = NULL;
-	aac_free_irq(aac);
 	kfree(aac->fsa_dev);
 	aac->fsa_dev = NULL;
 	quirks = aac_get_driver_ident(index)->quirks;
