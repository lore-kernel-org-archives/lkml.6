Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D1DC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA37820851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZkYlLHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA37820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeLDLAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbeLDLAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:00:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66402087F;
        Tue,  4 Dec 2018 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921218;
        bh=eUz4JVIwxuElcrRMF8v3SBYGj8g2TiHASa2KDgDGilE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZkYlLHvdiZ7Y53KTC7jvg26pjVyDDnGA3qRxsn70BrrT6909s0Iswu4fg2zDkwSL
         s5qDzIubZdK8zHSV9LFVuTxF2Ch3uG8XvNFyI6npjJbt7TkfgpnNtpBTTz8a74JAWR
         /2u8CRXGos+dbA3PkEhTXJlInjdRDiblogv+MOp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: [PATCH 4.19 127/139] staging: mt7621-pinctrl: fix uninitialized variable ngroups
Date:   Tue,  4 Dec 2018 11:50:08 +0100
Message-Id: <20181204103655.955006571@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit cd56a5141331abfe218d744a3d66e1788135d482 upstream.

Currently the for_each_node_with_property loop us incrementing variable
ngroups however it was not initialized and hence will contain garbage.
Fix this by initializing ngroups to zero.

Detected with static analysis with cppcheck:

drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c:89]: (error) Uninitialized
variable: ngroups

Fixes: e12a1a6e087b ("staging: mt7621-pinctrl: refactor rt2880_pinctrl_dt_node_to_map function")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -82,7 +82,7 @@ static int rt2880_pinctrl_dt_node_to_map
 	struct property *prop;
 	const char *function_name, *group_name;
 	int ret;
-	int ngroups;
+	int ngroups = 0;
 	unsigned int reserved_maps = 0;
 
 	for_each_node_with_property(np_config, "group")


