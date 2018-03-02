Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1148518-1519981729-2-5491199588423192989
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
    t=1519981728; b=W8H4exvRtlMBIT3GWldboP3nl07BKrwYHp0BNj4JUOgdgFx
    FNifytEPJTVdudLSt41AokyN/dNz4FK0WXRBe4SylYHHLtKoFAQlPOW1mt1Mqfb9
    sYm5TGpQwJ4VDmcsw2bfBIDe346blEU/8Fp5a8koeeYxKhaRe5aI0sJeGJ1zdJb6
    BCuAFCQurOtDyApHHfsOA1ZsVe6HGiGpL/84B4ykqEhalOBL4qxGf/ti2XhHy3+l
    q6Js3uSWIopwU7Q2OGxI+4t1aysmpS9r95zGs4xzJghRgbbN+eI5pfYMwtIxsZNm
    fcaEcn8LFbjPbRC2odJ7Xt/Eoo1jLNONjnNv7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981728; bh=1V3mGafFy/LecTRscGg+T2bC55
    ipHXBxiAGsPSGCo18=; b=UMgETP0DV/9/mRXR+J3gipz3Hf5+a4tGCWO5ipNGpU
    AZ1csFDmL1+8YZf4Ny+v8HDbcxsxjCqN6+gw5pjrRRlGqS5iC2ezPXfTaIq0UkxG
    mJYfPcv5SawC2X/qWAstsPdhwRD8LUyMpFXe8gisO37NmQGika7JnHtcKKV9aikL
    qRFQJERe6bYnrwT1l0BIJnCel+U0LY6bFU1ZkF6E5CJrn7ibMJLnD6jWn/LHc38u
    /FnzJj1yPJYH37KkHl8PIDqRPy9p9H/K80arlNluEckt0WzO02Z5bruy4fxNzXPI
    Hgsrn/KUQa3O9Qmo8y/ighRBVJd6vc8GSfVt0eCLR4kg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425270AbeCBJFm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:05:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56270 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425209AbeCBJFi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 04:05:38 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 106/115] nfp: always unmask aux interrupts at init
Date: Fri,  2 Mar 2018 09:51:49 +0100
Message-Id: <20180302084508.132704412@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <jakub.kicinski@netronome.com>


[ Upstream commit fc2336505fb49a8b932a0a67a9745c408b79992c ]

The link state and exception interrupts may be masked when we probe.
The firmware should in theory prevent sending (and automasking) those
interrupts if the device is disabled, but if my reading of the FW code
is correct there are firmwares out there with race conditions in this
area.  The interrupt may also be masked if previous driver which used
the device was malfunctioning and we didn't load the FW (there is no
other good way to comprehensively reset the PF).

Note that FW unmasks the data interrupts by itself when vNIC is
enabled, such helpful operation is not performed for LSC/EXN interrupts.

Always unmask the auxiliary interrupts after request_irq().  On the
remove path add missing PCI write flush before free_irq().

Fixes: 4c3523623dc0 ("net: add driver for Netronome NFP4000/NFP6000 NIC VFs")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -568,6 +568,7 @@ nfp_net_aux_irq_request(struct nfp_net *
 		return err;
 	}
 	nn_writeb(nn, ctrl_offset, entry->entry);
+	nfp_net_irq_unmask(nn, entry->entry);
 
 	return 0;
 }
@@ -582,6 +583,7 @@ static void nfp_net_aux_irq_free(struct
 				 unsigned int vector_idx)
 {
 	nn_writeb(nn, ctrl_offset, 0xff);
+	nn_pci_flush(nn);
 	free_irq(nn->irq_entries[vector_idx].vector, nn);
 }
 
