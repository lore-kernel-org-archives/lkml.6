Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeEGUnT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:43:19 -0400
Received: from smtprelay0189.hostedemail.com ([216.40.44.189]:54280 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753214AbeEGUnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:43:16 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2689:2693:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3873:3874:4321:4605:5007:7903:8957:10004:10400:10848:11026:11232:11473:11658:11914:12043:12295:12296:12555:12740:12760:12895:12986:13439:14093:14097:14181:14659:14721:21080:21451:21611:21627:30012:30054:30091,0,RBL:23.242.70.174:@perches.com:.lbl8.mailshell.net-62.8.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: glove24_7370707643d2a
X-Filterd-Recvd-Size: 3589
Message-ID: <51c4c2c53cf166b704fdf7e8f08b3f09dbece1ab.camel@perches.com>
Subject: Re: [BUG] scripts/checkpatch.pl: false positive missing parentheses
From: Joe Perches <joe@perches.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Date: Mon, 07 May 2018 13:43:11 -0700
In-Reply-To: <20180507183105.13499-1-xypron.glpk@gmx.de>
References: <20180507183105.13499-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-07 at 20:31 +0200, Heinrich Schuchardt wrote:
> This patch creates a false positive:
> ERROR: Macros with complex values should be enclosed in parentheses
> 
> Here we define a constant that can be used to initialize a structure.
> Adding parentheses would lead to a compile time error:
> error: braced-group within expression allowed only inside a function

>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  foo.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 foo.h
> 
> diff --git a/foo.h b/foo.h
> new file mode 100644
> index 000000000000..e2cba533f065
> --- /dev/null
> +++ b/foo.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: BSD-2 */
> +#define EFI_ST_DISK_IMG { 0x00003368, { \
> +	{0x00000d40, "\x6f\x63\x00\x2f\x2a\x00\x20\x2a"}, /* oc./*. * */ \
> +	{0x00000d48, "\x00\x20\x2a\x2f\x0a\x00\x09\x7b"}, /* . */...{ */ \

I think this line would not do what you expect as the "/* . */" is
a complete comment and the "...{ */" is parsed as code.

> +	{0x00000d50, "\x30\x78\x25\x30\x38\x7a\x78\x2c"}, /* 0x%08zx, */ \
> +	{0x00000d58, "\x20\x22\x00\x5c\x78\x25\x30\x32"}, /*  ".\x%02 */ \
> +	{0x00000d60, "\x78\x00\x20\x2a\x2f\x20\x5c\x00"}, /* x. */ \. */ \

here too...

> +	{0, NULL} } }

checkpatch will always be a stupid style checker.

Some false positives are expected.

I think this is one of them, but perhaps the bit of
checkpatch logic in the COMPLEX_MACRO test could be
improved by something like the below.

Andy?  What do you think?

---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 24618dffc5cb..9d3bdab03225 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -785,6 +785,8 @@ our $Typecast	= qr{\s*(\(\s*$NonptrType\s*\)){0,1}\s*};
 # Any use must be runtime checked with $^V
 
 our $balanced_parens = qr/(\((?:[^\(\)]++|(?-1))*\))/;
+our $balanced_braces = qr/(\{(?:[^\{\}]++|(?-1))*\})/;
+our $balanced_brackets = qr/(\[(?:[^\[\]]++|(?-1))*\])/;
 our $LvalOrFunc	= qr{((?:[\&\*]\s*)?$Lval)\s*($balanced_parens{0,1})\s*};
 our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
 
@@ -4953,6 +4955,16 @@ sub process {
 			$dstat =~ s/^\s*//s;
 			$dstat =~ s/\s*$//s;
 
+			# Flatten any parentheses and braces using the
+			# fancy balanced_<foo> tests (perl v5.10+ only)
+			if ($^V && $^V ge 5.10.0) {
+				while ($dstat =~ s/$balanced_parens/1/ ||
+				       $dstat =~ s/$balanced_braces/1/ ||
+				       $dstat =~ s/$balanced_brackets/1/)
+				{
+				}
+			}
+
 			# Flatten any parentheses and braces
 			while ($dstat =~ s/\([^\(\)]*\)/1/ ||
 			       $dstat =~ s/\{[^\{\}]*\}/1/ ||
