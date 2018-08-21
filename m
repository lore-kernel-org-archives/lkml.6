Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FAAC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A34021570
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A34021570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeHUPSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:18:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727058AbeHUPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:18:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LBssPJ106714
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:58:43 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m0ft4pfd4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:58:42 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 21 Aug 2018 12:58:40 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Aug 2018 12:58:34 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7LBwXGv42401966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Aug 2018 11:58:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE68CA404D;
        Tue, 21 Aug 2018 14:58:33 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DE48A4040;
        Tue, 21 Aug 2018 14:58:28 +0100 (BST)
Received: from [9.195.41.244] (unknown [9.195.41.244])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Aug 2018 14:58:28 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v9 0/4] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Song Liu <liu.song.a23@gmail.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        ananth@linux.vnet.ibm.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, mhiramat@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        paul.burton@mips.com, Peter Zijlstra <peterz@infradead.org>,
        ralf@linux-mips.org, Steven Rostedt <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
 <1534836620.dp1nz6tfz0.naveen@linux.ibm.com>
Date:   Tue, 21 Aug 2018 17:28:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1534836620.dp1nz6tfz0.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082111-0012-0000-0000-0000029C9D11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082111-0013-0000-0000-000020CFDBB6
Message-Id: <4445e941-551e-881f-c519-db82ed9b9b5c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808210127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/21/2018 01:04 PM, Naveen N. Rao wrote:
> Song Liu wrote:
>> I am testing the patch set with the following code:
>>
>> #include <stdio.h>
>> #include <unistd.h>
>>
>> volatile short semaphore = 0;
>>
>> int for_uprobe(int c)
>> {
>>         printf("%d\n", c + 10);
>>         return c + 1;
>> }
>>
>> int main(int argc, char *argv[])
>> {
>>         for_uprobe(argc);
>>         while (1) {
>>                 sleep(1);
>>                 printf("semaphore %d\n", semaphore);
>>         }
>> }
>>
>> I created a uprobe on function for_uprobe(), that uses semaphore as
>> reference counter:
>>
>>   echo "p:uprobe_1 /root/a.out:0x49a(0x1036)" >> uprobe_events
> 
> Is that even valid? That _looks_ like a semaphore, but I'm not quite sure that it qualifies as an _SDT_ semaphore. Do you see this issue if you instead use the macros provided by <sys/sdt.h> to create SDT markers?
> 

Right. By default SDT reference counters(semaphore) goes into .probes
section:

  [25] .probes           PROGBITS        000000000060102c 00102c 000004 00  WA  0   0  2

which has PROGBITS set. So this works fine. And there are many other
things which are coded into <sys/sdt.h>. So the official way to use
SDT markers should be through that.

Ravi

