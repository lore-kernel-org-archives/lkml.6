Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933809AbeE2MTk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:19:40 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38001 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933491AbeE2MTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:19:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Petr Tesarik <ptesarik@suse.cz>
Cc: dzickus@redhat.com, Neil Horman <nhorman@redhat.com>,
        Tony Luck <tony.luck@intel.com>, bhe@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
        <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
        <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
        <877enucqr0.fsf@xmission.com>
        <20180523222236.5a96732e@ezekiel.suse.cz>
        <20180524014905.GB2031@dhcp-128-65.nay.redhat.com>
        <20180524085708.31aa311d@ezekiel.suse.cz>
        <87k1rt3tdu.fsf@xmission.com>
        <20180525065943.03bcb911@ezekiel.suse.cz>
        <87d0xjwlo2.fsf@xmission.com>
        <20180528143400.4fc68de4@ezekiel.suse.cz>
Date: Tue, 29 May 2018 07:19:16 -0500
In-Reply-To: <20180528143400.4fc68de4@ezekiel.suse.cz> (Petr Tesarik's message
        of "Mon, 28 May 2018 14:34:00 +0200")
Message-ID: <874liqu01n.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fNdb8-00051N-5z;;;mid=<874liqu01n.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+eIiDdjZbTIYMynuJqJB/F6soXBKN/k/Y=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Petr Tesarik <ptesarik@suse.cz>
X-Spam-Relay-Country: 
X-Spam-Timing: total 668 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 9 (1.3%), b_tie_ro: 4.0 (0.6%), parse: 1.89 (0.3%),
        extract_message_metadata: 34 (5.0%), get_uri_detail_list: 3.5 (0.5%),
        tests_pri_-1000: 14 (2.1%), tests_pri_-950: 2.3 (0.3%), tests_pri_-900: 1.92
        (0.3%), tests_pri_-400: 38 (5.7%), check_bayes: 36 (5.4%), b_tokenize: 14
        (2.2%), b_tok_get_all: 10 (1.4%), b_comp_prob: 5 (0.8%), b_tok_touch_all: 2.8
        (0.4%), b_finish: 0.87 (0.1%), tests_pri_0: 550 (82.3%),
        check_dkim_signature: 1.10 (0.2%), check_dkim_adsp: 4.8 (0.7%),
        tests_pri_500: 10 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config options
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Tesarik <ptesarik@suse.cz> writes:

> On Fri, 25 May 2018 15:00:13 -0500
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>>[...]
>> The ultimate point is that the absolute best we can do is to run a
>> kernel in memory that we never use for anything else and then we have a
>> fighting chance of getting the system working and getting a report of
>> the failure out to somewhere.
>>
>> > Anyway, of course we would still have to keep the current method,
>> > because user pages are not always filtered. For example, a major SUSE
>> > account runs a database in user space and also inspects its data
>> > structures in case of a system crash.  
>> 
>> And I understand the memory pressures that will encourage people to use
>> user pages for extra memory to run the dump capture kernel in.  Short of
>> the presence of an IOMMU that all DMA transfers must go through I don't
>> see how those user pages could reliably be used.
>
> Absolutely. I fully understand that a system which reuses first
> kernel's memory in some way must be less reliable than the current
> state. However, some people are willing to trade less reliability for
> reduced resource consumption.

That is the kind of tradeoff that can easily result in the crash kernel
eating your data.  I will nack any patch that I see that goes anywhere
near that kind of solution for the kernel that takes the crash.

> Note that we're not talking about reserving a few gigs on a single
> machine with some terabytes of memory (i.e. less than 1% of total RAM),
> rather a few hundred megs of each 4-gig VM on an s390x machine (i.e.
> about 10% of total RAM).

You should be able to get away with tens of gigs instead of hundreds.
The biggest reservation I remember anyone ever making is about 100Meg.
And that was a general purpose configuration not tuned at all.  With the
maximum size dealing with large machines.

kexec on panic grew up on machines with 4Gig or less as it arrived
before everyone was 64bit.  It should be possible to tune your crash
dump taking kernel so things run in a reasonable amount of memory for
the configuration you are talking about.  The usual trade-off is time
vs generality.  Usually I simply have not seen people with non-embedded
configurations take the time to tune things.

Eric
