Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7BFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662C6204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662C6204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeIJHyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:54:40 -0400
Received: from smtp-out-no.shaw.ca ([64.59.134.13]:58192 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeIJHyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:54:40 -0400
X-Greylist: delayed 18536 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Sep 2018 03:54:39 EDT
Received: from fanir.tuyoix.net ([68.150.218.192])
        by shaw.ca with ESMTP
        id z7f8fwEklWppDz7f9fTzwb; Sun, 09 Sep 2018 15:54:36 -0600
X-Authority-Analysis: v=2.3 cv=YIcrNiOx c=1 sm=1 tr=0
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=JBFolyDoGHsA:10 a=nlC_4_pT8q9DhB4Ho9EA:9 a=3I1X_3ewAAAA:8
 a=OxNYDVJMC5hWt7gQjnkA:9 a=QEXdDO2ut3YA:10 a=VG9N9RgkD3hcbI6YpJ1l:22
Received: from CLUIJ (cluij.tuyoix.net [192.168.144.15])
        (authenticated bits=0)
        by fanir.tuyoix.net (8.15.2/8.15.2) with ESMTPSA id w89LsWgO015563
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 9 Sep 2018 15:54:33 -0600
Date:   Sun, 9 Sep 2018 15:54:19 -0600 (Mountain Daylight Time)
From:   Marc Aurele La France <tsi@tuyoix.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: sysfs:  Do not return POSIX ACL xattrs via listxattr()
Message-ID: <alpine.LNX.2.20.1809091544070.15534@fanir.tuyoix.net>
User-Agent: Alpine 2.20 (WNT 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="79591-22480-1536530061=:4216"
X-CMAE-Envelope: MS4wfE7BOFHeJIs/jCQu2lY2bQx8vbMOZyBDzScoYtPfC87HnWNLCFh09wx0EGwHwbFHGP51/XHy87u6MmZYdjMsJ/vRJDanfl45eKcSr3lgCpTHGUnKewf5
 eId1nUtKE+7g19l6IJzwto02WJ+UctX9vv5O1+BXKqHUcSWkhF9zJjY3Fie168X7eVB4RyidnhkBYep8JvlIIbLKK9HcNNFIWFFw1zoHD4IXvMPPdImlrW/r
 yfqmz7vyz9a006x/lKMfp5eIQYna0ugbCVAnpA3fj53IBhQNJJuvCjauplqL/CkRU2P4gXjlOkfQYXwpcu5gWgFU+p+jHrI1QYgPMPk+4RbVC1qUNiwgypNP
 077IXSxeO+nS/xlpeOWQR4eWfIjvng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--79591-22480-1536530061=:4216
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Greetings.

Commit 786534b92f3ce68f4afc8a761c80b76887797b0a "tmpfs: listxattr
should include POSIX ACL xattrs", which first appeared in 4.5 kernels,
introduced a regression whereby listxattr() syscalls on anything in
sysfs, or its mountpoint, return the name of the two POSIX ACL xattrs,
but attempts to retrieve these values are denied with EOPNOTSUP.  For
example ...

        # getfattr -d --match=- /sys
        /sys: system.posix_acl_access: Operation not supported
        /sys: system.posix_acl_default: Operation not supported
        #

This inconsistent behaviour confuses rsync(1) (among others) when it
runs into a sysfs mountpoint, even when told to not descend into it.
This issue occurs because simple_xattr_list() does not correctly deal
with cached ACLs.

The suggested fix below was developed with a 4.18.7 kernel, but should
apply, modulo patch fuzz, to any kernel >= 4.7.  A fix for 4.5 <=
kernels < 4.7 is trivially different, but I won't bother given such
kernels are no longer maintained.

Note that the only other simple_xattr_list() caller, shmem, avoids
this glitch by previously calling cache_no_acl() on all inodes it
creates, so perhaps sysfs/kernfs should do the same.

Please Reply-To-All.

Thanks and have a great day.

Marc.

Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>

--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -949,13 +949,13 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	int err = 0;

 #ifdef CONFIG_FS_POSIX_ACL
-	if (inode->i_acl) {
+	if (inode->i_acl && !is_uncached_acl(inode->i_acl)) {
 		err = xattr_list_one(&buffer, &remaining_size,
 				     XATTR_NAME_POSIX_ACL_ACCESS);
 		if (err)
 			return err;
 	}
-	if (inode->i_default_acl) {
+	if (inode->i_default_acl && !is_uncached_acl(inode->i_default_acl)) {
 		err = xattr_list_one(&buffer, &remaining_size,
 				     XATTR_NAME_POSIX_ACL_DEFAULT);
 		if (err)
--79591-22480-1536530061=:4216--
