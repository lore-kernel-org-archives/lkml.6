Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3423FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 05:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0A021837
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 05:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0A021837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeHMI2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 04:28:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbeHMI2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 04:28:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7D5iB9x076436
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 01:48:08 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ku0v35kfe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 01:48:07 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 13 Aug 2018 06:48:06 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Aug 2018 06:48:01 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7D5m0Td41681044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Aug 2018 05:48:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 925684203F;
        Mon, 13 Aug 2018 08:48:06 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F32742041;
        Mon, 13 Aug 2018 08:48:03 +0100 (BST)
Received: from [9.124.35.193] (unknown [9.124.35.193])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Aug 2018 08:48:03 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     srikar@linux.vnet.ibm.com, Oleg Nesterov <oleg@redhat.com>,
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
Date:   Mon, 13 Aug 2018 11:17:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18081305-0008-0000-0000-00000260E262
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081305-0009-0000-0000-000021C8FC85
Message-Id: <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-13_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808130064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On 08/11/2018 01:27 PM, Song Liu wrote:
>> +
>> +static void delayed_uprobe_delete(struct delayed_uprobe *du)
>> +{
>> +       if (!du)
>> +               return;
> Do we really need this check?


Not necessary though, but I would still like to keep it for a safety.


> 
>> +       list_del(&du->list);
>> +       kfree(du);
>> +}
>> +
>> +static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
>> +{
>> +       struct list_head *pos, *q;
>> +       struct delayed_uprobe *du;
>> +
>> +       if (!uprobe && !mm)
>> +               return;
> And do we really need this check?


Yes. delayed_uprobe_remove(uprobe=NULL, mm=NULL) is an invalid case. If I remove
this check, code below (or more accurately code suggested by Oleg) will remove
all entries from delayed_uprobe_list. So I will keep this check but put a comment
above function.


[...]
>> +
>> +       ret = get_user_pages_remote(NULL, mm, vaddr, 1,
>> +                       FOLL_WRITE, &page, &vma, NULL);
>> +       if (unlikely(ret <= 0)) {
>> +               /*
>> +                * We are asking for 1 page. If get_user_pages_remote() fails,
>> +                * it may return 0, in that case we have to return error.
>> +                */
>> +               ret = (ret == 0) ? -EBUSY : ret;
>> +               pr_warn("Failed to %s ref_ctr. (%d)\n",
>> +                       d > 0 ? "increment" : "decrement", ret);
> This warning is not really useful. Seems this function has little information
> about which uprobe is failing here. Maybe we only need warning in the caller
> (or caller of caller).


Sure, I can move this warning to caller of this function but what are the
exact fields you would like to print with warning? Something like this is
fine?

    pr_warn("ref_ctr %s failed for 0x%lx, 0x%lx, 0x%lx, 0x%p",
		d > 0 ? "increment" : "decrement", inode->i_ino,
		offset, ref_ctr_offset, mm);

More importantly, the reason I didn't print more info is because dmesg is
accessible to unprivileged users in many distros but uprobes are not. So
printing this information may be a security violation. No?


> 
>> +               return ret;
>> +       }
>> +
>> +       kaddr = kmap_atomic(page);
>> +       ptr = kaddr + (vaddr & ~PAGE_MASK);
>> +
>> +       if (unlikely(*ptr + d < 0)) {
>> +               pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
>> +                       "curr val: %d, delta: %d\n", vaddr, *ptr, d);
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       *ptr += d;
>> +       ret = 0;
>> +out:
>> +       kunmap_atomic(kaddr);
>> +       put_page(page);
>> +       return ret;
>> +}
>> +
>> +static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
>> +                         bool is_register)
> What's the reason of bool is_register here vs. short d in __update_ref_ctr()?
> Can we use short for both?


Yes, I can use short as well.


> 
>> +{
>> +       struct vm_area_struct *rc_vma;
>> +       unsigned long rc_vaddr;
>> +       int ret = 0;
>> +
>> +       rc_vma = find_ref_ctr_vma(uprobe, mm);
>> +
>> +       if (rc_vma) {
>> +               rc_vaddr = offset_to_vaddr(rc_vma, uprobe->ref_ctr_offset);
>> +               ret = __update_ref_ctr(mm, rc_vaddr, is_register ? 1 : -1);
>> +
>> +               if (is_register)
>> +                       return ret;
>> +       }
> Mixing __update_ref_ctr() here and delayed_uprobe_add() in the same
> function is a little confusing (at least for me). How about we always use
> delayed uprobe for uprobe_mmap() and use non-delayed in other case(s)?


No. delayed_uprobe_add() is needed for uprobe_register() case to handle race
between uprobe_register() and process creation.


[...]
>>
>> +static int delayed_uprobe_install(struct vm_area_struct *vma)
> This function name is confusing. How about we call it delayed_ref_ctr_incr() or
> something similar? Also, we should add comments to highlight this is vma is not
> the vma containing the uprobe, but the vma containing the ref_ctr.


Sure, I'll do that.


> 
>> +{
>> +       struct list_head *pos, *q;
>> +       struct delayed_uprobe *du;
>> +       unsigned long vaddr;
>> +       int ret = 0, err = 0;
>> +
>> +       mutex_lock(&delayed_uprobe_lock);
>> +       list_for_each_safe(pos, q, &delayed_uprobe_list) {
>> +               du = list_entry(pos, struct delayed_uprobe, list);
>> +
>> +               if (!valid_ref_ctr_vma(du->uprobe, vma))
>> +                       continue;
>> +
>> +               vaddr = offset_to_vaddr(vma, du->uprobe->ref_ctr_offset);
>> +               ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
>> +               /* Record an error and continue. */
>> +               if (ret && !err)
>> +                       err = ret;
> I think this is a good place (when ret != 0) to call pr_warn(). I guess we can
> print which mm get error for which uprobe (inode+offset).


__update_ref_ctr() is already printing warning, so I didn't add anything here.
In case I remove a warning from __update_ref_ctr(), a warning something like
below is fine?

    pr_warn("ref_ctr increment failed for 0x%lx, 0x%lx, 0x%lx, 0x%p",
		inode->i_ino, offset, ref_ctr_offset, vma->vm_mm);

Again, can this lead to a security violation?

Thanks for detailed review :)
-Ravi

