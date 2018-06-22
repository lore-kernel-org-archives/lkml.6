Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A256EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FCD23CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FCD23CC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934403AbeFVDyC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:54:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934362AbeFVDyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:54:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5M3nfdt142867
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 23:54:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jrp9fnt33-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 23:54:00 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 22 Jun 2018 04:53:57 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 04:53:54 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5M3rrkX36241526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 03:53:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE3984C04A;
        Fri, 22 Jun 2018 04:53:52 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDF9B4C046;
        Fri, 22 Jun 2018 04:53:50 +0100 (BST)
Received: from [9.77.204.211] (unknown [9.77.204.211])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 04:53:50 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
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
Date:   Fri, 22 Jun 2018 09:23:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620135220.GP20477@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18062203-0012-0000-0000-000002822999
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062203-0013-0000-0000-000020B37198
Message-Id: <6691adb2-e3d7-3cae-1d78-e5fd30317283@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220040
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

So, it's not about setting evsel->priv to 'struct perf_evsel_script', but
it's about setting proper output stream, either file or stdout. When
'struct perf_evsel_script' was not introduced, we were setting evsel->priv
to output stream. So I think, this commit missed to set evsel->priv properly
in pipped case. Ex, below patch applied _directly_ on top of a14390fde64e
fixes the issue.

------
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fb5e49b3bc44..66cc4b29bf4d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1645,6 +1645,9 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	evlist = *pevlist;
 	evsel = perf_evlist__last(*pevlist);
 
+	if (!evsel->priv)
+		evsel->priv = stdout;
+
 	if (evsel->attr.type >= PERF_TYPE_MAX &&
 	    evsel->attr.type != PERF_TYPE_SYNTH)
 		return 0;
------

To me this commit seems to be the bad. Please let me know if that is not
the case. I'll change the last patch as you suggested an post v2 soon.

Thanks,
Ravi

