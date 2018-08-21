Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A66C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0381E21774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0381E21774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeHUJjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:39:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbeHUJjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:39:45 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7L6IldV053509
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 02:20:59 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m0daxg4h5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 02:20:59 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 21 Aug 2018 07:20:57 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Aug 2018 07:20:51 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7L6Kou937093414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Aug 2018 06:20:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 451ECA4053;
        Tue, 21 Aug 2018 09:20:51 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA68AA4040;
        Tue, 21 Aug 2018 09:20:45 +0100 (BST)
Received: from [9.195.41.244] (unknown [9.195.41.244])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Aug 2018 09:20:45 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v9 0/4] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
 <2e997c62-371c-1d9d-97ab-65726f588ab5@linux.ibm.com>
Date:   Tue, 21 Aug 2018 11:50:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2e997c62-371c-1d9d-97ab-65726f588ab5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18082106-0020-0000-0000-000002B97F43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082106-0021-0000-0000-00002106CDF0
Message-Id: <dbd74447-b3e2-6bcf-2d8b-717b403bdf11@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808210066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On 08/21/2018 10:53 AM, Ravi Bangoria wrote:
> Hi Song,
> 
>> However, if I start a.out AFTER enabling the uprobe, there is something wrong:
>>
>> root@virt-test:~# ~/a.out
>> 11
>> semaphore 0       <<< this should be non-zero, as the uprobe is already enabled

In this testcase, semaphore variable is stored into .bss:

  $ nm test | grep semaphore
  0000000010010c5e B semaphore
 
  $ readelf -SW ./test | grep "data\|bss"
    [22] .data             PROGBITS        0000000010010c58 000c58 000004 00  WA  0   0  1
    [23] .bss              NOBITS          0000000010010c5c 000c5c 000004 00  WA  0   0  2

I'm not so sure but I guess .bss data initialization happens after
calling uprobe_mmap() and thus you are seeing semaphore as 0.

To verify this, if I force to save semaphore into data section by
assigning non-zero value to it:

  volatile short semaphore = 1

 $ nm test | grep semaphore
 0000000010010c5c D semaphore

 $ readelf -SW ./test | grep "data\|bss"
    [22] .data             PROGBITS        0000000010010c58 000c58 000006 00  WA  0   0  2
    [23] .bss              NOBITS          0000000010010c5e 000c5e 000002 00  WA  0   0  1 

increment/decrement works fine.

Ravi

