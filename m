Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4BBC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3324E20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBuNxx96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3324E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbeLDLZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:25:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeLDLAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:00:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1322214D9;
        Tue,  4 Dec 2018 11:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921241;
        bh=AHOfwddBoQWUYDNztiavgQlQ5Un3/PgXmZfI+G4LrnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hBuNxx96x8hFpoOz0jJveURyWcx5TYrKE9Rhu5o8P2XfA0RkW10A9O07Fx9s2yL43
         0TPChdSP3vVkVnSVg45aMcTCOu/h68CIm5iukN22PqSHptm+Q/CMRCORU9sLfTJE4l
         gTrcVeSchDD+IWmbTFsH1s2LgXamHsQWUtnQN6Lc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 135/139] lib/test_kmod.c: fix rmmod double free
Date:   Tue,  4 Dec 2018 11:50:16 +0100
Message-Id: <20181204103656.387823871@linuxfoundation.org>
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

From: Luis Chamberlain <mcgrof@kernel.org>

commit 5618cf031fecda63847cafd1091e7b8bd626cdb1 upstream.

We free the misc device string twice on rmmod; fix this.  Without this
we cannot remove the module without crashing.

Link: http://lkml.kernel.org/r/20181124050500.5257-1-mcgrof@kernel.org
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org>	[4.12+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/test_kmod.c |    1 -
 1 file changed, 1 deletion(-)

--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -1214,7 +1214,6 @@ void unregister_test_dev_kmod(struct kmo
 
 	dev_info(test_dev->dev, "removing interface\n");
 	misc_deregister(&test_dev->misc_dev);
-	kfree(&test_dev->misc_dev.name);
 
 	mutex_unlock(&test_dev->config_mutex);
 	mutex_unlock(&test_dev->trigger_mutex);


