Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44305C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DAE20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DAE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754261AbeFTPk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:40:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:34739 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751337AbeFTPkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:40:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 08:40:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,248,1526367600"; 
   d="scan'208";a="51462247"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2018 08:40:55 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 14E70300D7B; Wed, 20 Jun 2018 08:40:55 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        y2038@lists.linaro.org, Andi Kleen <andi.kleen@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@redhat.com>, Jan Kara <jack@suse.cz>,
        Brian Foster <bfoster@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: replace current_kernel_time64 with ktime equivalent
References: <20180620150138.49380-1-arnd@arndb.de>
Date:   Wed, 20 Jun 2018 08:40:55 -0700
In-Reply-To: <20180620150138.49380-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 20 Jun 2018 17:01:24 +0200")
Message-ID: <87r2l1sby0.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
>
> I traced the original addition of the current_kernel_time() call to set
> the nanosecond fields back to linux-2.5.48, where Andi Kleen added a
> patch with subject "nanosecond stat timefields". This adds the original
> call to current_kernel_time and the truncation to the resolution of the
> file system, but makes no mention of the intended accuracy.  At the time,
> we had a do_gettimeofday() interface that on some architectures could
> return a microsecond-resolution timestamp, but there was no interface
> for getting an accurate timestamp in nanosecond resolution, neither inside
> the kernel nor from user space. This makes me suspect that the use of
> coarse timestamps was never really a conscious decision but instead
> a result of whatever API was available 16 years ago.

Kind of. VFS/system calls are expensive enough that you need multiple us
in and out so us resolution was considered good enough.

Also if you do this change you really need to do some benchmarks,
especially on setups without lazy atime. This might potentially
cause a lot more inode flushes.

-Andi
