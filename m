Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9F6C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5444E2174C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5444E2174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389468AbeHGQd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:33:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40479 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389223AbeHGQd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:33:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so18430260wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uenez1CVaYZSLr5xv1gNkjDLfr8ggiz8OD25r5HLMWw=;
        b=hVBcx0IQkWQJtf6j0ksJvm24EhEcPd8oLmX/bYRbMOnWi7ZbQKglkwoSbrHuJX452p
         qlYycmCcsKm4DoRwJuh0GwnEs0A4ilZoc7YV+fYJmNjQ5XmeiEntCBtHs40nBh8/52fZ
         ZH2a+dwgilOs6dxiMqn8VIPzNZVfTpiOAdX6f3ChWnsNsMIFJEADhG5i1P2ur2Tz+hUi
         OSCTatnnE2b6Sx/+J5dFmkTPriRvGHUAyIAcFFXitBC9ndyHsPaYpA+g2nS4RYJ2Gowd
         qzK81kaMBq25e7B4Ut3iujwOnCMm4UHoPArcur19Yg8/68mmrkrZBDaW7/RqOB8Q9uM/
         NKiA==
X-Gm-Message-State: AOUpUlE9fN+xIETUSiPug6JPGF9GtTlH7wqsuMOKwe3E4pqD+i6M945o
        n3vfIAWR2IsYK4MlVAIoMbk=
X-Google-Smtp-Source: AA+uWPxzQoE8kJTJGwYrD4DygFuaRA1bBsbMJcPeUvfYlCyKowv/6eS4RGH8fvjC7lYpu/3bkTFyog==
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr1782183wmx.38.1533651563844;
        Tue, 07 Aug 2018 07:19:23 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id m2-v6sm2219931wrw.76.2018.08.07.07.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 07:19:23 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 752E3124707; Tue,  7 Aug 2018 16:19:22 +0200 (CEST)
Date:   Tue, 7 Aug 2018 16:19:22 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, pasha.tatashin@oracle.com,
        jglisse@redhat.com, yasu.isimatu@gmail.com, logang@deltatee.com,
        dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 0/3] Do not touch pages in remove_memory path
Message-ID: <20180807141922.GA5244@techadventures.net>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <6407d022-87b7-f5e0-572a-c5c29aba1314@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6407d022-87b7-f5e0-572a-c5c29aba1314@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 04:16:35PM +0200, David Hildenbrand wrote:
> On 07.08.2018 15:37, osalvador@techadventures.net wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> > 
> > This tries to fix [1], which was reported by David Hildenbrand, and also
> > does some cleanups/refactoring.
> > 
> > I am sending this as RFC to see if the direction I am going is right before
> > spending more time into it.
> > And also to gather feedback about hmm/zone_device stuff.
> > The code compiles and I tested it successfully with normal memory-hotplug operations.
> >
> 
> Please coordinate next time with people already working on this,
> otherwise you might end up wasting other people's time.

Hi David,

Sorry, if you are already working on this, I step back immediately.
I will wait for your work.

thanks
-- 
Oscar Salvador
SUSE L3
