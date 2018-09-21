Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9BAECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B16F20833
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B16F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389743AbeIUQT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:19:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38440 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUQT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:19:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id t25-v6so2665025wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 03:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MLQbbVAShPqtFPqB39xtt1JSukJPaV6UDF7X/Wx0anE=;
        b=VcWwtDqkYTfBe9BDds2HzG1FUfnwiknxCGVQCoAWerBHtVTg0DWodxvQ11398txrC4
         y3G09JZlkNPXWKVg98SxM1qR7mu9vNcyWwIitRADXwL/21DjjopZH3w+XeT1zfncIALS
         l2euRBGJO4mHjXxyEJOINnVbPy6Gk2zxJ+OL15HrmLGn9Hlcpxfyln6G8KfgWso/mPWo
         vns+Yf/JbWmUTEcnWmD/vhRVRhYB5BXxGNBN2TNw151y0aDzAL6B/ZNje1VRf7YczuOM
         E2nSwVaT5vq8k4GBqZT3bxy0AmVXhX0FKkWq3IdWm4Ft0soaiZYfzsf8idybo3a2rSHv
         t0Ww==
X-Gm-Message-State: APzg51BPb0ntRdHL/ls5/TcScPIIGbMLQfxPs+Ol4+q5W7y6kC/r3l0K
        SdfnXWKtJWkmU6Vi0K5g03Q=
X-Google-Smtp-Source: ANB0VdZUxttlTRVenjMctyk0x4zyZs7lr6DiZq5D8v5bdkeyO6b5QC7M0uE3HaW+F1WEYN1HU7ME0w==
X-Received: by 2002:a1c:3906:: with SMTP id g6-v6mr6324382wma.50.1537525902380;
        Fri, 21 Sep 2018 03:31:42 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id b74-v6sm9550622wma.8.2018.09.21.03.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 03:31:41 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 304E1125426; Fri, 21 Sep 2018 12:31:41 +0200 (CEST)
Date:   Fri, 21 Sep 2018 12:31:41 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "malat@debian.org" <malat@debian.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 2/5] mm/memory_hotplug: Avoid
 node_set/clear_state(N_HIGH_MEMORY) when !CONFIG_HIGHMEM
Message-ID: <20180921103141.GB15555@techadventures.net>
References: <20180919100819.25518-1-osalvador@techadventures.net>
 <20180919100819.25518-3-osalvador@techadventures.net>
 <e66c7d55-7145-dd6c-4b11-27893ed7a7d0@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66c7d55-7145-dd6c-4b11-27893ed7a7d0@microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 08:59:18PM +0000, Pasha Tatashin wrote:
> This is a rare case where I think comments are unnecessary as the code
> is self explanatory. So, I would remove the comments before:

Fair enough.
I just wanted to make clear why it was not needed.

I will remove it in the next version.

Thanks
-- 
Oscar Salvador
SUSE L3
