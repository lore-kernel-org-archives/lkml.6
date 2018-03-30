Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbeC3GOr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 02:14:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:47923 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbeC3GOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 02:14:45 -0400
From: Nicolai Stange <nstange@suse.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>,
        Francisco Jerez <currojerez@riseup.net>, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, kbuild-all@01.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        0day robot <fengguang.wu@intel.com>, Len Brown <lenb@kernel.org>,
        Nicolai Stange <nstange@suse.de>
Subject: Re: [kbuild-all] [PATCH] OPTIONAL: cpufreq/intel_pstate: fix debugfs_simple_attr.cocci warnings
References: <alpine.DEB.2.20.1803292109180.2750@hadrien>
        <CAOMZO5CLpW+2yCYRwAJTPWtXgXkaPGyPQrB3cbBGYvV1fryUQw@mail.gmail.com>
        <alpine.DEB.2.20.1803292140340.2750@hadrien>
Date: Fri, 30 Mar 2018 08:14:40 +0200
In-Reply-To: <alpine.DEB.2.20.1803292140340.2750@hadrien> (Julia Lawall's
        message of "Thu, 29 Mar 2018 21:44:02 +0200 (CEST)")
Message-ID: <87po3mxf73.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia Lawall <julia.lawall@lip6.fr> writes:

> On Thu, 29 Mar 2018, Fabio Estevam wrote:
>
>> Hi Julia,
>>
>> On Thu, Mar 29, 2018 at 4:12 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> >  Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
>> >  for debugfs files.
>> >
>> > Semantic patch information:
>> >  Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
>> >  imposes some significant overhead as compared to
>> >  DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
>>
>> Just curious: could you please expand on what "imposes some
>> significant overhead" means?
>
> I don't know.  I didn't write this rule.  Nicolai, can you explain?

>From commit 49d200deaa68 ("debugfs: prevent access to removed files' private
data"):

    Upon return of debugfs_remove()/debugfs_remove_recursive(), it might
    still be attempted to access associated private file data through
    previously opened struct file objects. If that data has been freed by
    the caller of debugfs_remove*() in the meanwhile, the reading/writing
    process would either encounter a fault or, if the memory address in
    question has been reassigned again, unrelated data structures could get
    overwritten.
    [...]
    Currently, there are ~1000 call sites of debugfs_create_file() spread
    throughout the whole tree and touching all of those struct file_operations
    in order to make them file removal aware by means of checking the result of
    debugfs_use_file_start() from within their methods is unfeasible.
    
    Instead, wrap the struct file_operations by a lifetime managing proxy at
    file open [...]

The additional overhead comes in terms of additional memory needed: for
debugs files created through debugfs_create_file(), one such struct
file_operations proxy is allocated for each struct file instantiation,
c.f. full_proxy_open().

This was needed to "repair" the ~1000 call sites without touching them.

New debugfs users should make their file_operations removal aware
themselves by means of DEFINE_DEBUGFS_ATTRIBUTE() and signal that fact to
the debugfs core by instantiating them through
debugfs_create_file_unsafe().

See commit c64688081490 ("debugfs: add support for self-protecting
attribute file fops") for further information.


Thanks,

Nicolai


-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
