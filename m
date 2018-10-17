Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3ECC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFC1214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFC1214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeJQI2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:28:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49046 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbeJQI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:28:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCZoS-0001Bz-W3; Wed, 17 Oct 2018 00:35:49 +0000
Date:   Wed, 17 Oct 2018 01:35:48 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        adobriyan@gmail.com, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH v3 2/2] sysctl: handle overflow for file-max
Message-ID: <20181017003548.GA32577@ZenIV.linux.org.uk>
References: <20181016223322.16844-1-christian@brauner.io>
 <20181016223322.16844-3-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016223322.16844-3-christian@brauner.io>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:33:22AM +0200, Christian Brauner wrote:
> Currently, when writing
> 
> echo 18446744073709551616 > /proc/sys/fs/file-max
> 
> /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> crashes the system.
> This commit sets the max and min value for file-max and returns -EINVAL
> when a long int is exceeded. Any higher value cannot currently be used as
> the percpu counters are long ints and not unsigned integers. This behavior
> also aligns with other tuneables that return -EINVAL when their range is
> exceeded. See e.g. [1], [2] and others.

Mostly sane, but...  get_max_files() users are bloody odd.  The one in
file-max limit reporting looks like a half-arsed attempt in "[PATCH] fix
file counting".  The one in af_unix.c, though...  I don't remember how
that check had come to be - IIRC that was a strange fallout of a thread
with me, Andrea and ANK involved, circa 1999, but I don't remember details;
Andrea, any memories?  It might be worth reconsidering...  The change in
question is in 2.2.4pre6; what do we use unix_nr_socks for?  We try to
limit the number of PF_UNIX socks by 2 * max_files, but max_files can be
huge *and* non-constant (i.e. it can decrease).  What's more, unix_tot_inflight
is unsigned int and max_files might exceed 2^31 just fine since "fs: allow
for more than 2^31 files" back in 2010...  Something's fishy there...
