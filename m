Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MR1TNe1oHlvuLgAAmS7hNA
	; Mon, 11 Jun 2018 12:20:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3FA88607E4; Mon, 11 Jun 2018 12:20:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CA7F86074D;
	Mon, 11 Jun 2018 12:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA7F86074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbeFKMUe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:20:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:44399 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754010AbeFKMUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:20:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 481AAAED0;
        Mon, 11 Jun 2018 12:20:31 +0000 (UTC)
Date: Mon, 11 Jun 2018 14:20:30 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Zhouyang Jia <jiazhouyang09@gmail.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-ntrig: add error handling for
 sysfs_create_group
In-Reply-To: <1528707296-35785-1-git-send-email-jiazhouyang09@gmail.com>
Message-ID: <nycvar.YFH.7.76.1806111419480.6203@cbobk.fhfr.pm>
References: <1528707296-35785-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018, Zhouyang Jia wrote:

> When sysfs_create_group fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling sysfs_create_group.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/hid/hid-ntrig.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index 43b1c72..1e70dae 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -955,6 +955,10 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  	ret = sysfs_create_group(&hdev->dev.kobj,
>  			&ntrig_attribute_group);
> +	if (ret) {
> +		hid_err(hdev, "cannot create sysfs group\n");
> +		goto err_free;
> +	}

Is it really necessarily to bail out completely here and render the device 
dysfunctional? Issuing a warning about sysfs knobs being unavailable might 
be more appropriate.

Thanks,

-- 
Jiri Kosina
SUSE Labs
