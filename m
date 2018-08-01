Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F9EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F62208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F62208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389269AbeHALXY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:23:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6397 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389005AbeHALXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:23:24 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id D9391BAF972FC;
        Wed,  1 Aug 2018 17:24:03 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.382.0; Wed, 1 Aug 2018 17:24:04 +0800
Received: from DGGEMM507-MBX.china.huawei.com ([169.254.1.75]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0382.000;
 Wed, 1 Aug 2018 17:23:57 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "eparis@parisplace.org" <eparis@parisplace.org>,
        "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        Lizefan <lizefan@huawei.com>, "miaoxie (A)" <miaoxie@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: maybe resource leak in security/selinux/selinuxfs.c
Thread-Topic: maybe resource leak in security/selinux/selinuxfs.c
Thread-Index: AdQpeVHZ6C+RBxudSMK/r1O5xUSIwQ==
Date:   Wed, 1 Aug 2018 09:23:57 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A72A2C9@dggemm507-mbx.china.huawei.com>
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

advisory:
1 After creating dentry in d_alloc_name, should I call dput to release resources before the exception exit?
2 After calling the new_inode to create an inode, should the inode resource be released before the exception exit?

If the dentry and inode resources need to be actively released, there are multiple resource leaks in security/selinux/selinuxfs.c.

Example:
Linux master branch v4.18-rc5
The function sel_make_avc_files in security/selinux/selinuxfs.c.

1566 static int sel_make_avc_files(struct dentry *dir)
.......
1580     for (i = 0; i < ARRAY_SIZE(files); i++) {
1581         struct inode *inode;
1582         struct dentry *dentry;
1583
1584         dentry = d_alloc_name(dir, files[i].name);
1585         if (!dentry)
/*Resource leak: when i!=0, the release action of dentry and inode resources is missing*/
1586             return -ENOMEM;
1587
1588         inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
1589         if (!inode)
/*Resource leak: missing dput(dentry)*/
/*Resource leak: when i!=0, the release action of dentry and inode resources is missing*/
1590             return -ENOMEM;
1591
1592         inode->i_fop = files[i].ops;
1593         inode->i_ino = ++fsi->last_ino;
1594         d_add(dentry, inode);
1595     }
1596
1597     return 0;
1598 }

There are similar resource leaking functions:
Sel_make_bools
Sel_make_avc_files
Sel_make_initcon_files
Sel_make_perm_files
Sel_make_class_dir_entries
Sel_make_policycap
Sel_fill_super
Sel_make_policy_nodes
Sel_make_classes
