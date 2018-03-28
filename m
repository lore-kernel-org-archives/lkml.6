Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbeC1Ry4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:54:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:45075 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753426AbeC1Ryu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:54:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: kernel test robot <fengguang.wu@intel.com>, LKP <lkp@01.org>,
        linux-kernel@vger.kernel.org, wfg@linux.intel.com
References: <5abb446e.XtEK088UbWSHCPaF%fengguang.wu@intel.com>
        <f249d351-240a-8c0e-ef50-f9155b696e86@oracle.com>
Date: Wed, 28 Mar 2018 12:53:31 -0500
In-Reply-To: <f249d351-240a-8c0e-ef50-f9155b696e86@oracle.com> (Nagarathnam
        Muthusamy's message of "Wed, 28 Mar 2018 10:22:16 -0700")
Message-ID: <87o9j8axyc.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1f1FHM-0007kI-Hr;;;mid=<87o9j8axyc.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/iJFowUQietkLQi1XIs4CIBN3mqGydUak=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_05 8+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15026 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.9 (0.0%), b_tie_ro: 1.95 (0.0%), parse: 1.05 (0.0%),
        extract_message_metadata: 12 (0.1%), get_uri_detail_list: 1.25 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.21 (0.0%), tests_pri_-900:
        0.95 (0.0%), tests_pri_-400: 17 (0.1%), check_bayes: 16 (0.1%), b_tokenize:
        4.7 (0.0%), b_tok_get_all: 5 (0.0%), b_comp_prob: 1.61 (0.0%),
        b_tok_touch_all: 3.0 (0.0%), b_finish: 0.62 (0.0%), tests_pri_0: 96 (0.6%),
        check_dkim_signature: 0.53 (0.0%), check_dkim_adsp: 2.8 (0.0%),
        tests_pri_500: 14888 (99.1%), poll_dns_idle: 14878 (99.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: 98f929b1bd ("ipc/shm: Fix shmctl(..., IPC_STAT, ...) between .."): Oops: 0000 [#1]
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:

> Hi Eric,
>
>     From
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/tree/ipc/shm.c?h=for-next
>
> It looks like if the following condition in Line 616 succeeds
>
> error = PTR_ERR(file);
> if (IS_ERR(file))
>     goto no_file;
>
> we get to no_file with garbage value in shm_cprid. An attempt to
> put_pid on this garbage value might be causing panic.
>
> We could initialize shm_cprid to NULL as soon as it was created.

Yes.  I misread the kvmalloc as a kvzalloc.
I am planning on placing the pid freeing under the no_id label
instead of the no_file label.  Which should also avoid the issue.

It is a rare enough issue an incremental patch should be fine.

Eric
