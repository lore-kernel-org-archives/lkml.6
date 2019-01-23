Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B0BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7031F2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfAWOQN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:16:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:47729 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfAWOPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:15:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 06:15:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,511,1539673200"; 
   d="scan'208";a="140624960"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2019 06:15:47 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     dev@openvswitch.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        intel-wired-lan@lists.osuosl.org, linux-fsdevel@vger.kernel.org,
        xen-devel@lists.xenproject.org, Laura Abbott <labbott@redhat.com>,
        linux-kbuild@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: [Intel-gfx] [PATCH 1/3] treewide: Lift switch variables out of switches
In-Reply-To: <20190123115829.GA31385@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190123110349.35882-1-keescook@chromium.org> <20190123110349.35882-2-keescook@chromium.org> <20190123115829.GA31385@kroah.com>
Date:   Wed, 23 Jan 2019 16:17:30 +0200
Message-ID: <874l9z31c5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 23, 2019 at 03:03:47AM -0800, Kees Cook wrote:
>> Variables declared in a switch statement before any case statements
>> cannot be initialized, so move all instances out of the switches.
>> After this, future always-initialized stack variables will work
>> and not throw warnings like this:
>> 
>> fs/fcntl.c: In function ‘send_sigio_to_task’:
>> fs/fcntl.c:738:13: warning: statement will never be executed [-Wswitch-unreachable]
>>    siginfo_t si;
>>              ^~
>
> That's a pain, so this means we can't have any new variables in { }
> scope except for at the top of a function?
>
> That's going to be a hard thing to keep from happening over time, as
> this is valid C :(

Not all valid C is meant to be used! ;)

Anyway, I think you're mistaking the limitation to arbitrary blocks
while it's only about the switch block IIUC.

Can't have:

	switch (i) {
		int j;
	case 0:
        	/* ... */
	}

because it can't be turned into:

	switch (i) {
		int j = 0; /* not valid C */
	case 0:
        	/* ... */
	}

but can have e.g.:

	switch (i) {
	case 0:
		{
			int j = 0;
	        	/* ... */
		}
	}

I think Kees' approach of moving such variable declarations to the
enclosing block scope is better than adding another nesting block.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
