Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41013C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1335020873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1335020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeK0TRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:17:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728923AbeK0TRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:17:33 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAR8JuZI099299
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 03:20:28 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p10kumdbn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 03:20:27 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 27 Nov 2018 08:20:25 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 08:20:21 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAR8KK5265798188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 08:20:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C317AE059;
        Tue, 27 Nov 2018 08:20:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DD91AE05D;
        Tue, 27 Nov 2018 08:20:18 +0000 (GMT)
Received: from [9.124.35.147] (unknown [9.124.35.147])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 08:20:18 +0000 (GMT)
Subject: Re: [PATCH] perf stat: Fix shadow stats for clock events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, yuzhoujian@didichuxing.com,
        tmricht@linux.vnet.ibm.com, anton@samba.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20181115141745.GJ9600@krava>
 <20181116042843.24067-1-ravi.bangoria@linux.ibm.com>
 <20181116133555.GA30465@krava>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 27 Nov 2018 13:50:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181116133555.GA30465@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112708-0008-0000-0000-0000029913F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112708-0009-0000-0000-000022035701
Message-Id: <2f319b94-8d6c-581b-19f3-43a1ab5774ef@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/18 7:05 PM, Jiri Olsa wrote:
> On Fri, Nov 16, 2018 at 09:58:43AM +0530, Ravi Bangoria wrote:
>> Commit 0aa802a79469 ("perf stat: Get rid of extra clock display
>> function") introduced scale and unit for clock events. Thus,
>> perf_stat__update_shadow_stats() now saves scaled values of
>> clock events in msecs, instead of original nsecs. But while
>> calculating values of shadow stats we still consider clock
>> event values in nsecs. This results in a wrong shadow stat
>> values. Ex,
>>
>>   # ./perf stat -e task-clock,cycles ls
>>     <SNIP>
>>               2.60 msec task-clock:u    #    0.877 CPUs utilized
>>          2,430,564      cycles:u        # 1215282.000 GHz
>>
>> Fix this by saving original nsec values for clock events in
>> perf_stat__update_shadow_stats(). After patch:
>>
>>   # ./perf stat -e task-clock,cycles ls
>>     <SNIP>
>>               3.14 msec task-clock:u    #    0.839 CPUs utilized
>>          3,094,528      cycles:u        #    0.985 GHz
>>
>> Reported-by: Anton Blanchard <anton@samba.org>
>> Suggested-by: Jiri Olsa <jolsa@redhat.com>
>> Fixes: 0aa802a79469 ("perf stat: Get rid of extra clock display function")
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>

Hi Arnaldo, Please pull this.

Thanks.

