Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id v6FSJaRTGVt6HwAAmS7hNA
	; Thu, 07 Jun 2018 15:50:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B8B556089E; Thu,  7 Jun 2018 15:50:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2DBF360590;
	Thu,  7 Jun 2018 15:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DBF360590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934508AbeFGPuC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:50:02 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36520 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933302AbeFGPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:50:00 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fQxAj-0006oX-MA; Thu, 07 Jun 2018 16:49:57 +0100
Message-ID: <1528386597.2289.75.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 08/56] ath10k: fix rfc1042 header retrieval in
 QCA4019 with eth decap mode
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Sriram R <srirrama@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        linux-kernel@vger.kernel.org
Date: Thu, 07 Jun 2018 16:49:57 +0100
In-Reply-To: <133624c2c44831fd70edb18c01508f64@codeaurora.org>
References: <20180514064754.853201981@linuxfoundation.org>
         <20180514064755.718467503@linuxfoundation.org>
         <1528134761.2289.45.camel@codethink.co.uk>
         <133624c2c44831fd70edb18c01508f64@codeaurora.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-07 at 17:22 +0530, Sriram R wrote:
> Hi Ben,
> 
> On 2018-06-04 23:22, Ben Hutchings wrote:
> > On Mon, 2018-05-14 at 08:48 +0200, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me 
> > > know.
> > > 
> > > ------------------
> > > 
> > > From: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> > > 
> > > commit 2f38c3c01de945234d23dd163e3528ccb413066d upstream.
> > > 
> > > Chipset from QCA99X0 onwards (QCA99X0, QCA9984, QCA4019 & future)
> > > rx_hdr_status is not padded to align in 4-byte boundary. Define a
> > > new hw_params field to handle different alignment behaviour between
> > > different hw. This patch fixes improper retrieval of rfc1042 header
> > > with QCA4019. This patch along with "ath10k: Properly remove padding
> > > from the start of rx payload" will fix traffic failure in ethernet
> > > decap mode for QCA4019.
> > > 
> > > Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> > > Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
> > > Signed-off-by: Sriram R <srirrama@codeaurora.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > [...]
> > 
> > I'm curious as to why this backport doesn't include the change to
> > ath10k_htt_rx_h_find_rfc1042().  I understand that the addition of the
> > new field is a dependency for the following patch, but shouldn't the
> > fix included in the upstream commit also be applied to 4.4?
> > 
> 
>    Our main intention with this patchset [1] was to provide fix for 
> replay detection security issue seen in ath10k driver which needed to be 
> in the stable releases.
> 
> And, as per stable tree guidelines we wanted the patchset to have only 
> one and this important fix .

OK, I think the problem here is that the rules say "must" when what's
really meant is "should".  So the rule "It must fix only one thing."
really means that commits that each make a single logical change are
strongly preferred.

It does not mean that upstream commits should be trimmed down to
conform to this.  Greg generally considers it more important to avoid
changes to the upstream commit, where possible.  Right, Greg?

And speaking only for myself, I particularly dislike stable backports
that are significantly different from the original upstream commit but
don't mention this difference in the commit message.

Ben.

> Also we felt the change in ath10k_htt_rx_h_find_rfc1042() is currently 
> not  a must-have fix in 4.4 stable tree .
> 
> [1]
> https://patchwork.kernel.org/patch/10370863/
> https://patchwork.kernel.org/patch/10370865/
> 
> Thanks and Regards,
> Sriram.R
> 
> > Ben.
> 
> 
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
