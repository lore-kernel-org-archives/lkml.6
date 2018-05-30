Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753474AbeE3OWJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:22:09 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39896 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932094AbeE3OWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:22:04 -0400
X-Google-Smtp-Source: ADUXVKKpD8zFSS7aKdThgalONgGrtQ43/ejXrH5zUwPMS9jR/OrcEvhJvP645V2Ljz3x7hu03LB3kstCnZHibZ8JXSA=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180206162518.tdoszuggqxpkrqvn@quack2.suse.cz>
References: <20180202175328.GL1121507@devbig577.frc2.facebook.com>
 <20180202175414.GM1121507@devbig577.frc2.facebook.com> <20180206162518.tdoszuggqxpkrqvn@quack2.suse.cz>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 30 May 2018 16:22:02 +0200
Message-ID: <CAJfpegu5UWjZJvt119JOwi7MMYEG3Gq5DmL01ndaG5wgBzPHxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] FUSE: fix congested state leak on aborted connections
To: Jan Kara <jack@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Joshua Miller <joshmiller@fb.com>, kernel-team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>, stable <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 5:25 PM, Jan Kara <jack@suse.cz> wrote:
> On Fri 02-02-18 09:54:14, Tejun Heo wrote:
>> If a connection gets aborted while congested, FUSE can leave
>> nr_wb_congested[] stuck until reboot causing wait_iff_congested() to
>> wait spuriously which can lead to severe performance degradation.
>>
>> The leak is caused by gating congestion state clearing with
>> fc->connected test in request_end().  This was added way back in 2009
>> by 26c3679101db ("fuse: destroy bdi on umount").  While the commit
>> description doesn't explain why the test was added, it most likely was
>> to avoid dereferencing bdi after it got destroyed.
>>
>> Since then, bdi lifetime rules have changed many times and now we're
>> always guaranteed to have access to the bdi while the superblock is
>> alive (fc->sb).
>>
>> Drop fc->connected conditional to avoid leaking congestion states.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Reported-by: Joshua Miller <joshmiller@fb.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: stable@vger.kernel.org
>
> Yeah, this should be fine AFAICT but my knowledge of FUSE is very cursory.
> Anyway:
>
> Acked-by: Jan Kara <jack@suse.cz>

Can't say I fully understand how the global "is any bdi congested"
state is used in direct reclaim, but the patch is an obvious
improvement, so applied.

Thanks,
Miklos
