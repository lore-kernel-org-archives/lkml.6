Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeDRUOY convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 16:14:24 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:45369 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeDRUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 16:14:22 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: John Johansen <john.johansen@canonical.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        tycho@docker.com, serge@hallyn.com, sunyuqiong1988@gmail.com,
        david.safford@ge.com, mkayaalp@cs.binghamton.edu,
        James.Bottomley@HansenPartnership.com, Yuqiong Sun <suny@us.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
        <1522159038-14175-2-git-send-email-stefanb@linux.vnet.ibm.com>
        <87sh8lcecn.fsf@xmission.com>
        <1523636702.3272.63.camel@linux.vnet.ibm.com>
        <d8c30d7d-c679-9323-7a25-d3148e9b96c6@canonical.com>
        <1524081472.3272.319.camel@linux.vnet.ibm.com>
Date: Wed, 18 Apr 2018 15:12:45 -0500
In-Reply-To: <1524081472.3272.319.camel@linux.vnet.ibm.com> (Mimi Zohar's
        message of "Wed, 18 Apr 2018 15:57:52 -0400")
Message-ID: <87wox4s282.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1f8tT3-0006Cs-1Y;;;mid=<87wox4s282.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+PTpRxHSEVb9a727dLqhn38S4aP9zK5tc=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4323]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Mimi Zohar <zohar@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 577 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 4.1 (0.7%), b_tie_ro: 2.9 (0.5%), parse: 1.38 (0.2%),
        extract_message_metadata: 6 (1.0%), get_uri_detail_list: 2.6 (0.4%),
        tests_pri_-1000: 7 (1.2%), tests_pri_-950: 2.3 (0.4%), tests_pri_-900: 2.1
        (0.4%), tests_pri_-400: 35 (6.1%), check_bayes: 33 (5.7%), b_tokenize: 12
        (2.2%), b_tok_get_all: 8 (1.5%), b_comp_prob: 4.7 (0.8%), b_tok_touch_all:
        3.2 (0.6%), b_finish: 0.89 (0.2%), tests_pri_0: 490 (85.0%),
        check_dkim_signature: 0.92 (0.2%), check_dkim_adsp: 4.8 (0.8%),
        tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH v3 1/3] ima: extend clone() with IMA namespace support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> On Wed, 2018-04-18 at 09:09 -0700, John Johansen wrote:
>> On 04/13/2018 09:25 AM, Mimi Zohar wrote:
>> > [Cc'ing John Johansen]
>> > 
>> > On Tue, 2018-03-27 at 18:01 -0500, Eric W. Biederman wrote:
>> > [...]
>> >> As such I expect the best way to create the ima namespace is by simply
>> >> writing to securityfs/imafs.  Possibly before the user namespace is
>> >> even unshared.  That would allow IMA to keep track of things from
>> >> before a container is created.
>> > 
>> 
>> I do think this is generally the right approach for LSMs when looking
>> forward to LSM stacking and more LSMs.
>> 
>> 
>> > My initial thought was to stage IMA namespacing with just IMA-audit
>> > first, followed by either IMA-measurement or IMA-appraisal.  This
>> > would allow us to get the basic IMA namespacing framework working and
>> > defer dealing with the securityfs related namespacing of the IMA
>> > policy and measurement list issues to later.
>> > 
>> > By tying IMA namespacing to a securityfs ima/unshare file, we would
>> > need to address the securityfs issues first.
>> > 
>> 
>> well it depends on what you want to do. It would be possible to have
>> a simple file (not a jump link) within securityfs that IMA could use
>> without having to deal with all the securityfs issues first. However it
>> does require that securityfs (not necessarily imafs) be visible within
>> the mount namespace of the task doing the setup.
>
> Eric, would you be OK with that?

Roughly.  My understanding is that you have to have a write to some
filesystem to set the ima policy.

I was expecting having to write an "create ima namespace" value
to the filesystem would not be any special effort.

Now it sounds like providing the "create an ima namespace" is going to
be a special case, and that does not sound correct.

Eric
