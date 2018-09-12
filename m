Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DB0C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E07420880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E07420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeILUMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:12:42 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeILUMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:12:42 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MBvyp-1gAFRy46g3-00Am5Q; Wed, 12 Sep 2018 17:04:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Chengguang Xu <cgxu519@gmx.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/17] ceph: fix compat_ioctl for ceph_dir_operations
Date:   Wed, 12 Sep 2018 17:01:05 +0200
Message-Id: <20180912150142.157913-4-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912150142.157913-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
X-Provags-ID: V03:K1:J6i9Eex6fUAKsd9dA3fYqkJD2kpX46luePEm0s9Dwfpngq4iDNR
 8VfkOikGhbGGX6M6txlpodzJ8kb/oKPCrA6Ow/8y1UnGWEZhLEqrePAbSMvICN86lN6rRyv
 y9Qf+6i6VGXuo59gGVZuuujaYgKD3tzaXnRA6nV12ZyfzsGLRCuPrPho71vvmR8RfgKPbDE
 ZR58XhUzel+x4kHlL77PQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S7ZIwIJCSPk=:tgnKrgSXeWHUyN3rZ8tbgq
 vgQcb7ahv2lyZfGQughJQVmXDKGO31tGN/W0tZfLD/y2e/j2dNZJWH3lZitV8d7gRlXP0eiJL
 4xi8xUXO+qxBmuykaS600L0OfTaIBdGkISUjD/dgK2sUvUC7y/KUTraDKPhevJhx4AOiTsSei
 bpfxm/iyFsL3LRvrt0sWo6LGif1G0qaS7lIqic21x939VpMkGq1dfPuCRT4alTdlPpeti1nop
 Vn0aV11gUuTydL/ZiJtT+jAVEMPGGEu0eaRcdgznkgmzxynef5xO5a54IwJXx2JT4zPyoPEiG
 ZtiqVFhAZdZmIHgEk1AWFC9cduQtFhGgvuf6A3gC/4s2dGVf0dBdjbQCt2piKnc74o4gL+xK5
 Zgsl8uKIb1tgXa40VTUcNKO3qAgdenuFW88L10OLk3uPu4wTBTDBN6MyFYwkIYwsgfL8HoF4J
 i7pBEHxV9QNIHCsNmJwDx5b6ZQredGQn0oomqRbvcDDFHNLKlIxIYUzVJ0PsIGOuVil0YGOX4
 fgy8ZzxXJQCyqHS1S8FfHCESDehWlD1WP8ptDjiG5KxQca6nzYvofRNya8n39P96rxXtSd3gK
 IcwQLRrd5bNaFBEiHVvy+p2iLNMN44qm9wlZzbDaG/wGYNvEuyIYAITNGDB4SR/9tpL2jm+wY
 gi9Chch0xcsLVTcPdQ6LOr8+tN0ty9CrYiokb4HkSjdyLLv2Fvu5lR+TtcH5rkN2faqU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ceph_ioctl function is used both for files and directories, but only
the files support doing that in 32-bit compat mode.

For consistency, add the same compat handler to the dir operations
as well.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 82928cea0209..da73f29d7faa 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1489,6 +1489,7 @@ const struct file_operations ceph_dir_fops = {
 	.open = ceph_open,
 	.release = ceph_release,
 	.unlocked_ioctl = ceph_ioctl,
+	.compat_ioctl = ceph_ioctl,
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
 	.flock = ceph_flock,
-- 
2.18.0

