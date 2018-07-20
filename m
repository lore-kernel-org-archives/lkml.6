Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A1AECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A9820850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A9820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbeGTRWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:22:55 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37778 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387858AbeGTRWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:55 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fgYLd-0007He-FL; Fri, 20 Jul 2018 10:33:42 -0600
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-10-logang@deltatee.com>
 <20180615195152.GA25605@mobilestation>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <641e5245-9e77-7e8e-aa70-6c7e73636a22@deltatee.com>
Date:   Fri, 20 Jul 2018 10:33:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180615195152.GA25605@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shuah@kernel.org, Shyam-sundar.S-k@amd.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, fancer.lancer@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 8/8] NTB: ntb_test: Fix bug when counting remote files
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/18 01:51 PM, Serge Semin wrote:
> I also tested this script in the looped-back setup. It is the case when two
> NTB-device ports are available at the same RootComplex. So the NTB can be
> configured from the single executional context. In this case the REMOTE_HOST is left
> empty, so the colon is left prepended to the corresponding paths and causes multiple
> errors including the one fixed by this patch. In order to fix it, we need to discard
> the colon for remote-less case, for instance, by the next patch:
> 
> @@ -482,7 +495,11 @@ function perf_test()
>  function ntb_tool_tests()
>  {
>  	LOCAL_TOOL="$DEBUGFS/ntb_tool/$LOCAL_DEV"
> -	REMOTE_TOOL="$REMOTE_HOST:$DEBUGFS/ntb_tool/$REMOTE_DEV"
> +	if [[ "${REMOTE_HOST}" != "" ]]; then
> +		REMOTE_TOOL="$REMOTE_HOST:$DEBUGFS/ntb_tool/$REMOTE_DEV"
> +	else
> +		REMOTE_TOOL="$DEBUGFS/ntb_tool/$REMOTE_DEV"
> +	fi
>  
>  	echo "Starting ntb_tool tests..."
>  
> And so on for REMOTE_PP and REMOTE_PERF. It is necessary for NTB devices, which ports
> are looped-back to the same Root-Port. Would you be amenable if you resent this patch
> together with the fix I suggested?
I took a closer look at this and it's not necessary. (Note: I do the
majority of my testing in a looped-back setup).

What you didn't notice is that split_remote() separates the colon
whether there is a host or not. It's not passed to ssh or cat (or
whatever) directly. So the change you propose will actually break the
how it was designed.

Logan

