Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3280DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DC0222B1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897425;
	bh=TBYFs7S8buC+UPKaNBQMT6mHfwE90Kw/LD2ReAafBGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AYmLgp6BjlBq/+ZP7EHlTcvcH8LQQPLyE9Rjx0/FuPJQNL4SxClFeg71VCOK8A5rO
	 aJ6ksxiGKufxVQSiiVW0V+D/RY6EKk2AyjXgh2rDfFPCNN/EjobrnO6Im0t5DEASJ3
	 L+nllVzQSvM6pY2bzvnzfzVFG3MCOiNxdeMu2vUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389389AbfBKPDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:03:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390660AbfBKPDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:03:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CD11222A7;
        Mon, 11 Feb 2019 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897418;
        bh=TBYFs7S8buC+UPKaNBQMT6mHfwE90Kw/LD2ReAafBGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hj+YpykfyEpAsCGF41uyISyggGm9T/k2JL+EwC2UEMnyfIcSaJJ6zP1JRGyF7jJYx
         qBmLvBK/+J8kC9kxdvF6KynTNdkLC1L+nGkN/cpE7UDEcF1sD40RibHe4iwH9XnkR8
         7otJ1kMNSETTaxiHGkW7jC6eCBQsKVh095muB73Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        x86-ml <x86@kernel.org>
Subject: [PATCH 4.14 197/205] x86/MCE: Initialize mce.bank in the case of a fatal error in mce_no_way_out()
Date:   Mon, 11 Feb 2019 15:19:55 +0100
Message-Id: <20190211141841.312127112@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

commit d28af26faa0b1daf3c692603d46bc4687c16f19e upstream.

Internal injection testing crashed with a console log that said:

  mce: [Hardware Error]: CPU 7: Machine Check Exception: f Bank 0: bd80000000100134

This caused a lot of head scratching because the MCACOD (bits 15:0) of
that status is a signature from an L1 data cache error. But Linux says
that it found it in "Bank 0", which on this model CPU only reports L1
instruction cache errors.

The answer was that Linux doesn't initialize "m->bank" in the case that
it finds a fatal error in the mce_no_way_out() pre-scan of banks. If
this was a local machine check, then this partially initialized struct
mce is being passed to mce_panic().

Fix is simple: just initialize m->bank in the case of a fatal error.

Fixes: 40c36e2741d7 ("x86/mce: Fix incorrect "Machine check from unknown source" message")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86-ml <x86@kernel.org>
Cc: stable@vger.kernel.org # v4.18 Note pre-v5.0 arch/x86/kernel/cpu/mce/core.c was called arch/x86/kernel/cpu/mcheck/mce.c
Link: https://lkml.kernel.org/r/20190201003341.10638-1-tony.luck@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -773,6 +773,7 @@ static int mce_no_way_out(struct mce *m,
 			quirk_no_way_out(i, m, regs);
 
 		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
+			m->bank = i;
 			mce_read_aux(m, i);
 			*msg = tmp;
 			return 1;


