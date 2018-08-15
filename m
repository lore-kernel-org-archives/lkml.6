Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAFDC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635962156F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635962156F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbeHORZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:25:15 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40169 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeHORZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:25:15 -0400
Received: by mail-wr1-f48.google.com with SMTP id h15-v6so1310494wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/em1lUuVJhsh+JUwUVwfEzmV1XesseCOHlbAfg4SKls=;
        b=XUNdIlRt+drSXonFqZbk8URbSQohHvPywdAx0sr8VUFaNeI89rAgsN5NPks2JL2RsT
         5/7bD/D27aqjZ/IfAq8dOJEaPyckxWl1I/W4NLwcpzILgoC96tgz7xmVvz+Pq68teSY3
         MkeSGZcnnhHxYcM1r5SOOOR2oyuOJe377nOJbBA7LydAoV7MHn401amWxhBRwtVohI1P
         oWL120W2G1AB+MtyFStNZGCuzz2cA3uypQWrXp6NGL1kO5Ofn5WxFhXOllI9mOsFkpFB
         ctdfSwED1AxBOMqXsGekELq22kTKu2WkAF5ycKtzwGM4BMfWdAOdyC1yp8RYRjTggHmv
         67uQ==
X-Gm-Message-State: AOUpUlEkG6BTC+C8hol8JHUNXs3WArMwqv/d47efvTH4GU1xwAoO5A7e
        kiaXtp5hmkO82QYX/vbexuc=
X-Google-Smtp-Source: AA+uWPxmn5ht/Z9eo2V8HTBNsNN8hBOdhYEFLs7Lu//iASZRKiAvbYybD0MCMamUE5ilbQPpNhak5w==
X-Received: by 2002:a5d:5201:: with SMTP id j1-v6mr16529798wrv.198.1534343570324;
        Wed, 15 Aug 2018 07:32:50 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id q3-v6sm1345858wmf.21.2018.08.15.07.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 07:32:49 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id CBF3E12489D; Wed, 15 Aug 2018 16:32:48 +0200 (CEST)
Date:   Wed, 15 Aug 2018 16:32:48 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 0/3] Do not touch pages in remove_memory path
Message-ID: <20180815143248.GA10577@techadventures.net>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <DM5PR21MB0508CEC7F586EBC89D2CCFBB9D3F0@DM5PR21MB0508.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR21MB0508CEC7F586EBC89D2CCFBB9D3F0@DM5PR21MB0508.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 02:05:35PM +0000, Pavel Tatashin wrote:
> > This tries to fix [1], which was reported by David Hildenbrand, and also
> > does some cleanups/refactoring.
> 
> Hi Oscar,
> 
> I would like to review this work. Are you in process of sending a new version? If so, I will wait for it.

Hi Pavel,

Yes, I plan to send a new version by Friday latest (although I hope tomorrow).

Thanks
-- 
Oscar Salvador
SUSE L3
