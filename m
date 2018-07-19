Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFCCC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1507C2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1507C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbeGSOmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:42:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39428 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731804AbeGSOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:42:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so6486579wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 06:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m9lxl6NH9FppFxQrFdHhXypzdTnxtxazSHxp69Rq0yo=;
        b=mPKo9PBfKBxCDQ4YSLAV2S80YNXrys/nNq7mNEHbO6VPY88jvxTkXtwVRcGFFg6Z5A
         H4pMPdW2iJ51B7zeiTy2caX5VeDC3rUO/XN6NuYdDSzzRbP5sYwMN2pYv8lseMbnGmk1
         LYmFzAe7BC/ab4WhlxwHhE3RM+CJg15ncXxed3fyEGYitZIDPFGhHSkxrp+Vg3wuY5qi
         NFi0Pwk5NP1R604cSVvV90Uo4vYYmvTj92c2oF33GxoUNeV7/lu8ts9fE+Oy6Lsl/GR3
         as0MXOv5lCDUbKHAZHnjZx5caZnRhc2cLsxov41xGT3gKm1krW3nZz9USq7uVLsvFC0j
         M1lw==
X-Gm-Message-State: AOUpUlEdvRs/yJMX0s/3eeW369x3M4b4af7Zvhjds3J8IlDHE1bLSMt8
        Cfmmw4+cQXXvtdGGPOgyps8=
X-Google-Smtp-Source: AAOMgpcoP273dJkxklqtAN0mnYbrWklFBvJHdK0nWP34L9N7X2wm1iohmY4ctnt117grG0WF0vvY3w==
X-Received: by 2002:a1c:e409:: with SMTP id b9-v6mr4143456wmh.34.1532008740316;
        Thu, 19 Jul 2018 06:59:00 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id m17-v6sm10280339wrg.65.2018.07.19.06.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:58:59 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 175E8124188; Thu, 19 Jul 2018 15:58:59 +0200 (CEST)
Date:   Thu, 19 Jul 2018 15:58:59 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 5/5] mm/page_alloc: Only call pgdat_set_deferred_range
 when the system boots
Message-ID: <20180719135859.GA10988@techadventures.net>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-6-osalvador@techadventures.net>
 <20180719134622.GE7193@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719134622.GE7193@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 03:46:22PM +0200, Michal Hocko wrote:
> On Thu 19-07-18 15:27:40, osalvador@techadventures.net wrote:
> > From: Oscar Salvador <osalvador@suse.de>
> > 
> > We should only care about deferred initialization when booting.
> 
> Again why is this worth doing?

Well, it is not a big win if that is what you meant.

Those two fields are only being used when dealing with deferred pages,
which only happens at boot time.

If later on, free_area_init_node gets called from memhotplug code,
we will also set the fields, although they will not be used.

Is this a problem? No, but I think it is more clear from the code if we
see when this is called.
So I would say it was only for code consistency.

If you think this this is not worth, I am ok with dropping it.

Thanks
-- 
Oscar Salvador
SUSE L3
