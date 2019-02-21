Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CD0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F63207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfBUW5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:57:03 -0500
Received: from www62.your-server.de ([213.133.104.62]:52036 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUW5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:57:03 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gwxGy-0000gv-6v; Thu, 21 Feb 2019 23:56:56 +0100
Received: from [178.197.248.36] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gwxGx-000NJn-Us; Thu, 21 Feb 2019 23:56:56 +0100
Subject: Re: [PATCH] x86, retpolines: raise limit for generating indirect
 calls from switch-case
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
References: <20190221221941.29358-1-daniel@iogearbox.net>
 <CAHk-=wgNfnC-oe7aJGgNWoTbssc0LPYK6FyR=6LO4_U_dsphbg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d58b52ae-c4d9-991a-b53b-4047abe2cb56@iogearbox.net>
Date:   Thu, 21 Feb 2019 23:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgNfnC-oe7aJGgNWoTbssc0LPYK6FyR=6LO4_U_dsphbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25367/Thu Feb 21 14:02:13 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2019 11:27 PM, Linus Torvalds wrote:
> On Thu, Feb 21, 2019 at 2:20 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> In case of gcc, this setting is controlled by case-values-threshold
>> which has an architecture global default that selects 4 or 5 (
> 
> Ack. For retpoline, that's much too low.
> 
> Patch looks sane, although it would be good to verify just which
> versions of gcc this works for. All versions with retpoline?

The feature was first added in gcc 4.7 [0], under "General Optimizer Improvements":

  Support for a new parameter --param case-values-threshold=n was added to allow
  users to control the cutoff between doing switch statements as a series of if
  statements and using a jump table.

From what I can tell, original author (H.J. Lu) provided backports up to gcc 4.8
and distros seem to have pulled it from his github branch [1] as upstream gcc does
not handle backports for stable versions that old.

Thanks,
Daniel

  [0] https://www.gnu.org/software/gcc/gcc-4.7/changes.html
  [1] https://bugs.launchpad.net/ubuntu/+source/gcc-4.8/+bug/1749261
      https://github.com/hjl-tools/gcc/tree/hjl/indirect/gcc-4_8-branch/master
