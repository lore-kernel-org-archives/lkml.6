Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF0BC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14ECF21763
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14ECF21763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbeHNAyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:54:13 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44088 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbeHNAyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:54:13 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LiscI-1gRRD102tq-00dD0W; Tue, 14 Aug 2018 00:09:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] bitfield: avoid gcc-8 -Wint-in-bool-context warning
Date:   Tue, 14 Aug 2018 00:09:34 +0200
Message-Id: <20180813220950.194841-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:SkRN9ZwMqH7s9rpPVdqftpfV2tufaYvAiwkfRYJqjv0O2qjPnFs
 jUw6O3t1ixiDPAXZjhiVtDvytSKlRTuoxSZxVnOdp6T1NZUd03fnBLG+bsyruBY6cJ2RmMU
 TPpqZtNxnbTObSEYlhrdIKuRjSIMON1+uaniBPsf9UJBgfh7KYyXNTu8HPEhKWQoyUcVMY5
 wJ22wfa33yautyoC6oWCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8/eiLgOZK6w=:eN9pN3hWTqGXNsfIiLisZy
 tUaCpQ4RJr2GCU3f+yWjpuaK1/RTVlkyyb2gRrWjsD/NyQMHj+mb5/RFb/h88N4UM86X4Nrop
 DOngQefAM7wgmQ6B5rwUixqEzwL8gjWaTW4G5Vgiguog0ysZ+x0uv4vya0cihmWHDlGZadQCy
 EkTYyU9DCglgnzaqvscxNw78Y1Zw+vqHtedN6/RX20NqhTG/i/znfc7bDy08A8figekhpwBez
 NhQgIcFEZBm7ipYkbs0PCldxvXsj/TmdCrLnaXEoC1uWVntL1RfFaVqs5BmRnz2w+2PB9+jA3
 WC3Ce7wxniXVSfZ7sfaKh/ZfVqZ4lF9H2aH1vYMlIUHc45/aedLpDgE8KivzO4GILs2K2h34u
 32n2EK/S7uMBwNkX8Jfao0BMfOQS+YTri0viPwqrquK1zT2zQlJwFmfW0UtB7nssTRxhOxaAF
 n2k9PB4v0TsOKDlhu91dc+hhclO5+69vllHCg2/a5J7/xAUcDXUsZeB2A1XEbGT+P/s9KvTNI
 dBZJ6L/jX1cxZhPvkudXtGsb1K2vc3D4TaiETQABWHqJRDvXjRRl6HBN01NMXLmMlRFJIiqEd
 dqWr8dFqryk4isb1Xe+M5hCODmo5+NjdPTgGbC9BJ8xI/YiI+jiKDmUGgaTdNwpieqWEYCOY4
 qk3gsDDS57LqbAJmJ1Pu/LZjwdCsLfErxVkq9342489VpAO5f5x0np3D94xZ1Cjhufjg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing an enum into FIELD_GET() produces a long but harmless warning on
newer compilers:

                 from include/linux/linkage.h:7,
                 from include/linux/kernel.h:7,
                 from include/linux/skbuff.h:17,
                 from include/linux/if_ether.h:23,
                 from include/linux/etherdevice.h:25,
                 from drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:63:
drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c: In function 'iwl_mvm_rx_mpdu_mq':
include/linux/bitfield.h:56:20: error: enum constant in boolean context [-Werror=int-in-bool-context]
   BUILD_BUG_ON_MSG(!(_mask), _pfx "mask is zero"); \
                    ^
...
include/linux/bitfield.h:103:3: note: in expansion of macro '__BF_FIELD_CHECK'
   __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: "); \
   ^~~~~~~~~~~~~~~~
drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c:1025:21: note: in expansion of macro 'FIELD_GET'
    le16_encode_bits(FIELD_GET(IWL_RX_HE_PHY_SIBG_SYM_OR_USER_NUM_MASK,

The problem here is that the caller has no idea how the macro gets
expanding, leading to a false-positive. It can be trivially avoided
by doing a comparison against zero.

This only recently started appearing as the iwlwifi driver was patched
to use FIELD_GET.

Fixes: 514c30696fbc ("iwlwifi: add support for IEEE802.11ax")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/bitfield.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 65a6981eef7b..3f1ef4450a7c 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -53,7 +53,7 @@
 	({								\
 		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
 				 _pfx "mask is not constant");		\
-		BUILD_BUG_ON_MSG(!(_mask), _pfx "mask is zero");	\
+		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
 		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
 				 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
 				 _pfx "value too large for the field"); \
-- 
2.18.0

