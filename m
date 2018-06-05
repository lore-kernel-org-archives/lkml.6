Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeFEPcD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:32:03 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:58484 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbeFEPcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:32:01 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Hatayama\, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "'gregkh\@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "'tj\@kernel.org'" <tj@kernel.org>,
        "Okajima\, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm\@aristanetworks.com'" <ebiederm@aristanetworks.com>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
        <87wovhqex2.fsf@xmission.com> <87po17r9ek.fsf_-_@xmission.com>
        <33710E6CAA200E4583255F4FB666C4E21B65E04E@G01JPEXMBYT03>
        <87sh62k3vk.fsf@xmission.com>
        <33710E6CAA200E4583255F4FB666C4E21B66BAC8@G01JPEXMBYT03>
Date: Tue, 05 Jun 2018 10:31:36 -0500
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E21B66BAC8@G01JPEXMBYT03> (Daisuke
        Hatayama's message of "Tue, 5 Jun 2018 05:45:54 +0000")
Message-ID: <87h8mhgsh3.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fQDvz-0004Jr-Re;;;mid=<87h8mhgsh3.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+0rEr2uBNUDlFg+H4X10BUkYgI4opbNxQ=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1962]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Hatayama\, Daisuke" <d.hatayama@jp.fujitsu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15030 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.3 (0.0%), b_tie_ro: 1.55 (0.0%), parse: 1.18 (0.0%),
        extract_message_metadata: 16 (0.1%), get_uri_detail_list: 2.6 (0.0%),
        tests_pri_-1000: 4.6 (0.0%), tests_pri_-950: 1.70 (0.0%), tests_pri_-900:
        1.40 (0.0%), tests_pri_-400: 24 (0.2%), check_bayes: 23 (0.2%), b_tokenize:
        10 (0.1%), b_tok_get_all: 6 (0.0%), b_comp_prob: 3.0 (0.0%), b_tok_touch_all:
        1.94 (0.0%), b_finish: 0.59 (0.0%), tests_pri_0: 199 (1.3%),
        check_dkim_signature: 0.44 (0.0%), check_dkim_adsp: 2.8 (0.0%),
        tests_pri_500: 14775 (98.3%), poll_dns_idle: 14766 (98.2%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [CFT][PATCH] kernfs: Correct kernfs directory seeks.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> writes:

>> >> +
>> >> +	/* Is the saved position usable? */
>> >> +	if (saved) {
>> >> +		/* Proper parent and hash? */
>> >> +		if ((parent != saved->parent) || (saved->hash != hash)) {
>> >> +			saved = NULL;
>> >
>> > name is uninitialized in this path.
>> 
>> It is.  name is initialized to "" see above.
>> 
>
> Or when either of the conditions is true, it has resulted in some inconsistent state, right?
> So, why not terminating this session of readdir() immediately by
> returning NULL just as when off is turned out to be invalid?

What I have above is not the clearest, and in fact the logic could be
better.

The fundamental challenge is because hash collisions are possible a file
offset does not hold complete position information in a directory.

So the kernfs node that is to be read/displayed next is saved in the
struct file.  The it is tested if the saved kernfs node is usable
for finding the location in the directory.  Several things may have
gone wrong.

- Someone may have called seekdir.
- The saved kernfs node may have been renamed.
- The saved kernfs node may have been moved to a different directory in
  kernfs.
- the saved kernfs node may have been deleted.

If any of those are true the code needs to do the rbtree lookup.

If the kernfs node has been deleted or moved to a different directory we
can safely use it's name while performing the rbtree lookup.  Which in
the event of a hash collision will be more accurate in finding our old
location, and preventing the same directory entry being returned
multiple times.

Which is completely different than if the directory offset is an invalid
value that will never point to any directory entries.

Eric
