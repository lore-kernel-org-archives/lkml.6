Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1624C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2D924067
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l5jE2jTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2D924067
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbeGEMRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:17:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753637AbeGEMRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B3XDDvTHPNSQ86JU/BGEhMPWPneJf3b870Etidm6hKE=; b=l5jE2jTrxvPAGhSJ9+FWdvJwp
        3Vke819h2MQhpmE6x21l1GL7H1eIpv6jD8GOzn5f0/r8uNYqJNEVjeG4UiqDqvEbTEL44OWeC6fQj
        UAsJohoxoMDnlf6L/+w1C9lcuXPIT8IVjSfI1hsYj+onK+s/6By+B/HkT1wdBtoCGFqQW0/cadNMC
        GAiT9cTQ4pV4BfxBlixGpoBmHbYPVh0wn6sLt0UEt2/MZ+jNgVatE7Y9hHZrWt/SE/43uis2xW3cQ
        vbFewpEloZqpDKiCvFU4jhLOiJvJrjGYlJIyLX237bF22RDM2F0EDxXPf1oPHRm8omGxqDKFWmK1V
        2pG4z3sdQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb3Ca-0000vU-OS; Thu, 05 Jul 2018 12:17:36 +0000
Date:   Thu, 5 Jul 2018 05:17:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 15/26] ppc: Convert vas ID allocation to new IDA API
Message-ID: <20180705121736.GB8404@bombadil.infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621212835.5636-16-willy@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 02:28:24PM -0700, Matthew Wilcox wrote:
> Removes a custom spinlock and simplifies the code.

I took a closer look at this patch as part of fixing the typo *ahem*.

The original code is buggy at the limit:

-	if (winid > VAS_WINDOWS_PER_CHIP) {
-		pr_err("Too many (%d) open windows\n", winid);
-		vas_release_window_id(ida, winid);

That permits winid to be == VAS_WINDOWS_PER_CHIP, which is 64 << 10.
Since you then go on to store:

        int id = window->winid;
        vinst->windows[id] = window;

and windows is defined as:

        struct vas_window *windows[VAS_WINDOWS_PER_CHIP];

that's a buffer overflow.

Here's the current version of my patch which will be in linux-next tomorrow.

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index ff9f48812331..e59e0e60e5b5 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -515,35 +515,17 @@ int init_winctx_regs(struct vas_window *window, struct vas_winctx *winctx)
        return 0;
 }
 
-static DEFINE_SPINLOCK(vas_ida_lock);
-
 static void vas_release_window_id(struct ida *ida, int winid)
 {
-       spin_lock(&vas_ida_lock);
-       ida_remove(ida, winid);
-       spin_unlock(&vas_ida_lock);
+       ida_free(ida, winid);
 }
 
 static int vas_assign_window_id(struct ida *ida)
 {
-       int rc, winid;
-
-       do {
-               rc = ida_pre_get(ida, GFP_KERNEL);
-               if (!rc)
-                       return -EAGAIN;
-
-               spin_lock(&vas_ida_lock);
-               rc = ida_get_new(ida, &winid);
-               spin_unlock(&vas_ida_lock);
-       } while (rc == -EAGAIN);
-
-       if (rc)
-               return rc;
+       int winid = ida_alloc_max(ida, VAS_WINDOWS_PER_CHIP - 1, GFP_KERNEL);
 
-       if (winid > VAS_WINDOWS_PER_CHIP) {
-               pr_err("Too many (%d) open windows\n", winid);
-               vas_release_window_id(ida, winid);
+       if (winid == -ENOSPC) {
+               pr_err("Too many (%d) open windows\n", VAS_WINDOWS_PER_CHIP);
                return -EAGAIN;
        }

