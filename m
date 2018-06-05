Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeFERro (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:47:44 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:39854 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeFERrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:47:42 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "'tj\@kernel.org'" <tj@kernel.org>
Cc: "Hatayama\, Daisuke" <d.hatayama@jp.fujitsu.com>,
        "'gregkh\@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "Okajima\, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm\@aristanetworks.com'" <ebiederm@aristanetworks.com>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
        <87wovhqex2.fsf@xmission.com> <87po17r9ek.fsf_-_@xmission.com>
        <33710E6CAA200E4583255F4FB666C4E21B65E04E@G01JPEXMBYT03>
        <87sh62k3vk.fsf@xmission.com>
        <33710E6CAA200E4583255F4FB666C4E21B66BAC8@G01JPEXMBYT03>
        <87h8mhgsh3.fsf@xmission.com>
        <20180605154210.GD1351649@devbig577.frc2.facebook.com>
Date: Tue, 05 Jun 2018 12:47:33 -0500
In-Reply-To: <20180605154210.GD1351649@devbig577.frc2.facebook.com>
        (tj@kernel.org's message of "Tue, 5 Jun 2018 08:42:10 -0700")
Message-ID: <8736y1dt1m.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fQG3Z-0008MS-3D;;;mid=<8736y1dt1m.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18XpYPJsz1MYZJ8cOJwpAx/FHszpBXrOKY=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.3 TooManyTo_001 Multiple "To" Header Recipients 2x (uncommon)
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;"'tj\@kernel.org'" <tj@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 195 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 8 (4.1%), b_tie_ro: 5 (2.7%), parse: 1.02 (0.5%),
        extract_message_metadata: 3.8 (1.9%), get_uri_detail_list: 1.74 (0.9%),
        tests_pri_-1000: 3.6 (1.8%), tests_pri_-950: 1.09 (0.6%), tests_pri_-900:
        0.87 (0.4%), tests_pri_-400: 21 (11.0%), check_bayes: 20 (10.3%), b_tokenize:
        5 (2.6%), b_tok_get_all: 7 (3.7%), b_comp_prob: 1.90 (1.0%), b_tok_touch_all:
        3.0 (1.5%), b_finish: 0.82 (0.4%), tests_pri_0: 142 (72.8%),
        check_dkim_signature: 0.40 (0.2%), check_dkim_adsp: 3.0 (1.5%),
        tests_pri_500: 4.6 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [CFT][PATCH] kernfs: Correct kernfs directory seeks.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"'tj@kernel.org'" <tj@kernel.org> writes:

> Hello,
>
> On Tue, Jun 05, 2018 at 10:31:36AM -0500, Eric W. Biederman wrote:
>> What I have above is not the clearest, and in fact the logic could be
>> better.
>> 
>> The fundamental challenge is because hash collisions are possible a file
>> offset does not hold complete position information in a directory.
>> 
>> So the kernfs node that is to be read/displayed next is saved in the
>> struct file.  The it is tested if the saved kernfs node is usable
>> for finding the location in the directory.  Several things may have
>> gone wrong.
>> 
>> - Someone may have called seekdir.
>> - The saved kernfs node may have been renamed.
>> - The saved kernfs node may have been moved to a different directory in
>>   kernfs.
>> - the saved kernfs node may have been deleted.
>> 
>> If any of those are true the code needs to do the rbtree lookup.
>
> So, given that the whole thing is protected by a mutex which protects
> modifications, it could be an option to simply keep track of who's
> iterating what and shift them on removals.  IOW, always keep cursor
> pointing to the next thing to visit and if that gets removed shift the
> cursor to the next one.

Yes.  We could.

The primary case we have to worry about is someone using seekdir,
and for that we always need the rbtree lookup.   For seekdir
we could invalidate the saved entry and make things simpler
that way.

We could add list_head to the kernfs_node and create:
struct kernfs_dir_file {
	struct list_head entry;
        struct kernfs_node *kn;
}
And point at that from struct file->private_data.

I don't know if it would be worth the trouble to do that over a quick
check to make certain the kernfs_node is what it is expected to be.
But that is an option.

Part of the pain of supporting seekdir is that the offset we expose
to userspace in has to be 32bit to support 32bit userspace applications.
Which unfortunately is small enough that if nothing else a name
collision can be brute forced.  So we can not avoid handling collisions.


Sigh,  I have found another issue with kernfs_fop_readdir.

We are not currently protecting file->private_data with the kernfs_mutex
or any other kind of serialization.  Which means if two processes are
calling readdir on the same file descriptor we might get unpredictable
behavior.

It doesn't look too bad and easy enough to fix, but definitely something
to be watchful of.

Eric
