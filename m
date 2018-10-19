Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2850ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC2420843
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC2420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeJTG3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 02:29:02 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:47102 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJTG3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 02:29:02 -0400
Received: by mail-yw1-f67.google.com with SMTP id j202-v6so13762090ywa.13;
        Fri, 19 Oct 2018 15:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DNViDtx2bCu3o/RtjRC4+649fRKwTO3vSVqtsn1LuNk=;
        b=ix6Pptiqql6pD7lm2mod9Nn/ucq/ZxQCxC3bbhVEjLvGI2zvdVpMkA7jYB4ZChyB4n
         L4X8xtEzCt0r0/1/4Xhixb3i/lfBWjBp4hd2eYAZhd/XIlDyD5ajMsx0iEoAZNd7jOmW
         /iJ4z77rem41rOOfNQn6PAvop4PT7FWUaz5wPoiKPwyEjiBDupJ/2UlATLXcOG9cVHQR
         75OxxL7CyeLmm4CU4UCNLcNgCpPhrVOOT0j2+Wu6F4dS/wedbCNO0a8RzqplpO6SCzzc
         XPqtndceLeXlBy1H06i3LVjZiWx72VdOkA5ZsPV0CTpAF0YpC8wMPyf7oylA6eD8bTmA
         lBcA==
X-Gm-Message-State: ABuFfohpKI/p7pnkOcI43+Zp0M8xlhnvMxdEOdKEQUcp5OWJK4ymqBIt
        hEw2h9XDPPFdfInxayUdARvgtqXO
X-Google-Smtp-Source: ACcGV60jOdi5salOBvjniwNCPHqFbGgncAtfYksfaXxrBGtjfQb4aPgn2PM811CwTglRD04frDPNRg==
X-Received: by 2002:a81:2e81:: with SMTP id u123-v6mr4602660ywu.424.1539987663965;
        Fri, 19 Oct 2018 15:21:03 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::4:a7a6])
        by smtp.gmail.com with ESMTPSA id h37-v6sm5911591ywk.98.2018.10.19.15.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 15:21:02 -0700 (PDT)
Date:   Fri, 19 Oct 2018 18:21:00 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     valdis.kletnieks@vt.edu
Cc:     Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
Message-ID: <20181019222100.GA20900@dennisz-mbp.dhcp.thefacebook.com>
References: <13987.1539646128@turing-police.cc.vt.edu>
 <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com>
 <20181016182513.GA9886@dennisz-mbp.dhcp.thefacebook.com>
 <13448.1539791255@turing-police.cc.vt.edu>
 <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com>
 <14614.1539964356@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14614.1539964356@turing-police.cc.vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 11:52:36AM -0400, valdis.kletnieks@vt.edu wrote:
> On Wed, 17 Oct 2018 17:20:29 -0400, Dennis Zhou said:
> >
> > I apologize, but I'm having a hard time reproducing this myself. I am
> > not able to hit this issue in my qemu instance with linux-next built
> > with your config. I have been running 'rpm -Hvh --force fio.rpm' several
> > times and haven't seen the issue.
> 
> I wouldn't be surprised if there's something oddball in my system config
> that changes the situation.
> 

Do you by chance run any encryption or anything on top of your hard
drive or ssd?

