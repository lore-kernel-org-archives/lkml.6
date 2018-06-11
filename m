Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9D09EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7E12087E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7E12087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934492AbeFKV1L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:27:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932395AbeFKV1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:27:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B71880401D3;
        Mon, 11 Jun 2018 21:27:10 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C78A35032A;
        Mon, 11 Jun 2018 21:27:08 +0000 (UTC)
Subject: Re: [PATCH] ipc: Limit sysctl value to IPCMNI
To:     Andrew Morton <akpm@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org
References: <20180608134949.12672-1-tiwai@suse.de>
 <20180608141659.8a517b128c756b4d0b813c9e@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <46a299ce-072c-fc84-3d52-3179ee42db4a@redhat.com>
Date:   Mon, 11 Jun 2018 17:27:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180608141659.8a517b128c756b4d0b813c9e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 11 Jun 2018 21:27:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 11 Jun 2018 21:27:10 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 05:16 PM, Andrew Morton wrote:
> On Fri,  8 Jun 2018 15:49:49 +0200 Takashi Iwai <tiwai@suse.de> wrote:
>
>> Currently shmmni proc entry accepts all entered integer values, but
>> the practical limit is IPCMNI (32768).  This confuses user as if a
>> bigger value were accepted but not applied correctly.
>>
>> This patch changes the proc entry to use *_minmax variant to limit the
>> accepted values accordingly.
> Waiman Long was working on a (vastly more complicated) patchset to
> address this.
>
>> --- a/ipc/ipc_sysctl.c
>> +++ b/ipc/ipc_sysctl.c
>> @@ -99,6 +99,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>>  static int zero;
>>  static int one = 1;
>>  static int int_max = INT_MAX;
>> +static int ipcmni = IPCMNI;
>>  
>>  static struct ctl_table ipc_kern_table[] = {
>>  	{
>> @@ -120,7 +121,9 @@ static struct ctl_table ipc_kern_table[] = {
>>  		.data		= &init_ipc_ns.shm_ctlmni,
>>  		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
>>  		.mode		= 0644,
>> -		.proc_handler	= proc_ipc_dointvec,
>> +		.proc_handler	= proc_ipc_dointvec_minmax,
>> +		.extra1		= &zero,
>> +		.extra2		= &ipcmni,
>>  	},
>>  	{
>>  		.procname	= "shm_rmid_forced",
> What is the back-compatibility situation here?
>
>
Sorry for the late reply. I am planning to send out an updated patch
once the merge window is closed. The latest patch can be found in

https://lkml.org/lkml/2018/5/7/666

Luis has some concern about the use of __read_mostly tag which I am
going to remove in the next version.

-Longman

