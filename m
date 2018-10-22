Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF4FC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2338E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ceMuSlzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2338E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeJWFJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:09:03 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:46312 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbeJWFJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2392; q=dns/txt; s=iport;
  t=1540241337; x=1541450937;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bAsNdtHY2ntetBwx/RM7c+A12Dt9nNe9LNo8DpKC6M8=;
  b=ceMuSlzkUP5/dAWiQo9rTyUdYa/EgHX3YYLSCj0DjFx/12lSeum8OEU2
   PuUOgUZo0RaEg1oxyz0OwoHhGOx9U2xIoEOHMGFPrqlPO+11a7ifEBpZ2
   baWS/8DZ2fx8Uh3fJjDkLxnN9no8L+8vLvSVl1eN+FcLT8q6s3BVNkomB
   g=;
X-IronPort-AV: E=Sophos;i="5.54,413,1534809600"; 
   d="scan'208";a="470247364"
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 20:48:57 +0000
Received: from [10.154.208.149] ([10.154.208.149])
        by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTP id w9MKmpGO018921;
        Mon, 22 Oct 2018 20:48:52 GMT
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, deller@gmx.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian@brauner.io, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Dave.Martin@arm.com,
        mchehab+samsung@kernel.org, Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        guro@fb.com, Marcos Souza <marcos.souza.org@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, linux@dominikbrodowski.net,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        yang.shi@linux.alibaba.com, Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Victor Kamensky <kamensky@cisco.com>,
        xe-linux-external@cisco.com, sstrogin@cisco.com,
        Enke Chen <enkechen@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <CAG48ez2ZPhnxudqgU7nC2ORvLnS0Ja-qhLSE5WAY361jst7XNw@mail.gmail.com>
 <c5a09a04-b4f2-876b-af83-30f7e527497e@cisco.com>
 <CAG48ez2ZD=dovBApR07wi_DzYjJvEyO-Pm35eLv9AyXv1tcAFQ@mail.gmail.com>
 <2631f765-8d7a-45ea-6aa4-d8a9bb00d56f@cisco.com>
 <CAG48ez27=w0oWFTYUeFc72-0DL0tf=NOzGCeZgtxFOePPPE5cA@mail.gmail.com>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <14503a22-403e-3e39-cfd5-0b7a2f299986@cisco.com>
Date:   Mon, 22 Oct 2018 13:48:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez27=w0oWFTYUeFc72-0DL0tf=NOzGCeZgtxFOePPPE5cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.149, [10.154.208.149]
X-Outbound-Node: alln-core-5.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann,

Thanks for the feedback. I will post a revised patch shortly.

On the related topic of "pdeath_signal", there are several inconsistencies
by preserving the flag across execve(2). The flag is cleared under several
conditions in different places. I will start a separate thread to see if
it can still be cleaned up.

     PR_SET_PDEATHSIG (since Linux 2.1.57)
              Set the parent death signal of the calling process to arg2
              (either a signal value in the range 1..maxsig, or 0 to clear).
              This is the signal that the calling process will get when its
              parent dies.  This value is cleared for the child of a fork(2)
              and (since Linux 2.4.36 / 2.6.23) when executing a set-user-ID
              or set-group-ID binary, or a binary that has associated
              capabilities (see capabilities(7)).  This value is preserved
              across execve(2).

-- Enke

On 10/22/18 8:40 AM, Jann Horn wrote:
> On Sat, Oct 20, 2018 at 1:01 AM Enke Chen <enkechen@cisco.com> wrote:
>> Regarding the security considerations, it seems simpler and more secure to
>> just clear the "pre-coredump signal" cross execve(2), and let the new program
>> decide for itself.  What do you think?
> 
> I don't have a problem with these semantics.
> 
> I could imagine someone being unhappy about the theoretical race
> window if they want to perform an in-place reexecution of a running
> service, but I don't know whether anyone actually cares about that.
> 
>> Changes to prctl(2):
>>
>> DESCRIPTION
>>
>>        PR_SET_PREDUMP_SIG (since Linux 4.20.x)
>>               This allows the calling process to receive a signal (arg2,
>>               if nonzero) from a child process prior to the coredump of
>>               the child process. arg2 must be SIGUSR1, or SIGUSR2, or
>>               SIGCHLD, or 0 (for clear).
>>
>>               When SIGCHLD is specified, the signal code is set to
>>               CLD_PREDUMP in such an SIGCHLD signal.
>>
>>               The value of the pre-coredump signal is cleared across
>>               execve(2), or for the child of a fork(2).
>>
>>        PR_GET_PREDUMP_SIG (since Linux 4.20.x)
>>               Return the current value of the pre-coredump signal for the
>>               calling process, in the location pointed to by (int *) arg2.
