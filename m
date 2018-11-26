Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E53C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9228B2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9228B2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeKZXU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:20:28 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:41817
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbeKZXU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:20:27 -0500
X-IronPort-AV: E=Sophos;i="5.56,282,1539640800"; 
   d="scan'208";a="286830708"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 13:26:26 +0100
Date:   Mon, 26 Nov 2018 13:26:24 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     frowand.list@gmail.com
cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: add dtc annotations functionality to dtx_diff
In-Reply-To: <1543233669-8696-1-git-send-email-frowand.list@gmail.com>
Message-ID: <alpine.DEB.2.20.1811261325430.3447@hadrien>
References: <1543233669-8696-1-git-send-email-frowand.list@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Nov 2018, frowand.list@gmail.com wrote:

> From: Frank Rowand <frank.rowand@sony.com>
>
> Add -T and --annotations command line arguments to dtx_diff.  These
> arguments will be passed through to dtc.  dtc will then add source
> location annotations to its output.
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

Tested-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>
> This feature depends upon commit 5667e7ef9a9a ("annotations: add the
> annotation functionality") in the dtc git repository.  To use the
> new flags before the new version of dtc is imported to the linux
> kernel, download the dtc repository, compile dtc with the make command,
> then add the path of the dtc repository to the shell PATH variable.
>
>  scripts/dtc/dtx_diff | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/dtc/dtx_diff b/scripts/dtc/dtx_diff
> index 8c4fbad2055e..0d8572008729 100755
> --- a/scripts/dtc/dtx_diff
> +++ b/scripts/dtc/dtx_diff
> @@ -21,6 +21,7 @@ Usage:
>          diff DTx_1 and DTx_2
>
>
> +      --annotate    synonym for -T
>         -f           print full dts in diff (--unified=99999)
>         -h           synonym for --help
>         -help        synonym for --help
> @@ -28,6 +29,7 @@ Usage:
>         -s SRCTREE   linux kernel source tree is at path SRCTREE
>                          (default is current directory)
>         -S           linux kernel source tree is at root of current git repo
> +       -T           Annotate output .dts with input source file and line (-T -T for more details)
>         -u           unsorted, do not sort DTx
>
>
> @@ -174,6 +176,7 @@ compile_to_dts() {
>
>  # -----  start of script
>
> +annotate=""
>  cmd_diff=0
>  diff_flags="-u"
>  dtx_file_1=""
> @@ -208,6 +211,14 @@ while [ $# -gt 0 ] ; do
>  		shift
>  		;;
>
> +	-T | --annotate )
> +		if [ "${annotate}"  = "" ] ; then
> +			annotate="-T"
> +		elif [ "${annotate}"  = "-T" ] ; then
> +			annotate="-T -T"
> +		fi
> +		shift
> +		;;
>  	-u )
>  		dtc_sort=""
>  		shift
> @@ -327,7 +338,7 @@ cpp_flags="\
>  DTC="\
>  	${DTC}                                     \
>  	-i ${srctree}/scripts/dtc/include-prefixes \
> -	-O dts -qq -f ${dtc_sort} -o -"
> +	-O dts -qq -f ${dtc_sort} ${annotate} -o -"
>
>
>  # -----  do the diff or decompile
> --
> Frank Rowand <frank.rowand@sony.com>
>
>
