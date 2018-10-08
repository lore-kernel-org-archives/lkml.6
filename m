Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F298C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159012086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JdsCmz4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159012086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeJHNYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:24:15 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:52201 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeJHNYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:24:15 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181008061409epoutp03f097341bbb2390ff7cde6df5db6167a4~bjXk7-sq01809018090epoutp03w
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 06:14:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181008061409epoutp03f097341bbb2390ff7cde6df5db6167a4~bjXk7-sq01809018090epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538979249;
        bh=0S4nDHkx8JPC0zeDzWFw0Npiiaaf8qHi2tRaPcOJtek=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=JdsCmz4HxgA77MufmYYR0i96lvuP5ZQAiLXKkzvRzXdLz0E6kg7cLuIu9zFhrCsv4
         BDn2V90QlRWAtVlK7vCyM0gcgxq8xMG+pn0OcfgUdC1qkwPyBq1wlXrDSjfiMKLYFS
         JzHDH2Rplj22ZglWYd4HJ28qnc2Z4BgSajw8d28c=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181008061408epcas1p3b75c995e21fd4815b8ee1db77d2a50c1~bjXju8lnP1240112401epcas1p3l;
        Mon,  8 Oct 2018 06:14:08 +0000 (GMT)
X-AuditID: b6c32a37-3edff70000000fe9-6d-5bbaf5af923c
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.A3.04073.FA5FABB5; Mon,  8 Oct 2018 15:14:07 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] mm, oom_adj: avoid meaningless loop to find
 processes sharing mm
Reply-To: ytk.lee@samsung.com
From:   Yong-Taek Lee <ytk.lee@samsung.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Yong-Taek Lee <ytk.lee@samsung.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <af7ae9c4-d7f1-69af-58fa-ec6949161f5b@I-love.SAKURA.ne.jp>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181008061407epcms1p519703ae6373a770160c8f912c7aa9521@epcms1p5>
Date:   Mon, 08 Oct 2018 15:14:07 +0900
X-CMS-MailID: 20181008061407epcms1p519703ae6373a770160c8f912c7aa9521
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdljTQHf9113RBm03zSwu75rDZnFvzX9W
        i9ffljFb3O9zsJjd8o7V4vF6bgc2j51rVzF5bFrVyeax6dMkdo++LasYPdZvucri8XmTXABb
        VI5NRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
        iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCQ4MCveLE3OLSvHS95PxcK0MDAyNToMqE
        nIxtk16xFvTyVrSe+c7SwLiFs4uRk0NCwERi1u4DTF2MXBxCAjsYJWbs3szSxcjBwSsgKPF3
        hzBIjbBAtETfjRPsIGEhAVmJ1l4ViLC2xPbdM9hAbDYBTYnr266ygYwREVjDKPFm9xcWkASz
        QJ7E9K4njBC7eCVmtD9lgbClJbYv3woW5xRwl9i6ZB07RFxU4ubqt3D2+2PzoXpFJFrvnWWG
        sAUlHvzcDRWXktjVfRnsfgmBVYwS+w+uY4ZwOhgl7k/tZoKo0pe40j8TzOYV8JW4/2MNWDeL
        gKrE35mXoSa5SGz/9oAR4mp5ie1v5zCDfMwM9Nr6XfoQYT6Jd197WGGe2THvCdR4RYnmE71Q
        cXGJe/P6oB7wkHi//A4LJHAvMUqsPTWbZQKj/CxE+M5Csm0WwrYFjMyrGMVSC4pz01OLDQuM
        kaN0EyM4GWqZ72DccM7nEKMAB6MSD++KgF3RQqyJZcWVuYcYJTiYlUR4RbcDhXhTEiurUovy
        44tKc1KLDzGaAj09kVlKNDkfmKjzSuINTY2MjY0tTMzMzUyNlcR5n0jNjRYSSE8sSc1OTS1I
        LYLpY+LglGpgnKoheqFRwWLavh+N6d55Jxb1XbQ68HbaNRYBBa8dwYdXH9wu/032xJ4yVmXB
        41s+SStXf3gmny/McMv0i+nXLdaxJheltlR5cmcfEWozdP1o2RBke0vg/4+KNF3px6HGH+e/
        /9VTXrLcf5alZPGxiiUfzV98UV7wLUtVQjoqLFtAukHPlSVSiaU4I9FQi7moOBEAIOZZWpwD
        AAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a
References: <af7ae9c4-d7f1-69af-58fa-ec6949161f5b@I-love.SAKURA.ne.jp>
        <20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p8>
        <CGME20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 2018/10/08 10:19, Yong-Taek Lee wrote:
>> @@ -1056,6 +1056,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>>         struct mm_struct *mm = NULL;
>>         struct task_struct *task;
>>         int err = 0;
>> +       int mm_users = 0;
>>
>>         task = get_proc_task(file_inode(file));
>>         if (!task)
>> @@ -1092,7 +1093,8 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>>                 struct task_struct *p = find_lock_task_mm(task);
>>
>>                 if (p) {
>> -                       if (atomic_read(&p->mm->mm_users) > 1) {
>> +                       mm_users = atomic_read(&p->mm->mm_users);
>> +                       if ((mm_users > 1) && (mm_users != get_nr_threads(p))) {
>
> How can this work (even before this patch)? When clone(CLONE_VM without CLONE_THREAD/CLONE_SIGHAND)
> is requested, copy_process() calls copy_signal() in order to copy sig->oom_score_adj and
> sig->oom_score_adj_min before calling copy_mm() in order to increment mm->mm_users, doesn't it?
> Then, we will get two different "struct signal_struct" with different oom_score_adj/oom_score_adj_min
> but one "struct mm_struct" shared by two thread groups.
>

Are you talking about race between __set_oom_adj and copy_process?
If so, i agree with your opinion. It can not set oom_score_adj properly for copied process if __set_oom_adj
check mm_users before copy_process calls copy_mm after copy_signal. Please correct me if i misunderstood anything.

>>                                 mm = p->mm;
>>                                 atomic_inc(&mm->mm_count);
>>                         }
