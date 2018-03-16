Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeCPUHu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:07:50 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51148 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeCPUHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:07:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Ram Pai <linuxram@us.ibm.com>
References: <87k1wimybi.fsf_-_@xmission.com>
        <20180116004009.31036-13-ebiederm@xmission.com>
        <29eb3438-0891-36ee-e5f6-36e26ccf2b89@intel.com>
        <818f8945-f990-a770-476e-f82bdc77dbda@intel.com>
Date: Fri, 16 Mar 2018 15:06:55 -0500
In-Reply-To: <818f8945-f990-a770-476e-f82bdc77dbda@intel.com> (Dave Hansen's
        message of "Fri, 16 Mar 2018 12:24:44 -0700")
Message-ID: <87efkjeqe8.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ewvdh-0001cO-4j;;;mid=<87efkjeqe8.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/RvK+5bvhoWN2uAM/ynDLaLaMq1wNer/M=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Dave Hansen <dave.hansen@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 164 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (1.7%), b_tie_ro: 1.98 (1.2%), parse: 0.72 (0.4%),
        extract_message_metadata: 9 (5.7%), get_uri_detail_list: 0.92 (0.6%),
        tests_pri_-1000: 6 (3.4%), tests_pri_-950: 1.15 (0.7%), tests_pri_-900: 0.94
        (0.6%), tests_pri_-400: 16 (10.0%), check_bayes: 16 (9.5%), b_tokenize: 4.8
        (2.9%), b_tok_get_all: 5 (3.1%), b_comp_prob: 1.55 (0.9%), b_tok_touch_all:
        2.4 (1.4%), b_finish: 0.58 (0.4%), tests_pri_0: 121 (73.4%),
        check_dkim_signature: 0.44 (0.3%), check_dkim_adsp: 2.4 (1.5%),
        tests_pri_500: 4.0 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 13/22] signal: Move addr_lsb into the _sigfault union for clarity
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 03/16/2018 12:00 PM, Dave Hansen wrote:
>> On 01/15/2018 04:40 PM, Eric W. Biederman wrote:
>>> The addr_lsb fields is only valid and available when the
>>> signal is SIGBUS and the si_code is BUS_MCEERR_AR or BUS_MCEERR_AO.
>>> Document this with a comment and place the field in the _sigfault union
>>> to make this clear.
>>>
>>> All of the fields stay in the same physical location so both the old
>>> and new definitions of struct siginfo will continue to work.
>> 
>> This breaks the ABI and breaks protection keys.  The physical locations
>> *DO* change.
>> 
>> Before this patch:
>> 
>> #define si_pkey         _sifields._sigfault._pkey
>> (gdb) print &((siginfo_t *)0)->_sifields._sigfault._pkey
>> $1 = (__u32 *) 0x20 <irq_stack_union+32>
>> 
>> and after:
>> 
>> +#define si_pkey                _sifields._sigfault._addr_pkey._pkey
>> (gdb) print &((siginfo_t *)0)->_sifields._sigfault._addr_pkey._pkey
>> $1 = (__u32 *) 0x1c
>> 
>> Can we revert this, please?
>
> It does not revert cleanly so I reverted it manually.  Patch doing that
> is attached.  Should we do this, or is there a better option?

Please see:
859d880cf544 ("signal: Correct the offset of si_pkey in struct siginfo")

Eric
