Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F955C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C332154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C332154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeHTR3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:29:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57022 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHTR3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:29:10 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w7KECINr043698;
        Mon, 20 Aug 2018 23:12:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Mon, 20 Aug 2018 23:12:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w7KECDuO043686
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 20 Aug 2018 23:12:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in generic_file_write_iter
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        Michal Hocko <mhocko@kernel.org>, ak@linux.intel.com,
        jlayton@redhat.com, linux-kernel@vger.kernel.org,
        mawilcox@microsoft.com, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0000000000009ce88d05714242a8@google.com>
 <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
 <9b9fcdda-c347-53ee-fdbb-8a7d11cf430e@I-love.SAKURA.ne.jp>
 <20180720130602.f3d6dc4c943558875a36cb52@linux-foundation.org>
 <a2df1f24-f649-f5d8-0b2d-66d45b6cb61f@i-love.sakura.ne.jp>
 <20180806100928.x7anab3c3y5q4ssa@quack2.suse.cz>
 <8248f4e9-3567-b8f5-4751-8b38c1807eff@i-love.sakura.ne.jp>
Message-ID: <e51a7822-3fdc-3f7a-25bd-5d8d8df44749@i-love.sakura.ne.jp>
Date:   Mon, 20 Aug 2018 23:12:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8248f4e9-3567-b8f5-4751-8b38c1807eff@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/06 20:56, Tetsuo Handa wrote:
> On 2018/08/06 19:09, Jan Kara wrote:
>> Looks like some kind of a race where device block size gets changed while
>> getblk() runs (and creates buffers for underlying page). I don't have time
>> to nail it down at this moment can have a look into it later unless someone
>> beats me to it.
>>
> 
> It seems that loop device is relevant to this problem.

Speak of loop device, I'm waiting for Jens for three months
http://lkml.kernel.org/r/1527297408-4428-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
but Jens is too busy to come up with an alternative. Since that is a big patch, I wish we can
start testing that patch before Jan starts writing a patch for fixing getblk() race problem.

