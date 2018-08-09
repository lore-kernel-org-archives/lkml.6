Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78690C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E28021E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E28021E5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeHIXR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:17:26 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:53157 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHIXR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:17:26 -0400
Received: by mail-wm0-f44.google.com with SMTP id o11-v6so1534147wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xt3apRvHSBlHNYAY75JSNgXseBtcaM4kxuRwtymZs+c=;
        b=N7Q+jyu+Hgvvc/+gbE4gMQU5yE44praNecW1f7iRuZ3F7L5FKhoogztWWiBCVssgZo
         c+x7O/C+HiECKkrHXwBKgypW8ujmvm9X9LzKd/IoHkrAwDBPxdWJSDdzxasPaUp+JgEg
         z3LaHoXqx2Z3USFOtOz8/CtM3QYYEuwrfwQXk8yaFWgvXmOqbYJ55xuPX6tGslQWXYg+
         zIlhurQvKRLQ9VEqrG0ztRKd8ey8Mz3I/e8WixjDHE/t2Ze7nNAi2P3BXSDWW8c1jtCi
         u8VQErVvnBlAuCZ18zxSJa/hrMGh9mph3KKU1Pd+AU6GKPl4CwjZev30jv8GTL/Ourbr
         JubA==
X-Gm-Message-State: AOUpUlEFcsS1D4UVQs11Q+BNaBuBW7eNDXc59WkQwK7X6EAjCnFvDEb2
        55ubWyC1+4KtIwll9ZL6Iyo=
X-Google-Smtp-Source: AA+uWPwvc7kcIU3mlp3BOw6lYU8QGRmpigsiQNJ4vlxWq2dpv7idiXrr28RXVOTBR9NziNg3Rmg8KQ==
X-Received: by 2002:a1c:908b:: with SMTP id s133-v6mr2619116wmd.69.1533847851845;
        Thu, 09 Aug 2018 13:50:51 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id e133-v6sm14977847wma.33.2018.08.09.13.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 13:50:51 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 5C29A1247F6; Thu,  9 Aug 2018 22:50:50 +0200 (CEST)
Date:   Thu, 9 Aug 2018 22:50:50 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, pasha.tatashin@oracle.com,
        david@redhat.com, yasu.isimatu@gmail.com, logang@deltatee.com,
        dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180809205050.GA17222@techadventures.net>
References: <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <20180807145900.GH10003@dhcp22.suse.cz>
 <20180807151810.GB3301@redhat.com>
 <20180808064758.GB27972@dhcp22.suse.cz>
 <20180808165814.GB3429@redhat.com>
 <20180809082415.GB24884@dhcp22.suse.cz>
 <20180809142709.GA3386@redhat.com>
 <20180809150950.GB15611@dhcp22.suse.cz>
 <20180809165821.GC3386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809165821.GC3386@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 12:58:21PM -0400, Jerome Glisse wrote:
> > I would really prefer to be explicit about these requirements rather
> > than having subtle side effects quite deep in the memory hotplug code
> > and checks for zone device sprinkled at places for special handling.
> 
> I agree, i never thought about that before. Looking at existing resource
> management i think the simplest solution would be to use a refcount on the
> resources instead of the IORESOURCE_BUSY flags.
> 
> So when you release resource as part of hotremove you would only dec the
> refcount and a resource is not busy only when refcount is zero.
> 
> Just the idea i had in mind. Right now i am working on other thing, Oscar
> is this something you would like to work on ? Feel free to come up with
> something better than my first idea :)

Hi Jerome,

Definetly it would be something I am interested to work on.
Let me think a bit about this and see if I can come up with something.

Thanks
-- 
Oscar Salvador
SUSE L3
