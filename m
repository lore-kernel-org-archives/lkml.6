Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbeAaCgK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeAaCgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:36:09 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788B821780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Tue, 30 Jan 2018 18:36:07 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH] f2fs: add sanity check for quota sysfile ino
Message-ID: <20180131023607.GA87929@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180129082933.64556-1-yuchao0@huawei.com>
 <20180131013556.GE65489@jaegeuk-macbookpro.roam.corp.google.com>
 <f27cbf43-eb34-5e21-8016-c1a17203cf0b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f27cbf43-eb34-5e21-8016-c1a17203cf0b@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31, Chao Yu wrote:
> On 2018/1/31 9:35, Jaegeuk Kim wrote:
> > On 01/29, Chao Yu wrote:
> >> Add missing sanity check for quota sysfile ino.
> > 
> > We don't need to limit the specific inode numbers for quota files, since
> > we may be able to set any inode numbers later. How about checkint the
> > numbers are allocated as quota?

If quota_ino is set, f2fs_enable_quotas() will be failed, if its ino is invalid.
It'd be also fine, if we have no inode numbers there. What I mean was we may need
to consider reallocating or deallocating inode numbers later.

> 
> Do you mean:
> 
> 	if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
> 		if (!le32_to_cpu(raw_super->qf_ino[0]) ||
> 			!le32_to_cpu(raw_super->qf_ino[1])) {
> 			f2fs_msg(sb, KERN_INFO,
> 				"Invalid Quota Ino: user_ino(%u), grp_ino(%u)",
> 				le32_to_cpu(raw_super->qf_ino[0]),
> 				le32_to_cpu(raw_super->qf_ino[1]));
> 			return 1;
> 		}
> 		if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA) &&
> 			!le32_to_cpu(raw_super->qf_ino[2])) {
> 			f2fs_msg(sb, KERN_INFO,
> 				"Invalid Quota Ino: prj_ino(%u)",
> 				le32_to_cpu(raw_super->qf_ino[2]));
> 			return 1;
> 		}
> 	}
> 
> I think it's equal to:
> 
> 	if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
> 		unsigned int qf_cnt = 0;
> 		if (qf_ino[0])
> 			qf_cnt++;
> 		if (qf_ino[1])
> 			qf_cnt++;
> 		if (qf_cnt != 2) {
> 			f2fs_msg();
> 			return 1;
> 		}
> 		if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA)) {
> 			if (qf_ino[2])
> 				qf_cnt++;
> 			if (qf_cnt != 3) {
> 				f2fs_msg();
> 				return 1;
> 			}
> 		}
> 	}
> 
> Thanks,
> 
> > 
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/super.c | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index 368f63d7bad2..6011071688ca 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -2116,6 +2116,25 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
> >>  		return 1;
> >>  	}
> >>  
> >> +	/* check quota sysfile ino info */
> >> +	if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
> >> +		if (le32_to_cpu(raw_super->qf_ino[0]) != 4 ||
> >> +			le32_to_cpu(raw_super->qf_ino[1]) != 5) {
> >> +			f2fs_msg(sb, KERN_INFO,
> >> +				"Invalid Quota Ino: user_ino(%u), grp_ino(%u)",
> >> +				le32_to_cpu(raw_super->qf_ino[0]),
> >> +				le32_to_cpu(raw_super->qf_ino[1]));
> >> +			return 1;
> >> +		}
> >> +		if (raw_super->feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA) &&
> >> +			le32_to_cpu(raw_super->qf_ino[2]) != 6) {
> >> +			f2fs_msg(sb, KERN_INFO,
> >> +				"Invalid Quota Ino: prj_ino(%u)",
> >> +				le32_to_cpu(raw_super->qf_ino[2]));
> >> +			return 1;
> >> +		}
> >> +	}
> >> +
> >>  	if (le32_to_cpu(raw_super->segment_count) > F2FS_MAX_SEGMENT) {
> >>  		f2fs_msg(sb, KERN_INFO,
> >>  			"Invalid segment count (%u)",
> >> -- 
> >> 2.15.0.55.gc2ece9dc4de6
> > 
> > .
> > 
