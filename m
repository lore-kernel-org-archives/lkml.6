Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3720C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A609321756
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A609321756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbeHMPn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:43:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728455AbeHMPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:43:28 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7DD0QfV087959
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 09:01:16 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ku9623m3n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 09:01:15 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 13 Aug 2018 14:01:12 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Aug 2018 14:01:07 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7DD16Kg46137524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Aug 2018 13:01:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBE69A4065;
        Mon, 13 Aug 2018 16:01:10 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53B24A4055;
        Mon, 13 Aug 2018 16:01:06 +0100 (BST)
Received: from [9.79.223.161] (unknown [9.79.223.161])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Aug 2018 16:01:06 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Song Liu <liu.song.a23@gmail.com>, srikar@linux.vnet.ibm.com,
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
Date:   Mon, 13 Aug 2018 18:31:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180813115019.GB28360@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18081313-0028-0000-0000-000002EA1227
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081313-0029-0000-0000-000023A32D9D
Message-Id: <fa85d19f-b22c-e09c-b8d2-f68f0c79de15@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808130142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 08/13/2018 05:20 PM, Oleg Nesterov wrote:
> On 08/13, Ravi Bangoria wrote:
>>
>> On 08/11/2018 01:27 PM, Song Liu wrote:
>>>> +
>>>> +static void delayed_uprobe_delete(struct delayed_uprobe *du)
>>>> +{
>>>> +       if (!du)
>>>> +               return;
>>> Do we really need this check?
>>
>> Not necessary though, but I would still like to keep it for a safety.
> 
> Heh. I tried to ignore all minor problems in this version, but now that Song
> mentioned this unnecessary check...
> 
> Personally I really dislike the checks like this one.
> 
> 	- It can confuse the reader who will try to understand the purpose
> 
> 	- it can hide a bug if delayed_uprobe_delete(du) is actually called
> 	  with du == NULL.
> 
> IMO, you should either remove it and let the kernel crash (to notice the
> problem), or turn it into
> 
> 	if (WARN_ON(!du))
> 		return;
> 
> which is self-documented and reports the problem without kernel crash.

Ok. I'll remove that check.

> 
>>>> +       rc_vma = find_ref_ctr_vma(uprobe, mm);
>>>> +
>>>> +       if (rc_vma) {
>>>> +               rc_vaddr = offset_to_vaddr(rc_vma, uprobe->ref_ctr_offset);
>>>> +               ret = __update_ref_ctr(mm, rc_vaddr, is_register ? 1 : -1);
>>>> +
>>>> +               if (is_register)
>>>> +                       return ret;
>>>> +       }
>>> Mixing __update_ref_ctr() here and delayed_uprobe_add() in the same
>>> function is a little confusing (at least for me). How about we always use
>>> delayed uprobe for uprobe_mmap() and use non-delayed in other case(s)?
>>
>>
>> No. delayed_uprobe_add() is needed for uprobe_register() case to handle race
>> between uprobe_register() and process creation.
> 
> Yes.
> 
> But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
> hook and avoid delayed_uprobe_install() in uprobe_mmap().

I'm sorry. I didn't get this.

> 
> Afaics, the really problematic case is dlopen() which can race with _register()
> too, right?

dlopen() should internally use mmap() right? So what is the problem here? Can
you please elaborate.

Thanks,
Ravi

