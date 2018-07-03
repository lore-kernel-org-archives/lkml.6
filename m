Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE1FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4D420855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4D420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbeGCK6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:58:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:64863 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752197AbeGCK57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:57:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 03:57:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,303,1526367600"; 
   d="scan'208";a="69263352"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2018 03:56:55 -0700
Received: from ash by um with local (Exim 4.91)
        (envelope-from <alexander.shishkin@linux.intel.com>)
        id 1faIzM-0003Ul-Qb; Tue, 03 Jul 2018 13:56:52 +0300
Date:   Tue, 3 Jul 2018 13:56:52 +0300
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, peterz@infradead.org,
        acme@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
Message-ID: <20180703105652.psjq5cq4t7o2j6zk@um.fi.intel.com>
Mail-Followup-To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org>
 <20180703100348.fy43f4fosw3fdc6i@um.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703100348.fy43f4fosw3fdc6i@um.fi.intel.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:03:48PM +0300, Alexander Shishkin wrote:
> On Mon, Jul 02, 2018 at 04:33:29PM -0600, Mathieu Poirier wrote:
> > +/*
> > + * PMU driver configuration works the same way as filter management above,
> > + * but without the need to deal with memory mapping.  Driver configuration
> > + * arrives through the SET_DRV_CONFIG ioctl() where it is validated and applied
> > + * to the event.  When the PMU is ready it calls perf_event_drv_config_sync() to
> > + * bring the configuration information within reach of the PMU.
> 
> Wait a second. The reason why we dance around with the generations of filters
> is the locking order of ctx::mutex vs mmap_sem. In an mmap path, where we're
> notified about mapping changes, we're called under the latter, and we'd need
> to grab the former to update the event configuration. In your case, the
> update comes in via perf_ioctl(), where we're already holding the ctx::mutex,
> so you can just kick the PMU right there, via an event_function_call() or
> perf_event_stop(restart=1). In the latter case, your pmu::start() would just
> grab the new configuration. Should also be about 90% less code. :)

Also, since it affects the AUX buffer configuration, it is probably a one
time ioctl command that you issue before you mmap the buffer. If that's
the case, you don't even have to worry about stopping the event, as it
shouldn't be running, because without the buffer perf_aux_output_begin()
should fail and so should the pmu::add() iirc.

Regards,
--
Alex
