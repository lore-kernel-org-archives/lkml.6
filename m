Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750881AbeEaU52 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:57:28 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45969 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEaU5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:57:23 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: CHANDAN VN <chandan.vn@samsung.com>, gregkh@linuxfoundation.org,
        tj@kernel.org, bfields@fieldses.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        cpgs@samsung.com, sireesha.t@samsung.com
References: <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcas1p2.samsung.com>
        <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
        <cae274dd-e9e5-39b1-8b7b-aec1b3e76fe9@schaufler-ca.com>
Date: Thu, 31 May 2018 15:57:00 -0500
In-Reply-To: <cae274dd-e9e5-39b1-8b7b-aec1b3e76fe9@schaufler-ca.com> (Casey
        Schaufler's message of "Thu, 31 May 2018 08:26:23 -0700")
Message-ID: <87po1ba6hv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fOUd7-0005ar-Sd;;;mid=<87po1ba6hv.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/XP0tPEpehqsmwDWlaPGm1Ip3r44VJ/mU=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  2.5 XM_E_VN URI: Link to something.vn
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;Casey Schaufler <casey@schaufler-ca.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15041 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (0.0%), b_tie_ro: 1.76 (0.0%), parse: 1.25 (0.0%),
        extract_message_metadata: 21 (0.1%), get_uri_detail_list: 3.0 (0.0%),
        tests_pri_-1000: 4.6 (0.0%), tests_pri_-950: 1.80 (0.0%), tests_pri_-900:
        1.54 (0.0%), tests_pri_-400: 30 (0.2%), check_bayes: 28 (0.2%), b_tokenize:
        13 (0.1%), b_tok_get_all: 7 (0.0%), b_comp_prob: 3.3 (0.0%), b_tok_touch_all:
        3.1 (0.0%), b_finish: 0.59 (0.0%), tests_pri_0: 188 (1.2%),
        check_dkim_signature: 0.48 (0.0%), check_dkim_adsp: 2.6 (0.0%),
        tests_pri_500: 14787 (98.3%), poll_dns_idle: 14769 (98.2%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 1/1] Fix memory leak in kernfs_security_xattr_set and kernfs_security_xattr_set
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 5/31/2018 2:28 AM, CHANDAN VN wrote:
>> From: "sireesha.t" <sireesha.t@samsung.com>
>>
>> Leak is caused because smack_inode_getsecurity() is allocating memory
>> using kstrdup(). Though the security_release_secctx() is called, it
>> would not free the allocated memory. Calling security_release_secctx is
>> not relevant for this scenario as inode_getsecurity() does not provide a
>> "secctx".
>>
>> Similar fix has been mainlined:
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=57e7ba04d422c3d41c8426380303ec9b7533ded9
>>
>> The fix is to replace the security_release_secctx() with a kfree()
>>
>> Below is the KMEMLEAK dump:
>> unreferenced object 0xffffffc025e11c80 (size 64):
>>   comm "systemd-tmpfile", pid 2452, jiffies 4294894464 (age 235587.492s)
>>   hex dump (first 32 bytes):
>>     53 79 73 74 65 6d 3a 3a 53 68 61 72 65 64 00 00  System::Shared..
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffff80081be770>] __save_stack_trace+0x28/0x34
>>     [<ffffff80081bedb8>] create_object+0x130/0x25c
>>     [<ffffff80088c82f8>] kmemleak_alloc+0x30/0x5c
>>     [<ffffff80081b3ef0>] __kmalloc_track_caller+0x1cc/0x2a8
>>     [<ffffff800818673c>] kstrdup+0x3c/0x6c
>>     [<ffffff80082d78b0>] smack_inode_getsecurity+0xcc/0xec
>>     [<ffffff80082d78f4>] smack_inode_getsecctx+0x24/0x44
>>     [<ffffff80082d5ea0>] security_inode_getsecctx+0x50/0x70
>>     [<ffffff800823bbcc>] kernfs_security_xattr_set+0x74/0xe0
>>     [<ffffff80081eafec>] __vfs_setxattr+0x74/0x90
>>     [<ffffff80081eb088>] __vfs_setxattr_noperm+0x80/0x1ac
>>     [<ffffff80081eb238>] vfs_setxattr+0x84/0xac
>>     [<ffffff80081eb374>] setxattr+0x114/0x178
>>     [<ffffff80081eb44c>] path_setxattr+0x74/0xb8
>>     [<ffffff80081ebdcc>] SyS_lsetxattr+0x10/0x1c
>>     [<ffffff800808310c>] __sys_trace_return+0x0/0x4
>>
>> Signed-off-by: sireesha.t <sireesha.t@samsung.com>
>> Signed-off-by: CHANDAN VN <chandan.vn@samsung.com>
>
> Why not:
>
>  static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
>  {
> -	int len = 0;
> -	len = smack_inode_getsecurity(inode, XATTR_SMACK_SUFFIX, ctx, true);
> +	int len = smack_inode_getsecurity(inode, XATTR_SMACK_SUFFIX, ctx, false);
>
The practical difference here is the true vs the false in the call
to smack_inode_getsecurity?

>  	if (len < 0)
>  		return len;
>

Eric
