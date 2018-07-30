Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028E913F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81E620870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81E620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=apache.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeG3PrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:47:04 -0400
Received: from hermes.apache.org ([140.211.11.3]:37587 "HELO mail.apache.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726740AbeG3PrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:47:04 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2018 11:47:04 EDT
Received: (qmail 56131 invoked by uid 99); 30 Jul 2018 14:05:13 -0000
Received: from mail-relay.apache.org (HELO mailrelay2-lw-us.apache.org) (207.244.88.137)
    by apache.org (qpsmtpd/0.29) with ESMTP; Mon, 30 Jul 2018 14:05:13 +0000
Received: from rombert.eur.adobe.com (unknown [192.147.117.11])
        by mailrelay2-lw-us.apache.org (ASF Mail Server at mailrelay2-lw-us.apache.org) with ESMTPSA id 5234C23D;
        Mon, 30 Jul 2018 14:05:11 +0000 (UTC)
Message-ID: <6330995a9313ade9196cadb2e3696d53d4ef9aa8.camel@apache.org>
Subject: Re: [PATCH 1/2] HID: redragon: Fix regression in non-Redragon
 keyboard due to this new driver
From:   Robert Munteanu <rombert@apache.org>
To:     John S Gruber <JohnSGruber@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 30 Jul 2018 16:05:09 +0200
In-Reply-To: <CAPotdmT-zCVL=hoV0y83bbksTQ3AWsCybzisL8B6n-OB-M645g@mail.gmail.com>
References: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
         <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com>
         <CAPotdmT-zCVL=hoV0y83bbksTQ3AWsCybzisL8B6n-OB-M645g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Sat, 2018-07-28 at 15:53 -0400, John S Gruber wrote:
> The Redragon keyboard uses the second device being presented, but
> other
> devices with the same vendor_id/device_id pair (0x0c45:760b) use the
> first.
> Don't cause its deletion. Problem introduced in commit 85455dd906d5
> ("HID: redragon: Fix modifier keys for Redragon Asura Keyboard")
> 
> Fixes: 85455dd906d5
> Signed-off-by: John S Gruber <JohnSGruber@gmail.com>
> ---
>  drivers/hid/hid-redragon.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-redragon.c b/drivers/hid/hid-redragon.c
> index daf5957..85a5fbb 100644
> --- a/drivers/hid/hid-redragon.c
> +++ b/drivers/hid/hid-redragon.c
> @@ -55,10 +55,6 @@ static int redragon_probe(struct hid_device *dev,
>  		return ret;
>  	}
> 
> -	/* do not register unused input device */
> -	if (dev->maxapplication == 1)
> -		return 0;
> -
>  	ret = hid_hw_start(dev, HID_CONNECT_DEFAULT);
>  	if (ret) {
>  		hid_err(dev, "hw start failed\n");

As I mentioned, this is already fixed by
dc9b8e85ed95cbe7e3ad0eabb5b48d617bbc365e, scheduled for 4.19, and I
suggest that we instead add that one to 4.18.

The explanation is that the block you deleted was the whole reason for
adding the redragon_probe function, so the changes are largely
equivalent.

Thanks,

Robert

