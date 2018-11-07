Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B22AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42A320862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="LC7YKeOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42A320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbeKHDE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:04:28 -0500
Received: from alln-iport-8.cisco.com ([173.37.142.95]:36712 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbeKHDE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=377; q=dns/txt; s=iport;
  t=1541611986; x=1542821586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rdgFNDA1kBuzvi1iWbqFCfFEn6FxmgRtB3TMwVULx+U=;
  b=LC7YKeOxWpsQJX/CcCcE+D2RutRTYJ5C9L9P+az2BofEMjEFhkA3ckK0
   6/pFhOxd02NtO0CKefHn+7l9FvX63o0h53qY6Xk/NDI+Pd75+Fm0X1OHz
   v80sYGJ3gj8+TmLMOSAOhmUTFKYtTEHJkNbzPCbfBroIQhCTYRlP7tBm3
   g=;
X-IronPort-AV: E=Sophos;i="5.54,476,1534809600"; 
   d="scan'208";a="197328108"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 17:33:05 +0000
Received: from zorba ([10.156.154.31])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id wA7HX3iP006686
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Nov 2018 17:33:05 GMT
Date:   Wed, 7 Nov 2018 09:33:03 -0800
From:   Daniel Walker <danielwa@cisco.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "nkela@cisco.com" <nkela@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Message-ID: <20181107173303.slnb3i2d6ufaonp7@zorba>
References: <20181106214928.40020-1-nkela@cisco.com>
 <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
 <1e4c066d1896e2a0b8b146253d34d05cc4f9ab36.camel@infinera.com>
 <8b08e8b992093453bb2b9caff8cff08c.squirrel@twosheds.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b08e8b992093453bb2b9caff8cff08c.squirrel@twosheds.infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.156.154.31, [10.156.154.31]
X-Outbound-Node: alln-core-7.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 04:12:14PM -0000, David Woodhouse wrote:
> 
> > Yes, this may slow things down. I am not sure I agree with the impl.
> > either.
> > Could one not make cpu_to_je_X/jeX_to_cpu a function ptr which is set to
> > a func. with the correct endian?
> 
> On x86 retpoline would make that quite slow.

Is x86 the largest consumer of jffs2 ?

Daniel
