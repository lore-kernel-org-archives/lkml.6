Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC6FC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C0220693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C0220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754275AbeFTA1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:27:06 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:53704 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754201AbeFTA04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:26:56 -0400
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1414.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 20 Jun 2018 00:26:47 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 19
 Jun 2018 17:26:46 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Tue, 19 Jun
 2018 17:26:46 -0700
Date:   Tue, 19 Jun 2018 17:26:47 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] MIPS: boot: rebuild ITB when contained DTB is updated
Message-ID: <20180620002647.u2d7t3vzc2yinkft@pburton-laptop>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
 <1523890067-13641-8-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1523890067-13641-8-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529454407-531716-21947-19827-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194209
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: yamada.masahiro@socionext.com,ralf@linux-mips.org,jhogan@kernel.org,linux-mips@linux-mips.org,keescook@chromium.org,linux-kernel@vger.kernel.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Mon, Apr 16, 2018 at 07:47:47AM -0700, Masahiro Yamada wrote:
> Since now, the unnecessary rebuild of ITB has been fixed.  Another
> problem to be taken care of is, missed rebuild of ITB.
> 
> For example, board-boston.its.S includes boston.dtb by the /incbin/
> directive.  If boston.dtb is updated, vmlinux.*.dtb must be rebuilt.
> Currently, the dependency between ITB and contained DTB files is not
> described anywhere.  Previously, this problem was hidden since
> vmlinux.*.itb was always rebuilt even if nothing is updated.  By
> fixing the spurious rebuild, this is a real problem now.
> 
> Use the same strategy for automatic generation of the header file
> dependency.  DTC works as a backend of mkimage, and DTC supports -d
> option.  It outputs the dependencies, including binary files pulled
> by the /incbin/ directive.
> 
> The implementation is simpler than cmd_dtc in scripts/Makefile.lib
> since we do not need CPP here.  Just pass -d $(depfile) to DTC, and
> let the resulted $(depfile) processed by fixdep.
> 
> It might be unclear why "$(obj)/dts/%.dtb: ;" is needed.  With this
> commit, *.cmd files will contain dependency on DTB files.  In the
> next invocation of build, the *.cmd files will be included, then
> Make will try to find a rule to update *.dtb files.  Unfortunately,
> it is found in scripts/Makefile.lib.  The build rule of $(obj)/%.dtb
> is invoked by if_changed_dep, so it needs to include *.cmd files
> of DTB, but they are not included because we are in arch/mips/boot,
> but those *.cmd files reside in arch/mips/boot/dts/*/.  Cancel the
> pattern rule in scripts/Makefile.lib to suppress unneeded rebuilding
> of DTB.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/mips/boot/Makefile | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Thanks - this looks good to me except that it starts outputting a "Don't
know how to preprocess itb-image" message after building the .itb.

I presume we just need an extra case adding to ksym_dep_filter. Do you
want to add that in & resubmit this one?

Thanks,
    Paul
