Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeEOSpR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:45:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752030AbeEOSpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:45:16 -0400
Subject: Re: [PATCH v3 2/2] locking/percpu-rwsem: Annotate rwsem ownership
 transfer by setting RWSEM_OWNER_UNKNOWN
To: Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-3-git-send-email-longman@redhat.com>
 <20180515175805.GN12217@hirez.programming.kicks-ass.net>
 <20180515180219.GA6612@bombadil.infradead.org>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4a3fbd3c-3cfa-f9c2-c73c-fa6d9c55c2d5@redhat.com>
Date: Tue, 15 May 2018 14:45:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180515180219.GA6612@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 02:02 PM, Matthew Wilcox wrote:
> On Tue, May 15, 2018 at 07:58:05PM +0200, Peter Zijlstra wrote:
>> On Tue, May 15, 2018 at 01:38:04PM -0400, Waiman Long wrote:
>>> +/*
>>> + * Owner value to indicate the rwsem's owner is not currently known.
>>> + */
>>> +#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-1)
>> It might be nice to comment that this works and relies on having that
>> ANON_OWNER bit set.
> I'd rather change the definition to be ((struct task_struct *)2)
> otherwise this is both reader-owned and anonymously-owned which doesn't
> make much sense.

Thinking about it a bit more. I can actually just use one special bit
(bit 0) to designate an unknown owner. So for a reader-owned lock, it is
just owner == 1 as the owners are unknown for a reader owned lock. For a
lock owned by an unknown writer, it is (owner & 1) && (owner != 1). That
will justify the use of -1L and save bit 1 for future extension.

Cheers,
Longman
