Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC871C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9628A20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oVW006xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9628A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeJHPtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:49:35 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:43940 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeJHPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:49:35 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181008083857epoutp02927ee119d1c04c0627bdc8aace4dd365~blWALiiyV0305503055epoutp02Z
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 08:38:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181008083857epoutp02927ee119d1c04c0627bdc8aace4dd365~blWALiiyV0305503055epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538987937;
        bh=pu9W9TkCvWMdCLA2G7OWKG6utgcM5rj1Y090akt8LA8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=oVW006xmpsq53a9OWP1EmgyQSCGbOdmWb8FxDjvqo0rcArgXrJV5nOkH4EkIJT8bJ
         r1mDW/aruUjZyqYvQDd2xzVMbwouDxyv6TLPVXzYl7iD12Rm7INfvPQh0gFF8nYjAI
         51+/z5L3e0mFnfV6M2CF87g6yeiLdjlipRHms8fc=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181008083856epcas1p4197d6452c3a41f3477ea2762e4e94a2c~blV-CEFFZ2912829128epcas1p4d;
        Mon,  8 Oct 2018 08:38:56 +0000 (GMT)
X-AuditID: b6c32a37-3edff70000000fe9-77-5bbb17a0fb98
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.12.04073.0A71BBB5; Mon,  8 Oct 2018 17:38:56 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] mm, oom_adj: avoid meaningless loop to find
 processes sharing mm
Reply-To: ytk.lee@samsung.com
From:   Yong-Taek Lee <ytk.lee@samsung.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yong-Taek Lee <ytk.lee@samsung.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <67eedc4c-7afa-e845-6c88-9716fd820de6@i-love.sakura.ne.jp>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181008083855epcms1p20e691e5a001f3b94b267997c24e91128@epcms1p2>
Date:   Mon, 08 Oct 2018 17:38:55 +0900
X-CMS-MailID: 20181008083855epcms1p20e691e5a001f3b94b267997c24e91128
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTV3eB+O5og8XPOC0u75rDZnFvzX9W
        i9ffljFb3O9zsJjd8o7V4vF6bgc2j51rVzF5bFrVyeax6dMkdo++LasYPdZvucri8XmTXABb
        VI5NRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
        iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCQ4MCveLE3OLSvHS95PxcK0MDAyNToMqE
        nIzjCw6xFjSKVMz5FdHA2MHfxcjJISFgIvH18QemLkYuDiGBHYwS3160sHUxcnDwCghK/N0h
        DFIjLBAt0XfjBDtIWEhAVqK1VwUirC2xffcMNhCbTUBT4vq2q2wgY0QE1jBKdHzsZAZJMAvk
        SUzvesIIsYtXYkb7UxYIW1pi+/KtYHFOAXeJc//vs0LERSVurn7LDmO/PzYfqldEovXeWWYI
        W1Diwc/dUHEpiV3dl8HulxBYxSix/+A6Zging1Hi/tRuJogqfYkr/TPBbF4BX4kpP06CTWIR
        UJX4dPkm2MMSAi4SCycLQxwtL7H97RxmkDAz0Gfrd+lDhPkk3n3tYYX5Zce8J1DTFSWaT/RC
        xcUl7s3rg7rfQ+L98jtg/woJXGaS+HBcdwKj/CxE6M5CsmwWwrIFjMyrGMVSC4pz01OLDQuM
        keNzEyM4DWqZ72DccM7nEKMAB6MSD++KgF3RQqyJZcWVuYcYJTiYlUR4RbcDhXhTEiurUovy
        44tKc1KLDzGaAr08kVlKNDkfmKLzSuINTY2MjY0tTMzMzUyNlcR5n0jNjRYSSE8sSc1OTS1I
        LYLpY+LglGpgdIrhnPl8zYSN+ROu95do2z5f8fu0/0rXD3f/fix5HqfIYOTdMfuGwP3aXZ+e
        zn7/3+vGz4YlRRH73tgdyLsdPK1t29rDu4+UFZd250kJ8vzs+iwR+HKmsp382oMBz366Hes0
        fZDz/4P97g65+PLEy5vnNl7jeTjfTq1Rt+j7wrAniuFsz6yVRZVYijMSDbWYi4oTAYxcZ3iZ
        AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a
References: <67eedc4c-7afa-e845-6c88-9716fd820de6@i-love.sakura.ne.jp>
        <af7ae9c4-d7f1-69af-58fa-ec6949161f5b@I-love.SAKURA.ne.jp>
        <20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p8>
        <20181008061407epcms1p519703ae6373a770160c8f912c7aa9521@epcms1p5>
        <CGME20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On 2018/10/08 15:14, Yong-Taek Lee wrote:
>>> On 2018/10/08 10:19, Yong-Taek Lee wrote:
>>>> @@ -1056,6 +1056,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>>>>         struct mm_struct *mm = NULL;
>>>>         struct task_struct *task;
>>>>         int err = 0;
>>>> +       int mm_users = 0;
>>>>
>>>>         task = get_proc_task(file_inode(file));
>>>>         if (!task)
>>>> @@ -1092,7 +1093,8 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>>>>                 struct task_struct *p = find_lock_task_mm(task);
>>>>
>>>>                 if (p) {
>>>> -                       if (atomic_read(&p->mm->mm_users) > 1) {
>>>> +                       mm_users = atomic_read(&p->mm->mm_users);
>>>> +                       if ((mm_users > 1) && (mm_users != get_nr_threads(p))) {
>>>
>>> How can this work (even before this patch)? When clone(CLONE_VM without CLONE_THREAD/CLONE_SIGHAND)
>>> is requested, copy_process() calls copy_signal() in order to copy sig->oom_score_adj and
>>> sig->oom_score_adj_min before calling copy_mm() in order to increment mm->mm_users, doesn't it?
>>> Then, we will get two different "struct signal_struct" with different oom_score_adj/oom_score_adj_min
>>> but one "struct mm_struct" shared by two thread groups.
>>>
>>
>> Are you talking about race between __set_oom_adj and copy_process?
>> If so, i agree with your opinion. It can not set oom_score_adj properly for copied process if __set_oom_adj
>> check mm_users before copy_process calls copy_mm after copy_signal. Please correct me if i misunderstood anything.
>
> You understand it correctly.
>
> Reversing copy_signal() and copy_mm() is not sufficient either. We need to use a read/write lock
> (read lock for copy_process() and write lock for __set_oom_adj()) in order to make sure that
> the thread created by clone() becomes reachable from for_each_process() path in __set_oom_adj().
>

Thank you for your suggestion. But i think it would be better to seperate to 2 issues. How about think these
issues separately because there are no dependency between race issue and my patch. As i already explained,
for_each_process path is meaningless if there is only one thread group with many threads(mm_users > 1 but 
no other thread group sharing same mm). Do you have any other idea to avoid meaningless loop ? 

>>
>>>>                                 mm = p->mm;
>>>>                                 atomic_inc(&mm->mm_count);
>>>>                         }
>>
>
