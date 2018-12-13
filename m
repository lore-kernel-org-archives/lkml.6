Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C632C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4179D2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZOwCjhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4179D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbeLMNbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:31:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34570 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbeLMNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:31:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so2047099wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 05:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HkEUVoqr9/FZA6SfGZutf6vi5PAgBI/VuaNwhT/f7sY=;
        b=NZOwCjhV9My9FWWRDmY0b2weYUFopS0LMFQxJyjW5vEjblPc5RrmWW0jtdXy5l4VGp
         YMU/SBFKArm+hMcL0G+v6zwOtx2Rln9kuxN9ziObfhi7JywX0EyZGAeAzGbg1DAS+Ubj
         PKhtRRX+SPW8y/5QnJOi+PS5PaiiuovmMsX9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HkEUVoqr9/FZA6SfGZutf6vi5PAgBI/VuaNwhT/f7sY=;
        b=bC930ChR9eb3AR+F6gNgZupZI7GHAhdgwcYeBrpLG0qZKMcT4faWmQ/Y9kqWvJ0Gs0
         rZFOdN19R1ovqzwdlor4jifoHE9/LULievr8tuE2s62T4zFs0FP0wrktt2mfxivag0ML
         658M22iGgzEXoH8i4Iw1XTfEY71WIIO4w1fdTBPNX9FY+guggVjcXnOxm4814iiuSvRp
         sALlFGmRPL/LNa2M9XEJcntaHOcW890hvbZ2c0Ndw9RGn3lD1qB765VESO1TtMENIgj8
         77XB4f7BbtVorMzOkC3zXZ7psp7UZzYKunpXlzJQ6FmjcHj+28WeiOE+yYY17ptAVOZn
         +DDQ==
X-Gm-Message-State: AA+aEWZdz7e3n8SdGsuL/XPysbcSdF9o6KL7dOQ9UHP1YfN7jb75FZtv
        7aD17+smRtBabuYOv4HFaaO8PJcy9ZUmv14H
X-Google-Smtp-Source: AFSGD/UDy24vnLJwoqdlHBmlGpu/oU3hXgYXuqlb39wQMaVgnXU8FmvHiyGsgPGBs3XMFVTkIsKmpw==
X-Received: by 2002:adf:8122:: with SMTP id 31mr21646316wrm.48.1544707902217;
        Thu, 13 Dec 2018 05:31:42 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id k128sm2456292wmd.37.2018.12.13.05.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 05:31:41 -0800 (PST)
Date:   Thu, 13 Dec 2018 21:31:31 +0800
From:   leo.yan@linaro.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>
Subject: Re: [PATCH v3 6/8] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Message-ID: <20181213133131.GD17663@leoy-ThinkPad-X240s>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
 <20181213123854.GE21027@kernel.org>
 <20181213124154.GF21027@kernel.org>
 <20181213130949.GB17663@leoy-ThinkPad-X240s>
 <20181213132126.GI21027@kernel.org>
 <20181213132633.GJ21027@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213132633.GJ21027@kernel.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:26:33AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 13, 2018 at 10:21:26AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Dec 13, 2018 at 09:09:49PM +0800, leo.yan@linaro.org escreveu:
> > > Thanks a lot for helping.  If you prefer me to resend the patch set,
> > > also let me know.
> > 
> > I can fix it, here.
> 
> Can I take a look at the result:
> 
> https://git.kernel.org/acme/c/222b0bead7e4

Yeah, looks good to me :)

Thanks,
Leo Yan
