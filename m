Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BC0C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA89520844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYHym9iO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA89520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbeKIHhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbeKIHhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:39 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A94C21019;
        Thu,  8 Nov 2018 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714410;
        bh=ZbbFDmERkOV7ECm/qeUtql0NE9WKa+uBclNyFssZzgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hYHym9iOeZI9K3vYZMbQsfikuY3ydiPYS6qmDFPd5nij7/umVqQ0X9zSrIkZLt++t
         +wr0S67adGLzoa2Lc72kq8C5yW89Kx0ovrY0eGqZKOCknGSwomk59IfZ1CxHGuuPIR
         njVhVZ4gjgmPSBrUpE4CQo50w3Ug1bWAsrqNM4II=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikael Pettersson <mikpelinux@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 068/114] sparc64: Fix exception handling in UltraSPARC-III memcpy.
Date:   Thu,  8 Nov 2018 13:51:23 -0800
Message-Id: <20181108215107.197539654@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
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

[ Upstream commit 0ede1c401332173ab0693121dc6cde04a4dbf131 ]

Mikael Pettersson reported that some test programs in the strace-4.18
testsuite cause an OOPS.

After some debugging it turns out that garbage values are returned
when an exception occurs, causing the fixup memset() to be run with
bogus arguments.

The problem is that two of the exception handler stubs write the
successfully copied length into the wrong register.

Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to accurate exception reporting.")
Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
Tested-by: Mikael Pettersson <mikpelinux@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/lib/U3memcpy.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
index 54f98706b03b..5a8cb37f0a3b 100644
--- a/arch/sparc/lib/U3memcpy.S
+++ b/arch/sparc/lib/U3memcpy.S
@@ -145,13 +145,13 @@ ENDPROC(U3_retl_o2_plus_GS_plus_0x08)
 ENTRY(U3_retl_o2_and_7_plus_GS)
 	and	%o2, 7, %o2
 	retl
-	 add	%o2, GLOBAL_SPARE, %o2
+	 add	%o2, GLOBAL_SPARE, %o0
 ENDPROC(U3_retl_o2_and_7_plus_GS)
 ENTRY(U3_retl_o2_and_7_plus_GS_plus_8)
 	add	GLOBAL_SPARE, 8, GLOBAL_SPARE
 	and	%o2, 7, %o2
 	retl
-	 add	%o2, GLOBAL_SPARE, %o2
+	 add	%o2, GLOBAL_SPARE, %o0
 ENDPROC(U3_retl_o2_and_7_plus_GS_plus_8)
 #endif
 
-- 
2.17.1



