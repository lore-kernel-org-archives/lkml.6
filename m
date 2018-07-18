Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E00ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6024A2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=makelinux.com header.i=@makelinux.com header.b="dc2zEQae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6024A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=MakeLinux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeGRITH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:19:07 -0400
Received: from bosmailout03.eigbox.net ([66.96.184.3]:52601 "EHLO
        bosmailout03.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeGRITH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:19:07 -0400
X-Greylist: delayed 1820 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jul 2018 04:19:06 EDT
Received: from bosmailscan15.eigbox.net ([10.20.15.15])
        by bosmailout03.eigbox.net with esmtp (Exim)
        id 1ffgdJ-0008Dh-Jf
        for linux-kernel@vger.kernel.org; Wed, 18 Jul 2018 03:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=makelinux.com; s=dkim; h=Sender:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MwVAxiwtBuulvZHY62rZFJXaLGybXIeviVElkxCexHs=; b=dc2zEQaeEDiFpLPIZVKg/rO8Hm
        QqFtqDVsOMt9AB0ExMsAE6mTheLgoF3euWMCSxQamA+vadom1g79DbVVFlt5iFFEOOLWXYLH1SfHi
        /sUl/lOjGQmb+PR3NdAyJh6npVuiABJQqaEvBRK/Ia/hRtvwu9r0fnz7Sq7yYAN2Ejv3vKVr2qbyJ
        rcnFWld8b3OdHbJaW7nFIvebdit0vj0lcjwZGoI/VwXYYg1HcF+2zbgKtttsea98jmEarefnXGHYY
        8TlUv1jgpA+Hnwj6JNlMLZ3RWPaW/Cu+o83Qq6BzJl1ZE8lyYjVUF/bGNcclnacgNHCpiNMJZ3/o6
        j5CKj6Yg==;
Received: from [10.115.3.31] (helo=bosimpout11)
        by bosmailscan15.eigbox.net with esmtp (Exim)
        id 1ffgdJ-0005no-GJ
        for linux-kernel@vger.kernel.org; Wed, 18 Jul 2018 03:12:21 -0400
Received: from bosauthsmtp08.yourhostingaccount.com ([10.20.18.8])
        by bosimpout11 with 
        id C7CJ1y0060ASroS017CMdt; Wed, 18 Jul 2018 03:12:21 -0400
X-Authority-Analysis: v=2.2 cv=PN5/wbiC c=1 sm=1 tr=0
 a=BF10AaGwQl41phDg7WSPyA==:117 a=Dlu3QSMc4l9Ye4MXzL7CyA==:17
 a=IkcTkHD0fZMA:10 a=R9QF1RCXAYgA:10 a=c2dxBoeyqOUA:10 a=dSbym95GAAAA:8
 a=yZlAmEMEHh5XrD6tH_MA:9 a=QEXdDO2ut3YA:10 a=eg0O5KPjxGrMl0Mu5AXQ:22
Received: from [37.142.20.114] (port=12249 helo=localhost.localdomain)
        by bosauthsmtp08.eigbox.net with esmtpa (Exim)
        id 1ffgdG-0004XZ-1G; Wed, 18 Jul 2018 03:12:18 -0400
From:   Constantine Shulyupin <const@MakeLinux.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Constantine Shulyupin <const@MakeLinux.com>
Subject: [PATCH] drivers/char/random.c: fix uninitialized value warning
Date:   Wed, 18 Jul 2018 10:11:52 +0300
Message-Id: <20180718071152.13265-1-const@MakeLinux.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EN-UserInfo: 49eb4aefa70c42fb849786903cdd8376:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: smtp@makelinux.net
X-EN-OrigIP: 37.142.20.114
X-EN-OrigHost: unknown
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable t should be initialized by arch_get_random_int.
Actually on failure of arch_get_random_int, value is not used.
So, just keep the build clean with less warnings.

warning:
drivers/char/random.c: In function ‘write_pool.constprop’:
drivers/char/random.c:1912:11: warning: ‘t’ may be used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 283fe390e878..8e51846d0673 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1896,7 +1896,7 @@ static int
 write_pool(struct entropy_store *r, const char __user *buffer, size_t count)
 {
 	size_t bytes;
-	__u32 t, buf[16];
+	__u32 t = 0, buf[16];
 	const char __user *p = buffer;
 
 	while (count > 0) {
-- 
2.17.1

