Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeDKBzH convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 21:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752121AbeDKBzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 21:55:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D25B21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Andy Gross <andy.gross@linaro.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180409214016.21219-1-niklas.cassel@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180409214016.21219-1-niklas.cassel@linaro.org>
Message-ID: <152341170436.180276.10941810507471101174@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] firmware: qcom: scm: Fix crash in qcom_scm_call_atomic1()
Date: Tue, 10 Apr 2018 18:55:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Niklas Cassel (2018-04-09 14:40:15)
> qcom_scm_call_atomic1() can crash with a NULL pointer dereference at
> qcom_scm_call_atomic1+0x30/0x48.
> 
> disassembly of qcom_scm_call_atomic1():
> ...
> <0xc08d73b0 <+12>: ldr r3, [r12]
> ... (no instruction explicitly modifies r12)
> 0xc08d73cc <+40>: smc 0
> ... (no instruction explicitly modifies r12)
> 0xc08d73d4 <+48>: ldr r3, [r12] <- crashing instruction
> ...
> 
> Since the first ldr is successful, and since r12 isn't explicitly
> modified by any instruction between the first and the second ldr,
> it must have been modified by the smc call, which is ok,
> since r12 is caller save according to the AAPCS.
> 
> Add r12 to the clobber list so that the compiler knows that the
> callee potentially overwrites the value in r12.
> Clobber descriptions may not in any way overlap with an input or
> output operand.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
