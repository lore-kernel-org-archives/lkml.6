Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF342C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5514F2064E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5514F2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeH1P6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:58:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:56746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbeH1P6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:58:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76098AF7E;
        Tue, 28 Aug 2018 12:06:47 +0000 (UTC)
Date:   Tue, 28 Aug 2018 14:06:46 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: input: fix leaking custom input node name
In-Reply-To: <20180828112955.11318-2-stefan@agner.ch>
Message-ID: <nycvar.YFH.7.76.1808281406360.25787@cbobk.fhfr.pm>
References: <20180828112955.11318-1-stefan@agner.ch> <20180828112955.11318-2-stefan@agner.ch>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Stefan Agner wrote:

> Make sure to free the custom input node name on disconnect.
> 
> Cc: stable@vger.kernel.org # v4.18+
> Fixes: c554bb045511 ("HID: input: append a suffix matching the application")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Found with kmemleak, after unplugging a Logitech Unifying receiver:
> 
> unreferenced object 0xc2345b80 (size 64):
>   comm "kworker/0:1", pid 20, jiffies 4294955181 (age 320.740s)
>   hex dump (first 32 bytes):
>     4c 6f 67 69 74 65 63 68 20 55 53 42 20 52 65 63  Logitech USB Rec
>     65 69 76 65 72 20 53 79 73 74 65 6d 20 43 6f 6e  eiver System Con
>   backtrace:
>     [<8fec5a71>] __kmalloc_track_caller+0x1dc/0x300
>     [<5b926275>] kvasprintf+0x60/0xcc
>     [<21fc360f>] kasprintf+0x38/0x54
>     [<3b6ce9f0>] hidinput_connect+0x23a8/0x4c60
>     [<deaab707>] hid_connect+0x30c/0x38c
>     [<5a28f7c9>] hid_hw_start+0x44/0x64
>     [<267d70e8>] hid_generic_probe+0x34/0x38
>     [<d68c31b1>] hid_device_probe+0xdc/0x13c
>     [<09414e91>] really_probe+0x1d8/0x2c4
>     [<f9d7157f>] driver_probe_device+0x68/0x184
>     [<1def17c8>] __device_attach_driver+0xa0/0xd4
>     [<d3b2081b>] bus_for_each_drv+0x60/0xc0
>     [<379d02f8>] __device_attach+0xdc/0x144
>     [<7026ace5>] device_initial_probe+0x14/0x18
>     [<44527d01>] bus_probe_device+0x90/0x98
>     [<cf58bf2f>] device_add+0x424/0x62c
> 
>  drivers/hid/hid-input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 4e94ea3e280a..ac201817a2dd 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1815,6 +1815,7 @@ void hidinput_disconnect(struct hid_device *hid)
>  			input_unregister_device(hidinput->input);
>  		else
>  			input_free_device(hidinput->input);
> +		kfree(hidinput->name);
>  		kfree(hidinput);

Applied for 4.19, thanks.

-- 
Jiri Kosina
SUSE Labs

