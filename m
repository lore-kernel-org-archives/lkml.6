Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EFAC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D01204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xyxsWg+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D01204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeJSB7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbeJSB7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:59:05 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2422145D;
        Thu, 18 Oct 2018 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885420;
        bh=e1weOQmCsA9xZiadk69ZwbiO95DdKO5H03RTeNVkkZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xyxsWg+MNpr0Hb/EnK3Lgwbixe91w3LHNH7BfB1HsnT0SuTxAEnsoIrhRYoPWlQck
         KXvRzoFWJeiPlzDODUvtoGSjr9eJrzwu/GiWYrtFN2dLgX6+iXFnNDotHMVTx+oTae
         GMwml0B/0iKqRGlXdmJ17c2QeuPI2XSNheLHAF2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 23/53] selftests: pmtu: properly redirect stderr to /dev/null
Date:   Thu, 18 Oct 2018 19:54:16 +0200
Message-Id: <20181018175420.790185616@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 0a286afee5a1e8dca86d824209dbd3200294f86f ]

The cleanup function uses "$CMD 2 > /dev/null", which doesn't actually
send stderr to /dev/null, so when the netns doesn't exist, the error
message is shown. Use "2> /dev/null" instead, so that those messages
disappear, as was intended.

Fixes: d1f1b9cbf34c ("selftests: net: Introduce first PMTU test")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Acked-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/pmtu.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -178,8 +178,8 @@ setup() {
 
 cleanup() {
 	[ ${cleanup_done} -eq 1 ] && return
-	ip netns del ${NS_A} 2 > /dev/null
-	ip netns del ${NS_B} 2 > /dev/null
+	ip netns del ${NS_A} 2> /dev/null
+	ip netns del ${NS_B} 2> /dev/null
 	cleanup_done=1
 }
 


