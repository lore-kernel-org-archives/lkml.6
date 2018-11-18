Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF1AC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30CA2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ycZvqg/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30CA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeKSJnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 04:43:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbeKSJnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 04:43:39 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E47220815;
        Sun, 18 Nov 2018 23:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542583318;
        bh=8bLbxwpovdoYOX+O2eS16D44bdJOgeBteNPJUV+hdwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ycZvqg/98/cFAX8/5i22O3M4J9vaqRdQH0zkxwMi908797RoX9viL74pSAAgCpRfq
         i095VR9KX24FznaNHoHGxQU/c1Nf+exGMTIaFpmFBe1Zl0Sory5uMSK7h3+FkcC8SO
         sIXWFcQVI8U9tGmyFObqMHRZfI5ryyhxOyprrDBc=
Date:   Sun, 18 Nov 2018 18:21:57 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 08/17] tpm: call tpm2_flush_space() on error in
 tpm_try_transmit()
Message-ID: <20181118232157.GA1711@sasha-vm>
References: <20181116123845.15705-1-jarkko.sakkinen@linux.intel.com>
 <20181116123845.15705-9-jarkko.sakkinen@linux.intel.com>
 <20181116161957.GG1706@sasha-vm>
 <20181118073618.GD5897@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181118073618.GD5897@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 09:36:18AM +0200, Jarkko Sakkinen wrote:
>On Fri, Nov 16, 2018 at 11:19:57AM -0500, Sasha Levin wrote:
>> On Fri, Nov 16, 2018 at 02:38:32PM +0200, Jarkko Sakkinen wrote:
>> > Always call tpm2_flush_space() on failure in tpm_try_transmit() so that
>> > the volatile memory of the TPM gets cleared. If /dev/tpm0 does not have
>> > sufficient permissions (usually it has), this could lead to the leakage
>> > of TPM objects. Through /dev/tpmrm0 this issue does not raise any new
>> > security concerns.
>> >
>> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>> > Cc: stable@vger.kernel.org
>> > Fixes: 745b361e989a ("tpm:tpm: infrastructure for TPM spaces")
>> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Hi Jarkko,
>>
>> This patch seems to depend on previous patches in this series, but those
>> were not tagged for stable. Do they also need to be backported? If so,
>> can you tag them as such?
>
>Hi
>
>Is that the preferred approach?
>
>I've usually followed this workflow:
>
>1. Mark patches with a fix to a regression with the fixes tag.
>2. If a merge conflict raises, I'll locate the deps.
>
>I've done it this way because often patches can depend on patches
>outside the patch set. Anyway, I'm open to change my workflow if
>that is required.
>
>/Jarkko

Hi Jarkko,

There's no "preferred" approach really. I try to warn about cases like
this early because the response rates to Greg's "FAILED" email seem to
be low - by the time they are sent out people are done with that code
and have moved on.

In this scenario, for exmaple, this patch would not apply to any stable
tree because it depends on a previous patch in this series that was not
tagged for stable. My hopes are that if I warn you about this early you
can work around this (for example, by marking that prior patch for
stable as well) so you won't need to deal with this patch again in a few
weeks.

There's no need to change anything about your flow if it works for you.

--
Thanks,
Sasha
