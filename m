Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859A3C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F552081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F552081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbeLGQuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:50:16 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:39774 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbeLGQuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:50:15 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 895E640009F;
        Fri,  7 Dec 2018 16:50:13 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Dec 2018 08:49:42 -0800
Subject: Re: [PATCH v2 0/4] Static calls
From:   Edward Cree <ecree@solarflare.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <0e96ac37-d5c5-86b6-833c-0de01ba18f0d@solarflare.com>
Message-ID: <188e9e90-ed8a-18d9-fc69-c208b80404f1@solarflare.com>
Date:   Fri, 7 Dec 2018 16:49:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <0e96ac37-d5c5-86b6-833c-0de01ba18f0d@solarflare.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24268.005
X-TM-AS-Result: No-3.620900-4.000000-10
X-TMASE-MatchedRID: 7ySqCuYCpfgOwH4pD14DsPHkpkyUphL92aYdnwn7qHcifM7JMNHW696M
        yUV+2+DZzXEUzvqkO8ahd5adCGkZGhIr2CZ2yHDIgZTbeFUhryEhHWssEmb8zkUNHQAoZf5c0JL
        YEuZmPHUOooaO+2ZHgNdLImwRoYjwNyl1nd9CIt2DGx/OQ1GV8mMVPzx/r2cb+gtHj7OwNO2Ohz
        Oa6g8KrcltHG1NG26gu5y8oEgIYHe6/GH5R/o0QFAB2ZAhkU59e9XBNUoc3/G+5QxbJXG8vwS9x
        e5wYKfGCI25swWdzFnsb5Ds7KVDcFPJBGEjehn+xfIRsEOHYJQiE3CyIkp0VAp6vLKoD5fOWTWZ
        GGyDOKY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.620900-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24268.005
X-MDID: 1544201414-Ql2z4z2bNj8m
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/18 16:06, Edward Cree wrote:
> Sorry if this has been pointed out before (it's a very long thread), but
>  in the out-of-line implementation, it appears that static_call_update()
>  never alters key->func.  Am I right in thinking that this should be
>  fixed by adding 'WRITE_ONCE(key->func, func);' just after the call to
>  arch_static_call_transform() on line 159 of include/linux/static_call.h?
On further examination, it's worse than that.

Why does the CONFIG_HAVE_STATIC_CALL_OUTLINE static_call_update() not
 call __static_call_update()?  It contains nothing but a BUILD_BUG_ON,
 which isn't likely to update anything.

-Ed
