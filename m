Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366DAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE2321726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfAVULu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:11:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:62902 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfAVULs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:11:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 12:11:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,508,1539673200"; 
   d="scan'208";a="312508837"
Received: from djbetows-mobl.amr.corp.intel.com (HELO [10.254.50.13]) ([10.254.50.13])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jan 2019 12:11:46 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com,
        Ajit Pandey <ajitp@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Matthias Reichl <hias@horus.com>,
        Mark Brown <broonie@kernel.org>,
        srinivas.kandagatla@linaro.org, asishb@codeaurora.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Dylan Reid <dgreid@google.com>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
 <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c6721670-cf89-5d21-953d-c1fa10d87367@linux.intel.com>
Date:   Tue, 22 Jan 2019 14:11:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The issue was that we were seeing a memory corruption bug on an AMD
> chromebooks with that function already (not observed on Intel). I was
> testing some SOF integrations and was seeing this in the kernel logs.
> I had Dylan verify my logic before I sent the patch because it took so
> long to identify the bug and it was traced to the patch that introduce
> soc_init_platform.
>
> [   10.922112] cz-da7219-max98357a AMD7219:00: ASoC: CPU DAI
> designware-i2s.1.auto not registered
> [   10.922122] cz-da7219-max98357a AMD7219:00:
> devm_snd_soc_register_card(acpd7219m98357) failed: -517
> [   11.001411] cz-da7219-max98357a AMD7219:00: ASoC: Both platform
> name/of_node are set for amd-max98357-play
> [   11.001423] cz-da7219-max98357a AMD7219:00: ASoC: failed to init
> link amd-max98357-play
> [   11.001431] cz-da7219-max98357a AMD7219:00:
> devm_snd_soc_register_card(acpd7219m98357) failed: -22
> [   11.001577] cz-da7219-max98357a: probe of AMD7219:00 failed with error -22
>
> of_node was never getting set but the pointer was becoming populated
> (outside of the probe call) which traced to soc_init_platform function
> which was not reallocating memory on a EPROBE_DEFER even though it was
> getting freed by devm. I am not very familiar with devm but my local
> maintainers say that it should be freeing the memory even on a
> PROBE_DEFER.
> The patch should mirror the memory behaviour in
> snd_soc_init_multicodec which also reallocates its memory on every
> probe. I'm not sure how the patch is causing you to defer, is your
> component list corrupt?
>
> Sorry for the duplicate spam, forgot to send via plain text mode,
> re-sending for the mailing list so it gets accepted.

There is no defer issue with the intel stuff, but we call this routine 
multiple times

snd_soc_register_card

--soc_init_dai_link

----snd_soc_init_platform

-- soc_soc_bind_card

----snd_soc_instantiate_card

------ soc_check_tplg_fes

-------- snd_soc_init_platform << ALLOC1

--------soc_init_dai_link

----------snd_soc_init_platform << ALLOC2

Initially dai_link->legacy_platform is 0, so gets set after the first 
first devm_kzalloc (ALLOC1) and after that we always allocate new memory 
(ALLOC2). The end result is that whatever we set in soc_check_tplg_fes 
is lost with the new/unnecessary alloc.

I would guess your solution is also a work-around, if devm_ effectively 
freed the memory then the pointer would become NULL. Or may that's the 
issue is that no one actually resets it.



