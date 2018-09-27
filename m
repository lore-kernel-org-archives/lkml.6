Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D93C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856472156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856472156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeI0N0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:26:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50839 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbeI0N0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:26:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id s12-v6so4704685wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 00:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2gsj1xYS9HO7ZrFcafzOz8wOOAFqp8dN7sc/eBotpDQ=;
        b=b/l8ywseXcAYLdRp93QY+tKk677nyWHShPoRdRRLgQPgPGD6uc7vmsERZYJK4wxMuy
         3KlHgu6K9MLBJZEspjHDrEGtDDAV3mM6HwQ8Lpcv+YqrrBF/NsZYKOhzRM/kXmaA4Mjp
         tmaDVI5IJONXxhVxHA1a+erPWmX/eP6nACTeLPaSWfuyJ+81y60KDxU61iC1z0tpX4Ua
         XeNgkFq/FbA59VPvFRPPYqegsofjSq2oLXaRUVExR1IkWUXQdKC2djEILQi9auROKunz
         6lD2iHWPNy0NbumS79H33LCT3QrJnLAF9f5JSIyvNhnU544WPoG6DBhTeD6N3PK0fB3a
         owmg==
X-Gm-Message-State: ABuFfoiA7ycX4FKblEJy57xsh3KkTL5EpgjmT92UmXNzvSXqzuECoMrJ
        Xhe+bypFsbeNFgTfO9Nzqks=
X-Google-Smtp-Source: ACcGV63yCHMDtqQVSAV71JwJJbLGlAY0JpvCQT81b0GO0FwBzJcJWLheW+H3x6tmi3v1gVyBz2VX0g==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr6659172wmd.79.1538032199376;
        Thu, 27 Sep 2018 00:09:59 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 184-v6sm3071362wmv.6.2018.09.27.00.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 00:09:58 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 09314125604; Thu, 27 Sep 2018 09:09:58 +0200 (CEST)
Date:   Thu, 27 Sep 2018 09:09:58 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Arun KS <arunks@codeaurora.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v3] memory_hotplug: Free pages as higher order
Message-ID: <20180927070957.GA19369@techadventures.net>
References: <1538031530-25489-1-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538031530-25489-1-git-send-email-arunks@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:28:50PM +0530, Arun KS wrote:
> +	__free_pages_boot_core(page, order);

I am not sure, but if we are going to use that function from the memory-hotplug code,
we might want to rename that function to something more generic?
The word "boot" suggests that this is only called from the boot stage.

And what about the prefetch operations? 
I saw that you removed them in your previous patch and that had some benefits [1].

Should we remove them here as well?

[1] https://patchwork.kernel.org/patch/10613359/ 

Thanks
-- 
Oscar Salvador
SUSE L3
