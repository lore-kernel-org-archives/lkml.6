Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbeCTCgD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:36:03 -0400
Received: from mx.socionext.com ([202.248.49.38]:15573 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeCTCgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:36:01 -0400
From: "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>
To: "'Mark Brown'" <broonie@kernel.org>,
        =?iso-2022-jp?B?U3V6dWtpLCBLYXRzdWhpcm8vGyRCTmtMWhsoQiAbJEI+IUduGyhC?=
        <suzuki.katsuhiro@socionext.com>
Cc: <alsa-devel@alsa-project.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com> <20180314162609.GV2186@sirena.org.uk> <001101d3bf39$6e3933c0$4aab9b40$@socionext.com> <20180320011216.GN2186@sirena.org.uk>
In-Reply-To: <20180320011216.GN2186@sirena.org.uk>
Subject: Re: [PATCH] ASoC: uniphier: evea: add switch for changing source of line-in
Date: Tue, 20 Mar 2018 11:35:56 +0900
Message-ID: <001d01d3bff4$2cef92e0$86ceb8a0$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHTu5FuzEJuYhG2tk6R1XBNqubmsKPPVE6AgAdyUOCAAPxXAIAAnAaA
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, March 20, 2018 10:12 AM
> To: Suzuki, Katsuhiro <suzuki.katsuhiro@socionext.com>
> Cc: alsa-devel@alsa-project.org; Masami Hiramatsu
<masami.hiramatsu@linaro.org>;
> Jassi Brar <jaswinder.singh@linaro.org>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ASoC: uniphier: evea: add switch for changing source of
line-in
> 
> On Mon, Mar 19, 2018 at 01:19:10PM +0900, Katsuhiro Suzuki wrote:
> 
> > > I'll apply for now but this should really be a DAPM control so that we
> > > can power down things connected to the disconnected line inputs when
> > > recording.
> 
> > Thanks a lot for your suggestion. I tried to change the implementation to
DAPM
> > control as follows:
> 
> > I can see the value of ALINSW1 register at 'Line In 1 Mux',0 using
> >   amixer get 'Line In 1 Mux',0
> 
> > But I can't change the value.
> >   amixer set 'Line In 1 Mux',0 LIN2
> >   Simple mixer control 'Line In 1 Mux',0
> >     Capabilities: enum
> >     Items: 'LIN1' 'LIN2' 'LIN3'
> >     Item0: 'LIN1'
> 
> > Would you tell me what is wrong...
> 
> Ugh, I *have* run into that before but I can't remember what triggers it
> and your code doesn't have any mistakes I can spot.  Unfortunately I'm

Thank you for reviewing.


> at Linaro Connect this week and don't have a test system I can poke at
> with me to remind myself, and I'm still travelling next week
> unfortunately.
> 

I see, no problem. Have a nice trip!


> I'd add some trace to the set code path to make sure everything is being
> called as expected.  It's somemthing really small that's hard to make a
> warning for in the code IIRC.

I traced some DAPM codes. The 'get' function as follows:

int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
        struct snd_ctl_elem_value *ucontrol)
{
        //...

        mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
        if (e->reg != SND_SOC_NOPM && dapm_kcontrol_is_powered(kcontrol)) {
                int ret = soc_dapm_read(dapm, e->reg, &reg_val);

The soc_dapm_read() reads real value of register. It's simple.


But 'put' function is mysterious for me...

int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
        struct snd_ctl_elem_value *ucontrol)
{
        //...

        change = dapm_kcontrol_set_value(kcontrol, val);

        if (e->reg != SND_SOC_NOPM)
                reg_change = soc_dapm_test_bits(dapm, e->reg, mask, val);

dapm_kcontrol_set_value() has stored value into dapm_kcontrol_data. And 
soc_dapm_test_bits() has just checked value of a register and returned need 
update or not. It seems anyone does not update a register in this function.

I tried to change soc_dapm_test_bits() -> soc_dapm_update_bits(), so I can 
change value of register using amixer. But I feel this change was wrong. And I 
found dapm_seq_run_coalesced() calls soc_dapm_update_bits(). Unfortunately 
this function has not been called even if I run amixer.

Anyway, I'll continue to study about DAPM codes.


Regards,
--
Katsuhiro Suzuki
