Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11842ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BA520685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Ubs5zPZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BA520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbeGWWVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:21:49 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38584 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388133AbeGWWVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:21:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8A7298EE18B;
        Mon, 23 Jul 2018 14:13:34 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uDYv0H0-iUpp; Mon, 23 Jul 2018 14:13:34 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1BD588EE0C3;
        Mon, 23 Jul 2018 14:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1532380414;
        bh=VBHRGfQGfqbW8oFivihL9Dvcfv9EKyehHthOUxuif+w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ubs5zPZ8xGPNFd2GUgFGKPMw1bvHFTb+2oPg2KS4A4OkIbc9lyVjCfvZAWs5SMA45
         JIzERLgPNEJkTTdyScX/A3FDlTiX2t3xfl5JIWKMA3tRVxlykYms3EAZ+rBt5j07ce
         IO0cOKly1gDLsNxdUdztqFMcNrFL+xXMh13ANW9U=
Message-ID: <1532380412.4112.22.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: add support for partial reads
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 Jul 2018 14:13:32 -0700
In-Reply-To: <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
         <20180723201956.GB26824@linux.intel.com>
         <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-23 at 13:53 -0700, Tadeusz Struk wrote:
> On 07/23/2018 01:19 PM, Jarkko Sakkinen wrote:
> > In this case I do not have any major evidence of any major benefit
> > *and* the change breaks the ABI.
> 
> As I said before - this does not break the ABI.

The current patch does, you even provided a use case in your last email
 (it's do command to get sizing followed by do command with correctly
sized buffer). 

However, if you tie it to O_NONBLOCK, it won't because no-one currently
opens the TPM device non blocking so it's an ABI conformant
discriminator of the uses.  Tying to O_NONBLOCK should be simple
because it's in file->f_flags.

James

