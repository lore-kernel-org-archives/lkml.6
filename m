Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A97C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC6B204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC6B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeIMTFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:05:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbeIMTFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:05:52 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0473DCE7;
        Thu, 13 Sep 2018 13:56:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 086/197] coccicheck: return proper error code on fail
Date:   Thu, 13 Sep 2018 15:30:35 +0200
Message-Id: <20180913131844.974207495@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Denis Efremov <efremov@linux.com>

[ Upstream commit 512ddf7d7db056edfed3159ea7cb4e4a5eefddd4 ]

If coccicheck fails, it should return an error code distinct from zero
to signal about an internal problem. Current code instead of exiting with
the tool's error code returns the error code of 'echo "coccicheck failed"'
which is almost always equals to zero, thus failing the original intention
of alerting about a problem. This patch fixes the code.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Denis Efremov <efremov@linux.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/coccicheck |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -128,9 +128,10 @@ run_cmd_parmap() {
 	fi
 	echo $@ >>$DEBUG_FILE
 	$@ 2>>$DEBUG_FILE
-	if [[ $? -ne 0 ]]; then
+	err=$?
+	if [[ $err -ne 0 ]]; then
 		echo "coccicheck failed"
-		exit $?
+		exit $err
 	fi
 }
 


