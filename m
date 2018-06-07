Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 49u3N4ZaGVsVEAAAmS7hNA
	; Thu, 07 Jun 2018 16:17:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E044F607E7; Thu,  7 Jun 2018 16:17:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQOKWitG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 453DD60590;
	Thu,  7 Jun 2018 16:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 453DD60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935321AbeFGQRL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932902AbeFGQRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:17:08 -0400
Received: from localhost (mobile-166-170-56-202.mycingular.net [166.170.56.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCFA9206B7;
        Thu,  7 Jun 2018 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528388228;
        bh=NqFThFgYS6FmyIWaa6j9DB9+936MyUdL+kxxr1H7hpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQOKWitGD1rjKro0v0WHTg0tf2ehs862ueDRNXhywdgD19xZWLWZDFt9+HPLghGV5
         LDjKRHXZha+Ab129D7rI1DAJ7FiYcoazlG53xkLSF6xx/eogTQpyxSjZESVIpCgWxw
         P0mQfg3tx8PTGbZjci86gK2g7hFhzapCFXyUaBls=
Date: Thu, 7 Jun 2018 18:16:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Sriram R <srirrama@codeaurora.org>, stable@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.4 08/56] ath10k: fix rfc1042 header retrieval in
 QCA4019 with eth decap mode
Message-ID: <20180607161640.GB15950@kroah.com>
References: <20180514064754.853201981@linuxfoundation.org>
 <20180514064755.718467503@linuxfoundation.org>
 <1528134761.2289.45.camel@codethink.co.uk>
 <133624c2c44831fd70edb18c01508f64@codeaurora.org>
 <1528386597.2289.75.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528386597.2289.75.camel@codethink.co.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 04:49:57PM +0100, Ben Hutchings wrote:
> On Thu, 2018-06-07 at 17:22 +0530, Sriram R wrote:
> > Hi Ben,
> > 
> > On 2018-06-04 23:22, Ben Hutchings wrote:
> > > On Mon, 2018-05-14 at 08:48 +0200, Greg Kroah-Hartman wrote:
> > > > 4.4-stable review patch.  If anyone has any objections, please let me 
> > > > know.
> > > > 
> > > > ------------------
> > > > 
> > > > From: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> > > > 
> > > > commit 2f38c3c01de945234d23dd163e3528ccb413066d upstream.
> > > > 
> > > > Chipset from QCA99X0 onwards (QCA99X0, QCA9984, QCA4019 & future)
> > > > rx_hdr_status is not padded to align in 4-byte boundary. Define a
> > > > new hw_params field to handle different alignment behaviour between
> > > > different hw. This patch fixes improper retrieval of rfc1042 header
> > > > with QCA4019. This patch along with "ath10k: Properly remove padding
> > > > from the start of rx payload" will fix traffic failure in ethernet
> > > > decap mode for QCA4019.
> > > > 
> > > > Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> > > > Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
> > > > Signed-off-by: Sriram R <srirrama@codeaurora.org>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > [...]
> > > 
> > > I'm curious as to why this backport doesn't include the change to
> > > ath10k_htt_rx_h_find_rfc1042().  I understand that the addition of the
> > > new field is a dependency for the following patch, but shouldn't the
> > > fix included in the upstream commit also be applied to 4.4?
> > > 
> > 
> >    Our main intention with this patchset [1] was to provide fix for 
> > replay detection security issue seen in ath10k driver which needed to be 
> > in the stable releases.
> > 
> > And, as per stable tree guidelines we wanted the patchset to have only 
> > one and this important fix .
> 
> OK, I think the problem here is that the rules say "must" when what's
> really meant is "should".  So the rule "It must fix only one thing."
> really means that commits that each make a single logical change are
> strongly preferred.
> 
> It does not mean that upstream commits should be trimmed down to
> conform to this.  Greg generally considers it more important to avoid
> changes to the upstream commit, where possible.  Right, Greg?
> 
> And speaking only for myself, I particularly dislike stable backports
> that are significantly different from the original upstream commit but
> don't mention this difference in the commit message.

I _STRONGLY_ dislike backports that are different than what is in
Linus's tree and normally I catch it when someone tries to do that.  I
missed this one here, and that's not ok on my part for missing that, and
for the authors part in doing that :(

So, what to do here, should I revert this series and take a fixed-up
one?  What exactly is the stable tree now missing because of this
mistake?

thanks,

greg k-h