> > Would it be possible for you to create a minimal qemu image that
> > reproduces the issue as I'm having issues reproducing it with my setup?
> 
> Hmm.. I'd first have to figure out how to build a qemu image at all..
> 
> > Additionally, I've added some more debug text in the diff below. If you
> > could apply that and send me the full dmesg that would be great. Lastly,
> > can you just confirm for me that the commit before, f0fcb3ec89f3
> > "blkcg: remove additional reference to the css", isn't seeing this
> > issue?
> 
> Full dmesg attached.  Had to piece it together from a 'dmesg' and what
> got saved in pstore when it crashed.  I was surprised that the printk_once
> popped during very early boot (2.88 seconds in), and then only 2 lines of output
> right before the crash:
> 
> [  106.465848] audit: type=1130 audit(1539957798.984:101): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:syst
> em_r:init_t:s0-s15:c0.c1023 msg='unit=run-r93ac4731e4724fd6a3670e7d0c417522 comm="systemd" exe="/usr/lib/systemd/systemd
> " hostname=? addr=? terminal=? res=success'
> [  106.564711] dennis: q ffff9e3c57152000 != rl->q ffff9e3a8fe48040
> [  106.564713] dennis: bio: ffff9e3a8fcf5400, root: ffffffffbbdd89e0
> [  106.564761] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [  106.568786] PGD 0 P4D 0
> [  106.570761] Oops: 0000 [#1] PREEMPT SMP PTI
> [  106.573115] CPU: 2 PID: 1205 Comm: sh Tainted: G                T 4.19.0-rc8-next-20181016-dirty #639
> 
> I'll cook up a kernel checked out at that commit and test later today...

I thought of another issue that may explain what's going on. It has to
do with how a bio can go through make_request() several times. However,
I do association on the first entry, but subsequent requests may go to
separate queues. Therefore association and the blk_get_rl() returns the
wrong request_list. It may be that a particular blkg doesn't have a
fully initialized request_list.

I've currently only been testing on a drive directly, but my try with md
still worked.. So I am still trying other ways to reproduce it.

Thanks for being patient with me. Would you be able to try the following
on Jens' for-4.20/block branch? His tree is available here:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git

Thanks,
Dennis

---
 block/bio.c         | 20 ++++++++++++++++++++
 block/blk-core.c    |  1 +
 include/linux/bio.h |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 17a8b0aa7050..bbfeb4ee2892 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2083,6 +2083,26 @@ int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
 	return ret;
 }
 
+/**
+ * bio_reassociate_blkg - reassociate a bio with a blkg from q
+ * @q: request_queue where bio is going
+ * @bio: target bio
+ *
+ * When submitting a bio, multiple recursive calls to make_request() may occur.
+ * This causes the initial associate done in blkcg_bio_issue_check() to be
+ * incorrect and reference the prior request_queue.  This performs reassociation
+ * when this situation happens.
+ */
+int bio_reassociate_blkg(struct request_queue *q, struct bio *bio)
+{
+	if (bio->bi_blkg) {
+		blkg_put(bio->bi_blkg);
+		bio->bi_blkg = NULL;
+	}
+
+	return bio_associate_create_blkg(q, bio);
+}
+
 /**
  * bio_disassociate_task - undo bio_associate_current()
  * @bio: target bio
diff --git a/block/blk-core.c b/block/blk-core.c
index cdfabc5646da..3ed60723e242 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2433,6 +2433,7 @@ blk_qc_t generic_make_request(struct bio *bio)
 			if (q)
 				blk_queue_exit(q);
 			q = bio->bi_disk->queue;
+			bio_reassociate_blkg(q, bio);
 			flags = 0;
 			if (bio->bi_opf & REQ_NOWAIT)
 				flags = BLK_MQ_REQ_NOWAIT;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f447b0ebb288..b47c7f716731 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -514,6 +514,7 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
 int bio_associate_blkg_from_css(struct bio *bio,
 				struct cgroup_subsys_state *css);
 int bio_associate_create_blkg(struct request_queue *q, struct bio *bio);
+int bio_reassociate_blkg(struct request_queue *q, struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
@@ -522,6 +523,8 @@ static inline int bio_associate_blkg_from_css(struct bio *bio,
 { return 0; }
 static inline int bio_associate_create_blkg(struct request_queue *q,
 					    struct bio *bio) { return 0; }
+static inline int bio_reassociate_blkg(struct request_queue *q, struct bio *bio)
+{ return 0; }
 static inline void bio_disassociate_task(struct bio *bio) { }
 static inline void bio_clone_blkg_association(struct bio *dst,
 					      struct bio *src) { }
-- 
2.17.1
