Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755477AbeE3Ce6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 22:34:58 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50542 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeE3Ce4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 22:34:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Chinner <david@fromorbit.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>, linux-kernel@vger.kernel.org
References: <87o9h6554f.fsf@xmission.com> <20180524214617.GG7712@thunk.org>
        <87y3g8y6x9.fsf@xmission.com> <20180525035716.GE10363@dastard>
        <8736yar4g3.fsf@xmission.com> <20180529221710.GM23861@dastard>
Date: Tue, 29 May 2018 21:34:35 -0500
In-Reply-To: <20180529221710.GM23861@dastard> (Dave Chinner's message of "Wed,
        30 May 2018 08:17:10 +1000")
Message-ID: <87k1rlkh1g.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fNqwh-0001oR-7G;;;mid=<87k1rlkh1g.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/3z68iK0gE+LhG6TcTrosq00kEFSbkhQs=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4985]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Dave Chinner <david@fromorbit.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15024 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.0 (0.0%), b_tie_ro: 2.1 (0.0%), parse: 0.87 (0.0%),
        extract_message_metadata: 11 (0.1%), get_uri_detail_list: 1.32 (0.0%),
        tests_pri_-1000: 3.4 (0.0%), tests_pri_-950: 1.40 (0.0%), tests_pri_-900:
        1.08 (0.0%), tests_pri_-400: 21 (0.1%), check_bayes: 20 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.4 (0.0%), b_tok_touch_all:
        2.6 (0.0%), b_finish: 0.60 (0.0%), tests_pri_0: 162 (1.1%),
        check_dkim_signature: 0.67 (0.0%), check_dkim_adsp: 3.8 (0.0%),
        tests_pri_500: 14816 (98.6%), poll_dns_idle: 14807 (98.6%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 0/6] Wrapping up the vfs support for unprivileged mounts
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Chinner <david@fromorbit.com> writes:

> Yeah, the are some fairly big process and policy things that need
> to be decided here. Not just at the kernel level, but at distro and
> app infrastructure level too.
>
> I was originally sceptical of supporting kernel filesystems via lkl,
> but the desire for unprivileged mounts has not gone away and so I'm
> less worried about accessing filesystems that way than I am of
> letting the kernel parse untrusted images from untrusted users...

There is also the more readily available libguestfs which doesn't
support as many filesystems but does seem available in most
linux distributions already.  It already has a fuse option available
with guestmount.  I may have to dig in there and see how to make
it available without using fusermount.

> I'm not sure what the correct forum for this is - wasn't this
> something the Plumbers conference was supposed to facilitate?

Yes.  If we all need to be in a room and talk about things.
It is early enough in the planning for Plumers that we could
definitely schedule a talk or a BOF for this.

>> Is fusefs-lkl valuable for testing filesystems?  If xfs-tests were to
>> have a mode that used that used the fuse protocol for testing and
>> fuzzing filesystems without the full weight of the kernel in the middle
>> that might encourage people to suppor this kind of things as well.
>
> Getting lkl-fuse to run under fstests would be a great way to ensure
> we have some level of confidence that it will do the right thing and
> users can expect that it won't eat their data. I think this would
> need to be a part of a recommendation for wider deploy of such a
> solution...

Good thought.  I will have to give that a look.  That does sound like a
good practical test.

Eric
