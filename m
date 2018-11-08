Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC4ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB6821479
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMz2G8E7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB6821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbeKIHn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeKIHn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:26 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BCAF20844;
        Thu,  8 Nov 2018 22:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714755;
        bh=yFSzq4DHYhRcPBfpXGJ8fGY/jvRJzwr28Rl8bZXXDj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMz2G8E7/pUad5Kcsc6h7OP3wimiNdOeUUsEELGW45Q8M0SgemEojoSt5mW/pNb4i
         VBXrGIu7Y3WwtAPRAsh1dmVS3uasICWaLO7auhy/g9pw0v9oCVXMPTFaU7NWL1NvIW
         8L7es7Eh86r8MqDu9NQ0Lns3rmyCoZ7iWrHamSY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 077/171] perf probe: Fix probe definition for inlined functions
Date:   Thu,  8 Nov 2018 13:50:47 -0800
Message-Id: <20181108215133.141226408@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7598f8bc1383ffd77686cb4e92e749bef3c75937 ]

In commit 613f050d68a8 ("perf probe: Fix to probe on gcc generated
functions in modules"), the offset from symbol is, incorrectly, added
to the trace point address. This leads to incorrect probe trace points
for inlined functions and when using relative line number on symbols.

Prior this patch:
  $ perf probe -m nf_nat -D in_range
  p:probe/in_range nf_nat:in_range.isra.9+0
  $ perf probe -m i40e -D i40e_clean_rx_irq
  p:probe/i40e_clean_rx_irq i40e:i40e_napi_poll+2212
  $ perf probe -m i40e -D i40e_clean_rx_irq:16
  p:probe/i40e_clean_rx_irq i40e:i40e_lan_xmit_frame+626

After:
  $ perf probe -m nf_nat -D in_range
  p:probe/in_range nf_nat:in_range.isra.9+0
  $ perf probe -m i40e -D i40e_clean_rx_irq
  p:probe/i40e_clean_rx_irq i40e:i40e_napi_poll+1106
  $ perf probe -m i40e -D i40e_clean_rx_irq:16
  p:probe/i40e_clean_rx_irq i40e:i40e_napi_poll+2665

Committer testing:

Using 'pfunct', a tool found in the 'dwarves' package [1], one can ask what are
the functions that while not being explicitely marked as inline, were inlined
by the compiler:

  # pfunct --cc_inlined /lib/modules/4.12.0-rc4+/kernel/drivers/net/ethernet/intel/e1000e/e1000e.ko | head
  __ew32
  e1000_regdump
  e1000e_dump_ps_pages
  e1000_desc_unused
  e1000e_systim_to_hwtstamp
  e1000e_rx_hwtstamp
  e1000e_update_rdt_wa
  e1000e_update_tdt_wa
  e1000_put_txbuf
  e1000_consume_page

Then ask 'perf probe' to produce the kprobe_tracer probe definitions for two of
them:

  # perf probe -m e1000e -D e1000e_rx_hwtstamp
  p:probe/e1000e_rx_hwtstamp e1000e:e1000_receive_skb+74

  # perf probe -m e1000e -D e1000_consume_page
  p:probe/e1000_consume_page e1000e:e1000_clean_jumbo_rx_irq+876
  p:probe/e1000_consume_page_1 e1000e:e1000_clean_jumbo_rx_irq+1506
  p:probe/e1000_consume_page_2 e1000e:e1000_clean_rx_irq_ps+1074

Now lets concentrate on the 'e1000_consume_page' one, that was inlined twice in
e1000_clean_jumbo_rx_irq(), lets see what readelf says about the DWARF tags for
that function:

  $ readelf -wi /lib/modules/4.12.0-rc4+/kernel/drivers/net/ethernet/intel/e1000e/e1000e.ko
  <SNIP>
  <1><13e27b>: Abbrev Number: 121 (DW_TAG_subprogram)
    <13e27c>   DW_AT_name        : (indirect string, offset: 0xa8945): e1000_clean_jumbo_rx_irq
    <13e287>   DW_AT_low_pc      : 0x17a30
  <3><13e6ef>: Abbrev Number: 119 (DW_TAG_inlined_subroutine)
    <13e6f0>   DW_AT_abstract_origin: <0x13ed2c>
    <13e6f4>   DW_AT_low_pc      : 0x17be6
  <SNIP>
  <1><13ed2c>: Abbrev Number: 142 (DW_TAG_subprogram)
     <13ed2e>   DW_AT_name        : (indirect string, offset: 0xa54c3): e1000_consume_page

So, the first time in e1000_clean_jumbo_rx_irq() where e1000_consume_page() is
inlined is at PC 0x17be6, which subtracted from e1000_clean_jumbo_rx_irq()'s
address, gives us the offset we should use in the probe definition:

  0x17be6 - 0x17a30 = 438

but above we have 876, which is twice as much.

Lets see the second inline expansion of e1000_consume_page() in
e1000_clean_jumbo_rx_irq():

  <3><13e86e>: Abbrev Number: 119 (DW_TAG_inlined_subroutine)
    <13e86f>   DW_AT_abstract_origin: <0x13ed2c>
    <13e873>   DW_AT_low_pc      : 0x17d21

  0x17d21 - 0x17a30 = 753

So we where adding it at twice the offset from the containing function as we
should.

And then after this patch:

  # perf probe -m e1000e -D e1000e_rx_hwtstamp
  p:probe/e1000e_rx_hwtstamp e1000e:e1000_receive_skb+37

  # perf probe -m e1000e -D e1000_consume_page
  p:probe/e1000_consume_page e1000e:e1000_clean_jumbo_rx_irq+438
  p:probe/e1000_consume_page_1 e1000e:e1000_clean_jumbo_rx_irq+753
  p:probe/e1000_consume_page_2 e1000e:e1000_clean_jumbo_rx_irq+1353
  #

Which matches the two first expansions and shows that because we were
doubling the offset it would spill over the next function:

  readelf -sw /lib/modules/4.12.0-rc4+/kernel/drivers/net/ethernet/intel/e1000e/e1000e.ko
   673: 0000000000017a30  1626 FUNC    LOCAL  DEFAULT    2 e1000_clean_jumbo_rx_irq
   674: 0000000000018090  2013 FUNC    LOCAL  DEFAULT    2 e1000_clean_rx_irq_ps

This is the 3rd inline expansion of e1000_consume_page() in
e1000_clean_jumbo_rx_irq():

   <3><13ec77>: Abbrev Number: 119 (DW_TAG_inlined_subroutine)
    <13ec78>   DW_AT_abstract_origin: <0x13ed2c>
    <13ec7c>   DW_AT_low_pc      : 0x17f79

  0x17f79 - 0x17a30 = 1353

 So:

   0x17a30 + 2 * 1353 = 0x184c2

  And:

   0x184c2 - 0x18090 = 1074

Which explains the bogus third expansion for e1000_consume_page() to end up at:

   p:probe/e1000_consume_page_2 e1000e:e1000_clean_rx_irq_ps+1074

All fixed now :-)

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 613f050d68a8 ("perf probe: Fix to probe on gcc generated functions in modules")
Link: http://lkml.kernel.org/r/20170621164134.5701-1-bjorn.topel@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/probe-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index c93daccec755..a7452fd3b6ee 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -615,7 +615,7 @@ static int post_process_probe_trace_point(struct probe_trace_point *tp,
 					   struct map *map, unsigned long offs)
 {
 	struct symbol *sym;
-	u64 addr = tp->address + tp->offset - offs;
+	u64 addr = tp->address - offs;
 
 	sym = map__find_symbol(map, addr);
 	if (!sym)
-- 
2.17.1



