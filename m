Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1347C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA04C21765
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu0VwuUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA04C21765
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeHUSK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbeHUSK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:10:56 -0400
Received: from localhost.localdomain (unknown [121.229.162.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 035C5214DA;
        Tue, 21 Aug 2018 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534863028;
        bh=gk24tsiTRmPBYAoqGkZgwSBpeG2M9XPe8aVhLb/X3RY=;
        h=From:To:Cc:Subject:Date:From;
        b=Iu0VwuUf3cJOz94FFTsOlELaT/kPIVKJrBg+k1cQ1MQluup280XtZUZfCtWQmHxUZ
         CUVm/DX3h9Y1LQbhD8CshBW9OR2uGwVRZa9TCOjRIH4lQJfwZCBTQeK6Ov2ERhYYkn
         AW4s+oAhtSNRS0y7MPkqWPr2aajv4GYBug+etu14=
From:   Chao Yu <chao@kernel.org>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 0/9] staging: erofs: fix some issues and clean up codes
Date:   Tue, 21 Aug 2018 22:49:28 +0800
Message-Id: <20180821144937.20555-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

This patchset mainly adds error handing code for erofs xattr subsystem.
In addition, some code cleanups are also included in this patchset.

P.S. Some other patches are still previewing in the linux-erofs mailing
list, which will be posted in the 2nd part later.

[changelog]
v1 -> v2:
[PATCH 2/9] staging: erofs: separate erofs_get_meta_page
- Put err_out stuff at the bottom of the function.
- Drop the question mark in the "truncated by others?".
  Pointed out by Dan Carpenter <dan.carpenter@oracle.com>
- fix `PTR_ERR applied after initialization to constant'.
  Reported by kbuild test robot <lkp@intel.com>
- fix compilation error (erofs is bypassed by BROKEN...).

[PATCH 3/9] staging: erofs: add error handling for xattr submodule
- drop all likely/unlikely hints in this patch.
- fix bare use of 'unsigned *' at drivers/staging/erofs/xattr.c:168.
  Pointed out by Dan Carpenter <dan.carpenter@oracle.com>

[PATCH 6/9] staging: erofs: fix vle_decompressed_index_clusterofs
- don't make functions inline
  Pointed out by Dan Carpenter <dan.carpenter@oracle.com> 

[PATCH 9/9] staging: erofs: fix potential overflow in erofs_grab_bio()
- in addition, we add one more patch above to fix potential overflow
in this series.

Chao Yu (1):
  staging: erofs: fix potential overflow in erofs_grab_bio()

Gao Xiang (8):
  staging: erofs: introduce erofs_grab_bio
  staging: erofs: separate erofs_get_meta_page
  staging: erofs: add error handling for xattr submodule
  staging: erofs: cleanup z_erofs_vle_work_{lookup, register}
  staging: erofs: rearrange vle clustertype definitions
  staging: erofs: fix vle_decompressed_index_clusterofs
  staging: erofs: fix integer overflow on 32-bit platform
  staging: erofs: fix compression mapping beyond EOF

 drivers/staging/erofs/Kconfig     |   9 ++
 drivers/staging/erofs/data.c      |  68 +++++++++-----
 drivers/staging/erofs/erofs_fs.h  |  11 +++
 drivers/staging/erofs/internal.h  |  66 ++++++++-----
 drivers/staging/erofs/unzip_vle.c | 149 +++++++++++++++---------------
 drivers/staging/erofs/xattr.c     | 127 +++++++++++++++++--------
 6 files changed, 273 insertions(+), 157 deletions(-)

-- 
2.18.0

