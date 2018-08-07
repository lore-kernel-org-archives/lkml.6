Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7982FC4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338FA21A64
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 00:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="a/B9DVLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338FA21A64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbeHGCrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 22:47:25 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42422 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387623AbeHGCrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 22:47:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D2FFB8EE251;
        Mon,  6 Aug 2018 17:35:46 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wqlOHoc6D4SU; Mon,  6 Aug 2018 17:35:46 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4136C8EE02B;
        Mon,  6 Aug 2018 17:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1533602146;
        bh=v8aGMMrS2s3KViscON6oSEn9ighVIrIaKmkGJvfg49E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a/B9DVLTJX5hrQmDCg3GnKhi/sSMBY8WWcEeTUofvex1SWlWNbavrRwpAxB1AYNrc
         qA5exTn/9Yu7xv/NgzBeDCkGBT+9NEnMAoXdSXYfzGfYBupOOEWabnj5hWhiqZEu7e
         ZAcXwZShPLf/DIYWdeak+DbN4Sf/V1Cz+kYoIc/I=
Message-ID: <1533602145.3159.23.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Aug 2018 17:35:45 -0700
In-Reply-To: <1064594c-3a3f-4d2a-5d94-e8314b330292@intel.com>
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
         <153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
         <1533596748.3159.19.camel@HansenPartnership.com>
         <1064594c-3a3f-4d2a-5d94-e8314b330292@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 17:09 -0700, Tadeusz Struk wrote:
> On 08/06/2018 04:05 PM, James Bottomley wrote:
> > For an async interface, shouldn't I be able to queue an
> > arbitrary number of commands without blocking?
> 
> That was the approach in the v1 version of this patch, but
> Jason requested this to be changed so that only one command
> at a time can be processed.

He did?  I don't remember that.  I think he told you the TPM itself can
only process one operation at once so you didn't need an elaborate
allocation scheme.

But anyway, if you're happy to limit the interface to block after one
command is issued, how is it useful as an asynchronous interface?  I
thought the whole argument for the patch was to avoid the producer-
consumer approach which is possible with the current interface and to
use a fully event driven polling interface which can be implemented
single threaded.  If you can block in submission, this latter isn't
really possible because your interface isn't really asynchronous.

James

