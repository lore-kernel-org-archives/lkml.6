Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A956DECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E4D208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E4D208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbeGQBZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:25:28 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:25287 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbeGQBZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:25:28 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6H0tHDu075677;
        Tue, 17 Jul 2018 09:55:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Tue, 17 Jul 2018 09:55:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6H0tHIS075671;
        Tue, 17 Jul 2018 09:55:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w6H0tHn5075670;
        Tue, 17 Jul 2018 09:55:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201807170055.w6H0tHn5075670@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH v13 0/7] cgroup-aware OOM killer
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Date:   Tue, 17 Jul 2018 09:55:17 +0900
References: <0d018c7e-a3de-a23a-3996-bed8b28b1e4a@i-love.sakura.ne.jp> <20180716220918.GA3898@castle.DHCP.thefacebook.com>
In-Reply-To: <20180716220918.GA3898@castle.DHCP.thefacebook.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Gushchin wrote:
> On Tue, Jul 17, 2018 at 06:13:47AM +0900, Tetsuo Handa wrote:
> > No response from Roman and David...
> > 
> > Andrew, will you once drop Roman's cgroup-aware OOM killer and David's patches?
> > Roman's series has a bug which I mentioned and which can be avoided by my patch.
> > David's patch is using MMF_UNSTABLE incorrectly such that it might start selecting
> > next OOM victim without trying to reclaim any memory.
> > 
> > Since they are not responding to my mail, I suggest once dropping from linux-next.
> 
> I was in cc, and didn't thought that you're expecting something from me.

Oops. I was waiting for your response. ;-)

  But Roman, my patch conflicts with your "mm, oom: cgroup-aware OOM killer" patch
  in linux-next. And it seems to me that your patch contains a bug which leads to
  premature memory allocation failure explained below.

  Can we apply my patch prior to your "mm, oom: cgroup-aware OOM killer" patch
  (which eliminates "delay" and "out:" from your patch) so that people can easily
  backport my patch? Or, do you want to apply a fix (which eliminates "delay" and
  "out:" from linux-next) prior to my patch?

> 
> I don't get, why it's necessary to drop the cgroup oom killer to merge your fix?
> I'm happy to help with rebasing and everything else.

Yes, I wish you rebase your series on top of OOM lockup (CVE-2016-10723) mitigation
patch ( https://marc.info/?l=linux-mm&m=153112243424285&w=4 ). It is a trivial change
and easy to cleanly backport (if applied before your series).

Also, I expect you to check whether my cleanup patch which removes "abort" path
( [PATCH 1/2] at https://marc.info/?l=linux-mm&m=153119509215026&w=4 ) helps
simplifying your series. I don't know detailed behavior of your series, but I
assume that your series do not kill threads which current thread should not wait
for MMF_OOM_SKIP.
