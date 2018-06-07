Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4Z7cBWDlGFvALAAAmS7hNA
	; Thu, 07 Jun 2018 07:57:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 07C366089E; Thu,  7 Jun 2018 07:57:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7F4DF6063F;
	Thu,  7 Jun 2018 07:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F4DF6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753627AbeFGH5S (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:57:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:26588 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753590AbeFGH5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:57:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 00:57:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="65040681"
Received: from gvt-dell.bj.intel.com (HELO intel.com) ([10.238.154.65])
  by orsmga002.jf.intel.com with SMTP; 07 Jun 2018 00:57:08 -0700
Date: Thu, 7 Jun 2018 15:46:29 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, gregkh@linuxfoundation.org,
        alex.elder@linaro.org, Johan Hovold <johan@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, michal.lkml@markovi.net,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        yamada.masahiro@socionext.com, lgirdwood@gmail.com,
        broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org,
        linux@armlinux.org.uk, changbin.du@intel.com,
        linux-sparse@vger.kernel.org, mingo@redhat.com, kbuild-all@01.org,
        akpm@linux-foundation.org, changbin.du@gmail.com,
        tglx@linutronix.de, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Message-ID: <20180607074628.kd3iyxevwj3ypzbr@intel.com>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
User-Agent: NeoMutt/20180323-6-5ca392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Jun 07, 2018 at 09:47:18AM +0530, Viresh Kumar wrote:
> +Greg/Alex,
> 
> @Fegguang/build-bot: I do see mention of Greg and /me in your initial email's
> body saying TO: Viresh, CC: Greg, but I don't see any of us getting cc'd in your
> email. Bug ?
> 
> On 06-06-18, 14:26, Steven Rostedt wrote:
> > On Wed, 6 Jun 2018 16:26:00 +0200
> > Johan Hovold <johan@kernel.org> wrote:
> > 
> > > Looks like the greybus code above is working as intended by checking for
> > > unterminated string after the strncpy, even if this does now triggers
> > > the truncation warning.
> 
> So why exactly are we generating a warning here ? Is it because it is possible
> that the first n bytes of src may not have the null terminating byte and the
> dest may not be null terminated eventually ?
> 
> Maybe I should just use memcpy here then ?
> 
I think if the destination is not a null terminated string (If I understand your
description below), memcpy can be used to get rid of such warning. The warning
makes sense in general as explained in mannual. Thanks!

> But AFAIR, I used strncpy() specifically because it also sets all the remaining
> bytes after the null terminating byte with the null terminating byte. And so it
> is pretty easy for me to check if the final string is null terminated by
> checking [max - 1] byte against '\0', which the code is doing right now.
> 
> I am not sure what would the best way to get around this incorrect-warning.
> 
> And I am wondering on why buildbot reported the warning only for two instances
> in that file, while I have done the same thing at 4 places.
> 
> > Ah, yes I now see that. Thanks for pointing it out. But perhaps it
> > should also add the "- 1" to the strncpy() so that gcc doesn't think
> > it's a mistake.
> 
> The src string is passed on from a firmware entity and we need to make sure the
> protocol (greybus) is implemented properly by the other end. For example, in the
> current case if the firmware sends "HELLOWORLD", its an error as it should have
> sent "HELLWORLD\0". But with what you are saying we will forcefully make dest as
> "HELLWORLD\0", which wouldn't be the right thing to do as we will miss the bug
> present in firmware.
> 
> -- 
> viresh

-- 
Thanks,
Changbin Du
