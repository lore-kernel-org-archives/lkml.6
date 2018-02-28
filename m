Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935174AbeB1VkZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:40:25 -0500
Received: from vern.gendns.com ([206.190.152.46]:50059 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932597AbeB1VkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:40:22 -0500
Subject: Re: [PATCH v7 10/42] clk: davinci: New driver for davinci PSC clocks
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-clk@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Adam Ford <aford173@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
 <1519071723-31790-11-git-send-email-david@lechnology.com>
 <CAMpxmJVxfGtO=kh63KF-5Uqew3yy97DsK4FSd14CyyRQTOhrTA@mail.gmail.com>
From: David Lechner <david@lechnology.com>
Message-ID: <93696fc8-bb93-aa20-3506-3d7216c17cd2@lechnology.com>
Date: Wed, 28 Feb 2018 15:40:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJVxfGtO=kh63KF-5Uqew3yy97DsK4FSd14CyyRQTOhrTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 06:38 AM, Bartosz Golaszewski wrote:
> 
> I think I found the reason for the strange crashes we were
> experiencing (emac core->name being NULL) thanks to Sekhar who pointed
> me in the right direction.
> 
> The mdio driver fails to probe with v7 due to the supplied clock rate
> being wrong. Before failing we register the emac clock with
> pm_clk_add_clk(). When clock_ops puts the clock, it decreases the
> reference count of the clock, but we never actually increased it in
> the first place in the line above. The core clock code then destroys
> the associated clk_core structure. When the next user comes around (in
> our case the clk debug functions) the system crashes.
> 
> I believe there to be two issues: one is with v7 - we need to increase
> the clock reference count in davinci_psc_genpd_attach_dev().
> 
> Second is the error path in the clock framework - we should remove the
> destroyed clk_core from the debug list, which is not being done now.
> 
> Why we even need to track the refcount of clk_core is a mistery for me
> though. Stephen, Mike?
> 
> Best regards,
> Bartosz Golaszewski

Great find. I figured it had to be something like this, but I wasn't
able to reproduce the problem yet.

I suppose it is time to spin up a v8 with some fixes.
