Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB15C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629D522506
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="eer78BHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629D522506
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbeKMKB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:01:57 -0500
Received: from alln-iport-5.cisco.com ([173.37.142.92]:41562 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=451; q=dns/txt; s=iport;
  t=1542067590; x=1543277190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uExxS9zyGKUbYfPAq25fEabkSZcvpRdj7YVWgh8NcXM=;
  b=eer78BHN5lNoJBRCdKCaUoX30jQWOQh1iZ4fF5zJDmQNE5Q45hMjl1SE
   afDk4Utyq5vBYJj0jtja/rpdTggUgIdNbpPiCcqAjxwEqrUljBovjKK8k
   SJoZ9iJE4HyAxuZyZOB9BRKpUxSawQ6v7i+b4uHuvTDLmuMhHQB/lq5lU
   g=;
X-IronPort-AV: E=Sophos;i="5.54,497,1534809600"; 
   d="scan'208";a="200208753"
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 00:06:29 +0000
Received: from zorba ([10.156.154.32])
        by rcdn-core-10.cisco.com (8.15.2/8.15.2) with ESMTPS id wAD06RGB003397
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Nov 2018 00:06:29 GMT
Date:   Mon, 12 Nov 2018 16:06:27 -0800
From:   Daniel Walker <danielwa@cisco.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Nikunj Kela (nkela)" <nkela@cisco.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Message-ID: <20181113000627.oe7cshgzfk4lf3to@zorba>
References: <591D4732-BC3E-4F85-9277-25E049FFF4BA@cisco.com>
 <CAFLxGvz8QgK1P6d-_biSRk4fyYEobio315_tUP+cRXTvt+m1hA@mail.gmail.com>
 <01b82f6eb37b674effc6c8b0fa4a014deb401a85.camel@infradead.org>
 <B1D7CC34-C9D3-4745-94A1-3F713C1CB216@cisco.com>
 <897867ec09af82ca76c642b48ad23a7f08838dcf.camel@infradead.org>
 <20181112214333.lplffcc722hta43v@zorba>
 <20181112225015.jyuro3z3ygavnvrp@zorba>
 <f64aa222a15467dc667deb5fc1bbcae1e477482a.camel@infradead.org>
 <20181112234022.r3gyu633ln3bp774@zorba>
 <b797e897960c3c047dfc7874615358a5443038a8.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b797e897960c3c047dfc7874615358a5443038a8.camel@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.156.154.32, [10.156.154.32]
X-Outbound-Node: rcdn-core-10.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 03:43:37PM -0800, David Woodhouse wrote:
> 
> That can't hurt. We should probably look at the time elapsed before you
> can *write* to it (when the background scan and crc checking is
> complete) rather than just reading.
> 


I'm not sure how to test that, but I tried this,

mount -t jffs2 mtd7 /mnt ; perf stat -B dd if=/dev/zero of=/mnt/test bs
1 count=1;

What would you suggest for testing this ?

Daniel
