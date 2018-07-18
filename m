Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EA1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872E02075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872E02075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeGROug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:50:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39459 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbeGROuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:50:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so4842732wre.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 07:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WwWfS3OLhTe4Ooer7DTxhXD/jdCVYwrZ/HMLBW+SlGI=;
        b=phTVu8caFiLm7e+y7PfvpNSEjGD1Ux8CkjjHbR+dg7Erokb2QI07GhAwDgZxJLOlpf
         C807QZaE1Y+636hTkJ91t2XAz+tC8UEgQB9EfEOZ/HolRz/vcJK6KIH55ZSsqqiPQYGF
         IqjCgUYMGq2VAlSKbPI+lwYDrrkHU2ldrkM7/u5iA678xdWcSDwkrKNDz/hoSgw5g/nL
         qNqA9oz2GUnELxYM74TECmJBqlt/rLYytMvkQTv5HArrCHnxBFYGpufJ9fZD+pQtJhju
         DmLqKmeCZfb+C2Sy5CbZoNXmW7BeVxPNj63TjdMi6xjSywoIS3/8leuFPq8BZZGWEHHR
         SRhw==
X-Gm-Message-State: AOUpUlFNS+b/bZ7zx+CPNcafJXpad2EbkC4mJKhecf8EHQKkvFcJ4RGH
        qXTe83V8ITK6E+HHg1TW1YJUe7Dk
X-Google-Smtp-Source: AAOMgpd0WZ6PeQBIESmXMGFNUQfOa7SgiKZ7Ik+LvW0DDYRr8ogZX4ZMWubB6aHVrnHDUZZIPvoaiA==
X-Received: by 2002:a5d:48c7:: with SMTP id p7-v6mr4901555wrs.0.1531923148088;
        Wed, 18 Jul 2018 07:12:28 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id h2-v6sm1771151wmf.28.2018.07.18.07.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 07:12:27 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id C6F6A1240E3; Wed, 18 Jul 2018 16:12:26 +0200 (CEST)
Date:   Wed, 18 Jul 2018 16:12:26 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, iamjoonsoo.kim@lge.com, aaron.lu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 2/3] mm/page_alloc: Refactor free_area_init_core
Message-ID: <20180718141226.GA2588@techadventures.net>
References: <20180718124722.9872-1-osalvador@techadventures.net>
 <20180718124722.9872-3-osalvador@techadventures.net>
 <20180718133647.GD7193@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718133647.GD7193@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 03:36:47PM +0200, Michal Hocko wrote:
> On Wed 18-07-18 14:47:21, osalvador@techadventures.net wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> > 
> > When free_area_init_core gets called from the memhotplug code,
> > we only need to perform some of the operations in
> > there.
> 
> Which ones? Or other way around. Which we do not want to do and why?
> 
> > Since memhotplug code is the only place where free_area_init_core
> > gets called while node being still offline, we can better separate
> > the context from where it is called.
> 
> I really do not like this if node is offline than only perform half of
> the function. This will generate more mess in the future. Why don't you
> simply. If we can split out this code into logical units then let's do
> that but no, please do not make random ifs for hotplug code paths.
> Sooner or later somebody will simply don't know what is needed and what
> is not.

Yes, you are right.
I gave it another thought and it was not a really good idea.
Although I think the code from free_area_init_core can be simplified.

I will try to come up with something that makes more sense.

Thanks
-- 
Oscar Salvador
SUSE L3
