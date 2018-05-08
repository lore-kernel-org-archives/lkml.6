Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932419AbeEHKA1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:00:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:63908 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932303AbeEHKAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:00:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,377,1520924400";
   d="gz'50?scan'50,208,50";a="197633322"
Date: Tue, 8 May 2018 18:00:05 +0800
From: kbuild test robot <lkp@intel.com>
To: Connor McAdams <conmanx360@gmail.com>
Cc: kbuild-all@01.org, o-takashi@sakamocchi.jp,
        Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?iso-8859-1?B?Suly6W15?= Lefaure <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/13] ALSA: hda/ca0132: add ca0132_alt_set_vipsource
Message-ID: <201805081505.JQAAuYjd%fengguang.wu@intel.com>
References: <1525746683-18535-13-git-send-email-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <1525746683-18535-13-git-send-email-conmanx360@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Connor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on sound/for-next]
[also build test ERROR on v4.17-rc4 next-20180507]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Connor-McAdams/ALSA-hda-ca0132-Patch-Series-for-Recon3Di-and-Sound-Blaster-Z-Support/20180508-144100
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: x86_64-randconfig-x012-201818 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the linux-review/Connor-McAdams/ALSA-hda-ca0132-Patch-Series-for-Recon3Di-and-Sound-Blaster-Z-Support/20180508-144100 HEAD 387bca1ff38f9c470b8965899c62b3bfc400ea88 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   sound/pci/hda/patch_ca0132.c: In function 'ca0132_alt_select_in':
>> sound/pci/hda/patch_ca0132.c:4210:2: error: implicit declaration of function 'ca0132_cvoice_switch_set'; did you mean 'ca0132_mic_boost_set'? [-Werror=implicit-function-declaration]
     ca0132_cvoice_switch_set(codec);
     ^~~~~~~~~~~~~~~~~~~~~~~~
     ca0132_mic_boost_set
   sound/pci/hda/patch_ca0132.c: At top level:
