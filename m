Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4755C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A6E2174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A6E2174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389637AbeHGQnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:43:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53402 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbeHGQnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:43:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so17659898wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VlS1mzb325GmXvcLxK23PrTNTnJfcQuai4cRq/OGx7Y=;
        b=JjsDAJnsV9Ggge7dG71H7Z2Asy7NgAHYJzuL8/UvGkjRx71m5z/6hJinC/6BztgSBz
         59QCye3XOzbJFdegeYGBrbq+AIfLYgldTdK9FII4xaXUITUnpLgV9nIV9U9HGIy+DEH/
         jhBlLYqkR9VqZyfZ5Cm3jpVRyV4YvSVajCWQf5Ff51D0djCw2tdc3UglkJhspVJIDRnF
         quH3ACXjVFZx8c0RdcvoOnTmuOPv3eZ5OQ//uiEud8FA8IXl2LMR+uehKfA6bHHLeR9L
         m93SxknvHkEeRBLPzSyaNYwvw2WZl02AILWtVd+CLJqLMgDiF02MFD7PpHPq7m9pYYX8
         A/oQ==
X-Gm-Message-State: AOUpUlGDFhXnBU6OIbzolS4X9b+pisUv4XIynA5spRwMIj8/AGAXO8Kc
        EvMTR+PNy73onQP06PIZdKY=
X-Google-Smtp-Source: AA+uWPxj8TTmr71GznnEB1UO+pgjNH1F7DJz79n7SCY20SXN3g+KcC/E4CndheIWIYaBBvqBrgvK6w==
X-Received: by 2002:a1c:f516:: with SMTP id t22-v6mr1780114wmh.103.1533652107517;
        Tue, 07 Aug 2018 07:28:27 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id i14-v6sm3501341wmd.13.2018.08.07.07.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 07:28:26 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 141FF12470C; Tue,  7 Aug 2018 16:28:26 +0200 (CEST)
Date:   Tue, 7 Aug 2018 16:28:26 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, pasha.tatashin@oracle.com,
        jglisse@redhat.com, yasu.isimatu@gmail.com, logang@deltatee.com,
        dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 0/3] Do not touch pages in remove_memory path
Message-ID: <20180807142826.GB5309@techadventures.net>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <6407d022-87b7-f5e0-572a-c5c29aba1314@redhat.com>
 <20180807141922.GA5244@techadventures.net>
 <d0ea36f7-9329-f947-3862-011827aee20c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0ea36f7-9329-f947-3862-011827aee20c@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 04:20:37PM +0200, David Hildenbrand wrote:
> On 07.08.2018 16:19, Oscar Salvador wrote:
> > On Tue, Aug 07, 2018 at 04:16:35PM +0200, David Hildenbrand wrote:
> >> On 07.08.2018 15:37, osalvador@techadventures.net wrote:
> >>> From: Oscar Salvador <osalvador@suse.de>
> >>>
> >>> This tries to fix [1], which was reported by David Hildenbrand, and also
> >>> does some cleanups/refactoring.
> >>>
> >>> I am sending this as RFC to see if the direction I am going is right before
> >>> spending more time into it.
> >>> And also to gather feedback about hmm/zone_device stuff.
> >>> The code compiles and I tested it successfully with normal memory-hotplug operations.
> >>>
> >>
> >> Please coordinate next time with people already working on this,
> >> otherwise you might end up wasting other people's time.
> > 
> > Hi David,
> > 
> > Sorry, if you are already working on this, I step back immediately.
> > I will wait for your work.
> 
> No, please keep going, you are way ahead of me ;)
> 
> (I was got stuck at ZONE_DEVICE so far)

It seems mine breaks ZONE_DEVICE for hmm at least, so.. not much better ^^.
So since you already got some work, let us not throw it away.

Thanks
-- 
Oscar Salvador
SUSE L3
