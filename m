Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB35C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B5E2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B5E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeIYOGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:06:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:45342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbeIYOGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:06:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 959D7AE26;
        Tue, 25 Sep 2018 07:59:39 +0000 (UTC)
Date:   Tue, 25 Sep 2018 09:59:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     lkp@01.org, 0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [mm, oom] 6209f6fc62: general_protection_fault:#[##]
Message-ID: <20180925075939.GP18685@dhcp22.suse.cz>
References: <20180925054820.GC27173@shao2-debian>
 <20180925060653.GN18685@dhcp22.suse.cz>
 <084cf8cd-f384-8694-16c0-d1e2abfb9099@intel.com>
 <20180925073145.GO18685@dhcp22.suse.cz>
 <917270d5-8755-b0d6-60c4-871f8c7ff982@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <917270d5-8755-b0d6-60c4-871f8c7ff982@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-09-18 15:43:22, Rong Chen wrote:
> 
> 
> On 09/25/2018 03:31 PM, Michal Hocko wrote:
> > On Tue 25-09-18 15:00:15, Rong Chen wrote:
> > > 
> > > On 09/25/2018 02:06 PM, Michal Hocko wrote:
> > > > On Tue 25-09-18 13:48:20, kernel test robot wrote:
> > > > > FYI, we noticed the following commit (built with gcc-7):
> > > > > 
> > > > > commit: 6209f6fc62835d84c2a92d237588a114e39436ce ("mm, oom: rework mmap_exit vs. oom_reaper synchronization")
> > > > > https://github.com/0day-ci/linux UPDATE-20180911-024633/Tetsuo-Handa/mm-oom-Fix-unnecessary-killing-of-additional-processes/20180910-163452
> > > > Do you have a msg-id to the patch that has been tested?
> > > message_id: 20180910125513.311-2-mhocko@kernel.org
> > Thanks! It woudl be really great if this was a part of the report when
> > testing patches which are not mainline yet.
> > 
> > This patch resulting in a crash is quite surprising. The patch is RFC
> > and not tested yet but I will definitely have a look. Could you help me
> > some more and give faddr2line __oom_reap_task_mm+0x40 please?
> $ faddr2line ./vmlinux __oom_reap_task_mm+0x40
> __oom_reap_task_mm+0x40/0x175:
> can_madv_dontneed_vma at mm/internal.h:48
>  (inlined by) __oom_reap_task_mm at mm/oom_kill.c:505

OK, this suggests the vma is gone. The problem is that I have removed
MMF_OOM_SKIP from the exit path and mm->mmap still points to the freed
memory. Later patch in the series does the later so the resulting code
is safe but not bisect safe. I will return MMF_OOM_SKIP setting to the
exit_mmap path and that should cure the issue.

diff --git a/mm/mmap.c b/mm/mmap.c
index 3481424717ac..a02b314c0546 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3083,8 +3083,10 @@ void exit_mmap(struct mm_struct *mm)
 	unmap_vmas(&tlb, vma, 0, -1);
 
 	/* oom_reaper cannot race with the page tables teardown */
-	if (oom)
+	if (oom) {
 		down_write(&mm->mmap_sem);
+		set_bit(MMF_OOM_SKIP, &mm->flags);
+	}
 
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb, 0, -1);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa5360616..b7137ca9c7a2 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -554,7 +554,7 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
 	 * MMF_OOM_SKIP is set by exit_mmap when the OOM reaper can't
 	 * work on the mm anymore. The check for MMF_OOM_SKIP must run
 	 * under mmap_sem for reading because it serializes against the
-	 * down_write();up_write() cycle in exit_mmap().
+	 * down_write() in exit_mmap().
 	 */
 	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
 		trace_skip_task_reaping(tsk->pid);
-- 
Michal Hocko
SUSE Labs
