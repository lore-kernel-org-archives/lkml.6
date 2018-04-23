Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932352AbeDWTAo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:00:44 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:38632 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbeDWTAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:00:42 -0400
Subject: Re: [PATCH 1/3] ASoC: tas6424: Allow disabling auto diagnostics for
 faster power-on
To: Mark Brown <broonie@kernel.org>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <dannenberg@ti.com>, <afd@ti.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
 <1524218684-19752-2-git-send-email-jjhiblot@ti.com>
 <20180423154411.GK19834@sirena.org.uk>
From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Message-ID: <d6a1c01b-7a9f-423f-d314-ff2e52aa9ab9@ti.com>
Date: Mon, 23 Apr 2018 21:00:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423154411.GK19834@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/2018 17:44, Mark Brown wrote:
> On Fri, Apr 20, 2018 at 12:04:42PM +0200, Jean-Jacques Hiblot wrote:
>> The TAS6424 incorporates both DC-load and AC-load diagnostics which are
>> used to determine the status of the load. The DC diagnostics runs when any
>> channel is directed to leave the Hi-Z state and enter the MUTE or PLAY
>> state.
>> The DC diagnostics are turned on by default but if a fast startup without
>> diagnostics is required the DC diagnostics can be bypassed by adding the
>> property "disable-auto-diagnostics".
> This is making me think we should be smarter here and either only run
> the diagnostics once during boot or provide a user control for the
> diagnostics.  It seems like something that is more of a runtime software
> decision than something that's fixed in hardware design, is there
> anything about the hardware design that'd make it impossible to run
> diagnostics?
I can't think of anything that would make it unusable.
This auto diagnostic is really useful in cars where wires can get 
disconnected or shorted to ground.
In quieter environment it may not be as useful, and a test at startup 
may be sufficient.
Diagnostics can also be triggered at will.
Do you think a sysfs interface would be better suited to disable the 
autodiag ?

Thanks for your comment on the series.

JJ

>
>> +	if (tas6424->no_auto_diags) {
>> +		/*
>> +		 * Disable DC auto-diagnostics to save time when channel leave
>> +		 * Hi-Z state
>> +		 */
>> +		ret = regmap_update_bits(tas6424->regmap,
>> +					 TAS6424_DC_DIAG_CTRL1,
>> +					  0xff, TAS6424_LDGBYPASS);
> This could just be exposed to userspace as a simple switch control
> couldn't it?  I do note that it masks more bits than it sets though...
