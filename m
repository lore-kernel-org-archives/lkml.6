Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B387C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FA1206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubgVzFgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FA1206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeKQCBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:01:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44079 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeKQCBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:01:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id s5-v6so11333695plq.11;
        Fri, 16 Nov 2018 07:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yyEBDisrzZDucWgLb++IQwrYwud34siQQ4o1Acb9MGY=;
        b=ubgVzFgCDdMxgGqJ8h4aoYjxkDvp4I4ujpdud2WiCXrQ1G7tuJBxNedDWavhFCCrW5
         GHv9ILjkIj7NadcQZJanrtG3rsjyXUOjLUHBf6Pv94IUIHMqQHHXwWlfJitXXmHuGxSB
         QZd+xyew7SnNiQLdP4TEUhUJrSc8rAqYDBHrRDRxTXikXy4+8nvgfS7PRXF5iMGi02BK
         JNQVF9y8t+YNPXQk1OECejVtmVLypAuvwLnzlcLhBEXOaxZmvPWqjsej4DEG42TJGROd
         kSxm2NYw+wZzn35UKwhmTUw+03uiDtTN6uZuCMGQg1xDcAXrha96TzWKaSmEQ9RsvhxV
         wXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yyEBDisrzZDucWgLb++IQwrYwud34siQQ4o1Acb9MGY=;
        b=mcVhZ1VkL/fDZHdEohlKS0Hz6eHMQBa+/Pbi+/pAnnJ9mizJYL069vJlNIwlJleve4
         AW0scywodBDMAKWbR/VpxIKGktFnD4xikSKK6AbpidFShZgVxj+dhFZJvOy2fmQ2sgxc
         dqMsz7zbzE4deMS030AMtvHARoPIMkfOT0l3sYirDu+ajos0DwwC7TXLW0pglM3uByie
         rvvC4v2TLN19yZ0hvjW/pYh//RO7OIblkNHj3PXwX5Cd8DnemPWaCwqi6ZmrXMBcCG2P
         2vC56GnTHitJ31lopL7EScodgucFle68iWfmM+YBcu7phkj6jShPbpTI+0EylwIYNOrg
         cbgQ==
X-Gm-Message-State: AGRZ1gJoXlOb8nmwB5amUwTNj9WXy/Zp+tmCwFxZeIuUwgnjuPVIW8NK
        4J/bIWvQEpNQdxhvwxJfHwY=
X-Google-Smtp-Source: AJdET5e1EOoEaG+/JJ3bVEngwn9k66zz9d2ubtmvSBtHr7ZCQcLm8/QOzflIiQaI9yZqHqU+ThLY2g==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8-v6mr11108007plo.94.1542383303455;
        Fri, 16 Nov 2018 07:48:23 -0800 (PST)
Received: from google.com ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id 67-v6sm39450236pfk.134.2018.11.16.07.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 07:48:22 -0800 (PST)
Date:   Fri, 16 Nov 2018 07:48:20 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        Howard Chen <howardsoc@google.com>
Subject: Re: [PATCH] zram: close udev startup race condition as default groups
Message-ID: <20181116154820.GA255402@google.com>
References: <20181114055223.66476-1-minchan@kernel.org>
 <20181115174504.GJ95254@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115174504.GJ95254@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 12:45:04PM -0500, Sasha Levin wrote:
> On Wed, Nov 14, 2018 at 02:52:23PM +0900, Minchan Kim wrote:
> > commit fef912bf860e upstream.
> > commit 98af4d4df889 upstream.
> > 
> > I got a report from Howard Chen that he saw zram and sysfs race(ie,
> > zram block device file is created but sysfs for it isn't yet)
> > when he tried to create new zram devices via hotadd knob.
> > 
> > v4.20 kernel fixes it by [1, 2] but it's too large size to merge
> > into -stable so this patch fixes the problem by registering defualt
> > group by Greg KH's approach[3].
> > 
> > This patch should be applied to every stable tree [3.16+] currently
> > existing from kernel.org because the problem was introduced at 2.6.37
> > by [4].
> > 
> > [1] fef912bf860e, block: genhd: add 'groups' argument to device_add_disk
> > [2] 98af4d4df889, zram: register default groups with device_add_disk()
> > [3] http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
> > [4] 33863c21e69e9, Staging: zram: Replace ioctls with sysfs interface
> > 
> > Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Tested-by: Howard Chen <howardsoc@google.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> I've queued this for 4.19 and 4.18, but it doesn't apply to anything
> older than that.

Thanks for the review, Hannes.

Sasha, I will send separate patches for older stable kernel.
Thanks for picking the patch.

> 
> --
> Thanks,
> Sasha
