Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29253C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBA320685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fr/SvRbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBA320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeKFFaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:30:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54732 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbeKFFaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:30:17 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5K63kh081462;
        Mon, 5 Nov 2018 20:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5vMyW/Jps6w9tpZOvnsTAHZKb9apR9/voHFFyWKajM0=;
 b=fr/SvRbtV0ZG86bWOWr0ldIJtkLi1ayblvA0uZ+w5VleSrEVBsmvxjlFZ+iT/mADe3kJ
 fdxVNwiCAgfkH9Z5YQVyM5sPtomUn20JclJr7U6CSPN11UsGH4bTxWB4+10WfxZ2km0L
 l3sUWtygZrDRQnpAUhO1FM5NXoTUAaqDd5eT3DBJw8yaNvRtwsJ2LqsgbgnYuJPd47cm
 0j3d5zD0CUwWP4H5xnL89VlgTZ0zeWyZrrxDi8KRbJ+kmqRjX3o3keFBtYoMIevFXrCc
 5W/8w807evySxw79kTpNmgg8yYGZgHbJmgZ78hTC6FN+zQyyFWwMIhCEwxeMOoIoJl5o ig== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nh3mph8um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 20:08:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA5K8JrN016131
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 20:08:19 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA5K8HxW020692;
        Mon, 5 Nov 2018 20:08:18 GMT
Received: from [10.152.33.198] (/10.152.33.198)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 12:08:17 -0800
Subject: Re: [PATCH 00/10] steal tasks to improve CPU utilization
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     dhaval.giani@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        quentin.perret@arm.com
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <aaa9cfea-d5f9-06a3-242f-05a1f3f9e7c8@oracle.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <0ac6a3ec-84af-1868-936c-1ccc0d401af8@oracle.com>
Date:   Mon, 5 Nov 2018 15:08:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <aaa9cfea-d5f9-06a3-242f-05a1f3f9e7c8@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=865
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/2018 7:39 PM, Subhra Mazumdar wrote:
> On 10/22/18 7:59 AM, Steve Sistare wrote:
>> When a CPU has no more CFS tasks to run, and idle_balance() fails to
>> find a task, then attempt to steal a task from an overloaded CPU in the
>> same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently
>> identify candidates.  To minimize search time, steal the first migratable
>> task that is found when the bitmap is traversed.  For fairness, search
>> for migratable tasks on an overloaded CPU in order of next to run.
>>
>> This simple stealing yields a higher CPU utilization than idle_balance()
>> alone, because the search is cheap, so it may be called every time the CPU
>> is about to go idle.  idle_balance() does more work because it searches
>> widely for the busiest queue, so to limit its CPU consumption, it declines
>> to search if the system is too busy.  Simple stealing does not offload the
>> globally busiest queue, but it is much better than running nothing at all.
>>
>> The bitmap of overloaded CPUs is a new type of sparse bitmap, designed to
>> reduce cache contention vs the usual bitmap when many threads concurrently
>> set, clear, and visit elements.
>>
> Is the bitmask saving much? I tried a simple stealing that just starts
> searching the domain from the current cpu and steals a thread from the
> first cpu that has more than one runnable thread. It seems to perform
> similar to your patch.
> 
> hackbench on X6-2: 2 sockets * 22 cores * 2 hyperthreads = 88 CPUs
>                 baseline        %stdev  patch %stdev
> 1(40 tasks)     0.5524          2.36    0.5522 (0.045%) 3.82
> 2(80 tasks)     0.6482          11.4    0.7241 (-11.7%) 20.34
> 4(160 tasks)    0.9756          0.95    0.8276 (15.1%) 5.8
> 8(320 tasks)    1.7699          1.62    1.6655 (5.9%) 1.57
> 16(640 tasks)   3.1018          0.77    2.9858 (3.74%) 1.4
> 32(1280 tasks)  5.565           0.62    5.3388 (4.1%) 0.72
> 
> X6-2: 2 sockets * 22 cores * 2 hyperthreads = 88 CPUs
> Oracle database OLTP, logging _enabled_
> 
> Users %speedup
> 20 1.2
> 40 -0.41
> 60 0.83
> 80 2.37
> 100 1.54
> 120 3.0
> 140 2.24
> 160 1.82
> 180 1.94
> 200 2.23
> 220 1.49
Hi Subhra,
  The bitset is a few percent faster than iterating over CPUs in the
tests I ran on the X6-2 with 44 CPUs per node.  If we extend stealing to 
RT, folks care even more about a few percent. The difference should be 
greater on systems with more CPUs per socket, and greater if we extend 
stealing to steal across NUMA nodes, and greater if Valentin adds another
bitset for misfits. Lastly, there is no measurable downside in maintaining 
the overloaded CPUs bitset.  I ran experiments where I set and cleared the 
bits in overload_set and overload_clear, but disabled stealing itself, and 
saw no significant difference versus the baseline.

- Steve
