Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D8AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF66B20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544532660;
	bh=129yGfPjzAisC/Y/bt9XquKhScefGqoezDN3tYO3uSg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=jYA1vwENiZOvk6Pe4BVDi5kW64OjLFv4PnwYZ+5YsX4c1oJgq611uWeZUyhDy90qu
	 U8auql2ubxUgFQn+RENQ8n9AsDxM7x4y1RbbNlQaFYdzfwcczGYoJpKgC0u2f7WNUz
	 fUH8q1h3cuw3BTBviS6DrVwQHcqXCjGHkB+ho0Kc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF66B20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeLKMu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:50:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbeLKMu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:50:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C8782082F;
        Tue, 11 Dec 2018 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544532658;
        bh=129yGfPjzAisC/Y/bt9XquKhScefGqoezDN3tYO3uSg=;
        h=Date:From:To:Cc:Subject:From;
        b=YuNZOu2geVndjfHkjUu/DPr2F3Gje2KPZ9dtLZ/WO690IOFaD8SwxAWjN69QE3psb
         kLemdoFoNZjcdUFKKtHCJG8DnQjBz8Gnle5rW5Xt8MWQ04W6qp89QNtXgmpLzHh4s1
         TGxa+WQorxbOo1UZzuQviF0KvQACOAAbBclkwWZk=
Date:   Tue, 11 Dec 2018 13:50:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: staging: atomisp: remove "fun" strncpy warning
Message-ID: <20181211125055.GB25594@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[for older kernels only, atomisp has been removed from upstream]

gcc-8 rightfully warns that this instance of strncpy is just copying
from the source, to the same source, for a few bytes.  Meaning this call
does nothing.  As the author of the code obviously meant it to do
something, but this code must be working properly, just replace the call
to the kernel internal strscpy() which gcc doesn't know about, so the
warning goes away.

As this driver was deleted from newer kernel versions, none of this
really matters but now at least we do not have to worry about a build
warning in the stable trees.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_css_debug.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_css_debug.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/css2400/runtime/debug/src/ia_css_debug.c
@@ -2860,9 +2860,7 @@ ia_css_debug_pipe_graph_dump_stage(
 			if (l <= ENABLE_LINE_MAX_LENGTH) {
 				/* It fits on one line, copy string and init */
 				/* other helper strings with empty string */
-				strcpy_s(enable_info,
-					sizeof(enable_info),
-					ei);
+				strscpy(enable_info, ei, sizeof(enable_info));
 			} else {
 				/* Too big for one line, find last comma */
 				p = ENABLE_LINE_MAX_LENGTH;
