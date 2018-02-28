Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbeB1RTS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:19:18 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53285 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752887AbeB1RTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:19:14 -0500
X-ME-Sender: <xms:keSWWpdOBxtUoIV5amNYK9bjCrVZZ3KRe3SVoz3zGbBGLBwTlRSqQg>
Subject: Re: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-4-samuel@sholland.org>
 <20180228083214.h4oi2kmjjqmoyfhn@flea>
From: Samuel Holland <samuel@sholland.org>
Message-ID: <fdf86770-6f45-3b3c-50ea-7a8363894639@sholland.org>
Date: Wed, 28 Feb 2018 11:19:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180228083214.h4oi2kmjjqmoyfhn@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/28/18 02:32, Maxime Ripard wrote:
> On Tue, Feb 27, 2018 at 08:27:14PM -0600, Samuel Holland wrote:
>> +	/*
>> +	 * The failure path should not disable the clock or assert the reset,
>> +	 * because the PSCI implementation in firmware relies on this device
>> +	 * being functional. Claiming the clock in this driver is required to
>> +	 * prevent Linux from turning it off.
>> +	 */
>> +	ret = clk_prepare_enable(clk);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable bus clock: %d\n", ret);
>> +		return ret;
>> +	}
> 
> You don't need it to be always on though. You only need it to be
> enabled when you access the registers (on both sides I guess?). So you
> could very well enable the clock in your registers accessors in Linux,
> and do the same in the ARISC firmware. That should work.

It does need to always be on because the *PSCI* implementation (ATF) also uses
SCPI concurrently with Linux (on a separate channel). Turning off the clock
anywhere in Linux could turn it off in the middle of a PSCI SCPI call on a
different CPU, causing ATF to hang in EL3 (which would be very bad).

> Maxime

Regards,
Samuel
