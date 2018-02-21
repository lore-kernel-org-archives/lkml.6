Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeBUFcM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:32:12 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36631 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeBUFcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:32:11 -0500
X-Google-Smtp-Source: AH8x2276OvCqNpCxBNOxDydG/IAJoH5QaSHUTfGLb6Opwk+c3TFeWiCt5B5eDEfTzmFlrCvn3n9FJA==
Subject: Re: [PATCH v2 1/3] HID: add driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
References: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
 <20180220193306.28748-2-rodrigorivascosta@gmail.com>
From: Cameron Gutman <aicommander@gmail.com>
Message-ID: <eb75654d-cd83-83a4-edde-6492300e4948@gmail.com>
Date: Tue, 20 Feb 2018 21:32:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220193306.28748-2-rodrigorivascosta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2018 11:33 AM, Rodrigo Rivas Costa wrote:
> +static void steam_work_connect_cb(struct work_struct *work)
> +{
> +	struct steam_device *steam = container_of(work, struct steam_device,
> +							work_connect);
> +	unsigned long flags;
> +	bool connected;
> +	int ret;
> +
> +	spin_lock_irqsave(&steam->lock, flags);
> +	connected = steam->connected;
> +	spin_unlock_irqrestore(&steam->lock, flags);
> +
> +	if (connected) {
> +		if (steam->input) {
> +			dbg_hid("%s: already connected\n", __func__);
> +			return;
> +		}
> +		ret = steam_register(steam);
> +		if (ret) {
> +			hid_err(steam->hdev,
> +				"%s:steam_register failed with error %d\n",
> +				__func__, ret);
> +			return;
> +		}
> +	} else {
> +		steam_unregister(steam);

I think you need synchronization here. You don't want to be in the middle of
processing a HID event or power supply update and have your device freed out
from underneath you.

xpad uses RCU to avoid this race.

> +	}
> +}
> +

Regards,
Cameron
