Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE0EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DAD214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmDXdq1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DAD214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeIRAQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:16:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33597 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIRAQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:16:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so8102063pgc.0;
        Mon, 17 Sep 2018 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=etsqK6QSX1yfKY0D3Lv4z27XlyrJiBEA3GbCjQw4fmo=;
        b=HmDXdq1EoWnMKa5fIXsXfd2Sdbkxxo9vUKa55mGhndFc46LVFwEkx5Q9MZTA7YFASv
         ct9TxajuBur2jslC5PNyPVBRLPbJObwL896aD4gXARngYgEU1R734BQmDN1KYPGlId3X
         RQkUXbjJvrBxlBN2z+nSSQHeo7I+I0xWlVo62X7ndPkIfFtC7i5jOKjOL2UXofvYQaoU
         i07JobwaZMab9hRbWR8Jf0pIjOBvbf0Ko8nKA6OapjD5ZEZQQsJaKSZ0tuRtzcai26Xz
         mK/2Y8gCNJmKU125+TL3sN9NlfolOmdmTrm2rZZErF7dTEaEbpNcyJ4U7z925ArCtz0Q
         nt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=etsqK6QSX1yfKY0D3Lv4z27XlyrJiBEA3GbCjQw4fmo=;
        b=mkYPSck1goStvZFzQV+42dYFPzgWVQvb9xdst072p0947atyxABdNAgAVPo/lFSd/D
         8QFH86nDMeVc/4nyfoGIfXtHFy65npwxUn6JS0rtACgAhyHn1nEcjZT030S5AtenO6nv
         Mj1+5Oc39md4YZEwXdh6il+0y8qZzV5OCSas1q+f0XxgtlDRQyraaAeYYFPUbVw25C6V
         aEnXNYNLuef/0toh1rOdfEFXzWYsqN14543fMrJJ0ynQYiQx/Mt1PEMsNLda+6FapD1m
         rxdCxZsrwvCd/rbwxm1s1rjSprTR78LGrAb6G9scebtNgZg1glvKNw/Iyn6zYw+0htGQ
         +JpA==
X-Gm-Message-State: APzg51CrjiFkDYg0roN3Uxc7alutPAM6gLZoJ3vWPYZ+6/+mnZoN4Zn7
        eqMSEQ/vF2yqTuqt/B6scVpVTGUE
X-Google-Smtp-Source: ANB0VdaRU0LcojvqcOm7oJMNpeRYGNb7Y+K2adS3js5kYCKEmzgqAXsd8Q/rDHoJiup6+uHYJYve8g==
X-Received: by 2002:a62:71c4:: with SMTP id m187-v6mr27059433pfc.232.1537210091691;
        Mon, 17 Sep 2018 11:48:11 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 6-v6sm30542476pfr.115.2018.09.17.11.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 11:48:10 -0700 (PDT)
Date:   Mon, 17 Sep 2018 11:48:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
Message-ID: <20180917184809.GA16057@roeck-us.net>
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
 <fbf54ca6-16b3-5e35-eac8-b3dab8118543@linux.intel.com>
 <20180917163401.GA1082@kunai>
 <037b4cf8-5dfa-d554-b126-a2462ba9c803@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037b4cf8-5dfa-d554-b126-a2462ba9c803@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 10:16:59AM -0700, Jae Hyun Yoo wrote:
> On 9/17/2018 9:34 AM, Wolfram Sang wrote:
> >
> >>Looks good to me. Thanks! :)
> >>
> >>Acked-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> >
> >Does that mean I need to revert "[PATCH i2c-next v6] i2c: aspeed: Handle
> >master/slave combined irq events properly" in i2c/for-next? And apply
> >this to i2c/for-current?
> >
> 
> No need to revert "[PATCH i2c-next v6] i2c: aspeed: Handle master/slave
> combined irq events properly". This patch should be applied on top of
> the patch.
> 
Yes, sorry, I should have tagged the patch as for-next.

Guenter
