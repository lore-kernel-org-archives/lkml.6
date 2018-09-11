Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB38C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7831020865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7831020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeIKLth convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:49:37 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6036 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbeIKLth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:49:37 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 61CA1DFFDB9DE;
        Tue, 11 Sep 2018 14:51:43 +0800 (CST)
Received: from DGGEMM507-MBS.china.huawei.com ([169.254.3.21]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0399.000;
 Tue, 11 Sep 2018 14:51:43 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Eric Paris <eparis@parisplace.org>,
        "rlove@rlove.org" <rlove@rlove.org>,
        "john@johnmccutchan.com" <john@johnmccutchan.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Is it possible to add pid and comm members to the event structure
 to increase the display of user and thread information?
Thread-Topic: Is it possible to add pid and comm members to the event
 structure to increase the display of user and thread information?
Thread-Index: AdRJmkzwtMeGnSbeRVCa8sLtVjSk6w==
Date:   Tue, 11 Sep 2018 06:51:43 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A7A1814@dggemm507-mbs.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inotify api cannot display information about users and processes.
That is, you can only know that the file event is generated, but you don't know who triggered the event, which is not conducive to fault location.
Is it possible to add pid and comm members to the event structure to increase the display of user and thread information?

Example:
diff --git a/fs/notify/inotify/inotify.h b/fs/notify/inotify/inotify.h
index 7e4578d..be91844 100644
--- a/fs/notify/inotify/inotify.h
+++ b/fs/notify/inotify/inotify.h
@@ -7,6 +7,8 @@ struct inotify_event_info {
        struct fsnotify_event fse;
        int wd;
        u32 sync_cookie;
+ int pid;
+ char comm[TASK_COMM_LEN];
        int name_len;
        char name[];
 };
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index f4184b4..f7ad298 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -117,6 +117,8 @@ int inotify_handle_event(struct fsnotify_group *group,
        fsnotify_init_event(fsn_event, inode, mask);
        event->wd = i_mark->wd;
        event->sync_cookie = cookie;
+ event->pid = current->pid;
+ strncpy(event->comm, current->comm, TASK_COMM_LEN);
        event->name_len = len;
        if (len)
                strcpy(event->name, file_name);

