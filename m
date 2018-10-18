Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A038C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E6D214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwtwPfEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E6D214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbeJSCHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbeJSCHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:07:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD1D21480;
        Thu, 18 Oct 2018 18:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885893;
        bh=AXZ7Lm6pkKWuvJ7n2sL5j2u96ZnKYxuRF9KYaIRtYww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwtwPfEurJ0h9kmcCNn8YZVRprtBpWp2t/y48tkjPvTK3uMp0e8DO+rXVNUd3bXi3
         F63kbthN2/KyU8gN70GlpDHWiYkufN3fkpZ5v9q1qyfJNNM1A6tN0vMnPpbGEHeZIB
         6R+aw65Ng1BiFk2ruGmAqa9FUcNHNfNSBnVCyV70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Christoph Lameter <clameter@sgi.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 11/48] mm/vmstat.c: fix outdated vmstat_text
Date:   Thu, 18 Oct 2018 19:54:46 +0200
Message-Id: <20181018175428.590247375@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 28e2c4bb99aa40f9d5f07ac130cbc4da0ea93079 upstream.

7a9cdebdcc17 ("mm: get rid of vmacache_flush_all() entirely") removed the
VMACACHE_FULL_FLUSHES statistics, but didn't remove the corresponding
entry in vmstat_text.  This causes an out-of-bounds access in
vmstat_show().

Luckily this only affects kernels with CONFIG_DEBUG_VM_VMACACHE=y, which
is probably very rare.

Link: http://lkml.kernel.org/r/20181001143138.95119-1-jannh@google.com
Fixes: 7a9cdebdcc17 ("mm: get rid of vmacache_flush_all() entirely")
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Roman Gushchin <guro@fb.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Christoph Lameter <clameter@sgi.com>
Cc: Kemi Wang <kemi.wang@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmstat.c |    1 -
 1 file changed, 1 deletion(-)

--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -869,7 +869,6 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_DEBUG_VM_VMACACHE
 	"vmacache_find_calls",
 	"vmacache_find_hits",
-	"vmacache_full_flushes",
 #endif
 #endif /* CONFIG_VM_EVENTS_COUNTERS */
 };


