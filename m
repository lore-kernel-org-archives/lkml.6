Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1148518-1519980977-2-1654718057519463380
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519980976; b=vrYak3spndTw6A9Klk25VkFbIuyJqQ1HuwxhHlHMrNiYf+0
    yM255aCLwxsvFseTQf/td2mqTGC0Ou4sLLCJdnNE7E/aoWhrd+XkowmlkjpYnFZV
    UA4C8NJ+50mHYJOpHtJu4oQZjCywZ7bP12xYJCERifRIBvrbOotVHUU5hv34z2pn
    2g69T0J8icyjkpDa5OmpTzfQMaAxLy6qjvQxI+jLv8r3JtOSw2+/aS5k0i1MKAci
    ANXZB+sEsc368YQUMaknlGYhS3YReFIglPSGGNZv/w8mYrDDxiGqj+fiS3sIQv13
    xOmE6/xKHSGmYKSGjMKBDvonq0yCuP2vuHEj6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519980976; bh=E7qUWat1UlVPy3VsQZ/S7buabr
    Dss34VfHXlxxt+ybU=; b=SkqPOzb5FhQh5IZuEenhUoTNeI0ZJEz6ubNAaL2Py/
    F1scuwaZrUaSU+xUv/fj2jQmhlzEfRYoYANwsm5CokIiaivDz5oAJ3QCVdma6Rpq
    leWuULG+9ZiA+L2ylL2gtOpjg8OeFLauw0olvcn8hq8/Yk2FPCOYNk52kQVlnjTR
    NcRrd61pIezOLEMKqu99dqYaEZk52kEYy/jzwuDG1Nq1B/TnjNRwRzw1d+jdx55o
    SSPPpSRNsw3qv/kAXN4dtpB8ZNoijQutwH2tXqIJEk6sp1CRDe4qXsI6VR2ZA23x
    QsC1hiMyaqiAGedkUPRzSPL9cat36mEjyptqPv+OVDPw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423798AbeCBI4L (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:56:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51014 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423748AbeCBI4J (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:56:09 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlei He <heyunlei@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4.9 03/56] f2fs: fix a bug caused by NULL extent tree
Date: Fri,  2 Mar 2018 09:50:49 +0100
Message-Id: <20180302084449.823884285@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunlei He <heyunlei@huawei.com>

commit dad48e73127ba10279ea33e6dbc8d3905c4d31c0 upstream.

Thread A:					Thread B:

-f2fs_remount
    -sbi->mount_opt.opt = 0;
						<--- -f2fs_iget
						         -do_read_inode
							     -f2fs_init_extent_tree
							         -F2FS_I(inode)->extent_tree is NULL
        -default_options && parse_options
	    -remount return
						<---  -f2fs_map_blocks
						          -f2fs_lookup_extent_tree
                                                              -f2fs_bug_on(sbi, !et);

The same problem with f2fs_new_inode.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/extent_cache.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -177,7 +177,7 @@ static void __drop_largest_extent(struct
 }
 
 /* return true, if inode page is changed */
-bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
+static bool __f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et;
@@ -215,6 +215,16 @@ out:
 	return false;
 }
 
+bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
+{
+	bool ret =  __f2fs_init_extent_tree(inode, i_ext);
+
+	if (!F2FS_I(inode)->extent_tree)
+		set_inode_flag(inode, FI_NO_EXTENT);
+
+	return ret;
+}
+
 static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 							struct extent_info *ei)
 {
