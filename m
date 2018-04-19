Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeDST2m convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:28:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752294AbeDST2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:28:41 -0400
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into
 /proc/stat_irqs
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, rdunlap@infradead.org
References: <20180419190846.GE2066@avx2>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1c3b9cf3-3a36-568f-3da2-e560a721f4aa@redhat.com>
Date: Thu, 19 Apr 2018 15:28:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180419190846.GE2066@avx2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 03:08 PM, Alexey Dobriyan wrote:
>> Therefore, application performance can be impacted if the application
>> reads /proc/stat rather frequently.
> [nods]
> Text interfaces can be designed in a very stupid way.
>
>> For example, reading /proc/stat in a certain 2-socket Skylake server
>> took about 4.6ms because it had over 5k irqs.
> Is this top(1)? What is this application doing?
> If it needs percpu usage stats, then maybe /proc/stat should be
> converted away from single_open() so that core seq_file code doesn't
> generate everything at once.

The application is actually a database benchmarking tool used by a
customer. The reading of /proc/stat is an artifact of the benchmarking
tool that can actually be turned off. Without doing that, about 20% of
CPU time were spent reading /proc/stat and the trashing of cachelines
slowed the benchmark number quite significantly. However, I was also
told that there are legitimate cases where reading /proc/stat was
necessary in some of their applications.

>> -
>> -	/* sum again ? it could be updated? */
>> -	for_each_irq_nr(j)
>> -		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
>> -
> This is direct userspace breakage.

Yes, I am aware of that. That is the cost of improving the performance
of applications that read /proc/stat, but don't need the individual irq
counts.

>
> Proper fix is to start strategic switch away from /proc.
> It is a fun toy but its time has come.

Migration from procfs is easier said then done. Many existing customers
are reluctant to do that.

-Longman
