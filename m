Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71260C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FC2217B7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FC2217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbeHGRHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:07:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53355 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbeHGRHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:07:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so17744189wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=08infau77i+pItKq5f5h3+RL7j1tPo8L19jst4GO8lo=;
        b=aoHbQI1NA0a0NhooncZt6mmVVCP0Q0BGL8hqnHYRHiB6zKbM4GefrSQ9qQIjitoGda
         bc7MDe4jRYWkyfhfj0jovDjnkhH5gxMohL1z510EeSiFvPca0dniyZPQpxm4Y7k+aazK
         8cex0/kQ2BZf/QVzxoRGFIHDEoRNWsxEKaVrfkgWPyCEpxX4EPxGncdjMTPHzfTtx6xZ
         noPo9H/66VmDMdSIZ+HHyWutd7aI1OnB8nhIVt7Jd5SCCG13kayTKRGgsGxUOyqeMyZS
         +7NYpVGkEiGbopQ4DSLqHTbtCdwmu7T3FV7/vkUXRRWMmGuUwZ4vKARIlgITsNVf/I5D
         Vo6A==
X-Gm-Message-State: AOUpUlEVKgwlgtcTlh6OBoJ+IUMboxSHm1MBWK8b8jYu7M55EY6EeSGO
        p68p1V7IQEFr1YjG9rf2S18=
X-Google-Smtp-Source: AA+uWPyH28G9+nCj0cCsMIqkVrbhYYKQsQi4Iw8LO46npQNLqgvM29Jgh+Hf5qgfTqexWvtLehc/cw==
X-Received: by 2002:a1c:7c13:: with SMTP id x19-v6mr2018736wmc.27.1533653560604;
        Tue, 07 Aug 2018 07:52:40 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id d8-v6sm2081598wrv.68.2018.08.07.07.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 07:52:39 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id BAEC9124711; Tue,  7 Aug 2018 16:52:38 +0200 (CEST)
Date:   Tue, 7 Aug 2018 16:52:38 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, pasha.tatashin@oracle.com,
        jglisse@redhat.com, yasu.isimatu@gmail.com, logang@deltatee.com,
        dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 0/3] Do not touch pages in remove_memory path
Message-ID: <20180807145238.GA5512@techadventures.net>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <6407d022-87b7-f5e0-572a-c5c29aba1314@redhat.com>
 <20180807141922.GA5244@techadventures.net>
 <d0ea36f7-9329-f947-3862-011827aee20c@redhat.com>
 <20180807142826.GB5309@techadventures.net>
 <6d07f588-cc40-132e-2d89-26e00fff5a88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d07f588-cc40-132e-2d89-26e00fff5a88@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 04:41:33PM +0200, David Hildenbrand wrote:
> I am not close to an RFC (spent most time looking into the details -
> still have plenty to learn in the MM area - and wondering on how to
> handle ZONE_DEVICE). It might take some time for me to get something
> clean up and running.

That is probably the way to go, details like ZONE_DEVICE what I thought
it was about to be easier.
This has been broken for a while, so a few more weeks(or more) will not hurt.
Also, I need to catch up with ZONE_DEVICE myself and I will be on vacation
for a few weeks, so that is it.

Feel free to re-use anything you find useful in these series(in case you find something).

Thanks
-- 
Oscar Salvador
SUSE L3
