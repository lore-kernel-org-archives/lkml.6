Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE54020883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfARPSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:18:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:3620 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfARPSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:18:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 07:18:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="139412029"
Received: from unknown (HELO localhost) ([10.249.254.249])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2019 07:18:30 -0800
Date:   Fri, 18 Jan 2019 17:18:27 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, tweek@google.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm/eventlog/tpm1: Simplify walking over *pos
 measurements
Message-ID: <20190118151827.GK4080@linux.intel.com>
References: <1547197173-52826-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547197173-52826-2-git-send-email-zhang.jia@linux.alibaba.com>
 <20190116220952.GH25803@linux.intel.com>
 <8709dd61-2422-1c20-9937-d6003fa0354e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8709dd61-2422-1c20-9937-d6003fa0354e@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 09:32:55AM +0800, Jia Zhang wrote:
> 
> 
> On 2019/1/17 上午6:09, Jarkko Sakkinen wrote:
> > Please use "tpm:" tag for commits, not "tpm/eventlog/tpm1".
> > 
> > On Fri, Jan 11, 2019 at 04:59:32PM +0800, Jia Zhang wrote:
> >> The responsibility of tpm1_bios_measurements_start() is to walk
> >> over the first *pos measurements, ensuring the skipped and
> >> to-be-read measurements are not out-of-boundary.
> >>
> >> Current logic is complicated a bit. Just employ a do-while loop
> >> with necessary sanity check, and then get the goal.
> >>
> >> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> > 
> > What does this fix? Even if the current logic is "complicated", it is
> > still a pretty simple functiion.
> 
> 
> OK. Let me point out the fix part. Here is the original implementation:
> 
>  87         /* read over *pos measurements */
>  88         for (i = 0; i < *pos; i++) {
>  89                 event = addr;
>  90
>  91                 converted_event_size =
>  92                     do_endian_conversion(event->event_size);
>  93                 converted_event_type =
>  94                     do_endian_conversion(event->event_type);
>  95
>  96                 if ((addr + sizeof(struct tcpa_event)) < limit) {
>  97                         if ((converted_event_type == 0) &&
>  98                             (converted_event_size == 0))
>  99                                 return NULL;
> 100                         addr += (sizeof(struct tcpa_event) +
> 101                                  converted_event_size);
> 102                 }
> 103         }
> 
> The problem (just ignore all off-by-1 issues) is that accessing to
> event_size and event_type is not pre-checked carefully. In the latter
> part of tpm1_bios_measurements_start() and
> tpm1_bios_measurements_next(), there is a fixed patter to do the sanity
> check like this:
> 
> 136         /* now check if current entry is valid */
> 137         if ((v + sizeof(struct tcpa_event)) >= limit)
> 138                 return NULL;
> 
> So if we simply change this read-over chunk with sanity check like this:
> 
>         /* read over *pos measurements */
>         for (i = 0; i < *pos; i++) {
>                 event = addr;
> 
>                 if ((addr + sizeof(struct tcpa_event)) >= limit)
>                         return NULL;
> 
>                 converted_event_size =
>                     do_endian_conversion(event->event_size);
>                 converted_event_type =
>                     do_endian_conversion(event->event_type);
> 
>                 if ((converted_event_type == 0) &&
>                     (converted_event_size == 0))
>                         return NULL;
>                 addr += (sizeof(struct tcpa_event) +
>                          converted_event_size);
>         }
> 
> We will get two highly similar code chunks in
> tpm1_bios_measurements_start(). Here is the latter part:
> 
> 106         /* now check if current entry is valid */
> 107         if ((addr + sizeof(struct tcpa_event)) >= limit)
> 108                 return NULL;
> 109
> 110         event = addr;
> 111
> 112         converted_event_size = do_endian_conversion(event->event_size);
> 113         converted_event_type = do_endian_conversion(event->event_type);
> 114
> 115         if (((converted_event_type == 0) && (converted_event_size == 0))
> 116             || ((addr + sizeof(struct tcpa_event) +
> converted_event_size)
> 117                 >= limit))
> 118                 return NULL;
> 119
> 120         return addr;
> 
> So using a do while logic can simply merge them together and thus simply
> and optimize the logic of walking over *pos measurements.
> 
> Sorry I admit my initial motivation is to fix up the sanity check
> problem. If you would like to accept the optimization part, I will split
> this patch.

OK, got it now. I think I will apply this! Will take a while because
of https://lkml.org/lkml/2019/1/18/485. Will not apply new patches
before that is rooted.

/Jarkko
