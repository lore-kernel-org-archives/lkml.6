Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3152AC677FE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB6321476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow4epnB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB6321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbeJKXL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbeJKXL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:11:58 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EB7B20652;
        Thu, 11 Oct 2018 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272654;
        bh=rbL259K9WOgS9IrjUaKbDhTThv2sLBBfwPe6WlQ5Oc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ow4epnB3pjrFUx5hVWKrPqL7cIcMhAL2m2lwehRpkMSza8tID7RbaO8WwYaYPACy8
         hA0HFxUs78Qa5lXw0cmK19ru4KKi861eFp0q0ldQZUFK1aRbejsVoV3xRfKwzMItRc
         Mviqv3Hdve+yTuQs/6lTKSMwKtDFS4x5JJ+TkUsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Feng <gfree.wind@vip.163.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Loic <hackurx@opensec.fr>
Subject: [PATCH 4.9 31/35] ebtables: arpreply: Add the standard target sanity check
Date:   Thu, 11 Oct 2018 17:35:33 +0200
Message-Id: <20181011152521.425951160@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
References: <20181011152520.174949126@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Feng <gfree.wind@vip.163.com>

commit c953d63548207a085abcb12a15fefc8a11ffdf0a upstream.

The info->target comes from userspace and it would be used directly.
So we need to add the sanity check to make sure it is a valid standard
target, although the ebtables tool has already checked it. Kernel needs
to validate anything coming from userspace.

If the target is set as an evil value, it would break the ebtables
and cause a panic. Because the non-standard target is treated as one
offset.

Now add one helper function ebt_invalid_target, and we would replace
the macro INVALID_TARGET later.

Signed-off-by: Gao Feng <gfree.wind@vip.163.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Loic <hackurx@opensec.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/netfilter_bridge/ebtables.h |    5 +++++
 net/bridge/netfilter/ebt_arpreply.c       |    3 +++
 2 files changed, 8 insertions(+)

--- a/include/linux/netfilter_bridge/ebtables.h
+++ b/include/linux/netfilter_bridge/ebtables.h
@@ -123,4 +123,9 @@ extern unsigned int ebt_do_table(struct
 /* True if the target is not a standard target */
 #define INVALID_TARGET (info->target < -NUM_STANDARD_TARGETS || info->target >= 0)
 
+static inline bool ebt_invalid_target(int target)
+{
+	return (target < -NUM_STANDARD_TARGETS || target >= 0);
+}
+
 #endif
--- a/net/bridge/netfilter/ebt_arpreply.c
+++ b/net/bridge/netfilter/ebt_arpreply.c
@@ -67,6 +67,9 @@ static int ebt_arpreply_tg_check(const s
 	if (e->ethproto != htons(ETH_P_ARP) ||
 	    e->invflags & EBT_IPROTO)
 		return -EINVAL;
+	if (ebt_invalid_target(info->target))
+		return -EINVAL;
+
 	return 0;
 }
 


