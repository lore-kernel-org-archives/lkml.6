Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5CFC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AB720855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AB720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeLJVmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:42:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:4805 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbeLJVmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:42:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 13:42:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="117241378"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.96]) ([10.24.14.96])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2018 13:42:10 -0800
Subject: Re: [PATCH] x86/resctrl: Fix rdt_find_domain() return value checks
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        jithu.joseph@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <d932648504b745cb51c4a440710c7a1ca9830eca.1543427858.git.reinette.chatre@intel.com>
 <20181210191311.GC5482@zn.tnic>
 <40422756-cef4-38b1-8554-c99e7bcb7765@intel.com>
 <20181210210436.GI5482@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <3b097a0a-bcc5-1929-eb50-0e251ebc1152@intel.com>
Date:   Mon, 10 Dec 2018 13:42:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181210210436.GI5482@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 12/10/2018 1:04 PM, Borislav Petkov wrote:
> On Mon, Dec 10, 2018 at 12:42:14PM -0800, Reinette Chatre wrote:
>> Would you be ok if the above is changed to
>>
>> if (id < 0)
>>         return ERR_PTR(-ENOENT);
>>
>> as part of this patch?
> 
> Yap.
> 
>> Looking at rdtgroup_mondata_show() is does seem as though ENOENT is the
>> actual intended error value,
> 
> #define ENOENT           2      /* No such file or directory */
> 
>> although ENODEV could perhaps also be considered since such a result
>> reflects that a particular cache instance could not be found.
> 
> #define ENODEV          19      /* No such device */
> 
> Yeah, they both kinda look ok to me and in the end of the day, the thing
> that matters most is pinpointing the place in the code which causes the
> error.

Thank you for the sanity check. I think ENODEV may reflect the issue
better and will do so in the next version. This would not affect the
current code (quoted below) that subsequently translates the error to
ENOENT.

> And looking at that particular part:
> 
>         r = &rdt_resources_all[resid];
>         d = rdt_find_domain(r, domid, NULL);
>         if (!d) {
>                 ret = -ENOENT;
>                 goto out;
>         }
> 
> You *could* put in there something like:
> 
> 	seq_printf(m, "Cannot find a domain for resource ID: %d\n", domid);
> 
> and this way it is perfectly clear which error path it is.
> 
> :-)
> 

From what I understand this scenario should never happen - at the time
knowledge of the resource instance is removed then these mondata files
referring to it will be removed also. Even so, I'd prefer not to make
any user visible changes without a specific requirement or need to do
so. In this case ENOENT is the only error code returned during this user
space interaction so from what I can tell it is currently clear which
error path it is.

Reinette
