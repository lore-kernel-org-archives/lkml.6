Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932129AbeE3SZ7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:25:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:49152 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932074AbeE3SZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:25:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,461,1520924400";
   d="scan'208";a="233239677"
Date: Thu, 31 May 2018 02:25:45 +0800
From: kbuild test robot <lkp@intel.com>
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org,
        Steven Eckhoff <steven.eckhoff.opensource@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel][PATCH v1] ASoC: TSCS454: Add Support
Message-ID: <201805310225.8sNN5isi%fengguang.wu@intel.com>
References: <20180529105147.GA32219@t7-ThinkPad-E560>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529105147.GA32219@t7-ThinkPad-E560>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

I love your patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.17-rc7 next-20180530]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Steven-Eckhoff/ASoC-TSCS454-Add-Support/20180531-001905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/codecs/tscs454.c:2454:9: sparse: Using plain integer as NULL pointer
>> sound/soc/codecs/tscs454.c:2629:5: sparse: symbol 'tscs454_set_sysclk' was not declared. Should it be static?
   sound/soc/codecs/tscs454.c:236:10: sparse: Initializer entry defined twice
   sound/soc/codecs/tscs454.c:239:10:   also defined here

Please review and possibly fold the followup patch.

vim +2454 sound/soc/codecs/tscs454.c

  2348	
  2349	static struct snd_soc_dapm_widget const tscs454_dapm_widgets[] = {
  2350		/* R_PLLCTL PG 0 ADDR 0x15 */
  2351		SND_SOC_DAPM_SUPPLY("PLL 1 Power", R_PLLCTL, FB_PLLCTL_PU_PLL1, 0,
  2352				pll_power_event,
  2353				SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_PRE_PMD),
  2354		SND_SOC_DAPM_SUPPLY("PLL 2 Power", R_PLLCTL, FB_PLLCTL_PU_PLL2, 0,
  2355				pll_power_event,
  2356				SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_PRE_PMD),
  2357		/* R_I2SPINC0 PG 0 ADDR 0x22 */
  2358		SND_SOC_DAPM_AIF_OUT("DAI 3 Out", "DAI 3 Capture", 0,
  2359				R_I2SPINC0, FB_I2SPINC0_SDO3TRI, 1),
  2360		SND_SOC_DAPM_AIF_OUT("DAI 2 Out", "DAI 2 Capture", 0,
  2361				R_I2SPINC0, FB_I2SPINC0_SDO2TRI, 1),
  2362		SND_SOC_DAPM_AIF_OUT("DAI 1 Out", "DAI 1 Capture", 0,
  2363				R_I2SPINC0, FB_I2SPINC0_SDO1TRI, 1),
  2364		/* R_PWRM0 PG 0 ADDR 0x33 */
  2365		SND_SOC_DAPM_ADC("Input Processor Channel 3", NULL,
  2366				R_PWRM0, FB_PWRM0_INPROC3PU, 0),
  2367		SND_SOC_DAPM_ADC("Input Processor Channel 2", NULL,
  2368				R_PWRM0, FB_PWRM0_INPROC2PU, 0),
  2369		SND_SOC_DAPM_ADC("Input Processor Channel 1", NULL,
  2370				R_PWRM0, FB_PWRM0_INPROC1PU, 0),
  2371		SND_SOC_DAPM_ADC("Input Processor Channel 0", NULL,
  2372				R_PWRM0, FB_PWRM0_INPROC0PU, 0),
  2373		SND_SOC_DAPM_SUPPLY("Mic Bias 2",
  2374				R_PWRM0, FB_PWRM0_MICB2PU, 0, NULL, 0),
  2375		SND_SOC_DAPM_SUPPLY("Mic Bias 1", R_PWRM0,
  2376				FB_PWRM0_MICB1PU, 0, NULL, 0),
  2377		/* R_PWRM1 PG 0 ADDR 0x34 */
  2378		SND_SOC_DAPM_SUPPLY("Sub Power", R_PWRM1, FB_PWRM1_SUBPU, 0, NULL, 0),
  2379		SND_SOC_DAPM_SUPPLY("Headphone Left Power",
  2380				R_PWRM1, FB_PWRM1_HPLPU, 0, NULL, 0),
  2381		SND_SOC_DAPM_SUPPLY("Headphone Right Power",
  2382				R_PWRM1, FB_PWRM1_HPRPU, 0, NULL, 0),
  2383		SND_SOC_DAPM_SUPPLY("Speaker Left Power",
  2384				R_PWRM1, FB_PWRM1_SPKLPU, 0, NULL, 0),
  2385		SND_SOC_DAPM_SUPPLY("Speaker Right Power",
  2386				R_PWRM1, FB_PWRM1_SPKRPU, 0, NULL, 0),
  2387		SND_SOC_DAPM_SUPPLY("Differential Input 2 Power",
  2388				R_PWRM1, FB_PWRM1_D2S2PU, 0, NULL, 0),
  2389		SND_SOC_DAPM_SUPPLY("Differential Input 1 Power",
  2390				R_PWRM1, FB_PWRM1_D2S1PU, 0, NULL, 0),
  2391		/* R_PWRM2 PG 0 ADDR 0x35 */
  2392		SND_SOC_DAPM_SUPPLY("DAI 3 Out Power",
  2393				R_PWRM2, FB_PWRM2_I2S3OPU, 0, NULL, 0),
  2394		SND_SOC_DAPM_SUPPLY("DAI 2 Out Power",
  2395				R_PWRM2, FB_PWRM2_I2S2OPU, 0, NULL, 0),
  2396		SND_SOC_DAPM_SUPPLY("DAI 1 Out Power",
  2397				R_PWRM2, FB_PWRM2_I2S1OPU, 0, NULL, 0),
  2398		SND_SOC_DAPM_SUPPLY("DAI 3 In Power",
  2399				R_PWRM2, FB_PWRM2_I2S3IPU, 0, NULL, 0),
  2400		SND_SOC_DAPM_SUPPLY("DAI 2 In Power",
  2401				R_PWRM2, FB_PWRM2_I2S2IPU, 0, NULL, 0),
  2402		SND_SOC_DAPM_SUPPLY("DAI 1 In Power",
  2403				R_PWRM2, FB_PWRM2_I2S1IPU, 0, NULL, 0),
  2404		/* R_PWRM3 PG 0 ADDR 0x36 */
  2405		SND_SOC_DAPM_SUPPLY("Line Out Left Power",
  2406				R_PWRM3, FB_PWRM3_LLINEPU, 0, NULL, 0),
  2407		SND_SOC_DAPM_SUPPLY("Line Out Right Power",
  2408				R_PWRM3, FB_PWRM3_RLINEPU, 0, NULL, 0),
  2409		/* R_PWRM4 PG 0 ADDR 0x37 */
  2410		SND_SOC_DAPM_DAC("Sub", NULL, R_PWRM4, FB_PWRM4_OPSUBPU, 0),
  2411		SND_SOC_DAPM_DAC("DAC Left", NULL, R_PWRM4, FB_PWRM4_OPDACLPU, 0),
  2412		SND_SOC_DAPM_DAC("DAC Right", NULL, R_PWRM4, FB_PWRM4_OPDACRPU, 0),
  2413		SND_SOC_DAPM_DAC("ClassD Left", NULL, R_PWRM4, FB_PWRM4_OPSPKLPU, 0),
  2414		SND_SOC_DAPM_DAC("ClassD Right", NULL, R_PWRM4, FB_PWRM4_OPSPKRPU, 0),
  2415		/* R_AUDIOMUX1  PG 0 ADDR 0x3A */
  2416		SND_SOC_DAPM_MUX("DAI 2 Out Mux", SND_SOC_NOPM, 0, 0,
  2417				&dai2_mux_dapm_enum),
  2418		SND_SOC_DAPM_MUX("DAI 1 Out Mux", SND_SOC_NOPM, 0, 0,
  2419				&dai1_mux_dapm_enum),
  2420		/* R_AUDIOMUX2 PG 0 ADDR 0x3B */
  2421		SND_SOC_DAPM_MUX("DAC Mux", SND_SOC_NOPM, 0, 0,
  2422				&dac_mux_dapm_enum),
  2423		SND_SOC_DAPM_MUX("DAI 3 Out Mux", SND_SOC_NOPM, 0, 0,
  2424				&dai3_mux_dapm_enum),
  2425		/* R_AUDIOMUX3 PG 0 ADDR 0x3C */
  2426		SND_SOC_DAPM_MUX("Sub Mux", SND_SOC_NOPM, 0, 0,
  2427				&sub_mux_dapm_enum),
  2428		SND_SOC_DAPM_MUX("Speaker Mux", SND_SOC_NOPM, 0, 0,
  2429				&classd_mux_dapm_enum),
  2430		/* R_HSDCTL1 PG 1 ADDR 0x01 */
  2431		SND_SOC_DAPM_SUPPLY("GHS Detect Power", R_HSDCTL1,
  2432				FB_HSDCTL1_CON_DET_PWD, 1, NULL, 0),
  2433		/* R_CH0AIC PG 1 ADDR 0x06 */
  2434		SND_SOC_DAPM_MUX("Input Boost Channel 0 Mux", SND_SOC_NOPM, 0, 0,
  2435				&in_bst_mux_ch0_dapm_enum),
  2436		SND_SOC_DAPM_MUX("ADC Channel 0 Mux", SND_SOC_NOPM, 0, 0,
  2437				&adc_mux_ch0_dapm_enum),
  2438		SND_SOC_DAPM_MUX("Input Processor Channel 0 Mux", SND_SOC_NOPM, 0, 0,
  2439				&in_proc_mux_ch0_dapm_enum),
  2440		/* R_CH1AIC PG 1 ADDR 0x07 */
  2441		SND_SOC_DAPM_MUX("Input Boost Channel 1 Mux", SND_SOC_NOPM, 0, 0,
  2442				&in_bst_mux_ch1_dapm_enum),
  2443		SND_SOC_DAPM_MUX("ADC Channel 1 Mux", SND_SOC_NOPM, 0, 0,
  2444				&adc_mux_ch1_dapm_enum),
  2445		SND_SOC_DAPM_MUX("Input Processor Channel 1 Mux", SND_SOC_NOPM, 0, 0,
  2446				&in_proc_mux_ch1_dapm_enum),
  2447		/* Virtual */
  2448		SND_SOC_DAPM_AIF_IN("DAI 3 In", "DAI 3 Playback", 0,
  2449				SND_SOC_NOPM, 0, 0),
  2450		SND_SOC_DAPM_AIF_IN("DAI 2 In", "DAI 2 Playback", 0,
  2451				SND_SOC_NOPM, 0, 0),
  2452		SND_SOC_DAPM_AIF_IN("DAI 1 In", "DAI 1 Playback", 0,
  2453				SND_SOC_NOPM, 0, 0),
> 2454		SND_SOC_DAPM_SUPPLY("PLLs", SND_SOC_NOPM, 0, 0, 0, 0),
  2455		SND_SOC_DAPM_OUTPUT("Sub Out"),
  2456		SND_SOC_DAPM_OUTPUT("Headphone Left"),
  2457		SND_SOC_DAPM_OUTPUT("Headphone Right"),
  2458		SND_SOC_DAPM_OUTPUT("Speaker Left"),
  2459		SND_SOC_DAPM_OUTPUT("Speaker Right"),
  2460		SND_SOC_DAPM_OUTPUT("Line Out Left"),
  2461		SND_SOC_DAPM_OUTPUT("Line Out Right"),
  2462		SND_SOC_DAPM_INPUT("D2S 2"),
  2463		SND_SOC_DAPM_INPUT("D2S 1"),
  2464		SND_SOC_DAPM_INPUT("Line In 1 Left"),
  2465		SND_SOC_DAPM_INPUT("Line In 1 Right"),
  2466		SND_SOC_DAPM_INPUT("Line In 2 Left"),
  2467		SND_SOC_DAPM_INPUT("Line In 2 Right"),
  2468		SND_SOC_DAPM_INPUT("Line In 3 Left"),
  2469		SND_SOC_DAPM_INPUT("Line In 3 Right"),
  2470		SND_SOC_DAPM_INPUT("DMic 1"),
  2471		SND_SOC_DAPM_INPUT("DMic 2"),
  2472	
  2473		SND_SOC_DAPM_MUX("CH 0_1 Mux", SND_SOC_NOPM, 0, 0,
  2474				&ch_0_1_mux_dapm_enum),
  2475		SND_SOC_DAPM_MUX("CH 2_3 Mux", SND_SOC_NOPM, 0, 0,
  2476				&ch_2_3_mux_dapm_enum),
  2477		SND_SOC_DAPM_MUX("CH 4_5 Mux", SND_SOC_NOPM, 0, 0,
  2478				&ch_4_5_mux_dapm_enum),
  2479	};
  2480	
  2481	static struct snd_soc_dapm_route const tscs454_intercon[] = {
  2482		/* PLLs */
  2483		{"PLLs", NULL, "PLL 1 Power", pll_connected},
  2484		{"PLLs", NULL, "PLL 2 Power", pll_connected},
  2485		/* Inputs */
  2486		{"DAI 3 In", NULL, "DAI 3 In Power"},
  2487		{"DAI 2 In", NULL, "DAI 2 In Power"},
  2488		{"DAI 1 In", NULL, "DAI 1 In Power"},
  2489		/* Outputs */
  2490		{"DAI 3 Out", NULL, "DAI 3 Out Power"},
  2491		{"DAI 2 Out", NULL, "DAI 2 Out Power"},
  2492		{"DAI 1 Out", NULL, "DAI 1 Out Power"},
  2493		/* Ch Muxing */
  2494		{"CH 0_1 Mux", "DAI 1", "DAI 1 In"},
  2495		{"CH 0_1 Mux", "TDM 0_1", "DAI 1 In"},
  2496		{"CH 2_3 Mux", "DAI 2", "DAI 2 In"},
  2497		{"CH 2_3 Mux", "TDM 2_3", "DAI 1 In"},
  2498		{"CH 4_5 Mux", "DAI 3", "DAI 2 In"},
  2499		{"CH 4_5 Mux", "TDM 4_5", "DAI 1 In"},
  2500		/* In/Out Muxing */
  2501		{"DAI 1 Out Mux", "CH 0_1", "CH 0_1 Mux"},
  2502		{"DAI 1 Out Mux", "CH 2_3", "CH 2_3 Mux"},
  2503		{"DAI 1 Out Mux", "CH 4_5", "CH 4_5 Mux"},
  2504		{"DAI 2 Out Mux", "CH 0_1", "CH 0_1 Mux"},
  2505		{"DAI 2 Out Mux", "CH 2_3", "CH 2_3 Mux"},
  2506		{"DAI 2 Out Mux", "CH 4_5", "CH 4_5 Mux"},
  2507		{"DAI 3 Out Mux", "CH 0_1", "CH 0_1 Mux"},
  2508		{"DAI 3 Out Mux", "CH 2_3", "CH 2_3 Mux"},
  2509		{"DAI 3 Out Mux", "CH 4_5", "CH 4_5 Mux"},
  2510		/******************
  2511		 * Playback Paths *
  2512		 ******************/
  2513		/* DAC Path */
  2514		{"DAC Mux", "CH 4_5", "CH 4_5 Mux"},
  2515		{"DAC Mux", "CH 2_3", "CH 2_3 Mux"},
  2516		{"DAC Mux", "CH 0_1", "CH 0_1 Mux"},
  2517		{"DAC Left", NULL, "DAC Mux"},
  2518		{"DAC Right", NULL, "DAC Mux"},
  2519		{"DAC Left", NULL, "PLLs"},
  2520		{"DAC Right", NULL, "PLLs"},
  2521		{"Headphone Left", NULL, "Headphone Left Power"},
  2522		{"Headphone Right", NULL, "Headphone Right Power"},
  2523		{"Headphone Left", NULL, "DAC Left"},
  2524		{"Headphone Right", NULL, "DAC Right"},
  2525		/* Line Out */
  2526		{"Line Out Left", NULL, "Line Out Left Power"},
  2527		{"Line Out Right", NULL, "Line Out Right Power"},
  2528		{"Line Out Left", NULL, "DAC Left"},
  2529		{"Line Out Right", NULL, "DAC Right"},
  2530		/* ClassD Path */
  2531		{"Speaker Mux", "CH 4_5", "CH 4_5 Mux"},
  2532		{"Speaker Mux", "CH 2_3", "CH 2_3 Mux"},
  2533		{"Speaker Mux", "CH 0_1", "CH 0_1 Mux"},
  2534		{"ClassD Left", NULL, "Speaker Mux"},
  2535		{"ClassD Right", NULL, "Speaker Mux"},
  2536		{"ClassD Left", NULL, "PLLs"},
  2537		{"ClassD Right", NULL, "PLLs"},
  2538		{"Speaker Left", NULL, "Speaker Left Power"},
  2539		{"Speaker Right", NULL, "Speaker Right Power"},
  2540		{"Speaker Left", NULL, "ClassD Left"},
  2541		{"Speaker Right", NULL, "ClassD Right"},
  2542		/* Sub Path */
  2543		{"Sub Mux", "CH 4", "CH 4_5 Mux"},
  2544		{"Sub Mux", "CH 5", "CH 4_5 Mux"},
  2545		{"Sub Mux", "CH 4 + 5", "CH 4_5 Mux"},
  2546		{"Sub Mux", "CH 2", "CH 2_3 Mux"},
  2547		{"Sub Mux", "CH 3", "CH 2_3 Mux"},
  2548		{"Sub Mux", "CH 2 + 3", "CH 2_3 Mux"},
  2549		{"Sub Mux", "CH 0", "CH 0_1 Mux"},
  2550		{"Sub Mux", "CH 1", "CH 0_1 Mux"},
  2551		{"Sub Mux", "CH 0 + 1", "CH 0_1 Mux"},
  2552		{"Sub Mux", "ADC/DMic 1 Left", "Input Processor Channel 0"},
  2553		{"Sub Mux", "ADC/DMic 1 Right", "Input Processor Channel 1"},
  2554		{"Sub Mux", "ADC/DMic 1 Left Plus Right", "Input Processor Channel 0"},
  2555		{"Sub Mux", "ADC/DMic 1 Left Plus Right", "Input Processor Channel 1"},
  2556		{"Sub Mux", "DMic 2 Left", "DMic 2"},
  2557		{"Sub Mux", "DMic 2 Right", "DMic 2"},
  2558		{"Sub Mux", "DMic 2 Left Plus Right", "DMic 2"},
  2559		{"Sub Mux", "ClassD Left", "ClassD Left"},
  2560		{"Sub Mux", "ClassD Right", "ClassD Right"},
  2561		{"Sub Mux", "ClassD Left Plus Right", "ClassD Left"},
  2562		{"Sub Mux", "ClassD Left Plus Right", "ClassD Right"},
  2563		{"Sub", NULL, "Sub Mux"},
  2564		{"Sub", NULL, "PLLs"},
  2565		{"Sub Out", NULL, "Sub Power"},
  2566		{"Sub Out", NULL, "Sub"},
  2567		/*****************
  2568		 * Capture Paths *
  2569		 *****************/
  2570		{"Input Boost Channel 0 Mux", "Input 3", "Line In 3 Left"},
  2571		{"Input Boost Channel 0 Mux", "Input 2", "Line In 2 Left"},
  2572		{"Input Boost Channel 0 Mux", "Input 1", "Line In 1 Left"},
  2573		{"Input Boost Channel 0 Mux", "D2S", "D2S 1"},
  2574	
  2575		{"Input Boost Channel 1 Mux", "Input 3", "Line In 3 Right"},
  2576		{"Input Boost Channel 1 Mux", "Input 2", "Line In 2 Right"},
  2577		{"Input Boost Channel 1 Mux", "Input 1", "Line In 1 Right"},
  2578		{"Input Boost Channel 1 Mux", "D2S", "D2S 2"},
  2579	
  2580		{"ADC Channel 0 Mux", "Input 3 Boost Bypass", "Line In 3 Left"},
  2581		{"ADC Channel 0 Mux", "Input 2 Boost Bypass", "Line In 2 Left"},
  2582		{"ADC Channel 0 Mux", "Input 1 Boost Bypass", "Line In 1 Left"},
  2583		{"ADC Channel 0 Mux", "Input Boost", "Input Boost Channel 0 Mux"},
  2584	
  2585		{"ADC Channel 1 Mux", "Input 3 Boost Bypass", "Line In 3 Right"},
  2586		{"ADC Channel 1 Mux", "Input 2 Boost Bypass", "Line In 2 Right"},
  2587		{"ADC Channel 1 Mux", "Input 1 Boost Bypass", "Line In 1 Right"},
  2588		{"ADC Channel 1 Mux", "Input Boost", "Input Boost Channel 1 Mux"},
  2589	
  2590		{"Input Processor Channel 0 Mux", "ADC", "ADC Channel 0 Mux"},
  2591		{"Input Processor Channel 0 Mux", "DMic", "DMic 1"},
  2592	
  2593		{"Input Processor Channel 0", NULL, "PLLs"},
  2594		{"Input Processor Channel 0", NULL, "Input Processor Channel 0 Mux"},
  2595	
  2596		{"Input Processor Channel 1 Mux", "ADC", "ADC Channel 1 Mux"},
  2597		{"Input Processor Channel 1 Mux", "DMic", "DMic 1"},
  2598	
  2599		{"Input Processor Channel 1", NULL, "PLLs"},
  2600		{"Input Processor Channel 1", NULL, "Input Processor Channel 1 Mux"},
  2601	
  2602		{"Input Processor Channel 2", NULL, "PLLs"},
  2603		{"Input Processor Channel 2", NULL, "DMic 2"},
  2604	
  2605		{"Input Processor Channel 3", NULL, "PLLs"},
  2606		{"Input Processor Channel 3", NULL, "DMic 2"},
  2607	
  2608		{"DAI 1 Out Mux", "ADC/DMic 1", "Input Processor Channel 0"},
  2609		{"DAI 1 Out Mux", "ADC/DMic 1", "Input Processor Channel 1"},
  2610		{"DAI 1 Out Mux", "DMic 2", "Input Processor Channel 2"},
  2611		{"DAI 1 Out Mux", "DMic 2", "Input Processor Channel 3"},
  2612	
  2613		{"DAI 2 Out Mux", "ADC/DMic 1", "Input Processor Channel 0"},
  2614		{"DAI 2 Out Mux", "ADC/DMic 1", "Input Processor Channel 1"},
  2615		{"DAI 2 Out Mux", "DMic 2", "Input Processor Channel 2"},
  2616		{"DAI 2 Out Mux", "DMic 2", "Input Processor Channel 3"},
  2617	
  2618		{"DAI 3 Out Mux", "ADC/DMic 1", "Input Processor Channel 0"},
  2619		{"DAI 3 Out Mux", "ADC/DMic 1", "Input Processor Channel 1"},
  2620		{"DAI 3 Out Mux", "DMic 2", "Input Processor Channel 2"},
  2621		{"DAI 3 Out Mux", "DMic 2", "Input Processor Channel 3"},
  2622	
  2623		{"DAI 1 Out", NULL, "DAI 1 Out Mux"},
  2624		{"DAI 2 Out", NULL, "DAI 2 Out Mux"},
  2625		{"DAI 3 Out", NULL, "DAI 3 Out Mux"},
  2626	};
  2627	
  2628	/* This is used when BCLK is sourcing the PLLs */
> 2629	int tscs454_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int freq,
  2630			int dir)
  2631	{
  2632		struct snd_soc_component *component = dai->component;
  2633		struct tscs454 *tscs454 = snd_soc_component_get_drvdata(component);
  2634		unsigned int val;
  2635		int bclk_dai;
  2636		int ret;
  2637	
  2638		dev_dbg(component->dev, "%s(): freq = %u\n", __func__, freq);
  2639	
  2640		ret = snd_soc_component_read(component, R_PLLCTL, &val);
  2641		if (ret < 0)
  2642			return ret;
  2643	
  2644		bclk_dai = (val & FM_PLLCTL_BCLKSEL) >> FB_PLLCTL_BCLKSEL;
  2645		if (bclk_dai != dai->id)
  2646			return 0;
  2647	
  2648		tscs454->bclk_freq = freq;
  2649		return set_sysclk(component);
  2650	}
  2651	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
