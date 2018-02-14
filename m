Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162722AbeBNTKk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:10:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:10112 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162683AbeBNTKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:10:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,513,1511856000";
   d="scan'208";a="30779932"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org, me@tobin.cc,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 8/8] docs: kernel-doc: Don't mangle literal code blocks in comments
In-Reply-To: <20180214184009.12657-9-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180214184009.12657-1-corbet@lwn.net> <20180214184009.12657-9-corbet@lwn.net>
Date: Wed, 14 Feb 2018 21:10:31 +0200
Message-ID: <87606zjsk8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018, Jonathan Corbet <corbet@lwn.net> wrote:
> It can be useful to put code snippets into kerneldoc comments; that can be
> done with the "::" operator at the end of a line like this::
>
>    if (desperate)
>        run_in_circles();
>
> The ".. code-block::" directive can also be used to this end.  kernel-doc
> currently fails to understand these literal blocks and applies its normal
> markup to them, which is then treated as literal by sphinx.  The result is
> unsightly markup instead of a useful code snippet.
>
> Apply a hack to the output code to recognize literal blocks and avoid
> performing any special markup on them.  It's ugly, but that means it fits
> in well with the rest of the script.

With emphasis on part (d) of the reviewer's statement of oversight,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/kernel-doc | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 64 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index fb8fbdb25036..cbe864e72a2f 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -748,14 +748,73 @@ sub output_blockhead_rst(%) {
>      }
>  }
>  
> -sub output_highlight_rst {
> -    my $contents = join "\n",@_;
> -    my $line;
> -
> +#
> +# Apply the RST highlights to a sub-block of text.
> +#   
> +sub highlight_block($) {
> +    # The dohighlight kludge requires the text be called $contents
> +    my $contents = shift;
>      eval $dohighlight;
>      die $@ if $@;
> +    return $contents;
> +}
>  
> -    foreach $line (split "\n", $contents) {
> +#
> +# Regexes used only here.
> +#
> +my $sphinx_literal = '^[^.].*::$';
> +my $sphinx_cblock = '^\.\.\ +code-block::';
> +
> +sub output_highlight_rst {
> +    my $input = join "\n",@_;
> +    my $output = "";
> +    my $line;
> +    my $in_literal = 0;
> +    my $litprefix;
> +    my $block = "";
> +
> +    foreach $line (split "\n",$input) {
> +	#
> +	# If we're in a literal block, see if we should drop out
> +	# of it.  Otherwise pass the line straight through unmunged.
> +	#
> +	if ($in_literal) {
> +	    if (! ($line =~ /^\s*$/)) {
> +		#
> +		# If this is the first non-blank line in a literal
> +		# block we need to figure out what the proper indent is.
> +		#
> +		if ($litprefix eq "") {
> +		    $line =~ /^(\s*)/;
> +		    $litprefix = '^' . $1;
> +		    $output .= $line . "\n";
> +		} elsif (! ($line =~ /$litprefix/)) {
> +		    $in_literal = 0;
> +		} else {
> +		    $output .= $line . "\n";
> +		}
> +	    } else {
> +		$output .= $line . "\n";
> +	    }
> +	}
> +	#
> +	# Not in a literal block (or just dropped out)
> +	#
> +	if (! $in_literal) {
> +	    $block .= $line . "\n";
> +	    if (($line =~ /$sphinx_literal/) || ($line =~ /$sphinx_cblock/)) {
> +		$in_literal = 1;
> +		$litprefix = "";
> +		$output .= highlight_block($block);
> +		$block = ""
> +	    }
> +	}
> +    }
> +
> +    if ($block) {
> +	$output .= highlight_block($block);
> +    }
> +    foreach $line (split "\n", $output) {
>  	print $lineprefix . $line . "\n";
>      }
>  }

-- 
Jani Nikula, Intel Open Source Technology Center
