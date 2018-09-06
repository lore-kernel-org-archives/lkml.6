Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4999BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3DA2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3T5adKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3DA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbeIGBTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:19:08 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41582 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIGBTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:19:08 -0400
Received: by mail-yb1-f195.google.com with SMTP id u33-v6so4651408ybi.8;
        Thu, 06 Sep 2018 13:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KkHyODO2LSs2B8yvP42X+QdwGHycGvN193FxePG3aQk=;
        b=t3T5adKYRwRFPQMhEvUeP2yfGV374Fe54ZxfTYTpaTMdl7Y7B5aoD1cAf88u1HCSyf
         bSswgjNuTadYjutV8OEkmsXMgy2h5CI5CfEiur56DUWTQJrPdImzrEr/o4K/O7jdlvrS
         M6LIXbhnpQQZPRDq7W4oR4ssWeqhanK016GmxKJ48SwWX1HkCTqNyhpzgZzjeaMCyn0W
         Lo+mh5nNZgq46s3WXsFGc5KGvzBxMMgVYfF2Wx5u6d3d0p0bU4hH98gtv9SvWb4Tep26
         0b9xAxbXCL7FuYo6SvIMuss9m+8PR6B8fyMeHOOsOh/rAYFcIa3HuN1oglz578Bq7FQF
         ieDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KkHyODO2LSs2B8yvP42X+QdwGHycGvN193FxePG3aQk=;
        b=JB0VxpXWlrK5COClYncf5MD6gf4uun7Iv5rnKa7ghEDUhgcScNHJatU+ojRRk2dUuy
         4N/+al+1ZwR7S2mdI0JkZB4eq3PNohEey1C0MYZ7v0Nej9zJ8MfalOhhvJKxmiKgsepx
         3ONTTEub7GZZYy431+hLgCnrqw/k/lMDvgWooPgrksy+ZrmzeuckV/tgRzSrSUx33XrN
         VMFW1UyhKgrWW7dPfqbl4il9IvcAbiLvR63rrykEfQbfzqKSueWsFBOLafASLbuApNys
         H8Hh6hgCReBxHLly93+oiY7/wcYSRsZoiDIxcK2dwr2hZl3gBeyX73ipVQbkYXLafITK
         XBmw==
X-Gm-Message-State: APzg51B6jrCR2y/8wXrTkakbHgybRL9FqLxWaqqTA5NNC0rLv7haJqD6
        0EsLlPTFkbzIgvCOszLobsM=
X-Google-Smtp-Source: ANB0VdbDmpe4w0Jigbx7umkXh3cvRbeJM8skKz9WjVZ+489jTgrpnwgQaflXSIZPixwl1yedIv/PCg==
X-Received: by 2002:a25:9111:: with SMTP id v17-v6mr2567147ybl.120.1536266516666;
        Thu, 06 Sep 2018 13:41:56 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::3:20a])
        by smtp.gmail.com with ESMTPSA id u124-v6sm2092273ywd.37.2018.09.06.13.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 13:41:56 -0700 (PDT)
Date:   Thu, 6 Sep 2018 16:41:54 -0400
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] blkcg: always associate a bio with a blkg
Message-ID: <20180906204153.GA26048@dennisz-mbp.dhcp.thefacebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-7-dennisszhou@gmail.com>
 <20180831231609.GD1488037@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831231609.GD1488037@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 04:16:09PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Thu, Aug 30, 2018 at 09:53:47PM -0400, Dennis Zhou wrote:
> > From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> > 
> > Previously, blkg's were only assigned as needed by blk-iolatency and
> > blk-throttle. bio->css was also always being associated while blkg was
> > being looked up and then thrown away in blkcg_bio_issue_check.
> > 
> > This patch beings the cleanup of bio->css and bio->bi_blkg by always
>              ^
> 	     begins
> 

Thanks!

> > +int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
> > +{
> > +	struct blkcg *blkcg;
> > +	struct blkcg_gq *blkg;
> > +	int ret = 0;
> > +
> > +	/* someone has already associated this bio with a blkg */
> > +	if (bio->bi_blkg)
> > +		return ret;
> > +
> > +	rcu_read_lock();
> > +
> > +	bio_associate_blkcg(bio, NULL);
> > +	blkcg = bio_blkcg(bio);
> > +
> > +	if (!blkcg->css.parent) {
> > +		ret = bio_associate_blkg(bio, q->root_blkg);
> > +		goto assoc_out;
> > +	}
> > +
> > +	blkg = blkg_lookup_create(blkcg, q);
> > +	if (IS_ERR(blkg))
> > +		blkg = q->root_blkg;
> > +
> > +	ret = bio_associate_blkg(bio, blkg);
> > +assoc_out:
> 
> Maybe if/else instead of goto?
> 

Yeah, no need for goto.

Thanks,
Dennis
