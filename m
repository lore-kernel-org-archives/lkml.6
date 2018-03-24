Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeCXQND (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 12:13:03 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35914 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbeCXQNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 12:13:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org
References: <20180323060457.sxgsd3j2obi33fyw@gordon>
        <87k1u3ti9e.fsf@xmission.com> <87fu4qo4ff.fsf_-_@xmission.com>
        <20180323231511.GK30522@ZenIV.linux.org.uk>
Date: Sat, 24 Mar 2018 11:12:02 -0500
In-Reply-To: <20180323231511.GK30522@ZenIV.linux.org.uk> (Al Viro's message of
        "Fri, 23 Mar 2018 23:15:11 +0000")
Message-ID: <87in9ljvvx.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ezlmt-0003N1-W3;;;mid=<87in9ljvvx.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ibURohPQswukymQDZ/wukB2YAt5v2c9w=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@ZenIV.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 595 ms - load_scoreonly_sql: 0.21 (0.0%),
        signal_user_changed: 5 (0.9%), b_tie_ro: 3.2 (0.5%), parse: 4.7 (0.8%),
        extract_message_metadata: 30 (5.1%), get_uri_detail_list: 3.3 (0.5%),
        tests_pri_-1000: 12 (2.1%), tests_pri_-950: 2.7 (0.5%), tests_pri_-900: 2.1
        (0.3%), tests_pri_-400: 33 (5.5%), check_bayes: 30 (5.1%), b_tokenize: 12
        (2.0%), b_tok_get_all: 8 (1.3%), b_comp_prob: 4.5 (0.8%), b_tok_touch_all:
        2.4 (0.4%), b_finish: 0.87 (0.1%), tests_pri_0: 453 (76.1%),
        check_dkim_signature: 1.17 (0.2%), check_dkim_adsp: 5 (0.9%), tests_pri_500:
        44 (7.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] fs: Extend mount_ns with support for a fast namespace to vfsmount function
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> writes:

> On Fri, Mar 23, 2018 at 04:41:40PM -0500, Eric W. Biederman wrote:
>
>>  struct dentry *mount_ns(struct file_system_type *fs_type,
>>  	int flags, void *data, void *ns, struct user_namespace *user_ns,
>> +	struct vfsmount *(*ns_to_mnt)(void *ns),
>>  	int (*fill_super)(struct super_block *, void *, int))
>>  {
>>  	struct super_block *sb;
>> -
>> +	int (*test_super)(struct super_block *, void *) = ns_test_super;
>>  	/* Don't allow mounting unless the caller has CAP_SYS_ADMIN
>>  	 * over the namespace.
>>  	 */
>>  	if (!(flags & SB_KERNMOUNT) && !ns_capable(user_ns, CAP_SYS_ADMIN))
>>  		return ERR_PTR(-EPERM);
>>  
>> -	sb = sget_userns(fs_type, ns_test_super, ns_set_super, flags,
>> -			 user_ns, ns);
>> +	if (ns_to_mnt) {
>> +		test_super = NULL;
>> +		if (!(flags & SB_KERNMOUNT)) {
>> +			struct vfsmount *m = ns_to_mnt(ns);
>> +			if (IS_ERR(m))
>> +				return ERR_CAST(m);
>> +			atomic_inc(&m->mnt_sb->s_active);
>> +			down_write(&m->mnt_sb->s_umount);
>> +			return dget(m->mnt_root);
>
> This is completely wrong.  Look:
> 	* SB_KERNMOUNT and !SB_KERNMOUNT cases are almost entirely isolated;
> completely so once that ns_to_mnt becomes unconditionally non-NULL.  
> 	* in !SB_KERNMOUNT passing ns_to_mnt() is pointless - you might as
> well pass existing vfsmount (or ERR_PTR()) and use _that_.  fill_super()
> is not used at all in that case.
> 	* is SB_KERNMOUNT ns_to_mnt serves only as a flag, eventually
> constant true.
>
> So let's split it in two helpers and give them sane arguments.

Everything I look at with multiple helpers feels even worse to me.
The above has the advantage it is the minimal change to fix the
regression.  So I am not worried about code correctness.

I keep wondering is the intention long term to fix sget so it has an
efficient data structure for finding super blocks (like an rbtree) or if
the intention is to deprecate sget entirely and just have everything
call alloc_super, and be responsible for their own data structures for
finding existing superblocks.

At this point since we are not in agreement on a proper fix I am going
to plan on just queueing up a revert.   So that we don't ship 4.16 with
a regression in a permission check.

Eric
