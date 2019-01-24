Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D22CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB8F218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfAXTH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:07:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:52886 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfAXTH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:07:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 11:07:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="128634601"
Received: from agunda-mobl1.amr.corp.intel.com (HELO [10.251.156.62]) ([10.251.156.62])
  by orsmga002.jf.intel.com with ESMTP; 24 Jan 2019 11:07:18 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
To:     Mark Brown <broonie@kernel.org>
Cc:     rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        lgirdwood@gmail.com, Curtis Malainey <cujomalainey@google.com>,
        plai@codeaurora.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <ajitp@codeaurora.org>, tiwai@suse.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Matthias Reichl <hias@horus.com>,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        srinivas.kandagatla@linaro.org,
        Curtis Malainey <cujomalainey@chromium.org>,
        Dylan Reid <dgreid@google.com>
References: <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
 <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
 <c6721670-cf89-5d21-953d-c1fa10d87367@linux.intel.com>
 <CAOReqxgG4TJDXKCEVcDVXvpi_mnLUzqLwF7Rp0H5iAPdbMuZ_Q@mail.gmail.com>
 <44029078-2749-5a3b-7b03-f38461bf268f@linux.intel.com>
 <20190124184412.GH5641@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <976ec85a-7b21-6c58-90cc-a3d104f9505a@linux.intel.com>
Date:   Thu, 24 Jan 2019 13:07:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124184412.GH5641@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> changes are legitimate. To move forward, maybe it's not worth spending too
>> much time on a grand unification of string theory, there are simpler
>> solutions: the Intel machine drivers already do get the platform driver name
>> as an platform_data argument, so we could modify the dailinks platform names
>> before even registering the card. I tested with the attached
> Yes, that would be much better - it's vastly more idiomatic.  The
> general idea is that a machine driver should know what it's expecting to
> find before it starts probing.

Thanks for the feedback, will send a formal patch with the helper and 
machine driver changes after I test more with the legacy drivers. Do you 
have a preference for one patch that deals with multiple machines 
drivers in one shot, or individual patches? The latter are nicer for 
backports (e.g. for Chrome), the former nicer for maintainers...

The goal of reusing machine drivers as is isn't really achievable 
anyways, it looks like we are going to have additional changes, e.g. if 
we want to avoid the calls to snd_pcm_suspend as suggested by Takashi, 
we'll have to add a reference to snd_soc_pm_ops that's only used for 
SOF, the Atom/SST driver does things in different ways mostly due to 
historical reasons.

-Pierre

