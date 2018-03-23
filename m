Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806375-2-4265643022881809801
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
    t=1521806374; b=JMZAHrGMxXTrBEOJEU9ApmvDvm/uHEYaxUyLVrvL94nAij1
    NNwyG/cVA9/L9ZWADZs3Pmw1ZdzsMrwzYZlynA8Cb2Y4PQq2hAOsUPGLLHHV0MKz
    fk+o0shspnf71QErQmXyBSA5/EgHTvHHMOBDeLpela9ieWXex/U8WTwy1UmEef+u
    xzcOV+fkBZawwNLwwoVSsSxyKrNlemsZTSfFBNB/2HJvT3V13l8/LHz4MAk1uRJQ
    6KZLhEFyZXcgvOb9D8mOtg2Sz14yKjlqP1rEMu2oomPpY0wlkyYNnFUjF9ODjl27
    qsOPDiPSJ59NoUQbOTJKd0PAGXIiFBmFI/HSd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806374; bh=UW58tl9Qe3TA6euiXoSKIyr02F
    eDjvhjUQb1aYDjjnM=; b=B1rBwud+aR/4Ba+iyJxPtsu0QGPMRFv/DFOo1RXrZZ
    SwNRy3MXWhM7UuyH5bF4xVrR0Vg/0FpUEA4GW3nfTlbbl/RhHNw94Zk85dLKYZD+
    K3Jn0lnR1PfH6JAg6/Qs5xvctWa3RucBCv4gns2UvJ187tdnOhg+lVbnQAWqxcDk
    uEBrFfC9+0lIUZs5umn+BWt+zwWDoj5omoLei3oJ8dDWF5NleTb8WrOhiEPXIV9p
    rWVLkqnJnoNCamYA8tC291Kjl8z/R8Hb68GyG4gNhl4mtR1FJL6/SR9t5cgrTk/L
    h19WBxsYBLoqMybCqaQklA/K4+peo8pyQwtUb8Py2y1A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1753582AbeCWKAV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:00:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753573AbeCWKAT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:00:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 10/77] hv_netvsc: Fix the receive buffer size limit
Date: Fri, 23 Mar 2018 10:53:44 +0100
Message-Id: <20180323094142.900265737@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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

From: Haiyang Zhang <haiyangz@microsoft.com>


[ Upstream commit 11b2b653102571ac791885324371d9a1a17b900e ]

The max should be 31 MB on host with NVSP version > 2.

On legacy hosts (NVSP version <=2) only 15 MB receive buffer is allowed,
otherwise the buffer request will be rejected by the host, resulting
vNIC not coming up.

The NVSP version is only available after negotiation. So, we add the
limit checking for legacy hosts in netvsc_init_buf().

Fixes: 5023a6db73196 ("netvsc: increase default receive buffer size")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/hyperv_net.h |    6 ++++--
 drivers/net/hyperv/netvsc.c     |    5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -635,9 +635,11 @@ struct nvsp_message {
 #define NETVSC_MTU 65535
 #define NETVSC_MTU_MIN ETH_MIN_MTU
 
-#define NETVSC_RECEIVE_BUFFER_SIZE		(1024*1024*16)	/* 16MB */
-#define NETVSC_RECEIVE_BUFFER_SIZE_LEGACY	(1024*1024*15)  /* 15MB */
+/* Max buffer sizes allowed by a host */
+#define NETVSC_RECEIVE_BUFFER_SIZE		(1024 * 1024 * 31) /* 31MB */
+#define NETVSC_RECEIVE_BUFFER_SIZE_LEGACY	(1024 * 1024 * 15) /* 15MB */
 #define NETVSC_SEND_BUFFER_SIZE			(1024 * 1024 * 15)   /* 15MB */
+
 #define NETVSC_INVALID_INDEX			-1
 
 #define NETVSC_SEND_SECTION_SIZE		6144
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -262,6 +262,11 @@ static int netvsc_init_buf(struct hv_dev
 	buf_size = device_info->recv_sections * device_info->recv_section_size;
 	buf_size = roundup(buf_size, PAGE_SIZE);
 
+	/* Legacy hosts only allow smaller receive buffer */
+	if (net_device->nvsp_version <= NVSP_PROTOCOL_VERSION_2)
+		buf_size = min_t(unsigned int, buf_size,
+				 NETVSC_RECEIVE_BUFFER_SIZE_LEGACY);
+
 	net_device->recv_buf = vzalloc(buf_size);
 	if (!net_device->recv_buf) {
 		netdev_err(ndev,
