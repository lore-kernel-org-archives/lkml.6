Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEA0ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DBC206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DBC206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbeIXSmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:42:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733259AbeIXSmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:42:17 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8F449109C;
        Mon, 24 Sep 2018 12:40:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 156/235] KVM: PPC: Book3S HV: Add of_node_put() in success path
Date:   Mon, 24 Sep 2018 13:52:22 +0200
Message-Id: <20180924113120.871716105@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 51eaa08f029c7343df846325d7cf047be8b96e81 ]

The call to of_find_compatible_node() is returning a pointer with
incremented refcount so it must be explicitly decremented after the
last use. As here it is only being used for checking of node presence
but the result is not actually used in the success path it can be
dropped immediately.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit f725758b899f ("KVM: PPC: Book3S HV: Use OPAL XICS emulation on POWER9")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/book3s_hv.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4562,6 +4562,8 @@ static int kvmppc_book3s_init_hv(void)
 			pr_err("KVM-HV: Cannot determine method for accessing XICS\n");
 			return -ENODEV;
 		}
+		/* presence of intc confirmed - node can be dropped again */
+		of_node_put(np);
 	}
 #endif
 


