Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E31C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A319920820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC12PoTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A319920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392126AbeKVPto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:49:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46191 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeKVPto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:49:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so1293896pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 21:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lhNxwjAFiFYjtJJTQTynkRd9DVYlsuXzgovEtiOy6s4=;
        b=ZC12PoTsEdGVGDX0hbMKimpNigstPYcWmuM0KlUpCSVmK7D6Zvufr8cV8IvQTEP3Um
         YBla/3XTXF9lWbPx9XyN2V0v7bQPwO6LOu5T5ZcnHzqkW3g5yyU5pW6Db0rI0UFvh0Y9
         g8jrnOrCvN9IGqSazn1bn0cdzS9uBY2Ugf6FLZRyW/LrTioS2TCG2C0ri0nfEZsaKFgt
         z0B8TZ6yVplklYIe60dmrat7pTas8XWju61LnfcR0qCxE4S1nc6KWxgCb4WzBuiTtUKx
         i7hAH/ol5e9ti2nv8Neb28SHspb5fmRspglE52QX/VMrK+F7Vg2ZFLKWHQzOvoGsMU2K
         iyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lhNxwjAFiFYjtJJTQTynkRd9DVYlsuXzgovEtiOy6s4=;
        b=P8Oeg4h4z4xxpaWAeKfscgL654bCpoH6G2UwUhJat7IU/AezKk30bBq5rdx6ZoMIlp
         8BS4grXCH5bhH7bb5Sn5xSKRKM4ZngLZwJxeRwGNFTRcs3wOGQFMAAd4GciChi7d24Pi
         MOcQgXnopeu+qe4ysZF+HogZ4kpgD9yUHpvZLzjS26ZKDOj+hRvyFvVMowtCNThuUpG8
         b/ZdI6Gai13kI/Kp4bvJXjCJVUjV5nfvOWzPd1YWVjiZqmR8UAixCIgLlppJdmqO35RL
         FycZRuNfxOcPssMivHvfzJeLL+93n6zLxNY1EgrY/BYRQb8qDdQAMlNvgnZ9PrCRvpow
         EIDg==
X-Gm-Message-State: AA+aEWbhxVc6woz4MiMpVj5Ly/uLgfyvuLxOc8tk8q2w3xzYwHTjDx57
        4l2n9EewhFU7DxAmxhXNtWE=
X-Google-Smtp-Source: AFSGD/Vm/zMq8tEtEG7c6BuMuM1ojTRwqdl6+SjDTWBdQvlirmgndofiipl4fzRQBV8/wbzSUhGwpA==
X-Received: by 2002:a63:61c8:: with SMTP id v191mr8810977pgb.242.1542863521864;
        Wed, 21 Nov 2018 21:12:01 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id x7sm50311981pga.68.2018.11.21.21.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 21:12:00 -0800 (PST)
Date:   Thu, 22 Nov 2018 14:11:56 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] zram: introduce ZRAM_IDLE flag
Message-ID: <20181122051156.GB182024@google.com>
References: <20181116072035.155108-1-minchan@kernel.org>
 <20181116072035.155108-4-minchan@kernel.org>
 <20181120024659.GC4231@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120024659.GC4231@jagdpanzerIV>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:46:59AM +0900, Sergey Senozhatsky wrote:
> Hello,
> 
> On (11/16/18 16:20), Minchan Kim wrote:
> [..]
> > +static ssize_t idle_store(struct device *dev,
> > +		struct device_attribute *attr, const char *buf, size_t len)
> > +{
> > +	struct zram *zram = dev_to_zram(dev);
> > +	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
> > +	int index;
> > +
> > +	down_read(&zram->init_lock);
> > +	if (!init_done(zram)) {
> > +		up_read(&zram->init_lock);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (index = 0; index < nr_pages; index++) {
> > +		zram_slot_lock(zram, index);
> > +		if (!zram_allocated(zram, index))
> > +			goto next;
> > +
> > +		zram_set_flag(zram, index, ZRAM_IDLE);
> > +next:
> > +		zram_slot_unlock(zram, index);
> > +	}
> > +
> > +	up_read(&zram->init_lock);
> > +
> > +	return len;
> > +}
> 
> This is one way of doing it.
> 
> The other one could, probabaly, be a bit more friendly to the cache
> lines and CPU cycles. Basically, have a static timestamp variable,
> which would keep the timestamp of last idle_store().
> 
> static idle_snapshot_ts;
> 
> static ssize_t idle_store(struct device *dev,
> 			  struct device_attribute *attr,
> 			  const char *buf, size_t len)
> {
> 	idle_snapshot_ts = ktime();
> }
> 
> And then in read_block_state() compare handle access time and
> idle_snapshot_ts (if it's not 0). If the page was not modified/access
> since the last idle_snapshot_ts (handle access time <= idle_snapshot_ts),
> then it's idle, otherwise (handle access time > idle_snapshot_ts) it's
> not idle.
> 
> Would this do the trick?

It was a option when I imagined this idea first but problem from product
division was memory waste of ac_time for every zram table.