>> sound/pci/hda/patch_ca0132.c:4403:12: error: static declaration of 'ca0132_cvoice_switch_set' follows non-static declaration
    static int ca0132_cvoice_switch_set(struct hda_codec *codec)
               ^~~~~~~~~~~~~~~~~~~~~~~~
   sound/pci/hda/patch_ca0132.c:4210:2: note: previous implicit declaration of 'ca0132_cvoice_switch_set' was here
     ca0132_cvoice_switch_set(codec);
     ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +4210 sound/pci/hda/patch_ca0132.c

  4099	
  4100	/*
  4101	 * Select the active input.
  4102	 * Mic detection isn't used, because it's kind of pointless on the SBZ.
  4103	 * The front mic has no jack-detection, so the only way to switch to it
  4104	 * is to do it manually in alsamixer.
  4105	 */
  4106	static int ca0132_alt_select_in(struct hda_codec *codec)
  4107	{
  4108		struct ca0132_spec *spec = codec->spec;
  4109		unsigned int tmp;
  4110	
  4111		codec_dbg(codec, "%s\n", __func__);
  4112	
  4113		snd_hda_power_up_pm(codec);
  4114	
  4115		chipio_set_stream_control(codec, 0x03, 0);
  4116		chipio_set_stream_control(codec, 0x04, 0);
  4117	
  4118		spec->cur_mic_type = spec->in_enum_val;
  4119	
  4120		switch (spec->cur_mic_type) {
  4121		case REAR_MIC:
  4122			switch (spec->quirk) {
  4123			case QUIRK_SBZ:
  4124				writew(0x0000, spec->mem_base + 0x320);
  4125				tmp = FLOAT_THREE;
  4126				break;
  4127			case QUIRK_R3DI:
  4128				r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
  4129				tmp = FLOAT_ONE;
  4130				break;
  4131			default:
  4132				tmp = FLOAT_ONE;
  4133				break;
  4134			}
  4135	
  4136			chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
  4137			chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
  4138			if (spec->quirk == QUIRK_R3DI)
  4139				chipio_set_conn_rate(codec, 0x0F, SR_96_000);
  4140	
  4141			dspio_set_uint_param(codec, 0x80, 0x00, tmp);
  4142	
  4143			chipio_set_stream_control(codec, 0x03, 1);
  4144			chipio_set_stream_control(codec, 0x04, 1);
  4145	
  4146			if (spec->quirk == QUIRK_SBZ) {
  4147				chipio_write(codec, 0x18B098, 0x0000000C);
  4148				chipio_write(codec, 0x18B09C, 0x0000000C);
  4149			}
  4150			break;
  4151		case REAR_LINE_IN:
  4152			ca0132_mic_boost_set(codec, 0);
  4153			switch (spec->quirk) {
  4154			case QUIRK_SBZ:
  4155				writew(0x0000, spec->mem_base + 0x320);
  4156				break;
  4157			case QUIRK_R3DI:
  4158				r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
  4159				break;
  4160			}
  4161	
  4162			chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
  4163			chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
  4164			if (spec->quirk == QUIRK_R3DI)
  4165				chipio_set_conn_rate(codec, 0x0F, SR_96_000);
  4166	
  4167			tmp = FLOAT_ZERO;
  4168			dspio_set_uint_param(codec, 0x80, 0x00, tmp);
  4169	
  4170			if (spec->quirk == QUIRK_SBZ) {
  4171				chipio_write(codec, 0x18B098, 0x00000000);
  4172				chipio_write(codec, 0x18B09C, 0x00000000);
  4173			}
  4174	
  4175			chipio_set_stream_control(codec, 0x03, 1);
  4176			chipio_set_stream_control(codec, 0x04, 1);
  4177			break;
  4178		case FRONT_MIC:
  4179			switch (spec->quirk) {
  4180			case QUIRK_SBZ:
  4181				writew(0x0100, spec->mem_base + 0x320);
  4182				writew(0x0005, spec->mem_base + 0x320);
  4183				tmp = FLOAT_THREE;
  4184				break;
  4185			case QUIRK_R3DI:
  4186				r3di_gpio_mic_set(codec, R3DI_FRONT_MIC);
  4187				tmp = FLOAT_ONE;
  4188				break;
  4189			default:
  4190				tmp = FLOAT_ONE;
  4191				break;
  4192			}
  4193	
  4194			chipio_set_conn_rate(codec, MEM_CONNID_MICIN1, SR_96_000);
  4195			chipio_set_conn_rate(codec, MEM_CONNID_MICOUT1, SR_96_000);
  4196			if (spec->quirk == QUIRK_R3DI)
  4197				chipio_set_conn_rate(codec, 0x0F, SR_96_000);
  4198	
  4199			dspio_set_uint_param(codec, 0x80, 0x00, tmp);
  4200	
  4201			chipio_set_stream_control(codec, 0x03, 1);
  4202			chipio_set_stream_control(codec, 0x04, 1);
  4203	
  4204			if (spec->quirk == QUIRK_SBZ) {
  4205				chipio_write(codec, 0x18B098, 0x0000000C);
  4206				chipio_write(codec, 0x18B09C, 0x000000CC);
  4207			}
  4208			break;
  4209		}
> 4210		ca0132_cvoice_switch_set(codec);
  4211	
  4212		snd_hda_power_down_pm(codec);
  4213		return 0;
  4214	
  4215	}
  4216	
  4217	/*
  4218	 * Check if VNODE settings take effect immediately.
  4219	 */
  4220	static bool ca0132_is_vnode_effective(struct hda_codec *codec,
  4221					     hda_nid_t vnid,
  4222					     hda_nid_t *shared_nid)
  4223	{
  4224		struct ca0132_spec *spec = codec->spec;
  4225		hda_nid_t nid;
  4226	
  4227		switch (vnid) {
  4228		case VNID_SPK:
  4229			nid = spec->shared_out_nid;
  4230			break;
  4231		case VNID_MIC:
  4232			nid = spec->shared_mic_nid;
  4233			break;
  4234		default:
  4235			return false;
  4236		}
  4237	
  4238		if (shared_nid)
  4239			*shared_nid = nid;
  4240	
  4241		return true;
  4242	}
  4243	
  4244	/*
  4245	* The following functions are control change helpers.
  4246	* They return 0 if no changed.  Return 1 if changed.
  4247	*/
  4248	static int ca0132_voicefx_set(struct hda_codec *codec, int enable)
  4249	{
  4250		struct ca0132_spec *spec = codec->spec;
  4251		unsigned int tmp;
  4252	
  4253		/* based on CrystalVoice state to enable VoiceFX. */
  4254		if (enable) {
  4255			tmp = spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID] ?
  4256				FLOAT_ONE : FLOAT_ZERO;
  4257		} else {
  4258			tmp = FLOAT_ZERO;
  4259		}
  4260	
  4261		dspio_set_uint_param(codec, ca0132_voicefx.mid,
  4262				     ca0132_voicefx.reqs[0], tmp);
  4263	
  4264		return 1;
  4265	}
  4266	
  4267	/*
  4268	 * Set the effects parameters
  4269	 */
  4270	static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
  4271	{
  4272		struct ca0132_spec *spec = codec->spec;
  4273		unsigned int on, tmp;
  4274		int num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
  4275		int err = 0;
  4276		int idx = nid - EFFECT_START_NID;
  4277	
  4278		if ((idx < 0) || (idx >= num_fx))
  4279			return 0; /* no changed */
  4280	
  4281		/* for out effect, qualify with PE */
  4282		if ((nid >= OUT_EFFECT_START_NID) && (nid < OUT_EFFECT_END_NID)) {
  4283			/* if PE if off, turn off out effects. */
  4284			if (!spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
  4285				val = 0;
  4286		}
  4287	
  4288		/* for in effect, qualify with CrystalVoice */
  4289		if ((nid >= IN_EFFECT_START_NID) && (nid < IN_EFFECT_END_NID)) {
  4290			/* if CrystalVoice if off, turn off in effects. */
  4291			if (!spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID])
  4292				val = 0;
  4293	
  4294			/* Voice Focus applies to 2-ch Mic, Digital Mic */
  4295			if ((nid == VOICE_FOCUS) && (spec->cur_mic_type != DIGITAL_MIC))
  4296				val = 0;
  4297	
  4298			/* If Voice Focus on SBZ, set to two channel. */
  4299			if ((nid == VOICE_FOCUS) && (spec->quirk == QUIRK_SBZ)
  4300					&& (spec->cur_mic_type != REAR_LINE_IN)) {
  4301				if (spec->effects_switch[CRYSTAL_VOICE -
  4302							 EFFECT_START_NID]) {
  4303	
  4304					if (spec->effects_switch[VOICE_FOCUS -
  4305								 EFFECT_START_NID]) {
  4306						tmp = FLOAT_TWO;
  4307						val = 1;
  4308					} else
  4309						tmp = FLOAT_ONE;
  4310	
  4311					dspio_set_uint_param(codec, 0x80, 0x00, tmp);
  4312				}
  4313			}
  4314			/*
  4315			 * For SBZ noise reduction, there's an extra command
  4316			 * to module ID 0x47. No clue why.
  4317			 */
  4318			if ((nid == NOISE_REDUCTION) && (spec->quirk == QUIRK_SBZ)
  4319					&& (spec->cur_mic_type != REAR_LINE_IN)) {
  4320				if (spec->effects_switch[CRYSTAL_VOICE -
  4321							 EFFECT_START_NID]) {
  4322					if (spec->effects_switch[NOISE_REDUCTION -
  4323								 EFFECT_START_NID])
  4324						tmp = FLOAT_ONE;
  4325					else
  4326						tmp = FLOAT_ZERO;
  4327				} else
  4328					tmp = FLOAT_ZERO;
  4329	
  4330				dspio_set_uint_param(codec, 0x47, 0x00, tmp);
  4331			}
  4332	
  4333			/* If rear line in disable effects. */
  4334			if (spec->use_alt_functions &&
  4335					spec->in_enum_val == REAR_LINE_IN)
  4336				val = 0;
  4337		}
  4338	
  4339		codec_dbg(codec, "ca0132_effect_set: nid=0x%x, val=%ld\n",
  4340			    nid, val);
  4341	
  4342		on = (val == 0) ? FLOAT_ZERO : FLOAT_ONE;
  4343		err = dspio_set_uint_param(codec, ca0132_effects[idx].mid,
  4344					   ca0132_effects[idx].reqs[0], on);
  4345	
  4346		if (err < 0)
  4347			return 0; /* no changed */
  4348	
  4349		return 1;
  4350	}
  4351	
  4352	/*
  4353	 * Turn on/off Playback Enhancements
  4354	 */
  4355	static int ca0132_pe_switch_set(struct hda_codec *codec)
  4356	{
  4357		struct ca0132_spec *spec = codec->spec;
  4358		hda_nid_t nid;
  4359		int i, ret = 0;
  4360	
  4361		codec_dbg(codec, "ca0132_pe_switch_set: val=%ld\n",
  4362			    spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID]);
  4363	
  4364		if (spec->use_alt_functions)
  4365			ca0132_alt_select_out(codec);
  4366	
  4367		i = OUT_EFFECT_START_NID - EFFECT_START_NID;
  4368		nid = OUT_EFFECT_START_NID;
  4369		/* PE affects all out effects */
  4370		for (; nid < OUT_EFFECT_END_NID; nid++, i++)
  4371			ret |= ca0132_effects_set(codec, nid, spec->effects_switch[i]);
  4372	
  4373		return ret;
  4374	}
  4375	
  4376	/* Check if Mic1 is streaming, if so, stop streaming */
  4377	static int stop_mic1(struct hda_codec *codec)
  4378	{
  4379		struct ca0132_spec *spec = codec->spec;
  4380		unsigned int oldval = snd_hda_codec_read(codec, spec->adcs[0], 0,
  4381							 AC_VERB_GET_CONV, 0);
  4382		if (oldval != 0)
  4383			snd_hda_codec_write(codec, spec->adcs[0], 0,
  4384					    AC_VERB_SET_CHANNEL_STREAMID,
  4385					    0);
  4386		return oldval;
  4387	}
  4388	
  4389	/* Resume Mic1 streaming if it was stopped. */
  4390	static void resume_mic1(struct hda_codec *codec, unsigned int oldval)
  4391	{
  4392		struct ca0132_spec *spec = codec->spec;
  4393		/* Restore the previous stream and channel */
  4394		if (oldval != 0)
  4395			snd_hda_codec_write(codec, spec->adcs[0], 0,
  4396					    AC_VERB_SET_CHANNEL_STREAMID,
  4397					    oldval);
  4398	}
  4399	
  4400	/*
  4401	 * Turn on/off CrystalVoice
  4402	 */
