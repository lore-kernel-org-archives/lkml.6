Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B1C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1A920658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DoPdcX++";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DnG0Ncug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1A920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeIBOth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:49:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60992 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeIBOth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:49:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 83DBF60242; Sun,  2 Sep 2018 10:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535884457;
        bh=Cf3WF48+aAlsZdVhfDphBMGwSwegn6kox31GV7aJl4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DoPdcX++bGqyALGZkXR3MYXGLCMQiVHMjd/mlv2qKR1j5i2Y/RUn1yiR7PWUCRaoV
         SiSlEIPg9SQkg+Quhr0bz6UpL2DO1KCu9ZMY7rJzok3Dn67EemOzZ9XoDBnQOWA672
         W39U9o0Tmd4bM/rbEMGMZKnqe7cV3qj8dfnkiENs=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F315360242;
        Sun,  2 Sep 2018 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535884456;
        bh=Cf3WF48+aAlsZdVhfDphBMGwSwegn6kox31GV7aJl4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnG0NcugP32BT2ewu7ufOz9U54zX97VqkPMlK3Dk5T/zhvrlN+rIUFmpBsGYZtLZC
         ZXJxliS+ZFUawZWLoE/ZPeLLswoIW9IxHSwmRw1FR6m+48VxzYWfQOj0ePm4EAh5e/
         JqM65Fa1msdMEN4OALJ6AEnOKGGvP0g2jCFtTb04=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F315360242
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Sun, 2 Sep 2018 16:04:11 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix unnecessary periodic wakeup of
 discard thread when dev is busy
Message-ID: <20180902103411.GE12489@codeaurora.org>
References: <1535708366-11318-1-git-send-email-stummala@codeaurora.org>
 <ae0ec622-1fd3-d28a-019b-75a507e551f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae0ec622-1fd3-d28a-019b-75a507e551f6@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 04:52:40PM +0800, Chao Yu wrote:
> On 2018/8/31 17:39, Sahitya Tummala wrote:
> > When dev is busy, discard thread wake up timeout can be aligned with the
> > exact time that it needs to wait for dev to come out of busy. This helps
> > to avoid unnecessary periodic wakeups and thus save some power.
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> >  fs/f2fs/segment.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 8bcbb50..df14030 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1379,6 +1379,8 @@ static int issue_discard_thread(void *data)
> >  	struct discard_policy dpolicy;
> >  	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
> >  	int issued;
> > +	unsigned long interval = sbi->interval_time[REQ_TIME] * HZ;
> > +	long delta;
> >  
> >  	set_freezable();
> >  
> > @@ -1410,7 +1412,11 @@ static int issue_discard_thread(void *data)
> >  			__wait_all_discard_cmd(sbi, &dpolicy);
> >  			wait_ms = dpolicy.min_interval;
> >  		} else if (issued == -1){
> > -			wait_ms = dpolicy.mid_interval;
> > +			delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;
> 
> I agree that we need to consider power consumption. One more consideration is
> that discard thread may need different submission frequency comparing to garbage
> collection thread, maybe a little fast, would it be better to split
> sbi->interval_time[REQ_TIME] according to gc/discard type.
> 
> How do you think?
> 
> Thanks,
> 

Thanks for the review.

You mean when GC type is urgent? I see that for that case, the discard policy is
changed to DPOLICY_FORCE, which sets dpolicy->io_aware as false and hence,
cannot fall into this (issued == -1) case at all.

> > +			if (delta > 0)
> > +				wait_ms = jiffies_to_msecs(delta);
> > +			else
> > +				wait_ms = dpolicy.mid_interval;
> >  		} else {
> >  			wait_ms = dpolicy.max_interval;
> >  		}
> > 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
