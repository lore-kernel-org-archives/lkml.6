Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeBIJUv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:20:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:27716 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbeBIJUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:20:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,482,1511856000";
   d="scan'208";a="29436314"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org, me@tobin.cc,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/8] docs: kernel-doc: Rename and split STATE_FIELD
In-Reply-To: <20180207172624.24555-3-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180207172624.24555-1-corbet@lwn.net> <20180207172624.24555-3-corbet@lwn.net>
Date: Fri, 09 Feb 2018 11:20:41 +0200
Message-ID: <87fu6aa592.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Feb 2018, Jonathan Corbet <corbet@lwn.net> wrote:
> STATE_FIELD describes a parser state that can handle any part of a
> kerneldoc comment body; rename it to STATE_BODY to reflect that.
>
> The $in_purpose variable was a hidden substate of STATE_FIELD; get rid of
> it and make a proper state (STATE_BODY_MAYBE) instead.  This will make the
> subsequent process_file() splitup easier.
>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

I really wanted to avoid leaving behind any evidence that I've ever
reviewed perl, but my sympathy for you updating the script won. But just
barely.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  scripts/kernel-doc | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 5aa4ce211fc6..ad30c52f91ef 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -328,10 +328,11 @@ my $lineprefix="";
>  use constant {
>      STATE_NORMAL        => 0, # normal code
>      STATE_NAME          => 1, # looking for function name
> -    STATE_FIELD         => 2, # scanning field start
> -    STATE_PROTO         => 3, # scanning prototype
> -    STATE_DOCBLOCK      => 4, # documentation block
> -    STATE_INLINE        => 5, # gathering documentation outside main block
> +    STATE_BODY_MAYBE    => 2, # body - or maybe more description
> +    STATE_BODY          => 3, # the body of the comment
> +    STATE_PROTO         => 4, # scanning prototype
> +    STATE_DOCBLOCK      => 5, # documentation block
> +    STATE_INLINE        => 6, # gathering documentation outside main block
>  };
>  my $state;
>  my $in_doc_sect;
> @@ -1784,7 +1785,6 @@ sub process_file($) {
>      my $identifier;
>      my $func;
>      my $descr;
> -    my $in_purpose = 0;
>      my $initial_section_counter = $section_counter;
>      my ($orig_file) = @_;
>      my $leading_space;
> @@ -1830,7 +1830,7 @@ sub process_file($) {
>  		    $identifier = $1;
>  		}
>  
> -		$state = STATE_FIELD;
> +		$state = STATE_BODY;
>  		# if there's no @param blocks need to set up default section
>  		# here
>  		$contents = "";
> @@ -1843,7 +1843,7 @@ sub process_file($) {
>  		    $descr =~ s/\s*$//;
>  		    $descr =~ s/\s+/ /g;
>  		    $declaration_purpose = $descr;
> -		    $in_purpose = 1;
> +		    $state = STATE_BODY_MAYBE;
>  		} else {
>  		    $declaration_purpose = "";
>  		}
> @@ -1875,7 +1875,7 @@ sub process_file($) {
>  		++$warnings;
>  		$state = STATE_NORMAL;
>  	    }
> -	} elsif ($state == STATE_FIELD) {	# look for head: lines, and include content
> +	} elsif ($state == STATE_BODY || $state == STATE_BODY_MAYBE) {
>  	    if (/$doc_sect/i) { # case insensitive for supported section names
>  		$newsection = $1;
>  		$newcontents = $2;
> @@ -1902,7 +1902,7 @@ sub process_file($) {
>  		}
>  
>  		$in_doc_sect = 1;
> -		$in_purpose = 0;
> +		$state = STATE_BODY;
>  		$contents = $newcontents;
>                  $new_start_line = $.;
>  		while (substr($contents, 0, 1) eq " ") {
> @@ -1941,8 +1941,8 @@ sub process_file($) {
>  		    } else {
>  			$contents .= "\n";
>  		    }
> -		    $in_purpose = 0;
> -		} elsif ($in_purpose == 1) {
> +		    $state = STATE_BODY;
> +		} elsif ($state == STATE_BODY_MAYBE) {
>  		    # Continued declaration purpose
>  		    chomp($declaration_purpose);
>  		    $declaration_purpose .= " " . $1;

-- 
Jani Nikula, Intel Open Source Technology Center
