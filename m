Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C69C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF39220821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF39220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbeLJUmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:42:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:46031 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbeLJUmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:42:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 12:42:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="117229612"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.96]) ([10.24.14.96])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2018 12:42:14 -0800
Subject: Re: [PATCH] x86/resctrl: Fix rdt_find_domain() return value checks
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        jithu.joseph@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <d932648504b745cb51c4a440710c7a1ca9830eca.1543427858.git.reinette.chatre@intel.com>
 <20181210191311.GC5482@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <40422756-cef4-38b1-8554-c99e7bcb7765@intel.com>
Date:   Mon, 10 Dec 2018 12:42:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181210191311.GC5482@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 12/10/2018 11:13 AM, Borislav Petkov wrote:
> On Wed, Nov 28, 2018 at 10:20:27AM -0800, Reinette Chatre wrote:
>> rdt_find_domain() may return an ERR_PTR(), NULL, or a pointer to struct
>> rdt_domain. It is thus required that the return value be checked for the
>> possibility of an ERR_PTR as well as NULL.
> 
> Well, it returns ERR_PTR(id) but code which uses ERR_PTR passes in an -E
> value, for example ERR_PTR(-EINVAL) or so, and not an id.
> 
> And that might work now if id fits within that MAX_ERRNO range - I'm
> looking at include/linux/err.h - but that's still fragile.
> 

Thank you for catching this.

It does seem as though things work at this time since rdt_find_domain()
contains:

if (id < 0)
        return ERR_PTR(id);

and from what I can tell the only possible negative value of id is -1.

As you note, this is fragile. Additionally the error, if intending to
use -E values, does not reflect the error (since -1 would mean EPERM).

Would you be ok if the above is changed to

if (id < 0)
        return ERR_PTR(-ENOENT);

as part of this patch?

Looking at rdtgroup_mondata_show() is does seem as though ENOENT is the
actual intended error value, although ENODEV could perhaps also be
considered since such a result reflects that a particular cache instance
could not be found.

Thank you!

Reinette

