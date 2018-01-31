Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeAaJZo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:25:44 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:32407 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeAaJZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:25:41 -0500
Subject: Re: [alsa-devel] [PATCH] sound/tlv320dac33: Add device tree support
To: Ladislav Michl <ladis@linux-mips.org>, Pavel Machek <pavel@ucw.cz>
CC: <mark.rutland@arm.com>, <alsa-devel@alsa-project.org>,
        <lgirdwood@gmail.com>, <tony@atomide.com>, <abcloriens@gmail.com>,
        <tiwai@suse.com>, <martijn@brixit.nl>,
        =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>,
        <patrikbachan@gmail.com>, <ivo.g.dimitrov.75@gmail.com>,
        <khilman@kernel.org>, <linux-omap@vger.kernel.org>, <serge@hallyn.com>,
        <devicetree@vger.kernel.org>, <pali.rohar@gmail.com>,
        <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <aaro.koskinen@iki.fi>, <linux-kernel@vger.kernel.org>,
        <broonie@kernel.org>, <clayton@craftyguy.net>,
        <sakari.ailus@linux.intel.com>, <sre@kernel.org>, <bhumirks@gmail.com>
References: <20180129230539.GA18280@amd> <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd> <20180130083446.GA13498@lenoch>
 <20180130085314.GA4585@amd> <1141b126-b883-a246-85ad-c5a69acb90bb@gmail.com>
 <20180130093838.GA15195@lenoch> <20180130100023.GB18104@amd>
 <20180130101046.GA16474@lenoch> <20180130103538.GD18104@amd>
 <20180130113829.GA18464@lenoch>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <571fedb5-0449-eb6f-04c5-e14252e055aa@ti.com>
Date: Wed, 31 Jan 2018 11:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180130113829.GA18464@lenoch>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-01-30 13:38, Ladislav Michl wrote:
> On Tue, Jan 30, 2018 at 11:35:38AM +0100, Pavel Machek wrote:
>> On Tue 2018-01-30 11:10:46, Ladislav Michl wrote:
>>> On Tue, Jan 30, 2018 at 11:00:23AM +0100, Pavel Machek wrote:
>>>> On Tue 2018-01-30 10:38:38, Ladislav Michl wrote:
>>>>> On Tue, Jan 30, 2018 at 10:11:02AM +0100, Filip Matijeviæ wrote:
>>>>>> Hi,
>>>>>>
>>>>
>>>>>>> Well, notice I'm converting existing driver to device tree. And that
>>>>>>> one already has GPIO dependency. It is possible that more work needs
>>>>>>> to be done there, but that should not be a reason to delay this. Feel
>>>>>>> free to help.
>>>>>
>>>>> Adding DT properties that need to be maintained for compatibility reasons
>>>>> is a bad idea and very good reason to delay merging unfinished stuff.
>>>>> And meanwhile it turned out it is not power-gpio :)
>>>>
>>>> I believe reset-gpios and power-gpios are commonly used like
>>>> this... and that's what the old code does.
>>>
>>> Why do you care about old code when introducing new DT property?
>>> Either it is reset, then lets call it reset-gpios or it is power supply
>>> and then voltage regulator should be used (VAUX4.OUT is such a regulator
>>> although it is unclear to me how it is controlled (*)).
>>
>> power gpio = !reset gpio. Difference is only in polarity.
> 
> Quick grep:
> Documentation/devicetree/bindings/net/smsc-lan91c111.txt
> - power-gpios: GPIO to control the PWRDWN pin
> - reset-gpios: GPIO to control the RESET pin
> Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
> - ti,power-gpio :     GPIO connected to chip's PMEN pin
> Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> - power-gpios             : Specification for the pin connected to the gsl1680's
>                             shutdown input. This needs to be driven high to take the
>                             gsl1680 out of its low power state
> Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
> - power-gpios             : GPIO specification for the pin connected to the
>                             ektf2127's wake input. This needs to be driven high
>                             to take ektf2127 out of it's low power state
> 
> As you can see others are using it to drive pins different from nRESET. As
> stated in datasheet:
> "The TLV320DAC32 requires a hardware reset after power-up for proper operation.
> After all power supplies are at their specified values, the nRESET pin must be
> driven low for at least 10ns. If this reset sequence is not performed, the DAC32
> may not respond properly to register reads/writes". That does not sound like
> anything to do with power.
> 
> (It seems the only difference between TLV320DAC33 and TLV320DAC32 is uses a ball
> grid array package vs QFN32)

Note that tlv320dac32 != tlv320dac33, they are not even register
compatible devices... dac33 was created _for_ Nokia back in the days and
as far as I know there is no publicly available documentation for dac33.

And yes, my pick to use power_gpio in the code was wrong, it should have
been named as reset_gpio.

> 
>>>> You are not helping.
>>>
>>> The only way I can help here is to resend your patch with "reset-gpios"
>>> used, which I'm pretty sure you can handle yourself.
>>
>> Well, you can do that, and then you can argue with the next person who
>> feels one of the properties has to get his preferred color. Hard part
>> is not changing code :-(.
> 
> Indeed, hard part is not to break DT compatibility later. Consider someone
> will have to add regulator support later, which you omitted to do - having
> both power supply and power gpio is a bit confusing, don't you think?
> 
> Anyway, time to stop arguing, feel free to do what you think is right, I do
> not have anything important to add :)
> 
> 	ladis
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
