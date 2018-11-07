Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2B7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE11C2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="YINaKpXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE11C2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeKHFDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:03:02 -0500
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:44652 "EHLO
        rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKHFDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:03:01 -0500
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2018 00:03:01 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1129; q=dns/txt; s=iport;
  t=1541619077; x=1542828677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YtTpBgtZRpjibu3ozBjEhrBp7YUvBYaF//UwXAhT5UM=;
  b=YINaKpXzbossjU4Z/mI52diafcG9VgHU34XtTYAYkd6KyV2bJxRTG+T9
   P5VgGggmJZ4goGK/jFIBlh2/glbfiD5Ssi70ERJQugAfy/PlBRj2Q/txv
   BB63RAPI6Bt1Jb+mpsMbrglHDQzwUFL1G+ktC+Lw+bJ4Ta+tRH+brwOD5
   s=;
X-IronPort-AV: E=Sophos;i="5.54,476,1534809600"; 
   d="scan'208";a="467851184"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 19:21:54 +0000
Received: from zorba ([10.156.154.31])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id wA7JLkP2009626
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Nov 2018 19:21:54 GMT
Date:   Wed, 7 Nov 2018 11:21:45 -0800
From:   Daniel Walker <danielwa@cisco.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Joakim Tjernlund <joakim.tjernlund@infinera.com>,
        "nkela@cisco.com" <nkela@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Message-ID: <20181107192131.tf5ptjiccne3tzmq@zorba>
References: <20181106214928.40020-1-nkela@cisco.com>
 <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
 <1e4c066d1896e2a0b8b146253d34d05cc4f9ab36.camel@infinera.com>
 <8b08e8b992093453bb2b9caff8cff08c.squirrel@twosheds.infradead.org>
 <20181107173303.slnb3i2d6ufaonp7@zorba>
 <df9cdf1753ec7e6e20c12aa096b98453.squirrel@twosheds.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9cdf1753ec7e6e20c12aa096b98453.squirrel@twosheds.infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.156.154.31, [10.156.154.31]
X-Outbound-Node: alln-core-6.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 05:58:53PM -0000, David Woodhouse wrote:
> 
> > On Wed, Nov 07, 2018 at 04:12:14PM -0000, David Woodhouse wrote:
> >>
> >> > Yes, this may slow things down. I am not sure I agree with the impl.
> >> > either.
> >> > Could one not make cpu_to_je_X/jeX_to_cpu a function ptr which is set
> >> to
> >> > a func. with the correct endian?
> >>
> >> On x86 retpoline would make that quite slow.
> >
> > Is x86 the largest consumer of jffs2 ?
> 
> Certainly not. I'm not sure which architectures do have Spectre V2
> mitigations which make indirect branches expensive now... perhaps there is
> no intersection with the cases where we really care about JFFS2 being
> CPU-bound?


How about we add the Kconfig option to enable the mount option. So if you enable
to mount option your accepting the performance impact and we'll note that in the
Kconfig description. Then we can do the performance testing in time, and maybe
make this always on at some later time when the performance impact is better
understood ?

We could also add likely()/unlikely() cause that's easy enough.

Daniel
