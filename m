Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B76C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D9721724
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D9721724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbeHCEAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:00:22 -0400
Received: from nautica.notk.org ([91.121.71.147]:58896 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeHCEAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:00:22 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 70159C009; Fri,  3 Aug 2018 04:06:23 +0200 (CEST)
Date:   Fri, 3 Aug 2018 04:06:08 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     Greg Kurz <groug@kaod.org>, Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH v2] net/9p/trans_virtio.c: add null
 terminal for mount tag
Message-ID: <20180803020608.GA15635@nautica>
References: <5B6262F4.9080601@huawei.com>
 <20180802015439.GA27403@nautica>
 <5B62658A.3010605@huawei.com>
 <20180802152339.194c2820@bahia.lan>
 <5B63B3CE.3040601@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B63B3CE.3040601@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Fri, Aug 03, 2018:
> We'd better reach an agreement about the patch fix.

The way I read Greg's comment was that he agreed to the proposed changes
and is waiting for a new version.


I'm writing a longer reply than I should because I don't like people
saying strncmp is safe just because it's strncmp, feel free to skim
through the rest as it's just ranting.


> In my opinion, replacing strlen(chan->tag) with a local variable
> sounds reasonable,

So we agree here

> and changing strncmp to strcmp may be little beneficial, as strcmp is more
> dangerours such as buffer-flow.

strcmp is more dangerous for buffer-overflow if you're comparing
"unsafe" non-null terminated strings.
This isn't the case here as you've constructed chan->tag yourself and
you rely on it being null-terminated by calling strlen() on it yourself.

strncmp(x, y, strlen(y)+1) is at best awkward, but it's a false sense of
security if you think this is any better than strcmp here. It implies that:
 - y is null-terminated (for strlen() to work)
 - x is either null-terminated or longer than y

Here, x is the devname argument to p9_virtio_create, which comes
straight from the mount syscall with "copy_mount_string", using
strndup_user, which returns a null-terminated string or an error.

(the code is currently not safe if it returns an error, I'm sending
another mail about it right after this one as we already have a partial
fix)


strcmp(x, y) on the other hand assumes that x and y are null-terminated
in this case, which is the same assumptions you have, so is strictly as
"safe" as strncmp used that way.
(it could also assume that one is null terminated and the other one is
at least as long as that, e.g. when comparing a "char buf[42]" to the
constant "foo" then we don't care if buf is null-terminated)


Thanks,
-- 
Dominique

