Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC151C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5A52190A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545438442;
	bh=6IkoMxUDeM8KFBGRVzD12zvIf4Q6If4P2+cTkGUhIX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NPj3QTKFPCP2TqeAOcvksOySNd11sHHzTTWBaH5Ckxod+tIvtZ6Jp+5NoFBGXyvzg
	 odl+8ZULChyYOrNWCl/H/dUnPQ9xcNv5nK5P6jdUDEOl47I3AVzC9CNX2R3vCfHgeV
	 u6hTitgkPTgaUuiLpwyetWjt9Tq5BGZ9hqWmCRW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390898AbeLVA1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:27:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:51018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387684AbeLVA1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:27:20 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 717BC2190A;
        Sat, 22 Dec 2018 00:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545438439;
        bh=6IkoMxUDeM8KFBGRVzD12zvIf4Q6If4P2+cTkGUhIX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XltnPW7/UGVrxrQxqhQtnhkTBYPJ/ZsEEGcKd2qa3N9Pkg1kkb5r7xan991YrHzIC
         joc3xMOSiZ6jKt6jWA2WGwZDYynak/l6NvMAc1dwED/5wXwmVm2ZPEPTV0FrxAZWNE
         IGuhQ87zJreW/2D/Sx6IMLUsdf+c7vawhxZEC3gs=
Date:   Fri, 21 Dec 2018 19:27:18 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Jinpu Wang <jinpuwang@gmail.com>
Cc:     "Greensky, James J" <james.j.greensky@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v3.14+, only the raid10 part" <stable@vger.kernel.org>
Subject: Re: Fix "perf tools: Synthesize GROUP_DESC feature in pipe mode" in
 the LT 4.14 branch
Message-ID: <20181222002718.GL86645@sasha-vm>
References: <05BD5679F4A9234798A0693ABF94E75ADFF7F3A5@ORSMSX101.amr.corp.intel.com>
 <CAD9gYJKvcn5kzMKhHU2UO=99Vdus_v=5D-fZb6-+Fy=gDokZFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD9gYJKvcn5kzMKhHU2UO=99Vdus_v=5D-fZb6-+Fy=gDokZFA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:57:53AM +0100, Jinpu Wang wrote:
>+cc Greg, stable
>
>Greensky, James J <james.j.greensky@intel.com> 于2018年12月21日周五 上午11:48写道：
>>
>> Commit d38d272592737ea88a20 ("perf tools: Synthesize GROUP_DESC feature in pipe mode") broke the LT 4.14 branch when using event groups in pipe-mode.
>>
>>   # perf record -e '{cycles,instructions,branches}' -- sleep 4 | perf report
>>   # To display the perf.data header info, please use --header/--header-only options
>>   #
>>   Oxd7c [0x60]: failed to process type: 80
>>   Error:
>>   Failed to process sample
>>
>> Commit a2015516c5c0be932a69 ("perf record: Synthesize features before events in pipe mode") is the fix. Can we get this cherry-picked and applied?

I've queued d38d272592737ea88a20 for 4.14, thank you.

--
Thanks,
Sasha
