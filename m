Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D83C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2572083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2572083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbeHATzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:55:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbeHATzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:55:18 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B2BFCBA;
        Wed,  1 Aug 2018 18:08:22 +0000 (UTC)
Date:   Wed, 1 Aug 2018 20:08:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Bornyakov <brnkv.i1@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        benchan@chromium.org, jnjoseph@google.com, rspringer@google.com
Subject: Re: [PATCH] staging: gasket: sysfs: fix potential null dereference
Message-ID: <20180801180807.GA31510@kroah.com>
References: <20180731152320.11575-1-brnkv.i1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731152320.11575-1-brnkv.i1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 06:23:20PM +0300, Ivan Bornyakov wrote:
> Add handling of possible allocation failure.
> 
> Reported by smatch:
> 
>   drivers/staging/gasket/gasket_sysfs.c:105 put_mapping() error: potential null dereference 'files_to_remove'. (kcalloc returns null)
> 
> Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
> ---
>  drivers/staging/gasket/gasket_sysfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
> index ef4eca02afa6..682e5c21f203 100644
> --- a/drivers/staging/gasket/gasket_sysfs.c
> +++ b/drivers/staging/gasket/gasket_sysfs.c
> @@ -101,6 +101,12 @@ static void put_mapping(struct gasket_sysfs_mapping *mapping)
>  		files_to_remove = kcalloc(num_files_to_remove,
>  					  sizeof(*files_to_remove),
>  					  GFP_KERNEL);
> +		if (!files_to_remove) {
> +			pr_err("%s: can't allocate memory\n", __func__);

kcalloc failing will print something, no need to do it again here.

thanks,

greg k-h
