Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB6C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413F3208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CllBredL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413F3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbeLGNp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:45:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56222 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLGNp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:45:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB7DdNn2055354;
        Fri, 7 Dec 2018 13:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=PE3fYvAYPASrhBQ2gknZJJFUEtgY3aHudDyJpriEAVs=;
 b=CllBredLIkn2P/ndGhlZokXNOmxysnd/uhehWVJ4a2RVINcyhTRDEuLWa5TeBJ8XFOGH
 UUit/JfXIW7GTRZYYSNCCHvZQbl5hNOURuwWH3VEfohh2nclzAaEw1FZuJ3qv+pqPlQN
 NudCKbiAm4moajrJWvvHqQf1ASnTu3GutiVqvWaZ71VYK8eNY8efeW+mH+pkoHTuMNSC
 nnht/2T4SYNXuju7YUNTBxODlOzhhtcGf9dR7+M/EARtqVE9akV03oPlWhoeWoSPFi2v
 Bd8p5Tzw2JcAtPlw2rrekcwE9Symmp8rwB67u5tPQkR+in/Xpl6Wyto/CZ++QmRWaFqU /w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2p3jxrwucr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 13:45:32 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB7DjV6K022084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 13:45:31 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB7DjUrj023072;
        Fri, 7 Dec 2018 13:45:30 GMT
Received: from [10.39.214.172] (/10.39.214.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 05:45:30 -0800
Subject: Re: [PATCH v4 10/10] sched/fair: Provide idle search schedstats
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <1544131696-2888-11-git-send-email-steven.sistare@oracle.com>
 <be837c2a-6e8d-3598-0a27-db90792a2673@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <e2f0d3c6-23d3-2d7c-9605-5095d69e00e4@oracle.com>
Date:   Fri, 7 Dec 2018 08:45:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <be837c2a-6e8d-3598-0a27-db90792a2673@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2018 6:56 AM, Valentin Schneider wrote:
> Hi Steve,
> 
> On 06/12/2018 21:28, Steve Sistare wrote:
> [...]
>> @@ -6392,6 +6422,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
>>  static int
>>  select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
>>  {
>> +	unsigned long time = schedstat_start_time();
> 
> With arm64's defconfig (!CONFIG_SCHEDSTATS) I get:
> 
> kernel/sched/fair.c: In function ‘select_task_rq_fair’:
> kernel/sched/fair.c:6459:16: warning: unused variable ‘time’ [-Wunused-variable]
>   unsigned long time = schedstat_start_time();
>                 ^~~~
> 
> So you probably want something like this:
> 
> ----->8-----
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5a113a8..7d33f74 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6456,12 +6456,14 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
>  static int
>  select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
>  {
> -	unsigned long time = schedstat_start_time();
>  	struct sched_domain *tmp, *sd = NULL;
>  	int cpu = smp_processor_id();
>  	int new_cpu = prev_cpu;
>  	int want_affine = 0;
>  	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
> +	unsigned long time;
> +
> +	time = schedstat_start_time();
>  
>  	if (sd_flag & SD_BALANCE_WAKE) {
>  		record_wakee(p);
> -----8<-----
> 
> The 0-day bot will catch those but since it's the only warn I got I figured
> I'd report it :)

Thanks.  This patch is provided for steal evaluation only and it should be 
dropped before the series is pushed upstream.  If I ever post it again for
future work, I will apply your fix.

- Steve
