Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5868C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924662081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="PeFDjQzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924662081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeKCGXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:23:33 -0400
Received: from alln-iport-4.cisco.com ([173.37.142.91]:37735 "EHLO
        alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeKCGXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1094; q=dns/txt; s=iport;
  t=1541193289; x=1542402889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K6AS13gXCOwa9AguBgQyVGngMmafF7uZ3EdQIES0qPI=;
  b=PeFDjQzStRMDgmbet4x7yNdF9zTRwfepcWIja3cQmNvqi3PVNmZuBz58
   lHU4K6q6l7MZjPqrUPevQmtVdaH5JP5Zor1JwjgrGMAPKwsH8T1F8TXPm
   cFT6wjamzSEA+UG68YBQQu9W5jz4y7D9R4tgmHKrEb3cyBXpq4wTTrKX9
   0=;
X-IronPort-AV: E=Sophos;i="5.54,457,1534809600"; 
   d="scan'208";a="195671246"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 21:14:48 +0000
Received: from zorba ([10.24.90.186])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id wA2LEj39016747
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 2 Nov 2018 21:14:47 GMT
Date:   Fri, 2 Nov 2018 14:14:44 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, nkela@cisco.com,
        xe-linux-external@cisco.com, LKML <linux-kernel@vger.kernel.org>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        Rod Whitby <rod@whitby.id.au>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Make JFFS2 endianness configurable
Message-ID: <20181102211444.nqqqbd4w5diyqrfw@zorba>
References: <20181101225603.17806-1-nkela@cisco.com>
 <20181102000236.rqho7txtb7gv543t@zorba>
 <20181102003434.GW32577@ZenIV.linux.org.uk>
 <20181102140420.jiuhcsrahoeqe5vk@zorba>
 <CAFLxGvy-0-A1Ta1vf=o4q0tcJAdr+uv9eQc7UrnwqF9NkJiWUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvy-0-A1Ta1vf=o4q0tcJAdr+uv9eQc7UrnwqF9NkJiWUw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.90.186, [10.24.90.186]
X-Outbound-Node: alln-core-11.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 09:15:06PM +0100, Richard Weinberger wrote:
> On Fri, Nov 2, 2018 at 3:04 PM Daniel Walker <danielwa@cisco.com> wrote:
> > Do you have any thought on how to implement it ? I was think abstracting the
> > endian functions in the nodelist.h
> 
> Yes, see what UFS does.
> 
> > static inline jint16_t cpu_to_je16(jint16_t x) {
> >         if (check_big_endian()) {
> >                 return cpu_to_be16(x);
> >         } else if (check_little_endian()) {
> >                 return cpu_to_le16(x);
> >         }
> > }
> >
> > but how would you setup the checking ?
> 
> Make it a mount option and store the endianness mode in the super block.

It's actually a mkfs option currently. I'm not sure how that factors in,

from the mkfs.jffs2 man page,

       -l, --little-endian
              Create a little-endian JFFS2 image.  Default is to make an image with the same endianness as the host.

       -b, --big-endian
              Create a big-endian JFFS2 image.  Default is to make an image with the same endianness as the host.


Daniel
