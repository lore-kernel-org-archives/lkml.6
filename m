Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA7EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69E021873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeLRTkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:40:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:59972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbeLRTkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:40:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D426AD8B;
        Tue, 18 Dec 2018 19:40:06 +0000 (UTC)
Date:   Tue, 18 Dec 2018 11:39:57 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@baidu.com>, zhangyu31@baidu.com,
        liuqi16@baidu.com, yuanlinsi01@baidu.com, nixun@baidu.com,
        lilin24@baidu.com, andrea.parri@amarulasolutions.com
Subject: Re: [PATCH v2] sched/wake_q: Reduce reference counting for special
 users
Message-ID: <20181218193957.cjx34nn5tku2eaps@linux-r8p5>
References: <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
 <20181129221714.GF11632@hirez.programming.kicks-ass.net>
 <CAONzpcZ_kQ0cwit+d5uL=v2SqwP=Fo0WSihdCr23uKCAFAhTbQ@mail.gmail.com>
 <20181217113718.GB4900@worktop.programming.kicks-ass.net>
 <20181217205310.pvwcryyaqlrzmaex@linux-r8p5>
 <20181218131031.GJ15430@hirez.programming.kicks-ass.net>
 <20181218131419.GD16284@hirez.programming.kicks-ass.net>
 <20181218185443.g5jzinm3vnrkznmm@linux-r8p5>
 <a8767197-21b9-f470-b864-be88e020c647@redhat.com>
 <20181218193009.ytzz5rlrsh27rjre@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181218193009.ytzz5rlrsh27rjre@linux-r8p5>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Davidlohr Bueso wrote:
>+void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task)
>+{
>+	if (!__wake_q_add(head, task))
>+		get_task_struct(task);

*sigh* and this should be put().
