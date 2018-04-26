Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754404AbeDZIQW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:16:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:48166 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752419AbeDZIQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:16:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="gz'50?scan'50,208,50";a="219505595"
Date: Thu, 26 Apr 2018 16:15:32 +0800
From: kbuild test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: kbuild-all@01.org, perex@perex.cz, tiwai@suse.com, arnd@arndb.de,
        baolin.wang@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        o-takashi@sakamocchi.jp, mingo@kernel.org,
        elfring@users.sourceforge.net, dan.carpenter@oracle.com,
        jeeja.kp@intel.com, vinod.koul@intel.com, guneshwor.o.singh@intel.com,
        subhransu.s.prusty@intel.com, bhumirks@gmail.com,
        gudishax.kranthikumar@intel.com, naveen.m@intel.com,
        hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com, fabf@skynet.be,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] ALSA: Replace timespec with timespec64
Message-ID: <201804261345.1lsWsCDl%fengguang.wu@intel.com>
References: <7373ade7cb5a8d6a5fca07e78cf992ba7372bd7f.1524570852.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <7373ade7cb5a8d6a5fca07e78cf992ba7372bd7f.1524570852.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baolin,

I love your patch! Yet something to improve:

[auto build test ERROR on v4.17-rc2]
[also build test ERROR on next-20180424]
[cannot apply to sound/for-next asoc/for-next arm-soc/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Fix-year-2038-issue-for-sound-subsystem/20180426-010145
config: sh-ecovec24_defconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

Note: the linux-review/Baolin-Wang/Fix-year-2038-issue-for-sound-subsystem/20180426-010145 HEAD 53cdcc389f07bdd923be240cdb746a97de063301 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   sound/core/pcm_lib.c: In function 'update_audio_tstamp':
>> sound/core/pcm_lib.c:256:54: error: passing argument 2 of 'timespec_equal' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (!timespec_equal(&runtime->status->audio_tstamp, audio_tstamp)) {
                                                         ^~~~~~~~~~~~
   In file included from include/linux/time.h:73:0,
                    from include/linux/ktime.h:24,
                    from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:16,
                    from include/linux/memory_hotplug.h:7,
                    from include/linux/mmzone.h:777,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from sound/core/pcm_lib.c:23:
   include/linux/time32.h:59:19: note: expected 'const struct timespec *' but argument is of type 'struct timespec64 *'
    static inline int timespec_equal(const struct timespec *a,
                      ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/timespec_equal +256 sound/core/pcm_lib.c

^1da177e Linus Torvalds       2005-04-16  222  
3179f620 Pierre-Louis Bossart 2015-02-13  223  static void update_audio_tstamp(struct snd_pcm_substream *substream,
ac8bbfea Baolin Wang          2018-04-24  224  				struct timespec64 *curr_tstamp,
ac8bbfea Baolin Wang          2018-04-24  225  				struct timespec64 *audio_tstamp)
3179f620 Pierre-Louis Bossart 2015-02-13  226  {
3179f620 Pierre-Louis Bossart 2015-02-13  227  	struct snd_pcm_runtime *runtime = substream->runtime;
3179f620 Pierre-Louis Bossart 2015-02-13  228  	u64 audio_frames, audio_nsecs;
ac8bbfea Baolin Wang          2018-04-24  229  	struct timespec64 driver_tstamp;
3179f620 Pierre-Louis Bossart 2015-02-13  230  
3179f620 Pierre-Louis Bossart 2015-02-13  231  	if (runtime->tstamp_mode != SNDRV_PCM_TSTAMP_ENABLE)
3179f620 Pierre-Louis Bossart 2015-02-13  232  		return;
3179f620 Pierre-Louis Bossart 2015-02-13  233  
3179f620 Pierre-Louis Bossart 2015-02-13  234  	if (!(substream->ops->get_time_info) ||
3179f620 Pierre-Louis Bossart 2015-02-13  235  		(runtime->audio_tstamp_report.actual_type ==
3179f620 Pierre-Louis Bossart 2015-02-13  236  			SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT)) {
3179f620 Pierre-Louis Bossart 2015-02-13  237  
3179f620 Pierre-Louis Bossart 2015-02-13  238  		/*
3179f620 Pierre-Louis Bossart 2015-02-13  239  		 * provide audio timestamp derived from pointer position
3179f620 Pierre-Louis Bossart 2015-02-13  240  		 * add delay only if requested
3179f620 Pierre-Louis Bossart 2015-02-13  241  		 */
3179f620 Pierre-Louis Bossart 2015-02-13  242  
3179f620 Pierre-Louis Bossart 2015-02-13  243  		audio_frames = runtime->hw_ptr_wrap + runtime->status->hw_ptr;
3179f620 Pierre-Louis Bossart 2015-02-13  244  
3179f620 Pierre-Louis Bossart 2015-02-13  245  		if (runtime->audio_tstamp_config.report_delay) {
3179f620 Pierre-Louis Bossart 2015-02-13  246  			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
3179f620 Pierre-Louis Bossart 2015-02-13  247  				audio_frames -=  runtime->delay;
3179f620 Pierre-Louis Bossart 2015-02-13  248  			else
3179f620 Pierre-Louis Bossart 2015-02-13  249  				audio_frames +=  runtime->delay;
3179f620 Pierre-Louis Bossart 2015-02-13  250  		}
3179f620 Pierre-Louis Bossart 2015-02-13  251  		audio_nsecs = div_u64(audio_frames * 1000000000LL,
3179f620 Pierre-Louis Bossart 2015-02-13  252  				runtime->rate);
ac8bbfea Baolin Wang          2018-04-24  253  		*audio_tstamp = ns_to_timespec64(audio_nsecs);
3179f620 Pierre-Louis Bossart 2015-02-13  254  	}
ac8bbfea Baolin Wang          2018-04-24  255  
20e3f985 Henrik Eriksson      2017-11-21 @256  	if (!timespec_equal(&runtime->status->audio_tstamp, audio_tstamp)) {
ac8bbfea Baolin Wang          2018-04-24  257  		runtime->status->audio_tstamp =
ac8bbfea Baolin Wang          2018-04-24  258  			timespec64_to_timespec(*audio_tstamp);
ac8bbfea Baolin Wang          2018-04-24  259  		runtime->status->tstamp = timespec64_to_timespec(*curr_tstamp);
20e3f985 Henrik Eriksson      2017-11-21  260  	}
3179f620 Pierre-Louis Bossart 2015-02-13  261  
ac8bbfea Baolin Wang          2018-04-24  262  
3179f620 Pierre-Louis Bossart 2015-02-13  263  	/*
3179f620 Pierre-Louis Bossart 2015-02-13  264  	 * re-take a driver timestamp to let apps detect if the reference tstamp
3179f620 Pierre-Louis Bossart 2015-02-13  265  	 * read by low-level hardware was provided with a delay
3179f620 Pierre-Louis Bossart 2015-02-13  266  	 */
ac8bbfea Baolin Wang          2018-04-24  267  	snd_pcm_gettime(substream->runtime, &driver_tstamp);
3179f620 Pierre-Louis Bossart 2015-02-13  268  	runtime->driver_tstamp = driver_tstamp;
3179f620 Pierre-Louis Bossart 2015-02-13  269  }
3179f620 Pierre-Louis Bossart 2015-02-13  270  

:::::: The code at line 256 was first introduced by commit
:::::: 20e3f985bb875fea4f86b04eba4b6cc29bfd6b71 ALSA: pcm: update tstamp only if audio_tstamp changed

:::::: TO: Henrik Eriksson <henrik.eriksson@axis.com>
:::::: CC: Takashi Iwai <tiwai@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--YiEDa0DAkWCtVeE4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICD1Z4VoAAy5jb25maWcAjBxrb9u29vt+hdABFxuwronzxkU+UBRlcdaromQ7+SK4jtoY
Texc29nWf3/PoSSLlEjXA9bEPIfP8344v/7yq0Pe95vXxX61XLy8/HC+Vetqu9hXT87X1Uv1
X8dLnDjJHebx/E9ADlfr938/7Z6dyz/Pb/48+7hdjpxJtV1XLw7drL+uvr3D5NVm/cuvv9Ak
9vm4FEXKsuD+h/75YtSNkIwGpcf8+uP9h8V2+QxbfFrKBXfw678X5VP1tf78oZ2WzQSLyjGL
WcZpKVIehwmddMu2ELcYDweDGePjIO8dQhQiZbFXpokQ3A1ZDxxwl2UxyXkSG1DEg8DLpUmW
izIoxiwPXV8o8JzQSZ4Rylq0DoYn91g6BMRJyRMcKiOSdsNeRAAU0yRgGYtVfMY8CQV03DFn
PZioJ4csHucKVdJxTuA2MD5lobi/aMd59rmcJRk+K5D0V2cs2ePF2VX797eOyG6WTFhcwruI
SDkmj3lesngKzwd35BHP7y9GLZBm8IQlTaKUwzN++ACrt5B6rMyZyJ3Vzllv9rih8lgknLJM
AB20eSqgJEWeGCYHZMrKCZCRheX4kSuHVSEuQEZmUPgYETNk/mibkXQAfevD0dV91VP3EXD3
Y/D54/HZpicB0SNFmJdBIvKYRECL39abdfX7QdLETOU94PMpT+lgAH/SPFRvBULC52X0uWAF
M2xcc0DEoiR7KEkO8hGoswvBQu4a70MK0Ec26kpZlRh4IhKGLfMCMzu79y+7H7t99doxb0Qe
6okiJZlgyPNDhYGCIIJkpjA3jHhJRHisj/lJRkHQ8iBjxOOxony09Q93UXfwGGgrXxhu1mJR
VBUgpHEu2mvlq9dquzPdLHgsQdnyxONU3RGUCkC4FzLj40qwERKAziwzJsqcRyBmKo48CU2L
T/li993Zw5GcxfrJ2e0X+52zWC437+v9av2tO1vO6aSECSWhNCniXHspV4ASzhLKgD8Anqun
78PK6YXxsDkRE9SAw2NmtHDE8LXSjLEozUsAq/vBx5LN4R1NDCdq5HZLWKE/hKcotSFcEA4W
hqjooiTWIbWWZmPqhlxoF+eT+hejSoR3KXzgUO7n9+eX3ZV4nE9KQXzWx7noc5agAexMGyPa
KeNxlhSpiSVRVwBLAyG6GxRg+2LlM+oF+VmV6gyGDOul3NPmxizvza2PiJpdHspIdpB5X4Ag
ATUpmD/PiJSxkDwYIW44gclTaboyz6S0aJmkwP/8kaGoo4DBj4jElGnP1kMT8IuJf1qd2So2
sOqwd+KpjyqVU8G982tFQlJf3c7KoL1pESh6jiRQtBJ4KhFwadlpS+0pB8N+QGJP9XxqNV/r
BGVU8l7/cxlHXLmF6pux0AeJyJSFXQLq0i+0zYuczXsfgXN6j1UP0yid00DdIU20+/FxTELf
U6QV76AOSE2rDogA7JVCL67YduJNORy4eTDlKWCKS7KMq88+QZSHSAxH6msji+Z8qjEVEL1d
3ci8SFhpy30z28MxmOcxE1vLZ0NeLg/GpaUbDsLK5TSCfRPamp3G7U+r7dfN9nWxXlYO+7ta
g7onoPgpKnwwS4p6NS0+jeqhUtoAjX/QCyQ5uJYKD4mQuJpCCAvXJFWABo+ejVnr3OiTAOqD
qkYFW2bAzElkfC6wMj4PwTDZ3iupMTQaTWDMZSb9VvuENbjvKWYsNwI0aem8GxlGBEliCHfA
AZemvXFADJ4MAlEQwMrkRd8BztgYzCrEQDJcQQMr7exAwmg46Y1gWAF4tQ/TgwUzoCMjkzTh
arQiYRGfg1LvwEKeoR96NY9Rm7KBYEucGQE+QoNTu1lthNA7N61vBq+dM5onWU9p60AMssxO
0hAVTl2EJDsRW+RZYmSsISraO0WXJF4RgguGEokaE/VEB01CD9VaE8gOxgnNtSdB/wvcPeb7
nHIUQ9/XDG6GUXmB44WucupgkCbTj18Wu+rJ+V4rg7ft5uvqpfbzOgcX0JoIxHDfhryiRmsE
qtQMjiRcy77IZsO4FwNk1PmqAEk1KlBp3Z/1Xk+9Yz1Uu+3gJBGTdmxwihjh1sk12MgAgNfw
o7DBcR3wHQ/xq0XHt5i6H9gHo/IER928WZ7xCA4LHOSVE7Q41huL2qUNQdOomsLVMy2h6xFf
hYIvQQUH7oHIT/dhW/fKFebjK3Bb7Nd5aDkbZzw/7sc9ggCbSYIYNPJAv7NaY5hFF9Fmrsm1
qrcAZVfqQiPvD0+bpGQoM+liu19hhszJf7xVO1VO4BA5l8klcCTQnzRyovAS0aEqnorPteE6
4k0csXyunt5fNFPMk9qTjpNEzdY0ox6YDXyVIYT6WuTaJg7aCUdyC5aZeIAjs5p97z8sv/7v
kI2IPh85qQKcPLhM0+4twPU/mxzlmMeSFzCTKEVZZXF0Fx7lcvJdhQwdnT2QsHtVVKYiuNS1
KwyQ/si8n/wEpzJxuepSIyIqxTTSYlE5v3DzhxTOGdxcn9+ZzY2C9pc5n9RbaXR2fhqaOdYe
oF2fhHZ92mrXl6eh/fwxorlZ7fSWujm7Og3tpGvenN2chnZ7GtrPr4lo52enoZ3EHkDR09BO
4qKbq5NWO7s7dTWL0zXAM5vDAd6J256ftu31KZe9LEdnJ1LiwqC8BkiXR7TGzcVJ8nRzdRrb
nibEwLcnod2eiHaagN6eIqDzky5wcXnaPUcnkfHiWjuZNCpR9brZ/nAglF58q14hknY2b+gp
KIb7c8HppMkLthYvUlKLKYGQNwEnnuX3Z//entX/HYyY9FIjMpdeUZJ5YNDOD/WYJg8PwUeG
k89u9cktmD8ygJ73lh7duVxz9NLIFJjPR3noKtH/ILckzaEfkhy2K1lMhkW4Ool+AriL/DU4
CyGqam8DXi4LVT8nY1g48zEkVZKaMSXScwBYquWp5Xvjk5SXEy0x0QFuJ2Y3tsO4vpwYkxjH
Tto+UUTigmg1l+4Baphh5WayvlqJSceynqdWew7LYS6dK2WfOnhnUS8Y0IabRdUF62ovB7pn
nmG6SEOel2kuZ4PQiPtDMlsmhHoBbMTHGdGH4qwWk/tzJSkjIsM7tG5mhDSPOPrdXnZ/eXZ3
3aWggeopy6T4TiJNqYaM1HxhJK8P4X2OhTOzNrBU8R7TJDGHfY9uYQ5jHkWdljMC61wPchpm
jCa9VFbHiyyT+qlfLelC+CItXRbTICLZZFj2WUCM4SzN9X/5ROUMAjXmkl5poQPlQZYU48D8
WBINtNowmNpultVut9k6X6vF/n1b7XRvHFgphwdgscdJ3LeILgZNEmISPtBCqeZ6w4jIQT+U
spppCplbnx0D02k+9OVFVmbucLjeR97H3Sy2T87u/e1ts92roaHABokpp0zG4+a6R1Ci3S9F
EhYyiGTxmFuSV4A78bNRpruSHZDRZMoOiV5ZX5TVvOXLZvndRmiYRzGkTsftRLih42+r/71X
6+UPZ7dcNJmho0CNRhB2fR5Q3QPhsbyRLlY1dPP6tlhjwE2fV2+7dnvy9CTD8MWLI97fqm3g
eNXfq2XleNvV31qwHDAwiC4junkrkB9mPKfBYMcmMa6wZFdAfSzBcppyw4/l6OpM3QFGLs7M
zlC9inmZe1hG0XtszsyagWYEH6yITPF3GjwIDobZ6gwIRlEbay/SVE+tGdMWYQoMGsO6D6aN
axy1aFRPkllIJZddCLUJY9YrLtQxek3WT44IPkabL6uXlrZO0ner4CVAaA8Mz7FysX1/2yOr
77eblxeY1PlinXaFObLmwrF+ZlbAiNK4DXWyaMAu7mZj8PQeWZb03DkkwLlCBDdJclBx8URF
udXoBO8BvsNwhS7Bm0RweNgliij3TUqtyZCBQsikptbUaANk8xw0qX32/Qd4yN3mpbrf73+c
/eEonwQ9++P8/GoE7LyFh7j/9FT9/Wn9dees3u6fnpdvzmv1ej+6vI3wl+Xz+/r7n3+/vd/f
viqfq/ez+8vXD81zvu+U12zs01OF5amU8koh6U7RIrViqXarb+vZYitRQXPAL0JHwXG2fnrb
rNaa8oFxNCaygGHmfooOz4D47N9q+b5ffAHmxH47R5bS9gofuDz2oxwz/VqhVK+T4icpyweX
BisDoLg8raLWrCVoxlM9K1sDIvDKTESE1XHxVjzSzT8gD8MwxflNVqF5BFxHwt/VFsBeNaLt
s+uyakqLyaHHzqQfwA0NGdMVTyQrJHLc/PRROSMThh6lse0g6q02ENMOVFe9Dsizz2WazMA9
7AooDQFMrTEOf3qp+hau34VzcDzz9rnjav/PZvsdrONQS4A/PGG6YZIj4GAT0xWKmM9VbPw8
wO3qBKHZG5z7WST1nhGKbRsTZtLuPNbPytO6H4ESY58fgNtEOOipIu9lczFMc7GWwY44ru0W
KRZEMVy0oskdGmSSmz3RAxooQzcRJsIBShqrSXX5ufQCmvZOj8Oows1M2yBkJDPD8ZV5yo8B
x6gUWFTMzT7gQwySnUy45UlwDT8pLFYNgMTyRghjwnKr+mToO9jhkr0w3sWgJRbY/XoSchH3
Kow2TJcxI7/FjeAo1MOhnKbtsL5i4aV24ZEYGZn9BAOhQCUsB5sLWbg7/Do+VhQ64NDCVUP0
1hq0cLDD719Wyw/66pF3Zasm8nRqzqDB0bEtGB3Bfkg4wAFvUjbWgJRGqS0EBWSfh7lFp4A0
eJRaJUVQixRlnqUCCjxoBJDc3AoSjiw7uBn3xiZFUHcsIIWlq6rJFQwZF5uGJC5vz0bnn41g
j9GYmWUhDKk570jAFJvJMx+Zc6ghSS0ZqyCxbc8ZY3juK3NmGe8sa2/ma1FLoReIQWQx1AhO
wIWYDkOw7jEFdspa7AKcSHrOVuGMUovxq7sSzVsGwm4S65NCFG/FCC8gUhAgAuUxrJgKbnYY
ymxeuoV4KPUuN/dz2HMlnH212/eibZyfTvIxi803I1FGPJ4YgZSYJ7lmZiE+nDSzCaBfTqgp
WTfjGQPzrVXaqT9GrtPqNfWlWsC6qp52zn7jfKmcao1+9hP62E5EqERQu8DrEXQmMC8TyER5
ne5WPD6Ilsz2NPMn3NKygW97Z0kEEj3q6gAsDUpbC0Tsmx8vFaBhbV3daHl9MyycHTGeUmGx
KYqLgSzYPI+tSA1Gy2mDZEr37ZHV0hqHF3UvYMDCVG2V1IZL9M7uP3zafVmtPz1v9m8v798U
gwbnyKPU2EIPhI09EiZqv0Ca1Wv7PItmBBwmt+ChEqn4M9kSpJ4Ggt2MHCZoX0A5YNddzs2B
fRKGmPo0HAkztzPZp6IEWZ2VApNZEnDUaOllfIp3xx5BwzoZG2tJ9vpzyUd0MCZkK98hVH6S
hNLSGvAjlp1nJnLnevtT7slTWpqaAAq3knkKbE0x9hkBjtKFk4v+8iS7GU7utdK8LbY7hc0K
+OBEG+x6qZtR8+1ivXuR+UonXPzQ0nu4hxtOgAZqw64c7HXC+7lFQGwAboVkvmddTgjfM4u3
iKyT8MBJktrpYC1FIPDQNyRrXKLnhdXfmSDRpyyJPvkvi92zs3xevTlP/UyppKXP+xT8i4Hj
YuNcRACjU3N2fyYshuZfdtInxu8MIBZytUvAmM+4lwfluU7GHnR0FHqpQ3F/fm4YG5lOinn/
ELSDjcvxMpEnhhKEEFBO5MjEIudhfxqQxC52lpZmKVGuYPEwQxEt3t4wydCQVZpJSefFEoss
qoaQp0rQ1Mzb5KaNOJhKrlWTznH1cNPkbWfMkOS9a9a53erl60fM5C1Wa7DogNooMoUptYU8
8IP9kFj8NskJNEhHF5PRlTngkTIk8tGVXf5EeIwiaXAMCv8fA0tdNMJr9l/CW+2+f0zWH7G4
MbS6+hskdGzuYZDaI2YxMSZxEYqgklHap2M7DrrJlDpsUazTXIvzfkAapxan84DhcTFJYhpY
ciEdHlzfHJ4cUPAfwe1kkEjIk/iNn+NYWEAMaT5sAA1Tz8uc/9Q/R05KZWYbGz8srFtPsDJd
ysvYZqrLwuW69oKBchbK7waIIAFPR612twguc5tv647O9N0Q6oOBiI4YE8QZhwVz+VEUydLm
wM5Uh5BtAxF+Z7v5qops82++LK1kP7N+uqiNRep+YFMvclyEIX4wxzANUtjrVB0geJlr7zOW
27gm4WqhIP16B3Uz2FS+Lk0gGZxIAna+mweaHwM56k3NxwFFKIs5JbMkOQ87uENtE08jppRE
OhcIxktLUCJhOcnGzGBzVrulyQUl3tXoal56aWK2DeApRw/4jVmz30XF3cVIXFp6WllMw0QU
4OyDk45FdbPXRFJP3EFISCyJAC7C0d2ZpSG2Blq6JsH8iiQTZQ5IV5ZeyBbHDc5trXMtijzo
3Zk5LA0ien1xZc4NeeL8+tYMKoTbZCxKX5C7S0tbHqjCHLsSwL+7KOsx81Ftxo2O+vJal8VY
ih6MocpfQ4CLR2Zd3sHN2a0GHrIxoeaEa4MBcf717c3RRe4u6NzsLRwQ5vPLoxjgdZa3d0HK
xHzwCHn172Ln8PVuv31/lV+s2z0vtuDu7DGcwYdxXsD9cZ5AiFZv+Kv6UDn6lEf5JuTiAu3H
z5EgjjSLCCZsCfqu6dDQYRX9xYk4BWO3rV7k3xTpFVw7FAxFa7elhQmsRw+Hp6CGh6PdQsFm
t7cCKbbXGLax4m/eDh1GYg83ACf5UPX8jSYi+r2f4sDzHZbrqE0DixfDBS0huJ2jxA3dXMz1
NY5t93QthfArNlGi+VYZ4R7+JYXMmP+ACUoNFqd7kZabrpf8bCpiqhj47fv6Oy/dKZvjya9E
OL8BS37/w9kv3qo/HOp9BE5XysGtgRHa0WmQ1aNmpm3BibAgHFa1dGW3y1u+ANCCLf6ovDf8
jjkkS7ZDooTJeGwrcUgEQTGljTkdM7XzVrY1e1hPBVdvQFsdxac/w+Dy358gCSJOQQm5Cz+O
4GTpUWaE15rJPzijVdYkJLcVeyRUZpTkt9Ptmxe+CKjZBapZv1/l74GP8EEiPPn3ATgxJ8lq
BxUdrTZWUC8I42ZVYD5s7TnJ/KBhq5jldWOgmrziipjHzVzN8U1iz8ak0rMyW6zPBQnB47SX
OHJmC2EJxdKWETad2yAwS1i612A3FMbEkuvOC/OKMF5O5YvIvzxjmT21ecZxGOldKbWIYgq/
M8lPuj2A+Hy/XX15R+sn/lntl88O2S6fV/tqid2BwyQabI5flc11Ek5Z7OFXgUNCsQlL/0M5
jRnOjQ0J6uyIPGqd0goIiBsDQ5uBmf7nYxRIkSWZKW8lH5l4rPdXMYCkplZ3ZUU3S4hHE01i
3MvL45OAwXMea6bMi401fmUSe8ScgfHCQUFmjBtBMslnhtxCyDI3giKSgZbTE3jTqFdOM0yD
OSROtI6dKJyL2UAbqGB/9pNVOc10lTsRt7eWLz3VIFjW9D2C3qJJ855qoDW6/cvy/ScAzkeX
ADX1sSorxwT4OjITA37NkjiJmBlqnnR7cac12pL57e3N3f8Zu5YmR3FlvT+/wsuZiDN3DH7h
c2MWGLCtLl6NoIxr46ipdt+uiHpFVXWc6X9/MyXAEiiFFz1TVn4ISUipVCofZimdlykzcyBY
pplJ46W8CPklRvhRX/YVCk4RLANjpUUyOmuLKI1g01XkuD22xdjTAi/ACyOJ+wmvUs2khde7
TdTXChiejKKv5iqz2C+28M/8NXjCNS7Ck2DtEKZJSCJpfEA0tSXA24zazEV5Kaar1poygY8y
3vtbgkUe2F3PuE2WnA4Lh7Di7gCzsSUA0mKWg7ij8bdDcKrjXW8mdaIEyxqHAUUswMJNxfsl
rNz4+kwQ5X3Fa0PL90cQ+1rRH0SNCZRYlO9+IpT95uNjs+nQgNKbzmqSvAmSVV1b6d7KRm/2
GhIQMNjD6OY12w5JD334Apbqw9ybea5rp889O325IunCjY2ksiCPK06TcaM71Qf/SEJikIWj
0pk6TkBj6pKkNdviKN2Z7miM2M2sZLEv2RG4w5AIaY3s0y/5an28iFA+u7HQBUen6cDFTT1Q
GCKSdG4WOdPafIJCURF4CwvoN96ChMl5RNJrDIpUn3aw+t0C/2v7MiBBrNcLwt8tz4kgbjEz
+aWgVlKYowhriF5YuQ0InKV5X0XiDYh0hFyP5Dza+bwynyeRXpSx5xC62gudVqaCILfyavOe
hnT4RxnXIZnle/PedIh9RaLHX51sHiYw7QhaqR8gyj1p9a4/lqjCr0pS5HYDNYBze2Ym9QTq
Pqng+sU3Bin1TXNDffAib5uIUQgHd2pkCr8xYzLR5EomiKpyTSWoztpqeUng746hKt+pJLFf
Rqk46Ug9uTBpmxwe0Srtt6GnwO9o+vZxPk8+f7Qowx59IA7gUrlAXYgyHg4Pw+zl7ecnqbJk
aV7pHgBYcNpu0RE4psIVSRAaNVJ2kRIhXZVvqLtJCUr8smB1H9SZDT2hm+Mj+n99v+/dSTXP
Zxg2ydqOL9mxB9DI0W3vHrItNjmHyfGkXBPlkzfRcZP5haZNbcuAC+SLhWeOLNIDmeOKXEDl
DXHD2UG+gjBAXFYpGNchjoQdJmxsc4slEeehQ8Y3o40iLQg0hJhfhIFyBywDfzl3zEdFFeTN
nZERl9NwpG+JN5uZrxeVeurVbDHy5ZLAvLAugLxwiNAtHSaNDmVm5hMdBk2yUTUx8rrm8DkC
KrODfyCitF5QVXpjvFe/IPb4t3727Ig1OaeV1W5f6hwDGVsgwuvI7G4iyFkV7DlISpGyjSuF
eNmCoV2ZHrRORfghX3nENaOOW3krc0yXAcw8ozQYygKnpDbLLBqygtXF6oCZNccqdFO5cJwg
4jkruODoBWWyc4ggRzq0LHlOa8yG2Pl14PCY+vBxRnF7P8n5nl1RYwRi+Tho58domB4VzDfb
omnoOphNCQWEittWX1jJzd5eKm6XZSHBt7Q+s5DyxlRhcI6A7z1eHV/y42ppZlBa66r07oph
vim3ruOOr4SIupnQQeNT4OCjGuDgTQmLlCGWunFXkcD7Hce7okrg/4trJkGScMcxm1VosCje
wnk1YfkVWPFjfCKkUU3s0lptN1S8Mo1jRmmCRlPjny4E2bNc1EQYNxUq/i7Q/Ow66IGNz5wr
eeIhLIUW65opIU7BWYIBucvxhSD+ZiCPjTPckgeC5Yx/I0C60+n4zJA4TbwjUStq6yuSE3Eb
r7EPFkdEXFYdxq8aZF467mx8GvKq2PpBRJvYaODaWxLOc9pw5Hy5mK7GOeZdVC5dd/y73omY
YKOwItsncnMm6mzEpV4AgYsOK2HDXVUccPb379/+ixEX2J/ZZGj3QE65nZ9ERtOx4Mf9+/0D
HOAUu8K2R+XxImNpEXrkXbL0N46Fuk+NUV62AFNZF5CgVVAcjOhLMUZb0POCoBf+2jvlpa7i
lzZqotisJBMiAAZckZ5NhXmKw7bIzSf4JhmR2bELDqkyRlgHh5IbKBqMOD+/P94/mRQLTQs9
V1ecSVPS15c/BOFDPi4uz01hfWQdsNnNqJsUDUJcG0lI5Rdl3GONOgLD+gSqmZRajLHFKuGk
5EzNgMGnb8h6vA6lUHmi31geBCmhxO0QzpLxFaFWbECNdcCX0t9h26+AjsHYtl7WxBm+rakg
XJgkecvjU5z339P7nEFZxOJsbhgbESOaUNeyPGEnmaPCaJ1zaGL+a2rFtlCmgGBZb6JfONls
TYSjFb7+QjFtXmwB/MuHqwd3nKGiTHXcgx8ncVxl6TbTi6X7TK9sD9CehgmKe3EgFErjptiE
me8a1XFmNLfsG25io2UM5L/RibBxGfrt+fXj8+nX5Pz89/nbt/O3yZ8N6g9Y7OhL9LumUMPG
wkekNTSICCNM0yF8M62eF4iNkujWvDEj1fqajNZbIDkPfOPrFQh6DLdRnLVnOUtKwo4JyfI2
ZTAvon9gD8PwZID5kyf4Ee6/3b+JjW3IacVIsQx1xRUhwohuSP+IU0xKsogqsk1Wbqu7uxPI
kWb3ZISVfsZPsEvQAJYejXat2ecP6MalY8oc6neKl5XZB1oQY/+WUM+ImYOx2cmz/AXixzvb
/ENIj9e0zEhNi4HmmdJ5sjOMBcEvuf/ATxZcAokZvLOEZafgvWamieRaGoAOo/opIMNdPhY3
hlhk3ZclRkLItYPETH5qkt7eYNIA0go9R4tZx2N8SYRHFghYeZxl5pkqAbZnYd8myTUa8NDU
wdLVyHfH9GuSn3Zfe93rJkf+/vr5+vD61MySwZyAf9RVA5LRJwkdyweJEjVUGUdLtyZ2a3wJ
uYg4bKRGwp6by/Pc4KVd5k3cSINwB8STs/A8mXZsyAPl9Za0ORERKMmYMso91/0ltKN48cf/
KAGzWIpihRIAgKWwM2q/8a9LQZt35EK4tF5WhjYu5uFo6EmQuzNOhHdvQbx2FlPTFt0B9qd8
G+gtvZS3glKPiJQuIHhDuyTUCSpegsgj7j8UEzL8LY18LscthAwsrv+lha1+e4MdXzAKAy8X
FYQHKraMIHdDbdvnBTLZeEtOHIMlAKZTNbziQ7lFtPD8zxtMJ1MbbRdmsmq8ciFOIheAa2kc
CBPrxcwK2HoLW/fKnAWu5wxPVck2HHaw4zcjXRcHKMooT+m7WeMoAcFs5hHOYrJrjGeEi4ag
14XvzHWnOnk5C2IE3fyDuUkyOJ9/a5brJBWkPsLuQtIxJW9s3tv2h4S4EUMb7oRQzx98jAOU
mWwtOBqiXBILXxgxN1lNb4LEN8I3gSEObvLz6fPx+8+XBxEFw+Itvw1PPp+tHGJIE1igYo0Q
zo3ieb90vdXUYqYMIGjlYj0lzq4CEK4XKyc5mDdA8Z46d6e0ZlS0NfTXU2KtYRVIXrikjk6B
UG/pIOar6pa8NMsvHZnwzJdkyvJIkOOUrjoJnBmaSNr612KoDu5LPDhwFpibiGR4NI+JzFfw
hpsosZE9L088gqNe6PTwCvqS0PyIHvq1M18Qd58NYLVarulvIAAekQKiAXhrItFLRyd8Ujv6
euT5tXlbEvRyObM9HqVb19kkhDH7XY2bEuHTD4/fshwjXlIqRoQUUWm+PkQibGgLmOL08BXl
YmojB4ty4dF0HgV2ZsPZfLWsRzDJgtjaBPXm6MEkopcaGmIaif6mXkxHmCEmwiD2EiSXGDpm
NlvUeCHiE+GBEBjns7Vllsa5tyJkm+Y1cWL5in6cEP5+eDHhTBfExYS4taDu6m1XGqJRAkBk
crkA1jT/wG5Bxy27gKjCW44A1kQXFIB9m+hANnYMIGCGM+Ja9xCDdGSZTABYTucjs+0QO+5q
ZsfEyWxhWZF+we6y1Ld2t8XYentIvLmF9QN55tBbkwIZeclsMR2rZb0mFLsisWfP1fNCHXKe
tlo0NBXyo4xSchHDns/fHu8nDxhf3HAols8FfiJ86+Xj5nYLoJ/6mNq7vL0CG7IdK/34OrAI
+HgFjofFFagAWLQNdcvCKBPRvmjPXImRbg0JS4W5brqLTGdSHGCTdCvaIqJbDNvyryZtAH4Q
jCqVBH9ydNJr9K56kLyjyK/ZxQEkmnD/8vD49HR/ie4z+e3z5wv8/9+AfPl4xT8e3Qf49fb4
78n399eXz/PLt4/f21ObrAXntn9phGzHz4/P1+fHj/MkvN1Mtu2TLbl8fX0SgS9B0j8/vb5N
Xs7/vdTfBWR8v3/78fjwYZqGYTG8rPCDfPKb//Pb4+skeO2yr/yO6k0tJYgEJ+Ekfvz7HXv/
/vrz8/Hl3L14+37/fJ78/fP7d9SI9i9qt5ruoYvNCN/OZOq33XR5Bn4pZWlWsu1RK4JdFmqL
4yIKygEhyPIjvMUfEESChE2s57cC2haWPduldBKZ9o1ZzrVKw2gbFQXMYVVjA+WoyxOa+d6L
RNBqeUtj3n0BU7JYtLHsOXYPR/tHe69jWB5Qkd2GE7vkhOK8QHS4vQU5xUEY9DqCIlK1Ne+y
QK5C84kZSGyTnHZ1OV8QewVAbllRVsSZGwex9RWlAMKDge8jQhsACDRkvHGoSDvYP0aGX9WG
Bjm76RqpmwA4eMrO0ZCxMIh94DqNb9/zpX6kxfPtdOrO3ZIISiQwCXe92W5LHKcEpLyF3fKr
+diNABaztUsouFr6jFAPIL0MM3dOxNkG8u1u585nrm/ejRFhVRCKoVtGy1lCtyAO1yAkkWQ/
4bPlersjDMOacQSR9mZrGep9DVLHyvqZta/5a0hvNKKacqcjwqF3PXdAmKMSHHdIP8w9j7iw
76EI831lZiYzOGmOgMjrIqWe24U7XcVEULUOtgnhXGE+1yotL4I6SA2hGWSeGYyQ9PZ03+7B
w+t2GU4s6NtuaMXw/7hKUv6XNzXTi+zA/3IXHS+EJQ6CzHaL2eOGNh4GMswDzPh+yjGfUEG4
dBoeK7KSypcCgqFmPYG/MWVQVQMrSs2fSMHc7nzC20EBBXFVukQ0LgEDPhYV+5EXNqDBGw2Y
5oXKzWtWadllej+kSYdelAeJXsCjr4N1iOVffC07YVPS2Lv1zCyQmnEeJZUpWkLz2q412mNo
TI7aSiHVGq+a025DOGUxsCjt6hmr7oIyKYVNnhJB1JOU61SWlmYfBtE2wjOwGbYK75YLw2ji
6hj0U3puDlbqPvxDiJVKeCtA79H5Gr3u4iyQ0Q6Xc72+3qlPHyyYLP33V0ZNusBnQR8MRcJ/
3SeCESFGukFwIv+iHL7OgIW5w57z12AiJWoMuLt9P58xF94ZEwZdZP3X5+fXFwXaZlwaPvIf
7Q656QSaW/mcMslSQNwnrsJVDHH5q2HykDAcUVHR2OtYUoPQFZIpbAAGQ3ras6XrTPuja6ht
KBlfhrQNYIZDKlPH6XMRa8A8zVvexU/nZfL48P56fjo/fMLJCs9RUDRzJzgd7tVaTR+lLrf5
zu+3ut9mF6agnOftWwM4DQRGa8t2ygbr1UmibMPhh37lrAiNpw5aOqTuZAAkTTkU4GpKWXO0
oJu5Q9iQK5D5wqzKVCALwqhagSwJ83cVMh9r7mJGKCgVyGKsuXGwWBL21S1mE7reKAaTrRDW
Og0k4LNFTNiw6xj7qyTGPsQSYz5uXDBzNx4ZZIFZjM9EibumLvsXE5jVWP/n7nK8a1QAVxVy
XcdW4wsMYXXtXVPdzJmNtmw2Nwv7F8hiFuvV9BChvwL2bNpcQ5a5DnEp1mIivnJGZljEvRkh
p6oQd3xMGtjYEO/KZDnCOFmaZqfiZjad2RuW+PXaW4zwOgFamk9BGmZNeLVpoNnIpJZvs0+M
hMPh01meDkHYKpWteBB8naVnHzLErLz16EcSuDV9KdDHjX1NxHnL6+pD3BX1wXT06LuRAfCK
GheO+881FQrcWH1FuViOLBiEEHdQnTS0K2PSr7ADsWKLMhzLrhBJxsVGzhN3OaUv0Pq4sRED
3HwxsrJ46VPmXCqECuTdQUTQVCum9Lm7GNm6AEPehqqYFRVATcVQAcovGBB97LypBPY+d+x7
RLn115RPeYeJb2fu1GeBS8ebNmHHZkKHnTmUn8wA6dbz69sg0Ne3YqQNfOa77oqwx+1Aco+3
gg6JtyDuq1XIiCwpIPYJgBDC4k+BUPZkKsS1y8cIGWFJAmJfzQiZj9cyspoFZHToyMj9KsS+
lAHiTcdnYwMbm4Z4y01orFXIyOYvIHYuhZDV6LxZr0a/+JqIANNC7oSGYL3MXXuDUKhZEYFS
WkzqV96CuBZQMd7IuhKYMbaZ+3DwnPpaq1WMuEo6YdJwkfypp9hTyK1eYM/CoWYbCjU3NxZi
Ws0yKo6wIRVRuiNCogGw8A9GUrU33sJi1ZfrCqkfeTs/oGsnPjCIc4x4f94PZSxKg6CiwwZI
RGH0ZhO0PNc17V0h4Wsv6BVqGYkaN1F8w9LBMEZllp+2plw1SA72UVEot8+yjMGvY7+mvMhC
hjFqyOYFwmyBepO0ROjXCt9vl6UFI+LXICRKeK8DOjmOAiKNmCSb4oMKyh30pt+eXZRsGGE/
KOhb4j4PifsMA6+RZHidfcLcHOlRqII42zHC9BXoBz8uidw/ot3HYnD7ogEwhqgxQTDSysFU
/eJvCDcwpJYHlu6NxgZyHFLOYE1ng9kaB8Kanaw3jtLslvqeOD6mhdqW4w8ikGMHIeYZ0osq
2cRR7oeuDbVbz6c2+mEfRbF1Pic+fGY6opOEHAdZ4lSyiBWabUt9XScZBiocTnmRTN4+MVMi
4o+kFUQ6HaRmhW1F5H6KPghxZllx1jgpEgDH+iPh4CYAwM9iIsmCoMfQjCJLGRGATHI/MqUu
kgs02wjpL1ZkQUAkEEQy95ltmGyRyAQ9j6Kwn/lWR5Q47WDXIwxmBKZKMdQu3QfKzQ7ZC8bf
8DmjWQJP/KL8kh2tryjZrVkjLIhZziPCiEDQ90WFOd/6iUF1NooCwynnhJOAYKS27aRmMBtJ
6l1UZNYOYtRMWJw0G5YJjU57wp1YSAGxwX8RbwyNohUaERrEq5yZB7KB9/w5L9722iu6p4R/
vlHewvqyfcBOaPQFoqC0QlOCilxsHPVC9GjNesDGJZCf9kGoUfohdv00BZYRYGb7Q3NfbrC+
fPx4OD893b+cX39+iAF8HWR65ps2y9AJzdoYL/uvoq/ENVhWmpdvQzsd9sABYsZNkSYQk+ib
JRYdxDBt/K15MmCGKbs/t3h+uaqn0xOVgwYhNX4+GyAaA2Q1xuTZ51YQ47njLGsrZgtDhXeo
Ngy6B85dx96gsRbz2HMGVSj0wvOXy8V61cxEffkEMtu0MIgk39DG04a/9+bl3IRTDZ7uP4xx
B8RED8ysSsSKLkRkYpJ+COlnS90FR4bCycroPxMxOmUGYns0+XZ+QzPdCV76Y1aov39+Ti5p
sybP979a04D7pw+R3B4T3Z+//e8EnaDVmvbnpzdxp/2M1uaPL99f9UXY4PpD3RRbbLFVVBMY
eRQnsvD6Zgas4raw6VF7hYpjPHQJ/bMKg78JEUFF8TAspmYFQR9GuPqpsC8VRn0k0leqQD/2
q9C8u6uwLI1oSVIF3vgFEWxdRbXm6/BBgvHvASvqVG2WriX+eeWb1xp7vv8/kVV6mORT8JQw
oDz/BBkFbsvMYpbAnuJ5wTZCwvJF7DIHwq2xIdIR3TGiBQsjeqyR7650VVo3LL1UUfqoD0J7
do/pOyvxfJQwQjvXUF2zylGwvbAqCWsb2bRbHtH8oGAZZaAtYuBHu6wkj6ECYdk52ikbHFcB
4S0rYcL5mv4qIX0EFDthGTI68qcYI1QmhfB1YyI6segJ3RGMMheA6ATnfMqpSDQ0O/gFjCiN
IMN+SNmBi5RssF1uWV1WllXCOFrRbgl1HwCO8DQ9KaI7MW41PedA6Mb/uwunppnNnoOwB3/M
FoSGWgXNl8SVuRh7jB4OHycq7EMU7P2M30RH41LLf/z6eHy4f5rE97/MMZfSLJdiXBAxs7E8
UkVUg1sqVlnLJ3pBFdTn/XAXDYRjWdoEJ9qymDh9DqEmYzMFhQ1F1eHhL9dAbfeDtMJokGiE
zAF3GbLz++Pbj/M7DNpFPu5zpy1+YguTaCXRivByFc0prORWhqQFuNp3CY9TsWvcWqtH8swi
JuO76bWwCQNr7bDPu+6Kfl4andMCdMw2XQTYv55VyhbDU/FO4nvuLQbxJ5FREwF4BKd5YhUS
Fv+CQ1gSr8A6sojacuJZWrWF0yiqX8mJbevzzhZGW8ofsBnINlg6MHYeCMJgJCqvrAfOHKfE
spClQtFC31t0D7tTuNkRIbmPOWGYISS7GCOLUfzrYLKnThIlThH8OG0wvJOhqDnc/+VdakSP
SzoCJT7Z5+lS5yCcNaW/5hUndKyHPtsg9f8bu7betnEl/J5fIXRf9gCn3fiS1HnIg0xRlmrd
IlKJ0xfB67ip0cYObAen+feHQ4kyKXHkALtIzflEUeRwSA7nwryA2GzLJU03vpdNiqV9ix7j
s64j7JZIp0Avdg17c0kM4A9iAQOA+wIVnUAuWIA4OEuiePV1nkb48+QuQEKhATVGXARiGuM5
EEBNJDZLduZxCaEQvSaMQo4lIfPDJJy6iU3a5ZyUVZgqrUB6VJlFAeFplT2vW6h8Pj7tj6vL
TzpAEHkaEPOpurD1VNNcgGDeEkBL6pC6khNzSFalZ5rRgEKe+FW4LfP9shycOSzFLWcUvbws
QnGIa7mlmK3O7+3zCnST0FLL/kc9506nV98povg9gRYTxHFSQTwmtkH2RVuHIGYFGuQaWT4V
JHYX1zfWpIsKkbMrMvo6bPcnkEIWDYZILDcTg1gkKNBCQOx6BIWQYcAQAx0Dg0UPMkCjj4A+
gkHisDS9Ox5wxB5IQaZ3o6FdXigEG12Nbi7tZ2uF8WPUfrkZR8F0iLGGBrlCDFP1WhArZQWh
8egSsb1tarmfTCyBzcBk58wEgx5FYhMZkLMTY4S4XRiQ/g8FCBJgxoCcn8dIwBZjkiJGqk2X
3mD+K6ehG58f3Wssj4whDsb9c74SKv39K6bPcHBmQsck+3pjS4uQc6s7EPAPRMb8gKD22AhL
XGC28BwjCz66MTVjVajP38vjj93+5Xw7BkPEglWDXCEWgzoEMcHT14LJVem7cYiE8NOQXxH/
kxNkOEaUDo3U4vPBV+6eYZTxhJ/5eoAgHjM6BDFnayAsvh6e+ajp3Xhyhmnz7IqcmWXAEF09
5277mWTFOWZAYvMqcm1S1r8QcPGvS0s0TDgPMRlm5VwrtBti8M+1vk5s2bEbT0GaFr52zXk6
zjwmRCpo7DvgYmFRJKqzlR4epIDYmXWHhPmdoQ+CyKpiY1mT7Oc0eDwvkAyLEDrD5pqrkSG2
J00K/b2qODZP/vUV8Gq/O+x+HJ3g/XW9/3zvPL+txanM5g/J3VkraElNIdEcNq9Rms4LI7F8
8CCkXmINGUxkqGG2e9sj+ajz2gNbyNCJOZ2bEWPq4pzBkYzE2gV6m8jjQiMGddXmI6q0wp7O
TW4YTVNrUP40jot24KjZerveb1aOJDrZ8nl9lMGRmRmZP1+/7I7r1/1uZWV3GqecwgGi03H5
68vh2fpMFjM12Fbuke73D6ElBhL4wf7NqjwB6dYhkAHAOYBV6A/xJadjeRUu6OX37lkUg0vu
k0ma7nfLp9XuxUbbfIkXtvK7t+Vv8Uj7Ga3VELW80+TF5vdm+wd7qM58fE/sQfKyGE5bfk7t
k5AuOMGC/ImBQUI+hEi3Zw+WZBJi+kOeha61CvD9LJR20GWS3w60+jMIaIApeGR4XFAO8hwS
ZNqVXL7lUhuSR7O3f6v8D0aoYRXlGc/aXs4hbBzcGKAoCACeLdxyOElieStwHgX12VFwJ4WG
vyTd/AWZOLSLfc5yK2TMy267Oe72NsmWW+5E3e3Tfrd5MkRS4uUpornzXJuAMPQIwYNz3C9X
cMlqla5IfgaZ3h3Ry4Jjun2qhynidRKFcYuFqshTGyGiKh7Q43sxkHGuljVJTI2hEb2iLigX
Lud5txh0qYvSJVGXxCgp8lBP9SQoo3blI7yWEVrLuF3LGK9l3KpFlwLjkiYkf8xQu2GJwTRJ
36aeoZmA3yhYNCKeEpcEholHTkNGc0FDNOvfcNICJ818NsRoEH8EJU55T1uSMOp51B/iTwqK
ff5ggwbrrRkmRZXV6uo0s+2PfBnuTNCNrF4x5OTiQqq36Xr77HzQ0Nsx7Lx2QVgVCNlmxpTx
3Ypg7Ze7IuX2+Q05gHw2RjtUvAYdYLF5FPvY0pIhgCxXP03TD59Jluwivc95Gv/j3XtScpwE
x0lusfTm+voSa0Xh+bYWeCn7x3f5Pwlv1dt0Fy/NgY+ZeMZ+XXrfoLWnlTEjOLlmcNU0Hn21
0cMU8jOJNfX20+awm0yubj4PPunjdoIW3LefJBPe4flqWTqs3552zg/bF3bCA8mCuXlnIcsg
FDGPWoXwSWAqGQqGNlJgAJEEYeTl1MbCc5onRlAiU6fN48zsdllwmpzWz68wcmGw0oNiRnk0
tY5d9Ud23+lyFNIWVpfoj4zT2GhQKiOM4jLG9XpoPk4Leklg6owKy57WTHFSz1Pf/B4BW0xD
/EmSuzFCYneFywKEeN+zisRhIgYfkzJxT79lOO0uWYx7qdc4Ne97aQZXy4i77iO7R3u1U6Oa
23WCG5MdFbFiXOP3/bD1e6Szb1WCTiVJtuu0gMQezE1x0yEpL5NWQzzzV7cd3pmGeK2WqE2F
TFKZQU4+7RWwmrZ/iufNrmhburMiyTMzypcs6bkJJjQLUOYPMULqubhMwAZed/EUP9QyYKwT
GlktNKVYaIye1mmYM7QJ+mpXNRqgCWL72QLZD1gt0Ide94GGY0FKWiC77rIF+kjDkcuxFgiZ
TiboI11wbVcSt0B2HbABukFi0JigK9uFaKueIcppN0iYILO1yN0tgMTGDri8RLY8ejUDzBC5
jcJH3mUktFl36C0ZtD9WEXBeUQicURTifEfgLKIQ+KgqBD6JFAIftaYbzn8MkjTegOCfM0/D
SWnfyjVku74NyLELCStjxF5XIQiNOKIjOkESTgvExq0B5anLw3Mve8zDKDrzuplLz0Jyipi+
K0RIwFIZyfusMEkR2o2pjO4791G8yOchclkDGPS04kVdPeV8vd+ufzs/l6tfm+3z6ZRSZaQO
8zs/cmesrQJ/3W+2x1/ytvPpZX14tt23VLFMO5c4p+2/DJkbpbOI3tOoWWSbs1pMGQPp0UGM
tS+qPdM62wYVrPNVnMA+Q5oHRxx8V78OssmrqnzfdYajiTsVjXpw80TUmeWUuJwa3k81Ii4Y
h8gCxJawW4YGlpXcDi6HWnMZz8NMSLxY7Egx88JEnOw9oE/TyLY7UdbDmuMzdT2as6o5elsr
KKPSLBPOVjEkPLPU2YZUHZAmkaEuk17bsJdGbraq18E5k3Z9JurchN7637fn54rTTpwiPVsW
HHzmETWchGSpkGGJ/YZKZlGsWxDTOKKuZuVYlVeafTELw4aPZXOcaLf69fZa8Uaw3D6bbCwm
JBF9UaZ2lZNBL+/dqKC3lyYRpkBacFHc6isgzCnNbJkCoFGn7nL+PrxutjKH5n+dl7fj+s9a
/GN9XH358uU/J/6VqjFZN1zkabO2efHDg+BdThdizCMfz1bKXTKXIsBKluzhRpHgVnBXFvxa
pezuHxfxfx3nuD0yBqW6AyOFwSvqvEOKkmQFtE+8XfXrcGC8TRkiVzJMU1mbVHGcEScKK0aJ
FV9S2xVUojEm4LFfChGR5l4LAoob2UBACq5NuK5pEYXI4Ph4l3uxC5GmcaNG0RjRHdJ0EGpv
XxFHcw+5f5COKeCWWzIsI4yEoFSXp6Kzrsf9LCXrCOjCK2LE9lm+REjIZNabYkPi5gLIkRsQ
CZCrj91+V9KnIY+ReyZJLwrkHkhS88BlAYeVoOdbXWSNrjp83jMaoEOWWVB62p/ZP84PEw8+
rpzShASxm9u3LbU3UjdjTms4pAayp6EexVyv6uEUezRSoiF1qrGMUySZHY1RdgKxISYx+LGC
uXde4Fc4zIUITTbZLSer9LifzzzTw37KkF0YpKnmcKGQQz+n9u/yRLf6Qjo+iNEwb2qr2/j1
6m2/Ob7btk1oX6kbLLAwYfI6WMwVgsjvGttLtCo/ZJcE4uNoQj3JiMCHpQz87rZUzh0YtpZw
6SpGc/AWr6a2dWNTKdtP3+kSfaEwqbefGh2MvLdJm6Dc+/fX465K6bXbOz/Xv1+l65MBhkTz
Rtx+o3jYLRdbrJOWWivsQqfRnIRZoK8pbUr3IZAV1sIuNE9mnZaIMiuw2TJ3mo62ZJ5lls8H
nxlD46Dewey3VzXZswvAmkqJZ9uM1lRxEBJ7vm4v1uW21gCLna2w9EImt/AgWpillpk/GE7s
iSNqRFJEUadLobDbc6BBvitoQS0vkn/skk81+TzELXggJH0fxOpN4L4df663x81qCQnW6HYF
0wbyEf9vc/zpuIfDbrWRJG95XOrySTUecRVTndhPJoEr/hteZmn0iBo611hG70ynzjYXBa7Y
0t+LAakslKTZ2cvuSffkUK+dEts4+HZXWEVGLrcaMnYhUzevt/Iot/v61uRMtLiPvuh/uVhL
HnJzl1MZqiwPP5su6nxQ7BK8uwPwlnrpNuRMQ+9blVanr83z+nDsjlJORkPrQAEBb5og88Gl
F/q2SY3uxlRPf4ATY8+uXWvI/U+HglNpBH/7YHnsDZDwqxoC0befEEMkpv4JgeUFU9MucG2O
0CeqeIOFEQThamBXy54Qdj2mose9ZD7LB4hTr5K5WasFFZNLh+iuTHCpbREQpSXi4KkQSTEN
e2ef2Fj28ss0Sh98TJGneNqNaRQhMccaDOO9nAeAXm7wEKf1muzLv72CJnC/u73rFHMj5vZz
nFoU+hcDJDpaQ88zmvS2lcW9o8IyinhQNstp72jwh7Q9qI0ycr8+HKq0nN0R8CMXcUlWS8V3
u0K8Jk8Q/4Lm6d6vFuTAYom83D7tXpzk7eXf9b6ye1Z5RbvTgYUlyXK7+Xj9kfm0Vky0N0+S
ErQccQ2aPRSkBunU+S2E6LoUzGWzR4ukkodsUKmcWxoaIKt3zR8C50gwwzYOThE9y+1Dc65Z
749grC02ZVW2qcPmebs8vu1r1XalJ6tUh91Ur+rUHPKcgm+BptRSVsDiOJkQcdTz8zRWVmwW
SEQThJpQ3gRI1j6XiL2iGArrN5LBtb5lJmWzgGtlIS9KbhSNWrt/UWBVPpmAKCR0+jixPFpR
sAkiIW7+gM9PQEyRqx3SWgVOxYaxAASLkPserBLElUnqXZHPb1CL72Ur4UNzgpf2v1RLwQdF
Xqzl3mWzqDr+a4fxO80qLYlMw2DFDkotaPR3mnvI9sfzcmdzcLa7o3NYHy/+ckia+OGsDPO7
MkujyNkcnO3u6BzWxwuSJn44K/004SUrsizN+e37xV8OSRM/nJV+mnDmbA7Odnd0DuvjBUkT
P5yVfprwcvJncvt+QdLED2elnya8nPwZXN++X5A08cNZyWZllqbR7fsFSRM/nJVsGvLYzW7f
L/5ySJr44axkPA+TWclo5HPKuLM5ONvd0Tmsjxf/BzcwTPfI/wAA

--YiEDa0DAkWCtVeE4--
