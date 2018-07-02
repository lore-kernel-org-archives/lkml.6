Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD8BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 04:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67BF256AB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 04:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67BF256AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeGBElc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 00:41:32 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12058 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753118AbeGBElZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 00:41:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b39acf20000>; Sun, 01 Jul 2018 21:41:22 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 01 Jul 2018 21:41:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 01 Jul 2018 21:41:24 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Jul
 2018 04:41:23 +0000
Subject: Re: [PATCH v2 4/6] mm/fs: add a sync_mode param for
 clear_page_dirty_for_io()
To:     kbuild test robot <lkp@intel.com>, <john.hubbard@gmail.com>
CC:     <kbuild-all@01.org>, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20180702005654.20369-5-jhubbard@nvidia.com>
 <201807020900.J6omiRbx%fengguang.wu@intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b98be1bd-89dd-8b76-20f6-8f440dc3ba44@nvidia.com>
Date:   Sun, 1 Jul 2018 21:40:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <201807020900.J6omiRbx%fengguang.wu@intel.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2018 07:47 PM, kbuild test robot wrote:
> Hi John,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.18-rc3]
> [cannot apply to next-20180629]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/john-hubbard-gmail-com/mm-fs-gup-don-t-unmap-or-drop-filesystem-buffers/20180702-090125
> config: i386-randconfig-x075-201826 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    fs/f2fs/dir.c: In function 'f2fs_delete_entry':
>>> fs/f2fs/dir.c:734:33: error: 'WB_SYNC_ALL' undeclared (first use in this function); did you mean 'FS_SYNC_FL'?
>       clear_page_dirty_for_io(page, WB_SYNC_ALL);
>                                     ^~~~~~~~~~~
>                                     FS_SYNC_FL

Fixed locally, via:

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 258f9dc117f4..ca20c1262582 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -16,6 +16,7 @@
 #include "acl.h"
 #include "xattr.h"
 #include <trace/events/f2fs.h>
+#include <linux/writeback.h>
 
 static unsigned long dir_blocks(struct inode *inode)
 {



thanks,
-- 
John Hubbard
NVIDIA
