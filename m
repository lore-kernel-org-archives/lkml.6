Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6954C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A24A2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="V3ZnMaVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A24A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeKBJRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:17:13 -0400
Received: from alln-iport-4.cisco.com ([173.37.142.91]:40685 "EHLO
        alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbeKBJRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:17:13 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Nov 2018 05:17:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=966; q=dns/txt; s=iport;
  t=1541117524; x=1542327124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y0h06bDjERW54u9e3GFfoFZ7LBzd7gGim9w0oCA7N6A=;
  b=V3ZnMaVSSStnmLG97Kad7LJf73Wbub0LTuqsuMdflvQgRMYUmAerCl1S
   ICOb8Fd6z3CKP73aDunLcYL/42Db5sRu2SwZZURV8eWUzzBweeQLiiaQf
   Rh7Wr3eTlYNVB7I1B6Xi8g1RCyBWxzmzzugKGAeiAfy3byK7ij2lV9kLS
   0=;
X-IronPort-AV: E=Sophos;i="5.54,454,1534809600"; 
   d="scan'208";a="195135796"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 00:02:42 +0000
Received: from zorba ([10.24.121.150])
        by alln-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id wA202dcg023096
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 2 Nov 2018 00:02:41 GMT
Date:   Thu, 1 Nov 2018 17:02:36 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Nikunj Kela <nkela@cisco.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, xe-linux-external@cisco.com,
        Rod Whitby <rod@whitby.id.au>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make JFFS2 endianness configurable
Message-ID: <20181102000236.rqho7txtb7gv543t@zorba>
References: <20181101225603.17806-1-nkela@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101225603.17806-1-nkela@cisco.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.121.150, [10.24.121.150]
X-Outbound-Node: alln-core-8.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On Thu, Nov 01, 2018 at 03:56:03PM -0700, Nikunj Kela wrote:
> This patch allows the endianness of the JFSS2 filesystem to be
> specified by config options.
> 
> It defaults to native-endian (the previously hard-coded option).
> 
> Some architectures benefit from having a single known endianness
> of JFFS2 filesystem (for data, not executables) independent of the
> endianness of the processor (ARM processors can be switched to either
> endianness at run-time).
> 


The description is pretty sad .. We have a product which we released that uses
JFFS2, and that product was release with a kernel in one endianness. Then later
on we decided to change the endianness and now we're stuck with a JFFS2
partition that has the wrong endiannes, in a released product. This patch allows
us to set the endianness to something different from the architecture setting.

So there a significant use case for the change, at least for Cisco.

Daniel
