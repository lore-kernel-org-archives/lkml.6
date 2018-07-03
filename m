Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C8C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D31D20837
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D31D20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933423AbeGCIAQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:00:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753364AbeGCIAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:00:15 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w637xq3N082638
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 04:00:14 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k04xc8rm9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 04:00:14 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 3 Jul 2018 09:00:11 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 09:00:06 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63805WD31522942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 08:00:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95E51AE05A;
        Tue,  3 Jul 2018 11:00:08 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BCE5AE055;
        Tue,  3 Jul 2018 11:00:05 +0100 (BST)
Received: from [9.124.31.159] (unknown [9.124.31.159])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 11:00:05 +0100 (BST)
Subject: Re: [PATCH v5 10/10] perf probe: Support SDT markers having reference
 counter (semaphore)
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>, mhiramat@kernel.org
Cc:     oleg@redhat.com, rostedt@goodmis.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-11-ravi.bangoria@linux.ibm.com>
 <20180702145727.GC65296@linux.vnet.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 3 Jul 2018 13:30:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702145727.GC65296@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070308-0020-0000-0000-000002A283D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070308-0021-0000-0000-000020EE999F
Message-Id: <c29309ae-65ff-8a68-42ef-7e9f77227571@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar,

On 07/02/2018 08:27 PM, Srikar Dronamraju wrote:
> * Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-06-28 10:52:09]:
> 
>> With this, perf buildid-cache will save SDT markers with reference
>> counter in probe cache. Perf probe will be able to probe markers
>> having reference counter. Ex,
>>
>>   # readelf -n /tmp/tick | grep -A1 loop2
>>     Name: loop2
>>     ... Semaphore: 0x0000000010020036
>>
>>   # ./perf buildid-cache --add /tmp/tick
> 
> Would this perf buildid-cache work if the executable is stripped of
> symbols?

Description of SDT markers resides in .notes section. If .notes section
is there, binary has SDT markers, if .notes section is not there, binary
does not have any SDT markers. So SDT markers does not have anything to
do with symbol table.

> 
>>   # ./perf probe sdt_tick:loop2
>>   # ./perf stat -e sdt_tick:loop2 /tmp/tick
>>     hi: 0
>>     hi: 1
>>     hi: 2
>>     ^C
>>      Performance counter stats for '/tmp/tick':
>>                  3      sdt_tick:loop2
>>        2.561851452 seconds time elapsed
> 
> Also can we document how to use SDT markers with perf under perf-probe
> or perf-build-cache?
> 

Yes, perf-buildid-cache and perf-probe man pages describes about SDT
markers.

Thanks,
Ravi

