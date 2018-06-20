Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEACC1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AA720874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AA720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeFTOBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:01:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753880AbeFTOBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:01:16 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KE0tUt153100
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:01:15 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqpkbn9m0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:01:09 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 20 Jun 2018 15:01:01 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 15:00:56 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KE0teK31326242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 14:00:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44FCD42047;
        Wed, 20 Jun 2018 14:50:55 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 048C042045;
        Wed, 20 Jun 2018 14:50:52 +0100 (BST)
Received: from [9.195.33.217] (unknown [9.195.33.217])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 14:50:51 +0100 (BST)
Subject: Re: [PATCH 2/3] perf script: Fix crash because of missing evsel->priv
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, dsahern@gmail.com, davidcc@google.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180620133030.2188-1-ravi.bangoria@linux.ibm.com>
 <20180620133030.2188-3-ravi.bangoria@linux.ibm.com>
 <20180620135220.GP20477@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 20 Jun 2018 19:30:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620135220.GP20477@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18062014-0012-0000-0000-000002818AC7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062014-0013-0000-0000-000020B2CADF
Message-Id: <e4396e01-2de9-3c11-7a2f-5e7fc894b5ae@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 06/20/2018 07:22 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 20, 2018 at 07:00:29PM +0530, Ravi Bangoria escreveu:
>> perf script in pipped mode is crashing because evsel->priv is not
>> set properly. Fix it.
>>
>> Before:
>>   # ./perf record -o - -- ls | ./perf script
>>     Segmentation fault (core dumped)
>>
>> After:
>>   # ./perf record -o - -- ls | ./perf script
>>   ls 2282 1031.731974:  250000 cpu-clock:uhH:  7effe4b3d29e
>>   ls 2282 1031.732222:  250000 cpu-clock:uhH:  7effe4b3a650
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> Fixes: a14390fde64e ("perf script: Allow creating per-event dump files")
> 
> Humm, this cset doesn't set evsel->priv to a 'struct perf_evsel_script'
> object, will check which one does to continue review.

Possible. Actually, git bisect led me to this commit.

Ravi

