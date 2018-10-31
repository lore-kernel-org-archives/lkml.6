Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85D6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6855E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6855E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbeKABRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:17:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59055 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbeKABRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:17:53 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHtD5-0006Sv-Kl; Wed, 31 Oct 2018 10:19:11 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gHtCp-0008Nr-8q; Wed, 31 Oct 2018 10:19:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181031053355.GQ32577@ZenIV.linux.org.uk>
        <87a7mut9cm.fsf@xmission.com>
Date:   Wed, 31 Oct 2018 11:18:24 -0500
In-Reply-To: <87a7mut9cm.fsf@xmission.com> (Eric W. Biederman's message of
        "Wed, 31 Oct 2018 10:38:17 -0500")
Message-ID: <87d0rqqecv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gHtCp-0008Nr-8q;;;mid=<87d0rqqecv.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+hXy997IJhcJu94YVdw0aXyeQZAL7lzeQ=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [git pull] mount API series
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> I am going to stop there.  I believe there are more issues in the code.
> I am relieved that I am not seeing the loss of some of the security
> hooks that I thought I saw last time I looked at the code.

Bah.  Now I see the missing security hook.

There are a set of security hooks that allow security modules to parse
mount options.

On a good day they look like:

	security_mnt_opts opts;
        char *secdata;
        
	secdata = alloc_secdata();
        security_sb_copy_data("a,mount,options,string", secdata);

	security_init_mnt_opts(&opts);
	security_parse_opts_str(secdata, &opts);
        security_set_mnt_opts(sb, &opts, 0, NULL);
	security_free_mnt_opts(&opts);

In practice however things are not that explicit.  With
security_sb_kern_mount performing all of the mnt_opts work.

However after the rewrite in the patchset.

The function sb_kern_mount no longer exists and it's replacement
sb_get_tree out of necessity does not call parse_opts_str.  This is
because the mount options can no longer be passed as a string.

The legacy compatibility code also does not call sb_parse_opts_str.

The result is using the existing apis all of the security module command
line parsing except for (btrfs and nfs) no longer works.


The changes are not structured in a way that makes any of this easy to
find.  Which is why I have been saying I wouldn't do it that way.  It
also is the case that this pattern repeats through out the patches.
Replacing code with something brand new, instead of evolving what is
there.  That makes it easy for this kind of thing to slip through.

Eric
