Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBIJX1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:23:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:60052 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750942AbeBIJXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:23:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,482,1511856000";
   d="scan'208";a="29436691"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org, me@tobin.cc,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 3/8] docs: kernel-doc: Move STATE_NORMAL processing into its own function
In-Reply-To: <20180207172624.24555-4-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180207172624.24555-1-corbet@lwn.net> <20180207172624.24555-4-corbet@lwn.net>
Date: Fri, 09 Feb 2018 11:23:17 +0200
Message-ID: <87d11ea54q.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Feb 2018, Jonathan Corbet <corbet@lwn.net> wrote:
> Begin the process of splitting up the nearly 500-line process_file()
> function by moving STATE_NORMAL processing to a separate function.
>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/kernel-doc | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index ad30c52f91ef..65150b7c8472 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1780,6 +1780,21 @@ sub process_export_file($) {
>      close(IN);
>  }
>  
> +#
> +# Parsers for the various processing states.
> +#
> +# STATE_NORMAL: looking for the /** to begin everything.
> +#
> +sub process_normal() {
> +    if (/$doc_start/o) {
> +	$state = STATE_NAME;	# next line is always the function name
> +	$in_doc_sect = 0;
> +	$declaration_start_line = $. + 1;
> +    }
> +}
> +
> +
> +

Superfluous whitespace, but fixed in the next patch so I'll look the
other way.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

>  sub process_file($) {
>      my $file;
>      my $identifier;
> @@ -1807,11 +1822,7 @@ sub process_file($) {
>  	# Replace tabs by spaces
>          while ($_ =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {};
>  	if ($state == STATE_NORMAL) {
> -	    if (/$doc_start/o) {
> -		$state = STATE_NAME;	# next line is always the function name
> -		$in_doc_sect = 0;
> -		$declaration_start_line = $. + 1;
> -	    }
> +	    process_normal();
>  	} elsif ($state == STATE_NAME) {# this line is the function name (always)
>  	    if (/$doc_block/o) {
>  		$state = STATE_DOCBLOCK;

-- 
Jani Nikula, Intel Open Source Technology Center
