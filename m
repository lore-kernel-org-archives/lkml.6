Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3734ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659F1214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="Wa98Uua4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659F1214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeIRBkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:03 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:38943 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIRBkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:02 -0400
Received: by mail-qk1-f181.google.com with SMTP id b19-v6so9726921qkc.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WcQyA5hHk/A0uPIiU2BBOfEvj9n7fTDcfk6JYXN+yvI=;
        b=Wa98Uua4/ryFzmFR48IHvj8eIU6SIbAGNLXJRM9YSP285d1CG/0A9xpid+oVAy9aFL
         NXqiGCBT1fsYqc+tmXtquJBXs8+LGaAHsIyRLwuNl/CIW25ZLbKdM1sxYbG45EAjuyF6
         7Km6wq1jzpWW7OzxYIE+gdMtD4NwrblE/WKL5nQrJm060e9LAKudkIdWp2yp7fvRJaoK
         GWCe/WYYtqj1m5pURTEbr3yNYQBlc4cdBhsqHVY0mlJBqaoCmBICA6PxogQl87+81avi
         2wQ6gmGSvMwMABMd2guL3V68PmZ2+3n19GaBRinioZ3JAz0gu2xm8W91kHov4QnGI++u
         i1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WcQyA5hHk/A0uPIiU2BBOfEvj9n7fTDcfk6JYXN+yvI=;
        b=M0AyFq/9RcGbJCsbY7IZlAYJDCdvrZUsgMJO/FJ6Tm5vEcUE/kkoNJIbTunHNEYaje
         o8OkocCGmF3mGEJ/cb1jxzf+coonLwWfuh0bEdXUFVbN1JfzfjWQ2tAq3FEZcwGEs0L3
         g5DZU1X/ar9xIJL9ImFqdg1nzY/MxnsOCe6H/6FrrPSzcrK47n2S8V8nNBKK8n9VIpqQ
         if7/BfL6/6QJyP1u1zwoSj1rVQ65mtL+4DJl01cj3QlbJoJFbR3AmroyxmPLrdOWNaRk
         Gd40HseMe0tFNgN6czqXyXl1FK8pKldEnyWXm2SBjO3ZX4eEDdWS/oW5JRgzLQhkyizm
         cT7g==
X-Gm-Message-State: APzg51AxjnnosPMFqOAOF78nq8n70T358Caz0ConkjJHJRn+4C++B1kA
        kpuY+nJbTG1veAwL2hfWRj49J0F60hY=
X-Google-Smtp-Source: ANB0Vdb+HEehTgg2mJDB7xRE4mfW1xTkj9G+7JMj2xhPogwLWAq2REJRbYV1oXeATdfb09oUjh4gdA==
X-Received: by 2002:a37:c04f:: with SMTP id o76-v6mr18350879qki.315.1537215070356;
        Mon, 17 Sep 2018 13:11:10 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:09 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 00/17] orangefs: page cache
Date:   Mon, 17 Sep 2018 20:10:37 +0000
Message-Id: <20180917201054.3530-1-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no major issues are found in review or in our testing, we intend to
submit this during the next merge window.

The goal of all this is to significantly reduce the number of network
requests made to the OrangeFS

First the xattr cache is needed because otherwise we make a ton of
getxattr calls from security_inode_need_killpriv.

Then there's some reorganization so inode changes can be cached.
Finally, we enable write_inode.

Then remove the old readpages.  Next there's some reorganization to
support readpage/writepage.  Finally, enable readpage/writepage which
is fairly straightforward except for the need to separate writes from
different uid/gid pairs due to the design of our server.

Martin Brandenburg (17):
  orangefs: implement xattr cache
  orangefs: do not invalidate attributes on inode create
  orangefs: simply orangefs_inode_getattr interface
  orangefs: update attributes rather than relying on server
  orangefs: hold i_lock during inode_getattr
  orangefs: set up and use backing_dev_info
  orangefs: let setattr write to cached inode
  orangefs: reorganize setattr functions to track attribute changes
  orangefs: remove orangefs_readpages
  orangefs: service ops done for writeback are not killable
  orangefs: migrate to generic_file_read_iter
  orangefs: implement writepage
  orangefs: skip inode writeout if nothing to write
  orangefs: write range tracking
  orangefs: avoid fsync service operation on flush
  orangefs: use kmem_cache for orangefs_write_request
  orangefs: implement writepages

 fs/orangefs/acl.c             |   4 +-
 fs/orangefs/file.c            | 193 ++++--------
 fs/orangefs/inode.c           | 576 +++++++++++++++++++++++++++-------
 fs/orangefs/namei.c           |  41 ++-
 fs/orangefs/orangefs-cache.c  |  24 +-
 fs/orangefs/orangefs-kernel.h |  56 +++-
 fs/orangefs/orangefs-mod.c    |  10 +-
 fs/orangefs/orangefs-utils.c  | 181 +++++------
 fs/orangefs/super.c           |  38 ++-
 fs/orangefs/waitqueue.c       |  18 +-
 fs/orangefs/xattr.c           | 104 ++++++
 11 files changed, 839 insertions(+), 406 deletions(-)

-- 
2.19.0

