Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A90C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8C4218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbfABQuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:50:09 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:54967 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbfABQuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:50:08 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x02GntWg019619;
        Thu, 3 Jan 2019 01:49:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Thu, 03 Jan 2019 01:49:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x02Gntpn019616
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 3 Jan 2019 01:49:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: WARNING: lock held when returning to user space in grab_super
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan@huawei.com>,
        syzbot <syzbot+87b93137e0280beaeba1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <000000000000638c1b057e787822@google.com>
 <a6e8d929-3765-ad70-0f7c-942b68d7b25c@I-love.SAKURA.ne.jp>
 <20190102161640.GS2509588@devbig004.ftw2.facebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <19260f8b-d831-9a9a-5315-1f4353dadc9b@i-love.sakura.ne.jp>
Date:   Thu, 3 Jan 2019 01:49:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190102161640.GS2509588@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/03 1:16, Tejun Heo wrote:
> Happy new year, Tetsuo.
> 
> On Wed, Jan 02, 2019 at 09:08:56PM +0900, Tetsuo Handa wrote:
>> According to commit 633feee310de6b6c ("cgroup: refactor mount path and
>> clearly distinguish v1 and v2 paths"), cgroup_do_mount() is failing to
>> do full teardown steps for kernfs_mount() (deactivate_locked_super() ?)
>> when kernfs_node_dentry() failed.
> 
> Hmm... that's basically dget()'ing the root dentry of the sb.  I'm not
> sure how that could fail.  Can it?

kernfs_node_dentry() calls lookup_one_len_unlocked() which involves
memory allocation, and memory allocation fault injection made
lookup_one_len_unlocked() fail, and thus kernfs_node_dentry() failed.
What's strange?
