Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbeBIJeK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:34:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:5050 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbeBIJeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:34:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,482,1511856000";
   d="scan'208";a="29438553"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org, me@tobin.cc,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 6/8] docs: kernel-doc: Move STATE_PROTO processing into its own function
In-Reply-To: <20180207172624.24555-7-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180207172624.24555-1-corbet@lwn.net> <20180207172624.24555-7-corbet@lwn.net>
Date: Fri, 09 Feb 2018 11:33:57 +0200
Message-ID: <874lmqa4my.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Feb 2018, Jonathan Corbet <corbet@lwn.net> wrote:
> Move the top-level prototype-processing code out of process_file().
>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  scripts/kernel-doc | 46 ++++++++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index a6a7bb46ea29..2deddb876156 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1965,6 +1965,32 @@ sub process_body($$) {
>  }
>  
>  
> +#
> +# STATE_PROTO: reading a function/whatever prototype.
> +#
> +sub process_proto($$) {
> +    my $file = shift;
> +
> +    if (/$doc_inline_oneline/) {
> +	$section = $1;
> +	$contents = $2;
> +	if ($contents ne "") {
> +	    $contents .= "\n";
> +	    dump_section($file, $section, $contents);
> +	    $section = $section_default;
> +	    $contents = "";
> +	}
> +    } elsif (/$doc_inline_start/) {
> +	$state = STATE_INLINE;
> +	$inline_doc_state = STATE_INLINE_NAME;
> +    } elsif ($decl_type eq 'function') {
> +	process_proto_function($_, $file);
> +    } else {
> +	process_proto_type($_, $file);
> +    }
> +}
> +
> +
>  sub process_file($) {
>      my $file;
>      my $func;
> @@ -2031,24 +2057,8 @@ sub process_file($) {
>  		    ++$warnings;
>  		}
>  	    }
> -	} elsif ($state == STATE_PROTO) {	# scanning for function '{' (end of prototype)
> -	    if (/$doc_inline_oneline/) {
> -		$section = $1;
> -		$contents = $2;
> -		if ($contents ne "") {
> -		    $contents .= "\n";
> -		    dump_section($file, $section, $contents);
> -		    $section = $section_default;
> -		    $contents = "";
> -		}
> -	    } elsif (/$doc_inline_start/) {
> -		$state = STATE_INLINE;
> -		$inline_doc_state = STATE_INLINE_NAME;
> -	    } elsif ($decl_type eq 'function') {
> -		process_proto_function($_, $file);
> -	    } else {
> -		process_proto_type($_, $file);
> -	    }
> +	} elsif ($state == STATE_PROTO) {
> +	    process_proto($file, $_);
>  	} elsif ($state == STATE_DOCBLOCK) {
>  		if (/$doc_end/)
>  		{

-- 
Jani Nikula, Intel Open Source Technology Center
