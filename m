Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbeEHAE5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:04:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752954AbeEHAE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:04:56 -0400
Subject: Re: [PATCH v7 3/4] ipc: Allow boot time extension of IPCMNI from 32k
 to 2M
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, tglx@linutronix.de, arnd@arndb.de,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <1525726752-29281-1-git-send-email-longman@redhat.com>
 <1525726752-29281-4-git-send-email-longman@redhat.com>
 <20180507231704.GX27853@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <39507091-da19-64d7-7888-c307f4dc4670@redhat.com>
Date: Mon, 7 May 2018 20:04:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180507231704.GX27853@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 07:17 PM, Luis R. Rodriguez wrote:
> On Mon, May 07, 2018 at 04:59:11PM -0400, Waiman Long wrote:
>> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
>> index 49f9bf4..d62335f 100644
>> --- a/ipc/ipc_sysctl.c
>> +++ b/ipc/ipc_sysctl.c
>> @@ -120,7 +120,8 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
>>  static int zero;
>>  static int one = 1;
>>  static int int_max = INT_MAX;
>> -static int ipc_mni = IPCMNI;
>> +int ipc_mni __read_mostly = IPCMNI;
>> +int ipc_mni_shift __read_mostly = IPCMNI_SHIFT;
>>  
>>  static struct ctl_table ipc_kern_table[] = {
>>  	{
> Is use of ipc_mni and ipc_mni_shift a hot path? As per Christoph Lameter,
> its use should be reserved for data that is actually used frequently in hot
> paths, and typically this was done after performance traces reveal contention
> because a neighboring variable was frequently written to [0]. These would also
> be tightly packed, to reduce the number of cachelines needed to execute a
> critical path, so we should be selective about what variables use it.
>
> Your commit log does not describe why you'd use __read_mostly here. It would
> be useful if it did.
>
> [0] https://lkml.kernel.org/r/alpine.DEB.2.11.1504301343190.28879@gentwo.org
I used __read_mostly to reduce the performance impact of transitioning
from a constant to a variable. But you are right, their use are probably
not in a hot path. So even the use of regular variables shouldn't show
any noticeable performance difference. I can take that out in the my
next version after I gather enough feedback.

Cheers,
Longman
