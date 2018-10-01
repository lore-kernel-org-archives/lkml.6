Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3690C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F29F204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlhPmzEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F29F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeJAWkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:40:15 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33593 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJAWkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:40:15 -0400
Received: by mail-yw1-f68.google.com with SMTP id m127-v6so2090752ywb.0;
        Mon, 01 Oct 2018 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cwQ1wE00a63kxMagcaQIss+hO7DEXQX68CrC/1CV8wk=;
        b=nlhPmzEzTjADkB6ESxt2N93LTMubJ94IO/sduZL76QocW0UDinlWZ4m+n7NyYpUqa7
         twHuQeAgaKgS29SbOdAXFxrcHgEToiTpN3iUQ4sBB8cUHaf/b9P6V29sfZjkZZ5AfE7q
         fFjCIGGx4u3/wXPSFmO4mu479pZoBI8gpiSzvQDvV10cpdB95HKoC55b+9nqpsHssnNf
         xH3ebQNihwtkiIVcmCytI5h2AwSyrsZ5ctUX7OCK+1BobJzDwo7w3GL2P1KwC/isfEAr
         IdjgR/hhJWwvpJOh2l5E2vWtI8yN10I/F/S66Up2IKMX7aAK+mI6KWaWweOH8c9pZpVW
         dZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cwQ1wE00a63kxMagcaQIss+hO7DEXQX68CrC/1CV8wk=;
        b=jFp0BzDuqFUurijlUAGi7G6JHNhPMKDK7kB5hn4Nb/kjd2pUxDmEW2lKWarSypvanp
         lK4jP5gKtEi6ZHPm1erfvADbNPqM4XG/i3P+FOvjVYuiUIrzWxXkUowSfA8Qy4E1C/Sl
         k7esyjbeYsZBu41IGvturG47dklG4Ou5PK0Go8U3IPrve7rHkwpXSmBPglFCuZgnHgCy
         aYbnM8EbQAfCj3YkAmAwJ26kOp/xc9h3HmhyjdPkPVstmjpbDvGurhBwoXxd8JKR/0AI
         pGKwnHt3O/P+5UUBySszT/Zb/wy5uv7JwmnSSMyGZ2/k4szM9VayyxrPx9MBT6WLzKlr
         dAdg==
X-Gm-Message-State: ABuFfohmKpivj6xwpHh+V6e3tp9pQPDj9roRt2Vsd0z0/c1x2aDtMs5S
        m/O0qyAiuOQSE/FJhod+Guk=
X-Google-Smtp-Source: ACcGV61pLkcrWuyTsRQwdg96Uw6CE1h0kwnzeU3RWMo/HCibe9Gt0fQaRlvTzIxz19LzGP0kHmQB4w==
X-Received: by 2002:a81:2cd4:: with SMTP id s203-v6mr6136946yws.132.1538409705341;
        Mon, 01 Oct 2018 09:01:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:8671])
        by smtp.gmail.com with ESMTPSA id p128-v6sm5741810ywp.65.2018.10.01.09.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 09:01:44 -0700 (PDT)
Date:   Mon, 1 Oct 2018 09:01:42 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, len.brown@intel.com,
        dave.jiang@intel.com, rafael@kernel.org, vishal.l.verma@intel.com,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        dan.j.williams@intel.com
Subject: Re: [RFC workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
Message-ID: <20181001160142.GE270328@devbig004.ftw2.facebook.com>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215138.13512.33146.stgit@localhost.localdomain>
 <20180926215307.GA270328@devbig004.ftw2.facebook.com>
 <9b002bbb-3e6d-9e99-d8f9-36df4306093e@linux.intel.com>
 <20180926220957.GB270328@devbig004.ftw2.facebook.com>
 <ba72f007-84e2-6fe0-b128-d876dadef5f5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba72f007-84e2-6fe0-b128-d876dadef5f5@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Sep 26, 2018 at 03:19:21PM -0700, Alexander Duyck wrote:
> On 9/26/2018 3:09 PM, Tejun Heo wrote:
> I could just use queue_work_on probably, but is there any issue if I
> am passing CPU values that are not in the wq_unbound_cpumask? That

That should be fine.  If it can't find any available cpu, it'll fall
back to round-robin.  We probably can improve it so that it can
consider the numa distance when falling back.

> was mostly my concern. Also for an unbound queue do I need to worry
> about the hotplug lock? I wasn't sure if that was the case or not as

Issuers don't need to worry about them.

> I know it is called out as something to be concerned with using
> queue_work_on, but in __queue_work the value is just used to
> determine which node to grab a work queue from.

It might be better to leave queue_work_on() to be used for per-cpu
workqueues and introduce queue_work_near() as you suggseted.  I just
don't want it to duplicate the node selection code in it.  Would that
work?

> I forgot to address your question about the advantages. They are
> pretty significant. The test system I was working with was
> initializing 3TB of nvdimm memory per node. If the node is aligned
> it takes something like 24 seconds, whereas an unaligned core can
> take 36 seconds or more.

Oh yeah, sure, numa affinity matters quite a bit on memory heavy
workloads.  I was mistaken that you were adding adding numa affinity
to per-cpu workqueues.

Thanks.

-- 
tejun
