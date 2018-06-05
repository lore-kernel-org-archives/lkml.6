Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752341AbeFET4m convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:56:42 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36834 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeFET4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:56:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ilya Matveychikov <matvejchikov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
        <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com>
Date: Tue, 05 Jun 2018 14:56:31 -0500
In-Reply-To: <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com> (Ilya
        Matveychikov's message of "Tue, 5 Jun 2018 10:59:51 +0400")
Message-ID: <87o9gpatxs.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fQI4N-0001AN-HS;;;mid=<87o9gpatxs.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18xnCP1tORvvJ8/5vS5coBItrgeR/Z1HDo=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ilya Matveychikov <matvejchikov@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 178 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (1.4%), b_tie_ro: 1.69 (0.9%), parse: 0.74 (0.4%),
        extract_message_metadata: 15 (8.4%), get_uri_detail_list: 1.70 (1.0%),
        tests_pri_-1000: 8 (4.6%), tests_pri_-950: 1.11 (0.6%), tests_pri_-900: 0.96
        (0.5%), tests_pri_-400: 20 (11.0%), check_bayes: 19 (10.4%), b_tokenize: 6
        (3.3%), b_tok_get_all: 6 (3.4%), b_comp_prob: 1.84 (1.0%), b_tok_touch_all:
        3.0 (1.7%), b_finish: 0.57 (0.3%), tests_pri_0: 124 (69.6%),
        check_dkim_signature: 0.47 (0.3%), check_dkim_adsp: 2.3 (1.3%),
        tests_pri_500: 3.7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] ksys_mount: check for permissions before resource allocation
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilya Matveychikov <matvejchikov@gmail.com> writes:

> Just CC’ed to some of maintainers.
>
> $ perl scripts/get_maintainer.pl fs/0001-ksys_mount-check-for-permissions-before-resource-all.patch
> Alexander Viro <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS and infrastructure))
> linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
> linux-kernel@vger.kernel.org (open list)
>
>> On Jun 5, 2018, at 6:00 AM, Ilya Matveychikov <matvejchikov@gmail.com> wrote:
>> 
>> Early check for mount permissions prevents possible allocation of 3
>> pages from kmalloc() pool by unpriveledged user which can be used for
>> spraying the kernel heap.

*Snort*

You clearly have not read may_mount.  Your modified code still
let's unprivileged users in.  So even if all of Al's good objections
were not applicable this change would still be buggy and wrong.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>> Signed-off-by: Ilya V. Matveychikov <matvejchikov@gmail.com>
>> ---
>> fs/namespace.c | 3 +++
>> 1 file changed, 3 insertions(+)
>> 
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index 5f75969adff1..1ef8feb2de2a 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -3046,6 +3046,9 @@ int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
>> 	char *kernel_dev;
>> 	void *options;
>> 
>> +	if (!may_mount())
>> +		return -EPERM;
>> +
>> 	kernel_type = copy_mount_string(type);
>> 	ret = PTR_ERR(kernel_type);
>> 	if (IS_ERR(kernel_type))
>> --
>> 2.17.0
>> 
