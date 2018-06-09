Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3tZEAzsPHFvyIQAAmS7hNA
	; Sat, 09 Jun 2018 17:32:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D8DCA608C1; Sat,  9 Jun 2018 17:32:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGi1GA0V"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3D603601D2;
	Sat,  9 Jun 2018 17:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D603601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeFIRcj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 13:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753268AbeFIRci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 13:32:38 -0400
Received: from kernel.org (unknown [24.6.201.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD662087E;
        Sat,  9 Jun 2018 17:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528565557;
        bh=/Qj/QiQ61AN/yB0sJRPCLtgpBsMxMD+FdiVXKhg4pr4=;
        h=Date:From:To:Cc:Subject:From;
        b=MGi1GA0V+x+ykBOHwdrANIrrT+6WhmsOwEngA68DtKd9LZ6A1uEXPxi9vC4JOwz0N
         2JW6QeBKvoZFqeqGbgKdUnHU4Z5bQmCPjjalFckNoGiaSq9iDpXGN5SIW/01TnaGC8
         CHoeexTf8JEZ7rF+mh/xIGIw5JVhsEY4Oy8FmlaQ=
Date: Sat, 9 Jun 2018 10:32:35 -0700
From: Shaohua Li <shli@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [GIT PULL] MD update for 4.18-rc
Message-ID: <20180609173235.GA110796@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
A few fixes of MD for this merge window. Mostly bug fixes:
- raid5 stripe batch fix from Amy
- Read error handling for raid1 FailFast device from Gioh
- raid10 recovery NULL pointer dereference fix from Guoqing
- Support write hint for raid5 stripe cache from Mariusz
- Fixes for device hot add/remove from Neil and Yufen
- Improve flush bio scalability from Xiao

There is a merge conflict, I attached the fix below. Please pull!

Thanks,
Shaohua

The following changes since commit 83beed7b2b26f232d782127792dd0cd4362fdc41:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal (2018-04-20 10:56:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shli/md.git for-next

for you to fetch changes up to 5a409b4f56d50b212334f338cb8465d65550cd85:

  MD: fix lock contention for flush bios (2018-05-21 09:30:26 -0700)

----------------------------------------------------------------
Amy Chiang (1):
      md/raid5: Assigning NULL to sh->batch_head before testing bit R5_Overlap of a stripe

Gioh Kim (1):
      md/raid1: add error handling of read error from FailFast device

Guoqing Jiang (1):
      raid10: check bio in r10buf_pool_free to void NULL pointer dereference

Mariusz Dabrowski (1):
      raid5: copy write hint from origin bio to stripe

NeilBrown (1):
      md: fix two problems with setting the "re-add" device state.

Xiao Ni (1):
      MD: fix lock contention for flush bios

Yufen Yu (2):
      md: fix an error code format and remove unsed bio_sector
      md: fix NULL dereference of mddev->pers in remove_and_add_spares()

 drivers/md/md.c     | 165 +++++++++++++++++++++++++++++++++++-----------------
 drivers/md/md.h     |  22 ++++---
 drivers/md/raid1.c  |   4 +-
 drivers/md/raid10.c |  10 ++--
 drivers/md/raid5.c  |  12 +++-
 drivers/md/raid5.h  |   1 +
 6 files changed, 144 insertions(+), 70 deletions(-)


diff --cc drivers/md/md.c
index 22203eba1e6e,6b4e2f29fe4e..000000000000
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@@ -5489,16 -5518,34 +5510,32 @@@ int md_run(struct mddev *mddev
  		sysfs_notify_dirent_safe(rdev->sysfs_state);
  	}
  
 -	if (mddev->bio_set == NULL) {
 -		mddev->bio_set = bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 -		if (!mddev->bio_set)
 -			return -ENOMEM;
 +	if (!bioset_initialized(&mddev->bio_set)) {
 +		err = bioset_init(&mddev->bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 +		if (err)
 +			return err;
  	}
 -	if (mddev->sync_set == NULL) {
 -		mddev->sync_set = bioset_create(BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 -		if (!mddev->sync_set) {
 -			err = -ENOMEM;
 -			goto abort;
 -		}
 +	if (!bioset_initialized(&mddev->sync_set)) {
 +		err = bioset_init(&mddev->sync_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 +		if (err)
 +			return err;
  	}
+ 	if (mddev->flush_pool == NULL) {
+ 		mddev->flush_pool = mempool_create(NR_FLUSH_INFOS, flush_info_alloc,
+ 						flush_info_free, mddev);
+ 		if (!mddev->flush_pool) {
+ 			err = -ENOMEM;
+ 			goto abort;
+ 		}
+ 	}
+ 	if (mddev->flush_bio_pool == NULL) {
+ 		mddev->flush_bio_pool = mempool_create(NR_FLUSH_BIOS, flush_bio_alloc,
+ 						flush_bio_free, mddev);
+ 		if (!mddev->flush_bio_pool) {
+ 			err = -ENOMEM;
+ 			goto abort;
+ 		}
+ 	}
  
  	spin_lock(&pers_lock);
  	pers = find_pers(mddev->level, mddev->clevel);
@@@ -5654,6 -5703,26 +5693,17 @@@
  	sysfs_notify_dirent_safe(mddev->sysfs_action);
  	sysfs_notify(&mddev->kobj, NULL, "degraded");
  	return 0;
 -
+ abort:
+ 	if (mddev->flush_bio_pool) {
+ 		mempool_destroy(mddev->flush_bio_pool);
+ 		mddev->flush_bio_pool = NULL;
+ 	}
+ 	if (mddev->flush_pool){
+ 		mempool_destroy(mddev->flush_pool);
+ 		mddev->flush_pool = NULL;
+ 	}
 -	if (mddev->bio_set) {
 -		bioset_free(mddev->bio_set);
 -		mddev->bio_set = NULL;
 -	}
 -	if (mddev->sync_set) {
 -		bioset_free(mddev->sync_set);
 -		mddev->sync_set = NULL;
 -	}
+ 
+ 	return err;
  }
  EXPORT_SYMBOL_GPL(md_run);
  
@@@ -5864,8 -5933,22 +5914,16 @@@ void md_stop(struct mddev *mddev
  	 * This is called from dm-raid
  	 */
  	__md_stop(mddev);
+ 	if (mddev->flush_bio_pool) {
+ 		mempool_destroy(mddev->flush_bio_pool);
+ 		mddev->flush_bio_pool = NULL;
+ 	}
+ 	if (mddev->flush_pool) {
+ 		mempool_destroy(mddev->flush_pool);
+ 		mddev->flush_pool = NULL;
+ 	}
 -	if (mddev->bio_set) {
 -		bioset_free(mddev->bio_set);
 -		mddev->bio_set = NULL;
 -	}
 -	if (mddev->sync_set) {
 -		bioset_free(mddev->sync_set);
 -		mddev->sync_set = NULL;
 -	}
 +	bioset_exit(&mddev->bio_set);
 +	bioset_exit(&mddev->sync_set);
  }
  
  EXPORT_SYMBOL_GPL(md_stop);
