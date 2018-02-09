Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeBIJ1c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:27:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:28183 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751034AbeBIJ12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:27:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,482,1511856000";
   d="scan'208";a="29437356"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org, me@tobin.cc,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/8] docs: kernel-doc: Move STATE_NAME processing into its own function
In-Reply-To: <20180207172624.24555-5-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180207172624.24555-1-corbet@lwn.net> <20180207172624.24555-5-corbet@lwn.net>
Date: Fri, 09 Feb 2018 11:27:20 +0200
Message-ID: <87a7wia4xz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Feb 2018, Jonathan Corbet <corbet@lwn.net> wrote:
> Move this code out of process_file() in the name of readability and
> maintainability.
>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

I admit I don't fully understand the semantics of perl parameter
passing, but looks okay.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  scripts/kernel-doc | 137 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 72 insertions(+), 65 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 65150b7c8472..a27c7016f72d 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1793,13 +1793,81 @@ sub process_normal() {
>      }
>  }
>  
> +#
> +# STATE_NAME: Looking for the "name - description" line
> +#
> +sub process_name($$) {
> +    my $file = shift;
> +    my $identifier;
> +    my $descr;
> +
> +    if (/$doc_block/o) {
> +	$state = STATE_DOCBLOCK;
> +	$contents = "";
> +	$new_start_line = $. + 1;
> +
> +	if ( $1 eq "" ) {
> +	    $section = $section_intro;
> +	} else {
> +	    $section = $1;
> +	}
> +    }
> +    elsif (/$doc_decl/o) {
> +	$identifier = $1;
> +	if (/\s*([\w\s]+?)\s*-/) {
> +	    $identifier = $1;
> +	}
>  
> +	$state = STATE_BODY;
> +	# if there's no @param blocks need to set up default section
> +	# here
> +	$contents = "";
> +	$section = $section_default;
> +	$new_start_line = $. + 1;
> +	if (/-(.*)/) {
> +	    # strip leading/trailing/multiple spaces
> +	    $descr= $1;
> +	    $descr =~ s/^\s*//;
> +	    $descr =~ s/\s*$//;
> +	    $descr =~ s/\s+/ /g;
> +	    $declaration_purpose = $descr;
> +	    $state = STATE_BODY_MAYBE;
> +	} else {
> +	    $declaration_purpose = "";
> +	}
> +
> +	if (($declaration_purpose eq "") && $verbose) {
> +	    print STDERR "${file}:$.: warning: missing initial short description on line:\n";
> +	    print STDERR $_;
> +	    ++$warnings;
> +	}
> +
> +	if ($identifier =~ m/^struct/) {
> +	    $decl_type = 'struct';
> +	} elsif ($identifier =~ m/^union/) {
> +	    $decl_type = 'union';
> +	} elsif ($identifier =~ m/^enum/) {
> +	    $decl_type = 'enum';
> +	} elsif ($identifier =~ m/^typedef/) {
> +	    $decl_type = 'typedef';
> +	} else {
> +	    $decl_type = 'function';
> +	}
> +
> +	if ($verbose) {
> +	    print STDERR "${file}:$.: info: Scanning doc for $identifier\n";
> +	}
> +    } else {
> +	print STDERR "${file}:$.: warning: Cannot understand $_ on line $.",
> +	    " - I thought it was a doc line\n";
> +	++$warnings;
> +	$state = STATE_NORMAL;
> +    }
> +}
>  
>  sub process_file($) {
>      my $file;
> -    my $identifier;
>      my $func;
> -    my $descr;
>      my $initial_section_counter = $section_counter;
>      my ($orig_file) = @_;
>      my $leading_space;
> @@ -1823,69 +1891,8 @@ sub process_file($) {
>          while ($_ =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {};
>  	if ($state == STATE_NORMAL) {
>  	    process_normal();
> -	} elsif ($state == STATE_NAME) {# this line is the function name (always)
> -	    if (/$doc_block/o) {
> -		$state = STATE_DOCBLOCK;
> -		$contents = "";
> -                $new_start_line = $. + 1;
> -
> -		if ( $1 eq "" ) {
> -			$section = $section_intro;
> -		} else {
> -			$section = $1;
> -		}
> -	    }
> -	    elsif (/$doc_decl/o) {
> -		$identifier = $1;
> -		if (/\s*([\w\s]+?)\s*-/) {
> -		    $identifier = $1;
> -		}
> -
> -		$state = STATE_BODY;
> -		# if there's no @param blocks need to set up default section
> -		# here
> -		$contents = "";
> -		$section = $section_default;
> -		$new_start_line = $. + 1;
> -		if (/-(.*)/) {
> -		    # strip leading/trailing/multiple spaces
> -		    $descr= $1;
> -		    $descr =~ s/^\s*//;
> -		    $descr =~ s/\s*$//;
> -		    $descr =~ s/\s+/ /g;
> -		    $declaration_purpose = $descr;
> -		    $state = STATE_BODY_MAYBE;
> -		} else {
> -		    $declaration_purpose = "";
> -		}
> -
> -		if (($declaration_purpose eq "") && $verbose) {
> -			print STDERR "${file}:$.: warning: missing initial short description on line:\n";
> -			print STDERR $_;
> -			++$warnings;
> -		}
> -
> -		if ($identifier =~ m/^struct/) {
> -		    $decl_type = 'struct';
> -		} elsif ($identifier =~ m/^union/) {
> -		    $decl_type = 'union';
> -		} elsif ($identifier =~ m/^enum/) {
> -		    $decl_type = 'enum';
> -		} elsif ($identifier =~ m/^typedef/) {
> -		    $decl_type = 'typedef';
> -		} else {
> -		    $decl_type = 'function';
> -		}
> -
> -		if ($verbose) {
> -		    print STDERR "${file}:$.: info: Scanning doc for $identifier\n";
> -		}
> -	    } else {
> -		print STDERR "${file}:$.: warning: Cannot understand $_ on line $.",
> -		" - I thought it was a doc line\n";
> -		++$warnings;
> -		$state = STATE_NORMAL;
> -	    }
> +	} elsif ($state == STATE_NAME) {
> +	    process_name($file, $_);
>  	} elsif ($state == STATE_BODY || $state == STATE_BODY_MAYBE) {
>  	    if (/$doc_sect/i) { # case insensitive for supported section names
>  		$newsection = $1;

-- 
Jani Nikula, Intel Open Source Technology Center
