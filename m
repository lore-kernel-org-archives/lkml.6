Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDDNzU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:55:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750853AbeDDNzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:55:19 -0400
Subject: Re: REGRESSION/TEST FAILURE caused by DEBUG_RWSEMS
To: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
References: <20180404132354.GA13897@thunk.org>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Cc: Ingo Molnar <mingo@redhat.com>
Message-ID: <5670badd-0268-8a06-6612-b58eb6a304b6@redhat.com>
Date: Wed, 4 Apr 2018 09:55:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180404132354.GA13897@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2018 09:23 AM, Theodore Y. Ts'o wrote:
> The commit 5149cbac4235: "locking/rwsem: Add DEBUG_RWSEMS to look for
> lock/unlock emismatches" (newly added in this merge window) will cause
> xfstests tests failures in generic/068 for all file systems.
>
> This is because the freeze and thaw ioctls, by design, are run in
> different processes.  It looks like the concern for why
> CONFIG_DEBUG_RWSEMS was added is because read/write semaphores can
> spin --- which if the case, we need to make sure that (a) the spinlock
> code path is not used for the freeze/thaw ioctls, and (b) we don't
> trigger the debug WARN_ON.
>
> Cheers,
>
The rwsem code has an up_read_non_owner() function for this kind of
cross task lock/unlock. I think we should add the corresponding
up_write_non_owner() for that. It is better to annotate those calls that
have this issue rather than working around it. I will post a patch to
address that later today.

Cheers,
Longman
