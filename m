Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C26C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED99320E20
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qEs9627b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED99320E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeHQPID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:08:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54699 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeHQPIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:08:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180817120448euoutp02d3c342b094f524fb783fd731b5d908a5~Lqm49GSY90437604376euoutp020;
        Fri, 17 Aug 2018 12:04:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180817120448euoutp02d3c342b094f524fb783fd731b5d908a5~Lqm49GSY90437604376euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1534507488;
        bh=qLz2oUpRq2+r4Wx/qwFB3duaoch/bmf/QexzJhUjFfM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=qEs9627b2eCfVzM1DcrVr5Yz2NHZirIOMrSshDF0aIsrmVshOx7tL8tj+5uD1ASpd
         AmeVQwjApbSjznz14NZnYzjyLHs6XCP59TjXqPp4B23wygXN0zQziDIcQEt6If04pt
         CnIXGTH3v6wxSG3fZe/LBDQ0GiUqXG8qB0J8RvDU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180817120448eucas1p1c0d49d2dd2dbdbcdcffe160a841fee80~Lqm4lQ-IZ2496724967eucas1p1T;
        Fri, 17 Aug 2018 12:04:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6A.9D.04294.FD9B67B5; Fri, 17
        Aug 2018 13:04:47 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180817120447eucas1p1dde0176cf7d824e8a42e2d39ac5531f9~Lqm38tsUN1904019040eucas1p1M;
        Fri, 17 Aug 2018 12:04:47 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-a3-5b76b9df9cce
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 80.98.04128.FD9B67B5; Fri, 17
        Aug 2018 13:04:47 +0100 (BST)
Received: from mcdsrvbld02.digital.local ([106.116.37.23]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PDL003VITI7WI30@eusync1.samsung.com>;
        Fri, 17 Aug 2018 13:04:47 +0100 (BST)
From:   Andrzej Pietrasiewicz <andrzej.p@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Forsman?= <bjorn.forsman@gmail.com>
Subject: [PATCH] kbuild: make sorting initramfs contents independent of
 locale
Date:   Fri, 17 Aug 2018 14:03:19 +0200
Message-id: <20180817120319.21002-1-andrzej.p@samsung.com>
X-Mailer: git-send-email 2.11.0
In-reply-to: <CAK7LNASUsZB--DWMB4hpw74OnTiz+d2jrdp+CA9L=AOdkbEmhg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7djPc7r3d5ZFG0w5r28x62U7i0XHzMXs
        Fpd3zWGz2HvvM6MDi8fOWXfZPfq2rGL0ODH9O4vH501yASxRXDYpqTmZZalF+nYJXBnX7h1h
        L2jjrDi04xpTA+Nu9i5GTg4JAROJT29PgNlCAisYJZ7e0uti5AKyPzNKLJx2mA2maPrzJywQ
        iWWMEr8PPGCHcJqYJH71TwFrZxMwlth7sIMRxBYRUJDY3PuMFaSIWWARo8ScuTNYQBLCAgES
        m55uZQKxWQRUJU71vGIGsXkFrCQafk5kgVgnL7Gr7SIriM0pECxxZ0E32CAJgZesEt2tPxkh
        ilwkWnetgLpPWOLV8S1QD8lIXJ7cDTWoXmLTlz1QNVMYJe7N9YawrSUOH4dYwCzAJzFp23Sg
        IziA4rwSHW1CECUeEpvnX2CE+HIJo8Sz2ReYJjBKLmBkWMUonlpanJueWmyUl1quV5yYW1ya
        l66XnJ+7iREYWaf/Hf+yg3HXn6RDjAIcjEo8vBPWlkYLsSaWFVfmHmKU4GBWEuGNXF4WLcSb
        klhZlVqUH19UmpNafIhRmoNFSZyXTystWkggPbEkNTs1tSC1CCbLxMEp1cA4R+5Nim/pu70r
        64/PP3IwYd5z9q8JNpsWH5XXN8t2e3SrdeW9zMkuHUukXLrv+Je9quBiltveoG/yRUr2qov/
        nf9VP0+eSK1I3t8dwl/lXmARsVQ76HS3h+uW27o71QV4d86vKSxYIO0zc16TymUW14sH/r9+
        5OTzSeboN9njtg+eLOrYZ3NUiaU4I9FQi7moOBEAnpS21qgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJMWRmVeSWpSXmKPExsVy+t/xy7r3d5ZFG0w/I24x62U7i0XHzMXs
        Fpd3zWGz2HvvM6MDi8fOWXfZPfq2rGL0ODH9O4vH501yASxRXDYpqTmZZalF+nYJXBnX7h1h
        L2jjrDi04xpTA+Nu9i5GTg4JAROJ6c+fsHQxcnEICSxhlPhwYAaU08Iksez0LbAqNgFjib0H
        OxhBbBEBBYnNvc9YQYqYBRYxSkx/NYsZJCEs4CexvesRC4jNIqAqcarnFVicV8BKouHnRBaI
        dfISu9ousoLYnALBEtu3XWICsYUEAiQ+9t5in8DIs4CRYRWjSGppcW56brGRXnFibnFpXrpe
        cn7uJkZgWGw79nPLDsaud8GHGAU4GJV4eCesLY0WYk0sK67MPcQowcGsJMIbubwsWog3JbGy
        KrUoP76oNCe1+BCjNAeLkjjveYPKKCGB9MSS1OzU1ILUIpgsEwenVAPjhbkTPx7xWCu7228r
        65Fdiw5s9Nso9SOKqXVJ82mlrKN2pbO3lXk8z/iw9KlEYu6/4495Kh672oRcu1i2bhvnydNS
        tv49U7crXvGx9U9Zce7GBbnDdy6GnFv//G47x5mZs+cZijI7sykHMEbYrIj4+G/iG+ZGGdX/
        lStEJnA+rE/lFpnws6dygxJLcUaioRZzUXEiAHuoZGMHAgAA
X-CMS-MailID: 20180817120447eucas1p1dde0176cf7d824e8a42e2d39ac5531f9
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180817120447eucas1p1dde0176cf7d824e8a42e2d39ac5531f9
References: <CAK7LNASUsZB--DWMB4hpw74OnTiz+d2jrdp+CA9L=AOdkbEmhg@mail.gmail.com>
        <CGME20180817120447eucas1p1dde0176cf7d824e8a42e2d39ac5531f9@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some LANG values (e.g. pl_PL.UTF-8) cause the sort command to output
files before their parent directories, which makes them inaccessible for
the kernel. In other words, when the kernel populates the rootfs, it is
unable to create files whose parent directories have not been yet created.

This patch makes sorting use the default (LANG=C) locale, which results in
correctly laid out initramfs images (parent directories before files).

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
---
 scripts/gen_initramfs_list.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
index 10e528b..0aad760 100755
--- a/scripts/gen_initramfs_list.sh
+++ b/scripts/gen_initramfs_list.sh
@@ -174,7 +174,7 @@ dir_filelist() {
 	${dep_list}header "$1"
 
 	srcdir=$(echo "$1" | sed -e 's://*:/:g')
-	dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n" | sort)
+	dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n" | LANG=C sort)
 
 	# If $dirlist is only one line, then the directory is empty
 	if [  "$(echo "${dirlist}" | wc -l)" -gt 1 ]; then
-- 
2.7.4

