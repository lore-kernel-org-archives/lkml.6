Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F8AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34F92084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545172;
	bh=uM5PvfjiB8ipQtOSWOP++bJLGFsKE31cJTbKQSc6DLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ItHYeKxpRKlgAp0gvrWXqbsz/bL/iU7vQK6H9vR6zwVOcfzBrXT1VwhIvnxL7ey+
	 nti7j8WBgw4bH1w/WIXSWUwQVZDGxHaNUMfcw1vECochKBy1EtI2arVBFSylcS6veq
	 cjbPHH44G/bXFR5H9fkmWJ/sDaxk48xrw3u5w/Pg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34F92084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeLKPpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:45:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeLKPps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:45:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B6D21104;
        Tue, 11 Dec 2018 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543148;
        bh=uM5PvfjiB8ipQtOSWOP++bJLGFsKE31cJTbKQSc6DLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3rhJz18rwSiYVoG8/6ZkNytobKHcXymv9/Kw9QJDpWZr4hZWTTyNG9fETGqrKQNT
         l6LHSOsf3J1hPRJqQMSCPpNCIuPRz/nAXjCwtjLxFXKMa3EnurDLjzBezhzaEzgKHj
         AKlCmyDkdBoPSj9uJ3TwitsGAZHxbVbOGZ1G3tVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: [PATCH 4.4 31/91] kdb: use memmove instead of overlapping memcpy
Date:   Tue, 11 Dec 2018 16:40:50 +0100
Message-Id: <20181211151608.340731774@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 2cf2f0d5b91fd1b06a6ae260462fc7945ea84add upstream.

gcc discovered that the memcpy() arguments in kdbnearsym() overlap, so
we should really use memmove(), which is defined to handle that correctly:

In function 'memcpy',
    inlined from 'kdbnearsym' at /git/arm-soc/kernel/debug/kdb/kdb_support.c:132:4:
/git/arm-soc/include/linux/string.h:353:9: error: '__builtin_memcpy' accessing 792 bytes at offsets 0 and 8 overlaps 784 bytes at offset 8 [-Werror=restrict]
  return __builtin_memcpy(p, q, size);

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/debug/kdb/kdb_support.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -129,13 +129,13 @@ int kdbnearsym(unsigned long addr, kdb_s
 		}
 		if (i >= ARRAY_SIZE(kdb_name_table)) {
 			debug_kfree(kdb_name_table[0]);
-			memcpy(kdb_name_table, kdb_name_table+1,
+			memmove(kdb_name_table, kdb_name_table+1,
 			       sizeof(kdb_name_table[0]) *
 			       (ARRAY_SIZE(kdb_name_table)-1));
 		} else {
 			debug_kfree(knt1);
 			knt1 = kdb_name_table[i];
-			memcpy(kdb_name_table+i, kdb_name_table+i+1,
+			memmove(kdb_name_table+i, kdb_name_table+i+1,
 			       sizeof(kdb_name_table[0]) *
 			       (ARRAY_SIZE(kdb_name_table)-i-1));
 		}


