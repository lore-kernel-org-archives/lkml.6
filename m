Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2711C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE2E20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ck10cOqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE2E20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeKJG5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:57:45 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35273 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJG5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:57:45 -0500
Received: by mail-qk1-f196.google.com with SMTP id w204so4141788qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 13:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=d1jLP0vvLb2F8QBsHv2P1ODyTO4vmGSriZo5+RA6cXM=;
        b=ck10cOqMcv/andnIqMi3kYyLlNiZAC9R8jMrGBx22lJ4vI28Sb9X+LlVoooQwCx8eu
         Cw7qRP8KS9rJyf+WH+S8sIEUQ2rGWlxTtRjyQAXUGKsCKQ5q1zp/H6nZbV3WNbEQDLxg
         5SIDilLN7bL2ZvndhoPUBARm4NTM02VrBMadST2s56uJq5BuCTuMzmidryYUNhZsMFSG
         CwtRrxVD9lDhW7wdmyacOpsvhLIgkH5D32AryqAe/d3rYV/2m2TSB/q5mhv4wAXl1w7b
         jvBhpxDNSCWBViqbOz5SZv4dznjIRE7Dop97Fkje9pXAAlOe/iiGXZzageeg6/Wuyo81
         CwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d1jLP0vvLb2F8QBsHv2P1ODyTO4vmGSriZo5+RA6cXM=;
        b=kp9LIMTcw6xQMrjPOjNfCYpZdHn7VotC+QxDrPWAN0aUVK5J0MW3MJCQ9ILO4CFIiQ
         BMVgovd/tg7BBOB6KYbtPAJ5cvNnPODXqQFU5kqU+qGKjJJzm1GohQqZ8mGL5ote9IF7
         L4lZ/uFcmWJFnsDUd4aaVH/e1n0nYtTY8gugiHv9v8pdymBTOjN+vwyd2wW9sy8aTB0y
         fE/5AChuL/2VwXmGi8cl4stQwwsdukQ65kWql3eT5GQUVePVU0er8in5eiMADF+iiVtV
         eIJlgjip2hWyt1JPvmwnH9Hsxynv4v68VJAo+QMeh7A0Ltmi8CD1BpGD57PE6YIStypL
         MJmw==
X-Gm-Message-State: AGRZ1gLbvabCoxe3G5tibyVuQaMQoe/E/V/3QTfpYYVKh+hhLkH+/YNJ
        9xCi5yQ3KlYmm5Yv0x/141KinQ==
X-Google-Smtp-Source: AJdET5cNxqgGHDTlxR1FRJV0mlMG8VKwLZAc+swlnnS+X/K8gEhvEE6KAdt9lGjqbfL8GX7bV07qwA==
X-Received: by 2002:ac8:160b:: with SMTP id p11mr10092610qtj.113.1541798123874;
        Fri, 09 Nov 2018 13:15:23 -0800 (PST)
Received: from xakep.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w34sm5002599qtj.27.2018.11.09.13.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 13:15:22 -0800 (PST)
Date:   Fri, 9 Nov 2018 16:15:21 -0500
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        daniel.m.jordan@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 0/7] Deferred page init improvements
Message-ID: <20181109211521.5ospn33pp552k2xv@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-05 13:19:25, Alexander Duyck wrote:
> This patchset is essentially a refactor of the page initialization logic
> that is meant to provide for better code reuse while providing a
> significant improvement in deferred page initialization performance.
> 
> In my testing on an x86_64 system with 384GB of RAM and 3TB of persistent
> memory per node I have seen the following. In the case of regular memory
> initialization the deferred init time was decreased from 3.75s to 1.06s on
> average. For the persistent memory the initialization time dropped from
> 24.17s to 19.12s on average. This amounts to a 253% improvement for the
> deferred memory initialization performance, and a 26% improvement in the
> persistent memory initialization performance.

Hi Alex,

Please try to run your persistent memory init experiment with Daniel's
patches:

https://lore.kernel.org/lkml/20181105165558.11698-1-daniel.m.jordan@oracle.com/

The performance should improve by much more than 26%.

Overall, your works looks good, but it needs to be considered how easy it will be
to merge with ktask. I will try to complete the review today.

Thank you,
Pasha
