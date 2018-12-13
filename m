Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9A8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF2620870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544706680;
	bh=vx3UfyT37qi7YNjRu6FHKzxpzFiS7e/mXCYEG0g4ggo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DZd3UfwCLt8GIh6HEA3K4pG20JCD7UUYjhvX627xT5q9YEHWgCYUWn0WBT8x40WmZ
	 A52KfmHpQ2ioE2GE8boV5mf060qYLuWTOS2KJ15p5TDM3hRcRyKr7WkKLLQVfAGOPP
	 Si6UjnnY299jtvRdCy4g5yVB3G/Zy4Ys+ybZVECE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF2620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeLMNLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:11:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbeLMNLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:11:18 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B76020849;
        Thu, 13 Dec 2018 13:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544706677;
        bh=vx3UfyT37qi7YNjRu6FHKzxpzFiS7e/mXCYEG0g4ggo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0EvGRf7j3qprC/guCKh8qJ2x3DqCKeLCu65sohMDSc7UVFnoLeyqf6bd1d/GsLeT
         /KF+/n15b4SDoeSJlyfnDPIEcYYB3Y7FJ/XQefQAEONmH2e4/wPKIIrnk3ByWns2cl
         kvXCl9oZBFWPPoCkf9BE2P5V7ibLy8CXEThUGWas=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EE48E41B1D; Thu, 13 Dec 2018 10:11:13 -0300 (-03)
Date:   Thu, 13 Dec 2018 10:11:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v3 0/8] perf cs-etm: Correct packets handling
Message-ID: <20181213131113.GH21027@kernel.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <CANLsYkyFZqUYghGmSS-j50EaOvce57CP+Y737xRF3HjPrHDVqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkyFZqUYghGmSS-j50EaOvce57CP+Y737xRF3HjPrHDVqw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 12, 2018 at 11:45:44AM -0700, Mathieu Poirier escreveu:
> On Tue, 11 Dec 2018 at 00:40, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > perf cs-etm module converts decoder elements to packets and then we have
> > more context crossing packets to generate synthenize samples, finally
> > perf tool can faciliate samples for statistics and report the results.
> >
> > This patch series is to address several issues found related with
> > packets handling and samples generation when worked firstly on branch
> > sample flags support for Arm CoreSight trace data, so this patch series
> > is dependency for sample flags setting, will send another dedicated
> > patch series for sample flags later.
> >
> > In this patch series, the first two patches are mainly to fix issues in
> > cs_etm__flush(): patch 0001 corrects packets swapping in cs_etm__flush()
> > and this can fix the wrong branch sample caused by the missed packets
> > swapping; patch 0002 is to fix the wrong samples generation with stale
> > packets at the end of trace block.
> >
> > Patch 0003 and 0004 are for minor fixing; patch 0003 removes unused field
> > 'cs_etm_decoder::trace_on', this can simplize the switch-case code for all
> > discontinuity packet generation by using one code block; patch 0004 is to
> > refactor enumeration cs_etm_sample_type.
> >
> > Patch 0005 is to rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY, we use
> > a more general packet type to present trace discontinuity, so it can be
> > used by TRACE_ON event, and also can be used by NO_SYNC and EO_TRACE
> > elements.
> >
> > Patch 0006 is used to support NO_SYNC packet, otherwise the trace
> > decoding cannot reflect the tracing discontinuity caused by NO_SYNC
> > packet.
> >
> > Patch 0007 is used to support EO_TRACE packet, which also introduces
> > the tracing discontinuity at the end of trace and we should save last
> > trace data for it.
> >
> > Patch 0008 is used to generate branch sample for exception packets.
> >
> > Credit to Mike Leach and Robert Walker who made me clear for underlying
> > mechanism for NO_SYNC/EO_TRACE elements, Mike also shared the detailed
> > explanation for why we can treat NO_SYNC and TRACE_ON elements as the
> > same, so except following Mike & Rob suggestion for trace discontinuity
> > consolidation, most commit log of patches 0006/0007 also come from
> > Mike's explanation.
> >
> > This patch series is applied directly on the acme's perf/core branch [1]
> > with latest commit aaab25f03e9e ("perf trace: Allow selecting use the
> > use of the ordered_events code").
> >
> > With applying the dependency patch, this patch series has been tested
> > for branch samples dumping with below command on Juno board:
> >
> >   # perf script -F,-time,+ip,+sym,+dso,+addr,+symoff -k vmlinux
> 
> Good day Arnaldo,
> 
> I have reviewed all the changes in this set - please consider adding
> to your next branch.  Let me know if you want a pull request.

Thanks, applied manually, pushing now to my tmp.perf/core branch, please
take a look at the commit log messages to see if I didn't messed up
anything. :-)

- Arnaldo
