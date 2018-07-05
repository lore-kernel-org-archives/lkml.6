Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB11C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FE224053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FE224053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeGEQUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:20:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754044AbeGEQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:20:14 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 397A5C87;
        Thu,  5 Jul 2018 16:20:13 +0000 (UTC)
Date:   Thu, 5 Jul 2018 18:20:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Sriram R <srirrama@codeaurora.org>, stable@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.4 08/56] ath10k: fix rfc1042 header retrieval in
 QCA4019 with eth decap mode
Message-ID: <20180705162010.GA18499@kroah.com>
References: <20180514064754.853201981@linuxfoundation.org>
 <20180514064755.718467503@linuxfoundation.org>
 <1528134761.2289.45.camel@codethink.co.uk>
 <133624c2c44831fd70edb18c01508f64@codeaurora.org>
 <1528386597.2289.75.camel@codethink.co.uk>
 <20180607161640.GB15950@kroah.com>
 <1528389764.2289.77.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528389764.2289.77.camel@codethink.co.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 05:42:44PM +0100, Ben Hutchings wrote:
> On Thu, 2018-06-07 at 18:16 +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jun 07, 2018 at 04:49:57PM +0100, Ben Hutchings wrote:
> > > On Thu, 2018-06-07 at 17:22 +0530, Sriram R wrote:
> > > > Hi Ben,
> > > > 
> > > > On 2018-06-04 23:22, Ben Hutchings wrote:
> > > > > On Mon, 2018-05-14 at 08:48 +0200, Greg Kroah-Hartman wrote:
> > > > > > 4.4-stable review patch.  If anyone has any objections, please let me 
> > > > > > know.
> > > > > > 
> > > > > > ------------------
> > > > > > 
> > > > > > From: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> > > > > > 
> > > > > > commit 2f38c3c01de945234d23dd163e3528ccb413066d upstream.
> > > > > > 
> > > > > > Chipset from QCA99X0 onwards (QCA99X0, QCA9984, QCA4019 & future)
> > > > > > rx_hdr_status is not padded to align in 4-byte boundary. Define a
> > > > > > new hw_params field to handle different alignment behaviour between
> > > > > > different hw. This patch fixes improper retrieval of rfc1042 header
> > > > > > with QCA4019. This patch along with "ath10k: Properly remove padding
> > > > > > from the start of rx payload" will fix traffic failure in ethernet
> > > > > > decap mode for QCA4019.
> > > > > > 
> > > > > > Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> > > > > > Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
> > > > > > Signed-off-by: Sriram R <srirrama@codeaurora.org>
> > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > 
> > > > > [...]
> > > > > 
> > > > > I'm curious as to why this backport doesn't include the change to
> > > > > ath10k_htt_rx_h_find_rfc1042().  I understand that the addition of the
> > > > > new field is a dependency for the following patch, but shouldn't the
> > > > > fix included in the upstream commit also be applied to 4.4?
> > > > > 
> > > > 
> > > >    Our main intention with this patchset [1] was to provide fix for 
> > > > replay detection security issue seen in ath10k driver which needed to be 
> > > > in the stable releases.
> > > > 
> > > > And, as per stable tree guidelines we wanted the patchset to have only 
> > > > one and this important fix .
> > > 
> > > OK, I think the problem here is that the rules say "must" when what's
> > > really meant is "should".  So the rule "It must fix only one thing."
> > > really means that commits that each make a single logical change are
> > > strongly preferred.
> > > 
> > > It does not mean that upstream commits should be trimmed down to
> > > conform to this.  Greg generally considers it more important to avoid
> > > changes to the upstream commit, where possible.  Right, Greg?
> > > 
> > > And speaking only for myself, I particularly dislike stable backports
> > > that are significantly different from the original upstream commit but
> > > don't mention this difference in the commit message.
> > 
> > I _STRONGLY_ dislike backports that are different than what is in
> > Linus's tree and normally I catch it when someone tries to do that.  I
> > missed this one here, and that's not ok on my part for missing that, and
> > for the authors part in doing that :(
> > 
> > So, what to do here, should I revert this series and take a fixed-up
> > one?  What exactly is the stable tree now missing because of this
> > mistake?
> 
> If you apply the attached patch, that should complete the backporting
> of commit 2f38c3c01de9.  I'm not able to test the driver but the change
> looks reasonable and it builds OK.

Looks good, thanks for this, now queued up.

greg k-h
