Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614CDECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD622075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD622075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbeGRS0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:26:00 -0400
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:34281 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731186AbeGRS0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:26:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 67C13100E86C0;
        Wed, 18 Jul 2018 17:47:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: elbow19_2ea816c5a74c
X-Filterd-Recvd-Size: 3504
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Jul 2018 17:46:59 +0000 (UTC)
Message-ID: <8601ab3e058b92aca02081c1210e0b5db6d5700c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Resolve improper warning for krealloc arg
 reuse
From:   Joe Perches <joe@perches.com>
To:     Manish Narani <manish.narani@xilinx.com>, apw@canonical.com,
        linux-kernel@vger.kernel.org
Cc:     anirudh@xilinx.com, sgoud@xilinx.com, svemula@xilinx.com
Date:   Wed, 18 Jul 2018 10:46:58 -0700
In-Reply-To: <1531922148-7423-1-git-send-email-manish.narani@xilinx.com>
References: <1531922148-7423-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 19:25 +0530, Manish Narani wrote:
> Correct the check for reuse of krealloc. It gives false warning when a
> structure member variable name and krealloc argument name is same.
> 
> For Example:
> {
> 	...
> 	abc.def_var = krealloc(def_var, sizeof(*def_var),
> 				    GFP_KERNEL);
> 	...
> }
> 
> $ ./scripts/checkpatch.pl -f file.c
> 
> WARNING: Reusing the krealloc arg is almost always a bug
> +	abc.def_var = krealloc(def_var, sizeof(*def_var),
> 
> This patch resolves the above false warning.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 447857f..db9b666 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6119,7 +6119,7 @@ sub process {
>  
>  # check for krealloc arg reuse
>  		if ($^V && $^V ge 5.10.0 &&
> -		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*krealloc\s*\(\s*\1\s*,/) {
> +		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*krealloc\s*\(\s*\1\s*,/ && $line !~ m/[\.|\-\>].*\s*\=\s*.*/) {
>  			WARN("KREALLOC_ARG_REUSE",
>  			     "Reusing the krealloc arg is almost always a bug\n" . $herecurr);
>  		}

This works, though I'm not completely sure why.

Andy or anyone else:  Does your perl-foo understand why?

$ cat test_krealloc.c
static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
	unsigned int *conf)
{
	indio_dev->channels = krealloc(channels, sizeof(*channels) *
					num_channels, GFP_KERNEL);
	indio_dev->channels = krealloc(indio_dev->channels, sizeof(*channels) *
					num_channels, GFP_KERNEL);
}

For the patch below, the old case matches the first
$Lval above as "channels" skipping the "indio_dev->"
bit and as not "indio_dev->channels"

The modified patch below matches the first $Lval as the
expected "indio_dev->channels"
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ed4fa986e8da..59eaaede757a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6149,7 +6149,8 @@ sub process {
 
 # check for krealloc arg reuse
 		if ($perl_version_ok &&
-		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*krealloc\s*\(\s*\1\s*,/) {
+		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*krealloc\s*\(\s*($Lval)\s*,/ &&
+		    $1 eq $3) {
 			WARN("KREALLOC_ARG_REUSE",
 			     "Reusing the krealloc arg is almost always a bug\n" . $herecurr);
 		}

