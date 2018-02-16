Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935004AbeBPLEo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:04:44 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:40853 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeBPLEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:04:41 -0500
X-Google-Smtp-Source: AH8x224CQI6KWMlQDKGpjdlViW0XzvKRS9KbeL9VWypdyzoFGXekrAps4QL3CfexJYKAXPa1gSF0YQ==
Subject: Re: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
To: David Woodhouse <dwmw2@infradead.org>, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com
Cc: Ingo Molnar <mingo@kernel.org>
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
 <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk>
 <7e2e5ad1-49b6-1fdb-4a62-8ad6aefc30a0@redhat.com>
 <1518509708.12890.33.camel@infradead.org>
 <27c85759-e662-d281-f8a0-0a80ca8ee18f@redhat.com>
 <1518517262.12890.43.camel@infradead.org>
 <1518518198.12890.48.camel@infradead.org>
 <02bd3fdd-1b73-6cab-fb09-38ba933396bd@redhat.com>
 <1518775136.7876.13.camel@infradead.org>
 <75287047-77a0-e0ff-c2e8-61c81641251e@redhat.com>
 <1518776517.7876.21.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d61edc94-8a51-62bd-65ed-8068451ca5b5@redhat.com>
Date: Fri, 16 Feb 2018 12:04:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518776517.7876.21.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2018 11:21, David Woodhouse wrote:
> Why? With IBRS_ALL the guest *never* gets to affect the actual hardware
> MSR, which is always on. The MSR is purely an emulated no-op. Why does
> that affect migration?

Because even if the host has IBRS_ALL, as long as you want to migrate to
a system without IBRS_ALL the guest will likely not have it.  You can
fake IBRS_ALL on the older system after migration, and forcing the guest
to always run with IBRS=1 even when in user mode; that is slow.  Or...

> Even if the guest doesn't have/support IBRS_ALL, and is frobbing the
> (now emulated) MSR on every kernel entry/exit, that's *still* going to
> be a metric shitload faster than what it *thought* it was doing.

... you are making every kernel entry/exit 3 times slower by adding two
KVM exits (both hypervisor traps and syscalls are in the 1000-1500 clock
cycles ballpark).  That cannot be fast at all.

Paolo
