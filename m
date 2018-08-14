Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19657C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5AE21527
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5AE21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbeHNHXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 03:23:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbeHNHXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 03:23:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7E4XtEd065727
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 00:37:43 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kuqfq1b2n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 00:37:42 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 14 Aug 2018 05:37:40 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 05:37:34 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7E4bXDd42795068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 04:37:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5263AE055;
        Tue, 14 Aug 2018 07:37:20 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90107AE04D;
        Tue, 14 Aug 2018 07:37:17 +0100 (BST)
Received: from [9.124.35.253] (unknown [9.124.35.253])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 07:37:17 +0100 (BST)
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
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
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
 <20180813115019.GB28360@redhat.com>
 <fa85d19f-b22c-e09c-b8d2-f68f0c79de15@linux.ibm.com>
 <20180813131723.GC28360@redhat.com>
 <CAPhsuW4KT=6vR_0ogTy_+Fwcz7cZ0Rac8sYohLngQmEBCd0HLw@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 14 Aug 2018 10:07:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4KT=6vR_0ogTy_+Fwcz7cZ0Rac8sYohLngQmEBCd0HLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18081404-0028-0000-0000-000002EA6679
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081404-0029-0000-0000-000023A384C5
Message-Id: <58d21bac-5a31-85df-4b9f-05815b64f465@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808140045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On 08/13/2018 10:42 PM, Song Liu wrote:
> On Mon, Aug 13, 2018 at 6:17 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> On 08/13, Ravi Bangoria wrote:
>>>
>>>> But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
>>>> hook and avoid delayed_uprobe_install() in uprobe_mmap().
>>>
>>> I'm sorry. I didn't get this.
>>
>> Sorry for confusion...
>>
>> I meant, if only exec*( could race with _register(), we could add another uprobe
>> hook which updates all (delayed) counters before return to user-mode.
>>
>>>> Afaics, the really problematic case is dlopen() which can race with _register()
>>>> too, right?
>>>
>>> dlopen() should internally use mmap() right? So what is the problem here? Can
>>> you please elaborate.
>>
>> What I tried to say is that we can't avoid uprobe_mmap()->delayed_uprobe_install()
>> because dlopen() can race with _register() too, just like exec.
>>
>> Oleg.
>>
> 
> How about we do delayed_uprobe_install() per file? Say we keep a list
> of delayed_uprobe
> in load_elf_binary(). Then we can install delayed_uprobe after loading
> all sections of the
> file.

I'm not sure if I totally understood the idea. But how this approach can
solve dlopen() race with _register()?

Rather, making delayed_uprobe_list an mm field seems simple and effective
idea to me. The only overhead will be list_empty(mm->delayed_list) check.

Please let me know if I misunderstood you.

Thanks,
Ravi

