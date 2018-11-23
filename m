Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1E2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BBF20645
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="X28nRSx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BBF20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408510AbeKWTGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:06:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50700 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731828AbeKWTGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:06:19 -0500
Received: from zn.tnic (p200300EC2BDC9100898E5A1DF8FAB135.dip0.t-ipconnect.de [IPv6:2003:ec:2bdc:9100:898e:5a1d:f8fa:b135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E7591EC035B;
        Fri, 23 Nov 2018 09:23:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542961386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LZbhBSLa621/KT/AIn9+K97NVHywmP3WP6lM0VZFVdQ=;
        b=X28nRSx44pXZc1KgZlOqmuoxxK9Ok2EjSn8giNM4DS6dSTcXFSM2TMYLpxlHSy2ycjWUjo
        6ktpzLhgklJl3B0X3ykMBnAMWn2dps6H646GZj88bvBfG3ADz/eyHERT+oFSMYsZ1iwr55
        YkzHpDtBd6gPDO1T7JkeVuyNi+WPunI=
Date:   Fri, 23 Nov 2018 09:22:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 01/13] x86/resctrl: Rename and move rdt files to new
 directory
Message-ID: <20181123082258.GA30697@zn.tnic>
References: <20181121202811.4492-1-babu.moger@amd.com>
 <20181121202811.4492-2-babu.moger@amd.com>
 <20181123072839.GA51597@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181123072839.GA51597@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 08:28:39AM +0100, Ingo Molnar wrote:
> Ugh, violent NAK on this unreadable directory naming: 'resctrl' is an 
> ugly double/triple abbreviation that nobody recognizes for what it is to 
> begin with, and even the long form 'resource control' is an overly 
> generic naming - *everything* the kernel does is in essence 'resource 
> control' ...

Well, the fs this thing uses is called "resctrl".

Documentation/x86/resctrl_ui.txt:1075:the resctrl will still mount but cannot create CTRL_MON directories.
Documentation/x86/resctrl_ui.txt:1082:# mount -t resctrl resctrl /sys/fs/resctrl
Documentation/x86/resctrl_ui.txt:1083:# cd /sys/fs/resctrl

Are you saying that the fs should be renamed now too?

> So please find some better name and standardize the namespace around it. 
> A couple of suggestions:
> 
>  -    'Hardware Quality of Service', i.e. HW_QOS, hw_qos
>  - or 'CPU bandwidth control',       i.e. CPU_BW, cpu_bw
>  - or 'Hardware Bandwidth Control',  i.e. HW_BW,  hw_bw

How are those *abbreviations* better? "hw_bw" is especially cryptic and
the others are no better.

"resctrl" to mean "resource control" is much better IMO. And it is
different from the "other" resource controlling the kernel does because
it is under arch/x86/kernel/cpu/ which tells you it is a *CPU* resource
control.

And also matches the user-visible "resctrl" filesystem.

But I don't have the energy to bikeshed this morning so whatever, as
long as it is short...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
