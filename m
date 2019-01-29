Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E07C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B59221871
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761891;
	bh=uuMHvEyNK8k5Ohfo8V0LWzf9z+Go6StIYrbjkSt4/ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Se/8Lt/VnX4HzG/lFf04marNWRRK9bYOBB+Vd1dwmZLd6wuuirmIUdeEe9XgXqLjh
	 6+JZ8mnqOYi+25UOCFyek62wBzJ76H8gvvEQJu6qtB+1P4FGYhvT7OwkrlqbSfjVZ5
	 s4PRzCx/WIpB+7CjC6SNmm+8ITD14zA/zUkjMjAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfA2LiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbfA2LiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D02EE214DA;
        Tue, 29 Jan 2019 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761888;
        bh=uuMHvEyNK8k5Ohfo8V0LWzf9z+Go6StIYrbjkSt4/ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dCc0bs7g3AduYMURLejoxJmwKwDqHTSVlT1ezdvVeUTdRv+Y38RB2sgSSXvht+U6/
         pXtdm8acmtoh12cWqWvVnC7mC20nYK9iF9EEiSUjoaePyztU6jsWl62O398aweQOJn
         7sHr6qUA2hihTeZN6kq+ZCZq1ekaC1O2VMJ9qU+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-stable@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.20 036/117] clk: socfpga: stratix10: fix rate calculation for pll clocks
Date:   Tue, 29 Jan 2019 12:34:47 +0100
Message-Id: <20190129113209.409483944@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinh Nguyen <dinguyen@kernel.org>

commit c0a636e4cc2eb39244d23c0417c117be4c96a7fe upstream.

The main PLL calculation has a mistake. We should be using the
multiplying the VCO frequency, not the parent clock frequency.

Fixes: 07afb8db7340 ("clk: socfpga: stratix10: add clock driver for
Stratix10 platform")
Cc: linux-stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/socfpga/clk-pll-s10.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -43,7 +43,7 @@ static unsigned long clk_pll_recalc_rate
 	/* Read mdiv and fdiv from the fdbck register */
 	reg = readl(socfpgaclk->hw.reg + 0x4);
 	mdiv = (reg & SOCFPGA_PLL_MDIV_MASK) >> SOCFPGA_PLL_MDIV_SHIFT;
-	vco_freq = (unsigned long long)parent_rate * (mdiv + 6);
+	vco_freq = (unsigned long long)vco_freq * (mdiv + 6);
 
 	return (unsigned long)vco_freq;
 }


