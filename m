Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7395C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850522075C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759857;
	bh=nZPNLlLRGbS2TJgncL6URPt4NIcq6idRZVj2qWiXhQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s4gKOQZrGKfaICQI6rffpjePtqz4/IU8sYufp+4rb9uMiValdGwSLvlFKROHwtX22
	 OWXmWPzaOcHpeWZ3rMq/PJ1/kwpjsVz1gRuPCzYCJlTreuQCDSCynn/VRRaO5gNpTE
	 nCYUITH9Pzw0hyMdzciZCWh3jlNMKX2vacq3KzWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfBUOhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfBUOhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:37:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7577D2084D;
        Thu, 21 Feb 2019 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759854;
        bh=nZPNLlLRGbS2TJgncL6URPt4NIcq6idRZVj2qWiXhQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HgJffcXukiBUrO1tgFQqFnswt38UwMz/lixqHzTmu8e3m6ooTWKgZ/f0C0JuoKfE3
         rGBSc6NcDXcuUzk4QMt6Ycme4lJRj7L2VhRqkbnpm/AUjP+0IWrMq4fardf/tJQyQt
         nfALWufEJrU3TmjTDDnqGuuz6Hep6rkMQXxaCrrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, chenzefeng <chenzefeng2@huawei.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 4.4 13/20] [PATCH] x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32
Date:   Thu, 21 Feb 2019 15:35:43 +0100
Message-Id: <20190221141947.151506933@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
References: <20190221141946.772985220@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

Signed-off-by: chenzefeng <chenzefeng2@huawei.com>

On x86-64, for 32-bit PC-relacive branches, we can generate PLT32
relocation, instead of PC32 relocation. and R_X86_64_PLT32 can be
treated the same as R_X86_64_PC32 since linux kernel doesn't use PLT.

commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as R_X86_64_PC32") been
fixed for the module loading, but not fixed for livepatch relocation,
which will fail to load livepatch with the error message as follow:
relocation failed for symbol <symbol name> at <symbol address>

This issue only effacted the kernel version from 4.0 to 4.6, becauce the
function klp_write_module_reloc is introduced by: commit b700e7f03df5
("livepatch: kernel: add support for live patching") and deleted by:
commit 425595a7fc20 ("livepatch: reuse module loader code to write
relocations")

Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/livepatch.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/livepatch.c
+++ b/arch/x86/kernel/livepatch.c
@@ -58,6 +58,7 @@ int klp_write_module_reloc(struct module
 		val = (s32)value;
 		break;
 	case R_X86_64_PC32:
+	case R_X86_64_PLT32:
 		val = (u32)(value - loc);
 		break;
 	default:


