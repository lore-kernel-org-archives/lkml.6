Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97F4C6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FF22084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 00:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FF22084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJHHQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 03:16:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40210 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJHHQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 03:16:26 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9J53-0000Oh-0p; Mon, 08 Oct 2018 00:07:25 +0000
Date:   Mon, 8 Oct 2018 01:07:24 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     syzbot <syzbot+c54f8e94e6bba03b04e9@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in getname_kernel
Message-ID: <20181008000724.GB32577@ZenIV.linux.org.uk>
References: <0000000000006533a60577ac1419@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006533a60577ac1419@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 04:44:03PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    c1d84a1b42ef Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f3c6a1400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
> dashboard link: https://syzkaller.appspot.com/bug?extid=c54f8e94e6bba03b04e9
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10688159400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1162aa31400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c54f8e94e6bba03b04e9@syzkaller.appspotmail.com

Umm...  See if this helps:
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c2469833b4fb..6b84ef6ccff3 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1333,6 +1333,9 @@ static struct dentry *gfs2_mount_meta(struct file_system_type *fs_type,
 	struct path path;
 	int error;
 
+	if (!dev_name || !*dev_name)
+		return ERR_PTR(-EINVAL);
+
 	error = kern_path(dev_name, LOOKUP_FOLLOW, &path);
 	if (error) {
 		pr_warn("path_lookup on %s returned error %d\n",
