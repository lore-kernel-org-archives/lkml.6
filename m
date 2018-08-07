Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C41DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4812172F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4812172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390992AbeHGVOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:14:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389783AbeHGVO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:14:29 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C44C73EE;
        Tue,  7 Aug 2018 18:58:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Novakovic <chris@chrisn.me.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 56/85] ipconfig: Correctly initialise ic_nameservers
Date:   Tue,  7 Aug 2018 20:51:58 +0200
Message-Id: <20180807172359.437355860@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Novakovic <chris@chrisn.me.uk>

[ Upstream commit 300eec7c0a2495f771709c7642aa15f7cc148b83 ]

ic_nameservers, which stores the list of name servers discovered by
ipconfig, is initialised (i.e. has all of its elements set to NONE, or
0xffffffff) by ic_nameservers_predef() in the following scenarios:

 - before the "ip=" and "nfsaddrs=" kernel command line parameters are
   parsed (in ip_auto_config_setup());
 - before autoconfiguring via DHCP or BOOTP (in ic_bootp_init()), in
   order to clear any values that may have been set after parsing "ip="
   or "nfsaddrs=" and are no longer needed.

This means that ic_nameservers_predef() is not called when neither "ip="
nor "nfsaddrs=" is specified on the kernel command line. In this
scenario, every element in ic_nameservers remains set to 0x00000000,
which is indistinguishable from ANY and causes pnp_seq_show() to write
the following (bogus) information to /proc/net/pnp:

  #MANUAL
  nameserver 0.0.0.0
  nameserver 0.0.0.0
  nameserver 0.0.0.0

This is potentially problematic for systems that blindly link
/etc/resolv.conf to /proc/net/pnp.

Ensure that ic_nameservers is also initialised when neither "ip=" nor
"nfsaddrs=" are specified by calling ic_nameservers_predef() in
ip_auto_config(), but only when ip_auto_config_setup() was not called
earlier. This causes the following to be written to /proc/net/pnp, and
is consistent with what gets written when ipconfig is configured
manually but no name servers are specified on the kernel command line:

  #MANUAL

Signed-off-by: Chris Novakovic <chris@chrisn.me.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ipconfig.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -772,6 +772,11 @@ static void __init ic_bootp_init_ext(u8
  */
 static inline void __init ic_bootp_init(void)
 {
+	/* Re-initialise all name servers to NONE, in case any were set via the
+	 * "ip=" or "nfsaddrs=" kernel command line parameters: any IP addresses
+	 * specified there will already have been decoded but are no longer
+	 * needed
+	 */
 	ic_nameservers_predef();
 
 	dev_add_pack(&bootp_packet_type);
@@ -1404,6 +1409,13 @@ static int __init ip_auto_config(void)
 	int err;
 	unsigned int i;
 
+	/* Initialise all name servers to NONE (but only if the "ip=" or
+	 * "nfsaddrs=" kernel command line parameters weren't decoded, otherwise
+	 * we'll overwrite the IP addresses specified there)
+	 */
+	if (ic_set_manually == 0)
+		ic_nameservers_predef();
+
 #ifdef CONFIG_PROC_FS
 	proc_create("pnp", S_IRUGO, init_net.proc_net, &pnp_seq_fops);
 #endif /* CONFIG_PROC_FS */
@@ -1605,6 +1617,7 @@ static int __init ip_auto_config_setup(c
 		return 1;
 	}
 
+	/* Initialise all name servers to NONE */
 	ic_nameservers_predef();
 
 	/* Parse string for static IP assignment.  */


