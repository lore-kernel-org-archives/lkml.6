Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL94jdDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 10CB460767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbeFFPWb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:22:31 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45539 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeFFPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:22:29 -0400
X-Google-Smtp-Source: ADUXVKKh//NyPlC/BjzVnN93jj0aSqSUPakt+CJa6MNqnNOHJgCvX7ssGXJXqBw9jYItqDoGRgjinQ==
Date: Wed, 6 Jun 2018 08:22:26 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>
Subject: Re: [GIT PULL] cgroup changes for v4.18-rc1
Message-ID: <20180606152226.GN1351649@devbig577.frc2.facebook.com>
References: <20180605192157.GG1351649@devbig577.frc2.facebook.com>
 <CA+55aFzWdPavAPC--MY15RgwvU1QYgF+Uy7rMJmx2Dr3ddJdsQ@mail.gmail.com>
 <20180606150438.GM1351649@devbig577.frc2.facebook.com>
 <CA+55aFy=a3nm+r7462mLq4D6eDxDsPXUO3_tviT=DqJPsohx5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFy=a3nm+r7462mLq4D6eDxDsPXUO3_tviT=DqJPsohx5A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 08:14:27AM -0700, Linus Torvalds wrote:
> On Wed, Jun 6, 2018 at 8:04 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > The notification implementation isn't super light weight, so the patch
> > ratelimits the notifications by capping minimum notification interval
> > interval to 10ms.
> 
> Yeah, I looked at the patch (and the code) to make sense of the explanation.
> 
> My reaction to that was that it might be a better idea to simply not
> notify if a notification was already pending, rather than have the
> timeout. Or perhaps in addition to. The path _to_ the fsnotify code
> looked quite messy, though.

Yeah, getting to the inode is currently quite involved.  Some of the
complications come from the fact that a kernfs node can be associated
with multiple inodes for sysfs namespace support.

The right thing to do could be linking the inodes to the kernfs node
and protect it with a spinlock so that we don't have to punt and walk
them directly from notification path.

For now, I think the 10ms thing is an acceptable workaround but this
likely needs more work in the future.

Thanks.

-- 
tejun
