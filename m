Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804648-2-17853117448778262087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804647; b=MKzUbnGyPq+qj6TiM4R67A1OkPf1bCtmXkXvGJLJNu0XXBJ
    pCRQ+wmXZ/Q0C/wNutL7J0Oj97URlemcAUcVbhK9xPre3Yw7tceKEY2omb3TOWmw
    bm5QcD13/8wj/JJZEQl7URggjQ3k/v/JfmTHmdlDBrbrBIN7KdZ4lSPSErnbEj9q
    aiSY6t2ateo82UP0Iv8z/AoLKek783ZTMnmMLIqQ99C9pSjiuZOmcZyQkoYH/U+c
    J3cdUiT85S/46viyhLZXGcin63GPZ6ov2pCFDnpewFVuot9QyOAM4x+2z84JJQ/L
    tnGU4Ekld29JvE4/1rw7UtiEbLeQ7hC+epm7N+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804647; bh=5RODp7fkRfja77STQp3lWUFR8t
    y09JTFFngOz02p2YE=; b=tuc0r9RVJaxiKB3ofG07m21rCAOgMhNz+D5yCPHQ3s
    ZWGQheyYEMkyz/pl1JPvu9jWTgSll7Qe5LIvMO8s+HKkb7knEZXnyqvFbkHPDTU/
    rAy+9QeFTviewKl3TlvwL2B03mHVR6WJkWdcTkkmL7JdyGFAAq7QtAq+/txGtHls
    NHZLZrX9peVqCG3gajD9RYLzBI3+toW2rupQx6nimqbsT28JNdGvGVrYY0Vr0w2B
    lAXEpwTfSZENdT82+AuQPKenklbwHCzyTxsgrDooemoMd7Nvxe1arvX8V75brHtR
    f+7YXDbi5gOaKCRchHGdPJrPDuukJUBoFDi3phuoyvnw==
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
        id S1755331AbeCWLa1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:30:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755211AbeCWKGU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian King <brking@linux.vnet.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 053/177] ibmvnic: Disable irq prior to close
Date: Fri, 23 Mar 2018 10:53:01 +0100
Message-Id: <20180323094207.679784172@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Brian King <brking@linux.vnet.ibm.com>


[ Upstream commit dd9c20fa07ba5cfb5a0ab3181d68530506610605 ]

    Add some code to call disable_irq on all the vnic interface's irqs.
    This fixes a crash observed when closing an active interface, as
    seen in the oops below when we try to access a buffer in the interrupt
    handler which we've already freed.

    Unable to handle kernel paging request for data at address 0x00000001
    Faulting instruction address: 0xd000000003886824
    Oops: Kernel access of bad area, sig: 11 [#1]
    SMP NR_CPUS=2048 NUMA pSeries
    Modules linked in: ibmvnic(OEN) rpadlpar_io(X) rpaphp(X) tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag rpcsec_
    Supported: No, Unsupported modules are loaded
    CPU: 8 PID: 0 Comm: swapper/8 Tainted: G           OE   NX 4.4.49-92.11-default #1
    task: c00000007f990110 ti: c0000000fffa0000 task.ti: c00000007f9b8000
    NIP: d000000003886824 LR: d000000003886824 CTR: c0000000007eff60
    REGS: c0000000fffa3a70 TRAP: 0300   Tainted: G           OE   NX  (4.4.49-92.11-default)
    MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22008042  XER: 20000008
    CFAR: c000000000008468 DAR: 0000000000000001 DSISR: 40000000 SOFTE: 0
    GPR00: d000000003886824 c0000000fffa3cf0 d000000003894118 0000000000000000
    GPR04: 0000000000000000 0000000000000000 c000000001249da0 0000000000000000
    GPR08: 000000000000000e 0000000000000000 c0000000ccb00000 d000000003889180
    GPR12: c0000000007eff60 c000000007af4c00 0000000000000001 c0000000010def30
    GPR16: c00000007f9b8000 c000000000b98c30 c00000007f9b8080 c000000000bab858
    GPR20: 0000000000000005 0000000000000000 c0000000ff5d7e80 c0000000f809f648
    GPR24: c0000000ff5d7ec8 0000000000000000 0000000000000000 c0000000ccb001a0
    GPR28: 000000000000000a c0000000f809f600 c0000000fd4cd900 c0000000f9cd5b00
    NIP [d000000003886824] ibmvnic_interrupt_tx+0x114/0x380 [ibmvnic]
    LR [d000000003886824] ibmvnic_interrupt_tx+0x114/0x380 [ibmvnic]
    Call Trace:
    [c0000000fffa3cf0] [d000000003886824] ibmvnic_interrupt_tx+0x114/0x380 [ibmvnic] (unreliable)
    [c0000000fffa3dd0] [c000000000132940] __handle_irq_event_percpu+0x90/0x2e0
    [c0000000fffa3e90] [c000000000132bcc] handle_irq_event_percpu+0x3c/0x90
    [c0000000fffa3ed0] [c000000000132c88] handle_irq_event+0x68/0xc0
    [c0000000fffa3f00] [c000000000137edc] handle_fasteoi_irq+0xec/0x250
    [c0000000fffa3f30] [c000000000131b04] generic_handle_irq+0x54/0x80
    [c0000000fffa3f60] [c000000000011190] __do_irq+0x80/0x1d0
    [c0000000fffa3f90] [c0000000000248d8] call_do_irq+0x14/0x24
    [c00000007f9bb9e0] [c000000000011380] do_IRQ+0xa0/0x120
    [c00000007f9bba40] [c000000000002594] hardware_interrupt_common+0x114/0x180

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -511,6 +511,23 @@ alloc_napi_failed:
 	return -ENOMEM;
 }
 
+static void disable_sub_crqs(struct ibmvnic_adapter *adapter)
+{
+	int i;
+
+	if (adapter->tx_scrq) {
+		for (i = 0; i < adapter->req_tx_queues; i++)
+			if (adapter->tx_scrq[i])
+				disable_irq(adapter->tx_scrq[i]->irq);
+	}
+
+	if (adapter->rx_scrq) {
+		for (i = 0; i < adapter->req_rx_queues; i++)
+			if (adapter->rx_scrq[i])
+				disable_irq(adapter->rx_scrq[i]->irq);
+	}
+}
+
 static int ibmvnic_close(struct net_device *netdev)
 {
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
@@ -519,6 +536,7 @@ static int ibmvnic_close(struct net_devi
 	int i;
 
 	adapter->closing = true;
+	disable_sub_crqs(adapter);
 
 	for (i = 0; i < adapter->req_rx_queues; i++)
 		napi_disable(&adapter->napi[i]);
