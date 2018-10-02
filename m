Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FE3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B532082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQ+9RLmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B532082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeJCB0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:26:15 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46875 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeJCB0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:26:15 -0400
Received: by mail-yb1-f193.google.com with SMTP id o8-v6so1217865ybk.13;
        Tue, 02 Oct 2018 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Sa9Rft7SLm0ybnwkpEYiOMsJ6tJlmxz032AEZLMhWs=;
        b=pQ+9RLmildwvpj76Pyws/C8ZwezeHw//gYFK/LXY+MupawTlLZa/sGpkowziRwBE7i
         0GnSIAtcP5yFk4tmrXwDCig6rYSbZlvblZ+g/qEP3d/wsjJ5sKKMz3Lb6fq+QdDL6BT4
         KaCi2JWoBIMlT8JKpvI2OhJdrSQZsA2SNPaxK+OQY9a8WIFEqi5nyhL2OvhJHuGkA/Oc
         tEqPKE66WxeCbJyxrbukhZH2AG91b8YSUbMbgGGC6jCEGPwZRttJxlHxuP7kEp8WkArd
         szePlgMyjf7ijRAs1PfbRfAqn/uFcswTDc3gkDNsn7zuQD29TvGD10x+h3Z8Ovxf2L8M
         vXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Sa9Rft7SLm0ybnwkpEYiOMsJ6tJlmxz032AEZLMhWs=;
        b=pIsIHMApzADWaOY0aD+RpUFUbExy8rBiEzdEyzl83FJomYIWqWl/fu2zAGPlSPnmin
         1LhQQOUV6rQ4DC0ZvD1EYEx4IozahZ8a/fiYM6laKxXlOD7tedqEdlpvC4RxhQyznGg4
         Afh7dJ3jVT+wMP1dE6F6aMudXX00KuLtOK1gmEz+eSHIsW2J6x9/FZGpSk4RyQEs0dlV
         tkEp3BYoXl27lTef2mDHS3bi6rfIOhbOE6s1E/nNvIjUWWVRWKNnwXkSd8KmtslIAg0W
         tRkGThIFE99JF8vTEjzEY6AZb84OpuiurMb06efgUXyBSFixZQoNgoSRRXpokOnhoiIP
         rciw==
X-Gm-Message-State: ABuFfoiqfw8A/dG21gNL+gHYDQ4/xBDtjowLPZ6F2hihbZg6qOsZpQBw
        bLz7LVCqbQAodLoBA8A3ri0=
X-Google-Smtp-Source: ACcGV62REuP/XmmDAZiXhSLZvFtMFzE8JREDvG85gCdRwZqtGRerGw+8PwDFmHag/dVWa5TUoMtmCQ==
X-Received: by 2002:a25:2108:: with SMTP id h8-v6mr9356754ybh.30.1538505690098;
        Tue, 02 Oct 2018 11:41:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:ee3])
        by smtp.gmail.com with ESMTPSA id t81-v6sm9211896ywb.90.2018.10.02.11.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 11:41:29 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:41:27 -0700
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
Message-ID: <20181002184127.GH270328@devbig004.ftw2.facebook.com>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215138.13512.33146.stgit@localhost.localdomain>
 <20180926215307.GA270328@devbig004.ftw2.facebook.com>
 <9b002bbb-3e6d-9e99-d8f9-36df4306093e@linux.intel.com>
 <20180926220957.GB270328@devbig004.ftw2.facebook.com>
 <ba72f007-84e2-6fe0-b128-d876dadef5f5@linux.intel.com>
 <20181001160142.GE270328@devbig004.ftw2.facebook.com>
 <4eebc017-23a2-a26e-095c-66433061a141@linux.intel.com>
 <20181002174116.GG270328@devbig004.ftw2.facebook.com>
 <be9081de-f186-b265-934d-78cec2a8792f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be9081de-f186-b265-934d-78cec2a8792f@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 02, 2018 at 11:23:26AM -0700, Alexander Duyck wrote:
> >Yeah, it's all in wq_select_unbound_cpu().  Right now, if the
> >requested cpu isn't in wq_unbound_cpumask, it falls back to dumb
> >round-robin.  We can probably do better there and find the nearest
> >node considering topology.
> 
> Well if we could get wq_select_unbound_cpu doing the right thing
> based on node topology that would be most of my work solved right
> there. Basically I could just pass WQ_CPU_UNBOUND with the correct
> node and it would take care of getting to the right CPU.

Yeah, sth like that.  It might be better to keep the function to take
cpu for consistency as everything else passes around cpu.

> >>The question I have then is what should I do about workqueues that
> >>aren't WQ_UNBOUND if they attempt to use queue_work_near? In that
> >
> >Hmm... yeah, let's just use queue_work_on() for now.  We can sort it
> >out later and users could already do that anyway.
> 
> So are you saying I should just return an error for now if somebody
> tries to use something other than an unbound workqueue with
> queue_work_near, and expect everyone else to just use queue_work_on
> for the other workqueue types?

Oh, I meant that let's not add a new interface for now and just use
queue_work_on() for your use case too.

Thanks.

-- 
tejun
