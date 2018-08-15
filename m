Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AF3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7AD21536
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7AD21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeHPABI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:01:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbeHPABH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:01:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90601401EF05;
        Wed, 15 Aug 2018 21:07:16 +0000 (UTC)
Received: from redhat.com (dhcp-17-127.bos.redhat.com [10.18.17.127])
        by smtp.corp.redhat.com (Postfix) with SMTP id 48ED92156712;
        Wed, 15 Aug 2018 21:07:16 +0000 (UTC)
Date:   Wed, 15 Aug 2018 17:07:16 -0400
From:   Don Zickus <dzickus@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] get_maintainer: Allow option --mpath <directory> to read
 all files in <directory>
Message-ID: <20180815210716.26wfdxtt3c5uup3q@redhat.com>
References: <991b2f20112d53863cd79e61d908f1d26d3e1971.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <991b2f20112d53863cd79e61d908f1d26d3e1971.camel@perches.com>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 15 Aug 2018 21:07:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 15 Aug 2018 21:07:16 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dzickus@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 06:12:44PM -0700, Joe Perches wrote:
> There is an external use case for multiple private MAINTAINER
> style files in a separate directory.  Allow it.
> 
> --mpath has a default of "./MAINTAINERS".
> 
> The value entered can be either a file or a directory.
> 
> The behaviors are now:
> 
> --mpath <file>          Read only the specific file as <MAINTAINER_TYPE> file
> --mpath <directory>     Read all files in <directory> as <MAINTAINER_TYPE> files
> --mpath <directory> --find-maintainer-files
>                         Recurse through <directory> and read all files named MAINTAINERS

Tested-by: Don Zickus <dzickus@redhat.com>
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  scripts/get_maintainer.pl | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 0ebdefe74d5b..c1c088ef1420 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -396,7 +396,12 @@ sub read_all_maintainer_files {
>  
>      if (-d $path) {
>  	$path .= '/' if ($path !~ m@/$@);
> -	if ($path eq "${lk_path}MAINTAINERS/") {
> +	if ($find_maintainer_files) {
> +	    find( { wanted => \&find_is_maintainer_file,
> +		    preprocess => \&find_ignore_git,
> +		    no_chdir => 1,
> +		}, "$path");
> +	} else {
>  	    opendir(DIR, "$path") or die $!;
>  	    my @files = readdir(DIR);
>  	    closedir(DIR);
> @@ -404,12 +409,6 @@ sub read_all_maintainer_files {
>  		push(@mfiles, "$path$file") if ($file !~ /^\./);
>  	    }
>  	}
> -	if ($find_maintainer_files) {
> -	    find( { wanted => \&find_is_maintainer_file,
> -		    preprocess => \&find_ignore_git,
> -		    no_chdir => 1,
> -		}, "$path");
> -	}
>      } elsif (-f "$path") {
>  	push(@mfiles, "$path");
>      } else {
> 
