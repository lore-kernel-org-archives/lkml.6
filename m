Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805562-2-12136060584003837013
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805562; b=T5TKLG5AL0GECV8hucHQr1ZqRs9x5TdQtGbNg00pSkrC20D
    hvHj5PME1WWrP8hct+yzdRpYGhbVGWe4tlDAJc1TwQ9knJlOR7QoTc1bek67BT32
    zdGeB+OeWDqxKRXuKkCeaG6tN/1YnhkgrTQyr7zxF9pRdLFMe2qmANG5tMYaK6DQ
    lJb6pTlEByNfQ6oksiHXue2PWhz/vyg9woDudnjWyRBHD9oAH+HDEvHDKaZHgsDs
    crEBl1F0tX33fKLPZUxy+Ye48gf7eHGe3BJTFrvT/yg9gKjdO5udr7QKZbfuu1wT
    j0vvBqQdWV6LmjtVugeVxEF77KoT0RWmu1olHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805562; bh=1qZ703ZM32XGFOMu7TUGebAgdV
    Kaydp5KKqossM8RU8=; b=VH8RoEwp7wjOEXQ1R2k/xkWXQazLfkvOcl2jjwEYCm
    uqSkCLZPvc9QxvHwh1zy+oBUf3L5NN9b5SLYOCMow5sWxnde95F7ZVkkcieFEFAr
    LxLJPi44es6htKq/b5Jccjwt2YgaH901/0SmuBUPzI81uj461VK3eBcGN+WX28KV
    X0jjFxA/4F/FwhO8yPOrSYkah5IImoB7uutm1e9NZ7Bo1rcoa9PRNg5dvIHBDFmT
    r58ADBHNMhUEDzZATXqjrWbDJdFlJsL1N7XaOrhgFMQ63x6smdrLcjF/G8KS61RC
    f0J7Y0I5JfsJZ9S8xrnhd7NW0V3z2TbJCisQHWwRPsQA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeCWKC7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:02:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38550 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754331AbeCWKCz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:02:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 62/77] clk: Dont touch hardware when reparenting during registration
Date: Fri, 23 Mar 2018 10:54:36 +0100
Message-Id: <20180323094146.431380078@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <sboyd@codeaurora.org>


[ Upstream commit f8f8f1d04494d3a6546bee3f0618c4dba31d7b72 ]

The orphan clocks reparent operation shouldn't touch the hardware
if clocks are enabled, otherwise it may get a chance to disable a
newly registered critical clock which triggers the warning below.

Assuming we have two clocks: A and B, B is the parent of A.
Clock A has flag: CLK_OPS_PARENT_ENABLE
Clock B has flag: CLK_IS_CRITICAL

Step 1:
Clock A is registered, then it becomes orphan.

Step 2:
Clock B is registered. Before clock B reach the critical clock enable
operation, orphan A will find the newly registered parent B and do
reparent operation, then parent B will be finally disabled in
__clk_set_parent_after() due to CLK_OPS_PARENT_ENABLE flag as there's
still no users of B which will then trigger the following warning.

WARNING: CPU: 0 PID: 0 at drivers/clk/clk.c:597 clk_core_disable+0xb4/0xe0
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.11.0-rc1-00056-gdff1f66-dirty #1373
Hardware name: Generic DT based system
Backtrace:
[<c010c4bc>] (dump_backtrace) from [<c010c764>] (show_stack+0x18/0x1c)
 r6:600000d3 r5:00000000 r4:c0e26358 r3:00000000
[<c010c74c>] (show_stack) from [<c040599c>] (dump_stack+0xb4/0xe8)
[<c04058e8>] (dump_stack) from [<c0125c94>] (__warn+0xd8/0x104)
 r10:c0c21cd0 r9:c048aa78 r8:00000255 r7:00000009 r6:c0c1cd90 r5:00000000
 r4:00000000 r3:c0e01d34
[<c0125bbc>] (__warn) from [<c0125d74>] (warn_slowpath_null+0x28/0x30)
 r9:00000000 r8:ef00bf80 r7:c165ac4c r6:ef00bf80 r5:ef00bf80 r4:ef00bf80
[<c0125d4c>] (warn_slowpath_null) from [<c048aa78>] (clk_core_disable+0xb4/0xe0)
[<c048a9c4>] (clk_core_disable) from [<c048be88>] (clk_core_disable_lock+0x20/0x2c)
 r4:000000d3 r3:c0e0af00
[<c048be68>] (clk_core_disable_lock) from [<c048c224>] (clk_core_disable_unprepare+0x14/0x28)
 r5:00000000 r4:ef00bf80
[<c048c210>] (clk_core_disable_unprepare) from [<c048c270>] (__clk_set_parent_after+0x38/0x54)
 r4:ef00bd80 r3:000010a0
[<c048c238>] (__clk_set_parent_after) from [<c048daa8>] (clk_register+0x4d0/0x648)
 r6:ef00d500 r5:ef00bf80 r4:ef00bd80 r3:ef00bfd4
[<c048d5d8>] (clk_register) from [<c048dc30>] (clk_hw_register+0x10/0x1c)
 r9:00000000 r8:00000003 r7:00000000 r6:00000824 r5:00000001 r4:ef00d500
[<c048dc20>] (clk_hw_register) from [<c048e698>] (_register_divider+0xcc/0x120)
[<c048e5cc>] (_register_divider) from [<c048e730>] (clk_register_divider+0x44/0x54)
 r10:00000004 r9:00000003 r8:00000001 r7:00000000 r6:00000003 r5:00000001
 r4:f0810030
[<c048e6ec>] (clk_register_divider) from [<c0d3ff58>] (imx7ulp_clocks_init+0x558/0xe98)
 r7:c0e296f8 r6:c165c808 r5:00000000 r4:c165c808
[<c0d3fa00>] (imx7ulp_clocks_init) from [<c0d24db0>] (of_clk_init+0x118/0x1e0)
 r10:00000001 r9:c0e01f68 r8:00000000 r7:c0e01f60 r6:ef7f8974 r5:ef0035c0
 r4:00000006
[<c0d24c98>] (of_clk_init) from [<c0d04a50>] (time_init+0x2c/0x38)
 r10:efffed40 r9:c0d61a48 r8:c0e78000 r7:c0e07900 r6:ffffffff r5:c0e78000
 r4:00000000
[<c0d04a24>] (time_init) from [<c0d00b8c>] (start_kernel+0x218/0x394)
[<c0d00974>] (start_kernel) from [<6000807c>] (0x6000807c)
 r10:00000000 r9:410fc075 r8:6000406a r7:c0e0c930 r6:c0d61a44 r5:c0e07918
 r4:c0e78294

We know that the clk isn't enabled with any sort of prepare_count
here so we don't need to enable anything to prevent a race. And
we're holding the prepare mutex so set_rate/set_parent can't race
here either. Based on an earlier patch by Dong Aisheng.

Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Reported-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2476,14 +2476,17 @@ static int __clk_core_init(struct clk_co
 	 */
 	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
 		struct clk_core *parent = __clk_init_parent(orphan);
+		unsigned long flags;
 
 		/*
 		 * we could call __clk_set_parent, but that would result in a
 		 * redundant call to the .set_rate op, if it exists
 		 */
 		if (parent) {
-			__clk_set_parent_before(orphan, parent);
-			__clk_set_parent_after(orphan, parent, NULL);
+			/* update the clk tree topology */
+			flags = clk_enable_lock();
+			clk_reparent(orphan, parent);
+			clk_enable_unlock(flags);
 			__clk_recalc_accuracies(orphan);
 			__clk_recalc_rates(orphan, 0);
 		}
