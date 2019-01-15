Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941D8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C1A20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390328AbfAOVQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:16:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:30617 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730655AbfAOVQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:16:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 13:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,483,1539673200"; 
   d="scan'208";a="126150815"
Received: from linayu-mobl.amr.corp.intel.com (HELO [10.252.197.109]) ([10.252.197.109])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jan 2019 13:16:57 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
To:     Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>,
        rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        lgirdwood@gmail.com, plai@codeaurora.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        srinivas.kandagatla@linaro.org,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        Ajit Pandey <ajitp@codeaurora.org>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
Date:   Tue, 15 Jan 2019 15:16:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Beyond the fact that the platform_name seems to be totally useless,
>> additional tests show that the patch ('ASoC: soc-core: defer card probe
>> until all component is added to list') adds a new restriction which
>> contradicts existing error checks.
>>
>> None of the Intel machine drivers set the dailink "cpu_name" field but use
>> the "cpu_dai_name" field instead. This was perfectly legit as documented by
>> the code at the end of soc_init_dai_link()
> This should be fixed by the patch
> "ASoC: core: Don't defer probe on optional, NULL components" which Mark
> already applied to his tree. See
> http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144323.html

Ah yes, I missed this patch while I was debugging. Indeed this fixes the 
problem and my devices work again with Mark's for-next branch. Thanks 
Matthias!

>
> Maybe the defer card probe logic needs to be extended to also check if
> dai_link_name had already been registered (either cpu or cpu_dai_name
> needs to be set), not 100% sure which problem the defer card probe patch
> was trying to solve.
same here, I don't get why the deferred probe stuff only deals with one 
of the two options.

