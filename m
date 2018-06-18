Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37C2C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660FF20652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660FF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936020AbeFRJwj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:52:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933380AbeFRJwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:52:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F6E513AA1;
        Mon, 18 Jun 2018 09:52:36 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-106.phx2.redhat.com [10.3.116.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B6AA5D9D1;
        Mon, 18 Jun 2018 09:52:28 +0000 (UTC)
Subject: Re: [PATCH v7 1/4] ipc: IPCMNI limit check for msgmni and shmmni
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <1525726752-29281-1-git-send-email-longman@redhat.com>
 <1525726752-29281-2-git-send-email-longman@redhat.com>
 <20180507223910.GW27853@wotan.suse.de>
 <edcc0a97-fbec-f511-36d2-fea0e123b4ee@redhat.com>
 <20180509193200.GU27853@wotan.suse.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <11228787-d9df-5c6e-3495-ad5ba2a16d18@redhat.com>
Date:   Mon, 18 Jun 2018 17:52:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180509193200.GU27853@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 18 Jun 2018 09:52:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 03:32 AM, Luis R. Rodriguez wrote:
> On Mon, May 07, 2018 at 07:57:12PM -0400, Waiman Long wrote:
>> On 05/07/2018 06:39 PM, Luis R. Rodriguez wrote:
>>> On Mon, May 07, 2018 at 04:59:09PM -0400, Waiman Long wrote:
>>>> A user can write arbitrary integer values to msgmni and shmmni sysctl
>>>> parameters without getting error, but the actual limit is really
>>>> IPCMNI (32k). This can mislead users as they think they can get a
>>>> value that is not real.
>>>>
>>>> The right limits are now set for msgmni and shmmni so that the users
>>>> will become aware if they set a value outside of the acceptable range.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>  ipc/ipc_sysctl.c | 7 +++++--
>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
>>>> index 8ad93c2..f87cb29 100644
>>>> --- a/ipc/ipc_sysctl.c
>>>> +++ b/ipc/ipc_sysctl.c
>>>> @@ -99,6 +99,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>>>>  static int zero;
>>>>  static int one = 1;
>>>>  static int int_max = INT_MAX;
>>>> +static int ipc_mni = IPCMNI;
>>>>  
>>>>  static struct ctl_table ipc_kern_table[] = {
>>>>  	{
>>>> @@ -120,7 +121,9 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>>>>  		.data		= &init_ipc_ns.shm_ctlmni,
>>>>  		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
>>>>  		.mode		= 0644,
>>>> -		.proc_handler	= proc_ipc_dointvec,
>>>> +		.proc_handler	= proc_ipc_dointvec_minmax,
>>>> +		.extra1		= &zero,
>>>> +		.extra2		= &ipc_mni,
>>>>  	},
>>>>  	{
>>>>  		.procname	= "shm_rmid_forced",
>>>> @@ -147,7 +150,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>>>>  		.mode		= 0644,
>>>>  		.proc_handler	= proc_ipc_dointvec_minmax,
>>>>  		.extra1		= &zero,
>>>> -		.extra2		= &int_max,
>>>> +		.extra2		= &ipc_mni,
>>>>  	},
>>>>  	{
>>>>  		.procname	= "auto_msgmni",
>>>> -- 
>>>> 1.8.3.1
>>> It seems negative values are not allowed, if true then having
>>> a caller to use proc_douintvec_Fminmax() would help with ensuring
>>> no invalid negative input values are used as well.
>>>
>>>   Luis
>> Negative value doesn't mean sense here. So it is true that we can use
>> proc_douintvec_minmax() instead. However, the data types themselves are
>> defined as "int". So I think it is better to keep using
>> proc_dointvec_minmax() to be consistent with the data type.
> Huh, no... If you *know* the valid values *are* only positive, the right
> thing to do is to then *change* the data type. Tons of odd bugs can creep
> up because of these stupid things.
>
>   Luis

Sorry for the late reply.

First of all, negative value will not be accepted because of the zero
lower limit check. The type of msgmni, shmmni and semmni are defined as
int in the uapi/linux/msg.h and uapi/linux/shm.h and uapi/linux/sem.h.
They are exposed to the userspace and changing them to "unsigned int"
may cause some undesirable consequence. Again this is a case of
introducing risk without any noticeable benefit.

I understand your desire of cleaning thing up. However, I am hesitant to
take this risk without seeing any real benefit in this case.

Cheers,
Longman


