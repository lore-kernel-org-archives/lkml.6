Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162812AbeE1KqL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937798AbeE1KqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:46:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 104/496] arm64: perf: correct PMUVer probing
Date: Mon, 28 May 2018 11:58:09 +0200
Message-Id: <20180528100324.224472328@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 0331365edb1d6ccd6ae68b1038111da85d4c68d1 ]

The ID_AA64DFR0_EL1.PMUVer field doesn't follow the usual ID registers
scheme. While value 0xf indicates a non-architected PMU is implemented,
values 0x1 to 0xe indicate an increasingly featureful architected PMU,
as if the field were unsigned.

For more details, see ARM DDI 0487C.a, D10.1.4, "Alternative ID scheme
used for the Performance Monitors Extension version".

Currently, we treat the field as signed, and erroneously bail out for
values 0x8 to 0xe. Let's correct that.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/perf_event.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -914,9 +914,9 @@ static void __armv8pmu_probe_pmu(void *i
 	int pmuver;
 
 	dfr0 = read_sysreg(id_aa64dfr0_el1);
-	pmuver = cpuid_feature_extract_signed_field(dfr0,
+	pmuver = cpuid_feature_extract_unsigned_field(dfr0,
 			ID_AA64DFR0_PMUVER_SHIFT);
-	if (pmuver < 1)
+	if (pmuver == 0xf || pmuver == 0)
 		return;
 
 	probe->present = true;
