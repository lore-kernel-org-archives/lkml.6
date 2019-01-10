Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA94C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D623213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfAJUY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:24:57 -0500
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:49969 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726560AbfAJUY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:24:57 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 12AE9100E86C1;
        Thu, 10 Jan 2019 20:24:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bike43_82460749f3861
X-Filterd-Recvd-Size: 2235
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Jan 2019 20:24:55 +0000 (UTC)
Message-ID: <d3c1a0a9a29f6edfb36d97889d3498e1968500c0.camel@perches.com>
Subject: Re: [PATCH] checkpatch: allow reporting C99 style comments
From:   Joe Perches <joe@perches.com>
To:     Vadim Bendebury <vbendeb@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     apw@canonical.com
Date:   Thu, 10 Jan 2019 12:24:53 -0800
In-Reply-To: <20190110050117.55349-1-vbendeb@chromium.org>
References: <20190110050117.55349-1-vbendeb@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 21:01 -0800, Vadim Bendebury wrote:
> Presently C99 style comments are removed unconditionally before actual
> patch validity check happens. This is a problem for some third party
> projects which use checkpatch.pl but do not allow C99 style comments.
> 
> This patch adds yet another variable, named C99_COMMENT_TOLERANCE. If
> it is included in the --ignore command line or config file options
> list, C99 comments in the patch are reported as errors.
> 
> Tested by processing a patch with a C99 style comment, it passes the
> check just fine unless '--ignore C99_COMMENT_TOLERANCE' is present in
> .checkpatch.conf.

I'm not a big fan of the name but I can't think of
anything much better.

And the location of the added test isn't good.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -61,7 +61,6 @@ my $codespellfile = "/usr/share/codespell/dictionary.txt";
>  my $conststructsfile = "$D/const_structs.checkpatch";
>  my $typedefsfile = "";
>  my $color = "auto";
> -my $allow_c99_comments = 1;

Keep this here.
 
>  sub help {
>  	my ($exitcode) = @_;
> @@ -1250,6 +1249,8 @@ sub sanitise_line {
>  	my $off = 0;
>  	my $c;
>  
> +	my $allow_c99_comments = !defined $ignore_type{"C99_COMMENT_TOLERANCE"};
> +

And add this test as a new line near line 1015 like

 my $vname;
+$allow_c99_comments = !defined $ignore_type{"C99_COMMENT_TOLERANCE"};
 for my $filename (@ARGV) {


