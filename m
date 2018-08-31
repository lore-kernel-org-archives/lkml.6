Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA87C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA032083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EroODGsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA032083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeIACnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:43:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIACnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gJIEMefwE4xMZFyYSRGFkkmLSbNPctFrRdyhB0dUiWU=; b=EroODGsRIgFYGr8zd8zKnLzee
        xmjYsHheTNZT5P/2aBeo7Iiqs0xLNd3SLAmRsQldLzG/1lr3XtD9HJEcEOoA8L1sHZLBP2F+1FBp7
        dh687oEMBnQOIUzIUWPX5P/l/0ctDB3f2ZJYRTFO3c1nrDYYcXL5X2spe6EMRXW9LJRH0CCtymDLO
        8AEKoDU420FAdGOf2ejpvucYpnmLwlfsuKylcGEWM9/3CgS1FeS1eh/WQXZm9JZQjgCywtsm3jElk
        joR0ZDe35P2MP217dBcKTOERgISHxOReKNOHHObmWsFzzw+eCrhfcCuXUot9xXvKEv6F/AATjJy0R
        0McvNZGLA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvryw-0003Yj-Lh; Fri, 31 Aug 2018 22:33:34 +0000
To:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kbuild: modules_install: Warn if System.map file is not found
Message-ID: <b82ada4b-25d1-5612-4405-d6a09eb59433@infradead.org>
Date:   Fri, 31 Aug 2018 15:33:34 -0700
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
 scripts/depmod.sh |    1 +
 1 file changed, 1 insertion(+)

--- lnx-419-rc1.orig/scripts/depmod.sh
+++ lnx-419-rc1/scripts/depmod.sh
@@ -11,6 +11,7 @@ DEPMOD=$1
 KERNELRELEASE=$2
 
 if ! test -r System.map ; then
+	echo "Warning: modules_install: missing 'System.map' file"
 	exit 0
 fi
 

