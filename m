Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeBUFyz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:54:55 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:40468 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751369AbeBUFyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:54:54 -0500
X-Google-Smtp-Source: AH8x226DsFnDjSN1ekEXrhjZI8oz+wQVLmCP4jYnrpPay3QdxG8eNqAA8NF81YuuwPLp+ytwKyHLRw==
Date: Wed, 21 Feb 2018 11:24:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] cpufreq: powernv: Check  negative value returned by
 cpufreq_table_find_index_dl()
Message-ID: <20180221055450.GO28462@vireshk-i7>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7>
 <874lmasxxx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lmasxxx.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-18, 16:39, Michael Ellerman wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:

> > AFAICT, you will get -1 here only if the freq table had no valid
> > frequencies (or the freq table is empty). Why would that happen ?
> 
> Bugs?

The cupfreq driver shouldn't have registered itself in that case (i.e.
if the cpufreq table is empty).

> Or if you ask for a target_freq that is higher than anything in the
> table.

You will still get a valid index in that case.

There is only once case where we return -1, when the cpufreq table
doesn't have any valid frequencies.

> Or the API changes, and we forget to update this call site.

I am not sure we can do much about that right now.

> If you're saying that cpufreq_table_find_index_dl() can NEVER fail,

Yes, if we have at least one valid frequency in the table, otherwise
the cpufreq driver shouldn't have registered itself.

> then
> write it so that it can never fail and change it to return unsigned int.

But what should we do when there is no frequency in the cpufreq table?
Just in case where a driver is buggy and tries to call this routine
for an invalid table.

> Having it potentially return -1, which is then used to index an array
> and not handling that is just asking for bugs to happen.

I understand what you are trying to say here, but I don't know what
can be done to prevent this here.

What we can do is change the return type to void and pass a int
pointer to the routine, but that wouldn't change anything at all. That
pointers variable can still have -1 in it.

-- 
viresh
