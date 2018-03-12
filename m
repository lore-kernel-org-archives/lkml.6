Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeCLOam (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:30:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56318 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751361AbeCLOak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:30:40 -0400
Date: Mon, 12 Mar 2018 15:30:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/microcode/AMD: check microcode file sanity before
 loading it
Message-ID: <20180312143021.GE9431@pd.tnic>
References: <787b0ecc-8c1a-3b5a-82e0-9840c7b7c595@maciej.szmigiero.name>
 <20180312095336.GB9431@pd.tnic>
 <ddf0ddc2-bc46-d61c-7080-0eca26d6bfcf@maciej.szmigiero.name>
 <20180312130653.GC9431@pd.tnic>
 <df1e721c-f030-68b4-f197-2592bce97bbf@maciej.szmigiero.name>
 <20180312134853.GD9431@pd.tnic>
 <2d60978a-522c-ff00-f245-a7e681283371@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d60978a-522c-ff00-f245-a7e681283371@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 03:10:47PM +0100, Maciej S. Szmigiero wrote:
> And this current maximum was reached by CPU types added in
> families < 15h during last 10+ years (the oldest supported CPU family in

You're assuming that the rate of adding patches to the microcode
container won't change. You have a crystal ball which shows you the
future?

Ok, enough with the bullshit.

Here's what I'll take as hardening patches:

1. Check whether the equivalence table length is not exceeding the size
of the whole blob. This is the only sane limit check we can do - no
arbitrary bullshit of it'll take how many years to reach some limit.

2. Add a PATCH_MAX_SIZE macro which evaluates against the max of all
family patch sizes:

#define F1XH_MPB_MAX_SIZE 2048
#define F14H_MPB_MAX_SIZE 1824
#define F15H_MPB_MAX_SIZE 4096
#define F16H_MPB_MAX_SIZE 3458
#define F17H_MPB_MAX_SIZE 3200

so that future additions won't break the macro.

3. Fix install_equiv_cpu_table() to return an unsigned int

Make all the points above into separate patches, please, with proper
commit messages explaining why they do what they do and test them.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
