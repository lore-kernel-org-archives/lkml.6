Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EA8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E767721763
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV0Iev/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E767721763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbeHCP3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbeHCP3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:29:25 -0400
Received: from jouet.infradead.org (unknown [186.208.79.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23512175D;
        Fri,  3 Aug 2018 13:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533303182;
        bh=Y22UxhHswyuxWH2fD+DUOM2O/RHz7KWbRJjXabSSSrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IV0Iev/ZFSWmNvGoyYyt3t0s6ED5JTwT5m1wcCF4GUtiBDjlxiWt3fne4jqqyD2Zf
         U3Ja95k/qFzXbM2sAGqc++BH5dT4X3AZCClnJiZ9o0TWWfHZAzgrq27CxSoD0Rdple
         RWJiDOF/PZzHqeR8KM2MZH9Jf8ET7vFrxJoY1b5g=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 52B5C140A1C; Fri,  3 Aug 2018 10:32:52 -0300 (-03)
Date:   Fri, 3 Aug 2018 10:32:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hendrik Brueckner <brueckner@linux.ibm.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 1/3] perf auxtrace: Support for perf report -D for s390
Message-ID: <20180803133252.GE7996@kernel.org>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-2-tmricht@linux.ibm.com>
 <20180802124909.GB7996@kernel.org>
 <20180803100758.GA28475@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803100758.GA28475@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 03, 2018 at 12:07:58PM +0200, Hendrik Brueckner escreveu:
> Arnaldo,
> 
> On Thu, Aug 02, 2018 at 09:49:09AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Aug 02, 2018 at 09:46:20AM +0200, Thomas Richter escreveu:
> > > Add initial support for s390 auxiliary traces using the
> > > CPU-Measurement Sampling Facility.
> > 
> > Could you please provide one or two paragraphs explaining what is this
> > "CPU-Measurement Sampling Facility", in which hardware this is available
> > (all s/390 hardware has it? Just the 64-bit model(s)?) and provide a
> > public URL for people interested in further reading?
> 
> The CPU-Measurement Facility (CPU-MF) provides a set of functions to obtain
> performance information on the mainframe.  Basically, it was introduced
> with System z10 years ago for the z/Architecture, that means, 64-bit.
> For Linux, there are two facilities of interest, counter facility and sampling
> facility.  The counter facility provides hardware counters for instructions,
> cycles, crypto-activities, and many more.
> 
> The sampling facility is a hardware sampler that when started will write
> samples at a particular interval into a sampling buffer.  At some point,
> for example, if a sample block is full, it generates an interrupt to collect
> samples (while the sampler continues to run).
> 
> Few years ago, I started to provide the a perf PMU to use the counter
> and sampling facilities.  Recently, the device driver was updated to also
> "export" the sampling buffer into the AUX area.  Thomas now completed the
> related perf work to interpret and process these AUX data.
> 
> If people are more interested in the sampling facility, they can have a
> look into:
> 
> - The Load-Program-Parameter and the CPU-Measurement Facilities, SA23-2260-05
>   http://www-01.ibm.com/support/docview.wss?uid=isg26fcd1cc32246f4c8852574ce0044734a
> 
> and to learn how-to use it for Linux on Z, have look at chapter 54,
> "Using the CPU-measurement facilities" in the:
> 
> - Device Drivers, Features, and Commands, SC33-8411-34
>   http://public.dhe.ibm.com/software/dw/linux390/docu/l416dd34.pdf

-----------------------

Thanks a lot, I added this to the first commit, people investigating
this should be able to find that when doing research about the
implementation details.

- Arnaldo
