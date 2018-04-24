Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeDXQez (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:34:55 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40702 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeDXQev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:34:51 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot+7a1cff37dbbef9e7ba4c@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, viro@ZenIV.linux.org.uk,
        akpm@linux-foundation.org, dhowells@redhat.com, ebiggers3@gmail.com,
        gs051095@gmail.com, ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        oleg@redhat.com, pasha.tatashin@oracle.com, riel@redhat.com,
        rppt@linux.vnet.ibm.com, wangkefeng.wang@huawei.com
References: <94eb2c06406c59cccc0568c527c2@google.com>
        <000000000000a45f6f05697f173b@google.com>
        <201804102333.BCC87582.MFHFOQFOOJLVtS@I-love.SAKURA.ne.jp>
        <12b09710-ddc3-7948-b24e-487c514f028e@I-love.SAKURA.ne.jp>
Date: Tue, 24 Apr 2018 11:33:22 -0500
In-Reply-To: <12b09710-ddc3-7948-b24e-487c514f028e@I-love.SAKURA.ne.jp>
        (Tetsuo Handa's message of "Sat, 21 Apr 2018 19:43:18 +0900")
Message-ID: <8736zkbm3x.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fB0u0-0005K1-4w;;;mid=<8736zkbm3x.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ApTVxY72U8rjTGlFihhc2JTpw+C8jlMc=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 196 ms - load_scoreonly_sql: 0.13 (0.1%),
        signal_user_changed: 2.4 (1.2%), b_tie_ro: 1.63 (0.8%), parse: 0.59 (0.3%),
        extract_message_metadata: 11 (5.5%), get_uri_detail_list: 1.43 (0.7%),
        tests_pri_-1000: 5 (2.7%), tests_pri_-950: 1.07 (0.5%), tests_pri_-900: 5
        (2.6%), tests_pri_-400: 28 (14.5%), check_bayes: 27 (13.9%), b_tokenize: 5
        (2.7%), b_tok_get_all: 10 (5.2%), b_comp_prob: 2.7 (1.4%), b_tok_touch_all: 7
        (3.4%), b_finish: 0.82 (0.4%), tests_pri_0: 133 (68.1%),
        check_dkim_signature: 0.41 (0.2%), check_dkim_adsp: 3.3 (1.7%),
        tests_pri_500: 6 (3.3%), poll_dns_idle: 1.59 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: KASAN: use-after-free Read in alloc_pid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> On 2018/04/10 23:33, Tetsuo Handa wrote:
>> syzbot wrote:
>>> syzbot has found reproducer for the following crash on upstream commit
>>> c18bb396d3d261ebbb4efbc05129c5d354c541e4 (Tue Apr 10 00:04:10 2018 +0000)
>>> Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
>>> syzbot dashboard link:  
>>> https://syzkaller.appspot.com/bug?extid=7a1cff37dbbef9e7ba4c
>>>
>> While we are waiting for
>> 
>>   rpc_pipefs: fix double-dput()
>>   rpc_pipefs: deal with early sget() failures
>>   kernfs: deal with early sget() failures
>>   procfs: deal with early sget() failures
>>   orangefs_kill_sb(): deal with allocation failures
>>   nfsd_umount(): deal with early sget() failures
>>   nfs: avoid double-free on early sget() failures
>>   jffs2_kill_sb(): deal with failed allocations
>>   hypfs_kill_super(): deal with failed allocations
>> 
>> in https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=for-linus ,
>> I think the patch at
>> 
>>   WARNING in kill_block_super
>>   https://syzkaller.appspot.com/bug?id=588996a25a2587be2e3a54e8646728fb9cae44e7
>> 
>> is better.
>> 
>
> OK. The patch was sent to linux.git as commit 8e04944f0ea8b838.
>
> #syz fix: mm,vmscan: Allow preallocating memory for
> register_shrinker().

Sigh no fixes tag on the commit you sent to Linus, and no
cc'ing of stable.

Can you please update the stable folks that 9ee332d99e4d ("sget():
handle failures of register_shrinker()") is fixed with the commit you
just sent to Linus?

Thank you,
Eric
