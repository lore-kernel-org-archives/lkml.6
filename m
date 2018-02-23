Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519418711-2-17146553757121611880
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519418711; b=tPuGOu7tbIHJNUDBuOkVX8gDTYoeLYk7sUFDZcQubcqOEbP
    U3kmsWysVLnx2+ZrLD9S0LbfCIfudORys0tS6F9PXS22BFmT3uCBrNON0Icf+utS
    Hve8q78HcMpI2SMgjAwWmU2ECAu9n40SAOzXnY0vGEniQgAkPnKA/FcTG5+mipr6
    hCPxepDSYsD/1ljq+cqbrP5SaN75fyqTi1uVASVYK5bek+lIDA5iLVrEjvaZo98z
    OrKvDkfn49GhxCYUES3MJs4+G+y2IkH2+1PEdwJwiJ39NDz+gVncU17Ny4/ts8I1
    HthMQKkY3tsdxO6/A5gol7T0a/CUiBYC0eepYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418711; bh=63/h/IEyh+GioXRaum2Phr3VI2
    KtsNo0oOhKRe84vg8=; b=EH/ElWmnyXbDI6XBOVZYi7EQAuToewwZoExiV5X4XS
    zDygDbu9kxzChrw+fcabZwPhlDI7OpsPa7GjsLNDLTUNKGhqKcMsQB9763FwuflD
    qG4OMVlQwaR0IblinaUdb1wcBWOiPxlRLGQ7IJc3MfAa4z6g6jRHdDNvRJSrGGND
    d0dNa2hHVsKXCSWKwIvAXgSYdxnnUC/QKK+3/158ie+vheYknjF4LOcSIb38cP5C
    j7pLQ7XqHrUUfN3Jm/iJhDF86Or3tQePVzI/I7QcNHj6gAbCdjGTjF4CkRubgYNj
    p7pb+2tpdpmkDquTo8xwzaYO3foxG8KytiEPHkcn/6Ig==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753104AbeBWUoz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:44:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36280 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbeBWScm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:32:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 48/58] btrfs: Fix possible off-by-one in btrfs_search_path_in_tree
Date: Fri, 23 Feb 2018 19:26:47 +0100
Message-Id: <20180223170214.332959821@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>


[ Upstream commit c8bcbfbd239ed60a6562964b58034ac8a25f4c31 ]

The name char array passed to btrfs_search_path_in_tree is of size
BTRFS_INO_LOOKUP_PATH_MAX (4080). So the actual accessible char indexes
are in the range of [0, 4079]. Currently the code uses the define but this
represents an off-by-one.

Implications:

Size of btrfs_ioctl_ino_lookup_args is 4096, so the new byte will be
written to extra space, not some padding that could be provided by the
allocator.

btrfs-progs store the arguments on stack, but kernel does own copy of
the ioctl buffer and the off-by-one overwrite does not affect userspace,
but the ending 0 might be lost.

Kernel ioctl buffer is allocated dynamically so we're overwriting
somebody else's memory, and the ioctl is privileged if args.objectid is
not 256. Which is in most cases, but resolving a subvolume stored in
another directory will trigger that path.

Before this patch the buffer was one byte larger, but then the -1 was
not added.

Fixes: ac8e9819d71f907 ("Btrfs: add search and inode lookup ioctls")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ added implications ]
Signed-off-by: David Sterba <dsterba@suse.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2233,7 +2233,7 @@ static noinline int btrfs_search_path_in
 	if (!path)
 		return -ENOMEM;
 
-	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX];
+	ptr = &name[BTRFS_INO_LOOKUP_PATH_MAX - 1];
 
 	key.objectid = tree_id;
 	key.type = BTRFS_ROOT_ITEM_KEY;