> 4403	static int ca0132_cvoice_switch_set(struct hda_codec *codec)
  4404	{
  4405		struct ca0132_spec *spec = codec->spec;
  4406		hda_nid_t nid;
  4407		int i, ret = 0;
  4408		unsigned int oldval;
  4409	
  4410		codec_dbg(codec, "ca0132_cvoice_switch_set: val=%ld\n",
  4411			    spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID]);
  4412	
  4413		i = IN_EFFECT_START_NID - EFFECT_START_NID;
  4414		nid = IN_EFFECT_START_NID;
  4415		/* CrystalVoice affects all in effects */
  4416		for (; nid < IN_EFFECT_END_NID; nid++, i++)
  4417			ret |= ca0132_effects_set(codec, nid, spec->effects_switch[i]);
  4418	
  4419		/* including VoiceFX */
  4420		ret |= ca0132_voicefx_set(codec, (spec->voicefx_val ? 1 : 0));
  4421	
  4422		/* set correct vipsource */
  4423		oldval = stop_mic1(codec);
  4424		if (spec->use_alt_functions)
  4425			ret |= ca0132_alt_set_vipsource(codec, 1);
  4426		else
  4427			ret |= ca0132_set_vipsource(codec, 1);
  4428		resume_mic1(codec, oldval);
  4429		return ret;
  4430	}
  4431	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--OXfL5xGRrasGEqWY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
0ScqF63r5qX9Lrjh+T9ZbIEpiqQBAA==

--OXfL5xGRrasGEqWY--
