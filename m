Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeEPNMH convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:12:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751395AbeEPNME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:12:04 -0400
Subject: Re: [PATCH v4 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED
 flag
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
References: <1526420991-21213-1-git-send-email-longman@redhat.com>
 <1526420991-21213-2-git-send-email-longman@redhat.com>
 <20180516104829.GA24332@redhat.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <3481c82e-81b2-3a33-48a6-4b0d46c0bd71@redhat.com>
Date: Wed, 16 May 2018 09:11:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180516104829.GA24332@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 06:48 AM, Oleg Nesterov wrote:
> On 05/15, Waiman Long wrote:
>> There are use cases where a rwsem can be acquired by one task, but
>> released by another task. In thess cases, optimistic spinning may need
>> to be disabled.  One example will be the filesystem freeze/thaw code
> You do not read my emails ;)
>
> Let me repeat once again that in this particular case the writer will
> never spin because of owner == NULL. freeze_super() checks SB_UNFROZEN
> under sb->s_umount and only then calls sb_wait_write(). IOW, sb_wait_write()
> can only be called when this rwsem was already released by the previous
> writer.
>
> I am not arguing with this change, percpu_rwsem_release/acquire may have
> another user sometime, but the changelog is not accurate.

I know the change may not be necessary in this particular case, but it
is a correctness issue. Optimistic spinning should be disabled when the
exact time delay between percpu_rwsem_release() and
percpu_rwsem_acquire() is indeterminate even though no one is supposed
to spin on the rwsem during that time.

If we don't do that now, we may forget this issue when some other use
cases show up or we extend rwsem to do reader optimistic spinning, for
instance. So it is better to address that now than debugging the same
issue again in the future.

Cheers,
Longman
