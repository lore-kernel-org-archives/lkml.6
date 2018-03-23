Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521807456-2-838821366252945598
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807455; b=tQ6MP7EJi3+JiU2V26LtQs5gKonnH2SEmKGRGCy8HNZuhrl
    ZtVNhvV64hrfDlpg5h9T1zvYphr8uckTQJprsx3HZZ7koZi71qj4KWnebN4OVMgr
    B3AS6l9ttHfucb7RlEEgs2cVTXpZ/BLQoWvX0mGcEJi+Zw65/Uu3Hi8s0yO8xNVg
    PWWGtJ4zWzhOI7V9tXTdApjDyRAWKJNQVAzqhNfTppsY4KBd31A8Z3MV4IyieCM3
    a5/ZlI7HdTcxZ1gN8ogkfcCe/0vkMLwUPChQzlroiE5C8FqrI0gbZOBkFiArW+rb
    t88LcDW6u9JaEhEJcLUCZDDFtrtuyzlmylrFSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807455; bh=McA8mRZUsTg5F7CSmcsdeef/9k
    JXINuPUFSBkUrN52I=; b=NEDS4dYJ35nol8/32jG+zENYQN8h9wm68qiIpCc4ka
    2CcIOALj/ok5E3Esv6om/BCED5uBaLfAB6cQrxGtwX49Qjfnd22KJFoYC4LfdqSv
    Xsst2sEd5pTuP4dQOr+dV7A5Z/f1WPSCgW2ujArbH1vvREZCP5rVfcrqV4dIykAT
    tC5Vp0ih9xoyFrF6fk28J37TN2N5IlCa2kG8K6Lz3h0kz1BiIDYY3nH5lAEtvyML
    0VVgUYhGSbTeYAOAJIbTiMGqjEB24yHm17vnpwtUbHCRmQju0AvJixX9oJg/7qu+
    3xO+ZoJIqio9ZMuUunssHppzwy8wAjq1t9v7itokTSXg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1752561AbeCWJ4N (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:56:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbeCWJ4H (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:56:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 13/84] hv_netvsc: Fix the TX/RX buffer default sizes
Date: Fri, 23 Mar 2018 10:53:27 +0100
Message-Id: <20180323095413.900602105@linuxfoundation.org>
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

From: Haiyang Zhang <haiyangz@microsoft.com>


[ Upstream commit 41f61db2cd24d5ad802386719cccde1479aa82a6 ]

The values were not computed correctly. There are no significant
visible impact, though.

The intended size of RX buffer is 16 MB, and the default slot size is 1728.
So, NETVSC_DEFAULT_RX should be 16*1024*1024 / 1728 = 9709.

The intended size of TX buffer is 1 MB, and the slot size is 6144.
So, NETVSC_DEFAULT_TX should be 1024*1024 / 6144 = 170.

The patch puts the formula directly into the macro, and moves them to
hyperv_net.h, together with related macros.

Fixes: 5023a6db73196 ("netvsc: increase default receive buffer size")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/hyperv_net.h |   13 ++++++++++++-
 drivers/net/hyperv/netvsc_drv.c |    4 ----
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -638,13 +638,24 @@ struct nvsp_message {
 /* Max buffer sizes allowed by a host */
 #define NETVSC_RECEIVE_BUFFER_SIZE		(1024 * 1024 * 31) /* 31MB */
 #define NETVSC_RECEIVE_BUFFER_SIZE_LEGACY	(1024 * 1024 * 15) /* 15MB */
-#define NETVSC_SEND_BUFFER_SIZE			(1024 * 1024 * 15)   /* 15MB */
+#define NETVSC_RECEIVE_BUFFER_DEFAULT		(1024 * 1024 * 16)
+
+#define NETVSC_SEND_BUFFER_SIZE			(1024 * 1024 * 15)  /* 15MB */
+#define NETVSC_SEND_BUFFER_DEFAULT		(1024 * 1024)
 
 #define NETVSC_INVALID_INDEX			-1
 
 #define NETVSC_SEND_SECTION_SIZE		6144
 #define NETVSC_RECV_SECTION_SIZE		1728
 
+/* Default size of TX buf: 1MB, RX buf: 16MB */
+#define NETVSC_MIN_TX_SECTIONS	10
+#define NETVSC_DEFAULT_TX	(NETVSC_SEND_BUFFER_DEFAULT \
+				 / NETVSC_SEND_SECTION_SIZE)
+#define NETVSC_MIN_RX_SECTIONS	10
+#define NETVSC_DEFAULT_RX	(NETVSC_RECEIVE_BUFFER_DEFAULT \
+				 / NETVSC_RECV_SECTION_SIZE)
+
 #define NETVSC_RECEIVE_BUFFER_ID		0xcafe
 #define NETVSC_SEND_BUFFER_ID			0
 
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -46,10 +46,6 @@
 #include "hyperv_net.h"
 
 #define RING_SIZE_MIN		64
-#define NETVSC_MIN_TX_SECTIONS	10
-#define NETVSC_DEFAULT_TX	192	/* ~1M */
-#define NETVSC_MIN_RX_SECTIONS	10	/* ~64K */
-#define NETVSC_DEFAULT_RX	10485   /* Max ~16M */
 
 #define LINKCHANGE_INT (2 * HZ)
 #define VF_TAKEOVER_INT (HZ / 10)
