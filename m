Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE92C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EAB20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EAB20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754291AbeFTQTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:19:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:18445 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752983AbeFTQTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:19:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 09:19:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,248,1526367600"; 
   d="scan'208";a="58861419"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2018 09:19:18 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 343FA300D7B; Wed, 20 Jun 2018 09:19:18 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Brian Foster <bfoster@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH] vfs: replace current_kernel_time64 with ktime equivalent
References: <20180620150138.49380-1-arnd@arndb.de>
        <87r2l1sby0.fsf@linux.intel.com>
        <CAK8P3a1J9j7pz-d+otbJweWgOZZePdaMJEb_sU2GJKi3oYq7Xg@mail.gmail.com>
Date:   Wed, 20 Jun 2018 09:19:18 -0700
In-Reply-To: <CAK8P3a1J9j7pz-d+otbJweWgOZZePdaMJEb_sU2GJKi3oYq7Xg@mail.gmail.com>
        (Arnd Bergmann's message of "Wed, 20 Jun 2018 18:14:50 +0200")
Message-ID: <87muvpsa61.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
>
> To clarify: current_kernel_time() uses at most millisecond resolution rather
> than microsecond, as tkr_mono.xtime_nsec only gets updated during the
> timer tick.

Ah you're right. I remember now: the motivation was to make sure there
is basically no overhead. In some setups the full gtod can be rather
slow, particularly if it falls back to some crappy timer.

I think it would be ok if it falls back to jiffies if TSC or a similar
fast timer doesn't work. But the function you're using likely
doesn't do that?

> Has that time scale changed over the past 16 years as CPUs got faster
> (and system call entry times slower down again with recent changes)?

Maybe a bit, but not substantially.



-Andi
