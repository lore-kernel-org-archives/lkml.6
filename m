Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_NEOMUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4796C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928B02081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="gNWtJkyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928B02081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeKBXLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:11:39 -0400
Received: from alln-iport-4.cisco.com ([173.37.142.91]:32905 "EHLO
        alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1940; q=dns/txt; s=iport;
  t=1541167464; x=1542377064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=haHA5WqRQcMUNziGi4g3S1tgiGWxz250sy7XFD5RM9E=;
  b=gNWtJkyBZldZNHbr13zDBlB0J4vrz+4tUnGkCBURY77E8O2Lh0Z81/07
   evZD447Y0jHERTd2Lq06c+KL2NO4Ue20u7KGTxgpwB0wHFZzeucgL+z+e
   M9r5z0EPS9HlOCL+kphhXLS9t278CGaM5IG0PMq5Vujp7ZJVm8skSKD/5
   g=;
X-IronPort-AV: E=Sophos;i="5.54,456,1534809600"; 
   d="scan'208";a="195464345"
Received: from rcdn-core-12.cisco.com ([173.37.93.148])
  by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 14:04:23 +0000
Received: from zorba ([10.24.90.186])
        by rcdn-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id wA2E4Lhe019704
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 2 Nov 2018 14:04:22 GMT
Date:   Fri, 2 Nov 2018 07:04:20 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Nikunj Kela <nkela@cisco.com>,
        David Woodhouse <dwmw2@infradead.org>,
        xe-linux-external@cisco.com, Rod Whitby <rod@whitby.id.au>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make JFFS2 endianness configurable
Message-ID: <20181102140420.jiuhcsrahoeqe5vk@zorba>
References: <20181101225603.17806-1-nkela@cisco.com>
 <20181102000236.rqho7txtb7gv543t@zorba>
 <20181102003434.GW32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102003434.GW32577@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.90.186, [10.24.90.186]
X-Outbound-Node: rcdn-core-12.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 12:34:34AM +0000, Al Viro wrote:
> On Thu, Nov 01, 2018 at 05:02:36PM -0700, Daniel Walker wrote:
> > 
> > 
> > 
> > On Thu, Nov 01, 2018 at 03:56:03PM -0700, Nikunj Kela wrote:
> > > This patch allows the endianness of the JFSS2 filesystem to be
> > > specified by config options.
> > > 
> > > It defaults to native-endian (the previously hard-coded option).
> > > 
> > > Some architectures benefit from having a single known endianness
> > > of JFFS2 filesystem (for data, not executables) independent of the
> > > endianness of the processor (ARM processors can be switched to either
> > > endianness at run-time).
> > > 
> > 
> > 
> > The description is pretty sad .. We have a product which we released that uses
> > JFFS2, and that product was release with a kernel in one endianness. Then later
> > on we decided to change the endianness and now we're stuck with a JFFS2
> > partition that has the wrong endiannes, in a released product. This patch allows
> > us to set the endianness to something different from the architecture setting.
> > 
> > So there a significant use case for the change, at least for Cisco.
> 
> FWIW, can't we detect it at mount time, as e.g. UFS does?

We're not JFFS2 (or even filesystems) experts, but we could make an attempt at
it.

Do you have any thought on how to implement it ? I was think abstracting the
endian functions in the nodelist.h

static inline jint16_t cpu_to_je16(jint16_t x) {
	if (check_big_endian()) {
		return cpu_to_be16(x);
	} else if (check_little_endian()) {
		return cpu_to_le16(x);
	}
}

but how would you setup the checking ?

This would also work well for when you have a filesystem image on say an
x86 machine. I found some sites that recommend using jffs2dump to convert the
endianness before you can mount it. You most likely wouldn't change the kernel
in that case, or wouldn't want to.

Daniel
