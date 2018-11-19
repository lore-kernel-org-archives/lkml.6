Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EE3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ED42080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ED42080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbeKTBFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:05:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:2900 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbeKTBFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:05:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 06:41:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="109517985"
Received: from dmcollin-mobl.amr.corp.intel.com (HELO [10.254.97.13]) ([10.254.97.13])
  by orsmga001.jf.intel.com with ESMTP; 19 Nov 2018 06:41:15 -0800
Subject: Re: sound/soc/intel/skylake/skl.c:874: undefined reference to
 `snd_soc_hdac_hda_get_ops'
To:     kbuild test robot <lkp@intel.com>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <201811192142.918eowM7%fengguang.wu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a6129d18-7c0d-d458-f401-c79643897b80@linux.intel.com>
Date:   Mon, 19 Nov 2018 08:41:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <201811192142.918eowM7%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Th

On 11/19/18 7:26 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9ff01193a20d391e8dbce4403dd5ef87c7eaaca6
> commit: 6bae5ea9498926440ffc883f3dbceb0adc65e492 ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers
> date:   3 months ago
> config: i386-randconfig-x078-11191627 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>          git checkout 6bae5ea9498926440ffc883f3dbceb0adc65e492
>          # save the attached .config to linux build tree
>          make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>     sound/soc/intel/skylake/skl.o: In function `skl_create':
>>> sound/soc/intel/skylake/skl.c:874: undefined reference to `snd_soc_hdac_hda_get_ops'

the patches I submitted yesterday as RFC to alsa-devel fix this issue, 
HDAC_HDA is selected directly by the SKYLAKE driver. will do a bit more 
validation and resubmit as regular patch.


> vim +874 sound/soc/intel/skylake/skl.c
>
>     844	
>     845	/*
>     846	 * constructor
>     847	 */
>     848	static int skl_create(struct pci_dev *pci,
>     849			      const struct hdac_io_ops *io_ops,
>     850			      struct skl **rskl)
>     851	{
>     852		struct hdac_ext_bus_ops *ext_ops = NULL;
>     853		struct skl *skl;
>     854		struct hdac_bus *bus;
>     855		struct hda_bus *hbus;
>     856		int err;
>     857	
>     858		*rskl = NULL;
>     859	
>     860		err = pci_enable_device(pci);
>     861		if (err < 0)
>     862			return err;
>     863	
>     864		skl = devm_kzalloc(&pci->dev, sizeof(*skl), GFP_KERNEL);
>     865		if (!skl) {
>     866			pci_disable_device(pci);
>     867			return -ENOMEM;
>     868		}
>     869	
>     870		hbus = skl_to_hbus(skl);
>     871		bus = skl_to_bus(skl);
>     872	
>     873	#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
>   > 874		ext_ops = snd_soc_hdac_hda_get_ops();
>     875	#endif
>     876		snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, ext_ops);
>     877		bus->use_posbuf = 1;
>     878		skl->pci = pci;
>     879		INIT_WORK(&skl->probe_work, skl_probe_work);
>     880		bus->bdl_pos_adj = 0;
>     881	
>     882		mutex_init(&hbus->prepare_mutex);
>     883		hbus->pci = pci;
>     884		hbus->mixer_assigned = -1;
>     885		hbus->modelname = "sklbus";
>     886	
>     887		*rskl = skl;
>     888	
>     889		return 0;
>     890	}
>     891	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
