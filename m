Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeFECDM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 22:03:12 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38508 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeFECDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 22:03:10 -0400
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
Date: Mon, 04 Jun 2018 21:02:46 -0500
In-Reply-To: <87sh62k3vk.fsf@xmission.com> (Eric W. Biederman's message of
        "Mon, 04 Jun 2018 09:44:47 -0500")
Message-ID: <87h8mihtx5.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fQ1JG-0000bq-0H;;;mid=<87h8mihtx5.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18VyszF24vhObj5mVddA0XZReRwEthqASk=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2663]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Hatayama\, Daisuke" <d.hatayama@jp.fujitsu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15023 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.0%), b_tie_ro: 1.69 (0.0%), parse: 0.87 (0.0%),
        extract_message_metadata: 13 (0.1%), get_uri_detail_list: 2.2 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.13 (0.0%), tests_pri_-900:
        0.96 (0.0%), tests_pri_-400: 24 (0.2%), check_bayes: 23 (0.2%), b_tokenize: 9
        (0.1%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.1 (0.0%), b_tok_touch_all:
        2.8 (0.0%), b_finish: 0.57 (0.0%), tests_pri_0: 238 (1.6%),
        check_dkim_signature: 0.51 (0.0%), check_dkim_adsp: 2.9 (0.0%),
        tests_pri_500: 14737 (98.1%), poll_dns_idle: 14729 (98.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [CFT][PATCH] kernfs: Correct kernfs directory seeks.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> writes:
>
>>> Can you test this and please verify it fixes your issue?
>>
>> I tried this patch on top of v4.17 but the system fails to boot
>> without detecting root disks by dracut like this:
[snip]

>> OTOH, there's no issue on the pure v4.17 kernel.
>>
>> As above, ls /sys/module looks apparently good. But I guess any part of
>> behavior of getdentries() on sysfs must have changed, affecting the disk
>> detection...
>
> I haven't been able to reproduce this yet.  My test system boots fine.
> Which fedora are you testing on?

I reproduced something similar and fedora 28.  So I think I have found
and fixed the issue.  I believe I simply reversed the test at the end of
kernfs_dir_pos. AKA "<" instead of ">".

I am going to see if I can test my changes more throughly on this side
and then repost.



>>>  fs/kernfs/dir.c | 109
>>> ++++++++++++++++++++++++++++++++++----------------------
>>>  1 file changed, 67 insertions(+), 42 deletions(-)
>>> 
>>> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
>>> index 89d1dc19340b..8148b5fec48d 100644
>>> --- a/fs/kernfs/dir.c
>>> +++ b/fs/kernfs/dir.c
>>> @@ -1584,53 +1584,75 @@ static int kernfs_dir_fop_release(struct inode *inode,
>>> struct file *filp)
>>>  	return 0;
>>>  }
>>> 
>>> +static struct kernfs_node *kernfs_dir_next(struct kernfs_node *pos)
>>> +{
>>> +	struct rb_node *node = rb_next(&pos->rb);
>>> +	return node ? rb_to_kn(node) : NULL;
>>> +}
>>> +
>>>  static struct kernfs_node *kernfs_dir_pos(const void *ns,
>>> -	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
>>> +	struct kernfs_node *parent, loff_t off, struct kernfs_node *saved)
>>>  {
>>> -	if (pos) {
>>> -		int valid = kernfs_active(pos) &&
>>> -			pos->parent == parent && hash == pos->hash;
>>> -		kernfs_put(pos);
>>> -		if (!valid)
>>> -			pos = NULL;
>>> -	}
>>> -	if (!pos && (hash > 1) && (hash < INT_MAX)) {
>>> -		struct rb_node *node = parent->dir.children.rb_node;
>>> -		while (node) {
>>> -			pos = rb_to_kn(node);
>>> -
>>> -			if (hash < pos->hash)
>>> -				node = node->rb_left;
>>> -			else if (hash > pos->hash)
>>> -				node = node->rb_right;
>>> -			else
>>> -				break;
>>> +	struct kernfs_node *pos;
>>> +	struct rb_node *node;
>>> +	unsigned int hash;
>>> +	const char *name = "";
>>> +
>>> +	/* Is off a valid name hash? */
>>> +	if ((off < 2) || (off >= INT_MAX))
>>> +		return NULL;
>>> +	hash = off;
>>> +
>>> +	/* Is the saved position usable? */
>>> +	if (saved) {
>>> +		/* Proper parent and hash? */
>>> +		if ((parent != saved->parent) || (saved->hash != hash)) {
>>> +			saved = NULL;
>>
>> name is uninitialized in this path.
>
> It is.  name is initialized to "" see above.
>
>>> +		} else {
>>> +			if (kernfs_active(saved))
>>> +				return saved;
>>> +			name = saved->name;
>>>  		}
>>>  	}
>>> -	/* Skip over entries which are dying/dead or in the wrong namespace
>>> */
>>> -	while (pos && (!kernfs_active(pos) || pos->ns != ns)) {
>>> -		struct rb_node *node = rb_next(&pos->rb);
>>> -		if (!node)
>>> -			pos = NULL;
>>> +
>>> +	/* Find the closest pos to the hash we are looking for */
>>> +	pos = NULL;
>>> +	node = parent->dir.children.rb_node;
>>> +	while (node) {
>>> +		int result;
>>> +
>>> +		pos = rb_to_kn(node);
>>> +		result = kernfs_name_compare(hash, name, ns, pos);
>>> +		if (result < 0)
>>> +			node = node->rb_left;
>>> +		else if (result > 0)
>>> +			node = node->rb_right;
>>>  		else
>>> -			pos = rb_to_kn(node);
>>> +			break;
>>>  	}
>>> +
>>> +	/* Ensure pos is at or beyond the target position */
>>> +	if (pos && (kernfs_name_compare(hash, name, ns, pos) < 0))
                                                    ^^^^^^^^^^^^^^^^
                                          should be > 0
>>> +		pos = kernfs_dir_next(pos);
>>> +

Eric
