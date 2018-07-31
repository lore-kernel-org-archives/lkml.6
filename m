Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBB2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC78A20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC78A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbeGaUcq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:32:46 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:35314 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbeGaUcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:32:46 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1fkZjb-00007Z-Vo from George_Davis@mentor.com ; Tue, 31 Jul 2018 11:51:04 -0700
Received: from svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) by
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 31 Jul 2018 11:51:01 -0700
Received: from svr-orw-mbx-02.mgc.mentorg.com ([fe80::b428:a08e:8ebc:bfa]) by
 svr-orw-mbx-02.mgc.mentorg.com ([fe80::b428:a08e:8ebc:bfa%22]) with mapi id
 15.00.1320.000; Tue, 31 Jul 2018 11:51:01 -0700
From:   "Davis, George" <George_Davis@mentor.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "Davis, George" <George_Davis@mentor.com>,
        "Wang, Jiada (ESD)" <Jiada_Wang@mentor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "erosca@de.adit-jv.com" <erosca@de.adit-jv.com>
Subject: Re: [PATCH v2 1/1] sched/debug: fix potential deadlock when write to
 sched_features
Thread-Topic: [PATCH v2 1/1] sched/debug: fix potential deadlock when write to
 sched_features
Thread-Index: AQHUKMfAtegF/Co/gkShoSFJOF2US6SpuhiAgABohQA=
Date:   Tue, 31 Jul 2018 18:51:01 +0000
Message-ID: <E6A8E911-491D-4185-A5FC-AD2B53037C71@mentor.com>
References: <20180731121222.26195-1-jiada_wang@mentor.com>
 <20180731123651.GW2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180731123651.GW2494@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.94.39.250]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A40566CBE793D41B5B5C98C92821B43@mentor.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 31, 2018, at 8:36 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Tue, Jul 31, 2018 at 09:12:22PM +0900, jiada_wang@mentor.com wrote:
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index 60caf1fb94e0..7b2997d4a349 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -87,21 +87,21 @@ struct static_key sched_feat_keys[__SCHED_FEAT_NR] = {
>> 
>> #undef SCHED_FEAT
>> 
>> -static void sched_feat_disable(int i)
>> +static void sched_feat_disable_cpuslocked(int i)
>> {
>> -	static_key_disable(&sched_feat_keys[i]);
>> +	static_key_disable_cpuslocked(&sched_feat_keys[i]);
>> }
>> 
>> -static void sched_feat_enable(int i)
>> +static void sched_feat_enable_cpuslocked(int i)
>> {
>> -	static_key_enable(&sched_feat_keys[i]);
>> +	static_key_enable_cpuslocked(&sched_feat_keys[i]);
>> }
>> #else
>> -static void sched_feat_disable(int i) { };
>> -static void sched_feat_enable(int i) { };
>> +static void sched_feat_disable_cpuslocked(int i) { };
>> +static void sched_feat_enable_cpuslocked(int i) { };
>> #endif /* HAVE_JUMP_LABEL */
>> 
>> -static int sched_feat_set(char *cmp)
>> +static int sched_feat_set_cpuslocked(char *cmp)
>> {
>> 	int i;
>> 	int neg = 0;
>> @@ -117,10 +117,10 @@ static int sched_feat_set(char *cmp)
>> 
>> 	if (neg) {
>> 		sysctl_sched_features &= ~(1UL << i);
>> -		sched_feat_disable(i);
>> +		sched_feat_disable_cpuslocked(i);
>> 	} else {
>> 		sysctl_sched_features |= (1UL << i);
>> -		sched_feat_enable(i);
>> +		sched_feat_enable_cpuslocked(i);
>> 	}
>> 
>> 	return 0;
>> @@ -146,9 +146,11 @@ sched_feat_write(struct file *filp, const char __user *ubuf,
>> 
>> 	/* Ensure the static_key remains in a consistent state */
>> 	inode = file_inode(filp);
>> +	cpus_read_lock();
>> 	inode_lock(inode);
>> -	ret = sched_feat_set(cmp);
>> +	ret = sched_feat_set_cpuslocked(cmp);
>> 	inode_unlock(inode);
>> +	cpus_read_unlock();
>> 	if (ret < 0)
>> 		return ret;
>> 
> 
> I've made that..
> 
> ---
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -89,12 +89,12 @@ struct static_key sched_feat_keys[__SCHE
> 
> static void sched_feat_disable(int i)
> {
> -	static_key_disable(&sched_feat_keys[i]);
> +	static_key_disable_cpuslocked(&sched_feat_keys[i]);
> }
> 
> static void sched_feat_enable(int i)
> {
> -	static_key_enable(&sched_feat_keys[i]);
> +	static_key_enable_cpuslocked(&sched_feat_keys[i]);
> }
> #else
> static void sched_feat_disable(int i) { };
> @@ -146,9 +146,11 @@ sched_feat_write(struct file *filp, cons
> 
> 	/* Ensure the static_key remains in a consistent state */
> 	inode = file_inode(filp);
> +	cpus_read_lock();
> 	inode_lock(inode);
> 	ret = sched_feat_set(cmp);
> 	inode_unlock(inode);
> +	cpus_read_unlock();
> 	if (ret < 0)
> 		return ret;
> 

For the record, for both Jiada's v2 and Peter's simplified versions:

Reviewed-and-Tested-by: George G. Davis <george_davis@mentor.com>



