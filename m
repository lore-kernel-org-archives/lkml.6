Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B466BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C6C20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544707598;
	bh=FSPT6FdCdx6F/u0KcpI/0VkpZb498tvGi970S0lOTh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tKPFJJBO15EC+jDn03PG8nAkDFVNPOuGnTLGaR3jkpFOytD3toqctsM1cGoV293Yi
	 91iOQ3IGVDJHcWRypLeSj3aOgV7orrWOeqrt7jrhbpYi0BgEyoINowP3BOj/++wHyq
	 Ermp2FqwaqyC0gN9V1+6PAQRAonuIjaYLznVFKTw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C6C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbeLMN0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:26:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbeLMN0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:26:36 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA732086D;
        Thu, 13 Dec 2018 13:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544707596;
        bh=FSPT6FdCdx6F/u0KcpI/0VkpZb498tvGi970S0lOTh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iz9ByEO/aEV1EqJk9Qpae5hj8CtUHXopaEsuvJdfUi/2BnGUYkfZhpu3Syqxpzxf1
         1aW2s4tcc1CYvTCQuouSjxxNTMksP7rqRKsxg0KR0ssuPgc5Qrv1rtvGKSiu2ReALf
         chPiVy1AicyFESoC9WBdqXs70cJkAY0jDZlvQmCU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B1B4E41B1D; Thu, 13 Dec 2018 10:26:33 -0300 (-03)
Date:   Thu, 13 Dec 2018 10:26:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     leo.yan@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>
Subject: Re: [PATCH v3 6/8] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Message-ID: <20181213132633.GJ21027@kernel.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
 <20181213123854.GE21027@kernel.org>
 <20181213124154.GF21027@kernel.org>
 <20181213130949.GB17663@leoy-ThinkPad-X240s>
 <20181213132126.GI21027@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213132126.GI21027@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 13, 2018 at 10:21:26AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Dec 13, 2018 at 09:09:49PM +0800, leo.yan@linaro.org escreveu:
> > Thanks a lot for helping.  If you prefer me to resend the patch set,
> > also let me know.
> 
> I can fix it, here.

Can I take a look at the result:

https://git.kernel.org/acme/c/222b0bead7e4

?

- Arnaldo
