Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171D4C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BEE235FB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="ThBEaqOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BEE235FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965398AbeF0OJm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:09:42 -0400
Received: from imap.thunk.org ([74.207.234.97]:60692 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932312AbeF0OJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=elwyV6RvddMTNwKBo7+XXjPohjV6LeW7TYtH5KK2/84=; b=ThBEaqOzlNU0iyz8Js7apjOTvv
        BY9WwK/knPryRj8BZAGIv+MfLsXKkVADae0mPgHhbY+5e4I+Pmx2rzzA3uWn3F6aTt7obUaJN8NG8
        xfpEBw3tUavP53NfphyOrETL5dNWFHEW82Z4LRD1sev1otAXBx3i+kl7/NRFY+NO+H3c=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fYB8c-0008Fo-E7; Wed, 27 Jun 2018 14:09:38 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8A1157A4481; Wed, 27 Jun 2018 10:09:37 -0400 (EDT)
Date:   Wed, 27 Jun 2018 10:09:37 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     GaoMing <gaoming20@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        sorp.liqingchao@huawei.com, harry.shen@huawei.com,
        miaoxie@huawei.com
Subject: Re: [PATCH] ext4: e2fsprogs: fix inode bitmap num not
 integer,incompatible for ancient android devices
Message-ID: <20180627140937.GA3348@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        GaoMing <gaoming20@huawei.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sorp.liqingchao@huawei.com,
        harry.shen@huawei.com, miaoxie@huawei.com
References: <1530014046-62466-1-git-send-email-gaoming20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530014046-62466-1-git-send-email-gaoming20@huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 07:54:06PM +0800, GaoMing wrote:
> for example, 1708 inodes every group,3 block groups, bitmap bytes are 1708/8=213.5 when the inode bitmap has some errors, e2fsprogs cannot fix it
>
> Signed-off-by: GaoMing <gaoming20@huawei.com>

File systems like this should not exist.  Can you please please please
make sure that any use of make_ext2fs are ripped out by the roots?

What I *should* do is have e2fsck reject these file systems as
completely invalid in pass 0, when we check for superblock sanity.  I
haven't because there are some older Android systems that use
make_ext2fs.  But at this point, what I am **seriously** doing is to
make e2fsck reject these file systems by default, unless a setting in
e2fsck.conf is set to allow them as an exception.

My concern about applying this patch is that it will be taken as
acceptance of e2fsprogs to fully support these sorts of invalid file
systems.  In particular, there is no guarantee that various tune2fs
options, resize2fs, etc., will work correctly even with your patch.

	 	    	       	    	      - Ted
