Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FFCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACF22075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D+WgThQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACF22075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeIGEPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:15:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeIGEPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+fNmr2U3/50TYgKUmR325SPC2sikD+JHOs96VKIEg/4=; b=D+WgThQeloxXsL8dGLgVLNSFt
        qTd3A8eCKH/aVYSlb9rUOdb7UEf6EwYrRLW30sV0/g4mr/6SIbPnwZMoBkujbdcLX4PBSWplw4LYU
        lLqSAHuGAXcVSasWZDw1EDtJf/IvI7MC2c6u4WdhE5stbcPJde5s57wFOlcR6plPMuTwKf9oWpIed
        nUVOdNJB1ercuJ0wzlCn93SjdPjd6sLIWY34lC3HqWoPQDH4wTi7FpQc5he3aW+JO263XS+dWUjxM
        DHzrRyY9+nxBVxtigEaj/uvJ7tbRlOzpAl8zo59sRyOjbqLz80HIuQYHjXCpN2T14t5dBd7RJsN9Z
        nK7Tm2ijA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fy3q1-0003zg-7E; Thu, 06 Sep 2018 23:37:25 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] modules_install: warn when missing System.map file
Message-ID: <dde798fd-9fef-6ac0-a3bc-6aa7193c5d89@infradead.org>
Date:   Thu, 6 Sep 2018 16:37:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

If there is no System.map file for "make modules_install",
scripts/depmod.sh will silently exit with success, having done
nothing.  Since this is an unexpected situation, change it to
report a Warning for the missing file.  The behavior is not
changed except for the Warning message.

The (previous) silent success and new Warning can be reproduced
by:
$ make mrproper; make defconfig
$ make modules; make modules_install

and since System.map is produced by "make vmlinux", the steps
above omit producing the System.map file.

Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: add Yamada-san's suggestions for >&2 and Skipping depmod.

 scripts/depmod.sh |    1 +
 1 file changed, 1 insertion(+)

--- lnx-419-rc1.orig/scripts/depmod.sh
+++ lnx-419-rc1/scripts/depmod.sh
@@ -11,6 +11,7 @@ DEPMOD=$1
 KERNELRELEASE=$2
 
 if ! test -r System.map ; then
+	echo "Warning: modules_install: missing 'System.map' file. Skipping depmod." >&2
 	exit 0
 fi
 

