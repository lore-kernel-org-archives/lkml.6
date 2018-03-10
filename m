Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbeCJQQp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 11:16:45 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:53394 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932329AbeCJQQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 11:16:44 -0500
Subject: Re: [PATCH] x86/microcode/AMD: check microcode file sanity before
 loading it
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <34e9d679-2eca-90cf-9a95-3864f0be060e@maciej.szmigiero.name>
Message-ID: <f61522e6-fa15-0fc1-feef-6e0c84d6fc80@maciej.szmigiero.name>
Date: Sat, 10 Mar 2018 17:16:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <34e9d679-2eca-90cf-9a95-3864f0be060e@maciej.szmigiero.name>
Content-Type: text/plain; charset=US-ASCII
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.2018 01:34, Maciej S. Szmigiero wrote:
> Currently, it is very easy to make the AMD microcode update driver crash
> or spin on a malformed microcode file since it does very little
> consistency checking on data loaded from such file.
> 
> This commit introduces various checks, mostly on length-type fields, so
> all corrupted microcode files are (hopefully) correctly rejected instead.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

To make sure that it is clear what this patch is about:
It *isn't* about verifying the actual microcode update, that is, the
blob that gets sent to the CPU as the new microcode.
Such verification is (hopefully) done by the CPU itself.

It is about verifying *this driver-specific* container file that
includes many microcode updates for different CPUs of a particular CPU
family, along with metadata that helps the driver select the right
microcode update to actually sent to the CPU.

The microcode container files in linux-firmware don't contain the
newest microcode versions, even for older CPUs.
They are generally updated VERY rarely - I can see only three updates
for them: on 2016-03-18, 2014-11-30 and 2013-07-11.
There is no container file at all for family 17h (Zen) so
distributions like OpenSUSE that include this file must have gotten it
from some other source (or made from raw updates themselves).

That's why to get things like IBPB it is sometimes necessary to use
a newer microcode version than included in linux-firmware, sourced for
example from a BIOS update.
Since BIOS updates contain only actual (raw) microcode updates one
has to place it in a microcode container file so this driver can parse
it.

As far I know there is no tool to automate this work so one has to
manually tweak the container metadata.
And this is prone to mistakes this patch protects against.

Sorry for not making this 100% clear in the commit log.

Maciej
