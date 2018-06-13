Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D99C8C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1845420891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1845420891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935200AbeFMKUU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:20:20 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:55011 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934947AbeFMKUS (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:4:1>);
        Wed, 13 Jun 2018 06:20:18 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 13 Jun 2018 04:20:18 -0600
Message-Id: <5B20EFE102000078001CACD4@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Wed, 13 Jun 2018 04:20:17 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] xen: don't use privcmd_call() from
 xen_mc_flush()
References: <20180613095806.2978-1-jgross@suse.com>
 <5B20EC6C02000078001CACBA@prv1-mh.provo.novell.com>
In-Reply-To: <5B20EC6C02000078001CACBA@prv1-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 13.06.18 at 12:05, <JBeulich@suse.com> wrote:
>>>> On 13.06.18 at 11:58, <jgross@suse.com> wrote:
>> Using privcmd_call() for a singleton multicall seems to be wrong, as
>> privcmd_call() is using stac()/clac() to enable hypervisor access to
>> Linux user space.
>> 
>> Add a new xen_single_call() function to be use for that purpose.
>> 
>> Reported-by: Jan Beulich <jbeulich@suse.com>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> Reviewed-by: Jan Beulich <jbeulich@suse.com>

Actually I've only now realized that this isn't a real problem right now:
PV can't use SMAP (we don't provide a virtualized version of it), and
HVM/PVH can't use multicalls (which may have to change for PVH Dom0,
so having the change in place is helpful anyway), so the whole
in-kernel logic to collect and issue batches should be unreachable there.

But perhaps the commit message would benefit from a little bit of
re-wording.

Jan


